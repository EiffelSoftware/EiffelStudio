indexing
	description: "Status window messages."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STATUS_WINDOW_CONSTANTS

feature -- Access

	Sb_getrect: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_GETRECT"
		end

	Sb_setminheight: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_SETMINHEIGHT"
		end

	Sb_getborders: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_GETBORDERS"
		end

	Sb_gettext: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_GETTEXT"
		end

	Sb_gettextlength: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_GETTEXTLENGTH"
		end

	Sb_settext: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_SETTEXT"
		end

	Sb_getparts: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_GETPARTS"
		end

	Sb_setparts: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_SETPARTS"
		end

	Sb_simple: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_SIMPLE"
		end

end -- class WEL_STATUS_WINDOW_CONSTANTS


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

