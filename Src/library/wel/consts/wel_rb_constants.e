indexing
	description: "Common control ReBar (RB) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RB_CONSTANTS

feature -- Access

	Rb_deleteband: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_DELETEBAND"
		end

	Rb_getbandinfo: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_GETBANDINFO"
		end

	Rb_getbarinfo: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_GETBARINFO"
		end

	Rb_getbandcount: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_GETBANDCOUNT"
		end

	Rb_getrowcount: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_GETROWCOUNT"
		end

	Rb_getrowheight: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_GETROWHEIGHT"
		end

	Rb_insertband: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_INSERTBAND"
		end

	Rb_setbandinfo: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_SETBANDINFO"
		end

	Rb_setbarinfo: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_SETBARINFO"
		end

	Rb_setparent: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_SETPARENT"
		end

end -- class WEL_RB_CONSTANTS


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

