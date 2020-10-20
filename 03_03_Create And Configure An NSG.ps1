#Create and configure an NSG

#Variables
$RG='VNetPS'
$Location = 'CanadaCentral'
$NSGName = 'AllowHTTP'


#Create an NSG
New-AzNetworkSecurityGroup -Name $NSGName -ResourceGroupName $RG -Location $Location

#create a Rule

New-AzNetworkSecurityRuleConfig -Name $NSGName -Description "Allow HTTP" `
    -Access Allow `
    -Protocol Tcp `
    -Direction Inbound `
    -Priority 101 `
    -SourceAddressPrefix Internet -SourcePortRange * `
    -DestinationAddressPrefix * -DestinationPortRange 80



