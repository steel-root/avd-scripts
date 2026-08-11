#description: Adds Edge Tracking Prevention exceptions for gstatic.com, recaptcha.net, and simplesat.io
#execution mode: Individual
#tags: C3, Edge

<#
  .SYNOPSIS
    Adds Edge Tracking Prevention exceptions via the AllowTrackingForUrls policy

  .NOTES
    Company:  C3 Integrated Solutions, LLC.
    Website:  c3isit.com
    Created:  2026-08-04
    Modified: 2026-08-04

  Notes:
  Configures SOFTWARE\Policies\Microsoft\Edge\AllowTrackingForUrls so Edge stops
  stripping cookies for these domains in third-party contexts. Was causing ZIA
  cookie-based auth to fail on survey.simplesat.io's reCAPTCHA subresource loads
  Ref: https://learn.microsoft.com/en-us/deployedge/microsoft-edge-policies/allowtrackingforurls
#>

$ErrorActionPreference = "Stop"

$PolicyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge\AllowTrackingForUrls"

$UrlsToAdd = @(
    "[*.]gstatic.com"
    "[*.]recaptcha.net"
    "[*.]simplesat.io"
)

if (!(Test-Path $PolicyPath)) {
    New-Item -Path $PolicyPath -Force | Out-Null
}

# Preserve any existing entries already configured
$Existing = Get-ItemProperty -Path $PolicyPath -ErrorAction SilentlyContinue
$ExistingValues = @()
if ($Existing) {
    $ExistingValues = $Existing.PSObject.Properties |
        Where-Object { $_.Name -match '^\d+$' } |
        Sort-Object { [int]$_.Name } |
        ForEach-Object { $_.Value }
}

$NextIndex = 1
if ($Existing) {
    $HighestIndex = $Existing.PSObject.Properties |
        Where-Object { $_.Name -match '^\d+$' } |
        ForEach-Object { [int]$_.Name } |
        Measure-Object -Maximum
    if ($HighestIndex.Count -gt 0) {
        $NextIndex = $HighestIndex.Maximum + 1
    }
}

foreach ($Url in $UrlsToAdd) {
    if ($ExistingValues -contains $Url) {
        Write-Output "Already present, skipping: $Url"
        continue
    }

    New-ItemProperty -Path $PolicyPath -Name $NextIndex -Value $Url -PropertyType String -Force | Out-Null
    Write-Output "Added [$NextIndex]: $Url"
    $NextIndex++
}

Write-Output "Current AllowTrackingForUrls values:"
Get-ItemProperty -Path $PolicyPath |
    Select-Object -Property * -ExcludeProperty PS* |
    Format-List | Out-String | Write-Output
### End Script ###
