#
# Stream Date: 7 AUG 2018
# Video URL: https://youtu.be/5On5-rpt9D4
# Subjet: Adding Dynamic VMs to a Hyper-V server
# 
#This script assumes the executor of has the appropriate rights to install
# Installation can occur via CIM instance or locally. 




# Importing a list of VMs to add from CSV file

$ListofVMsToCreate =  Import-Csv -Path (Join-Path $PSScriptRoot -ChildPath ListofVMsToCreate.csv)




#Adding the OS VHDs
#Reference: https://docs.microsoft.com/en-us/powershell/module/hyper-v/new-vhd?view=win10-ps

foreach ($VMsToCreate in $ListofVMsToCreate) {
	$OSVHDName = $VMsToCreate.VMName + "_OS.vhdx"
	$OSVHD = New-VHD -Path (Join-Path "C:\SSDVHDs\" -ChildPath $OSVHDName) -Dynamic -BlockSizeBytes 4MB -LogicalSectorSizeBytes 4096 -PhysicalSectorSizeBytes 4096 -ComputerName $VMsToCreate.VMHost -SizeBytes $VMsToCreate.OSVHDSize

	


#Adding the data VHDs
	$DataVHDName = $VMsToCreate.VMName + "_Data.vhdx"
	$DataVHD = New-VHD -Path (Join-Path "D:\VHDs\" -ChildPath $DataVHDName) -Dynamic -BlockSizeBytes 4194304 -LogicalSectorSizeBytes 4096 -PhysicalSectorSizeBytes 4096 -ComputerName $VMsToCreate.VMHost -SizeBytes $VMsToCreate.DataVHDSize




#Creating the VMs
#Reference: https://docs.microsoft.com/en-us/powershell/module/hyper-v/new-vm?view=win10-ps
	$VmSwitch = Get-VMSwitch
	$CreatedVM =  New-VM -Name $VMsToCreate.VMName -MemoryStartupBytes $VMsToCreate.StartupMemory  -SwitchName $VmSwitch.Name -Generation 2
	if ($CreatedVM) {
		Add-VMDvdDrive -VM $CreatedVM -Path C:\iso\en_windows_server_2016_x64_dvd_9327751.iso
		$NetAdapterName = $VMsToCreate.VMName + "-NIC-01"
		Add-VMNetworkAdapter -VM $CreatedVM -Name $NetAdapterName
		Add-VMHardDiskDrive -VM $CreatedVM -Path $OSVHD.Path 
		Add-VMHardDiskDrive -VM $CreatedVM -Path $DataVHD.Path
	}
}