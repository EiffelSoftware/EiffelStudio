indexing

	description: 
		"Two dimensional point.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_POINT

creation
	make

feature {NONE} -- Initialization

	make (an_x, a_y: INTEGER) is
			-- Create a two dimensions point.
		do
			x := an_x;
			y := a_y
		ensure
			x_set: x = an_x;
			y_set: y = a_y
		end;

feature -- Access

	x: INTEGER;

	y: INTEGER

feature -- Element change

	set_x (a_x: INTEGER) is
			-- Change the x coordinate of the point.
		do
			x := a_x
		ensure
			x_set: x = a_x
		end;

	set_y (a_y: INTEGER) is
			-- Change the y coordinate of the point.
		do
			y := a_y
		ensure
			y_set: y = a_y
		end;

end -- class MEL_POINT


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

