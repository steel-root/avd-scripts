#description: Downloads & installs the CrowdStrike installer
#execution mode: Individual
#tags: CrowdStrike

<#
  .SYNOPSIS
    Downloads & installs the crowdstrike installer
  .DESCRIPTION
    The install-crowdstrike.ps1 script runs the Crowdstrike Falcon VDI installer (VDI=1) on a session host in AVD.
  .NOTES
    Company:  C3 Integrated Solutions, LLC.
    Website:  c3isit.com
    Created:  2021-07-19
    Modified: 2026-04-07

  #! WARNING! Secure variables must be defined in Nerdio to use this script correctly.
    In Nerdio, define values for:
    - InstallersURL
    - CrowdstrikeId
#>

# Is the Service already running? If so, skip the installer.
if ((Get-Service -Name 'CSFalconService' -ErrorAction SilentlyContinue).Status -eq 'Running') {
    Write-Host "CSFalconService is running - CrowdStrike already installed. Exiting."
    exit 0
}

$ProgressPreference = "SilentlyContinue"

#Link to publicly available .exe
$PublicUrl = "$($SecureVars.InstallersURL)/WindowsSensor-Gov.exe"

#Local directory to keep the installer
$LocalDirectory = 'C:\Temp\'

#Local Directory + the filename obtained from the URL
$LocalFile ="$LocalDirectory"+ ($PublicUrl.split("/") | Select-Object -Last 1)

# Create a TEMP directory if one does not already exist
if (!(Test-Path -Path "$LocalDirectory" -ErrorAction SilentlyContinue)) {
    #Creates the directory
    Write-Host "Creating Temp folder to store installer."
    New-Item -ItemType Directory -Path $LocalDirectory -Force -Verbose
}

#Download Sensor to the Local Directory
Write-Host "Downloading CrowdStrike installer."
Invoke-WebRequest -Uri $PublicUrl -OutFile $LocalFile -Verbose

$Arguments = @(
    "/install"
    "/quiet"
    "/norestart"
    "CID=$($SecureVars.CrowdstrikeId)"
    "VDI=1"
    "GROUPING_TAGS=AVD_Host"
)

#Runs the installer with the appropriate flags. VDI=1 uses the fqdn of the host. For Images, replace with NO_START=1
Write-Host "Starting CrowdStrike installer."
Start-Process -FilePath $LocalFile -ArgumentList $Arguments -Wait -NoNewWindow

#Remove Installer
Write-Host "CrowdStrike installation script complete. Deleting installer."
Remove-Item -Path $LocalFile