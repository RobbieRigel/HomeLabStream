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
			LogPath = "C:\ProgramData\DSC\installHyperV.txt"
			IncludeAllSubFeature = $true
			Ensure = "Present"
		}

	}

	Node $AllNodes.Where({$_.Role -eq "IIS"}).NodeName {
		WindowsFeature AddIIS {
			Name = "Web-Server"
			LogPath = "C:\ProgramData\DSC\installIIS.txt"
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

		$certificateThumbPrint = '9DD77448DC3D1C21F205F75E5BDB42A24D3B72CB'
		xDscWebService PSDSCPullServer
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
        }

		File RegistrationKeyFile
        {
            Ensure          = 'Present'
            Type            = 'File'
            DestinationPath = "$env:ProgramFiles\WindowsPowerShell\DscService\RegistrationKeys.txt"
            Contents        = '80f5cbd2-1bbf-45cf-8753-35d2d01c947d'
        }

	} 
}
	MasterConfig -ConfigurationData BWORLD-MasterNodes.psd1


