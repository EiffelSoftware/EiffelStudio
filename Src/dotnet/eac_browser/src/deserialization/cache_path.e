indexing
	description: "Path to various EAC files"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_PATH

inherit
	COMMON_PATH

feature -- Access

	relative_assembly_path (an_assembly: CONSUMED_ASSEMBLY): STRING is
			-- Path to folder containing `an_assembly' types relative to `Eac_path'.
			-- Always return a value even if `an_assembly' in not in EAC.
		require
			non_void_assembly: an_assembly /= Void
		local
			version: STRING
			culture: STRING
		do
			create Result.make (an_assembly.name.count + an_assembly.version.count + an_assembly.culture.count + an_assembly.key.count + 4)
			Result.append (an_assembly.name)
			Result.append ("-")
			version := clone (an_assembly.version)
			version.replace_substring_all (".", "_")
			Result.append (version)
			Result.append ("-")
			culture := an_assembly.culture
			culture.to_lower
			if not culture.is_equal ("neutral") then
				Result.append (culture)
			end
			Result.append ("-")
			Result.append (an_assembly.key)
			Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
		ensure
			non_void_path: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end
	
	absolute_assembly_path (an_assembly: CONSUMED_ASSEMBLY): STRING is
			-- Absolute path to folder containing `an_assembly' types.
			-- Always return a value even if `an_assembly' in not in EAC.
		require
			non_void_assembly: an_assembly /= Void
		local
			relative_path: STRING
		do
			relative_path := relative_assembly_path (an_assembly)
			create Result.make (Eiffel_path.count + Eac_path.count + relative_path.count + 4)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (relative_path)
		ensure
			non_void_path: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

	relative_type_path (assembly_relative_path: STRING; a_dotnet_type_name: STRING): STRING is
			-- Path to file describing `t' relative to `Eac_path'.
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
			non_void_assembly_relative_path: assembly_relative_path /= Void
			not_empty_assembly_relative_path: not assembly_relative_path.is_empty
		do
			create Result.make (assembly_relative_path.count + Classes_path.count + a_dotnet_type_name.count + 4)
			Result.append (assembly_relative_path)
			Result.append (Classes_path)
			Result.append (a_dotnet_type_name)
			Result.append (".xml")
		ensure
			non_void_result: Result /= Void
		end

	absolute_type_path (assembly_relative_path: STRING; a_dotnet_type_name: STRING): STRING is
			-- Path to file describing `a_dotnet_type_name' relative to `Eac_path'.
			-- Return Void if `a_dotnet_type_name' is not in EAC.
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
			non_void_assembly_relative_path: assembly_relative_path /= Void
			not_empty_assembly_relative_path: not assembly_relative_path.is_empty
		local
			type_relative_path: STRING
		do
			type_relative_path := relative_type_path (assembly_relative_path, a_dotnet_type_name)
			create Result.make (Eiffel_path.count + Eac_path.count + type_relative_path.count + 4)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (type_relative_path)

			if not (create {RAW_FILE}.make (Result)).exists then
				Result := Void
			end
		ensure
			valid_path: Result /= Void implies (create {RAW_FILE}.make (Result)).exists
		end

	absolute_referenced_assemblies_path (an_assembly: CONSUMED_ASSEMBLY): STRING is
			-- Path to file describing `a_dotnet_type_name' relative to `Eac_path'
			-- Return Void if `an_assembly' is not in EAC.
		require
			non_void_an_assembly: an_assembly /= Void
		local
			assembly_relative_path: STRING
		do
			assembly_relative_path := relative_assembly_path (an_assembly)
			create Result.make (Eiffel_path.count + Eac_path.count + assembly_relative_path.count + Assembly_mapping_file_name.count + 4)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (assembly_relative_path)
			Result.append (Assembly_mapping_file_name)

			if not (create {RAW_FILE}.make (Result)).exists then
				Result := Void
			end
		ensure
			valid_path: Result /= Void implies (create {RAW_FILE}.make (Result)).exists
		end

feature -- Access

	absolute_info_assembly_path (an_assembly: CONSUMED_ASSEMBLY): STRING is
			-- Path to file describing `a_dotnet_type_name' relative to `Eac_path'.
			-- Return Void if `an_assembly' is not in EAC.
		require
			non_void_an_assembly: an_assembly /= Void
		local
			assembly_relative_path: STRING
		do
			assembly_relative_path := relative_assembly_path (an_assembly)
			create Result.make (Eiffel_path.count + Eac_path.count + assembly_relative_path.count + Assembly_original_types_file_name.count + 4)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (assembly_relative_path)
			Result.append (Assembly_original_types_file_name)
			
			if not (create {RAW_FILE}.make (Result)).exists then
				create Result.make (Eiffel_path.count + Eac_path.count + assembly_relative_path.count + Assembly_types_file_name.count + 4)
				Result.append (Eiffel_path)
				Result.append (Eac_path)
				Result.append (assembly_relative_path)
				Result.append (Assembly_types_file_name)
				
				if not (create {RAW_FILE}.make (Result)).exists then
					Result := Void
				end
			end
		ensure
			valid_path: Result /= Void implies (create {RAW_FILE}.make (Result)).exists
		end
		
	absolute_info_assemblies_path: STRING is
			-- Absolute path to EAC assemblies file info.
		once
			create Result.make (Eiffel_path.count + Eac_path.count + Info_path.count)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (Info_path)

			if not (create {RAW_FILE}.make (Result)).exists then
				Result := Void
			end
		ensure
			valid_path: Result /= Void implies (create {RAW_FILE}.make (Result)).exists
		end

feature {NONE} -- Implementation

	Info_path: STRING is "info.xml"
			-- Path to EAC info file relative to `Eac_path'.
		
	Ise_eiffel_key: STRING is "ISE_EIFFEL"
			-- Environment variable $ISE_EIFFEL.

	Eac_path: STRING is "dotnet\assemblies\"
			-- EAC path relative to $ISE_EIFFEL.

	Assembly_original_types_file_name: STRING is "original_types.xml"
			-- Original file of types which lists all types in assembly.

