indexing
	description: "Mouse Activate (MA) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MA_CONSTANTS

feature -- Access

	Ma_activate: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MA_ACTIVATE"
		end

	Ma_activateandeat: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MA_ACTIVATEANDEAT"
		end

	Ma_noactivate: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MA_NOACTIVATE"
		end

	Ma_noactivateandeat: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MA_NOACTIVATEANDEAT"
		end

end -- class WEL_MA_CONSTANTS

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
