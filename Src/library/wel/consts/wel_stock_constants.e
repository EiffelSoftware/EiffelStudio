indexing
	description: "Stock brushes, fonts, palette and pens."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STOCK_CONSTANTS

feature -- Brushes

	White_brush: INTEGER is 0

	Ltgray_brush: INTEGER is 1

	Gray_brush: INTEGER is 2

	Dkgray_brush: INTEGER is 3

	Black_brush: INTEGER is 4

	Null_brush: INTEGER is 5

	Hollow_brush: INTEGER is 5
			-- Same as `Null_brush'.

feature -- Pens

	White_pen: INTEGER is 6

	Black_pen: INTEGER is 7

	Null_pen: INTEGER is 8

feature -- Fonts

	Oem_fixed_font: INTEGER is 10

	Ansi_fixed_font: INTEGER is 11

	Ansi_var_font: INTEGER is 12

	System_font: INTEGER is 13

	Device_default_font: INTEGER is 14

	System_fixed_font: INTEGER is 16

	Default_gui_font: INTEGER is 17

feature -- Palette

	Default_palette: INTEGER is 15

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

