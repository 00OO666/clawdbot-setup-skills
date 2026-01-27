---
name: clawdbot-telegram-setup
description: |
  Clawdbot Telegram 版本自动化安装配置工具。一键完成 WSL2 Gateway + Windows Node Client 的完整安装、配置、配对和测试流程。
  当用户需要"安装 Clawdbot Telegram 版本"、"配置 Clawdbot 连接 Telegram"、"一键安装 Clawdbot"时触发。
  核心功能：(1) 收集配置信息 (2) 安装 WSL2 Gateway (3) 安装 Windows Node Client (4) 自动配对 (5) 测试验证 (6) 进度追踪
---

# Clawdbot Telegram 自动化安装工具

## 🎯 概述

自动化完成 Clawdbot Telegram 版本的完整安装流程，包括 WSL2 Gateway 和 Windows Node Client 的安装、配置、配对和测试。

## ⚡ 执行规则

**当此 Skill 被调用时，你必须：**
1. **立即执行**，不要只说"我要做什么"
2. **使用 AskUserQuestion 工具**收集用户配置信息
3. **使用 TaskCreate 和 TaskUpdate 工具**追踪安装进度
4. **使用 Bash 工具**执行安装命令
5. **使用 Write 工具**创建配置文件
6. **显示进度和结果**给用户

## 📋 安装流程

### 步骤 1: 收集配置信息

使用 AskUserQuestion 工具收集以下信息：

**必需信息**：
- Claude API Key（或其他 AI API Key）
- Telegram Bot Token（从 @BotFather 获取）
- Telegram Chat ID（从 @userinfobot 获取）
- Gateway 认证 Token（用户自定义密码）

**可选信息**：
- WSL2 发行版名称（默认：Ubuntu）
- Gateway 端口（默认：18789）

### 步骤 2: 创建安装任务

使用 TaskCreate 创建以下任务：
1. 安装 WSL2 Gateway
2. 配置 Telegram Bot
3. 安装 Windows Node Client
4. 配对 Telegram Bot
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
    "telegram": {
      "enabled": true,
      "botToken": "{用户的Bot Token}",
      "dmPolicy": "pairing"
    }
  }
}
```

**3.5 启动 Gateway**
```bash
wsl -d {发行版名称} -e bash -c 'clawdbot gateway --daemon'
```

**3.6 验证 Gateway 状态**
```bash
wsl -d {发行版名称} -e bash -c 'clawdbot status'
```

### 步骤 4: 配对 Telegram Bot

**4.1 指导用户配对**

告知用户：
1. 在 Telegram 中找到你的 bot
2. 点击 Start
3. 发送任意消息（如 "你好"）

**4.2 检查配对请求**
```bash
wsl -d {发行版名称} -e bash -c 'clawdbot pairing list telegram'
```

**4.3 自动批准配对**
```bash
wsl -d {发行版名称} -e bash -c 'clawdbot pairing approve telegram {配对码}'
```

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

在 Telegram 中向 bot 发送：
```
检查待配对的设备
```

**6.3 自动批准配对**

Bot 会自动批准配对请求。

### 步骤 7: 运行测试验证

**7.1 测试 Telegram 连接**

在 Telegram 中发送：
```
你好
```

Bot 应该会回复。

**7.2 测试设备状态**

在 Telegram 中发送：
```
查看我的设备状态
```

**7.3 测试远程命令**

在 Telegram 中发送：
```
在我的电脑上运行：hostname
```

## 💡 使用示例

### 示例 1: 完整安装流程

用户："安装 Clawdbot Telegram 版本"

**你应该立即执行：**

1. **收集配置信息**
```
使用 AskUserQuestion 询问：
- Claude API Key
- Telegram Bot Token
- Telegram Chat ID
- Gateway Token
```

2. **创建任务追踪**
```
TaskCreate: 安装 WSL2 Gateway
TaskCreate: 配置 Telegram Bot
TaskCreate: 安装 Windows Node Client
TaskCreate: 配对 Telegram Bot
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
✅ Clawdbot Telegram 版本安装完成！

安装摘要：
- WSL2 Gateway: 运行中
- Telegram Bot: 已配对
- Windows Node Client: 运行中
- 测试结果: 通过

下一步：
1. 在 Telegram 中向 bot 发送消息测试
2. 尝试远程控制你的电脑
```

### 示例 2: 仅安装 Gateway

用户："只安装 WSL2 Gateway"

**你应该立即执行：**
1. 收集 API Key 和 Gateway Token
2. 执行步骤 3（安装 WSL2 Gateway）
3. 输出结果

### 示例 3: 故障排查

用户："Clawdbot 安装失败了"

**你应该立即执行：**
1. 检查 Gateway 状态
2. 检查 Node Client 状态
3. 检查配对状态
4. 提供故障排查建议

## ⚠️ 常见问题

### 问题 1: Telegram bot 不回复

**解决方案**：
1. 检查 Gateway 是否运行：`clawdbot status`
2. 检查配对状态：`clawdbot pairing list telegram`
3. 重启 Gateway：`clawdbot gateway restart`

### 问题 2: Node 连接失败

**解决方案**：
1. 确认 WSL2 IP 地址正确
2. 确认 Gateway Token 一致
3. 检查防火墙是否阻止端口

### 问题 3: PowerShell 语法错误

**解决方案**：
- PowerShell 用 `;` 连接命令，不是 `&&`
- 正确：`$env:VAR = "value"; command`
- 错误：`$env:VAR = "value" && command`

## 📚 参考资源

- `scripts/install_gateway.sh` - WSL2 Gateway 安装脚本
- `scripts/install_node.ps1` - Windows Node Client 安装脚本
- `scripts/test_connection.sh` - 连接测试脚本
- `references/TROUBLESHOOTING.md` - 详细故障排查指南
- `references/CONFIGURATION.md` - 高级配置选项

## 🔧 高级配置

### 自定义 Gateway 配置

编辑 `~/.clawdbot/clawdbot.json`：

```json
{
  "gateway": {
    "bind": "lan",
    "port": 18789,
    "auth": {
      "mode": "token",
      "token": "your-token"
    }
  },
  "channels": {
    "telegram": {
      "enabled": true,
      "botToken": "your-bot-token",
      "dmPolicy": "pairing",
      "groups": {
        "*": {
          "requireMention": true
        }
      }
    }
  }
}
```

### 自定义 Node 配置

编辑 `C:\Users\{用户名}\.clawdbot\node.json`：

```json
{
  "gateway": {
    "host": "192.168.x.x",
    "port": 18789,
    "token": "your-token"
  },
  "displayName": "My Computer"
}
```

---

**版本**: v1.0.0
**最后更新**: 2026-01-27
**状态**: ✅ 已测试可用
