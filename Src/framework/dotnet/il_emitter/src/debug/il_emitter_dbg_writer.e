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
			debug ("refactor_fixme")
				to_implement ("TODO double check current implementation")
			end

			file_name := name.string_32

			initialize_code_view
			current_method_token := -1
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

feature -- Update

	close
			-- Stop all processing on current.
		local
			l_pdb_file: CLI_PDB_FILE
			l_pdb_id: ARRAY [NATURAL_8]
		do
				-- update pdb_stream entry point and pdb_id
			create l_pdb_id.make_filled (8, 1, 20) -- FIXME: for now, use fake PID id (easy to identify in binary, a sequence of 20 `08` values.
			emitter.update_pdb_stream_pdb_id (l_pdb_id)
			emitter.update_pdb_stream_entry_point (entry_point_token)
			create l_pdb_file.make (associated_pdb_file_name.name, emitter)
			l_pdb_file.save
			is_successful := True
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

			if attached {MD_EMIT} emitter then

					-- Set up state for new method.
				current_method_token := a_meth_token
				is_successful := True
			else
				is_successful := False
			end
		end

	open_scope (start_offset: INTEGER)
			-- Create a new scope for defining local variables.
		do
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
		do
			check current_method_token /= -1 end
			current_end_offset := end_offset
			check current_end_offset > current_start_offset  end


				-- create a new entry to PE_LOCAL_SCOPE_TABLE_ENTRY
				-- we use the current method token `current_method_token`
				-- whith the current entry in the importscope table
				-- then we compute the first entry to the localvariable rowid ( using the current index - (number of variables added in the scope)
			create l_local_scope_entry.make_with_data (current_method_token.to_natural_32,
													   emitter.pdb_writer.md_table ({PDB_TABLES}.timportscope).size,
													   emitter.pdb_writer.md_table ({PDB_TABLES}.tlocalvariable).size - current_variables_scope,
													   0,
													   current_start_offset.to_natural_32, (current_end_offset - current_start_offset).to_natural_32)

			l_local_scope_index := emitter.next_pdb_table_index ({PDB_TABLES}.tlocalscope)
			idx := emitter.add_pdb_table_entry (l_local_scope_entry)

			is_successful := True
		end

feature -- PE file data

	debug_info (a_dbg_directory: CLI_DEBUG_DIRECTORY_I): MANAGED_POINTER
			-- Retrieve debug info required to be inserted in PE file.
		do
			Result := associated_code_view.item.managed_pointer
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
		do
			debug ("refactor_fixme")
				to_implement ("TODO: DBG_DOCUMENT_WRITER")
			end
			debug ("il_emitter_dbg")
				print (generator + ".define_document (")
				print (url.string_32)
				print (", ..)%N")
			end
			if attached {MD_EMIT} emitter as l_md_emit then
				create {IL_EMITTER_DBG_DOCUMENT_WRITER} Result.make (Current, l_md_emit, url, language, vendor, doc_type)
				is_successful := True
			else
				is_successful := False
			end
		end

	define_sequence_points (document: DBG_DOCUMENT_WRITER_I; count: INTEGER; offsets, start_lines,
			start_columns, end_lines, end_columns: ARRAY [INTEGER])
			-- Set sequence points for `document'
		local
			n: INTEGER
		do
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
			debug ("il_emitter_dbg")
				print (generator + ".define_sequence_points (doc, " + count.out + ", ")
				if count > 0 then
					across
						<<offsets, start_lines, start_columns, end_lines, end_columns>> as arr
					loop
						print (", [")
						n := 0
						across
							arr as i
						until
							n >= count
						loop
							print (i.out)
							n := n + 1
							if n < count then
								print (",")
							end
						end
						print ("]")
					end
				else
					print (",,,,,")
				end
				print (")%N")

			end
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
			debug ("refactor_fixme")
				to_implement ("TODO add implementation")
			end
			debug ("il_emitter_dbg")
				print (generator + ".define_local_variable (%"")
				print (name.string_32)
				print ("%", " + pos.out + ", " + signature.debug_output)
				print (")%N")
			end
			l_attributes := 0 -- FIXME: All, DebuggerHidden ...
			l_name_index := emitter.pdb_writer.hash_string (name.string_32)
			create e.make_with_data (l_attributes, pos.to_natural_16, l_name_index)
			l_local_entry_entry_index := emitter.next_pdb_table_index ({PDB_TABLES}.tlocalvariable)
			idx := emitter.add_pdb_table_entry (e)
			current_variables_scope := current_variables_scope + 1
			is_successful := True
		end

	define_parameter (name: CLI_STRING; pos: INTEGER)
			-- Define parameter `name' at position `pos' in current method.
		do
			debug ("refactor_fixme")
				to_implement ("TODO this feature is not used by the old .Net implemenation")
					-- Double check if the current implementation needs it.
			end
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
			debug ("refactor_fixme")
				to_implement ("TODO double check if this is the correct way to setup the current entry point.")

			end
			debug ("il_emitter_dbg")
				print (generator + ".set_user_entry_point (%"")
				print (a_entry_point_token.out)
				print (")%N")
			end
			entry_point_token := a_entry_point_token
			is_successful := True
		end


feature {NONE} -- Implementation


	initialize_code_view
			-- Initialize associated code view.
		do
			create associated_code_view.make (associated_pdb_file_name)
		end

	associated_pdb_file_name: PATH
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
