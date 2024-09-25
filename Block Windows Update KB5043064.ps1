#description: This script hides the KB5043064 Windows update and clears the Windows Update cache.
#execution mode: IndividualWithRestart

# Ensure PSWindowsUpdate is installed on the system.
if(!(Get-installedmodule PSWindowsUpdate)){

    # Ensure NuGet and PowershellGet are installed on system
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Module PowershellGet -Force

    # Install latest version of PSWindowsUpdate
    Install-Module PSWindowsUpdate -Force
}

Import-Module PSWindowsUpdate -Force

# Hide KB5043064 from Windows Update to prevent automatic installation.
Hide-WindowsUpdate -KBArticleID KB5043064 -Confirm:$false

# Stop the Windows Update Service so the Windows Update cache can be cleared.
Stop-Service -Name wuauserv

Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force

Start-Service -Name wuauserv
