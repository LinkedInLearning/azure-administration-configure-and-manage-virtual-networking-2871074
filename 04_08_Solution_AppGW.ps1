#Create a RG,VM,Vnet,Enable IIS 

#Variables
$ResourceGroup = "SolutionAppGW"
$Location = "CanadaCentral"
$VMName = "SolutionIIS"
$VNetName = "APGWVnet"
$SubnetName = "Frontend"

#Create a resource group
New-AzResourceGroup -Name $ResourceGroup -Location $Location

#Create the virtual network
$virtualNetwork = New-AzVirtualNetwork `
  -ResourceGroupName $RG `
  -Location $Location `
  -Name $VNetName `
  -AddressPrefix 10.7.0.0/16

#Create the subnet
Add-AzVirtualNetworkSubnetConfig `
  -Name $SubnetName `
  -AddressPrefix 10.7.0.0/24 `
  -VirtualNetwork $virtualNetwork
  
#Associate subnet to virtual network
$virtualNetwork | Set-AzVirtualNetwork

#Create a virtual machine
New-AzVm `
    -ResourceGroupName $ResourceGroup `
    -Name $vmname `
    -Location $Location `
    -VirtualNetworkName $VNetName `
    -SubnetName $SubnetName `
    -OpenPorts 80

Set-AzVMExtension `
  -ResourceGroupName $ResourceGroup `
  -ExtensionName IIS `
  -VMName $VMName `
  -Publisher Microsoft.Compute `
  -ExtensionType CustomScriptExtension `
  -TypeHandlerVersion 1.4 `
  -SettingString '{"commandToExecute":"powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $($env:computername)"}' `
  -Location $Location

