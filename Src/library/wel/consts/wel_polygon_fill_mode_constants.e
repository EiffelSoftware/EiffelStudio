indexing
	description: "Polygon fill mode constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_POLYGON_FILL_MODE_CONSTANTS

feature -- Access

	Alternate: INTEGER is
			-- Selects alternate mode (fills the area between
			-- odd-numbered and even-numbered polygon sides on
			-- each scan line).
		external
			"C [macro %"wel.h%"]"
		alias
			"ALTERNATE"
		end

	Winding: INTEGER is
			-- Selects winding mode (fills any region with a
			-- nonzero winding value).
		external
			"C [macro %"wel.h%"]"
		alias
			"WINDING"
		end

feature -- Status report

	valid_polygon_fill_mode_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid polygon fill mode constant?
		do
			Result := c = Alternate or else c = Winding
		end

end -- class WEL_POLYGON_FILL_MODE_CONSTANTS


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

