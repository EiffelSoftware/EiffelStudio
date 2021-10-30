note
	description: "Parse file given in make and extract informations"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	ASSEMBLY_INFORMATION

inherit
	KL_SHARED_ARGUMENTS

	XM_CALLBACKS_FILTER_FACTORY
		export {NONE} all end

create
	make

feature -- Initialization

	make (a_version: like runtime_version)
		do
			create xml_file_path.make_empty
			runtime_version := a_version
		ensure
			non_void_xml_file_path: xml_file_path /= Void
		end

	initialize (an_assembly_name: READABLE_STRING_32)
			-- Set `xml_file' with `an_xml_file' and create an instance of MEMBER_FILTER.
		require
			non_void_an_assembly_name: an_assembly_name /= Void
			not_empty_an_assembly_name: not an_assembly_name.is_empty
		local
			retried: BOOLEAN
			l_xml_file: KL_BINARY_INPUT_FILE_32
			l_parser: XM_EIFFEL_PARSER
			l_file: RAW_FILE
			l_offset: INTEGER
			mp: like member_parser
		do
			if not retried and then not Member_parser_table.has (an_assembly_name) then
				xml_file_path := path_to_assembly_doc (an_assembly_name)

					-- get position of '<' because there could be some numbers for the encoding that are not taken into account by the positions returned by gobo
				create l_file.make_with_path (xml_file_path)
				create mp.make
				member_parser := mp
				if l_file.exists and then l_file.is_readable then
					l_file.open_read
					l_file.read_stream (5)
					l_file.close
					l_offset := l_file.last_string.index_of ('<', 1)
					if l_offset > 0 then
						mp.set_offset (l_offset - 1)
					end

					create l_xml_file.make_with_path (xml_file_path)
					l_xml_file.open_read
					create l_parser.make
					l_parser.set_string_mode_mixed
					mp.set_parser (l_parser)
					l_parser.set_callbacks (standard_callbacks_pipe (<<mp>>))
					l_parser.parse_from_stream (l_xml_file)
					l_xml_file.close
					check
						ok_parsing: l_parser.is_correct
					end
				end

				Member_parser_table.put (mp, an_assembly_name)
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

	member_parser_table: HASH_TABLE [detachable MEMBER_FILTER, READABLE_STRING_32]
			-- Caching member_parser already calculated.
		once
			create Result.make (20)
		ensure
			non_void_result: Result /= Void
		end

	member_parser: detachable MEMBER_FILTER
			-- Current member parser.

	xml_file_path: PATH
			-- Path to current xml document.

	runtime_version: detachable READABLE_STRING_32
			-- Runtime version where we look for XML documentation associated to Microsoft assemblies.

feature -- Basic Operations

	find_type (assembly_type_name, a_full_dotnet_type: READABLE_STRING_32): detachable MEMBER_INFORMATION
			-- Find comments relative to `a_full_dotnet_type'.
		require
			non_void_assembly_type_name: assembly_type_name /= Void
			not_empty_assembly_type_name: not assembly_type_name.is_empty
			non_void_a_full_dotnet_type: a_full_dotnet_type /= Void
			not_empty_a_full_dotnet_type: not a_full_dotnet_type.is_empty
		local
			l_full_dotnet_type: STRING_32
		do
			Member_parser_table.search (assembly_type_name)
			if Member_parser_table.found then
				xml_file_path := path_to_assembly_doc (assembly_type_name)
				member_parser := member_parser_table.found_item
			else
				initialize (assembly_type_name)
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

	find_feature (assembly_type_name, a_full_dotnet_type: READABLE_STRING_32; a_member_signature: STRING): detachable MEMBER_INFORMATION
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
			l_full_dotnet_type: STRING_32
			retried: BOOLEAN
		do
			if not retried then
				member_parser_table.search (assembly_type_name)
				if member_parser_table.found then
					xml_file_path := path_to_assembly_doc (assembly_type_name)
					member_parser := member_parser_table.found_item
					initialized := True
				else
					initialize (assembly_type_name)
				end
				if initialized and then attached member_parser then
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

	path_to_assembly_doc (an_assembly_name: READABLE_STRING_32): PATH
			-- Path to assembly XML file
		require
			non_void_an_assembly_name: an_assembly_name /= Void
			not_empty_an_assembly_name: not an_assembly_name.is_empty
		do
			Result := (create {IL_ENVIRONMENT}.make (runtime_version)).dotnet_framework_path.extended (an_assembly_name).appended_with_extension ("xml")
		ensure
			non_void_result: Result /= Void
		end

	path_to_assembly_dll (an_assembly_name: STRING): PATH
			-- Path to assembly
		require
			non_void_an_assembly_name: an_assembly_name /= Void
			not_empty_an_assembly_name: not an_assembly_name.is_empty
		do
			Result := (create {IL_ENVIRONMENT}.make (runtime_version)).dotnet_framework_path.extended (an_assembly_name).appended_with_extension ("dll")
		ensure
			non_void_result: Result /= Void
		end

feature -- Status Setting

	is_valid_dotnet_signature (a_feature_signature: STRING): BOOLEAN
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
					l_feature_name := a_feature_signature.twin
					create l_parameters.make_empty
				else
					l_feature_name := a_feature_signature.twin
					l_feature_name.keep_head (l_index - 1)
					l_parameters := a_feature_signature.twin
					l_parameters.keep_tail (a_feature_signature.count - l_index + 1)
				end
				if is_valid_feature_name (l_feature_name) and then is_valid_parameters (l_parameters) then
					Result := True
				end
			end
		end

feature {NONE} -- Status Setting

	is_valid_feature_name (a_feature_name: STRING): BOOLEAN
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

	is_valid_parameters (parameters: STRING): BOOLEAN
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
					if parameters.item (1) = '(' and parameters.item (parameters.count) = ')' then
						if parameters.count > 2 then
							Result := True
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	find_member (a_full_dotnet_type: STRING; a_member_signature: STRING): detachable MEMBER_INFORMATION
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
			l_xml_members: HASH_TABLE [XML_MEMBER, STRING]
			l_xml_member: XML_MEMBER
		do
			if attached member_parser as mp then
				if a_member_signature.is_empty then
					l_key_member := a_full_dotnet_type
				else
					create l_key_member.make (a_full_dotnet_type.count + a_member_signature.count + 1)
					l_key_member.append (a_full_dotnet_type)
					l_key_member.append_character ('.')
					l_key_member.append (a_member_signature)
				end
				l_xml_members := mp.Xml_members
				l_xml_members.search (l_key_member)
				if l_xml_members.found then
					create f.make_with_path (xml_file_path)
					f.open_read
					l_xml_member := l_xml_members.found_item
					f.go (l_xml_member.pos_in_file)
					f.read_stream (l_xml_member.number_of_char)
					if f.last_string /= Void then
						l_last_str := f.last_string
						l_last_str.prepend ("<THE_MEMBER>")
						l_last_str.append ("%N</THE_MEMBER>%N")

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
		end

invariant
	non_void_xml_file_path: xml_file_path /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
