##
# Stream Date:
# Video URL:
# Subjet: 
# 
#
#
#

$UserList = Import-Csv -Path (Join-Path $PSScriptRoot -ChildPath ADUserTemplate.csv)

foreach ($user in $UserList) {
	New-ADUser -Name $user.UserName -SamAccountName $user.SamAccountName -DisplayName $user.DisplayName -UserPrincipalName $user.UserPrincipalName

} 


