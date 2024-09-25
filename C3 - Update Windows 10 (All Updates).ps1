#description: Installs latest Windows 10 updates including optional updates.
#execution mode: IndividualWithRestart
#tags: Nerdio

<#
Notes:
This script will install ALL Windows updates using PSWindowsUpdate
See: https://www.powershellgallery.com/packages/PSWindowsUpdate for details on
how to customize and use the module for your needs.
#>

# Ensure PSWindowsUpdate is installed on the system.
if(!(Get-installedmodule PSWindowsUpdate)){

    # Ensure NuGet and PowershellGet are installed on system
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Module PowershellGet -Force

    # Install latest version of PSWindowsUpdate
    Install-Module PSWindowsUpdate -Force
}
Import-Module PSWindowsUpdate -Force

# Initiate download and install of all pending Windows updates
Get-WindowsUpdate -NotKBArticleID "KB5043064" -criteria "isinstalled=0 and deploymentaction=*" -Install -Verbose -AcceptAll -ForceInstall -IgnoreReboot
