note
	description: "Stock brushes, fonts, palette and pens."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STOCK_CONSTANTS

feature -- Brushes

	White_brush: INTEGER = 0

	Ltgray_brush: INTEGER = 1

	Gray_brush: INTEGER = 2

	Dkgray_brush: INTEGER = 3

	Black_brush: INTEGER = 4

	Null_brush: INTEGER = 5

	Hollow_brush: INTEGER = 5
			-- Same as `Null_brush'.

feature -- Pens

	White_pen: INTEGER = 6

	Black_pen: INTEGER = 7

	Null_pen: INTEGER = 8

feature -- Fonts

	Oem_fixed_font: INTEGER = 10

	Ansi_fixed_font: INTEGER = 11

	Ansi_var_font: INTEGER = 12

	System_font: INTEGER = 13

	Device_default_font: INTEGER = 14

	System_fixed_font: INTEGER = 16

	Default_gui_font: INTEGER = 17

feature -- Palette

	Default_palette: INTEGER = 15;

note
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

