# Windows Privacy & Telemetry Blocker

A comprehensive hosts file and PowerShell script to block Windows telemetry, Adobe services, and various tracking/analytics services on Windows systems.

## Description

This project provides a curated hosts file that blocks unwanted telemetry, tracking, and analytics services while maintaining system functionality. It's designed to enhance privacy and reduce unnecessary network traffic without breaking essential Windows features.

## Services Blocked

### Microsoft Telemetry & Error Reporting
- **Windows Telemetry**: Blocks Microsoft's diagnostic data collection
- **Windows Error Reporting**: Blocks Watson telemetry and error reporting endpoints
- **DiagTrack/Telemetry**: Blocks Microsoft's diagnostic tracking services
- **Visual Studio/VSCode**: Blocks telemetry from Microsoft development tools

### Adobe Services (Comprehensive Blocking)
- **Adobe Activation**: Blocks Adobe's software activation and licensing servers
- **Adobe Telemetry**: Blocks Adobe's usage analytics and telemetry collection
- **Adobe Statistics**: Blocks Adobe's analytics and tracking services
- **Adobe Cloud Services**: Blocks Adobe's cloud-based services and APIs
- **Adobe Licensing**: Blocks license verification servers (may affect some Adobe software functionality)

### Browser Telemetry
- **Brave Browser Telemetry**: Blocks Brave browser's privacy analytics (P3A)
- **Chrome Telemetry**: Blocks Chrome's safe browsing and telemetry
- **Firefox Telemetry**: Blocks Firefox's telemetry and location services

### Analytics & Tracking Services
- **Google Analytics & Advertising**: Blocks Google's tracking and advertising services
- **Facebook/Meta Tracking**: Blocks Facebook's analytics and pixel tracking
- **Twitter/X Analytics**: Blocks Twitter's analytics services
- **LinkedIn Tracking**: Blocks LinkedIn's analytics
- **Pinterest Tracking**: Blocks Pinterest's analytics
- **Instagram Tracking**: Blocks Instagram's analytics
- **Apple Telemetry**: Blocks Apple's usage analytics
- **Amazon Advertising**: Blocks Amazon's advertising system
- **Common Analytics**: Blocks popular analytics services (Mixpanel, Amplitude, Segment, Hotjar, FullStory)

### Ad Networks & Advertising
- **Mainstream Ad Networks**: Blocks major advertising networks and platforms
- **YouTube Ads**: Blocks YouTube advertising domains (partial blocking)
- **Social Media Ads**: Blocks advertising from TikTok, Snapchat, Reddit, Discord

### Professional Software Telemetry
- **Autodesk**: Blocks AutoCAD, Maya, 3ds Max analytics and telemetry
- **Unity**: Blocks Unity game engine analytics and telemetry
- **GitHub**: Blocks GitHub analytics and telemetry (Microsoft-owned)
- **Unreal Engine**: Blocks Epic Games analytics and telemetry

### Security & Malware Protection
- **Crypto Mining**: Blocks cryptocurrency mining domains
- **Malware & Scam Sites**: Blocks known malicious and phishing domains
- **Tracking Domains**: Blocks various tracking and analytics services

### Software-Specific Blocks
- **CorelDRAW Internet Access**: Blocks CorelDRAW's online services and updates

## How to Use

### Automated Installation (Recommended)

Download and run in one command (requires admin privileges):
```powershell
# Download and execute immediately (requires admin privileges)
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/servalabs/win/main/replace-hosts.ps1" -UseBasicParsing).Content
```

**Note**: This runs the script directly from GitHub without saving a local file. Make sure to run PowerShell as Administrator.

### Manual Installation

1. **Backup your current hosts file**:
   ```cmd
   copy C:\Windows\System32\drivers\etc\hosts C:\Windows\System32\drivers\etc\hosts.backup
   ```

2. **Download and replace the hosts file**:
   - Download the `hosts` file from this repository
   - Copy it to `C:\Windows\System32\drivers\etc\hosts`
   - You'll need administrator privileges

3. **Flush DNS cache**:
   ```cmd
   ipconfig /flushdns
   ```

## Backup and Recovery

The automated script creates a backup at `C:\Windows\System32\drivers\etc\hosts.bak`. To restore:

```cmd
copy C:\Windows\System32\drivers\etc\hosts.bak C:\Windows\System32\drivers\etc\hosts
ipconfig /flushdns
```

## Important Notes

- **Administrator Rights Required**: Both methods require administrator privileges
- **Adobe Software**: Some Adobe software may have reduced functionality due to license verification blocking
- **Windows Updates**: This does not block Windows Update services
- **Browser Extensions**: Consider using additional privacy extensions for comprehensive protection
- **Regular Updates**: The hosts file is updated regularly with new blocking rules
- **Professional Software**: Some development tools may have reduced functionality due to telemetry blocking

## File Structure

- `hosts` - The main hosts file with all blocking rules
- `replace-hosts.ps1` - PowerShell script for automated installation
- `README.md` - This documentation file