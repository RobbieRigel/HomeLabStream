#
# HyperVDSC_VMConfiguration.ps1
#
#Reference: https://www.powershellgallery.com/items?q=DscResources%3A%22xVMHyperV%22
Configuration MasterVMList {
	
	#Before processing any configs we need to make sure all resouces are imported
	#on the target node
	Import-DscResource -ModuleName xHyper-V
	Node $AllNodes.Where{$_.Role -eq "Hyper-V Host"}.NodeName
	{
		

	}