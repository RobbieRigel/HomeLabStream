#
# DSC_KeepPDCOn.ps1
#
Configuration KeepPDCRunning
{

	Import-DscResource -ModuleName xHyper-V

	Node 'Orion'
	{
		xVMHyperV ThePDC {
			Name = "BWORLD-DC-03"
			VhdPath = "C:\SSDVHDs\BWORLD-DC-03_OS.vhdx"
			State = "Running"
			Ensure = "Present"
			
		}
	}

}