indexing
	description: "Regions (RGN) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RGN_CONSTANTS

feature -- Access

	Rgn_and: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RGN_AND"
		end

	Rgn_or: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RGN_OR"
		end

	Rgn_xor: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RGN_XOR"
		end

	Rgn_diff: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RGN_DIFF"
		end

	Rgn_copy: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"RGN_COPY"
		end

feature -- Status report

	valid_region_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid region constant?
		do
			Result := c = Rgn_and or else
				c = Rgn_or or else
				c = Rgn_xor or else
				c = Rgn_diff or else
				c = Rgn_copy
		end

end -- class WEL_RGN_CONSTANTS


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

