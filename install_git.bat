@echo off
echo Installing Git for Windows...
echo.

:: Download Git using curl (built into Windows 10/11)
echo Downloading Git installer...
curl -L -o %TEMP%\git-installer.exe https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.2/Git-2.42.0.2-64-bit.exe

:: Run installer silently
echo Running installer (this may take a few minutes)...
start /wait %TEMP%\git-installer.exe /VERYSILENT /NORESTART

:: Initialize Git repository
echo.
echo Initializing Git repository...
call git init
echo.

:: Create basic .gitignore
echo Creating .gitignore file...
(
echo # Node modules
echo node_modules/
echo.
echo # Build files
echo /dist
echo /build
echo.
echo # Environment variables
echo .env
echo .env.local
echo.
echo # Debug logs
echo npm-debug.log*
echo yarn-debug.log*
echo yarn-error.log*
echo.
echo # Editor files
echo .vscode/
echo .idea/
echo *.suo
echo *.ntvs*
echo *.njsproj
echo *.sln
echo.
echo # OS specific
echo .DS_Store
echo Thumbs.db
) > .gitignore

echo.
echo Git has been installed and repository initialized!
echo Remember to configure your user name and email with:
echo git config --global user.name "Your Name"
echo git config --global user.email "your.email@example.com"
echo.
pause 