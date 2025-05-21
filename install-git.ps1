# Simple script to download and install Git

# Create temp directory if it doesn't exist
$tempDir = "$env:TEMP\git-installer"
if (-not (Test-Path $tempDir)) {
    New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
}

# Path to installer
$installerPath = "$tempDir\Git-Installer.exe"

# Download Git installer
$url = "https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.2/Git-2.42.0.2-64-bit.exe"
Write-Host "Downloading Git installer from $url"

try {
    # Use .NET WebClient as it's more stable than Invoke-WebRequest
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($url, $installerPath)
    
    Write-Host "Download completed. Installing Git..."
    
    # Install Git silently
    Start-Process -FilePath $installerPath -ArgumentList "/VERYSILENT /NORESTART" -Wait
    
    Write-Host "Git installation completed."
    
    # Refresh environment path
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")
    
    # Initialize Git repository
    Write-Host "Initializing Git repository..."
    & "C:\Program Files\Git\bin\git.exe" init
    
    # Create .gitignore
    Write-Host "Creating .gitignore file..."
    @"
# Node modules
node_modules/

# Build files
/dist
/build

# Environment variables
.env
.env.local

# Debug logs
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Editor files
.vscode/
.idea/
*.suo
*.ntvs*
*.njsproj
*.sln

# OS specific
.DS_Store
Thumbs.db
"@ | Out-File -FilePath ".gitignore" -Encoding utf8
    
    Write-Host "Git has been installed and repository initialized!"
} 
catch {
    Write-Host "An error occurred: $_"
    Write-Host "Please install Git manually from https://git-scm.com/download/win"
} 