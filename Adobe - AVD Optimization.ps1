#description: This script will add the registy keys provided by Adobe to roam a user's identity/licensing. It also adds keys to disable cloud storage and SharePoint integration.
#execution mode: Combined
#tags: Adobe Acrobat

<#
  .SYNOPSIS
    This script will add the registy keys provided by Adobe to roam a user's identity and licensing.
    https://www.adobe.com/devnet-docs/acrobatetk/tools/VirtualizationGuide/remotedesktopservices.html#known-issues-common-to-virtual-installs

  .DESCRIPTION
    This script will add the registry keys below for identity/license roaming.
      [HKEY_LOCAL_MACHINE\SOFTWARE\Adobe\Licensing\UserSpecificLicensing]"Enabled"="1" (REG_SZ)
      [HKEY_LOCAL_MACHINE\SOFTWARE\Adobe\Identity\UserSpecificIdentity]"Enabled"="1" (REG_SZ)
    The settings below are also adjusted.
      bUsageMeasurement - Disables sending usage data.
      bUpdater - Enables the update option.
      bPurchaseAcro - Disables the option to purchase Adobe.
      bToggleDocumentCloud - Disables Document Cloud storage.
      bToggleWebConnectors - Disables cloud storage connectors.
      bDisableSharePointFeatures - Disables Online SharePoint Access.

  .NOTES
    Company:  C3 Integrated Solutions
    Website:  c3isit.com
    Created:  2024-05-20
    Modified: 2024-05-20
#>


# Function to create registry key and value if they do not exist
function Set-RegistryValue {
    param (
        [string]$path,
        [string]$name,
        [string]$type,
        [object]$value
    )
    if (-not (Test-Path $path)) {
        New-Item -Path $path -Force
    }
    New-ItemProperty -Path $path -Name $name -PropertyType $type -Value $value -Force
}

# UserSpecificLicensing
Set-RegistryValue -path "HKLM:\SOFTWARE\Adobe\Licensing\UserSpecificLicensing" -name "Enabled" -type "String" -value "1"

# UserSpecificIdentity
Set-RegistryValue -path "HKLM:\SOFTWARE\Adobe\Identity\UserSpecificIdentity" -name "Enabled" -type "String" -value "1"

# FeatureLockDown paths
$featureLockDownPaths = @(
    "HKLM:\SOFTWARE\WOW6432Node\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown",
    "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown"
)

# Add DWORD values to FeatureLockDown paths
foreach ($path in $featureLockDownPaths) {
    Set-RegistryValue -path $path -name "bUsageMeasurement" -type "DWord" -value 0
    Set-RegistryValue -path $path -name "bUpdater" -type "DWord" -value 1
    Set-RegistryValue -path $path -name "bPurchaseAcro" -type "DWord" -value 0
}

# cServices paths
$cServicesPaths = @(
    "HKLM:\SOFTWARE\WOW6432Node\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cServices",
    "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cServices"
)

# Add DWORD values to cServices paths
foreach ($path in $cServicesPaths) {
    Set-RegistryValue -path $path -name "bToggleDocumentCloud" -type "DWord" -value 1
    Set-RegistryValue -path $path -name "bToggleWebConnectors" -type "DWord" -value 1
}

# cSharePoint paths
$cSharePointPaths = @(
    "HKLM:\SOFTWARE\WOW6432Node\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cSharePoint",
    "HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cSharePoint"
)

# Add DWORD value to cSharePoint paths
foreach ($path in $cSharePointPaths) {
    Set-RegistryValue -path $path -name "bDisableSharePointFeatures" -type "DWord" -value 1
}

Write-Host "Registry changes applied successfully."
