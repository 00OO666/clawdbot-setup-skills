#!/bin/bash
# Clawdbot WSL2 Gateway 安装脚本 (WhatsApp 版本)
# 用途：在 WSL2 中自动安装和配置 Clawdbot Gateway for WhatsApp

set -e

echo "🦞 Clawdbot Gateway 安装脚本 (WhatsApp 版本)"
echo "=============================================="
echo ""

# 参数
API_KEY="$1"
PHONE_NUMBER="$2"
GATEWAY_TOKEN="$3"
PORT="${4:-18789}"
SELF_CHAT_MODE="${5:-true}"

# 步骤 1: 检查 Node.js
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
echo "✅ Clawdbot 安装完成"

# 步骤 3: 创建配置目录
echo ""
echo "📁 步骤 3/5: 创建配置目录..."
mkdir -p ~/.clawdbot
echo "✅ 配置目录已创建"

# 步骤 4: 创建配置文件
echo ""
echo "⚙️  步骤 4/5: 创建配置文件..."

if [ "$SELF_CHAT_MODE" = "true" ]; then
    # 自聊模式配置
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
    "whatsapp": {
      "enabled": true,
      "selfChatMode": true,
      "dmPolicy": "allowlist",
      "allowFrom": ["$PHONE_NUMBER"]
    }
  }
}
EOF
else
    # 备用号码配置
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
    "whatsapp": {
      "enabled": true,
      "dmPolicy": "allowlist",
      "allowFrom": ["$PHONE_NUMBER"]
    }
  }
}
EOF
fi

echo "✅ 配置文件已创建: ~/.clawdbot/clawdbot.json"

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
echo "1. 运行扫码登录：clawdbot channels login"
echo "2. 用手机 WhatsApp 扫描二维码"
echo "3. 验证连接状态：clawdbot channels status"
