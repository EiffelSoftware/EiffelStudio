indexing
	description: "Button notification (BN) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BN_CONSTANTS

feature -- Access

	Bn_clicked: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BN_CLICKED"
		end

	Bn_paint: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BN_PAINT"
		end

	Bn_hilite: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BN_HILITE"
		end

	Bn_unhilite: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BN_UNHILITE"
		end

	Bn_disable: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BN_DISABLE"
		end

	Bn_doubleclicked: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BN_DOUBLECLICKED"
		end

	Bn_killfocus: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BN_KILLFOCUS"
		end

	Bn_setfocus: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BN_SETFOCUS"
		end

end -- class WEL_BN_CONSTANTS

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

