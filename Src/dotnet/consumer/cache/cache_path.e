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

feature {CACHE_READER} -- Access

	relative_assembly_path (name: ASSEMBLY_NAME): STRING is
			-- Path to folder containing `name' types relative to `Eac_path'
			-- Always return a value even if `name' in not in EAC
		require
			non_void_assembly: name /= Void
			valid_assembly: name.get_public_key_token /= Void
		local
			key: STRING
		do
			key := encoded_key (name.get_public_key_token)
			create Result.make (name.get_name.get_length + name.get_version.to_string.get_length + name.get_culture_info.get_name.get_length + key.count + 4)
			Result.append (create {STRING}.make_from_cil (name.get_name))
			Result.append ("-")
			Result.append (create {STRING}.make_from_cil (name.get_version.to_string.replace_char ('.', '_')))
			Result.append ("-")
			Result.append (create {STRING}.make_from_cil (name.get_culture_info.get_name))
			Result.append ("-")
			Result.append (key)
			Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
		ensure
			non_void_path: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end
	
	absolute_assembly_path (name: ASSEMBLY_NAME): STRING is
			-- Absolute path to folder containing `name' types.
			-- Always return a value even if `name' in not in EAC
		require
			non_void_assembly: name /= Void
			valid_assembly: name.get_public_key_token /= Void
		local
			relative_path: STRING
		do
			relative_path := relative_assembly_path (name)
			create Result.make (Eiffel_path.count + Eac_path.count + relative_path.count)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (relative_path)
		ensure
			non_void_path: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

	relative_type_path (t: TYPE): STRING is
			-- Path to file describing `t' relative to `Eac_path'
			-- Always return a value even if `t' in not in EAC
		require
			non_void_type: t /= Void
		local
			path, type: STRING
		do
			path := relative_assembly_path (t.get_assembly.get_name)
			type := create {STRING}.make_from_cil (t.get_full_name)
			create Result.make (path.count + Classes_path.count + type.count + 4)
			Result.append (path)
			Result.append (Classes_path)
			Result.append (type)
			Result.append (".xml")
		ensure
			non_void_path: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

	absolute_type_path (t: TYPE): STRING is
			-- Path to file describing `t' relative to `Eac_path'
			-- Always return a value even if `t' in not in EAC
		require
			non_void_type: t /= Void
		local
			relative_path: STRING
		do
			relative_path := relative_type_path (t)
			create Result.make (Eiffel_path.count + Eac_path.count + relative_path.count)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (relative_path)
		ensure
			non_void_path: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

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
		end
		
	Ise_key: STRING is "ISE_EIFFEL"
			-- Environment variable $ISE_EIFFEL

	Eac_path: STRING is "dotnet\assemblies\"
			-- EAC path relative to $ISE_EIFFEL

feature {NONE} -- Implementation

	Eiffel_path: STRING is
			-- Path to Eiffel installation
		once
			Result := (create {EXECUTION_ENVIRONMENT}).get (Ise_key)
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

end -- class CACHE_PATH
