# Check for admin privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "This script requires administrator privileges."
    Write-Host "Right-click the script and select 'Run with PowerShell as administrator'."
    Pause
    exit 1
}

# Define paths and URLs
$hostsFile = "$env:windir\System32\drivers\etc\hosts"
$backupFile = "$env:windir\System32\drivers\etc\hosts.bak"
$hostsUrl = "https://raw.githubusercontent.com/servalabs/win/main/hosts"
$tempFile = "$env:TEMP\hosts_downloaded"

# Backup the original hosts file
if (-not (Test-Path $backupFile)) {
    Copy-Item -Path $hostsFile -Destination $backupFile -Force
    if ($?) {
        Write-Host "Backup created at $backupFile"
    } else {
        Write-Host "Failed to create backup. Aborting."
        Pause
        exit 1
    }
}

# Download the hosts file from GitHub
try {
    Invoke-WebRequest -Uri $hostsUrl -OutFile $tempFile -ErrorAction Stop
    Write-Host "Downloaded hosts file from $hostsUrl"
} catch {
    Write-Host "Failed to download hosts file from $hostsUrl. Error: $_"
    Pause
    exit 1
}

# Replace the local hosts file
try {
    Copy-Item -Path $tempFile -Destination $hostsFile -Force -ErrorAction Stop
    Write-Host "Replaced local hosts file with downloaded version"
} catch {
    Write-Host "Failed to replace hosts file. Error: $_"
    Pause
    exit 1
}

# Clean up temporary file
Remove-Item -Path $tempFile -Force -ErrorAction SilentlyContinue

# Flush DNS cache
ipconfig /flushdns | Out-Null
if ($?) {
    Write-Host "DNS cache flushed successfully"
} else {
    Write-Host "Failed to flush DNS cache. Please run 'ipconfig /flushdns' manually."
}

Write-Host "Done! Hosts file updated and DNS cache flushed."
Write-Host "Verify by checking CorelDRAW or other blocked services."
Pause