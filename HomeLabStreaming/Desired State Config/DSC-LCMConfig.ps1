#
# DSC_LCMConfig.ps1
#
#We need to configure the Local DSC config manager to the settings we want
#We will add each computer to "All Nodes" as we online them in DSC
[DSCLocalConfigurationManager()]
configuration LCMConfig
{
    Node $AllNodes.NodeName
    {
        Settings
        {
            RefreshMode = "Pull"
			ActionAfterReboot =  'ContinueConfiguration'
			AllowModuleOverwrite = $true
			ConfigurationMode = 'ApplyAndAutoCorrect'
        }

		ConfigurationRepositoryWeb BWORLD-DSCSvr
        {
            ServerURL          = "https://BWORLD-IIS-01.ugn.bobbysworld.org:8080/PSDSCPullServer.svc" # notice it is https
            RegistrationKey    = '80f5cbd2-1bbf-45cf-8753-35d2d01c947d'
            ConfigurationNames = @('ClientConfig')
        }
		ReportServerWeb BWORLD-RptSvr
        {
            ServerURL       = "https://BWORLD-IIS-01.ugn.bobbysworld.org:8080/PSDSCPullServer.svc" # notice it is https
            RegistrationKey = '80f5cbd2-1bbf-45cf-8753-35d2d01c947d'
        }
    }
}
LCMConfig -ConfigurationData BWORLD-MasterNodes.psd1



<#$DSCConfig = 
@{
	AllNodes = 
	@(
		@{
			NodeName = "Orion"
			Role = "Hyper-V Host"
			Application = "Hyper-V"
			}
		@{
			NodeName = "BWORLD-IIS-01"
			Role = "IIS"
			Application = "DSC"
			}
		@{
			NodeName = "BWORLD-MGT-01"
			Role = "Managment"
			
		}
		@{
			NodeName = "BWORLD-BU-01"
			Role = "Backup"
		}

	)

}#>