#description: Installs the NVIDIA GPU Driver Extension and version 16.5 (538.46) of the NVIDIA GRID Driver on an Azure VM. This version is required for NVv3 and NVadsA10_v5 VMs due to a known issue.
#tags: GPU
<# 
Notes:
This Script will install the NVIDIA GPU Driver Extension and version 16.5 (538.46) of the NVIDIA GRID Driver on an Azure VM. This version is required for NVv3 and NVadsA10_v5 VMs due to a known issue.
See the URLs below for details: 
https://learn.microsoft.com/en-us/azure/virtual-machines/extensions/hpccompute-gpu-windows#known-issues
https://www.reddit.com/r/AzureVirtualDesktop/comments/1icyr3i/issues_with_nvidia_gpu_driver_in_nvads_a10_v5/
#>

# Set Error action
$errorActionPreference = "Stop"

# Ensure context is using correct subscription
Set-AzContext -SubscriptionId $AzureSubscriptionId

# Variables
$AzVM = Get-AzVM -Name $AzureVMName -ResourceGroupName $AzureResourceGroupName
$PublisherName = "Microsoft.HpcCompute"
$Type = "NvidiaGpuDriverWindows"

$GPUsettings = @'
{
    "driverVersion": "538.46"
}
'@

# Enable the NVIDIA GPU Driver Extension
$NvidiaExtension = @{
    ResourceGroupName   = $AzVM.ResourceGroupName
    Location            = $AzVM.Location
    VMName              = $AzureVMName
    Name                = $Type
    Publisher           = $PublisherName
    SettingString       = $GPUsettings
    ExtensionType       = $Type
    TypeHandlerVersion  = "1.9"
}
Set-AzVMExtension @NvidiaExtension
