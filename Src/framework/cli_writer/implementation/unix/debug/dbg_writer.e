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

create
	make

feature {NONE} -- Initialization

	make (emitter: MD_EMIT; name: UNI_STRING; full_build: BOOLEAN)
			-- Create a new SymUnmanagedWriter object using `emitter' in a file `name'.
		do
				-- Initialize COM.
			(create {CLI_COM}).initialize_com

			make_by_pointer (c_new_sym_writer)
			last_call_success := c_initialize (item, emitter.item, name.item,
				default_pointer, full_build)
			is_closed := False
		ensure
			not_is_closed: not is_closed
			item_set: item /= default_pointer
		end

feature -- Update

	close
			-- Stop all processing on current.
		require
			not_is_closed: not is_closed
		do
			last_call_success := c_close (item)
			is_closed := True
		ensure
			success: last_call_success = 0
			is_closed: is_closed
		end

	close_method
			-- Close current method.
		require
			not_is_closed: not is_closed
		do
			last_call_success := c_close_method (item)
		ensure
			success: last_call_success = 0
		end

	open_method (a_meth_token: INTEGER)
			-- Open method `a_meth_token'.
		require
			not_is_closed: not is_closed
			valid_token: a_meth_token /= 0
		do
			last_call_success := c_open_method (item, a_meth_token)
		ensure
			success: last_call_success = 0
		end

	open_scope (start_offset: INTEGER)
			-- Create a new scope for defining local variables.
		require
			valid_start_offset: start_offset >= 0
		local
			l_scope_id: INTEGER
		do
			last_call_success := c_open_scope (item, start_offset, $l_scope_id)
		ensure
			success: last_call_success = 0
		end

	close_scope (end_offset: INTEGER)
			-- Close most recently opened scope.
		require
			valid_end_offset: end_offset >= 0
		do
			last_call_success := c_close_scope (item, end_offset) 
		ensure
			success: last_call_success = 0
		end
		
feature -- PE file data

	debug_info (a_dbg_directory: CLI_DEBUG_DIRECTORY): MANAGED_POINTER
			-- Retrieve debug info required to be inserted in PE file.
		require
			not_is_closed: not is_closed
			a_dbg_directory_not_void: a_dbg_directory /= Void
		local
			l_count: INTEGER
			l_data: MANAGED_POINTER
		do
			create l_data.make (1024)
			last_call_success := c_debug_info (item, a_dbg_directory.item, l_data.count, $l_count, l_data.item)
			
			create Result.make (l_count)
			Result.item.memory_copy (l_data.item, l_count)
		ensure
			success: last_call_success = 0
		end

feature -- Status report

	is_closed: BOOLEAN
			-- Can further operation be applied on Current?

feature -- Definition

	define_sequence_points (document: DBG_DOCUMENT_WRITER; count: INTEGER; offsets, start_lines,
			start_columns, end_lines, end_columns: ARRAY [INTEGER])
		
			-- Set sequence points for `document'
		require
			not_is_closed: not is_closed
			document_not_void: document /= Void
			offsets_not_void: offsets /= Void
			start_lines_not_void: start_lines /= Void
			valid_start_lines_count: count <= start_lines.count
			start_columns_not_void: start_columns /= Void
			valid_start_columns_count: count <= start_columns.count
			end_lines_not_void: end_lines /= Void
			valid_end_lines_count: count <= end_lines.count
			end_columns_not_void: end_columns /= Void
			valid_end_columns_count: count <= end_columns.count
		local
			l_offsets, l_start_lines, l_start_columns, l_end_lines, l_end_columns: ANY
		do
			if count > 0 then
				l_offsets := offsets.to_c
				l_start_lines := start_lines.to_c
				l_start_columns := start_columns.to_c
				l_end_lines := end_lines.to_c
				l_end_columns := end_columns.to_c
				last_call_success := c_define_sequence_points (item, document.item, count,
					$l_offsets, $l_start_lines, $l_start_columns, $l_end_lines, $l_end_columns)
			else
				last_call_success := 0
			end
		ensure
			success: last_call_success = 0
		end

	define_local_variable (name: UNI_STRING; pos: INTEGER; signature: MD_TYPE_SIGNATURE)
			-- Define local variable `name' at position `pos' in current method using
			-- `signature' of current method.
		require
			name_not_void: name /= Void
			valid_pos: pos >= 0
			signature_not_void: signature /= Void
		do
			last_call_success := c_define_local_variable (item, name.item, 0,
				signature.count, signature.item.item, 1, pos, 0, 0, 0, 0)
		ensure
			success: last_call_success = 0
		end

	define_parameter (name: UNI_STRING; pos: INTEGER)
			-- Define parameter `name' at position `pos' in current method.
		require
			name_not_void: name /= Void
			valid_pos: pos >= 0
		do
			last_call_success := c_define_parameter (item, name.item, 0, pos, 1, pos, 0, 0)
		ensure
			success: last_call_success = 0
		end
	
feature -- Settings

	set_user_entry_point (entry_point_token: INTEGER)
			-- Set `entry_point_token' as entry point.
		require
			not_is_closed: not is_closed
			valid_token:
				entry_point_token & {MD_TOKEN_TYPES}.Md_mask =
					{MD_TOKEN_TYPES}.Md_method_def
		do
			last_call_success := c_set_user_entry_point (item, entry_point_token)
		ensure
			success: last_call_success  = 0
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class DBG_WRITER
