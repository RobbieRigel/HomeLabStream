#
# DSC_CreateVM.ps1
#


#Step 1 Download the xHyper-V DSC Resouce in dev enviroment. 
#Reference: https://www.powershellgallery.com/items?q=DscResources%3A%22xVMHyperV%22
Configuration CreateManagmentVM {
	
	#Before processing any configs we need to make sure all resouces are imported
	#on the target node
	Import-DscResource -ModuleName xHyper-V
	Node $AllNodes.Where{$_.Role -eq "Hyper-V Host"}.NodeName
	{
		xVMSwitch MgmtVswitch
		{
			Name = "ORION-VSw-02"
			Type = Internal
			AllowManagementOS = $true
			Ensure = "Present"
		}
		xVHD MgmtVM_OSVHD
		{
			Name = "BWORLD-MGT-01_OS"
			Path = 'D:\VHDs'
			Ensure = "Present"
			Generation = "Vhdx"
			MaximumSizeBytes = 30GB
			Type = "Dynamic"
		}
		xVHD MgmtVM_DataVHD
		{
			Name = "BWORLD-MGT-01_Data"
			Path = 'D:\VHDs'
			Ensure = "Present"
			Generation = "Vhdx"
			MaximumSizeBytes = 10GB
			Type = "Dynamic"
		}	
		
		xVMHyperV  MgmtVM
		{
			Name = "BWORLD-MGT-01"
			VhdPath = "D:\VHDs\BWORLD-MGT-01_OS.vhdx"
			Ensure = "Present"
			Generation = 2
			ProcessorCount = 4
			StartupMemory = 4GB
			SwitchName = "Orion-VSw-01", "Orion-VSw-02"
			EnableGuestService = $true
			
			DependsOn = "[xVMSwitch]MgmtVswitch", "[xVHD]MgmtVM_OSVHD"
		}

		xVMHardDiskDrive MgmtVM_AddDataVHD
		{

			VMName = Name = "BWORLD-MGT-01"
			Path = "D:\VHDs\BWORLD-MGT-01_Data.vhdx"
			Ensure = "Present"
			DependsOn = "[xVHD]MgmtVM_DataVHD", "[xVMHyperV]MgmtVM"
		}
		xVMDvdDrive MgmtVM_DVDDrive
		{
			VMName = "BWORLD-MGT-01"
			ControllerLocation = 0
			ControllerNumber = 1
			Path = "C:\ISO\Win10EntEdu.iso"
			Ensure = "Present"
			DependsOn = "[xVMHyperV]MgmtVM"

		}



	}


}






$HyperVDSCData = 
@{
	AllNodes = 
	@(
		@{
			NodeName = "BWORLD-MGT-01"
			Role= "Managment Desktop"
		},

		@{
			NodeName = "Orion"
			Role = "Hyper-V Host"
		}

	)

}



