indexing
	description: "Information about current .NET environment"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_ENVIRONMENT

inherit
	ANY
		export
			{NONE} all
		redefine
			default_create
		end

create 
	make,
	default_create

feature {NONE} -- Initialization

	make (a_version: STRING) is
			-- Create an instance of IL_ENVIRONMENT targeting a specific .NET version `a_version'.
			-- If `a_version' is not specified we currently take `default_version'.
			-- Set `version' with `a_version'.
		do
			if a_version /= Void then
				version := a_version
			else
				version := default_version
			end
		ensure
			version_set: version /= Void and (a_version /= Void implies version = a_version)
		end

	default_create is
			-- Create an instance of IL_ENVIRONMENT targetting `default_version' of .NET runtime.
		do
			version := default_version
		ensure then
			version_set: version /= Void and then version.is_equal (default_version)
		end
		
feature -- Access

	default_version: STRING is
			-- Default runtime version if `version' was not specified.
			-- Semantic is to take `v1_0' if present, `v1_1' otherwise.
		do
			Result := "v1.0"
		ensure
			default_version_not_void: Result /= Void
		end

	dotnet_framework_path: STRING is
			-- Path to .NET Framework of version `version'.
		require
			is_dotnet_installed: is_dotnet_installed
		do
		end

	dotnet_framework_sdk_bin_path: STRING is
			-- Path to bin directory of .NET Framework SDK of version `version'.
		do
		end

	dotnet_framework_sdk_path: STRING is
			-- Path to .NET Framework SDK directory of version `version'.
			-- Void if not installed.
		do
		end

	installed_runtimes: LINEAR [STRING] is
			-- List all installed version of the runtime.
		do
			create {ARRAYED_LIST [STRING]} Result.make (1)
		ensure
			installed_runtimes_not_void: Result /= Void
		end

	is_dotnet_installed: BOOLEAN is
			-- Is dotnet version `version' installed?
		do
		end

	version: STRING
			-- Currently selected version, if none `default_version'.
	
feature -- Query

	use_cordbg (a_string: STRING): BOOLEAN is
			-- Should Current use cordbg.exe?
		require
			a_string_not_void: a_string /= Void
		do
		end
		
	use_dbgclr (a_string: STRING): BOOLEAN is
			-- Should Current use DbgCLR.exe?
		require
			a_string_not_void: a_string /= Void
		do
		end
	
	Dotnet_debugger_path (a_debug: STRING): STRING is
			-- The path to the .NET debugger associated with 'a_debug'.
		require
			a_debug_not_void: a_debug /= Void
		do
		end	
	
invariant
	version_not_void: version /= Void

end -- class IL_ENVIRONMENT
