#Create a Virtual Network

#Variables
$RG='SolutionPS'
$Location = 'CanadaCentral'
$VNetName = 'VNet'

#Create a new resource group
New-AzResourceGroup -Name $RG -Location $Location

#Create the virtual network
$virtualNetwork = New-AzVirtualNetwork `
  -ResourceGroupName $RG `
  -Location $Location `
  -Name $VNetName `
  -AddressPrefix 10.5.0.0/16

#Create the subnets

Add-AzVirtualNetworkSubnetConfig `
  -Name Subnet1 `
  -AddressPrefix 10.5.0.0/24 `
  -VirtualNetwork $virtualNetwork

Add-AzVirtualNetworkSubnetConfig `
  -Name Subnet2 `
  -AddressPrefix 10.5.1.0/24 `
  -VirtualNetwork $virtualNetwork

#Associate subnets to virtual network
  
  $virtualNetwork | Set-AzVirtualNetwork  


#Delete the Vnet
Remove-AzVirtualNetwork -Name $VNetName `
-ResourceGroupName $RG 
