#
# BWORLD_MasterConfig.ps1
#

#Step 1 Download the xHyper-V DSC Resouce in dev enviroment. 
#Reference: https://www.powershellgallery.com/items?q=DscResources%3A%22xVMHyperV%22
Configuration MasterConfig {
	
	#Before processing any configs we need to make sure all resouces are imported
	#on the target node
	Import-DscResource -ModuleName xHyper-V
	Import-DscResource -ModuleName ComputerManagementDsc
	Import-DscResource -ModuleName PSDesiredStateConfiguration
	Import-DSCResource -ModuleName xPSDesiredStateConfiguration

	Node $AllNodes.Where({$_.Role -eq "Hyper-V Host"}).NodeName
	{
		WindowsFeature AddHyperV {
			Name = "Hyper-V"
			LogPath = "C:\ProgramData\DSC\"
			IncludeAllSubFeature = $true
			Ensure = "Present"
		}

	}

	Node $AllNodes.Where({$_.Role -eq "IIS"}).NodeName {
		WindowsFeature AddIIS {
			Name = "Web-Serer"
			LogPath = "C:\ProgramData\DSC\"
			IncludeAllSubFeature = $true
			Ensure = "Present"
		}
	}

	Node $AllNodes.Where({$_.Application -eq "DSC"}).NodeName {

		WindowsFeature DSCServiceFeature
		{
            Ensure = "Present"
            Name   = "DSC-Service"
        }

        <#xDscWebService PSDSCPullServer
        {
            UseSecurityBestPractices = $true
			Ensure                  = "Present"
            EndpointName            = "BWORLD-IIS-01"
            Port                    = 8080
            PhysicalPath            = "$env:SystemDrive\inetpub\PSDSCPullServer"
            CertificateThumbPrint   = $certificateThumbPrint
            ModulePath              = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules"
            ConfigurationPath       = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"
            State                   = "Started"
            DependsOn               = "[WindowsFeature]DSCServiceFeature"
            RegistrationKeyPath     = "$env:PROGRAMFILES\WindowsPowerShell\DscService"
            AcceptSelfSignedCertificates = $true
            Enable32BitAppOnWin64   = $false
        }#>

	} 
}
	MasterConfig -ConfigurationData BWORLD-MasterNodes.psd1


