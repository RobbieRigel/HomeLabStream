#
# HyperV_DSCData.psd1
#
@{
	AllNodes = 
	@(
		@{
			NodeName = "BWORLD-MGT-01"
			Role= "Managment Desktop"
			Application = "Veeam"
		},

		@{
			NodeName = "Orion"
			Role = "Hyper-V Host"
			Application = "Hyper-V"

		}
		@{
			NodeName = "BWORLD-BU-01"
			Role = "Backup Server"
			Application = "Veeam"
		}
		@{
			NodeName = "BWORLD-IIS-01"
			Role = "DSC Pull Server"
			Application = "DSC"
		}

	)

}