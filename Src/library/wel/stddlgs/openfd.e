indexing
	description: "Standard dialog box to open a file."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_OPEN_FILE_DIALOG

inherit
	WEL_FILE_DIALOG

creation
	make

feature -- Basic operations

	activate (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Activate the dialog box (modal mode) with
			-- `a_parent' as owner.
		do
			set_parent (a_parent)
			selected := cwin_get_open_file_name (item)
		end

feature {NONE} -- Externals

	cwin_get_open_file_name (ptr: POINTER): BOOLEAN is
			-- SDK GetOpenFileName
		external
			"C [macro <cdlg.h>] (LPOPENFILENAME): EIF_BOOLEAN"
		alias
			"GetOpenFileName"
		end

end -- class WEL_OPEN_FILE_NAME

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
