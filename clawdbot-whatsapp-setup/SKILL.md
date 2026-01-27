---
name: clawdbot-whatsapp-setup
description: |
  Clawdbot WhatsApp 版本自动化安装配置工具。一键完成 WSL2 Gateway + Windows Node Client 的完整安装、配置、扫码登录和测试流程。
  当用户需要"安装 Clawdbot WhatsApp 版本"、"配置 Clawdbot 连接 WhatsApp"、"WhatsApp 扫码登录 Clawdbot"时触发。
  核心功能：(1) 收集配置信息 (2) 安装 WSL2 Gateway (3) WhatsApp 扫码登录 (4) 安装 Windows Node Client (5) 自动配对 (6) 测试验证
---

# Clawdbot WhatsApp 自动化安装工具

## 🎯 概述

自动化完成 Clawdbot WhatsApp 版本的完整安装流程，包括 WSL2 Gateway 和 Windows Node Client 的安装、配置、WhatsApp 扫码登录、配对和测试。

**优势**：
- ✅ 不需要创建 bot，直接用你的 WhatsApp 账号
- ✅ 扫码登录，像 WhatsApp Web 一样简单
- ✅ 可以给自己发消息（自聊模式）

## ⚡ 执行规则

**当此 Skill 被调用时，你必须：**
1. **立即执行**，不要只说"我要做什么"
2. **使用 AskUserQuestion 工具**收集用户配置信息
3. **使用 TaskCreate 和 TaskUpdate 工具**追踪安装进度
4. **使用 Bash 工具**执行安装命令
5. **使用 Write 工具**创建配置文件
6. **指导用户扫码登录** WhatsApp
7. **显示进度和结果**给用户

## 📋 安装流程

### 步骤 1: 收集配置信息

使用 AskUserQuestion 工具收集以下信息：

**必需信息**：
- Claude API Key（或其他 AI API Key）
- 手机号码（E.164 格式，如 +8613800138000）
- Gateway 认证 Token（用户自定义密码）

**可选信息**：
- WSL2 发行版名称（默认：Ubuntu）
- Gateway 端口（默认：18789）
- 是否启用自聊模式（默认：是）

### 步骤 2: 创建安装任务

使用 TaskCreate 创建以下任务：
1. 安装 WSL2 Gateway
2. 配置 WhatsApp 通道
3. WhatsApp 扫码登录
4. 安装 Windows Node Client
5. 配对 Node Client
6. 运行测试验证

### 步骤 3: 安装 WSL2 Gateway

**3.1 检查 WSL2 环境**
```bash
wsl -d {发行版名称} -e bash -c 'which node'
```

**3.2 安装 Node.js（如果未安装）**
```bash
wsl -d {发行版名称} -e bash -c '
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - &&
sudo apt-get install -y nodejs
'
```

**3.3 安装 Clawdbot**
```bash
wsl -d {发行版名称} -e bash -c 'npm install -g clawdbot'
```

**3.4 创建配置文件**

使用 Bash 工具在 WSL2 中创建 `~/.clawdbot/clawdbot.json`：

**自聊模式配置**（推荐）：
```json
{
  "providers": {
    "anthropic": {
      "apiKey": "{用户的API Key}"
    }
  },
  "model": "anthropic/claude-opus-4-5",
  "gateway": {
    "bind": "lan",
    "port": {端口},
    "auth": {
      "mode": "token",
      "token": "{用户的Gateway Token}"
    }
  },
  "channels": {
    "whatsapp": {
      "enabled": true,
      "selfChatMode": true,
      "dmPolicy": "allowlist",
      "allowFrom": ["{用户的手机号}"]
    }
  }
}
```

**备用号码配置**：
```json
{
  "channels": {
    "whatsapp": {
      "enabled": true,
      "dmPolicy": "allowlist",
      "allowFrom": ["{用户的手机号}"]
    }
  }
}
```

**3.5 启动 Gateway**
```bash
wsl -d {发行版名称} -e bash -c 'clawdbot gateway --daemon'
```

### 步骤 4: WhatsApp 扫码登录

**4.1 启动扫码登录**
```bash
wsl -d {发行版名称} -e bash -c 'clawdbot channels login'
```

**4.2 指导用户扫码**

告知用户：
1. 打开手机上的 WhatsApp
2. 点击右上角 **三个点** → **已连接的设备**（或 Linked Devices）
3. 点击 **连接设备**（或 Link a Device）
4. 扫描终端中显示的二维码

**4.3 验证连接状态**
```bash
wsl -d {发行版名称} -e bash -c 'clawdbot channels status'
```

应该显示：`whatsapp: running, connected`

### 步骤 5: 安装 Windows Node Client

**5.1 检查 Clawdbot 是否已安装**
```powershell
pwsh -Command 'clawdbot --version'
```

**5.2 安装 Clawdbot（如果未安装）**
```powershell
pwsh -Command 'npm install -g clawdbot'
```

**5.3 获取 WSL2 IP 地址**
```bash
wsl -d {发行版名称} -e bash -c 'hostname -I'
```

**5.4 创建 Node 配置文件**

使用 PowerShell 创建 `C:\Users\{用户名}\.clawdbot\node.json`：

```json
{
  "gateway": {
    "host": "{WSL2 IP地址}",
    "port": {端口},
    "token": "{用户的Gateway Token}"
  }
}
```

**5.5 安装为 Windows 服务**
```powershell
pwsh -Command 'clawdbot node install'
```

