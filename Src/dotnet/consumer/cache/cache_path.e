indexing
	description: "Path to various EAC files"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_PATH

inherit
	COMMON_PATH

	KEY_ENCODER
		export
			{NONE} all
		end
		
	CACHE_SETTINGS
		export
			{NONE} all
		end
	
feature {NONE}

	make (a_clr_version: STRING) is
			-- Create new instance of CACHE_PATH for CLR runtime version `a_clr_version'.
		require
			a_clr_version_not_void: a_clr_version /= Void
		do
			clr_version := a_clr_version
		ensure
			clr_version_set: clr_version = a_clr_version
		end
		
feature {CACHE_READER} -- Access
		
	relative_assembly_path_from_consumed_assembly (a_assembly: CONSUMED_ASSEMBLY): STRING is
			-- Path to folder containing `a_assembly' types relative to `Eac_path'
		require
			non_void_assembly: a_assembly /= Void
		do
			create Result.make (a_assembly.folder_name.count + relative_executing_env_path.count + 1)
			Result.append (relative_executing_env_path)
			Result.append (a_assembly.folder_name)
			Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
		ensure
			non_void_path: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end
		
	absolute_assembly_path_from_consumed_assembly (a_assembly: CONSUMED_ASSEMBLY): STRING is
			-- Absolute path to folder containing `a_assembly' types.
		require
			non_void_assembly: a_assembly /= Void
			valid_assembly: a_assembly.key /= Void
			non_void_clr_version: clr_version /= Void
		local
			relative_path: STRING
		do
			relative_path := relative_assembly_path_from_consumed_assembly (a_assembly)
			create Result.make (eiffel_assembly_cache_path.count + relative_path.count + 1)
			Result.append (eiffel_assembly_cache_path)
			Result.append (relative_path)
		ensure
			non_void_path: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

	absolute_assembly_mapping_path_from_consumed_assembly (a_assembly: CONSUMED_ASSEMBLY): STRING is
			-- Absolute path to folder containing `a_assembly' types.
		require
			non_void_assembly: a_assembly /= Void
			valid_assembly: a_assembly.key /= Void
			non_void_clr_version: clr_version /= Void
		local
			l_assembly_path: STRING
		do
			l_assembly_path := absolute_assembly_path_from_consumed_assembly (a_assembly)
			create Result.make (l_assembly_path.count + assembly_mapping_file_name.count + 1)
			Result.append (l_assembly_path)
			Result.append (assembly_mapping_file_name)
		ensure
			non_void_path: Result /= Void
		end

	relative_type_path (a_assembly: CONSUMED_ASSEMBLY; a_type_index: INTEGER): STRING is
			-- Path to file describing `a_type' from `a_assembly' relative to `Eac_path'
			-- Always return a value even if `a_type' in not in EAC
		require
			a_assembly_not_void: a_assembly /= Void
			a_type_index_positive: a_type_index > 0
		local
			l_path: STRING
			l_type: STRING
		do
			l_path := relative_assembly_path_from_consumed_assembly (a_assembly)
			l_type := a_type_index.out
			create Result.make (l_path.count + classes_path.count + l_type.count + 4)
			Result.append (l_path)
			Result.append (classes_path)
			Result.append (l_type)
			Result.append (".xml")
		ensure
			non_void_path: Result /= Void
			ends_with_xml_extension: Result.substring_index (".xml", Result.count - 4) = Result.count - 3
		end

	absolute_type_path (a_assembly: CONSUMED_ASSEMBLY; a_type_index: INTEGER): STRING is
			-- Path to file describing `a_type' from `a_assembly' relative to `Eac_path'
			-- Always return a value even if `a_type' in not in EAC
		require
			a_assembly_not_void: a_assembly /= Void
			a_type_index_positive: a_type_index > 0
			clr_version_not_void: clr_version /= Void
			not_clr_version_empty: not clr_version.is_empty
		local
			relative_path: STRING
		do
			relative_path := relative_type_path (a_assembly, a_type_index)
			create Result.make (eiffel_assembly_cache_path.count + relative_path.count + 1)
			Result.append (eiffel_assembly_cache_path)
			Result.append (relative_path)
		ensure
			non_void_path: Result /= Void
			ends_with_xml_extension: Result.substring_index (".xml", Result.count - 4) = Result.count - 3
		end

	info_path: STRING is "info.xml"
			-- Path to EAC info file relative to `Eac_path'.

	eiffel_assembly_cache_path: STRING is
			-- Path to versioned Eiffel Assembly Cache installation
		require
			clr_version_not_void: clr_version /= Void
			clr_version_not_empty: not clr_version.is_empty
		local
			retried: BOOLEAN
			l_str: SYSTEM_STRING
			l_registry_key: REGISTRY_KEY
			l_obj: SYSTEM_OBJECT
			l_file_info: FILE_INFO
			l_dir_sep: CHARACTER
		once
			if not retried then
				l_dir_sep := (create {OPERATING_ENVIRONMENT}).Directory_separator
				if internal_eiffel_cache_path.item = Void then
					Result := (create {EXECUTION_ENVIRONMENT}).get (Ise_key)
					if Result = Void then
						l_registry_key := feature {REGISTRY}.local_machine
						l_registry_key := l_registry_key.open_sub_key ("SOFTWARE")
						l_registry_key := l_registry_key.open_sub_key ("ISE")
						l_registry_key := l_registry_key.open_sub_key ("Eiffel56")
						
						l_obj := Current
						create l_file_info.make (l_obj.get_type.assembly.location)
						l_str := l_file_info.name.substring (0, l_file_info.name.length - 4)
						l_registry_key := l_registry_key.open_sub_key (l_str)
						if l_registry_key /= Void then
							l_obj := l_registry_key.get_value (Ise_key)
							l_str ?= l_obj
						else
							l_str := (create {EXECUTION_ENVIRONMENT}).current_working_directory
						end
						check
							l_str_not_void: l_str /= Void
						end
						Result := l_str
					end
					check
						Ise_eiffel_defined: Result /= Void
					end
					if Result.item (Result.count) /= l_dir_sep then
						Result.append_character (l_dir_sep)
					end
					Result.append (eac_path)
					
						-- set internal EAC path to registry key
					internal_eiffel_cache_path.put (Result)
				else
					Result := internal_eiffel_cache_path.item
				end
				if Result.item (Result.count) /= l_dir_sep then
					Result.append_character (l_dir_sep)
				end
			else
					-- FIXME: Manu 05/14/2002: we should raise an error here.
				io.error.put_string ("ISE_EIFFEL environment variable is not defined!%N")
			end
		ensure
			exist: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		rescue
			retried := True
			retry
		end		

	absolute_info_path: STRING is
			-- Absolute path to EAC assemblies file info
		require
			non_void_clr_version: clr_version /= Void
		once
			create Result.make (eiffel_assembly_cache_path.count + info_path.count + 1)
			Result.append (eiffel_assembly_cache_path)
			Result.append (relative_executing_env_path)
			Result.append (info_path)
		ensure
			non_void_result: Result /= Void
			valid_result: not Result.is_empty
		end
		
	ise_key: STRING is "ISE_EIFFEL"
			-- Environment variable $ISE_EIFFEL

	eac_path: STRING is "dotnet\assemblies"
			-- EAC path relative to $ISE_EIFFEL
			
	clr_version: STRING
			-- Version of runtime used to consume/read XML.

feature {EMITTER} -- Access
		
	relative_executing_env_path: STRING is
			-- retrieve relative path for execting environment
		local
			l_name: STRING
			l_dir_sep: CHARACTER
		once
			l_dir_sep := (create {OPERATING_ENVIRONMENT}).Directory_separator
			
			if conservative_mode then
				l_name := short_cache_name
			else
				l_name := cache_name
			end
			
			create Result.make (l_name.count + clr_version.count + 3)
			Result.append (l_name)
			Result.append_character (l_dir_sep)
			Result.append (clr_version)
			Result.append_character (l_dir_sep)
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end
		
		
	internal_eiffel_cache_path: CELL [STRING] is
			-- internal eiffel cache path
		once
			create Result.put (Void)
		end

feature {EMITTER} -- Element Change
	
	set_internal_eiffel_cache_path (a_path: STRING) is
			-- set `internal_eiffel_cache_path' to 'a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		do
			internal_eiffel_cache_path.put (a_path)
		end
		
end -- class CACHE_PATH

