indexing
	description: "Raster operations constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RASTER_OPERATIONS_CONSTANTS

feature -- Access

	Srccopy: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SRCCOPY"
		end

	Srcpaint: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SRCPAINT"
		end

	Srcand: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SRCAND"
		end

	Srcinvert: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SRCINVERT"
		end

	Srcerase: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SRCERASE"
		end

	Notsrccopy: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"NOTSRCCOPY"
		end

	Notsrcerase: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"NOTSRCERASE"
		end

	Mergecopy: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MERGECOPY"
		end

	Mergepaint: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MERGEPAINT"
		end

	Patcopy: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"PATCOPY"
		end

	Patpaint: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"PATPAINT"
		end

	Patinvert: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"PATINVERT"
		end

	Dstinvert: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"DSTINVERT"
		end

	Blackness: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BLACKNESS"
		end

	Whiteness: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WHITENESS"
		end

end -- class WEL_RASTER_OPERATIONS_CONSTANTS

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

