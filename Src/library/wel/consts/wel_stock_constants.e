indexing
	description: "Stock brushes, fonts, palette and pens."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STOCK_CONSTANTS

feature -- Brushes

	White_brush: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WHITE_BRUSH"
		end

	Ltgray_brush: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"LTGRAY_BRUSH"
		end

	Gray_brush: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GRAY_BRUSH"
		end

	Dkgray_brush: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"DKGRAY_BRUSH"
		end

	Black_brush: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BLACK_BRUSH"
		end

	Null_brush: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"NULL_BRUSH"
		end

	Hollow_brush: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HOLLOW_BRUSH"
		end

feature -- Pens

	White_pen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"WHITE_PEN"
		end

	Black_pen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BLACK_PEN"
		end

	Null_pen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"NULL_PEN"
		end

feature -- Fonts

	Oem_fixed_font: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"OEM_FIXED_FONT"
		end

	Ansi_fixed_font: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ANSI_FIXED_FONT"
		end

	Ansi_var_font: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"ANSI_VAR_FONT"
		end

	System_font: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SYSTEM_FONT"
		end

	Device_default_font: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"DEVICE_DEFAULT_FONT"
		end

	System_fixed_font: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"SYSTEM_FIXED_FONT"
		end

feature -- Palette

	Default_palette: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"DEFAULT_PALETTE"
		end

end -- class WEL_STOCK_CONSTANTS

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

