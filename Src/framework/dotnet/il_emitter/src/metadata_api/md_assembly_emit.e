note
	description: "Eiffel class representation of IMetaDataAssemblyEmit"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_ASSEMBLY_EMIT

inherit
	MD_EMIT_SHARED

	REFACTORING_HELPER
		export {NONE} all end

create
	make

feature {NONE} -- Initialization

	make (a_tables: SPECIAL [MD_TABLE]; a_writer: PE_GENERATOR)
		do
			-- TODO: maybe use as parameter the instance of MD_EMIT
			tables := a_tables
			pe_writer := a_writer
		end

feature -- Access

	tables: SPECIAL [MD_TABLE]
			--  in-memory metadata tables

	--pe_writer: PE_WRITER
	pe_writer: PE_GENERATOR
			-- helper class to generate the PE file.
			--| using as a helper class to access needed features.

feature -- Access

	define_assembly_ref (assembly_name: CLI_STRING; assembly_info: MD_ASSEMBLY_INFO;
			public_key_token: MD_PUBLIC_KEY_TOKEN): INTEGER
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_info_not_void: assembly_info /= Void
		local
			l_assembly_ref_entry: PE_ASSEMBLY_REF_TABLE_ENTRY
			l_name_index: NATURAL_32
			l_public_key_or_token_index: NATURAL_32
			l_major_version: NATURAL_16
			l_minor_version: NATURAL_16
			l_build_number: NATURAL_16
			l_revision_number: NATURAL_16
		do
				-- See section II.22.5 AssemblyRef : 0x23

				-- Compute the indexes of the various strings and tokens in the metadata tables.
			l_name_index := pe_writer.hash_string (assembly_name.string_32)

				-- TODO double check the public key
				-- Clean the way to compute the index.
			l_public_key_or_token_index := hash_blob (public_key_token.item.read_array (0, public_key_token.item.count), public_key_token.item.count.to_natural_32)

				-- Extract the version information from the assembly info.
			l_major_version := assembly_info.major_version
			l_minor_version := assembly_info.minor_version
			l_build_number := assembly_info.build_number
			l_revision_number := assembly_info.revision_number

				-- TODO double check which flag we need to use.
			create l_assembly_ref_entry.make_with_data ({PE_ASSEMBLY_FLAGS}.PA_none, l_major_version, l_minor_version, l_build_number, l_revision_number, l_name_index, l_public_key_or_token_index)

				-- Add the new PE_ASSEMBLY_REF_TABLE_ENTRY instance to the metadata tables.
			pe_index := add_table_entry (l_assembly_ref_entry)
			Result := last_token.to_integer_32
		ensure
			valid_result: Result > 0
		end

