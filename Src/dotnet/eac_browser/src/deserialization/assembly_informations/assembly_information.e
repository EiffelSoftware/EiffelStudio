indexing
	description: "Parse file given in make and extract informations"

class
	ASSEMBLY_INFORMATION

inherit
	KL_SHARED_ARGUMENTS

	XM_CALLBACKS_FILTER_FACTORY
		export {NONE} all end

creation
	make

feature -- Initialization

	make (a_version: STRING) is
		do
			create xml_file_path.make_empty
			runtime_version := a_version
		ensure
			non_void_xml_file_path: xml_file_path /= Void
		end

	initialize (an_assembly_name: STRING) is
			-- Set `xml_file' with `an_xml_file' and create an instance of MEMBER_FILTER.
		require
			non_void_an_assembly_name: an_assembly_name /= Void
			not_empty_an_assembly_name: not an_assembly_name.is_empty
		local
			retried: BOOLEAN
			l_xml_file: KL_BINARY_INPUT_FILE
			l_parser: XM_EIFFEL_PARSER
		do
			if not retried and then not Member_parser_table.has (an_assembly_name) then
				create member_parser.make
				xml_file_path := path_to_assembly (an_assembly_name)
				create l_xml_file.make (xml_file_path)
				l_xml_file.open_read
				if not l_xml_file.is_open_read then
					-- error
				else
					create l_parser.make
					member_parser.set_parser (l_parser)
					l_parser.set_callbacks (standard_callbacks_pipe (<<member_parser>>))
					l_parser.parse_from_stream (l_xml_file)
					l_xml_file.close
					check
						ok_parsing: l_parser.is_correct
					end
				end
				Member_parser_table.put (member_parser, an_assembly_name)
				initialized := True
			elseif not Member_parser_table.has (an_assembly_name) then
				Member_parser_table.put (Void, an_assembly_name)
				initialized := True
			end
		ensure
--			xml_file_path_set: xml_file_path = path_to_assembly (an_assembly_name)
--			Member_parser_table_set: Member_parser_table.has (an_assembly_name)
		rescue
			initialized := False
			retried := True
			retry
		end

feature {NONE} -- Access
	
	initialized: BOOLEAN
			-- Did Current initialize correctly?

	member_parser_table: HASH_TABLE [MEMBER_FILTER, STRING] is
			-- Caching member_parser already calculated.
		once
			create Result.make (20)
		ensure
			non_void_result: Result /= Void
		end

	member_parser: MEMBER_FILTER
			-- Current member parser.

	xml_file_path: STRING
			-- Path to current xml document.

	runtime_version: STRING
			-- Runtime version where we look for XML documentation associated to Microsoft assemblies.

feature -- Basic Operations

	find_type (assembly_type_name: STRING; a_full_dotnet_type: STRING): MEMBER_INFORMATION is
			-- Find comments relative to `a_full_dotnet_type'.
		require
			non_void_assembly_type_name: assembly_type_name /= Void
			not_empty_assembly_type_name: not assembly_type_name.is_empty
			non_void_a_full_dotnet_type: a_full_dotnet_type /= Void
			not_empty_a_full_dotnet_type: not a_full_dotnet_type.is_empty
		local
			l_full_dotnet_type: STRING
		do
			if not Member_parser_table.has (assembly_type_name) then
				initialize (assembly_type_name)
			else
				xml_file_path := path_to_assembly (assembly_type_name)
				member_parser := Member_parser_table.item (assembly_type_name)
			end
			if not xml_file_path.is_empty and member_parser /= Void then
				create l_full_dotnet_type.make_from_string (a_full_dotnet_type)
				if l_full_dotnet_type.has ('+') then
						-- Replace '+' by '.' for nested types.
					l_full_dotnet_type.replace_substring_all ("+", ".")
				end
				Result := find_member (l_full_dotnet_type, "")
			end
		end

	find_feature (assembly_type_name: STRING; a_full_dotnet_type: STRING; a_member_signature: STRING): MEMBER_INFORMATION is
			-- Find comments of feature of `a_full_dotnet_type' corresponding to `a_feature_signature'.
			-- Constructor signature: #ctor[(TYPE,TYPE,...)]
			-- Feature signature: feature_name[(TYPE,TYPE,...)]
			-- Attribute signature: attribute_name
		require
			non_void_assembly_type_name: assembly_type_name /= Void
			not_empty_assembly_type_name: not assembly_type_name.is_empty
			not_empty_a_full_dotnet_type: not a_full_dotnet_type.is_empty
			non_void_a_member_signature: a_member_signature /= Void
			not_empty_a_member_signature: not a_member_signature.is_empty
			valid_dotnet_signature: is_valid_dotnet_signature (a_member_signature)
		local
			l_full_dotnet_type: STRING
			retried: BOOLEAN
		do
			if not retried then
				if not Member_parser_table.has (assembly_type_name) then
					initialize (assembly_type_name)
				else
					xml_file_path := path_to_assembly (assembly_type_name)
					member_parser := Member_parser_table.item (assembly_type_name)
					initialized := True
				end
				if initialized then
					create l_full_dotnet_type.make_from_string (a_full_dotnet_type)
					if l_full_dotnet_type.has ('+') then
							-- Replace '+' by '.' for nested types.
						l_full_dotnet_type.replace_substring_all ("+", ".")
					end
					Result := find_member (l_full_dotnet_type, a_member_signature)
				end
			end
		rescue
			retried := True
			retry
		end

	path_to_assembly (an_assembly_name: STRING): STRING is
			-- path to assembly.
		require
			non_void_an_assembly_name: an_assembly_name /= Void
			not_empty_an_assembly_name: not an_assembly_name.is_empty
		local
			l_file_name: FILE_NAME
		do
			create l_file_name.make_from_string ((create {IL_ENVIRONMENT}.make (runtime_version)).dotnet_framework_path)
			l_file_name.set_file_name (an_assembly_name)
			l_file_name.add_extension ("xml")
			Result := l_file_name
		ensure
			non_void_result: Result /= Void
		end

