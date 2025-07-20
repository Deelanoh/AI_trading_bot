```batch
@echo off
title AI Trading App - Professional Installer
color 0A
echo.
echo ╔══════════════════════════════════════════════════════════════╗
echo ║ AI TRADING APP INSTALLER ║
echo ║ Professional Desktop Edition ║
echo ╚══════════════════════════════════════════════════════════════╝
echo.
echo Installing AI-Powered FBS Trading Platform...
echo.
:: Check if running as administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
echo ⚠️ Administrator privileges required for installation.
echo ⚠️ Please right-click and "Run as Administrator"
echo.
pause
exit /b 1
)
:: Set installation directory
set "INSTALL_DIR=%USERPROFILE%\AI-Trading-App"
echo 📁 Installation Directory: %INSTALL_DIR%
echo.
:: Create installation directory
if not exist "%INSTALL_DIR%" (
mkdir "%INSTALL_DIR%"
echo ✅ Created installation directory
) else (
echo 📁 Installation directory exists
)
cd /d "%INSTALL_DIR%"
:: Check Node.js installation
echo 🔍 Checking Node.js installation...
node --version >nul 2>&1
if %errorLevel% neq 0 (
echo ❌ Node.js not found!
echo.
echo 📥 Downloading Node.js installer...
powershell -Command "Invoke-WebRequest -Uri 'https://nodejs.org/dist/v20.11.0/node-v20.11.0-x64.msi' -OutFile 'nodejs-installer.msi'"
echo 🚀 Installing Node.js...
msiexec /i nodejs-installer.msi /quiet /norestart
echo ✅ Node.js installed successfully
del nodejs-installer.msi
) else (
echo ✅ Node.js found
)
:: Install pnpm
echo 📦 Installing pnpm package manager...
npm install -g pnpm >nul 2>&1
echo ✅ pnpm installed
:: Create project structure
echo 🏗️ Creating project structure...
mkdir src\components\auth 2>nul
mkdir src\components\trading 2>nul
mkdir src\components\ui 2>nul
mkdir src\convex\auth 2>nul
mkdir src\hooks 2>nul
mkdir src\lib 2>nul
mkdir src\pages 2>nul
mkdir public 2>nul
echo ✅ Project structure created
:: Create package.json
echo 📄 Creating package.json...
(
echo {
echo "name": "ai-trading-app",
echo "version": "1.0.0",
echo "description": "AI-Powered FBS Trading Platform",
echo "type": "module",
echo "scripts": {
echo "dev": "vite",
echo "build": "tsc -b && vite build",
echo "lint": "eslint .",
echo "format": "prettier --write .",
echo "preview": "vite preview",
echo "start": "npm run dev"
echo },
echo "dependencies": {
echo "@convex-dev/auth": "^0.0.86",
echo "convex": "^1.24.6",
echo "react": "^19.1.0",
echo "react-dom": "^19.1.0",
echo "react-router": "^7.6.1",
echo "framer-motion": "^12.15.0",
echo "lucide-react": "^0.511.0",
echo "metaapi.cloud-sdk": "^29.2.0",
echo "tailwindcss": "^4.1.8",
echo "sonner": "^2.0.4"
echo },
echo "devDependencies": {
echo "@types/node": "^22.15.29",
echo "@types/react": "^19.1.2",
echo "@types/react-dom": "^19.1.2",
echo "@vitejs/plugin-react": "^4.4.1",
echo "typescript": "~5.8.3",
echo "vite": "^6.3.5"
echo }
echo }
) > package.json
echo ✅ package.json created
:: Install dependencies
echo 📦 Installing dependencies... (This may take 2-3 minutes)
pnpm install --silent
if %errorLevel% neq 0 (
echo ❌ Failed to install dependencies
pause
exit /b 1
)
echo ✅ Dependencies installed successfully
:: Create start script
echo 🚀 Creating launcher...
(
echo @echo off
echo title AI Trading App - Starting...
echo echo.
echo echo ╔══════════════════════════════════════════════════════════════╗
echo echo ║ AI TRADING APP STARTING ║
echo echo ╚══════════════════════════════════════════════════════════════╝
echo echo.
echo echo 🚀 Starting Convex backend...
echo start "Convex Backend" cmd /k "npx convex dev"
echo timeout /t 5 /nobreak ^> nul
echo echo 🌐 Starting frontend...
echo start "AI Trading App" cmd /k "pnpm dev"
echo echo.
echo echo ✅ AI Trading App is starting!
echo echo 📱 Open: http://localhost:5173
echo echo.
echo pause
) > start.bat
echo.
echo ✅ Installation Complete!
echo.
echo 📋 Next Steps:
echo 1. Get MetaApi token: https://app.metaapi.cloud
echo 2. Get FBS credentials: https://fbs.com
echo 3. Run start.bat
echo 4. Open http://localhost:5173
echo.
echo 🎯 Ready to start AI trading!
pause
```
