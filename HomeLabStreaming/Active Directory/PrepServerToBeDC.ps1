#
# Stream Date:
# Video URL:
# Subjet: Preparing a server with ADDS services. 
# 
# Ignore these... we are going to rework them. 
$ipAddress = "192.168.1.30"
$ipPrefix = "24"
$networkGateway = "192.168.1.254"
$dnsServer = "127.0.0.1"
$networkInterface = (Get-NetAdapter).ifIndex

New-NetIPAddress -IPAddress $ipAddress -PrefixLength $ipPrefix -InterfaceIndex $networkInterface -DefaultGateway $networkGateway 
Rename-Computer -NewName "BWORLD-DC-01" -Force
$serverFeaturePath = "C:\serverFeatures.txt"
New-Item $serverFeaturePath -ItemType File -Force
$toolsToAdd = "RSAT-AD-Tools"
Add-WindowsFeature $toolsToAdd 
Get-WindowsFeature | Where installed  >> $serverFeaturePath
Restart-Computer



