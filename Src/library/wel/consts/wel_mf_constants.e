indexing
	description: "Menu Flags (MF) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MF_CONSTANTS

feature -- Access

	Mf_insert: INTEGER is 0

	Mf_change: INTEGER is 128

	Mf_append: INTEGER is 256

	Mf_delete: INTEGER is 512

	Mf_remove: INTEGER is 4096

	Mf_bycommand: INTEGER is 0

	Mf_byposition: INTEGER is 1024

	Mf_separator: INTEGER is 2048

	Mf_enabled: INTEGER is 0

	Mf_grayed: INTEGER is 1

	Mf_disabled: INTEGER is 2

	Mf_unchecked: INTEGER is 0

	Mf_checked: INTEGER is 8

	Mf_usecheckbitmaps: INTEGER is 512

	Mf_string: INTEGER is 0

	Mf_bitmap: INTEGER is 4

	Mf_ownerdraw: INTEGER is 256

	Mf_popup: INTEGER is 16

	Mf_menubarbreak: INTEGER is 32

	Mf_menubreak: INTEGER is 64

	Mf_unhilite: INTEGER is 0

	Mf_hilite: INTEGER is 128

	Mf_sysmenu: INTEGER is 8192

	Mf_help: INTEGER is 16384

	Mf_mouseselect: INTEGER is 32768

	Mf_end: INTEGER is 128

end -- class WEL_MF_CONSTANTS

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

