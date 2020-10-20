#Create a Public DNS zone

#Variables
$RG = 'VNetDNSPS'
$ZoneName = 'yourdomainname'

#Create a new zone
New-AzDnsZone -Name "your domain name" -ResourceGroupName $RG

#Create a DNS record
New-AzDnsRecordSet -Name www `
-RecordType A `
-ZoneName $ZoneName `
-ResourceGroupName $RG `
-Ttl 3600 `
-DnsRecords (New-AzDnsRecordConfig -IPv4Address "10.10.10.10")

#View the record
Get-AzDnsRecordSet -ZoneName $ZoneName -ResourceGroupName $RG

#List name servers
Get-AzDnsRecordSet -ZoneName $ZoneName -ResourceGroupName $RG -RecordType ns

#NSLookup zonename nameserver

#Delete Public DNS
Remove-AzDnsZone -Name $ZoneName -ResourceGroupName $RG