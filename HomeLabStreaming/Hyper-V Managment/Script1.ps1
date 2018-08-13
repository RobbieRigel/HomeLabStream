#
# Stream Date:
# Video URL:
# Subjet: Setting some advanced VM options 
#  
# 
#


$VMtoChange = "BWORLD-DC-02"

$DC02IP4Address = "192.168.1.31"
$DC02IP6Address = "2600:1700:6460:40F0::31"
$DC01IP4Address = "192.168.1.30"
$DC01IP6Address = "2600:1700:6460:40F0::30"
$NetAdapter = (Get-NetAdapter).ifIndex
New-NetIPAddress -ifIndex $NetAdapter -IPAddress $DC02IP4Address -PrefixLength 24 -DefaultGateway "192.168.1.254" -AddressFamily IPv4
New-NetIPAddress -ifIndex $NetAdapter -IPAddress $DC02IP6Address -PrefixLength 48 -AddressFamily IPv6
Set-DnsClientServerAddress -InterfaceIndex $NetAdapter -ServerAddresses $DC01IP4Address
Set-DnsClientServerAddress -InterfaceIndex $NetAdapter -ServerAddresses $DC01IP6Address