feature -- Definition

	define_assembly (assembly_name: CLI_STRING; assembly_flags: INTEGER;
			assembly_info: MD_ASSEMBLY_INFO; public_key: detachable MD_PUBLIC_KEY): INTEGER

			-- Define a new assembly `assembly_name' with characteristics
			-- `assembly_flags' and `assembly_info', and if not void with
			-- a public key `public_key'.
			-- Possible values of `assembly_flags' are defined in MD_ASSEMBLY_FLAGS.
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_info_not_void: assembly_info /= Void
			valid_flags: public_key /= Void implies assembly_flags &
				{MD_ASSEMBLY_FLAGS}.public_key = {MD_ASSEMBLY_FLAGS}.public_key
		local
			l_assembly_def_entry: PE_ASSEMBLY_DEF_TABLE_ENTRY
			l_public_key_or_token: NATURAL_32
			l_name_index: NATURAL_32
		do
				-- Section II.22.2 Assembly : 0x20
			l_name_index := pe_writer.hash_string (assembly_name.string_32)
			if attached public_key as l_public_key then
				l_public_key_or_token :=
					hash_blob (
						(create {BYTE_ARRAY_CONVERTER}.
							make_from_string (l_public_key.public_key_token_string.to_string_8)).  -- TODO doubel check if to_string_8 is ok.
						to_natural_8_array,
						l_public_key.public_key_token_string.count.to_natural_32)
			else
				l_public_key_or_token := 0
			end

			create l_assembly_def_entry.make_with_data
				(assembly_flags,
				assembly_info.major_version,
				assembly_info.minor_version,
				assembly_info.build_number,
				assembly_info.revision_number,
				l_name_index,
				l_public_key_or_token)
			pe_index := add_table_entry (l_assembly_def_entry)
			Result := last_token.to_integer_32
		ensure
			valid_result: Result > 0
		end

	define_exported_type (type_name: CLI_STRING; implementation_token: INTEGER;
			type_def_token: INTEGER; type_flags: INTEGER): INTEGER
		require
			type_name_not_void: type_name /= Void
		local
			l_exported_type_entry: PE_EXPORTED_TYPE_TABLE_ENTRY
			l_tuple_type: like extract_table_type_and_row
			l_tuple_type_def: like extract_table_type_and_row
			l_name_index: NATURAL_32
			l_implementation: PE_IMPLEMENTATION
			l_namespace_index: NATURAL_32
			last_dot: INTEGER
			l_type_name: STRING_32
		do

				-- Section II.22.14 ExportedType : 0x27
				-- Extract table type and row from the implementation_token
			l_tuple_type := extract_table_type_and_row (implementation_token)

				-- Extract table type and row from the type_def_token
			l_tuple_type_def := extract_table_type_and_row (type_def_token)

				-- Hash the type name and get the name index
				-- First we check if we have a namespace (Double check if this is the correct way to
				-- compute type_name and namespace.
			l_type_name := type_name.string_32
			last_dot := l_type_name.last_index_of ('.', l_type_name.count)
			if last_dot = 0 then
				l_namespace_index := 0 -- empty namespace
				l_name_index := pe_writer.hash_string (l_type_name)
			else
				l_namespace_index := pe_writer.hash_string (l_type_name.substring (1, last_dot - 1))
				l_name_index := pe_writer.hash_string (l_type_name.substring (last_dot + 1, l_type_name.count))
			end


				-- Using table_row_index
			l_implementation := create_implementation (implementation_token, l_tuple_type.table_row_index)

				-- Create a new PE_EXPORTED_TYPE_TABLE_ENTRY instance with the given data
			create l_exported_type_entry.make_with_data (type_flags.to_natural_32, l_tuple_type_def.table_type_index, l_name_index, l_namespace_index, l_implementation)

			pe_index := add_table_entry (l_exported_type_entry)

			Result := last_token.to_integer_32
		ensure
			valid_result: Result > 0
		end

	define_file (file_name: CLI_STRING; hash_value: MANAGED_POINTER; file_flags: INTEGER): INTEGER
			-- Define a new entry in file table.
		require
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.is_empty
			hash_value_not_void: hash_value /= Void
			hash_value_not_empty: hash_value.count > 0
		local
			l_file_entry: PE_FILE_TABLE_ENTRY
			l_name_index: NATURAL_32
			l_hash_value_index: NATURAL_32
			last_slash: INTEGER
			file_name_len: INTEGER
			l_flags: NATURAL_32
			l_file_name: STRING_32
		do
				-- II.22.19 File : 0x26
				-- Compute the name index
			l_file_name := file_name.string_32
			file_name_len := l_file_name.count
			last_slash := l_file_name.last_index_of ({OPERATING_ENVIRONMENT}.directory_separator, file_name_len)
			if last_slash > 0 then
				file_name_len := l_file_name.count - last_slash
			end
			l_name_index := pe_writer.hash_string (l_file_name.substring (last_slash + 1, file_name_len))

				-- Compute the hash value index
			if hash_value.count > 0 then
				l_hash_value_index := hash_blob (hash_value.read_array (0, hash_value.count), hash_value.count.to_natural_32)
			else
				check has_non_empty_hash_value: False end
				l_hash_value_index := hash_blob (create {ARRAY [NATURAL_8]}.make_empty, 0)
			end

				-- Create a new PE_FILE_TABLE_ENTRY instance with the given data
			l_flags := file_flags.to_natural_32
			create l_file_entry.make_with_data (l_flags, l_name_index, l_hash_value_index)

			pe_index := add_table_entry (l_file_entry)
			Result := last_token.to_integer_32
		ensure
			valid_result: Result > 0
		end

	define_manifest_resource (resource_name: CLI_STRING; implementation_token: INTEGER; offset, resource_flags: INTEGER): INTEGER
			-- Define a new entry in manifest resource table.
		require
			resource_name_not_void: resource_name /= Void
		local
			l_manifest_resource_entry: PE_MANIFEST_RESOURCE_TABLE_ENTRY
			l_tuple_type: like extract_table_type_and_row
			l_implementation: PE_IMPLEMENTATION
			l_name_index: NATURAL_32
		do
				-- II.22.24 ManifestResource : 0x28
				-- Extract table type and row from the implementation_token
			l_tuple_type := extract_table_type_and_row (implementation_token)

				-- Hash the resource name and get the name index
			l_name_index := pe_writer.hash_string (resource_name.string_32)

				-- Using table_row_index
			l_implementation := create_implementation (implementation_token, l_tuple_type.table_row_index)

				-- Create a new PE_MANIFEST_RESOURCE_TABLE_ENTRY instance with the given data
			create l_manifest_resource_entry.make_with_data (offset.to_natural_32, resource_flags.to_natural_32, l_name_index, l_implementation)

			pe_index := add_table_entry (l_manifest_resource_entry)

			Result := last_token.to_integer_32
		ensure
			valid_result: Result > 0
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class MD_ASSEMBLY_EMIT
