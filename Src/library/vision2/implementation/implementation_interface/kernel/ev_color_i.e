indexing
	description: "Eiffel Vision color. Implementation interface";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	EV_COLOR_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature {NONE} -- Initialization

	make is
			-- Create a color. 
		deferred			
		end

	make_rgb (a_red, a_green, a_blue: INTEGER) is
			-- Create the color corresponding to the given name.
		deferred
		end

feature -- Access

	interface: EV_COLOR
			-- Interface of the current color.

	red: INTEGER is
			-- Intensity value for the red component
		deferred
		end

	green: INTEGER is
			-- Intensity value for the green component
		deferred
		end

	blue: INTEGER is
			-- Intensity value for the blue component
		deferred
		end

	name: STRING
			-- Current name of the color.

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
		deferred
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
		deferred
		ensure
			red_set: red = value
		end

	set_green (value: INTEGER) is
			-- Make `value' the new `green' value.
		require
			valid_green_inf: value >= 0
			valid_green_sup: value <= 255
		deferred
		ensure
			green_set: green = value
		end

	set_blue (value: INTEGER) is
			-- Make `value' the new `blue' value.
		require
			valid_blue_inf: value >= 0
			valid_blue_sup: value <= 255
		deferred
		ensure
			blue_set: blue = value
		end

	set_name (txt: STRING) is
			-- Make `txt' the new name.
		require
			valid_name: txt /= Void
		do
			name := txt
		ensure
			name_set: name = txt
		end

end -- class EV_COLOR_I

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
