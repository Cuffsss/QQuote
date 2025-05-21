# Script to install Git and initialize repository

Write-Host "Installing Git using winget..." -ForegroundColor Cyan

# Try to install Git using winget (preferred method on Windows 10)
try {
    winget install --id Git.Git -e --source winget
    $exitCode = $LASTEXITCODE
    if ($exitCode -ne 0) {
        throw "Winget installation failed with exit code $exitCode"
    }
} catch {
    Write-Host "Winget installation failed. Trying alternative method..." -ForegroundColor Yellow
    
    # Alternative: Download Git installer directly
    $tempFolder = [System.IO.Path]::GetTempPath()
    $installerPath = Join-Path $tempFolder "GitInstaller.exe"
    
    Write-Host "Downloading Git installer..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v2.41.0.windows.1/Git-2.41.0-64-bit.exe" -OutFile $installerPath
    
    Write-Host "Running Git installer..." -ForegroundColor Cyan
    Start-Process -FilePath $installerPath -Args "/VERYSILENT /NORESTART" -Wait
}

# Refresh environment variables
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Wait a moment for installation to complete
Start-Sleep -Seconds 5

# Check if git is now available
$gitInstalled = $null
try {
    $gitInstalled = Get-Command git -ErrorAction SilentlyContinue
} catch {
    # Git command not found
}

if ($gitInstalled) {
    Write-Host "Git has been successfully installed!" -ForegroundColor Green
    
    # Initialize git repository
    Write-Host "Initializing git repository..." -ForegroundColor Cyan
    git init
    
    # Create a basic .gitignore file
    @"
# Node modules
node_modules/

# Build files
/dist
/build

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Debug logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Editor directories and files
.idea
.vscode
*.suo
*.ntvs*
*.njsproj
*.sln
*.sw?

# OS specific
.DS_Store
Thumbs.db
"@ | Out-File -FilePath ".gitignore" -Encoding utf8
    
    Write-Host "Created .gitignore file" -ForegroundColor Green
    
    # Initialize with first commit
    git add .
    git config --global user.email "user@example.com"
    git config --global user.name "Your Name"
    git commit -m "Initial commit"
    
    Write-Host "Git repository has been initialized successfully!" -ForegroundColor Green
} else {
    Write-Host "Failed to install Git. Please install Git manually from https://git-scm.com/download/win" -ForegroundColor Red
} 