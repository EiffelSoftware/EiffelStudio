indexing
	description: "Provides useful transformations."
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	CONVERSION_SUPPORT

inherit
	SUPPORT_SUPPORT
	ASSEMBLY_NAME_DECODER
	
feature -- Access

	assembly_descriptor_from_name (an_assembly_name: ASSEMBLY_NAME): ASSEMBLY_DESCRIPTOR is 
		indexing
			description: "Assembly descriptor corresponding to `an_assembly_name'"
		require
			non_void_assembly_name: an_assembly_name /= Void
			non_void_name: an_assembly_name.get_name /= Void
			non_void_version: an_assembly_name.get_version /= Void
		local
				-- all strings are to be component strings
			assembly_info: ARRAY [STRING]
			a_name: STRING
			a_version: STRING
			a_culture: STRING
			a_public_key: STRING
			retried: BOOLEAN
		do
			if not retried then
				assembly_info := assembly_info_from_name (an_assembly_name)
				if assembly_info /= Void and then assembly_info.count = 4 then
					a_name ?= assembly_info.item (0)
					a_version ?= assembly_info.item (1)
					a_culture ?= assembly_info.item (2)
					a_public_key ?= assembly_info.item (3)
					if a_name /= Void and a_version /= Void and a_culture /= Void and a_public_key /= Void then
						create Result.make (a_name, a_version, a_culture, a_public_key)	
					end				
				end
			end
		ensure
			non_void_assembly_descriptor: Result /= Void
		rescue
			retried := True
			retry
		end

	assembly_name_from_descriptor (a_descriptor: ASSEMBLY_DESCRIPTOR): ASSEMBLY_NAME is
		indexing
			description: "Assembly name corresponding to `a_descriptor'"
		require
			non_void_descriptor: a_descriptor /= Void
		local
			version: VERSION
			culture: CULTURE_INFO
			public_key: ARRAY [INTEGER_8]
			retried: BOOLEAN
			i: INTEGER
			item: INTEGER_8
			key_code: STRING
			key_count: INTEGER
			divisor: INTEGER
			string: STRING
		do
			string := a_descriptor.name
			create Result.make
			Result.set_Name (a_descriptor.name.to_cil)
			create version.make_3 (a_descriptor.version.to_cil)
			Result.set_Version (version)
			if not a_descriptor.culture.is_equal (Neutral_culture) then
				create culture.make (a_descriptor.culture.to_cil)
			else
				create culture.make (Empty_string.to_cil)
			end
			Result.set_Culture_Info (culture)
			if not retried then
				divisor := 2
				key_count := (a_descriptor.public_key.count // divisor)
				from
					i := 0
					create public_key.make (0, key_count - 1)
				until
					i = key_count
				loop
					key_code := a_descriptor.public_key.substring ( (i * divisor) + 1,  (i * divisor) + divisor  )
					item := item.parse_string_number_styles ( key_code.to_cil, feature {NUMBER_STYLES}.hex_number )
					public_key.put (item, i)
					i := i + 1
				end
				Result.Set_Public_Key_Token (public_key.to_cil)
			end
		ensure
			non_void_assembly_name: Result /= Void
		rescue
			retried := True
			retry
		end
	
	As_keyword: STRING is "as"
		indexing
			description: "As keyword"
		end

	Space: STRING is " "
		indexing
			description: "Space"
		end

	Opening_curl_bracket: STRING is "{"
		indexing
			description: "Opening curl bracket"
		end

	Closing_curl_bracket: STRING is "}"
		indexing
			description: "Closing curl bracket"
		end
	
	rename_clause_from_text (a_text: STRING): RENAME_CLAUSE is 
		indexing
			description: "Rename clause from `a_text'"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.count > 0
		local
			source_name: STRING
			target_name: STRING
		do
			source_name := source_from_text (a_text)
			target_name := target_from_text (a_text)
			create Result
			--Result := create {IMPLEMENTATION_RENAME_CLAUSE}.make
			Result.set_source_name ( to_component_string (source_name))
			Result.set_target_name ( to_component_string (target_name))
		ensure
			rename_clause_created: Result /= Void
			non_void_source_name: Result.source_name /= Void
			not_empty_source_name: Result.source_name.count > 0
			non_void_target_name: Result.target_name /= Void
			not_empty_target_name: Result.target_name.count > 0
		end
		
	source_from_text (a_text: STRING): STRING is
		indexing
			description: "Rename clause source from `a_text'"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.count > 0
		local
			test_string: STRING
			as_index: INTEGER
		do
			test_string := Space.clone (Space)
			test_string.append (As_keyword)
			test_string.append (Space)
			as_index := a_text.substring_index (test_string, 1)
			if as_index > 0 then
				Result := a_text.substring(1, as_index)
			end
		ensure
			source_built: Result /= Void
		end 
		
	target_from_text (a_text: STRING): STRING is
		indexing
			description: "Rename clause target from `a_text'"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.count > 0
		local
			test_string: STRING
			as_index: INTEGER
		do
			test_string := Space.clone (Space)
			test_string.append (As_keyword)
			test_string.append (Space)
			as_index := a_text.substring_index (test_string, 1)
			if as_index > 0 then
				Result := a_text.substring (as_index + test_string.count, a_text.count)
			end
		ensure
			source_built: Result /= Void
		end 

	export_clause_from_text (a_text: STRING): EXPORT_CLAUSE is
		indexing
			description: "Export clause from `a_text'"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.count > 0
		local
			opening_curl_bracket_index: INTEGER
			closing_curl_bracket_index: INTEGER
			exportation_string: STRING
			comma_index: INTEGER
			
			text: STRING
		do
			--Result := create {IMPLEMENTATION_EXPORT_CLAUSE}.make1
			create Result.make
			opening_curl_bracket_index := a_text.substring_index (Opening_curl_bracket, 1)
			if opening_curl_bracket_index /= -1 then
				closing_curl_bracket_index := a_text.substring_index (Closing_curl_bracket, opening_curl_bracket_index)
				if closing_curl_bracket_index /= -1 then
					text := a_text.substring (closing_curl_bracket_index + Closing_curl_bracket.count + 1, a_text.count)
					text.right_adjust
					text.left_adjust
					Result.set_source_name ( to_component_string (text) )
					exportation_string := a_text.substring (1, closing_curl_bracket_index)
					if exportation_string.index_of (',', 1) = -1 then
						Result.add_exportation ( to_component_string (exportation_string) )
					else	
						from
						until
							exportation_string.index_of (',' , 1) = -1 
						loop
							comma_index := exportation_string.index_of (',', 1)
							Result.add_exportation ( to_component_string (exportation_string.substring (1, comma_index)) )
							exportation_string := exportation_string.substring (comma_index + 1, exportation_string.count)
							exportation_string.right_adjust
							exportation_string.left_adjust
						end
						Result.add_exportation ( to_component_string (exportation_string) )
					end
				end
			else
				Result.set_source_name (a_text)
			end
		ensure
			non_void_export_clause: Result /= Void
			non_void_source_name: Result.source_name /= Void
			not_empty_source_name: Result.source_name.count > 0
		end
		
		type_from_eiffel_class (a_eiffel_class: EIFFEL_CLASS): TYPE is
			indexing
				description: "Retrieves a Type from an Eiffel Class"
			require
				non_void_eiffel_class: a_eiffel_class /= void
				non_void_class_name: a_eiffel_class.full_external_name /= void
				non_empty_class_name: a_eiffel_class.full_external_name.count > 0
				non_void_assembly_descriptor: a_eiffel_class.assembly_descriptor /= void
			local
				assembly: ASSEMBLY
				assembly_descriptor: ASSEMBLY_DESCRIPTOR
				type: TYPE
			do
				assembly_descriptor := a_eiffel_class.assembly_descriptor
				assembly ?= assembly.load (assembly_name_from_descriptor (assembly_descriptor))
				if (assembly /= void) then
					Result ?= assembly.get_type_string (a_eiffel_class.full_external_name.to_cil)
				end
			ensure
				type_found: Result /= void
			end
			
		type_from_assembly_descriptor (a_assembly_descriptor: ASSEMBLY_DESCRIPTOR; a_type_full_external_name: STRING): TYPE is
			indexing
				description: "Retrieves a Type from an Assembly Descriptor and the a full external type name"
			require
				non_void_descriptor: a_assembly_descriptor /= void
				non_void_type_name: a_type_full_external_name /= void
				non_empty_type_name: a_type_full_external_name.count > 0
			local
				assembly: ASSEMBLY
				type: TYPE
			do
				assembly ?= assembly.load (assembly_name_from_descriptor (a_assembly_descriptor))
				if (assembly /= void) then
					Result ?= assembly.get_type_string (a_type_full_external_name.to_cil)
				end
				Result := Result
			ensure
				type_found: Result /= void
			end
		
end -- class CONVERSION_SUPPORT
