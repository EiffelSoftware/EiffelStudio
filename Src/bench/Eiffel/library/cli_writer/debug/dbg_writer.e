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
		ensure
			success: last_call_success = 0
			item_set: item /= default_pointer
		end

feature -- Definition

	define_document (url: UNI_STRING; language, vendor, doc_type: COM_GUID): DBG_DOCUMENT_WRITER is
			-- Create a new document writer needed to generated debug info.
		local
			p: POINTER
		do
			last_call_success := c_define_document (item, url.item, language.item.item,
				vendor.item.item, doc_type.item.item, $p)
			create Result.make_by_pointer (p)
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

end -- class DBG_WRITER
