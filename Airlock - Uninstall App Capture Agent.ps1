#description: Uninstalls the Airlock App Capture Agent.
#execution mode: Individual
#tags: Airlock

<#
  .NOTES
    Company:  C3 Integrated Solutions, LLC.
    Website:  c3isit.com
    Created:  2023-04-08
    Modified: 2024-09-03

  #! WARNING! Secure variables must be defined in Nerdio to use this script correctly.
  In Nerdio, define values for:
  - AirlockCaptureAgent
  - AirlockCaptureAgentFilename
#>

# Link to publicly available .msi
$PublicUrl = "$($SecureVars.AirlockCaptureAgent)"

# Local directory to keep the installer
$LocalDirectory = 'C:\Temp\'

# New filename you wish to assign to the downloaded file
$NewFileName = "$($SecureVars.AirlockCaptureAgentFilename)"

# Local Directory + the new filename
$LocalFile = Join-Path -Path $LocalDirectory -ChildPath $NewFileName

#Stores arguments/parameters for msiexec command.
$Argument = "/x $LocalFile /qn"

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
