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

	relative_assembly_path_from_consumed_assembly (ca: CONSUMED_ASSEMBLY): STRING is
			-- Path to folder containing `ca' types relative to `Eac_path'
		require
			non_void_assembly: ca /= Void
			valid_assembly: ca.key /= Void
		local
			ca_culture, ca_version: STRING
		do
			ca_culture := ca.culture
			if ca_culture.is_equal ("neutral") then
				ca_culture := ""
			end
			create ca_version.make_from_cil (ca.version.to_cil.to_string.replace_character ('.', '_'))
			create Result.make (ca.name.count + ca_version.count + ca_culture.count + ca.key.count + 4)
			Result.append (ca.name + "-" + ca_version + "-" + ca_culture)		
			-- local unsigned assemblies have no key so we will not append to directory path.
			if not ca.key.is_equal ("null") then
				Result.append ("-" + ca.key)
			end
			Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
		ensure
			non_void_path: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

	relative_assembly_path (name: ASSEMBLY_NAME): STRING is
			-- Absolute path to folder containing `name' types.
			-- Always return a value even if `name' in not in EAC
		require
			non_void_assembly: name /= Void
			valid_assembly: name.get_public_key_token /= Void
		local
			cr: CACHE_READER
			l_assemblies_info: ARRAY [CONSUMED_ASSEMBLY_INFO]
			i: INTEGER
			relative_path, l_assembly_location: STRING
		do
			create cr
			l_assemblies_info := cr.consumed_assemblies_info
			if name.code_base /= Void and then name.code_base.length > 0 then
				create l_assembly_location.make_from_cil (name.code_base)
				if l_assembly_location.substring (1, 8).is_equal ("file:///") then
					l_assembly_location.remove_head (8)
					l_assembly_location.replace_substring_all ("/", "\")
					l_assembly_location.to_lower
				end
			end
			from
				i := 1
			until
				i > l_assemblies_info.count or relative_path /= Void 
				or l_assembly_location = Void
			loop
				if l_assemblies_info.item (i).assembly.out.is_equal (create {STRING}.make_from_cil (name.full_name)) then
					if l_assemblies_info.item (i).location.is_equal (l_assembly_location) then
						relative_path := l_assemblies_info.item (i).directory
					end
				end
				i := i + 1
			end
			if relative_path = Void then
				relative_path := create_relative_assembly_path (name)
			end
			relative_path.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			Result := relative_path
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

	absolute_assembly_path_from_location (ass_location: STRING): STRING is
			-- Absolute path to folder containing `ass_location' types.
			-- Always return a value even if `ass_location' in not in EAC
		require
			non_void_location: ass_location /= Void
			not_empty_location: not ass_location.is_empty
			valid_location: feature {SYSTEM_FILE}.exists (ass_location.to_cil)
		local
			cr: CACHE_READER
			l_assemblies_info: ARRAY [CONSUMED_ASSEMBLY_INFO]
			l_assembly_directory: STRING
			i: INTEGER
		do
			create cr
			l_assemblies_info := cr.consumed_assemblies_info
			from
				i := 1
			until
				i > l_assemblies_info.count or l_assembly_directory /= Void
			loop
				if l_assemblies_info.item (i).location.is_equal (ass_location) then
					l_assembly_directory := l_assemblies_info.item (i).directory
				end
				i := i + 1
			end
			if l_assembly_directory = Void then
				l_assembly_directory := create_relative_assembly_path (feature {ASSEMBLY_NAME}.get_assembly_name (ass_location.to_cil))
			end
			check
				non_void_assembly_directory: l_assembly_directory /= Void
			end
			create Result.make (Eiffel_path.count + Eac_path.count + l_assembly_directory.count + 1)
			Result.append (Eiffel_path)
			Result.append (Eac_path)
			Result.append (l_assembly_directory)
			Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
		ensure
			non_void_path: Result /= Void
			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

	absolute_assembly_path_from_consumed_assembly (ca: CONSUMED_ASSEMBLY): STRING is
			-- Absolute path to folder containing `ca' types.
		require
			non_void_assembly: ca /= Void
			valid_assembly: ca.key /= Void
		local
			relative_path: STRING
		do
			relative_path := relative_assembly_path_from_consumed_assembly (ca)
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
			path := relative_assembly_path (t.assembly.get_name)
			type := create {STRING}.make_from_cil (t.full_name)
			create Result.make (path.count + Classes_path.count + type.count + 4)
			Result.append (path)
			Result.append (Classes_path)
			Result.append (type)
			Result.append (".xml")
		ensure
			non_void_path: Result /= Void
			ends_with_xml_extension: Result.substring_index (".xml", Result.count - 4) = Result.count - 3
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
			ends_with_xml_extension: Result.substring_index (".xml", Result.count - 4) = Result.count - 3
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
			
feature {EMITTER} -- Access
		
	internal_eiffel_path: CELL [STRING] is
			-- internal eiffel path
		once
			create Result.put (Void)
		end

feature {EMITTER} -- Element Change
	
	set_internal_eiffel_path (a_path: STRING) is
			-- set `internal_eiffel_path' to 'a_path'
		require
			not_already_set: internal_eiffel_path.item = Void
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		do
			internal_eiffel_path.put (a_path)
		end

feature {NONE} -- Implementation

	Eiffel_path: STRING is
			-- Path to Eiffel installation
		local
			retried: BOOLEAN
			l_str: SYSTEM_STRING
			l_registry_key: REGISTRY_KEY
			l_obj: SYSTEM_OBJECT
		once
			if not retried then
				if internal_eiffel_path.item = Void then
					Result := (create {EXECUTION_ENVIRONMENT}).get (Ise_key)
					if Result = Void then
						l_registry_key := feature {REGISTRY}.local_machine
						l_registry_key := l_registry_key.open_sub_key (("SOFTWARE").to_cil)
						l_registry_key := l_registry_key.open_sub_key (("ISE").to_cil)
						l_registry_key := l_registry_key.open_sub_key (("Eiffel54").to_cil)
						l_registry_key := l_registry_key.open_sub_key (("emitter").to_cil)
						l_obj := l_registry_key.get_value (Ise_key.to_cil)
						l_str ?= l_obj
						
						if l_str /= Void then
							create Result.make_from_cil (l_str)
						end
					end
					check
						Ise_eiffel_defined: Result /= Void
					end
					-- set internal eiffel path to registry key
					internal_eiffel_path.put (Result)
				else
					Result := clone (internal_eiffel_path.item)
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

	create_relative_assembly_path (name: ASSEMBLY_NAME): STRING is
			-- Path to folder containing `name' types relative to `Eac_path'
			-- Always return a value even if `name' in not in EAC
		require
			non_void_assembly: name /= Void
			--valid_assembly: name.get_public_key_token /= Void
		local
			key: STRING
			l_absolut_directoy_path: STRING
			i: INTEGER
		do
			if name.get_public_key_token /= Void then
				key := encoded_key (name.get_public_key_token)				
				create Result.make (name.name.length + name.version.to_string.length + name.culture_info.name.length + key.count + 4)
			else
				create Result.make (name.name.length + name.version.to_string.length + name.culture_info.name.length + 4)
			end
			--| FIXME IEK Refactor code so that both assembly_path functions call the same abstracted function.
	
			Result.append (create {STRING}.make_from_cil (name.name))
			Result.append ("-")
			Result.append (create {STRING}.make_from_cil (name.version.to_string.replace_character ('.', '_')))
			Result.append ("-")
			Result.append (create {STRING}.make_from_cil (name.culture_info.name))
			
			-- local unsigned assemblies will not have this attribute, and so we must test to see if it is null or not
			if key /= Void and then not key.is_empty then
				Result.append ("-")
				Result.append (key)
			end

			from
				i := 1
			until
				i = 100
			loop
				create l_absolut_directoy_path.make_from_string (Eiffel_path + Eac_path + Result + "_" + i.out)
				if not feature {SYSTEM_DIRECTORY}.exists (l_absolut_directoy_path.to_cil) then
					Result := Result + "_" + i.out
					i := 100
				else
					i := i + 1
				end
			end
		ensure
			non_void_path: Result /= Void
--			ends_with_directory_separator: Result.item (Result.count) = (create {OPERATING_ENVIRONMENT}).Directory_separator
		end

end

