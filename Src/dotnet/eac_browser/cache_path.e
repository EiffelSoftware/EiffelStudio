indexing
	description: "Path to various EAC files"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_PATH

inherit
	COMMON_PATH

--	KEY_ENCODER
--		export
--			{NONE} all
--		end

feature {TYPE_PRINTER} -- Access

	relative_assembly_path (an_assembly: CONSUMED_ASSEMBLY): STRING is
			-- Path to folder containing `an_assembly' types relative to `Eac_path'
			-- Always return a value even if `an_assembly' in not in EAC
		require
			non_void_assembly: an_assembly /= Void
		local
			version: STRING
			culture: STRING
		do
			create Result.make (an_assembly.name.count + an_assembly.version.count + an_assembly.culture.count + an_assembly.key.count + 4)
			Result.append (an_assembly.name)
			Result.append ("-")
			version := an_assembly.version
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
			-- Always return a value even if `an_assembly' in not in EAC
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
			-- Path to file describing `t' relative to `Eac_path'
			-- Always return a value even if `t' in not in EAC
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
			non_void_path: Result /= Void
--			ends_with_xml_extention: Result.tail (4).is_equal (".xml")
		end

	absolute_type_path (assembly_relative_path: STRING; a_dotnet_type_name: STRING): STRING is
			-- Path to file describing `a_dotnet_type_name' relative to `Eac_path'
			-- Always return a value even if `t' in not in EAC
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
		ensure
			non_void_path: Result /= Void
--			ends_with_xml_extention: Result.tail (4) = (".xml")
		end

	absolute_referenced_assemblies_path (an_assembly: CONSUMED_ASSEMBLY): STRING is
			-- Path to file describing `a_dotnet_type_name' relative to `Eac_path'
			-- Always return a value even if `t' in not in EAC
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
		ensure
			non_void_path: Result /= Void
--			ends_with_xml_extention: Result.tail (4) = (".xml")
		end

feature {MAIN_WINDOW} -- Access

	absolute_info_assembly_path (an_assembly: CONSUMED_ASSEMBLY): STRING is
			-- Path to file describing `a_dotnet_type_name' relative to `Eac_path'
			-- Always return a value even if `t' in not in EAC
		require
			non_void_an_assembly: an_assembly /= Void
		local
			assembly_relative_path: STRING
		do
			assembly_relative_path := relative_assembly_path (an_assembly)
			create Result.make (Eiffel_path.count + Eac_path.count + assembly_relative_path.count + Assembly_types_file_name.count + 4)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (assembly_relative_path)
			Result.append (Assembly_types_file_name)
		ensure
			non_void_path: Result /= Void
--			ends_with_xml_extention: Result.tail (4) = (".xml")
		end

feature {NONE} -- Implementation

	Info_path: STRING is "info.xml"
			-- Path to EAC info file relative to `Eac_path'.

	Absolute_info_path: STRING is
			-- Absolute path to EAC assemblies file info
		once
			create Result.make (Eiffel_path.count + Eac_path.count + Info_path.count)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (Info_path)
		ensure
			exist: Result /= Void
--			ends_with_xml_extention: Result.tail (4) = (".xml")
		end
		
	Ise_key: STRING is "ISE_EIFFEL"
			-- Environment variable $ISE_EIFFEL

	Eac_path: STRING is "dotnet\assemblies\"
			-- EAC path relative to $ISE_EIFFEL

feature {NONE} -- Implementation

	Eiffel_path: STRING is
			-- Path to Eiffel installation
		once
--			Result := (create {EXECUTION_ENVIRONMENT}).get (Ise_key)
--			check
--				Ise_eiffel_defined: Result /= Void
--			end
--			if Result.item (Result.count) /= (create {OPERATING_ENVIRONMENT}).Directory_separator then
--				Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
--			end
			Result := "e:\eac\"
		ensure
			exist: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

end -- class CACHE_PATH
