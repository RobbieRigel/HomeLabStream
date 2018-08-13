#
# Stream Date:
# Video URL:
# Subjet: Setting some advanced VM options 
#  
# 
#


$VMtoChange = "BWORLD-DC-02"

$DC03IP4Address = "192.168.1.32"
$DC03IP6Address = " "
$DC01IP4Address = "192.168.1.30"
$DC01IP6Address = " "
$NetAdapter = (Get-NetAdapter).ifIndex
New-NetIPAddress -ifIndex $NetAdapter -IPAddress $DC03IP4Address -PrefixLength 24 -DefaultGateway "192.168.1.254" -AddressFamily IPv4
New-NetIPAddress -ifIndex $NetAdapter -IPAddress $DC03IP6Address -PrefixLength 64 -AddressFamily IPv6
Set-DnsClientServerAddress -InterfaceIndex $NetAdapter -ServerAddresses $DC01IP4Address
Set-DnsClientServerAddress -InterfaceIndex $NetAdapter -ServerAddresses $DC01IP6Address







