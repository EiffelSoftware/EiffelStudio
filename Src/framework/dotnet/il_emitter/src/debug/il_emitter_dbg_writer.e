note
	description: "Summary description for {DBG_WRITER}."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_EMITTER_DBG_WRITER

inherit
	DBG_WRITER_I

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_emitter: MD_EMIT_I; name: CLI_STRING; full_build: BOOLEAN)
			--  Create a new IL_EMITTER_DBG_WRITER object using `emitter' in a file `name'.
		do
			check attached {MD_EMIT} a_emitter as md then
				emitter := md
			end

			file_name := name.string_32

			initialize_debug_directory
			current_method_token := -1
			local_token := -1
			create dbg_documents.make (2)
			is_closed := False
			is_successful := True
		ensure
			not_is_closed: not is_closed
		end

feature -- Access

	emitter: MD_EMIT

	current_method_token: INTEGER

	current_start_offset: INTEGER

	current_end_offset: INTEGER

	current_variables_scope: NATURAL_32

	file_name: IMMUTABLE_STRING_32

	entry_point_token: INTEGER

	associated_code_view:  CLI_CODE_VIEW

	associated_pdb_checksum: CLI_PDB_CHECKSUM

	local_token: INTEGER
		-- Local token for the current method.
		--| MD_LOCAL_SIGNATURE.

feature -- Access

	dbg_documents: ARRAYED_LIST [IL_EMITTER_DBG_DOCUMENT_WRITER]

