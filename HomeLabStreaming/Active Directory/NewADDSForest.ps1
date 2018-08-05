#
# Stream Date:
# Video URL:
# Subjet: Creating a Windows 2016 Active Directory Forest from scratch. 
# 
# NOTE: This server needs to have the ADDS role installed prior to execution. 


$windowsFeatureList = "C:\serverFeatures.txt"
Start-Job -Name addingServerFeatures -ScriptBlock {
	Add-WindowsFeature -Name "AD-Domain-Services" -IncludeAllSubFeature -IncludeManagementTools
	Add-WindowsFeature -Name "dns" -IncludeAllSubFeature -IncludeManagementTools}


Wait-Job addingServerFeatures
Get-WindowsFeature | Where installed >> $windowsFeatureList
