#
# Stream Date:
# Video URL:
# Subjet: This script takes servers in a given OU installs ADDS 
# 
#
#
#This is the Distinguished Name of the OU containing the servers to promote. 
$ServersToPromoteOU = "OU= Make DC, OU=Servers, DC=ugn, DC=bobbysworld, DC=org"

#Getting an array of computers in the OU and installing ADDS services
#
$ServersToPromote = Get-ADComputer -Filter * -SearchBase $ServersToPromoteOU

if ($ServersToPromote) {
	foreach ($Server in $ServersToPromote) {

		Add-WindowsFeature -Name AD-Domain-Services -ComputerName $Server.Name
		}
	}



