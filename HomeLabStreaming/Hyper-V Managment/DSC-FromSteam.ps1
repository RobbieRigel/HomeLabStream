#
# DSC_KeepPDCOn.ps1
#
Configuration OrionVMConfig
{

	
	$VMInfo = Import-Csv -path "C:\ProgramData\DSC\VMInfo.csv"

	$DefualtOSVhdSize = 30GB
	Import-DscResource -ModuleName xHyper-V

	Node 'Orion'
	{
		foreach ($VM in $VMInfo){
			xVMHyperV ($VM.VMName + "CreateVM") {
				Name = $VM.VMName
				VhdPath = $VM.VHDPath
				RestartIfNeeded = $true
				Generation = 2
				ProcessorCount = $VM.ProcessorCt
				EnableGuestService = $true 
				MaximumMemory = 32GB
				StartupMemory = 1GB
				MinimumMemory = 512MB
				SecureBoot = $false
				SwitchName = "Orion-VSw-01"
				#State = "Running"
				Ensure = "Present"
				DependsOn = ("[xVHD]"+$VM.VMName+"CreateOSVHD")
				

			}

			xVHD ($VM.VMName + "CreateOSVHD") {
				Name = $VM.OSVHDName
				Path = $VM.OSVHDRoot
				Ensure = "Present"
				Generation = "VHDX"
				Type = "Dynamic"
				MaximumSizeBytes = $DefualtOSVhdSize

			}
		
			xVMProcessor ($VM.VMName + "EditVMCPU") {
				
				VMName = $VM.VMName
				HwThreadCountPerCore = $VM.ProcessorThreadCt
				DependsOn = ("[xVMHyperV]"+ $VM.VMName + "CreateVM")


			}
			
			#As a standard all Virtual DVD Drives will be at 
			#SCSI controller 0 Device 1 (OS is assumed at
			# position 0-0
			xVMDvdDrive ($VM.VMName + "AttachISO") {
				VMName = $VM.VMName
				ControllerNumber = 0
				ControllerLocation = 1
				DependsOn = ("[xVMHyperV]"+ $VM.VMName + "CreateVM")
				Path = $VM.ISOPath


			}
			
			xVHD ($VM.VMName + "OtherVHD") {
				Name = $VM.DataVHDName
				Path = $VM.OSVHDRoot
				Ensure = "Present"
				Generation = "VHDX"
				Type = "Dynamic"
				MaximumSizeBytes = $VM.DataVHDSize
				}

			#Data Hard drives will run at SCSI controller 0 position 2 (DVD at 0-1 OS at 0-0)
			xVMHardDiskDrive ($VM.VMName + "MountVHD") {

				Path = (Join-Path $VM.OSVHDRoot -ChildPath ($VM.DataVHDName + ".vhdx"))
				VMName = $VM.VMName
				ControllerNumber = 0
				ControllerLocation = 2
				ControllerType = "SCSI"
				Ensure = "Present"
				DependsOn = ("[xVHD]" + $VM.VMName + "OtherVHD")
			
			}
					
		}
	}

}


OrionVMConfig