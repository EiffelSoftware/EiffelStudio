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

	make (a_dbg_writer: IL_EMITTER_DBG_WRITER; a_md_emit: MD_EMIT; a_url: CLI_STRING; a_language, a_vendor, a_doc_type: CIL_GUID)
		local
			lang_idx: NATURAL_32
			l_name_index: NATURAL_32
			l_scope_entry_index: NATURAL_32
			l_hash_algo_guid_idx, l_hash_blob_idx: NATURAL_32
		do
				-- https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#document-table-0x30
			dbg_writer := a_dbg_writer
			md_emit := a_md_emit
			url := a_url.string_32
			language := a_language
			vendor := a_vendor
			doc_type := a_doc_type

			debug ("il_emitter_table")
				print ({STRING_32} "DefineDocument: name=" + url)
			end

				-- Compute the name index
			l_name_index := hash_document_name_blob (a_url.string_32, a_md_emit.pdb_writer)

			if attached a_language.to_array_natural_8 as l_lang_guid then
					-- First check if the lang guid is known
				lang_idx := a_md_emit.pdb_writer.check_guid (l_lang_guid)
				if lang_idx = 0 then
					lang_idx := a_md_emit.pdb_writer.hash_guid (l_lang_guid)
				end
			end

			l_hash_algo_guid_idx := a_md_emit.pdb_writer.hash_guid_for_sha256_hash_algorithm
			l_hash_blob_idx := a_md_emit.pdb_writer.hash_blob_file_content (a_url, a_md_emit.pe_writer.hash_algo_sha256)

				-- Create a new PE_DOCUMENT_TABLE_ENTRY instance with the given data
			create entry.make_with_data (l_name_index, l_hash_algo_guid_idx, l_hash_blob_idx, lang_idx)

			document_entry_index := a_md_emit.next_pdb_table_index ({PDB_TABLES}.tdocument)
			document_entry_token := a_md_emit.add_pdb_table_entry (entry)

				-- Create a new PE_IMPORT_SCOPE_TABLE_ENTRY instance with the given data
			l_scope_entry_index := a_md_emit.next_pdb_table_index ({PDB_TABLES}.timportscope)
			scope_entry_token := a_md_emit.add_pdb_table_entry (create {PE_IMPORT_SCOPE_TABLE_ENTRY}.make_with_data (0, 0))

			create pending_sequence_points_table.make (0)
		end

feature -- Access

	md_emit: MD_EMIT

	dbg_writer: IL_EMITTER_DBG_WRITER

	entry: PE_DOCUMENT_TABLE_ENTRY

	document_entry_index: NATURAL_32

	document_entry_token: NATURAL_32

	scope_entry_token: NATURAL_32

	pending_sequence_points_table: HASH_TABLE [TUPLE [local_token: INTEGER_32; sequence_points: ARRAYED_LIST [MD_SEQUENCE_POINT]], INTEGER_32]
			-- indexed by method token	

