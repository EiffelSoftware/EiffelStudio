indexing
	description: "ListBox Style constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LBS_CONSTANTS

feature -- Access

	Lbs_notify: INTEGER is 1

	Lbs_sort: INTEGER is 2

	Lbs_noredraw: INTEGER is 4

	Lbs_multiplesel: INTEGER is 8

	Lbs_ownerdrawfixed: INTEGER is 16

	Lbs_ownerdrawvariable: INTEGER is 32

	Lbs_hasstrings: INTEGER is 64

	Lbs_usetabstops: INTEGER is 128

	Lbs_nointegralheight: INTEGER is 256

	Lbs_multicolumn: INTEGER is 512

	Lbs_wantkeyboardinput: INTEGER is 1024

	Lbs_extendedsel: INTEGER is 2048

	Lbs_disablenoscroll: INTEGER is 4096

	Lbs_standard: INTEGER is 10485763
			-- `Lbs_notify' | `Lbs_sort' | `Ws_vscroll' | `Ws_border'.

end -- class WEL_LBS_CONSTANTS

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

