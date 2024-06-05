note
	description: "[
		Encapsulation of ISymUnmanagedWriter COM interface to create PDB
		files for CLI images.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_WRITER

inherit
	COM_OBJECT
		export
			{DBG_DOCUMENT_WRITER, DBG_WRITER_I} item
		end

	DBG_WRITER_I

create
	make

feature {NONE} -- Initialization

	make (emitter: MD_EMIT_I; name: CLI_STRING; full_build: BOOLEAN)
			-- Create a new SymUnmanagedWriter object using `emitter' in a file `name'.
		do
				-- Initialize COM.
			(create {CLI_COM}).initialize_com

			make_by_pointer (c_new_sym_writer)
			if attached {MD_EMIT} emitter as e then
				last_call_success := c_initialize (item, e.item, name.item,
					default_pointer, full_build)
			else
				check is_expected_emitter: False end
			end
			is_closed := False
		ensure
			not_is_closed: not is_closed
			item_set: item /= default_pointer
		end

feature -- Update

	close (a_pe_file: detachable CLI_PE_FILE)
			-- Stop all processing on current.
		do
			last_call_success := c_close (item)
			is_closed := True
		end

	close_method
			-- Close current method.
		do
			last_call_success := c_close_method (item)
		end

	open_method (a_meth_token: INTEGER)
			-- Open method `a_meth_token'.
		do
			last_call_success := c_open_method (item, a_meth_token)
		end

	open_scope (start_offset: INTEGER)
			-- Create a new scope for defining local variables.
		local
			l_scope_id: INTEGER
		do
			last_call_success := c_open_scope (item, start_offset, $l_scope_id)
		end

	close_scope (end_offset: INTEGER)
			-- Close most recently opened scope.
		do
			last_call_success := c_close_scope (item, end_offset)
		end

	open_local_signature (a_doc: DBG_DOCUMENT_WRITER_I; a_token: INTEGER)
			-- Open Local signature token for the current method token.
		do
				-- Not implemented for COM interface.
			last_call_success := 0
		end

	close_local_signature (a_doc: DBG_DOCUMENT_WRITER_I)
			-- Close local signature fo the current Method.
		do
				-- Not implemented for COM interface.
			last_call_success := 0
		end

feature -- PE file data

	codeview_debug_info (a_dbg_directory: CLI_DEBUG_DIRECTORY): MANAGED_POINTER
			-- Retrieve debug info required to be inserted in PE file.
		local
			l_count: INTEGER
			l_data: MANAGED_POINTER
		do
			create l_data.make (1024)
			last_call_success := c_debug_info (item, a_dbg_directory.item, l_data.count, $l_count, l_data.item)

			create Result.make (l_count)
			Result.item.memory_copy (l_data.item, l_count)
		end

	checksum_debug_info (a_dbg_directory: CLI_DEBUG_DIRECTORY): MANAGED_POINTER
			-- Retrieve checksum info required to be inserted in PE file.
		do
				-- Not implemented for COM interface.
			create Result.make (0)
		end

feature -- Status report

	is_closed: BOOLEAN
			-- Can further operation be applied on Current?

feature -- Definition

	define_document (url: CLI_STRING; language, vendor, doc_type: CIL_GUID): DBG_DOCUMENT_WRITER_I
			-- Create a new document writer needed to generated debug info.
		local
			p: POINTER
		do
			last_call_success := c_define_document (item, url.item, language.item.item,
				vendor.item.item, doc_type.item.item, $p)
			check
				p_not_null: p /= default_pointer
			end
			create {DBG_DOCUMENT_WRITER} Result.make (Current, p)
		end

	define_sequence_points (document: DBG_DOCUMENT_WRITER_I; count: INTEGER; offsets, start_lines,
			start_columns, end_lines, end_columns: ARRAY [INTEGER])
			-- Set sequence points for `document'
		local
			j, n: INTEGER_32
		do
			debug ("il_emitter_dbg")
				print (generator + ".define_sequence_points (doc, " + count.out + ", ")
				if count > 0 then
					j := 0
					across
						<<offsets, start_lines, start_columns, end_lines, end_columns>> as arr
					loop
						print (", ")
						j := j + 1
						inspect j
						when 2 then
							print ("# start_lines")
						when 3 then
							print ("# start_columns")
						when 4 then
							print ("# end_lines")
						when 5 then
							print ("# end_columns")
						else
							print ("# ")
						end
						print ("[")
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
			end;

			document.define_sequence_points (count, offsets, start_lines,
			start_columns, end_lines, end_columns)
			if attached {DBG_DOCUMENT_WRITER} document as doc then
				last_call_success := doc.last_call_success
			else
				check expected_dbg_document_writer: False end
			end
		end

	define_local_variable (name: CLI_STRING; pos: INTEGER; signature: MD_TYPE_SIGNATURE)
			-- Define local variable `name' at position `pos' in current method using
			-- `signature' of current method.
		do
			last_call_success := c_define_local_variable (item, name.item, 0,
				signature.count, signature.item.item, 1, pos, 0, 0, 0, 0)
		end

	define_parameter (name: CLI_STRING; pos: INTEGER)
			-- Define parameter `name' at position `pos' in current method.
		do
			last_call_success := c_define_parameter (item, name.item, 0, pos, 1, pos, 0, 0)
		end

