indexing
	description: "Clipping capabilities (CP) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CLIPPING_CAPABILITIES_CONSTANTS

feature -- Access

	Cp_none: INTEGER is
			-- Output is not clipped
		external
			"C [macro %"wel.h%"]"
		alias
			"CP_NONE"
		end

	Cp_rectangle: INTEGER is
			-- Output is clipped to rectangles
		external
			"C [macro %"wel.h%"]"
		alias
			"CP_RECTANGLE"
		end

	Cp_region: INTEGER is
			-- Output is clipped to regions
		external
			"C [macro %"wel.h%"]"
		alias
			"CP_REGION"
		end

end -- class WEL_CLIPPING_CAPABILITIES_CONSTANTS


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

