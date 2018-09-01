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
            ActionAfterREboot = 'ContinueConfiguration'
			AllowModuleOverwrite = $true
			ConfigurationMode = 'ApplyAndAutoCorrect'
        }
    }
}
LCMConfig -ConfigurationData $HyperVDSCData



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