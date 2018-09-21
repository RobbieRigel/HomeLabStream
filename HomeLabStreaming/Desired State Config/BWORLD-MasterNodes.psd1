#
# BWORLD_MasterNodes.psd1
#
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
}