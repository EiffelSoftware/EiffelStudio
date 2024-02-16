note
	description: "Abstraction of a SymDocumentWriter"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_DOCUMENT_WRITER

inherit
	DBG_DOCUMENT_WRITER_I

	COM_OBJECT
		export
			{DBG_WRITER} item
			{DBG_WRITER_I} last_call_success
		end

create
	make

feature {NONE} -- Initialization

	make (a_dbg_writer: DBG_WRITER; a_doc_writer_pointer: POINTER)
		do
			dbg_writer := a_dbg_writer
			make_by_pointer (a_doc_writer_pointer)
		end

feature -- Access

	dbg_writer: DBG_WRITER

feature -- Definition

	define_sequence_points (count: INTEGER; offsets, start_lines,
			start_columns, end_lines, end_columns: ARRAY [INTEGER])
			-- Set sequence points for `document'
		local
			l_offsets, l_start_lines, l_start_columns, l_end_lines, l_end_columns: ANY
		do
			if count > 0 then
				l_offsets := offsets.to_c
				l_start_lines := start_lines.to_c
				l_start_columns := start_columns.to_c
				l_end_lines := end_lines.to_c
				l_end_columns := end_columns.to_c
				last_call_success := c_define_sequence_points (dbg_writer.item, item, count,
					$l_offsets, $l_start_lines, $l_start_columns, $l_end_lines, $l_end_columns)
			else
				last_call_success := 0
			end
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

end -- class DBG_DOCUMENT_WRITER
