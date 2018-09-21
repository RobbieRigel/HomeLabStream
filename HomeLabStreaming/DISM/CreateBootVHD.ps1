#
# Reference: https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-7/gg318049(v=ws.10)
#

#We are creating the VHD in my defualt iso folder on the Hyper-V Host

Function Format-BlankVHD {
	Param([Microsoft.Vhd.Powershell.VirtualHardDisk]$VHD, [String]$VolumeLable ="New Volume") 
	Initialize-Disk $VHD.Number -PassThru | New-Partition -UseMaximumSize | Format-Volume -FileSystem NTFS
	return $Result
}


try
{
	Import-Module Hyper-V -ErrorAction Stop
}
catch 
{
	Write-Host "Hyper-V Powershell Module is required for this script" -ForegroundColor Red
	exit
}
$ISOLocation = "C:\iso\"
try
{
	$Server2016Iso = New-VHD -Path (Join-Path $ISOLocation -ChildPath "WinServer2016.vhdx") -Dynamic -SizeBytes 25GB -ErrorAction Stop 
}
catch 
{
	Write-Host "The Hyper-V role is not installed" -ForegroundColor Red
	exit
}

#We are passing through the VHD varible 
$Server2016Iso = Mount-VHD $Server2016Iso.Path -Passthru

