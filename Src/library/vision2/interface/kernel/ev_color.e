indexing
	description: "Eiffel Vision color.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	EV_COLOR

inherit
	EV_ANY
		redefine
			implementation
		end

creation
	make,
	make_rgb

feature {NONE} -- Initialization

	make is
			-- Create a black color. 
		do
			!EV_COLOR_IMP!implementation.make
			implementation.set_interface (Current)
		end

	make_rgb (a_red, a_green, a_blue: INTEGER) is
			-- Create the color corresponding to the given rgb value.
		do
			!EV_COLOR_IMP!implementation.make_rgb (a_red, a_green, a_blue)
			implementation.set_interface (Current)
		end

feature -- Access

	red: INTEGER is
			-- Intensity value for the red component
		do
			Result := implementation.red
		end

	green: INTEGER is
			-- Intensity value for the green component
		do
			Result := implementation.green
		end

	blue: INTEGER is
			-- Intensity value for the blue component
		do
			Result := implementation.blue
		end

feature -- Element change

	set_rgb (a_red, a_green, a_blue: INTEGER) is
			-- Make `a_red', `a_green' and `a_blue' the new
			-- `red', `green' and `blue' value.
		require
			valid_red_inf: a_red >= 0
			valid_red_sup: a_red <= 255
			valid_green_inf: a_green >= 0
			valid_green_sup: a_green <= 255
			valid_blue_inf: a_blue >= 0
			valid_blue_sup: a_blue <= 255
		do
			implementation.set_rgb (a_red, a_green, a_blue)
		ensure
			red_set: red = a_red
			green_set: green = a_green
			blue_set: blue = a_blue
		end

	set_red (value: INTEGER) is
			-- Make `value' the new `red' value.
		require
			valid_red_inf: value >= 0
			valid_red_sup: value <= 255
		do
			implementation.set_red (value)
		ensure
			red_set: red = value
		end

	set_green (value: INTEGER) is
			-- Make `value' the new `green' value.
		require
			valid_green_inf: value >= 0
			valid_green_sup: value <= 255
		do
			implementation.set_green (value)
		ensure
			green_set: green = value
		end

	set_blue (value: INTEGER) is
			-- Make `value' the new `blue' value.
		require
			valid_blue_inf: value >= 0
			valid_blue_sup: value <= 255
		do
			implementation.set_blue (value)
		ensure
			blue_set: blue = value
		end

feature -- Implementation

	implementation: EV_COLOR_I
			-- Implementation of color

feature {EV_DEFAULT_COLORS_IMP} -- Initialization

	set_implementation (color_imp: EV_COLOR_IMP) is
			-- Set a color thanks to an implementation color
		do
			implementation ?= color_imp
			implementation.set_interface (Current)
		end

--invariant
--	valid_implementation: implementation /= Void

end -- class EV_COLOR

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
