indexing
	description: "Common paths used in the code DOM"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_CODE_DOM_PATH

feature -- Access

	Windows_key: STRING is "SystemRoot"
			-- Environment variable

	Machine_config_path: STRING is
			-- Path to access eiffel compiler.
		once
			Result := Framework_path + "CONFIG\machine.config"
		ensure
			exist: Result /= Void
		end

	Ise_eiffel_key: STRING is "ISE_EIFFEL"
			-- Environment variable $ISE_EIFFEL.
			
	Codedom_key: STRING is "codedom"

	Windows_path: STRING is
			-- Path to windows directory.
		once
			Result := (create {EXECUTION_ENVIRONMENT}).get (Windows_key)
			check
				Ise_eiffel_defined: Result /= Void
			end
			if Result.item (Result.count) /= (create {OPERATING_ENVIRONMENT}).Directory_separator then
				Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			end
		ensure
			exist: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end
		
	Install_root_path: STRING is
			-- Absolute path to framework SDK installation root directory
		local
			l_str: SYSTEM_STRING
			l_registry_key: REGISTRY_KEY
		once
			l_registry_key := feature {REGISTRY}.local_machine
			l_registry_key := l_registry_key.open_sub_key ("SOFTWARE")
			l_registry_key := l_registry_key.open_sub_key ("Microsoft")
			l_registry_key := l_registry_key.open_sub_key (".NETFramework")
			l_str ?= l_registry_key.get_value ("InstallRoot")
			
			if l_str /= Void then
				Result := l_str
				Result := Result + "\"
			else
				Result := Windows_path + "Microsoft.NET\Framework\"
			end
		end

	Framework_path: STRING is
			-- Absolute path to currently employed framework SDK.
		local
			dir: DIRECTORY
		do
			Result := Install_root_path
			if Clr_version /= Void then
				Result := Result + Clr_version
			else
				-- Our custom Clr version hasn't been set so we find the latest framework path
				create dir.make (Result + Version_1_1)
				if dir.exists then
					Result := Result + Version_1_1
				else
					Result := Result + Version_1_0
				end
			end

			if Result.item (Result.count) /= (create {OPERATING_ENVIRONMENT}).Directory_separator then
				Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			end
		ensure
			exist: Result /= Void
		end
	
	Clr_version: STRING is
			-- Version number of the current CLR version being used
		do
			Result := Internal_clr_version.item
		ensure
			clr_version_not_void: Result /= Void
		end
		
	Version_1_0: STRING is "v1.0.3705"
	Version_1_1: STRING is "v1.1.4322"
		-- Version strings of possible framework installations
		
	Mscorlib: STRING is "mscorlib"
		-- Core assembly constant
		
	Local_cache_path: STRING is
			-- Path to Local cache
		do
			Result := Internal_local_cache_path.item.twin
			Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			Result.append (clr_version)
		ensure
			local_cache_path_not_void: Result /= Void
		end

	Path_to_eiffel_compiler: STRING is
			-- Path to access eiffel compiler.
		once
			create Result.make_from_string (Codedom_installation_path)
			Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			Result.append ("studio")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			Result.append ("spec")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			Result.append ("windows")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			Result.append ("bin")
			Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
		ensure
			exist: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

	Codedom_installation_path: STRING is
			-- Path to installed CodeDom provider
		local
			l_str: SYSTEM_STRING
			l_registry_key: REGISTRY_KEY
			l_obj: SYSTEM_OBJECT
		once
			if Result = Void then
				l_registry_key := feature {REGISTRY}.local_machine
				l_registry_key := l_registry_key.open_sub_key ("SOFTWARE")
				l_registry_key := l_registry_key.open_sub_key ("ISE")
				l_registry_key := l_registry_key.open_sub_key ("CodeDom")
				l_obj := l_registry_key.get_value (Codedom_key.to_cil)
				l_str ?= l_obj

				if l_str /= Void then
					create Result.make_from_cil (l_str)
				end
			end

			check
				Codedom_defined: Result /= Void
			end
			if Result.item (Result.count) /= (create {OPERATING_ENVIRONMENT}).Directory_separator then
				Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			end
		ensure
			exist: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

	Windows_directory: STRING is
			-- Path to Windows installation
		do
			Result := Windows_path
		ensure
			exist: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

	set_environment_variable (name, value: STRING) is
			-- Set environment variable `name' with `value'
		local
			l_name, l_value: C_STRING
			l_success: BOOLEAN
		do
			create l_name.make (name)
			create l_value.make (value)
			l_success := c_set_environment_variable (l_name.item, l_value.item)
			check
				environment_variable_set: feature {ENVIRONMENT}.expand_environment_variables (("%%name%%").to_cil).compare_to_string (value.to_cil) = 0
			end
		end
		
	load_assembly (a_file_name: SYSTEM_STRING): ASSEMBLY is
			-- Retrieve assembly corresponding to `a_file_name'.		
		require
			non_void_a_file_name: a_file_name /= Void
		local
			l_file_name: STRING
			rescued: BOOLEAN
		do
			if not rescued then
				if feature {SYSTEM_FILE}.exists (a_file_name) then
					Result := feature {ASSEMBLY}.load_from (a_file_name)
				else
					create l_file_name.make_from_cil (a_file_name)
					l_file_name.prepend (Framework_path)
					Result := feature {ASSEMBLY}.load_from (l_file_name.to_cil)
				end
				check
					non_void_assembly: Result /= Void
				end
			else
				-- Unknown path to assembly.
			end
		rescue
			(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			rescued := True
			retry
		end
		
	load_assembly_from_assembly_name (a_assembly_name: ASSEMBLY_NAME): ASSEMBLY is
			-- Retrieve assembly from `a_assembly_name'.
		require
			non_void_assembly_name: a_assembly_name /= Void
		local
			rescued: BOOLEAN
		do
			if not rescued then
				Result := feature {ASSEMBLY}.load_assembly_name (a_assembly_name)
			end
		rescue
			(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			rescued := True
			retry
		end

feature {EIFFEL_CODE_DOM_PARSER} -- Element Change
	
	set_clr_version (a_version: STRING) is
			-- set `Internal_clr_version' to 'a_version'
		require
			non_void_version: a_version /= Void
			valid_version: not a_version.is_empty
		do
			internal_clr_version.put (a_version)
		end
		
feature {EIFFEL_CODE_DOM_PROVIDER, ECDP_SHARED_DATA} -- Element Change

	set_local_cache_path (a_path: STRING) is
			-- set `Internal_local_cache_path' to 'a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		do
			internal_local_cache_path.put (a_path)
		end

feature {NONE} -- Implementation
		
	Internal_clr_version: CELL [STRING] is
			-- CLR version
		once
			create Result.put (Void)
		end
		
	Internal_local_cache_path: CELL [STRING] is
			-- CLR version
		once
			create Result.put (Void)
		end

feature -- External

	c_set_environment_variable (name, value: POINTER): BOOLEAN is
			-- Set environment variable `name' with value `value'.
			-- Return True if successful.
		external
			"C macro signature (LPCTSTR, LPCTSTR): EIF_BOOLEAN use <windows.h>"
		alias
			"SetEnvironmentVariable"
		end

end -- class ECDP_CODE_DOM_PATH

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
