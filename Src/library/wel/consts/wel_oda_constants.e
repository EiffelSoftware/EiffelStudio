indexing
	description: "Owner Draw Action (ODA) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ODA_CONSTANTS

feature -- Access

	Oda_drawentire: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODA_DRAWENTIRE"
		end

	Oda_select: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODA_SELECT"
		end

	Oda_focus: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ODA_FOCUS"
		end

end -- class WEL_ODA_CONSTANTS


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

