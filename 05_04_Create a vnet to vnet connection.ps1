#Create a VNet to VNet Connection

#Variables
#Canada East
$RGCE = "Production_Canada_East"
$LocationCE = "CanadaEast"
$VnetCE = "CanadaEastVnet"
$GWNameCE = "CEGW"
$ConnectionName = "EastToCentral"

#Canada Central
$RGCC = "Production_Canada_Central"
$LocationCC = "CanadaCentral"
$VnetCC = "CanadaCentralVnet"
$GWNameCC = "CCGW"


#Get both VPN Gateways
$vnetce1 = Get-AzVirtualNetworkGateway -Name $GWNameCE -ResourceGroupName $RGCE
$vnetcc1 = Get-AzVirtualNetworkGateway -Name $GWNameCC -ResourceGroupName $RGCC

#Connect Canada East to Canada Central
New-AzVirtualNetworkGatewayConnection -Name $ConnectionName -ResourceGroupName $RGCE `
-VirtualNetworkGateway1 $vnetce1 -VirtualNetworkGateway2 $vnetcc1 -Location $LocationCE `
-ConnectionType Vnet2Vnet -SharedKey 'LinkedIn123!'

