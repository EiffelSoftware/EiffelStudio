indexing

	description: "Eiffel Vision color. Gtk implementation";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_COLOR_IMP

inherit
	EV_COLOR_I

creation
	make,
	make_rgb

feature {NONE} -- Initialization

	make is
			-- Create a color. 
		do			
		end

	make_rgb (a_red, a_green, a_blue: INTEGER) is
			-- Create the color corresponding to the given name.
		do
		end

feature -- Access

	red: INTEGER is
			-- Intensity value for the red component
		do
		end

	green: INTEGER is
			-- Intensity value for the green component
		do
		end

	blue: INTEGER is
			-- Intensity value for the blue component
		do
		end

feature -- Element change

	set_rgb (a_red, a_green, a_blue: INTEGER) is
			-- Make `a_red', `a_green' and `a_blue' the new
			-- `red', `green' and `blue' value.
		do
		end

	set_red (value: INTEGER) is
			-- Make `value' the new `red' value.
		do
		end

	set_green (value: INTEGER) is
			-- Make `value' the new `green' value.
		do
		end

	set_blue (value: INTEGER) is
			-- Make `value' the new `blue' value.
		do
		end

end -- class EV_COLOR_IMP

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