feature -- Settings

	set_user_entry_point (entry_point_token: INTEGER)
			-- Set `entry_point_token' as entry point.
		do
			last_call_success := c_set_user_entry_point (item, entry_point_token)
		end

feature {NONE} -- Implementation

	c_new_sym_writer: POINTER
			-- Create a new instance of ISymUnmanagedWriter implementation.
		external
			"C use %"cli_writer.h%""
		alias
			"new_sym_writer"
		end

	c_close (an_item: POINTER): INTEGER
			-- Call `ISymUnmanagedWriter->Close'.
		external
			"C++ ISymUnmanagedWriter signature : EIF_INTEGER use %"cli_headers.h%""
		alias
			"Close"
		end

	c_close_method (an_item: POINTER): INTEGER
			-- Call `ISymUnmanagedWriter->CloseMethod'.
		external
			"C++ ISymUnmanagedWriter signature : EIF_INTEGER use %"cli_headers.h%""
		alias
			"CloseMethod"
		end

	c_close_scope (an_item: POINTER; end_offset: INTEGER): INTEGER
			-- Call `ISymUnmanagedWriter->CloseScope'.
		external
			"C++ ISymUnmanagedWriter signature (ULONG32): EIF_INTEGER use %"cli_headers.h%""
		alias
			"CloseScope"
		end

	c_debug_info (an_item: POINTER; debug_directory: POINTER; input_data_size: INTEGER;
			output_data_size: POINTER; data: POINTER): INTEGER

			-- Call `ISymUnmanagedWriter->GetDebugInfo'.
		external
			"[
				C++ ISymUnmanagedWriter signature
					(IMAGE_DEBUG_DIRECTORY *, DWORD, DWORD *, BYTE *): EIF_INTEGER
				use "cli_headers.h"
			]"
		alias
			"GetDebugInfo"
		end

	c_define_document (an_item: POINTER; name: POINTER;
			lang_guid, lang_vendor, doc_type: POINTER; sym_writer: POINTER): INTEGER

			-- Call `ISymUnmanagedWriter->DefineDocument'.
		external
			"[
				C++ ISymUnmanagedWriter signature
					(LPWSTR, GUID *, GUID *, GUID *, ISymUnmanagedDocumentWriter **): EIF_INTEGER
				use "cli_headers.h"
			]"
		alias
			"DefineDocument"
		end

	c_define_local_variable (an_item: POINTER; name: POINTER; attributes, signature_length: INTEGER;
			signature: POINTER; Addresskind, local_pos, unused2, unused3,
			start_offset, end_offset: INTEGER): INTEGER

			-- Call `ISymUnmanagedWriter->DefineLocalVariable'.
		external
			"[
				C++ ISymUnmanagedWriter signature
					(LPWSTR, ULONG32, ULONG32, unsigned char *, ULONG32, ULONG32, ULONG32,
					ULONG32, ULONG32, ULONG32): EIF_INTEGER
				use "cli_headers.h"
			]"
		alias
			"DefineLocalVariable"
		end

	c_define_parameter (an_item: POINTER; name: POINTER; attributes, param_pos: INTEGER;
			Addresskind, unused1, unused2, unused3: INTEGER): INTEGER

			-- Call `ISymUnmanagedWriter->DefineParameter'.
		external
			"[
				C++ ISymUnmanagedWriter signature
					(LPWSTR, ULONG32, ULONG32, ULONG32, ULONG32, ULONG32, ULONG32): EIF_INTEGER
				use "cli_headers.h"
			]"
		alias
			"DefineParameter"
		end

	c_define_sequence_points (an_item: POINTER; document: POINTER; count: INTEGER;
			offsets, lines, columns, end_lines, end_columns: POINTER): INTEGER

			-- Call `ISymUnmanagedWriter->DefineSequencePoints'.
		external
			"[
				C++ ISymUnmanagedWriter signature
					(ISymUnmanagedDocumentWriter *, ULONG32, ULONG32 *, ULONG32 *,
					ULONG32 *, ULONG32 *, ULONG32 *): EIF_INTEGER
				use "cli_headers.h"
			]"
		alias
			"DefineSequencePoints"
		end

	c_initialize (an_item: POINTER; md_emitter: POINTER; filename: POINTER; stream: POINTER;
			full_build: BOOLEAN): INTEGER

				-- Call `ISymUnmanagedWriter->Initialize'.
		external
			"[
				C++ ISymUnmanagedWriter signature
					(IUnknown *, LPWSTR, IStream *, BOOL): EIF_INTEGER
				use "cli_headers.h"
			]"
		alias
			"Initialize"
		end

	c_open_method (an_item: POINTER; method_token: INTEGER): INTEGER
				-- Call `ISymUnmanagedWriter->OpenMethod'.
		external
			"C++ ISymUnmanagedWriter signature (mdMethodDef): EIF_INTEGER use %"cli_headers.h%""
		alias
			"OpenMethod"
		end

	c_open_scope (an_item: POINTER; start_offset: INTEGER; scope_id: POINTER): INTEGER

				-- Call `ISymUnmanagedWriter->OpenScope'.
		external
			"[
				C++ ISymUnmanagedWriter signature (ULONG32, ULONG32 *): EIF_INTEGER
				use "cli_headers.h"
			]"
		alias
			"OpenScope"
		end

	c_set_user_entry_point (an_item: POINTER; token: INTEGER): INTEGER

				-- Call `ISymUnmanagedWriter->SetUserEntryPoint'.
		external
			"[
				C++ ISymUnmanagedWriter signature (ULONG32): EIF_INTEGER
				use "cli_headers.h"
			]"
		alias
			"SetUserEntryPoint"
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

end -- class DBG_WRITER
