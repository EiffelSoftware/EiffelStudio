indexing
	description: "[
		Encapsulation of ISymUnmanagedWriter COM interface to create PDB
		files for CLI images.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_WRITER

inherit
	COM_OBJECT

create
	make

feature {NONE} -- Initialization

	make (emitter: MD_EMIT; name: UNI_STRING; full_build: BOOLEAN) is
			-- Create a new SymUnmanagedWriter object using `emitter' in a file `name'.
		do
			make_by_pointer (c_new_sym_writer)
			last_call_success := c_initialize (item, emitter.item, name.item,
				default_pointer, full_build)
			is_closed := False
		ensure
			success: last_call_success = 0
			not_is_closed: not is_closed
			item_set: item /= default_pointer
		end

feature -- Update

	close is
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

feature -- Status report

	is_closed: BOOLEAN
			-- Can further operation be applied on Current?

feature -- Definition

	define_document (url: UNI_STRING; language, vendor, doc_type: COM_GUID): DBG_DOCUMENT_WRITER is
			-- Create a new document writer needed to generated debug info.
		require
			not_is_closed: not is_closed
			url_not_void: url /= Void
			language_guid_not_void: language /= Void
			vendor_guid_not_void: vendor /= Void
			doc_type_guid_not_void: doc_type /= Void
		local
			p: POINTER
		do
			last_call_success := c_define_document (item, url.item, language.item.item,
				vendor.item.item, doc_type.item.item, $p)
			create Result.make_by_pointer (p)
		ensure
			success: last_call_success = 0
		end

	define_sequence_points (document: DBG_DOCUMENT_WRITER; offsets, start_lines, start_columns,
			end_lines, end_columns: MANAGED_POINTER)
		is
			-- Set sequence points for `document'
		require
			not_is_closed: not is_closed
			document_not_void: document /= Void
			offsets_not_void: offsets /= Void
			start_lines_not_void: start_lines /= Void
			valid_count: offsets.count = start_lines.count
		do
			last_call_success := c_define_sequence_points (item, document.item, offsets.count,
				offsets.item, start_lines.item, start_columns.item, end_lines.item,
				end_columns.item)
		ensure
			success: last_call_success = 0
		end
		
feature {NONE} -- Implementation

	c_new_sym_writer: POINTER is
			-- Create a new instance of ISymUnmanagedWriter implementation.
		external
			"C use %"cli_writer.h%""
		alias
			"new_sym_writer"
		end

	c_close (an_item: POINTER): INTEGER is
			-- Call `ISymUnmanagedWriter->Close'.
		external
			"C++ ISymUnmanagedWriter signature : EIF_INTEGER use %"cli_headers.h%""
		alias
			"Close"
		end

	c_close_method (an_item: POINTER): INTEGER is
			-- Call `ISymUnmanagedWriter->CloseMethod'.
		external
			"C++ ISymUnmanagedWriter signature : EIF_INTEGER use %"cli_headers.h%""
		alias
			"CloseMethod"
		end

	c_close_scope (an_item: POINTER; end_offset: INTEGER): INTEGER is
			-- Call `ISymUnmanagedWriter->CloseScope'.
		external
			"C++ ISymUnmanagedWriter signature (ULONG32): EIF_INTEGER use %"cli_headers.h%""
		alias
			"CloseScope"
		end

	c_define_document (an_item: POINTER; name: POINTER;
			lang_guid, lang_vendor, doc_type: POINTER; sym_writer: POINTER): INTEGER
		is
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

	c_define_sequence_points (an_item: POINTER; document: POINTER; count: INTEGER;
			offsets, lines, columns, end_lines, end_columns: POINTER): INTEGER
		is
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
		is
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

	c_open_method (an_item: POINTER; method_token: INTEGER): INTEGER is
				-- Call `ISymUnmanagedWriter->OpenMethod'.
		external
			"C++ ISymUnmanagedWriter signature (mdMethodDef): EIF_INTEGER use %"cli_headers.h%""
		alias
			"OpenMethod"
		end

	c_open_scope (an_item: POINTER; start_offset: INTEGER; scope_id: POINTER): INTEGER
		is
				-- Call `ISymUnmanagedWriter->OpenScope'.
		external
			"[
				C++ ISymUnmanagedWriter signature (ULONG32, ULONG32 *): EIF_INTEGER
				use "cli_headers.h"
			]"
		alias
			"OpenScope"
		end

end -- class DBG_WRITER
