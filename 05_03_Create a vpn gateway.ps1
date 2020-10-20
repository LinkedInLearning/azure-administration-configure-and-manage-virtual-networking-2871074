#Create a VPN Gateway

#Variables
$RG = "Production_Canada_East"
$Location = "CanadaEast"
$Vnetname = "CanadaEastVnet"

#Create the GatewaySubnet

$vnet = Get-AzVirtualNetwork -ResourceGroupName $RG -Name $Vnetname

Add-AzVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -AddressPrefix 10.2.1.0/27 -VirtualNetwork $vnet
$vnet | Set-AzVirtualNetwork

#Get Public IP
$gwpip= New-AzPublicIpAddress -Name CEGWIP -ResourceGroupName $RG -Location $Location -AllocationMethod Dynamic

#Create the gateway IP address config
$vnet = Get-AzVirtualNetwork -Name $Vnetname -ResourceGroupName $RG
$subnet = Get-AzVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $vnet
$gwipconfig = New-AzVirtualNetworkGatewayIpConfig -Name gwipconfig1 -SubnetId $subnet.Id -PublicIpAddressId $gwpip.Id

#Create the VPN Gateway
New-AzVirtualNetworkGateway -Name CEGW -ResourceGroupName $RG `
-Location $Location -IpConfigurations $gwipconfig -GatewayType Vpn `
-VpnType RouteBased -GatewaySku VpnGw1