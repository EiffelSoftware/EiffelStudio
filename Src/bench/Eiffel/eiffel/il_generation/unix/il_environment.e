indexing
	description: "Information about current .NET environment"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_ENVIRONMENT

feature -- Access

	dotnet_framework_path: STRING is
			-- Path to .NET Framework.
		local
		once
		end
		
	dotnet_framework_sdk_path: STRING is
			-- Path to .NET Framework SDK directory.
		once
		end
		
	Dotnet_framework_sdk_bin_path: STRING is
			-- Path to bin directory of .NET Framework SDK.
		once
		end
	
end -- class IL_ENVIRONMENT