feature -- Status Setting

	is_valid_dotnet_signature (a_feature_signature: STRING): BOOLEAN is
			-- Is `a_feature_signature' correct?
		require
			non_void_a_feature_signature: a_feature_signature /= Void
			not_empty_a_feature_signature: not a_feature_signature.is_empty
		local
			l_index: INTEGER
			l_parameters: STRING
			l_feature_name: STRING
		do
			if a_feature_signature.has (' ') then
				Result := False
			else
				l_index := a_feature_signature.index_of ('(', 1)
				if l_index = 0 then
					l_feature_name := clone (a_feature_signature)
					create l_parameters.make_empty
				else
					l_feature_name := clone (a_feature_signature)
					l_feature_name.keep_head (l_index - 1)
					l_parameters := clone (a_feature_signature)
					l_parameters.keep_tail (a_feature_signature.count - l_index + 1)
				end
				if is_valid_feature_name (l_feature_name) and then is_valid_parameters (l_parameters) then
					Result := True
				end
			end			
		end

feature {NONE} -- Status Setting

	is_valid_feature_name (a_feature_name: STRING): BOOLEAN is
			-- Is `a_feature_name' valid?
		require
			non_void_a_feature_name: a_feature_name /= Void
			not_empty_a_feature_name: not a_feature_name.is_empty
		do
			if a_feature_name.has (' ') or a_feature_name.has ('.') or a_feature_name.has (')') then
				Result := False
			else
				Result := True
			end
		end

	is_valid_parameters (parameters: STRING): BOOLEAN is
			-- Is `parameters' has a valid format?
			--| Rules : if empty return True.
			--|			else
			--|				must start and finish with '(' and ')' and must contain something between parantheses.
		require
			non_void_parameters: parameters /= Void
		do
			if parameters.is_empty then
				Result := True
			else
				if parameters.has (' ') or parameters.has (';') then
					Result := False
				else
					if parameters.item (1).is_equal ('(') and parameters.item (parameters.count).is_equal (')') then
						if parameters.count > 2 then
							Result := True
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	find_member (a_full_dotnet_type: STRING; a_member_signature: STRING): MEMBER_INFORMATION is
			-- Find comments of feature of `a_full_dotnet_type' corresponding to `a_member_signature'.
		require
			non_void_a_full_dotnet_type: a_full_dotnet_type /= Void
			not_empty_a_full_dotnet_type: not a_full_dotnet_type.is_empty
			non_void_a_member_signature: a_member_signature /= Void
--			not_empty_a_member_signature: not a_member_signature.is_empty
			valid_dotnet_signature: is_valid_dotnet_signature (a_member_signature)
		local
			l_feature_filter: FEATURE_FILTER
			f: RAW_FILE
			l_last_str: STRING
			l_key_member: STRING
			l_parser: XM_EIFFEL_PARSER
		do
			if a_member_signature.is_empty then
				l_key_member := a_full_dotnet_type
			else
				l_key_member := a_full_dotnet_type + "." + a_member_signature
			end
			if member_parser.Xml_members.has (l_key_member) then
				create f.make_open_read (xml_file_path)

				f.go (member_parser.Xml_members.item (l_key_member).pos_in_file)
				f.read_stream (member_parser.Xml_members.item (l_key_member).number_of_char)
				if f.last_string /= Void then
					l_last_str := f.last_string
					l_last_str.prepend ("<THE_MEMBER>")
					l_last_str.append ("%N</THE_MEMBER>%N")
					--l_last_str.replace_substring_all ("%R%N", "%N")

					create l_parser.make
					create l_feature_filter.make
					l_parser.set_callbacks (callbacks_pipe (<<l_feature_filter>>))
					l_parser.parse_from_string (l_last_str)
					check
						ok_parsing: l_parser.is_correct
					end
					if l_feature_filter.A_member.name.is_equal (l_key_member) then
						Result := l_feature_filter.A_member
					end
				end
			end
		end

invariant
	non_void_xml_file_path: xml_file_path /= Void

end -- class ASSEMBLY_INFORMATION
