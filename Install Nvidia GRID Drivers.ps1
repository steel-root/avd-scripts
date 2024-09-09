#description: This script installs Nvidia GRID drivers stored on the image VM.
#execution mode: IndividualWithRestart
#tags: GPU

<#
  .DESCRIPTION
    Installs the Nvidia GRID drivers. This is needed if you are using an NCas_T4_V3-series and want to enable graphic functionalities similar to the NV-series
    
  .DESCRIPTION
    This script runs the Nvidia GRID driver installer on a session host in AVD. 
    The driver must be downloaded and extracted on the golden image's C drive first (C:\NVIDIA\DisplayDriver\XXX.XX\Win11_Win10-DCH_64\International). 
    https://learn.microsoft.com/en-us/azure/virtual-machines/windows/n-series-driver-setup
    
  .NOTES
    Company:  C3 Integrated Solutions
    Website:  c3isit.com
    Created:  2024-05-14
    Modified: 2024-05-14
#>

<#
  WARNING! A secure variable must be defined in Nerdio to use this script correctly.
  You will see $SecureVars.NVidiaDriverVersion in this script.
  In Nerdio it should be defined as:
  - NVidiaDriverVersion
#>

$path = "C:\NVIDIA\DisplayDriver\$($SecureVars.NVidiaDriverVersion)\Win11_Win10-DCH_64\International\setup.exe"
Start-Process $path -ArgumentList " -s"
