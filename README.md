# 🦞 Clawdbot 一键安装工具

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude-Code-blue.svg)](https://claude.com/claude-code)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)

**让 AI 助手通过 Telegram/WhatsApp 控制你的电脑**

[快速开始](#-快速开始) • [功能特性](#-功能特性) • [版本对比](#-版本对比) • [安装指南](#-安装指南) • [常见问题](#-常见问题)

</div>

---

## 📖 简介

Clawdbot Setup Skills 是一套自动化安装工具，帮助你在 **5 分钟内**完成 Clawdbot 的完整配置，让你的 AI 助手能够通过 Telegram 或 WhatsApp 远程控制你的 Windows 电脑。

**适合人群**：
- ✅ 想要远程控制电脑的开发者
- ✅ 需要 AI 助手帮忙处理文件的用户
- ✅ 希望通过聊天软件执行命令的极客
- ✅ 编程小白也能轻松上手

**核心优势**：
- 🚀 **一键安装** - 全自动化流程，无需手动配置
- 📱 **双平台支持** - Telegram 和 WhatsApp 任选
- 🔒 **安全可靠** - 配对机制保护，只有你能控制
- 📊 **进度追踪** - 实时显示安装进度
- 🛠️ **智能修复** - 自动检测并修复常见问题

---

## 🎯 功能特性

### Telegram 版本
- ✅ 创建专属 Telegram Bot
- ✅ 通过 Bot 与 AI 对话
- ✅ 远程执行电脑命令
- ✅ 读取和修改文件
- ✅ 支持群组协作

### WhatsApp 版本
- ✅ 无需创建 Bot，直接用你的 WhatsApp
- ✅ 扫码登录，像 WhatsApp Web 一样简单
- ✅ 自聊模式，给自己发消息控制电脑
- ✅ 端到端加密，更安全
- ✅ 支持备用号码

---

## 🆚 版本对比

| 特性 | Telegram 版本 | WhatsApp 版本 |
|------|--------------|---------------|
| **设置难度** | ⭐⭐⭐ 需要创建 Bot | ⭐⭐ 扫码即可 |
| **使用体验** | ⭐⭐ 需要找 Bot | ⭐⭐⭐ 自聊模式 |
| **隐私性** | ⭐⭐ 云端存储 | ⭐⭐⭐ 端到端加密 |
| **稳定性** | ⭐⭐⭐ 更稳定 | ⭐⭐ 需要保持连接 |
| **群组支持** | ✅ 支持 | ❌ 不支持 |
| **推荐场景** | 团队协作 | 个人使用 |

**选择建议**：
- 🏢 **团队使用** → 选择 Telegram 版本
- 👤 **个人使用** → 选择 WhatsApp 版本
- 🔒 **注重隐私** → 选择 WhatsApp 版本
- 🚀 **追求稳定** → 选择 Telegram 版本

---

## 🚀 快速开始

### 前置要求

- ✅ Windows 10/11（已安装 WSL2 Ubuntu）
- ✅ Claude Code（或其他支持 Claude Skills 的工具）
- ✅ Claude API Key（或其他 AI API）
- ✅ Telegram 账号（Telegram 版本）或 WhatsApp 账号（WhatsApp 版本）

### 安装步骤

#### 方法 1: 下载 ZIP（推荐）

1. **下载本仓库**
   ```bash
   # 点击页面右上角的 "Code" → "Download ZIP"
   # 或使用命令行：
   git clone https://github.com/00OO666/clawdbot-setup-skills.git
   ```

2. **解压到 Claude Skills 目录**
   ```bash
   # Windows 路径：
   C:\Users\你的用户名\.claude\skills\
   
   # 解压后应该有两个文件夹：
   # - clawdbot-telegram-setup/
   # - clawdbot-whatsapp-setup/
   ```

3. **在 Claude Code 中使用**
   ```
   # Telegram 版本
   安装 Clawdbot Telegram 版本
   
   # WhatsApp 版本
   安装 Clawdbot WhatsApp 版本
   ```

#### 方法 2: 手动安装

1. **复制 SKILL 文件夹**
   ```bash
   # 复制到 Claude Skills 目录
   cp -r clawdbot-telegram-setup ~/.claude/skills/
   cp -r clawdbot-whatsapp-setup ~/.claude/skills/
   ```

2. **重启 Claude Code**
   ```bash
   # Skills 会自动加载
   ```

---

## 📋 安装指南

### Telegram 版本安装

#### 步骤 1: 创建 Telegram Bot

1. 在 Telegram 中搜索 `@BotFather`
2. 发送 `/newbot`
3. 按提示设置 Bot 名称和用户名
4. 保存 Bot Token（类似：`8014998602:AAGxznNFRiclK1HbHFCRyWmi0ppllgqPmgI`）

#### 步骤 2: 获取 Chat ID

1. 在 Telegram 中搜索 `@userinfobot`
2. 点击 Start
3. 记下你的 Chat ID（类似：`6145538033`）

#### 步骤 3: 运行安装 SKILL

在 Claude Code 中说：
```
安装 Clawdbot Telegram 版本
```

SKILL 会自动：
- ✅ 收集配置信息（API Key、Bot Token、Chat ID）
- ✅ 安装 WSL2 Gateway
- ✅ 安装 Windows Node Client
- ✅ 完成配对
- ✅ 运行测试

#### 步骤 4: 测试

在 Telegram 中找到你的 Bot，发送：
```
你好
```

Bot 应该会回复！🎉

---

### WhatsApp 版本安装

#### 步骤 1: 准备手机号

确保你的手机上已安装 WhatsApp，并且：
- ✅ 手机号格式：E.164（如 `+8613800138000`）
- ✅ 建议使用备用号码（避免影响主号）

#### 步骤 2: 运行安装 SKILL

在 Claude Code 中说：
```
安装 Clawdbot WhatsApp 版本
```

SKILL 会自动：
- ✅ 收集配置信息（API Key、手机号）
- ✅ 安装 WSL2 Gateway
- ✅ 显示二维码供扫码登录
- ✅ 安装 Windows Node Client
- ✅ 完成配对

#### 步骤 3: 扫码登录

1. 打开手机 WhatsApp
2. 点击右上角 **三个点** → **已连接的设备**
3. 点击 **连接设备**
4. 扫描终端中的二维码

#### 步骤 4: 测试

在 WhatsApp 中给自己发消息：
```
你好
```

Clawdbot 应该会回复！🎉

---

## 💡 使用示例

### 示例 1: 查看电脑文件

**Telegram/WhatsApp 中发送**：
```
列出我桌面上的文件
```

**Clawdbot 回复**：
```
你的桌面文件：
- 项目文档.docx
- 会议记录.pdf
- 代码备份.zip
...
```

### 示例 2: 运行命令

**Telegram/WhatsApp 中发送**：
```
在我的电脑上运行：git status
```

**Clawdbot 回复**：
```
正在运行命令...

On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
```

### 示例 3: 读取文件

**Telegram/WhatsApp 中发送**：
```
读取文件：C:\Users\666\Desktop\notes.txt
```

**Clawdbot 回复**：
```
文件内容：
今天的待办事项：
1. 完成项目报告
2. 回复客户邮件
3. 准备明天的会议
```

---

## ⚠️ 常见问题

### Q1: 安装失败怎么办？

**A**: 检查以下几点：
1. 确认 WSL2 已正确安装
2. 确认 Node.js 版本 >= 16
3. 查看错误日志：`clawdbot logs --follow`
4. 重启 Gateway：`clawdbot gateway restart`

### Q2: Bot 不回复消息？

**A**:
1. 检查 Gateway 状态：`clawdbot status`
2. 检查配对状态：`clawdbot pairing list telegram`
3. 重新配对：在 Telegram 中发送 `/start`

### Q3: Node Client 连接失败？

**A**:
1. 确认 WSL2 IP 地址正确
2. 确认 Gateway Token 一致
3. 检查防火墙设置

### Q4: WhatsApp 扫码后显示 "Not linked"？

**A**:
1. 重新运行：`clawdbot channels login`
2. 确保手机和电脑在同一网络
3. 更新 WhatsApp 到最新版本

### Q5: 如何卸载？

**A**:
```bash
# WSL2 中
npm uninstall -g clawdbot

# Windows 中
npm uninstall -g clawdbot
clawdbot node uninstall
```

---

## 🔧 高级配置

### 自定义 Gateway 端口

编辑 `~/.clawdbot/clawdbot.json`：
```json
{
  "gateway": {
    "port": 18789  // 改为你想要的端口
  }
}
```

### 添加多个 Telegram 用户

```json
{
  "channels": {
    "telegram": {
      "dmPolicy": "allowlist",
      "allowFrom": [
        "6145538033",
        "1234567890"
      ]
    }
  }
}
```

### 启用 WhatsApp 群组支持

```json
{
  "channels": {
    "whatsapp": {
      "groups": {
        "*": {
          "requireMention": true
        }
      }
    }
  }
}
```

---

## 🤝 贡献指南

欢迎贡献代码、报告问题或提出建议！

### 如何贡献

1. Fork 本仓库
2. 创建特性分支：`git checkout -b feature/AmazingFeature`
3. 提交更改：`git commit -m 'Add some AmazingFeature'`
4. 推送到分支：`git push origin feature/AmazingFeature`
5. 提交 Pull Request

### 报告问题

如果遇到问题，请[创建 Issue](https://github.com/00OO666/clawdbot-setup-skills/issues)并提供：
- 操作系统版本
- Clawdbot 版本
- 错误日志
- 复现步骤

---

## 📄 许可证

本项目采用 MIT 许可证 - 详见 [LICENSE](LICENSE) 文件

---

## 🙏 致谢

- [Clawdbot](https://clawd.bot/) - 强大的 AI 助手框架
- [Claude Code](https://claude.com/claude-code) - 优秀的 AI 编程助手
- [Anthropic](https://www.anthropic.com/) - Claude AI 的创造者

---

<div align="center">

**如果这个项目对你有帮助，请给个 ⭐️ Star！**

Made with ❤️ by the Clawdbot Community

</div>