feature -- Status

	is_successful: BOOLEAN
			-- Was last call to a COM routine of `Current' successful?

feature -- Properties

	language,
	vendor,
	doc_type: CIL_GUID

	url: STRING_32

feature -- Execution

	update_method_local_token (a_local_token: INTEGER; a_method_token: INTEGER)
		require
			a_local_token /= 0
		do
			if attached pending_sequence_points_table [a_method_token] as d then
				check d.local_token /= 0 implies d.local_token = a_local_token end
				d.local_token := a_local_token
			end
		ensure
			attached pending_sequence_points_table [a_method_token] as en_d implies en_d.local_token = a_local_token
		end

	flush_pending_sequence_points
		local
			meth_tok: INTEGER_32
			n: INTEGER
			tok: NATURAL_32
		do
			across
				pending_sequence_points_table as d
			loop
				meth_tok := @d.key
				process_define_sequence_points (meth_tok, d.local_token, d.sequence_points)
			end
				-- Ensure Method PE table and MethodDebugInformation PDB tables have the same size
			if
				attached md_emit.pe_writer.md_table ({PE_TABLES}.tmethoddef) as l_methoddef_table and then
				attached md_emit.pdb_writer.md_table ({PDB_TABLES}.tmethoddebuginformation) as l_methoddebuginformation_table
			then
				n := l_methoddef_table.count - l_methoddebuginformation_table.count
				if n > 0 then
					from
					until
						n = 0
					loop
						tok := md_emit.add_pdb_table_entry (create {PE_METHOD_DEBUG_INFORMATION_TABLE_ENTRY}.make_empty)
						n := n - 1
					end
				end
			end

			pending_sequence_points_table.wipe_out
		end

feature -- Helper	

	hash_document_name_blob (a_path: READABLE_STRING_GENERAL; pdb_writer: PE_GENERATOR): NATURAL_32
		local
			sep: CHARACTER_8
			sep_code: NATURAL_8
			s: STRING_8
			p: PATH
			bc: BYTE_ARRAY_CONVERTER
			l_blob: MD_BLOB_DATA
		do
			sep := {OPERATING_ENVIRONMENT}.directory_separator -- TODO: check if this is valid for all platform for .net
			sep_code := sep.natural_32_code.to_natural_8

			create p.make_from_string (a_path)
			create l_blob.make
			l_blob.put_natural_8 (sep_code)
			across
				p.components as l_part
			loop
				s := l_part.utf_8_name
				if s.count = 1 and then s[1] = sep then
						-- Useful for unix path /home/... first part if '/' 
					l_blob.put_natural_8 (0)
				else
					create bc.make_from_string (s)
					l_blob.put_compressed_natural_32 (pdb_writer.hash_blob (bc.to_natural_8_array, bc.count.to_natural_32))

				end
			end
			Result := pdb_writer.hash_blob (l_blob.as_array, l_blob.count.to_natural_32)
		end

feature -- Definition

	define_sequence_points (count: INTEGER; offsets, start_lines,
			start_columns, end_lines, end_columns: ARRAY [INTEGER])
			-- Set sequence points for `document'
		local
			i: INTEGER
			seqpt: MD_SEQUENCE_POINT
			meth_tok: INTEGER_32
			l_tb_data: like pending_sequence_points_table.item
			lst: ARRAYED_LIST [MD_SEQUENCE_POINT]
		do
			meth_tok := dbg_writer.current_method_token
			l_tb_data := pending_sequence_points_table [meth_tok]
			if l_tb_data = Void then
				create lst.make (count)
				l_tb_data := [dbg_writer.local_token, lst]
				pending_sequence_points_table [meth_tok] := l_tb_data
			else
				if dbg_writer.local_token > l_tb_data.local_token then
					l_tb_data.local_token := dbg_writer.local_token
				end
				lst := l_tb_data.sequence_points
			end
			from
				i := 0
			until
				i >= count
			loop
				create seqpt.make (
						offsets [offsets.lower + i],
						start_lines [start_lines.lower + i],
						start_columns [start_columns.lower + i],
						end_lines [end_lines.lower + i],
						end_columns [end_columns.lower + i]
					)
				lst.force (seqpt)
				i := i + 1
			end
			debug ("il_emitter_dbg")
				print (generator + ".define_sequence_points (")
				print (document_entry_token.to_hex_string)
				print (", " + count.out + ", .. )")
				if lst.count > 0 then
					print (" -> seq=")
				end
				across
					lst as e
				loop
					print (e.debug_output)
					print (" ")
				end
				print (" method=")
				print (meth_tok.to_hex_string)
				debug ("il_emitter_dbg_extra")
					if
						attached {PE_METHOD_DEF_TABLE_ENTRY} md_emit.pe_writer.md_table_entry (meth_tok.to_natural_32) as meth_entry and then
						attached md_emit.pe_writer.string_at (meth_entry.name_index) as meth_name
					then
						print (" %"")
						print (meth_name)
						print ("%"")
					end
				end
				io.put_new_line
			end
			is_successful := True
		end

	process_define_sequence_points (a_method_token, a_local_token: INTEGER_32; lst: LIST [MD_SEQUENCE_POINT])
			-- Set sequence points for Current document.
		local
			blob_data: ARRAY [NATURAL_8]
			blob_hash: NATURAL_32
			l_method_dbgi_table_entry: PE_METHOD_DEBUG_INFORMATION_TABLE_ENTRY
			l_method_index: NATURAL_32
			l_sequence_points: MD_SEQUENCE_POINTS
			d: TUPLE [table_type_index: NATURAL_32; table_row_index: NATURAL_32]
			m: TUPLE [table_type_index: NATURAL_32; table_row_index: NATURAL_32]
			l_document_row_index: NATURAL_32
			l_local_row_index: NATURAL_32
			l_current_method_table_index: NATURAL_32
			n: NATURAL_32
			l_methoddebuginformation_table: MD_TABLE
		do
				-- Extract table type and row from the method token
			d := md_emit.extract_table_type_and_row (document_entry_index.to_integer_32)
			l_document_row_index := d.table_row_index

				-- Ensure entry will be at same method row index.			
			l_current_method_table_index := md_emit.extract_table_type_and_row (a_method_token).table_row_index
			l_methoddebuginformation_table := md_emit.pdb_writer.md_table ({PDB_TABLES}.tmethoddebuginformation)
			n := l_methoddebuginformation_table.count.to_natural_32
			if l_current_method_table_index > n then
					-- Fill previous rows with empty entries.
				from
				until
					n >= l_current_method_table_index - 1
				loop
					l_method_index := md_emit.add_pdb_table_entry (create {PE_METHOD_DEBUG_INFORMATION_TABLE_ENTRY}.make_empty)
					n := n + 1
				end
			end

			-- Blob ::= header SequencePointRecord (SequencePointRecord | document-record)*
			-- SequencePointRecord ::= sequence-point-record | hidden-sequence-point-record

				-- Extract table type and row from the local token
			m := md_emit.extract_table_type_and_row (a_local_token)
			l_local_row_index := m.table_row_index

			if lst.count > 0 then
					--| See https://github.com/dotnet/runtime/blob/main/docs/design/specs/PortablePdb-Metadata.md#sequence-points-blob
					--| PE_SEQUENCE_POINTS_BLOB
					--| Sequence points blob has the following structure:
					--| Blob ::= header SequencePointRecord (SequencePointRecord | document-record)*
					--| SequencePointRecord ::= sequence-point-record | hidden-sequence-point-record

				create l_sequence_points.make

					--| Build the header
					--| LocalSignature (Method Token)
				l_sequence_points.set_local_signature (l_local_row_index.to_integer_32)

					--| IntialDocument (Current Document Entry)
					--	   TODO: check what value should we put if the document_id is already set.
					--	   we put 0 in other case we need to use the current document id
					-- DO NOT SET the Document row id here, as it should already be set in the Document table entry.
--				l_sequence_points.set_document_id (0)

					--| Build the sequence points record
					-- SequencePointRecord ::= sequence-point-record | hidden-sequence-point-record
				across
					lst as seq_pt
				loop
					l_sequence_points.put_sequence_point (seq_pt.il_offset,
							seq_pt.start_line,
							seq_pt.start_column,
							seq_pt.end_line,
							seq_pt.end_column
						)
				end

					-- Set the document record 0 for the offset
-- TODO: check but I think it is useless.
--				l_sequence_points.put_document_record (l_document_row_index.to_integer_32)

				blob_data := l_sequence_points.as_array

					-- Compute the Sequence Points Blob using hash_blob feature
				blob_hash := md_emit.pdb_writer.hash_blob (blob_data, blob_data.count.to_natural_32)

				-- Document (The row id of the single document containing all sequence points of the method,
				-- or 0 if the method doesn't have sequence points or spans multiple documents)
				create l_method_dbgi_table_entry.make (l_document_row_index, blob_hash)
			else
				-- Document (The row id of the single document containing all sequence points of the method,
				-- or 0 if the method doesn't have sequence points or spans multiple documents)
				create l_method_dbgi_table_entry.make_empty
			end

			if l_current_method_table_index.to_integer_32 <= l_methoddebuginformation_table.count then
				if attached {PE_METHOD_DEBUG_INFORMATION_TABLE_ENTRY} l_methoddebuginformation_table [l_current_method_table_index] as e and then not e.is_empty then
					debug ("il_emitter_dbg")
						print (generator + ".process_define_sequence_points (...): ISSUE doc["+ document_entry_token.to_hex_string +"] non empty sequence points already stored for method 0x" + l_current_method_table_index.to_hex_string + "%N")

						if
							attached sequence_points_at (e.sequence_points_index) as blob and then
							attached {PE_METHOD_DEF_TABLE_ENTRY} md_emit.pe_writer.md_table ({PE_TABLES}.tmethoddef)[l_current_method_table_index] as metdef and then
							attached md_emit.pe_writer.string_at (metdef.name_index) as met_name
						then
							print (" -> "+ document_entry_token.to_hex_string +"] Method %"" + met_name.to_string_8 + "%"%N")
						end
					end
						-- Unexpected, but it happens for instance with ARRAY.$NewCursor and ITERABLE.$NewCursor .. same method token, but the second sequence points part is related
						-- to the postconditions part of the ancestor  (ITERABLE) ...
						-- For now, let's ignore .
						-- FIXME: find out if this is expected behavior
						-- TODO: if it is expected, see if merging is a potential solution.
				else
						-- Replace with meaningful content.
					l_methoddebuginformation_table [l_current_method_table_index] := l_method_dbgi_table_entry
				end
			else
				l_method_index := md_emit.add_pdb_table_entry (l_method_dbgi_table_entry)
			end

			is_successful := True
		end

	sequence_points_at (a_blob: PE_BLOB): detachable TUPLE [sequence_points: MD_SEQUENCE_POINTS; local_token: NATURAL_32; points: LIST [MD_SEQUENCE_POINT]]
			-- Information related to the Sequence points stored in Blob heap at index `a_blob`.
		local
			l_reader: MD_BLOB_DATA

			l_il_offset: NATURAL_32
			l_delta_start_lines,
			l_delta_start_cols: INTEGER_32

			l_start_line, l_start_col,
			l_end_line, l_end_col: NATURAL_32
			n32: NATURAL_32
			l_is_first: BOOLEAN
			l_prev_non_hidden_start_line,
			l_prev_non_hidden_start_col: NATURAL_32
			l_prev_offset: NATURAL_32
			mp: MANAGED_POINTER
			l_nb_bytes: CELL [INTEGER_32]
			pos, max: INTEGER
			l_sequence_points: MD_SEQUENCE_POINTS
			seq_pt: MD_SEQUENCE_POINT
			seq_pt_lst: ARRAYED_LIST [MD_SEQUENCE_POINT]
		do
			mp := md_emit.pdb_writer.blob_at (a_blob)
			if mp /= Void and then mp.count > 0 then
				create l_sequence_points.make
				create seq_pt_lst.make (0)

				l_reader := l_sequence_points
				create l_nb_bytes.put (0)
				pos := 0
				max := mp.count
				n32 := l_reader.uncompressed_unsigned_data (mp, pos, l_nb_bytes).to_natural_32
				pos := pos + l_nb_bytes.item
				l_sequence_points.set_local_signature (n32.to_integer_32)

					-- The document row id information is already known in the Document table row
--				l_sequence_points.set_document_id (n32)

				Result := [l_sequence_points, n32, seq_pt_lst]


					-- Retrieve the sequence points
				l_is_first := True
				from
				until
					pos >= max
				loop
					l_il_offset := l_prev_offset + l_reader.uncompressed_unsigned_data (mp, pos, l_nb_bytes).to_natural_32
					pos := pos + l_nb_bytes.item

					l_delta_start_lines := l_reader.uncompressed_unsigned_data (mp, pos, l_nb_bytes)
					pos := pos + l_nb_bytes.item
					l_delta_start_cols := l_reader.uncompressed_unsigned_data (mp, pos, l_nb_bytes)
					pos := pos + l_nb_bytes.item
					if l_delta_start_lines = 0 and l_delta_start_cols = 0 then
	--							hidden-sequence-point-record
						l_start_line := 0x00FE_EFEE
						l_end_line := 0x00FE_EFEE
						l_start_col := 0
						l_end_col := 0
					else
	--							sequence-point-record
						if l_is_first then
							l_is_first := False
							l_start_line := l_reader.uncompressed_unsigned_data (mp, pos, l_nb_bytes).to_natural_32
							pos := pos + l_nb_bytes.item
							l_start_col := l_reader.uncompressed_unsigned_data (mp, pos, l_nb_bytes).to_natural_32
							pos := pos + l_nb_bytes.item
						else
							l_start_line := (l_prev_non_hidden_start_line.to_integer_32
									+ l_reader.uncompressed_signed_data (mp, pos, l_nb_bytes)
									).to_natural_32
							pos := pos + l_nb_bytes.item
							l_start_col := (l_prev_non_hidden_start_col.to_integer_32
									+ l_reader.uncompressed_signed_data (mp, pos, l_nb_bytes)
									).to_natural_32
							pos := pos + l_nb_bytes.item
						end
						l_end_line := (l_start_line.to_integer_32 + l_delta_start_lines).to_natural_32
						l_end_col := (l_start_col.to_integer_32 + l_delta_start_cols).to_natural_32
						create seq_pt.make (l_il_offset.to_integer_32, l_start_line.to_integer_32, l_start_col.to_integer_32, l_end_line.to_integer_32, l_end_col.to_integer_32)
						seq_pt_lst.force (seq_pt)
						l_sequence_points.put_sequence_point (seq_pt.il_offset,
									seq_pt.start_line, seq_pt.start_column,
									seq_pt.end_line, seq_pt.end_column)
						l_prev_non_hidden_start_line := l_start_line
						l_prev_non_hidden_start_col := l_start_col
					end
					l_prev_offset := l_il_offset
				end
			end
		end

	is_hidden_sequence_point (a_start_line, a_end_line: INTEGER; a_start_column, a_end_column: INTEGER): BOOLEAN
			-- True if: Hidden sequence point is a sequence point whose Start Line = End Line = 0xfeefee and Start Column = End Column = 0.
		do
			Result := a_start_line = a_end_line and then a_start_line = 0xfeefee and then (a_start_column = a_end_column) and then a_start_column = 0
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
