#
# Hyper_V_DSCData_Test.psd1
#

@{
	AllNodes = 
	@(
		@{
			NodeName = "Orion"
			Role = "Hyper-V Host"
			Application = "Hyper-V"
			VMsToCreate = 
			@(
				@{
					VMName = "BWORLD-MGT-01"
					OS = "Win10"
				},
				
				@{
					VMName = "BWORLD-BU-01"
					OS = "Server2016"
				},

				@{
					VMName = "BWORLD-IIS-01"
					OS = "Server2016"
				}
				

			)
			}
	)
	DefaultVMSettings = 
	@{
		OSVHDSize = 30GB
		DataVHDSize = 10GB


	}
}