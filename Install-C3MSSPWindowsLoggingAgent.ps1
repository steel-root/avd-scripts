#description: Downloads & installs the C3 MSSP Windows logging agent
#execution mode: Individual
#tags: MSSP

<#
  .SYNOPSIS
    Downloads & installs the C3 MSSP Windows logging agent

  .DESCRIPTION
    This script runs the C3 MSSP Windows logging agent installer on a session host in AVD. Be sure to update the msspClientId variable. 
    If updating the installer, be sure to use the same filename & public URL.

  .NOTES
    Company:  C3 Integrated Solutions, LLC.
    Website:  c3isit.com
    Created:  2024-09-05
    Modified: 2024-09-05

  #! WARNING! Secure variables must be defined in Nerdio to use this script correctly.
  In Nerdio, define values for:
  - InstallersURL
  - msspClientId
#>

$ProgressPreference = "SilentlyContinue"

#Link to publicly available .msi
$PublicUrl = "$($SecureVars.InstallersURL)/IngallsWindowsLoggingAgent.msi"

#Local directory to keep the installer
$LocalDirectory = 'C:\Temp\'

#Local Directory + the filename obtained from the URL 
$LocalFile ="$LocalDirectory"+ ($PublicUrl.split("/") | Select-Object -Last 1)

#Stores arguments/parameters for msiexec command.
$Argument = "/i $LocalFile /qn LICENSE_KEY=$($SecureVars.msspClientId) LOG_TIME="1""

Write-Host "Current value of `$Argument: $Argument"

# Create a TEMP directory if one does not already exist
if (!(Test-Path -Path '$LocalDirectory' -ErrorAction SilentlyContinue)) {
    #Creates the directory
    New-Item -ItemType Directory -Path $LocalDirectory -Force -Verbose
}

#Download msi to the Local Directory
Invoke-WebRequest -Uri $PublicUrl -OutFile $LocalFile -Verbose

#Runs the installer with the appropriate flags to wait for install.
& Start-Process msiexec.exe -Wait -ArgumentList $Argument -Verbose

#Wait for installer to finish
Start-Sleep -Seconds 30 -Verbose

#Remove Installer
Remove-Item -Path $LocalFile -Verbose

#Remove Directory (if it's empty)
if ((Get-ChildItem -Path $LocalDirectory).count -eq 0){
    #Directory Is Empty
    Remove-Item -Path $LocalDirectory -Verbose
}
