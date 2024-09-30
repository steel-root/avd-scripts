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
    Modified: 2024-09-03

  #! WARNING! Secure variables must be defined in Nerdio to use this script correctly.
    In Nerdio, define values for:
    - InstallersURL
    - CrowdstrikeId
#>

$ProgressPreference = "SilentlyContinue"

#Link to publicly available .exe
$PublicUrl = "$($SecureVars.InstallersURL)/WindowsSensor-Gov.exe"

#Local directory to keep the installer
$LocalDirectory = 'C:\Temp\'

#Local Directory + the filename obtained from the URL 
$LocalFile ="$LocalDirectory"+ ($PublicUrl.split("/") | Select-Object -Last 1)

# Create a TEMP directory if one does not already exist
if (!(Test-Path -Path '$LocalDirectory' -ErrorAction SilentlyContinue)) {
    #Creates the directory
    New-Item -ItemType Directory -Path $LocalDirectory -Force -Verbose
}

#Download Sensor to the Local Directory
Invoke-WebRequest -Uri $PublicUrl -OutFile $LocalFile -Verbose

# Is the Service already running? If so, skip the installer.
if (!(Get-Service -Name 'CSFalconService' -ErrorAction SilentlyContinue)) {

    #Runs the installer with the appropriate flags. VDI=1 uses the fqdn of the host. For Images, replace with NO_START=1
    & $LocalFile /install /quiet /norestart CID=$($SecureVars.CrowdstrikeId) VDI=1
}

#Remove Installer
Remove-Item -Path $LocalFile

#Remove Directory (if it's empty)
if ((Get-ChildItem -Path $LocalDirectory).count -eq 0){
    #Directory Is Empty
    Remove-Item -Path $LocalDirectory -Verbose
}
