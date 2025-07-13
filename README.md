# Windows Privacy & Telemetry Blocker

A comprehensive hosts file and PowerShell script to block Windows telemetry, Adobe services, and various tracking/analytics services on Windows systems.

## Description

This project provides a curated hosts file that blocks unwanted telemetry, tracking, and analytics services while maintaining system functionality. It's designed to enhance privacy and reduce unnecessary network traffic without breaking essential Windows features.

## Services Blocked

### Windows Telemetry & Error Reporting
- **Windows Error Reporting**: Blocks Watson telemetry and error reporting endpoints
- **DiagTrack/Telemetry**: Blocks Microsoft's diagnostic tracking services
- **Activity Tracking**: Blocks Windows activity monitoring services

### Adobe Services
- **Adobe Telemetry**: Blocks Adobe's usage analytics and telemetry
- **Adobe Licensing**: Blocks license verification (may affect some Adobe software functionality)
- **Adobe Statistics**: Blocks Adobe's analytics and tracking services

### Development Tools
- **Visual Studio/VSCode Telemetry**: Blocks telemetry from Microsoft development tools
- **Brave Browser Telemetry**: Blocks Brave browser's privacy analytics (P3A)

### Analytics & Tracking Services
- **Google Analytics & Advertising**: Blocks Google's tracking and advertising services
- **Facebook/Meta Tracking**: Blocks Facebook's analytics and pixel tracking
- **Twitter/X Analytics**: Blocks Twitter's analytics services
- **LinkedIn Tracking**: Blocks LinkedIn's analytics
- **Pinterest Tracking**: Blocks Pinterest's analytics
- **Instagram Tracking**: Blocks Instagram's analytics
- **Apple Telemetry**: Blocks Apple's usage analytics
- **Amazon Advertising**: Blocks Amazon's advertising system
- **Chrome Telemetry**: Blocks Chrome's safe browsing and telemetry
- **Firefox Telemetry**: Blocks Firefox's telemetry and location services
- **Common Analytics**: Blocks popular analytics services (Mixpanel, Amplitude, Segment, Hotjar, FullStory)

### Software-Specific Blocks
- **CorelDRAW Internet Access**: Blocks CorelDRAW's online services and updates

## How to Use

### Method 1: Automated Installation (Recommended)

#### Option A: Download and Run in One Command (Recommended)
```powershell
# Download and execute immediately (requires admin privileges)
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/servalabs/win/main/replace-hosts.ps1" -UseBasicParsing).Content
```

**Note**: This runs the script directly from GitHub without saving a local file. Make sure to run PowerShell as Administrator.

#### Option B: Download and Run Locally
1. **Download the PowerShell script**:
   ```powershell
   # Download the script
   Invoke-WebRequest -Uri "https://raw.githubusercontent.com/servalabs/win/main/replace-hosts.ps1" -OutFile "replace-hosts.ps1"
   ```

2. **Run as Administrator**:
   - Right-click on `replace-hosts.ps1`
   - Select "Run with PowerShell as administrator"
   - The script will automatically:
     - Create a backup of your current hosts file
     - Download the latest hosts file from GitHub
     - Replace your local hosts file
     - Flush the DNS cache

### Method 2: Manual Installation

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

## Verification

After installation, you can verify the blocking is working by:

1. **Check Adobe services**: Try accessing Adobe's activation servers
2. **Check Windows telemetry**: Monitor network traffic for blocked domains
3. **Test analytics blocking**: Visit websites and check if analytics services are blocked

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

## Troubleshooting

### If websites don't load properly:
1. Check if the domain is accidentally blocked
2. Temporarily comment out the problematic line in the hosts file
3. Flush DNS cache: `ipconfig /flushdns`

### If Adobe software doesn't work:
- Some Adobe software may require internet access for licensing
- Consider uncommenting specific Adobe domains if needed

### If the script fails:
- Ensure you're running as administrator
- Check your internet connection
- Verify the GitHub repository is accessible

## Contributing

Feel free to submit issues or pull requests to improve the blocking rules or add new services.

## License

This project is open source and available under the MIT License.