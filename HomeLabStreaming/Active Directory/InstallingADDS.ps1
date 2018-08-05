#
# CreateNewADDSForest.ps1
#
$newADDSName = "ugn.bobbysworld.org"
$netBiosName = "BobbysWorld"
Import-Module ADDSDeployment
Install-ADDSForest -CreateDnsDelegation:$false-DatabasePath "C:\Windows\NTDS"  -DomainMode "Win2012" -DomainName $newADDSName  -DomainNetbiosName $netbiosName  -ForestMode "Win2012" -InstallDns:$true  -LogPath "C:\Windows\NTDS"  -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -Force:$true