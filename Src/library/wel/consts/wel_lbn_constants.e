indexing
	description: "ListBox notification (LBN) messages."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LBN_CONSTANTS

feature -- Access

	Lbn_errspace: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LBN_ERRSPACE"
		end

	Lbn_selchange: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LBN_SELCHANGE"
		end

	Lbn_dblclk: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LBN_DBLCLK"
		end

	Lbn_selcancel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LBN_SELCANCEL"
		end

	Lbn_setfocus: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LBN_SETFOCUS"
		end

	Lbn_killfocus: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LBN_KILLFOCUS"
		end

end -- class WEL_LBN_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

