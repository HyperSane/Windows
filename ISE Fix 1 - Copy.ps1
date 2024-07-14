# Ensure the script is running with administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "You need to run this script as an Administrator."
    break
}

# Function to safely stop a service with error checking
function Stop-ServiceSafely {
    param([string]$serviceName)
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    if ($service) {
        Stop-Service -Name $serviceName -Force -ErrorAction SilentlyContinue
        Write-Output "$serviceName service stopped successfully."
    } else {
        Write-Warning "$serviceName service could not be found."
    }
}

# Function to safely start a service with error checking
function Start-ServiceSafely {
    param([string]$serviceName)
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    if ($service) {
        Start-Service -Name $serviceName -ErrorAction SilentlyContinue
        Write-Output "$serviceName service started successfully."
    } else {
        Write-Warning "$serviceName service could not be found."
    }
}

# Stop Windows Update services before making changes
Write-Output "Stopping Windows Update services..."
'Stop-ServiceSafely wuauserv'
'Stop-ServiceSafely cryptSvc'
'Stop-ServiceSafely bits'
'Stop-ServiceSafely msiserver'

# Clean up SoftwareDistribution and Catroot2 directories
Write-Output "Cleaning SoftwareDistribution and Catroot2 directories..."
Rename-Item -Path C:\Windows\SoftwareDistribution -NewName SoftwareDistribution.old -Force
Rename-Item -Path C:\Windows\System32\catroot2 -NewName Catroot2.old -Force

# Start Windows Update services
Write-Output "Restarting Windows Update services..."
'Start-ServiceSafely wuauserv'
'Start-ServiceSafely cryptSvc'
'Start-ServiceSafely bits'
'Start-ServiceSafely msiserver'

# Run System File Checker
Write-Output "Running System File Checker (SFC)..."
sfc /scannow

# Run DISM to restore health
Write-Output "Running DISM to repair Windows Image..."
DISM /Online /Cleanup-Image /RestoreHealth

# Countdown before reboot
Write-Output "System will reboot in 60 seconds..."
for ($i = 60; $i -gt 0; $i--) {
    Write-Output "$i second(s) remaining..."
    Start-Sleep -Seconds 1
}

# Reboot the system
Restart-Computer
