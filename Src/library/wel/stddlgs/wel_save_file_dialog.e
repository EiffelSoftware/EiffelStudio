indexing
	description: "Standard dialog box to save a file."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SAVE_FILE_DIALOG

inherit
	WEL_FILE_DIALOG

create
	make

feature -- Basic operations

	activate (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Activate the dialog box (modal mode) with
			-- `a_parent' as owner.
		do
			set_parent (a_parent)
			selected := cwin_get_save_file_name (item)
		end

feature {NONE} -- Externals

	cwin_get_save_file_name (ptr: POINTER): BOOLEAN is
			-- SDK GetSaveFileName
		external
			"C [macro <cdlg.h>] (LPOPENFILENAME): EIF_BOOLEAN"
		alias
			"GetSaveFileName"
		end

end -- class WEL_SAVE_FILE_DIALOG

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