feature {NONE} -- Implementation

	Eiffel_path: STRING is
			-- Path to Eiffel installation.
		local   
			retried: BOOLEAN
--			l_str: SYSTEM_STRING
--			l_registry_key: REGISTRY_KEY   
--			l_obj: SYSTEM_OBJECT
		once
			if not retried then   
				Result := (create {EXECUTION_ENVIRONMENT}).get (Ise_eiffel_key)
--				if Result = Void then   
--					l_registry_key := feature {REGISTRY}.local_machine   
--					l_registry_key := l_registry_key.open_sub_key (("SOFTWARE").to_cil)   
--					l_registry_key := l_registry_key.open_sub_key (("ISE").to_cil)   
--					l_registry_key := l_registry_key.open_sub_key (("Eiffel52").to_cil)   
--					l_registry_key := l_registry_key.open_sub_key (("emitter").to_cil)   
--					l_obj := l_registry_key.get_value (Ise_eiffel_key.to_cil)   
--					l_str ?= l_obj   
--
--					if l_str /= Void then   
--					 create Result.make_from_cil (l_str)   
--					end   
--				end 

				check
					Ise_eiffel_defined: Result /= Void
				end
				if Result.item (Result.count) /= (create {OPERATING_ENVIRONMENT}).Directory_separator then
					Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
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

	dotnet_framework_path: STRING is
		-- Path to .NET Framework.
		local
			p: POINTER
			path: WEL_STRING
			n, len: INTEGER
		once
			n := 1024
			-- We allocate 2 * n bytes, as `p' will hold a unicode string.
			p := p.memory_alloc (2 * n)
			if get_core_system_directory (p, n, $len) = 0 then
			create path.make_empty (len + 1)
			n := wcstombs (path.item, p, len)
			Result := path.string
		end
	end
	
feature {NONE} -- Implementation
	
	get_core_system_directory (path: POINTER; buf_size: INTEGER; filled_length: POINTER): INTEGER is
			-- Initializes a wide character `path' of size `buf_size' characters
			-- with path to .NET Framework SDK location. Number of characters set in `path'
			-- is given by `filled_length'.
		external
			"C [dllwin32 %"mscoree.dll%"] (LPWSTR, DWORD, DWORD*): BOOL"
		alias
			"GetCORSystemDirectory"
		end
	
	wcstombs (dest, source: POINTER; count: INTEGER): INTEGER is
		-- Convert a sequence of `count' of wide characters `source' to a 
		-- corresponding sequence of multibyte characters `dest'.
		external
			"C macro signature (char*, wchar_t *,size_t): EIF_INTEGER use <stdlib.h>"
		alias
			"wcstombs"
		end

end -- class CACHE_PATH
