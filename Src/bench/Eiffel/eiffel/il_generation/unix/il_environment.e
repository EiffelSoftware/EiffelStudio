indexing
	description: "Information about current .NET environment"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_ENVIRONMENT

feature -- Access

	is_dotnet_installed: BOOLEAN is
			-- Is dotnet installed?
		once
		end
	
	dotnet_framework_path: STRING is
			-- Path to .NET Framework.
		require
			is_dotnet_installed: is_dotnet_installed
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
		
feature -- Query
	
	use_cordbg (a_string: STRING): BOOLEAN is
			-- Should Current use cordbg.exe?
		do
		end
		
	use_dbgclr (a_string: STRING): BOOLEAN is
			-- Should Current use DbgCLR.exe?
		do
		end
	
	Dotnet_debugger_path (a_debug: STRING): STRING is
			-- The path to the .NET debugger associated with 'a_debug'.
		do
		end	
	
end -- class IL_ENVIRONMENT
