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
	make, default_create
	
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

	version: STRING
			-- Currently selected version, if none `default_version'.
			
	default_version: STRING is
			-- Default runtime version if `version' was not specified.
			-- Semantic is to take `v1_0' if present, `v1_1' otherwise.
		local
			l_installed: like installed_runtimes
		do
			l_installed := installed_runtimes
			if l_installed.has (v2_0) then
				Result := v2_0.twin
			elseif l_installed.has (v1_1) then
				Result := v1_1.twin
			else
				Result := v1_0.twin
			end
		ensure
			default_version_not_void: Result /= Void
		end

	is_dotnet_installed: BOOLEAN is
			-- Is dotnet version `version' installed?
		do
			Result := installed_runtimes.has (version)
		end
		
	installed_runtimes: LINEAR [STRING] is
			-- List all installed version of the runtime.
		local
			l_runtime_path: STRING
			l_result, l_content: ARRAYED_LIST [STRING]
			l_dir: DIRECTORY
			l_file_name: FILE_NAME
			l_file: RAW_FILE
		do
			l_runtime_path := dotnet_runtime_path
			create l_result.make (5)
			if l_runtime_path /= Void then
				create l_dir.make (l_runtime_path)
				if l_dir.exists then
					l_dir.open_read
					l_content := l_dir.linear_representation
					from
						l_content.start
					until
						l_content.after
					loop
							-- Insert in `l_result' all files/directories
							-- starting with letter `v' as it is most likely
							-- to be an occurrence of an installed .NET runtime.
						if l_content.item.item (1) = 'v' then
								-- Now we check that in this directory there is a file called
								-- `mscorwks.dll' which is the Microsoft .NET engine. If there
								-- is no such file, then it might be a remaining of an old
								-- installed runtime.
							create l_file_name.make_from_string (l_runtime_path)
							l_file_name.extend (l_content.item)
							l_file_name.set_file_name ("mscorwks.dll")
							create l_file.make (l_file_name)
							if l_file.exists then
								l_result.extend (l_content.item)
							end
						end
						l_content.forth
					end
					l_dir.close
				end
			end
			l_result.compare_objects
			Result := l_result
		ensure
			installed_runtimes_not_void: Result /= Void
		end

	dotnet_framework_path: STRING is
			-- Path to .NET Framework of version `version'.
		require
			is_dotnet_installed: is_dotnet_installed
		local
			l_file_name: FILE_NAME
		do
			if dotnet_runtime_path /= Void then
				create l_file_name.make_from_string (dotnet_runtime_path)
				l_file_name.extend (version)
				Result := l_file_name
			end
		end
		
	dotnet_framework_sdk_path: STRING is
			-- Path to .NET Framework SDK directory of version `version'.
			-- Void if not installed.
		local
			reg: WEL_REGISTRY
			p: POINTER
			key: WEL_REGISTRY_KEY_VALUE
		do
			create reg
			p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\Microsoft\.NETFramework",
				feature {WEL_REGISTRY_ACCESS_MODE}.Key_read)
			if p /= default_pointer then
				check
					known_runtime: sdk_keys.has (version)
				end
				key := reg.key_value (p, sdk_keys.item (version))
				if key /= Void then
					Result := key.string_value
				end
				reg.close_key (p)		
			end
		end
		
	Dotnet_framework_sdk_bin_path: STRING is
			-- Path to bin directory of .NET Framework SDK of version `version'.
		local
			l_path: STRING
		do
			l_path := Dotnet_framework_sdk_path
			if l_path /= Void then
				Result := Dotnet_framework_sdk_path + "bin\"
			end
		end

feature -- Query
	
	use_cordbg (a_string: STRING): BOOLEAN is
			-- Should Current use cordbg.exe?
		require
			a_string_not_void: a_string /= Void
		do
			Result := a_string.is_equal ("cordbg")
		end
		
	use_dbgclr (a_string: STRING): BOOLEAN is
			-- Should Current use DbgCLR.exe?
		require
			a_string_not_void: a_string /= Void
		do
			Result := a_string.is_equal ("DbgCLR")
		end
	
	Dotnet_debugger_path (a_debug: STRING): STRING is
			-- The path to the .NET debugger associated with 'a_debug'.
		require
			a_debug_not_void: a_debug /= Void
		local
			l_path: STRING
		do
			l_path := Dotnet_framework_sdk_bin_path
			if l_path /= Void then
				if use_cordbg (a_debug) then
					Result := l_path + a_debug + ".exe"
				elseif use_dbgclr (a_debug) then
					Result := l_path + "GuiDebug\" + a_debug + ".exe"
				end
			end	
		end
		
	resource_compiler: STRING is
			-- Path to `resgen' tool from .NET Framework SDK.
		local
			l_path: STRING
		do
			l_path := dotnet_framework_sdk_bin_path
			if l_path /= Void then
				Result := l_path + "resgen.exe"
			end
		end
	
feature {NONE} -- Implementation

	sdk_keys: HASH_TABLE [STRING, STRING] is
			-- List of keys associated to each known version of the .NET runtime.
		once
			create Result.make (2)
			Result.put ("sdkInstallRoot", v1_0)
			Result.put ("sdkInstallRootv1.1", v1_1)
			Result.put ("sdkInstallRootv2.0", v2_0)
		ensure
			sdk_keys_not_void: Result /= Void
		end
		
	dotnet_runtime_path: STRING is
			-- Path to where .NET runtimes are installed. It can be a once since this value is
			-- not dependent on `version'.
		local
			reg: WEL_REGISTRY
			p: POINTER
			key: WEL_REGISTRY_KEY_VALUE
		once
			create reg
			p := reg.open_key_with_access ("hkey_local_machine\SOFTWARE\Microsoft\.NETFramework",
				feature {WEL_REGISTRY_ACCESS_MODE}.Key_read)
			if p /= default_pointer then
				key := reg.key_value (p, runtime_root_key)
				if key /= Void then
					Result := key.string_value
					if Result.item (Result.count) = Operating_environment.Directory_separator then
						Result.remove (Result.count)
					end
				end
				reg.close_key (p)
			end
		ensure
			no_ending_separator: Result /= Void implies Result.item (Result.count) /= Operating_environment.Directory_separator
		end
		
feature -- Constants

	v1_0: STRING is "v1.0.3705"
			-- Version number of v1.0 of Microsoft .NET
			
	v1_1: STRING is "v1.1.4322"
			-- Version number of v1.1 of Microsoft .NET
			
	v2_0: STRING is "v2.0.40301"
			-- Temporary version number of the v2.0 of Microsoft .NET

feature {NONE} -- Constants

	runtime_root_key: STRING is "InstallRoot"
			-- Name of key specifiying where runtimes are installed.
	
invariant
	version_not_void: version /= Void

end -- class IL_ENVIRONMENT
