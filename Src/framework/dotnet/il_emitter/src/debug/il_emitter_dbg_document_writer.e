note
	description: "Abstraction of a SymDocumentWriter"
	date: "$Date$"
	revision: "$Revision$"

class
	IL_EMITTER_DBG_DOCUMENT_WRITER

inherit

	DBG_DOCUMENT_WRITER_I

create
	make

feature {NONE} -- Initialization

	make (a_dbg_writer: DBG_WRITER_I; a_md_emit: MD_EMIT; a_url: CLI_STRING; a_language, a_vendor, a_doc_type: CIL_GUID)
		local
			l_token, lang_idx: NATURAL_32
			l_owner_index: NATURAL_32
			l_name_index: NATURAL_32
			l_scope_entry_index, l_document_entry_index: NATURAL_32
			l_entry: NATURAL_32
			l_hash_algo_guid_idx, l_hash_blob_idx: NATURAL_32
			d: TUPLE [table_type_index: NATURAL_32; table_row_index: NATURAL_32]
		do
				-- https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#document-table-0x30
			dbg_writer := a_dbg_writer
			md_emit := a_md_emit
			url := a_url
			language := a_language
			vendor := a_vendor
			doc_type := a_doc_type

				-- Compute the Pdb Document token
			l_token := a_md_emit.define_pdb_string (a_url).to_natural_32

				-- Extract table type and row from the method token
			d := a_md_emit.extract_table_type_and_row (l_token.to_integer_32)
			l_owner_index := d.table_row_index

			debug ("il_emitter_table")
				print ({STRING_32} "DefineDocument: owner=" + l_token.to_hex_string + " owner.index=" + l_owner_index.out + " name=" + url.string_32)
			end

				-- Compute the name index
			l_name_index := a_md_emit.pdb_writer.hash_string (a_url.string_32)

			lang_idx := a_md_emit.pdb_writer.hash_guid (a_language.to_array_natural_8)
			l_hash_algo_guid_idx := a_md_emit.pdb_writer.hash_guid_for_sha256_hash_algorithm
			l_hash_blob_idx := a_md_emit.pdb_writer.hash_blob_file_content (a_url, a_md_emit.pe_writer.hash_algo_sha256)

				-- Create a new PE_DOCUMENT_TABLE_ENTRY instance with the given data
			create entry.make_with_data (l_name_index, l_hash_algo_guid_idx, l_hash_blob_idx, lang_idx)

			l_document_entry_index := a_md_emit.next_pdb_table_index ({PDB_TABLES}.tdocument)
			document_entry_index := a_md_emit.add_pdb_table_entry (entry)

				-- Create a new PE_IMPORT_SCOPE_TABLE_ENTRY instance with the given data
			l_scope_entry_index := a_md_emit.next_pdb_table_index ({PDB_TABLES}.timportscope)
			scope_entry_index := a_md_emit.add_pdb_table_entry (create {PE_IMPORT_SCOPE_TABLE_ENTRY}.make_with_data (0, 0))
		end

feature -- Access

	md_emit: MD_EMIT

	dbg_writer: DBG_WRITER_I

	entry: PE_DOCUMENT_TABLE_ENTRY

	document_entry_index: NATURAL_32

	scope_entry_index: NATURAL_32

feature -- Status

	is_successful: BOOLEAN
			-- Was last call to a COM routine of `Current' successful?

feature -- Properties

	language,
	vendor,
	doc_type: CIL_GUID

	url: CLI_STRING

feature -- Definition

	define_sequence_points (count: INTEGER; offsets, start_lines,
			start_columns, end_lines, end_columns: ARRAY [INTEGER])
			-- Set sequence points for `document'
		local
			i, j: INTEGER
			blob_data: ARRAY [NATURAL_8]
			blob_len: NATURAL_32
			blob_hash: NATURAL_32
			l_method_dbgi_table_entry: PE_METHOD_DEBUG_INFORMATION_TABLE_ENTRY
			l_idx: NATURAL_32
		do
			if count > 0 then
					-- Build the blob_data from the input arrays
				create blob_data.make_filled (0, 1, count * 5)
				from
					i := 0
					j := 1
				until
					i >= count
				loop
					blob_data [j] := offsets [offsets.lower + i].to_natural_8
					blob_data [j + 1] := start_lines [start_lines.lower + i].to_natural_8
					blob_data [j + 2] := start_columns [start_columns.lower + i].to_natural_8
					blob_data [j + 3] := end_lines [end_lines.lower + i].to_natural_8
					blob_data [j + 4] := end_columns [end_columns.lower + i].to_natural_8
					j := j + 5
					i := i + 1
				end

					-- Compute the blob length
				blob_len := blob_data.count.to_natural_32

					-- Compute the Sequence Points Blob using hash_blob feature
				blob_hash := md_emit.pdb_writer.hash_blob (blob_data, blob_len)

					-- Create a new PE_METHOD_DEBUG_INFORMATION_TABLE_ENTRY for the method with the
					-- entry index (the current document id and the blob hash)
				create l_method_dbgi_table_entry.make_with_data (document_entry_index, blob_hash)
			else
				create l_method_dbgi_table_entry.make_with_data (document_entry_index, 0)
			end

			l_idx := md_emit.next_pdb_table_index ({PDB_TABLES}.tmethoddebuginformation)

		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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

end
