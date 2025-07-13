# Check for admin privileges
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "❌ ERROR: This script requires administrator privileges." -ForegroundColor Red
    Write-Host "💡 SOLUTION: Right-click PowerShell and select 'Run as administrator'" -ForegroundColor Yellow
    Write-Host "   OR run this command in an admin PowerShell window." -ForegroundColor Yellow
    Pause
    exit 1
}

# Define paths and URLs
$hostsFile = "$env:windir\System32\drivers\etc\hosts"
$backupFile = "$env:windir\System32\drivers\etc\hosts.bak"
$hostsUrl = "https://raw.githubusercontent.com/servalabs/win/main/hosts"
$tempFile = "$env:TEMP\hosts_downloaded"

# Backup the original hosts file
Write-Host "🔍 Checking for existing backup..." -ForegroundColor Cyan
if (-not (Test-Path $backupFile)) {
    Write-Host "📋 Creating backup of current hosts file..." -ForegroundColor Cyan
    Copy-Item -Path $hostsFile -Destination $backupFile -Force
    if ($?) {
        Write-Host "✅ Backup created successfully at: $backupFile" -ForegroundColor Green
    } else {
        Write-Host "❌ ERROR: Failed to create backup. Aborting." -ForegroundColor Red
        Write-Host "💡 Try running as administrator or check file permissions." -ForegroundColor Yellow
        Pause
        exit 1
    }
} else {
    Write-Host "ℹ️  Backup already exists at: $backupFile" -ForegroundColor Blue
}

# Download the hosts file from GitHub
Write-Host "🌐 Downloading latest hosts file from GitHub..." -ForegroundColor Cyan
try {
    Invoke-WebRequest -Uri $hostsUrl -OutFile $tempFile -ErrorAction Stop
    Write-Host "✅ Successfully downloaded hosts file from GitHub" -ForegroundColor Green
} catch {
    Write-Host "❌ ERROR: Failed to download hosts file from GitHub" -ForegroundColor Red
    Write-Host "🔍 Error details: $_" -ForegroundColor Yellow
    Write-Host "💡 Check your internet connection and try again." -ForegroundColor Yellow
    Pause
    exit 1
}

# Replace the local hosts file
Write-Host "📝 Replacing local hosts file with updated version..." -ForegroundColor Cyan
try {
    Copy-Item -Path $tempFile -Destination $hostsFile -Force -ErrorAction Stop
    Write-Host "✅ Successfully updated hosts file" -ForegroundColor Green
} catch {
    Write-Host "❌ ERROR: Failed to replace hosts file" -ForegroundColor Red
    Write-Host "🔍 Error details: $_" -ForegroundColor Yellow
    Write-Host "💡 Make sure you're running as administrator." -ForegroundColor Yellow
    Pause
    exit 1
}

# Clean up temporary file
Write-Host "🧹 Cleaning up temporary files..." -ForegroundColor Cyan
Remove-Item -Path $tempFile -Force -ErrorAction SilentlyContinue

# Flush DNS cache
Write-Host "🔄 Flushing DNS cache..." -ForegroundColor Cyan
ipconfig /flushdns | Out-Null
if ($?) {
    Write-Host "✅ DNS cache flushed successfully" -ForegroundColor Green
} else {
    Write-Host "⚠️  WARNING: Failed to flush DNS cache" -ForegroundColor Yellow
    Write-Host "💡 Please run 'ipconfig /flushdns' manually to complete the process." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎉 SUCCESS! Hosts file has been updated successfully!" -ForegroundColor Green
Write-Host ""
Pause