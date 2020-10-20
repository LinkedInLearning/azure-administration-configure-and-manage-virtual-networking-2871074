#Peer Networks

#Variables 
$rgName1='Dev_Canada_East'
$location1='Canada East'

$rgName2='Dev_Canada_Central'
$location2='Canada Central'


#Create a resource groups.
New-AzResourceGroup -Name $rgName1  -Location $location1
New-AzResourceGroup -Name $rgName2  -Location $location2

# Create VNet 1
$vnet1 = New-AzVirtualNetwork -ResourceGroupName $rgName1 `
-Name 'Vnet1' `
-AddressPrefix '10.0.0.0/16' `
-Location $location1

#Create VNet 2
$vnet2 = New-AzVirtualNetwork -ResourceGroupName $rgName2 `
-Name 'Vnet2' `
-AddressPrefix '10.1.0.0/16' `
-Location $location2

#Peer VNet1 to VNet2.
Add-AzVirtualNetworkPeering -Name 'CAToCE' `
-VirtualNetwork $vnet1 `
-RemoteVirtualNetworkId $vnet2.Id

#Peer VNet2 to VNet1.
Add-AzVirtualNetworkPeering -Name 'CEtoCA' `
-VirtualNetwork $vnet2 `
-RemoteVirtualNetworkId $vnet1.Id

#View the connection
Get-AzVirtualNetworkPeering -Name "*" -VirtualNetwork "Vnet1" -ResourceGroupName $RGName1 

#Remove the Resource Group
Remove-AzResourceGroup -Name $rgname1 -Force
Remove-AzResourceGroup -Name $rgname2 -Force