indexing
	description: "Stock brushes, fonts, palette and pens."
	legal: "See notice at end of class."
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

	Default_palette: INTEGER is 15;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_STOCK_CONSTANTS

