indexing
	description: "ComboBox notification message (CBN) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CBN_CONSTANTS

feature -- Access

	Cbn_errspace: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CBN_ERRSPACE"
		end

	Cbn_selchange: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CBN_SELCHANGE"
		end

	Cbn_dblclk: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CBN_DBLCLK"
		end

	Cbn_setfocus: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CBN_SETFOCUS"
		end

	Cbn_killfocus: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CBN_KILLFOCUS"
		end

	Cbn_editchange: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CBN_EDITCHANGE"
		end

	Cbn_editupdate: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CBN_EDITUPDATE"
		end

	Cbn_dropdown: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CBN_DROPDOWN"
		end

	Cbn_closeup: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CBN_CLOSEUP"
		end

	Cbn_selendok: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CBN_SELENDOK"
		end

	Cbn_selendcancel: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"CBN_SELENDCANCEL"
		end

end -- class WEL_CBN_CONSTANTS

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

