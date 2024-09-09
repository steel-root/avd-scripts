#description: This script will add the registy keys provided by Adobe to use Acrobat 64-bit in read-only mode.
#execution mode: Combined
#tags: Adobe Acrobat

<#
  .SYNOPSIS
    This script will add the registy keys provided by Adobe to use Acrobat 64-bit in read-only mode.
    https://helpx.adobe.com/enterprise/kb/acrobat-64-bit-for-enterprises.html

  .DESCRIPTION
    This script will add the registry keys below 
      HKLM\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown
        “bIsSCReducedModeEnforcedEx”=dword:00000001
      HKLM\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cIPM
        “bDontShowMsgWhenViewingDoc”=dword:00000000
      

  .NOTES
    Company:  C3 Integrated Solutions
    Website:  c3isit.com
    Created:  2024-05-20
    Modified: 2024-05-20
#>

# Navigate to the registry location
$registryPath = "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown"

# Check if the path exists, if not, create it
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Add the string value bIsSCReducedModeEnforcedEx with the value 1
New-ItemProperty -Path $registryPath -Name "bIsSCReducedModeEnforcedEx" -PropertyType DWord -Value 1 -Force

# Create the cIPM key
$cipmPath = "$registryPath\cIPM"
if (-not (Test-Path $cipmPath)) {
    New-Item -Path $cipmPath -Force
}

# Add the string value bDontShowMsgWhenViewingDoc with the value 0 under the cIPM key
New-ItemProperty -Path $cipmPath -Name "bDontShowMsgWhenViewingDoc" -PropertyType DWord -Value 0 -Force

Write-Host "Registry changes applied successfully."
