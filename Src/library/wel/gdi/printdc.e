indexing
	description: "Device context associated to a printer."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PRINTER_DC

inherit
	WEL_DC

creation
	make_by_pointer

feature -- Basic operations

	start_document (title: STRING) is
			-- Start the job `title' on the printer
		require
			exists: exists
			title_not_void: title /= Void
		local
			a: ANY
		do
			a := title.to_c
			cwin_escape (item, Startdoc, title.count, $a,
				default_pointer)
		end

	new_frame is
			-- Send a new frame to the printer
		require
			exists: exists
		do
			cwin_escape (item, Newframe, 0, default_pointer,
				default_pointer)
		end

	end_document is
			-- End the job on the printer
		require
			exists: exists
		do
			cwin_escape (item, Enddoc, 0, default_pointer,
				default_pointer)
		end

feature {NONE} -- Removal

	destroy_item is
			-- Ensure the current dc is deleted
		do
			delete
		end

feature {NONE} -- Externals

	cwin_escape (dc: POINTER; escape_code, size: INTEGER; 
			input_struct, output_struct: POINTER) is
			-- SDK Escape
		external
			"C [macro <wel.h>] (HDC, int, int, LPCSTR, %
				%void *)"
		alias
			"Escape"
		end

	Startdoc: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"STARTDOC"
		end

	Enddoc: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"ENDDOC"
		end

	Newframe: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"NEWFRAME"
		end

end -- class WEL_PRINTER_DC

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
