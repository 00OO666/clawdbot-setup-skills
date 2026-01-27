#!/bin/bash
# Clawdbot Gateway 安装脚本
# 用途：在 WSL2 中自动安装和配置 Clawdbot Gateway

set -e

echo "🦞 Clawdbot Gateway 安装脚本"
echo "================================"

# 参数
API_KEY="$1"
BOT_TOKEN="$2"
GATEWAY_TOKEN="$3"
PORT="${4:-18789}"

if [ -z "$API_KEY" ] || [ -z "$BOT_TOKEN" ] || [ -z "$GATEWAY_TOKEN" ]; then
    echo "❌ 错误：缺少必需参数"
    echo "用法：$0 <API_KEY> <BOT_TOKEN> <GATEWAY_TOKEN> [PORT]"
    exit 1
fi

# 步骤 1: 检查 Node.js
echo ""
echo "📦 步骤 1/5: 检查 Node.js..."
if ! command -v node &> /dev/null; then
    echo "⚠️  Node.js 未安装，正在安装..."
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
    sudo apt-get install -y nodejs
    echo "✅ Node.js 安装完成"
else
    echo "✅ Node.js 已安装: $(node --version)"
fi

# 步骤 2: 安装 Clawdbot
echo ""
echo "📦 步骤 2/5: 安装 Clawdbot..."
npm install -g clawdbot
echo "✅ Clawdbot 安装完成: $(clawdbot --version)"

# 步骤 3: 创建配置目录
echo ""
echo "📁 步骤 3/5: 创建配置目录..."
mkdir -p ~/.clawdbot
echo "✅ 配置目录已创建"

# 步骤 4: 创建配置文件
echo ""
echo "⚙️  步骤 4/5: 创建配置文件..."
cat > ~/.clawdbot/clawdbot.json << EOF
{
  "providers": {
    "anthropic": {
      "apiKey": "$API_KEY"
    }
  },
  "model": "anthropic/claude-opus-4-5",
  "gateway": {
    "bind": "lan",
    "port": $PORT,
    "auth": {
      "mode": "token",
      "token": "$GATEWAY_TOKEN"
    }
  },
  "channels": {
    "telegram": {
      "enabled": true,
      "botToken": "$BOT_TOKEN",
      "dmPolicy": "pairing"
    }
  }
}
EOF
echo "✅ 配置文件已创建"

# 步骤 5: 启动 Gateway
echo ""
echo "🚀 步骤 5/5: 启动 Gateway..."
clawdbot gateway --daemon
sleep 3

# 验证状态
echo ""
echo "🔍 验证 Gateway 状态..."
clawdbot status

echo ""
echo "✅ Gateway 安装完成！"
echo ""
echo "下一步："
echo "1. 在 Telegram 中找到你的 bot 并点击 Start"
echo "2. 发送任意消息测试连接"
echo "3. 运行配对命令：clawdbot pairing list telegram"
