#Create a Virtual Network

#Variables
$RG='VNet_PS'
$Location = 'CanadaCentral'
$VNetName = 'VNet1'

#Create a new resource group
New-AzResourceGroup -Name $RG -Location $Location

#Create the virtual network
$virtualNetwork = New-AzVirtualNetwork `
  -ResourceGroupName $RG `
  -Location $Location `
  -Name $VNetName `
  -AddressPrefix 10.7.0.0/16

#Create the subnet

 Add-AzVirtualNetworkSubnetConfig `
  -Name FrontEnd `
  -AddressPrefix 10.7.0.0/24 `
  -VirtualNetwork $virtualNetwork
  
#Associate subnet to virtual network
  
  $virtualNetwork | Set-AzVirtualNetwork

#View 
Get-AzVirtualNetwork -Name $VNetName -ResourceGroupName $RG