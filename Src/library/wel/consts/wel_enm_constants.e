indexing
	description: "Edit Notification mask (ENM) constants for the rich %
		%edit control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ENM_CONSTANTS

feature -- Access

	Enm_none: INTEGER is 0

	Enm_change: INTEGER is 1

	Enm_update: INTEGER is 2

	Enm_scroll: INTEGER is 4

	Enm_keyevents: INTEGER is 65536

	Enm_mouseevents: INTEGER is 131072

	Enm_requestresize: INTEGER is 262144

	Enm_selchange: INTEGER is 524288

	Enm_dropfiles: INTEGER is 1048576

	Enm_protected: INTEGER is 2097152

	Enm_correcttext: INTEGER is 4194304

	Enm_imechange: INTEGER is 8388608

end -- class WEL_ENM_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

