indexing
	description: "Provides useful transformations."
	external_name: "ISE.Reflection.ConversionSupport"
--	attribute: create {SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE}.make_classinterfaceattribute (2) end

class
	CONVERSION_SUPPORT

inherit
	ISE_REFLECTION_CONVERT
	
feature -- Access

	assembly_descriptor_from_name (an_assembly_name: SYSTEM_REFLECTION_ASSEMBLYNAME): ISE_REFLECTION_ASSEMBLYDESCRIPTOR is 
		indexing
			description: "Assembly descriptor corresponding to `an_assembly_name'"
			external_name: "AssemblyDescriptorFromName"
		require
			non_void_assembly_name: an_assembly_name /= Void
		local
			assembly_info: ARRAY [ANY]
			a_name: STRING
			a_version: STRING
			a_culture: STRING
			a_public_key: STRING
			retried: BOOLEAN
		do
			create Result.make1
			if not retried then
				assembly_info := assembly_info_from_name (an_assembly_name)
				if assembly_info /= Void and then assembly_info.count = 4 then
					a_name ?= assembly_info.item (0)
					a_version ?= assembly_info.item (1)
					a_culture ?= assembly_info.item (2)
					a_public_key ?= assembly_info.item (3)
					if a_name /= Void and a_version /= Void and a_culture /= Void and a_public_key /= Void then
						Result.make (a_name, a_version, a_culture, a_public_key)	
					end				
				end
			end
		ensure
			non_void_assembly_descriptor: Result /= Void
		rescue
			retried := True
			retry
		end

	assembly_name_from_descriptor (a_descriptor: ISE_REFLECTION_ASSEMBLYDESCRIPTOR): SYSTEM_REFLECTION_ASSEMBLYNAME is
		indexing
			description: "Assembly name corresponding to `a_descriptor'"
			external_name: "AssemblyNameFromDescriptor"
		require
			non_void_descriptor: a_descriptor /= Void
		local
			version: SYSTEM_VERSION
			culture: SYSTEM_GLOBALIZATION_CULTUREINFO
			encoding: SYSTEM_TEXT_ASCIIENCODING
			public_key: ARRAY [INTEGER_8]
			retried: BOOLEAN
		do
			create Result.make
			Result.set_Name (a_descriptor.get_name)
			create version.make_3 (a_descriptor.get_version)
			Result.set_Version (version)
			if not a_descriptor.get_culture.equals_string (Neutral_culture) then
				create culture.make (a_descriptor.get_culture)
			else
				create culture.make (Empty_string)
			end
			Result.set_Culture_Info (culture)
			create encoding.make_asciiencoding 
			if not retried then
				public_key := encoding.Get_Bytes (a_descriptor.get_public_key)
				Result.Set_Public_Key_Token (public_key)
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
			external_name: "AsKeyword"
		end

	Space: STRING is " "
		indexing
			description: "Space"
			external_name: "Space"
		end

	Opening_curl_bracket: STRING is "{"
		indexing
			description: "Opening curl bracket"
			external_name: "OpeningCurlBracket"
		end

	Closing_curl_bracket: STRING is "}"
		indexing
			description: "Closing curl bracket"
			external_name: "ClosingCurlBracket"
		end
	
	rename_clause_from_text (a_text: STRING): ISE_REFLECTION_RENAMECLAUSE is 
		indexing
			description: "Rename clause from `a_text'"
			external_name: "RenameClauseFromText"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.get_length > 0
		local
			source_name: STRING
			target_name: STRING
		do
			source_name := source_from_text (a_text)
			target_name := target_from_text (a_text)
			create Result.make_renameclause
			Result.make (source_name)
			Result.set_target_name (target_name)
		ensure
			rename_clause_created: Result /= Void
			non_void_source_name: Result.get_source_name /= Void
			not_empty_source_name: Result.get_source_name.get_length > 0
			non_void_target_name: Result.get_target_name /= Void
			not_empty_target_name: Result.get_target_name.get_length > 0
		end
		
	source_from_text (a_text: STRING): STRING is
		indexing
			description: "Rename clause source from `a_text'"
			external_name: "SourceFromText"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.get_length > 0
		local
			test_string: STRING
			as_index: INTEGER
		do
			test_string := Space
			test_string := test_string.concat_string_string_string (test_string, As_keyword, Space)
			as_index := a_text.index_of_string_int32 (test_string, 0)
			if as_index > 0 then
				Result := a_text.substring_int32_int32 (0, as_index)
			end
		ensure
			source_built: Result /= Void
		end 
		
	target_from_text (a_text: STRING): STRING is
		indexing
			description: "Rename clause target from `a_text'"
			external_name: "TargetFromText"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.get_length > 0
		local
			test_string: STRING
			as_index: INTEGER
		do
			test_string := Space
			test_string := test_string.concat_string_string_string (test_string, As_keyword, Space)
			as_index := a_text.index_of_string_int32 (test_string, 0)
			if as_index > 0 then
				Result := a_text.substring (as_index + test_string.get_length)
			end
		ensure
			source_built: Result /= Void
		end 

	export_clause_from_text (a_text: STRING): ISE_REFLECTION_EXPORTCLAUSE is
		indexing
			description: "Export clause from `a_text'"
			external_name: "ExportClauseFromText"
		require
			non_void_text: a_text /= Void
			not_empty_text: a_text.get_length > 0
		local
			opening_curl_bracket_index: INTEGER
			closing_curl_bracket_index: INTEGER
			exportation_string: STRING
			comma_index: INTEGER
		do
			create Result.make_exportclause
			opening_curl_bracket_index := a_text.index_of_string_int32 (Opening_curl_bracket, 0)
			if opening_curl_bracket_index /= -1 then
				closing_curl_bracket_index := a_text.index_of_string_int32 (Closing_curl_bracket, opening_curl_bracket_index)
				if closing_curl_bracket_index /= -1 then
					Result.make (a_text.substring (closing_curl_bracket_index + Closing_curl_bracket.get_length + 1).trim)
					exportation_string := a_text.substring_int32_int32 (0, closing_curl_bracket_index)	
					if exportation_string.index_of_char (',') = -1 then
						Result.add_exportation (exportation_string)	
					else	
						from
						until
							exportation_string.index_of_char (',') = -1 
						loop
							comma_index := exportation_string.index_of_char (',')
							Result.add_exportation (exportation_string.substring_int32_int32 (0, comma_index))
							exportation_string := exportation_string.substring (comma_index + 1).trim
						end
						Result.add_exportation (exportation_string)	
					end
				end
			else
				Result.make (a_text)
			end
		ensure
			non_void_export_clause: Result /= Void
			non_void_source_name: Result.get_source_name /= Void
			not_empty_source_name: Result.get_source_name.get_length > 0
		end
		
end -- class CONVERSION_SUPPORT
