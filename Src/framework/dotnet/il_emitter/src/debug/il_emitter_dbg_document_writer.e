note
	description: "Abstraction of a SymDocumentWriter"
	author: ""
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
			url_id, lang_idx: NATURAL_32
--			vendor_idx, doc_type_idx: NATURAL_32
			l_hash_algo_guid_idx, l_hash_blob_idx: NATURAL_32
		do
			dbg_writer := a_dbg_writer
			md_emit := a_md_emit
			url := a_url
			language := a_language
			vendor := a_vendor
			doc_type := a_doc_type

			url_id := a_md_emit.define_pdb_string (a_url).to_natural_32
			lang_idx := a_md_emit.pdb_writer.hash_guid (a_language.to_array_natural_8)
--			vendor_idx := a_md_emit.pdb_writer.hash_guid (a_vendor.to_array_natural_8)
--			doc_type_idx := a_md_emit.pdb_writer.hash_guid (a_doc_type.to_array_natural_8)

--			l_hash_algo_guid_idx := a_md_emit.pdb_writer.hash_guid_for_sha1_hash_algorithm
--			l_hash_blob_idx := a_md_emit.pdb_writer.hash_blob_file_content (a_url, a_md_emit.pe_writer.hash_algo_sha1)
			l_hash_algo_guid_idx := a_md_emit.pdb_writer.hash_guid_for_sha256_hash_algorithm
			l_hash_blob_idx := a_md_emit.pdb_writer.hash_blob_file_content (a_url, a_md_emit.pe_writer.hash_algo_sha256)

			create entry.make_with_data (url_id, l_hash_algo_guid_idx, l_hash_blob_idx, lang_idx) --a_name_index, a_hash_algorithm_index, a_hash_index, a_language_index: NATURAL_32)
			entry_index := a_md_emit.add_pdb_table_entry (entry)
		end

feature -- Access

	md_emit: MD_EMIT_I

	dbg_writer: DBG_WRITER_I

	entry: PE_DOCUMENT_TABLE_ENTRY

	entry_index: NATURAL_32

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
--			l_offsets, l_start_lines, l_start_columns, l_end_lines, l_end_columns: ANY
--			e: PE_METHOD_DEBUG_INFORMATION_TABLE_ENTRY
		do
--			create e.make_with_data (entry_index, a_sequence_points_index: NATURAL_32)

--			if count > 0 then
--				l_offsets := offsets.to_c
--				l_start_lines := start_lines.to_c
--				l_start_columns := start_columns.to_c
--				l_end_lines := end_lines.to_c
--				l_end_columns := end_columns.to_c
--				last_call_success := c_define_sequence_points (dbg_writer.item, item, count,
--					$l_offsets, $l_start_lines, $l_start_columns, $l_end_lines, $l_end_columns)
--			else
--				last_call_success := 0
--			end
			is_successful := False
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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
