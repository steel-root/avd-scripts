#description: Downloads & installs the Airlock Baseline Builder installer
#execution mode: Individual
#tags: Airlock

<#
  .SYNOPSIS
    Downloads & installs the Airlock Baseline Builder installer

  .DESCRIPTION
    This script runs the Airlock Baseline Builder installer on a session host in AVD.
    If updating the installer, be sure to use the same filename & public URL.

  .NOTES
    Company:  C3 Integrated Solutions
    Website:  c3isit.com
    Created:  2024-05-21
    Modified: 2024-09-03

  #! WARNING! Secure variables must be defined in Nerdio to use this script correctly.
  In Nerdio, define values for:
  - InstallersURL
  - AirlockBaselineBuilderFilename
#>

# Link to publicly available .msi
$PublicUrl = "$($SecureVars.InstallersURL)/ABB.msi"

# Local directory to keep the installer
$LocalDirectory = 'C:\Temp\'

# New filename you wish to assign to the downloaded file
$NewFileName = "$($SecureVars.AirlockBaselineBuilderFilename)"

# Local Directory + the new filename
$LocalFile = Join-Path -Path $LocalDirectory -ChildPath $NewFileName

# Stores arguments/parameters for msiexec command.
$Argument = "/i `"$LocalFile`" /qn"

Write-Host "Current value of `$Argument: $Argument"

# Create a TEMP directory if one does not already exist
if (!(Test-Path -Path $LocalDirectory -ErrorAction SilentlyContinue)) {
    # Creates the directory
    New-Item -ItemType Directory -Path $LocalDirectory -Force -Verbose
}

# Download msi to the Local Directory and rename it
Invoke-WebRequest -Uri $PublicUrl -OutFile $LocalFile -Verbose

# Runs the installer with the appropriate flags to wait for install.
Start-Process msiexec.exe -Wait -ArgumentList $Argument -Verbose

# Remove Installer
Remove-Item -Path $LocalFile -Verbose

# Remove Directory (if it's empty)
if ((Get-ChildItem -Path $LocalDirectory).Count -eq 0) {
    # Directory Is Empty
    Remove-Item -Path $LocalDirectory -Verbose
}