**5.6 验证 Node 状态**
```powershell
pwsh -Command 'clawdbot node status'
```

### 步骤 6: 配对 Node Client

**6.1 启动 Node Client**
```powershell
pwsh -Command '$env:CLAWDBOT_GATEWAY_TOKEN = "{用户的Gateway Token}"; clawdbot node run'
```

**6.2 检查待配对设备**

在 WhatsApp 中给自己发消息：
```
检查待配对的设备
```

**6.3 自动批准配对**

Clawdbot 会自动批准配对请求。

### 步骤 7: 运行测试验证

**7.1 测试 WhatsApp 连接**

在手机 WhatsApp 中：
1. 点击右下角 **新建聊天**
2. 找到 **给自己发消息**（或 Message yourself）
3. 发送：`你好`

Clawdbot 应该会回复！

**7.2 测试设备状态**

发送：
```
查看我的设备状态
```

**7.3 测试远程命令**

发送：
```
在我的电脑上运行：hostname
```

## 💡 使用示例

### 示例 1: 完整安装流程

用户："安装 Clawdbot WhatsApp 版本"

**你应该立即执行：**

1. **收集配置信息**
```
使用 AskUserQuestion 询问：
- Claude API Key
- 手机号码（E.164 格式）
- Gateway Token
- 是否启用自聊模式
```

2. **创建任务追踪**
```
TaskCreate: 安装 WSL2 Gateway
TaskCreate: 配置 WhatsApp 通道
TaskCreate: WhatsApp 扫码登录
TaskCreate: 安装 Windows Node Client
TaskCreate: 配对 Node Client
TaskCreate: 运行测试验证
```

3. **执行安装**
```
按照步骤 3-7 依次执行
每完成一个任务，使用 TaskUpdate 更新状态
```

4. **输出结果**
```
✅ Clawdbot WhatsApp 版本安装完成！

安装摘要：
- WSL2 Gateway: 运行中
- WhatsApp: 已连接
- Windows Node Client: 运行中
- 测试结果: 通过

下一步：
1. 在 WhatsApp 中给自己发消息测试
2. 尝试远程控制你的电脑
```

### 示例 2: 重新扫码登录

用户："WhatsApp 连接断开了"

**你应该立即执行：**
1. 运行：`clawdbot channels login`
2. 指导用户重新扫码
3. 验证连接状态

### 示例 3: 故障排查

用户："Clawdbot 不回复 WhatsApp 消息"

**你应该立即执行：**
1. 检查 Gateway 状态
2. 检查 WhatsApp 连接状态
3. 检查手机号是否在白名单中
4. 查看日志：`clawdbot logs --follow`

## ⚠️ 常见问题

### 问题 1: 扫码后显示 "Not linked"

**解决方案**：
1. 重新运行：`clawdbot channels login`
2. 确保手机和电脑在同一网络
3. 检查手机 WhatsApp 版本是否最新

### 问题 2: Clawdbot 不回复消息

**解决方案**：
1. 检查 Gateway 是否运行：`clawdbot status`
2. 检查 WhatsApp 连接：`clawdbot channels status`
3. 确认你的手机号在 allowFrom 列表中
4. 查看日志：`clawdbot logs --follow`

### 问题 3: 二维码显示不出来

**解决方案**：
1. 确保终端支持显示二维码
2. 或者使用：`clawdbot channels login --url` 获取登录链接
3. 在浏览器中打开链接，会显示二维码

### 问题 4: 连接经常断开

**解决方案**：
1. 确保手机 WhatsApp 保持登录
2. 不要在手机上登出 "Linked Devices"
3. 重启 Gateway：`clawdbot gateway restart`

## 📚 参考资源

- `scripts/install_gateway_whatsapp.sh` - WSL2 Gateway 安装脚本（WhatsApp 版）
- `scripts/install_node.ps1` - Windows Node Client 安装脚本（通用）
- `scripts/test_whatsapp.sh` - WhatsApp 连接测试脚本
- `references/WHATSAPP_GUIDE.md` - WhatsApp 详细配置指南
- `references/TROUBLESHOOTING.md` - 故障排查指南

## 🔧 高级配置

### 自定义 WhatsApp 配置

编辑 `~/.clawdbot/clawdbot.json`：

```json
{
  "channels": {
    "whatsapp": {
      "enabled": true,
      "selfChatMode": true,
      "dmPolicy": "allowlist",
      "allowFrom": ["+8613800138000"],
      "groups": {
        "*": {
          "requireMention": true
        }
      }
    }
  }
}
```

### 多号码白名单

```json
{
  "channels": {
    "whatsapp": {
      "enabled": true,
      "dmPolicy": "allowlist",
      "allowFrom": [
        "+8613800138000",
        "+8613900139000"
      ]
    }
  }
}
```

## 🆚 WhatsApp vs Telegram 对比

| 特性 | WhatsApp | Telegram |
|------|----------|----------|
| 设置难度 | ⭐⭐ 扫码即可 | ⭐⭐⭐ 需要创建 bot |
| 使用体验 | ⭐⭐⭐ 自聊模式 | ⭐⭐ 需要找 bot |
| 隐私性 | ⭐⭐⭐ 端到端加密 | ⭐⭐ 云端存储 |
| 稳定性 | ⭐⭐ 需要保持连接 | ⭐⭐⭐ 更稳定 |
| 推荐场景 | 个人使用 | 团队协作 |

---

**版本**: v1.0.0
**最后更新**: 2026-01-27
**状态**: ✅ 已测试可用
