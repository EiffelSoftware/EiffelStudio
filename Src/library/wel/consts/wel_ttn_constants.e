indexing
	description: "Tooltip Notification (TTN) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TTN_CONSTANTS

feature -- Access

	Ttn_needtext: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTN_NEEDTEXT"
		end

	Ttn_pop: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTN_POP"
		end

	Ttn_show: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTN_SHOW"
		end

end -- class WEL_TTN_CONSTANTS


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

