note
	description: "Contains the input filename used by %
		%`start_doc' in WEL_PRINTER_DC."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DOC_INFO

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

create
	make

feature {NONE} -- Initialization

	make (a_document_name: STRING_GENERAL)
			-- Make doc info structure with `document_name'.
		require
			a_document_name_not_void: a_document_name /= Void
		do
			structure_make
			cwel_doc_info_set_cbsize (item, structure_size)
			set_document_name (a_document_name)
			set_default_output
		ensure
			document_name_set: document_name.is_equal (a_document_name)
		end

feature -- Access

	document_name: STRING_32
			-- Name of the document
		do
			Result := str_document_name.string
		ensure
			result_not_void: Result /= Void
		end

	output: STRING_32
			-- Name of the output file
		require
			default_output_not_set: not default_output_set
		do
			Result := str_output.string
		ensure
			result_not_void: Result /= Void
		end

feature -- Element change

	set_document_name (a_document_name: STRING_GENERAL)
			-- Set `document_name' with `a_document_name'.
		require
			a_document_name_not_void: a_document_name /= Void
		do
			create str_document_name.make (a_document_name)
			cwel_doc_info_set_lpszdocname (item, str_document_name.item)
		ensure
			document_name_set: document_name.is_equal (a_document_name)
		end

	set_output (an_output: STRING_GENERAL)
			-- Set `output' with `an_output'.
		require
			an_output_not_void: an_output /= Void
		do
			create str_output.make (an_output)
			cwel_doc_info_set_lpszoutput (item, str_output.item)
		ensure
			output_set: output.is_equal (an_output)
		end

	set_default_output
			-- Set the output to the default system value.
		do
			cwel_doc_info_set_lpszoutput (item, default_pointer)
		ensure
			default_output_set: default_output_set
		end

feature -- Status report

	default_output_set: BOOLEAN
			-- Is the default output set?
		do
			Result := cwel_doc_info_get_lpszoutput (item) = default_pointer
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := cwel_size_of_doc_info
		end

feature -- Implementation

	str_document_name: WEL_STRING
			-- C string to save the document name

	str_output: WEL_STRING
			-- C string to save the output

feature {NONE} -- Externals

	cwel_size_of_doc_info: INTEGER
		external
			"C [macro <docinfo.h>]"
		alias
			"sizeof (DOCINFO)"
		end

	cwel_doc_info_set_cbsize (ptr: POINTER; value: INTEGER)
		external
			"C [macro <docinfo.h>]"
		end

	cwel_doc_info_set_lpszdocname (ptr: POINTER; value: POINTER)
		external
			"C [macro <docinfo.h>]"
		end

	cwel_doc_info_set_lpszoutput (ptr: POINTER; value: POINTER)
		external
			"C [macro <docinfo.h>]"
		end

	cwel_doc_info_get_lpszdocname (ptr: POINTER): POINTER
		external
			"C [macro <docinfo.h>] (DOCINFO*): EIF_POINTER"
		end

	cwel_doc_info_get_lpszoutput (ptr: POINTER): POINTER
		external
			"C [macro <docinfo.h>] (DOCINFO*): EIF_POINTER"
		end

invariant
	str_output_not_void: str_output /= Void
	str_document_name_not_void: str_document_name /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
