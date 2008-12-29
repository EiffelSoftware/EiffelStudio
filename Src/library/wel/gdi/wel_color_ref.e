note
	description: "Color defined by intensity of the red, green, blue color."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COLOR_REF

inherit
	ANY

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
			{ANY} valid_color_constant
		end

create
	make,
	make_rgb,
	make_system,
	make_by_color

feature {NONE} -- Initialization

	make
			-- Make a black color
		do
			set_rgb (0, 0, 0)
		ensure
			red_set: red = 0
			green_set: green = 0
			blue_set: blue = 0
		end

	make_rgb (a_red, a_green, a_blue: INTEGER)
			-- Set `red', `green', `blue' with
			-- `a_red', `a_green', `a_blue'
		require
			valid_red_inf: a_red >= 0
			valid_red_sup: a_red <= 255
			valid_green_inf: a_green >= 0
			valid_green_sup: a_green <= 255
			valid_blue_inf: a_blue >= 0
			valid_blue_sup: a_blue <= 255
		do
			set_rgb (a_red, a_green, a_blue)
		ensure
			red_set: red = a_red
			green_set: green = a_green
			blue_set: blue = a_blue
		end

	make_system (index: INTEGER)
			-- Make a system color identified by `index'.
			-- See WEL_COLOR_CONSTANTS for `index' values.
		require
			valid_color_constant: valid_color_constant (index)
		do
			item := cwin_get_sys_color (index)
		end

	make_by_color (color: INTEGER)
			-- Set `item' with `color'.
		do
			set_color (color)
		end

	make_by_pointer (color_pointer: POINTER)
			-- Set `item' with `color_pointer'.
		obsolete
			"Use `make_by_color' instead. Not implemented here."
		do
		end

feature -- Access

	item: INTEGER
			-- The Current color.

	red: INTEGER
			-- Intensity value for the red component
		do
			Result := cwin_get_r_value (item)
		end

	green: INTEGER
			-- Intensity value for the green component
		do
			Result := cwin_get_g_value (item)
		end

	blue: INTEGER
			-- Intensity value for the blue component
		do
			Result := cwin_get_b_value (item)
		end

feature -- Element change

	set_color (color: INTEGER)
			-- Set `item' with `color'.
		do
			item := color
		ensure
			color_set: item = color
		end

	set_rgb (a_red, a_green, a_blue: INTEGER)
			-- Set `red', `green', `blue' with
			-- `a_red', `a_green', `a_blue'
		require
			valid_red_inf: a_red >= 0
			valid_red_sup: a_red <= 255
			valid_green_inf: a_green >= 0
			valid_green_sup: a_green <= 255
			valid_blue_inf: a_blue >= 0
			valid_blue_sup: a_blue <= 255
		do
			item := cwin_rgb (a_red, a_green, a_blue)
		ensure
			red_set: red = a_red
			green_set: green = a_green
			blue_set: blue = a_blue
		end

	set_red (a_red: INTEGER)
			-- Set `red' with `a_red'
		require
			valid_red_inf: a_red >= 0
			valid_red_sup: a_red <= 255
		do
			set_rgb (a_red, green, blue)
		ensure
			red_set: red = a_red
		end

	set_green (a_green: INTEGER)
			-- Set `green' with `a_green'
		require
			valid_green_inf: a_green >= 0
			valid_green_sup: a_green <= 255
		do
			set_rgb (red, a_green, blue)
		ensure
			green_set: green = a_green
		end

	set_blue (a_blue: INTEGER)
			-- Set `blue' with `a_blue'
		require
			valid_blue_inf: a_blue >= 0
			valid_blue_sup: a_blue <= 255
		do
			set_rgb (red, green, a_blue)
		ensure
			blue_set: blue = a_blue
		end

feature {NONE} -- Externals

	cwin_rgb (a_red, a_green, a_blue: INTEGER): INTEGER
			-- SDK RGB
		external
			"C [macro <windows.h>] (BYTE, BYTE, BYTE): COLORREF"
		alias
			"RGB"
		end

	cwin_get_r_value (color: INTEGER): INTEGER
			-- SDK GetRValue
		external
			"C [macro <windows.h>] (DWORD): BYTE"
		alias
			"GetRValue"
		end

	cwin_get_g_value (color: INTEGER): INTEGER
			-- SDK GetGValue
		external
			"C [macro <windows.h>] (DWORD): BYTE"
		alias
			"GetGValue"
		end

	cwin_get_b_value (color: INTEGER): INTEGER
			-- SDK GetBValue
		external
			"C [macro <windows.h>] (DWORD): BYTE"
		alias
			"GetBValue"
		end

	cwin_get_sys_color (index: INTEGER): INTEGER
			-- SDK GetSysColor
		external
			"C [macro <windows.h>] (int): DWORD"
		alias
			"GetSysColor"
		end

invariant
	valid_red_inf: red >= 0
	valid_red_sup: red <= 255
	valid_green_inf: green >= 0
	valid_green_sup: green <= 255
	valid_blue_inf: blue >= 0
	valid_blue_sup: blue <= 255

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




end -- class WEL_COLOR_REF

