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

#enable the AMD GPU extension
$AMExtension = @{
    ResourceGroupName = $AzVM.ResourceGroupName
    Location           = $AzVM.Location
    VMName             = $AzureVMName
    Name               = $Type
    Publisher          = $PublisherName
    ExtensionType      = $Type
    TypeHandlerVersion = 1.1
}
Set-AzVMExtension @AMExtension