feature -- Update

	close (a_pe_file: detachable CLI_PE_FILE)
			-- Stop all processing on current.
		local
			l_pdb_file: CLI_PDB_FILE
			l_sha256, l_guid: ARRAY [NATURAL_8]
			l_sha256_mp: MANAGED_POINTER
			l_time: INTEGER
			g: CIL_GUID

			l_codeview_debug_info,
			l_checksum_debug_info: MANAGED_POINTER
		do
				-- Process pending operation on Document (such as sequence points)
			across
				dbg_documents as dbg_doc
			loop
				dbg_doc.flush_pending_sequence_points
			end
			dbg_documents.wipe_out

				-- update pdb_stream entry point
			emitter.update_pdb_stream_entry_point (entry_point_token)
			create l_pdb_file.make (associated_pdb_file_name.name, emitter)
			l_pdb_file.save

			l_sha256 := {MD_HASH_UTILITIES}.sha256_bytes_for_file_name (l_pdb_file.file_name)
			create l_sha256_mp.make_from_array (l_sha256)
			l_time := associated_pdb_file_timestamp

				-- We use the first 16 bytes as deterministic GUID 	
			create g.make (
				l_sha256_mp.read_natural_32_le (0),
				l_sha256_mp.read_natural_16_le (4),
				l_sha256_mp.read_natural_16_le (6),
				l_sha256_mp.read_array (8, 8)
				)
			l_guid := g.to_array_natural_8
				-- We use this first 16 bytes as the GUID of CodeView
			associated_code_view.set_gui (l_guid)

			l_pdb_file.update_pdb_stream_pdb_id (compute_pdb_id (l_guid, l_time))
			associated_pdb_checksum.set_checksum (l_sha256)

				-- Note: the call to `codeview_debug_info` also updates the related timestamp with PDF file information.
			if a_pe_file /= Void then
				if attached a_pe_file.codeview_debug_directory as l_codeview_dbg_directory then
					l_codeview_debug_info := codeview_debug_info (l_codeview_dbg_directory)
					a_pe_file.set_codeview_debug_information (l_codeview_dbg_directory, l_codeview_debug_info)
					if attached a_pe_file.checksum_debug_directory as l_checksum_dbg_directory then
						l_checksum_debug_info := checksum_debug_info (l_checksum_dbg_directory)
						a_pe_file.set_checksum_debug_information (l_checksum_dbg_directory, l_checksum_debug_info)
					end
				end
			end

			is_successful := True
			is_closed := True
		end

	close_method
			-- Close current method.
		do
			check current_method_token /= -1 end
			current_method_token := -1
			is_successful := True
		end

	open_method (a_meth_token: INTEGER)
			-- Open method `a_meth_token'.
		do
			check current_method_token = -1 end
					-- Set up state for new method.
			current_method_token := a_meth_token
			is_successful := True
		end

	open_scope (start_offset: INTEGER)
			-- Create a new scope for defining local variables.
		do
			debug ("il_emitter_dbg")
				print (generator + ".open_scope (")
				print (start_offset.out)
				print (")%N")
			end
			current_variables_scope := 0
			check current_method_token /= -1 end
			current_start_offset := start_offset
			is_successful := 	True
		end

	close_scope (end_offset: INTEGER)
			-- Close most recently opened scope.
		local
			l_local_scope_entry: PE_LOCAL_SCOPE_TABLE_ENTRY
			l_local_scope_index: NATURAL_32
			idx: NATURAL_32
			m: TUPLE [table_type_index: NATURAL_32; table_row_index: NATURAL_32]
			l_method_row_index: NATURAL_32
			l_import_scope_row_index,
			l_local_variable_row_index: NATURAL_32
		do
			check current_method_token /= -1 end
			current_end_offset := end_offset
			check current_end_offset >= current_start_offset  end

				-- create a new entry to PE_LOCAL_SCOPE_TABLE_ENTRY

				-- we use the current method token `current_method_token`
			m := emitter.extract_table_type_and_row (current_method_token)
			l_method_row_index := m.table_row_index

				-- with the current entry in the importscope table
			l_import_scope_row_index := emitter.pdb_writer.md_table ({PDB_TABLES}.timportscope).size

				-- then we compute the first entry to the localvariable rowid ( using the current index - (number of variables added in the scope + 1)
			l_local_variable_row_index := emitter.pdb_writer.md_table ({PDB_TABLES}.tlocalvariable).size - current_variables_scope + 1

			create l_local_scope_entry.make_with_data (
					l_method_row_index, -- MethodDef row id
					l_import_scope_row_index, -- ImportScope row id
					l_local_variable_row_index, -- VariableList = LocalVariable row id
					0, -- ConstantList row id
					current_start_offset.to_natural_32, -- StartOffset
					(current_end_offset - current_start_offset).to_natural_32 -- Length
				)

			debug ("il_emitter_dbg")
				print (generator + ".close_scope (")
				print (end_offset.out)
				print (")")
				print (" method="+ current_method_token.to_hex_string)
				print (" current_variables_scope="+ current_variables_scope.out)
				print (" VariableList="+ l_local_variable_row_index.to_hex_string)
				print ("%N")
			end

			l_local_scope_index := emitter.next_pdb_table_index ({PDB_TABLES}.tlocalscope)
			idx := emitter.add_pdb_table_entry (l_local_scope_entry)

			is_successful := True
		end

	open_local_signature (a_doc: DBG_DOCUMENT_WRITER_I; a_local_token: INTEGER)
			-- Open Local signature token for the current method token.
		do
			local_token := a_local_token
			if
				a_local_token /= 0 and then
				attached {IL_EMITTER_DBG_DOCUMENT_WRITER} a_doc as l_il_doc
			then
				l_il_doc.update_method_local_token (a_local_token, current_method_token)
			end
		    is_successful := True
		end

	close_local_signature (a_doc: DBG_DOCUMENT_WRITER_I)
			-- Close local signature fo the current Method.
		do
			check local_token /= -1 end
			local_token := -1
			is_successful := True
		end

feature -- PE file data

	codeview_debug_info (a_dbg_directory: CLI_DEBUG_DIRECTORY_I): MANAGED_POINTER
			-- Retrieve CodeView debug info required to be inserted in PE file.
			-- note: it also update the timestamp !
		local
			t: INTEGER
		do
			if attached associated_code_view as l_code_view then
				t := associated_pdb_file_timestamp
				if t > 0 then
					a_dbg_directory.set_time_date_stamp (t)
				end
				Result := l_code_view.item.managed_pointer
			else
				Result := associated_code_view.item.managed_pointer
			end
			is_successful := True
		end

	checksum_debug_info (a_dbg_directory: CLI_DEBUG_DIRECTORY_I): MANAGED_POINTER
			-- Retrieve checksum info required to be inserted in PE file.
		do
			Result := associated_pdb_checksum.item.managed_pointer
			is_successful := True
		end

feature -- Status report

	is_closed: BOOLEAN
			-- Can further operation be applied on Current?

	is_successful: BOOLEAN
			-- Was last call successful?

feature -- Definition

	define_document (url: CLI_STRING; language, vendor, doc_type: CIL_GUID): detachable DBG_DOCUMENT_WRITER_I
			-- Create a new document writer needed to generated debug info.
		local
			dbg_doc_writer: IL_EMITTER_DBG_DOCUMENT_WRITER
		do
			debug ("il_emitter_dbg")
				print (generator + ".define_document (")
				print (url.string_32)
				print (", ..)%N")
			end
			if attached {MD_EMIT} emitter as l_md_emit then
				create dbg_doc_writer.make (Current, l_md_emit, url, language, vendor, doc_type)
				dbg_documents.force (dbg_doc_writer)
				Result := dbg_doc_writer
				is_successful := True
			else
				is_successful := False
			end
		end

	define_sequence_points (document: DBG_DOCUMENT_WRITER_I; count: INTEGER_32; offsets, start_lines, start_columns, end_lines, end_columns: ARRAY [INTEGER_32])
			-- Set sequence points for `document`
		do
			document.define_sequence_points (count, offsets, start_lines, start_columns, end_lines, end_columns)
			is_successful := document.is_successful
		end

	define_local_variable (name: CLI_STRING; pos: INTEGER; signature: MD_TYPE_SIGNATURE)
			-- Define local variable `name' at position `pos' in current method using
			-- `signature' of current method.
		local
			e: PE_LOCAL_VARIABLE_TABLE_ENTRY
			l_attributes: NATURAL_16
			l_name_index: NATURAL_32
			idx: NATURAL_32
			l_local_entry_entry_index: NATURAL_32
		do

			l_attributes := 0 -- FIXME: All, DebuggerHidden ...
			l_name_index := emitter.pdb_writer.hash_string (name.string_32)
			create e.make_with_data (l_attributes, pos.to_natural_16, l_name_index)
			l_local_entry_entry_index := emitter.next_pdb_table_index ({PDB_TABLES}.tlocalvariable)
			idx := emitter.add_pdb_table_entry (e)
			current_variables_scope := current_variables_scope + 1
			debug ("il_emitter_dbg")
				print (generator + ".define_local_variable (%"")
				print (name.string_32)
				print ("%", " + pos.out + ", " + signature.debug_output)
				print (") -> idx=0x"+ idx.to_hex_string +" current_variables_scope="+current_variables_scope.out+"%N")
			end
			is_successful := True
		end

	define_parameter (name: CLI_STRING; pos: INTEGER)
			-- Define parameter `name' at position `pos' in current method.
		do
			debug ("il_emitter_dbg")
				print (generator + ".define_parameter (%"")
				print (name.string_32)
				print ("%", " + pos.out)
				print (")%N")
			end
			is_successful := False
		end

feature -- Settings

	set_user_entry_point (a_entry_point_token: INTEGER)
			-- Set `entry_point_token' as entry point.
		do
			debug ("il_emitter_dbg")
				print (generator + ".set_user_entry_point (%"")
				print (a_entry_point_token.out)
				print (")%N")
			end
			entry_point_token := a_entry_point_token
			is_successful := True
		end


feature {NONE} -- Implementation

	initialize_debug_directory
			-- Initialize associated code view and pdb checksum
		do
			create associated_code_view.make (associated_pdb_file_name)
			create associated_pdb_checksum.make
		end

	associated_pdb_file_name: PATH
			-- Location of the associated PDF file.
		local
			fn: READABLE_STRING_32
			p: PATH
		do
			fn := file_name
			create p.make_from_string (fn)
			if attached p.extension as ext then
				create p.make_from_string (fn.head (fn.count - ext.count - 1))
			end
			Result := p.appended_with_extension ("pdb")
		end

	associated_pdb_file_timestamp: INTEGER
			-- timestamp of the associated PDB file, if it exists.
		local
			f: RAW_FILE
		do
			create f.make_with_path (associated_pdb_file_name)
			if f.exists then
				Result := f.change_date
			end
		end


	compute_pdb_id (a_guid_bytes: ARRAY [NATURAL_8]; a_timestamp: INTEGER): ARRAY [NATURAL_8]
	 	local
			mp: MANAGED_POINTER
		do
			check a_guid_bytes.count = 16 end
			create mp.make (20)
			mp.put_array (a_guid_bytes, 0)
			mp.put_integer_32_le (a_timestamp, 16)
			Result := mp.read_array (0, 20)
		ensure
			valid_result: Result.count = 20
        end


;note
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
