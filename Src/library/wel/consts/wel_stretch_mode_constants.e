indexing
	description: "Stretch mode constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STRETCH_MODE_CONSTANTS

feature -- Access

	Stretch_andscans: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"STRETCH_ANDSCANS"
		end

	Stretch_deletescans: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"STRETCH_DELETESCANS"
		end

	Stretch_orscans: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"STRETCH_ORSCANS"
		end

feature -- Status report

	valid_stretch_mode_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid stretch mode constant?
		do
			Result := c = Stretch_andscans or else
				c = Stretch_deletescans or else
				c = Stretch_orscans
		end

end -- class WEL_STRETCH_MODE_CONSTANTS


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

