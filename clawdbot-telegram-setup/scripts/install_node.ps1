# Clawdbot Windows Node Client 安装脚本
# 用途：在 Windows 上自动安装和配置 Clawdbot Node Client

param(
    [Parameter(Mandatory=$true)]
    [string]$WSL2_IP,

    [Parameter(Mandatory=$true)]
    [string]$GatewayToken,

    [Parameter(Mandatory=$false)]
    [int]$Port = 18789
)

Write-Host "🦞 Clawdbot Node Client 安装脚本" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# 步骤 1: 检查 Clawdbot
Write-Host "📦 步骤 1/5: 检查 Clawdbot..." -ForegroundColor Yellow
try {
    $version = clawdbot --version 2>$null
    Write-Host "✅ Clawdbot 已安装: $version" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Clawdbot 未安装，正在安装..." -ForegroundColor Yellow
    npm install -g clawdbot
    Write-Host "✅ Clawdbot 安装完成" -ForegroundColor Green
}

# 步骤 2: 创建配置目录
Write-Host ""
Write-Host "📁 步骤 2/5: 创建配置目录..." -ForegroundColor Yellow
$configDir = "$env:USERPROFILE\.clawdbot"
if (!(Test-Path $configDir)) {
    New-Item -ItemType Directory -Force -Path $configDir | Out-Null
}
Write-Host "✅ 配置目录已创建" -ForegroundColor Green

# 步骤 3: 创建配置文件
Write-Host ""
Write-Host "⚙️  步骤 3/5: 创建配置文件..." -ForegroundColor Yellow
$config = @{
    gateway = @{
        host = $WSL2_IP
        port = $Port
        token = $GatewayToken
    }
} | ConvertTo-Json

$configPath = "$configDir\node.json"
$config | Out-File -FilePath $configPath -Encoding UTF8
Write-Host "✅ 配置文件已创建: $configPath" -ForegroundColor Green

# 步骤 4: 安装为 Windows 服务
Write-Host ""
Write-Host "🔧 步骤 4/5: 安装为 Windows 服务..." -ForegroundColor Yellow
clawdbot node install
Write-Host "✅ Node Client 已安装为服务" -ForegroundColor Green

# 步骤 5: 验证状态
Write-Host ""
Write-Host "🔍 步骤 5/5: 验证 Node 状态..." -ForegroundColor Yellow
Start-Sleep -Seconds 3
clawdbot node status

Write-Host ""
Write-Host "✅ Node Client 安装完成！" -ForegroundColor Green
Write-Host ""
Write-Host "下一步：" -ForegroundColor Cyan
Write-Host "1. 在 Telegram 中向 bot 发送：检查待配对的设备" -ForegroundColor White
Write-Host "2. Bot 会自动批准配对请求" -ForegroundColor White
Write-Host "3. 测试远程命令：在我的电脑上运行：hostname" -ForegroundColor White
