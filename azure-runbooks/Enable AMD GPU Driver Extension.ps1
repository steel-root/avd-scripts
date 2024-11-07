#description: Installs the AMD GPU Driver Extension on the Azure VM.
#tags: GPU
<# 
Notes:
This Script will install the AMD GPU Driver Extension on the Azure VM.
See MS Doc for details: https://docs.microsoft.com/en-us/azure/virtual-machines/extensions/hpccompute-amd-gpu-windows
#>

# Set Error action
$errorActionPreference = "Stop"

# Ensure context is using correct subscription
Set-AzContext -SubscriptionId $AzureSubscriptionId

# Variables
$AzVM = Get-AzVM -Name $AzureVMName -ResourceGroupName $AzureResourceGroupName
$PublisherName = "Microsoft.HpcCompute"
$Type = "AmdGpuDriverWindows"

# Get the latest major version for AMD Extension
$amdversion = ((Get-AzVMExtensionImage -Location $AzVM.Location -PublisherName $PublisherName -Type $Type).Version[-1][0..2] -join '')

# Enable the AMD GPU extension
$AMDExtension = @{
    ResourceGroupName = $AzVM.ResourceGroupName
    Location           = $AzVM.Location
    VMName             = $AzureVMName
    Name               = $Type
    Publisher          = $PublisherName
    ExtensionType      = $Type
    TypeHandlerVersion = $amdVersion
}
Set-AzVMExtension @AMDExtension
