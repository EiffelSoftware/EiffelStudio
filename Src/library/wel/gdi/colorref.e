indexing
	description: "Color defined by intensity of the red, green, blue color."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COLOR_REF

inherit
	WEL_ANY
		rename
			make_by_pointer as any_make_by_pointer
		export
			{ANY} is_equal, copy, clone
		redefine
			exists,
			is_equal
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
			{ANY} valid_color_constant
		undefine
			is_equal
		end

creation
	make,
	make_rgb,
	make_system,
	make_by_pointer

feature {NONE} -- Initialization

	make is
			-- Make a black color
		do
			exists := True
			set_rgb (0, 0, 0)
		ensure
			exists: exists
			red_set: red = 0
			green_set: green = 0
			blue_set: blue = 0
		end

	make_rgb (a_red, a_green, a_blue: INTEGER) is
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
			exists := True
			set_rgb (a_red, a_green, a_blue)
		ensure
			exists: exists
			red_set: red = a_red
			green_set: green = a_green
			blue_set: blue = a_blue
		end

	make_system (index: INTEGER) is
			-- Make a system color identified by `index'.
			-- See WEL_COLOR_CONSTANTS for `index' values.
		require
			valid_color_constant: valid_color_constant (index)
		do
			exists := True
			item := cwin_get_sys_color (index)
		ensure
			exists: exists
		end

	make_by_pointer (pointer: POINTER) is
			-- Make a color by `pointer'.
		do
			any_make_by_pointer (pointer)
			exists := True
		ensure
			exists: exists
		end

feature -- Access

	red: INTEGER is
			-- Intensity value for the red component
		require
			exists: exists
		do
			Result := cwin_get_r_value (item)
		end

	green: INTEGER is
			-- Intensity value for the green component
		require
			exists: exists
		do
			Result := cwin_get_g_value (item)
		end

	blue: INTEGER is
			-- Intensity value for the blue component
		require
			exists: exists
		do
			Result := cwin_get_b_value (item)
		end

feature -- Element change

	set_rgb (a_red, a_green, a_blue: INTEGER) is
			-- Set `red', `green', `blue' with
			-- `a_red', `a_green', `a_blue'
		require
			exists: exists
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

	set_red (a_red: INTEGER) is
			-- Set `red' with `a_red'
		require
			exists: exists
			valid_red_inf: a_red >= 0
			valid_red_sup: a_red <= 255
		do
			set_rgb (a_red, green, blue)
		ensure
			red_set: red = a_red
		end

	set_green (a_green: INTEGER) is
			-- Set `green' with `a_green'
		require
			exists: exists
			valid_green_inf: a_green >= 0
			valid_green_sup: a_green <= 255
		do
			set_rgb (red, a_green, blue)
		ensure
			green_set: green = a_green
		end

	set_blue (a_blue: INTEGER) is
			-- Set `blue' with `a_blue'
		require
			exists: exists
			valid_blue_inf: a_blue >= 0
			valid_blue_sup: a_blue <= 255
		do
			set_rgb (red, green, a_blue)
		ensure
			blue_set: blue = a_blue
		end

feature -- Status report

	exists: BOOLEAN
			-- Does the color exist?

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `Current' equal to `other'?
		do
			Result := item = other.item
		end

feature {NONE} -- Removal

	destroy_item is
			-- This is only an affectation because
			-- we do not need to destroy a COLORREF.
		do
			exists := False
			item := default_pointer
		end

feature {NONE} -- Externals

	cwin_rgb (a_red, a_green, a_blue: INTEGER): POINTER is
			-- SDK RGB
		external
			"C [macro <wel.h>] (BYTE, BYTE, BYTE): EIF_POINTER"
		alias
			"RGB"
		end

	cwin_get_r_value (color: POINTER): INTEGER is
			-- SDK GetRValue
		external
			"C [macro <wel.h>] (COLORREF): EIF_INTEGER"
		alias
			"GetRValue"
		end

	cwin_get_g_value (color: POINTER): INTEGER is
			-- SDK GetGValue
		external
			"C [macro <wel.h>] (COLORREF): EIF_INTEGER"
		alias
			"GetGValue"
		end

	cwin_get_b_value (color: POINTER): INTEGER is
			-- SDK GetBValue
		external
			"C [macro <wel.h>] (COLORREF): EIF_INTEGER"
		alias
			"GetBValue"
		end

	cwin_get_sys_color (index: INTEGER): POINTER is
			-- SDK GetSysColor
		external
			"C [macro <wel.h>] (int): EIF_POINTER"
		alias
			"GetSysColor"
		end

invariant
	valid_red_inf: exists implies red >= 0
	valid_red_sup: exists implies red <= 255
	valid_green_inf: exists implies green >= 0
	valid_green_sup: exists implies green <= 255
	valid_blue_inf: exists implies blue >= 0
	valid_blue_sup: exists implies blue <= 255

end -- class WEL_COLOR_REF

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
