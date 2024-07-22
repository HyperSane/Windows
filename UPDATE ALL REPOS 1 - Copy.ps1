# Install Chocolatey if it's not already installed
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Upgrade all packages
Write-Host "Upgrading all packages..."

# Upgrade Chocolatey packages
Write-Host "Upgrading Chocolatey packages..."
choco upgrade all -y

# Upgrade Python packages
Write-Host "Upgrading Python packages..."
python -m pip install --upgrade pip
Get-Package -Name * | ForEach-Object { pip install --upgrade $_.Name }

# Upgrade Java
Write-Host "Upgrading Java..."
choco upgrade openjdk -y

# Upgrade Electron
Write-Host "Upgrading Electron..."
npm install electron@latest -g

# Upgrade Node.js and npm
Write-Host "Upgrading Node.js and npm..."
npm install npm@latest -g
npm install node@latest -g

# Upgrade PowerShell modules
Write-Host "Upgrading PowerShell modules..."
Get-Module -ListAvailable | ForEach-Object { Update-Module $_.Name -Force }

Write-Host "Upgrade complete!"