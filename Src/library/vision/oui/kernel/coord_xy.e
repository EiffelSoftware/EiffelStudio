indexing

	description: "Definition of a structure (x, y)";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	COORD_XY 

feature -- Access

	x: INTEGER;
			-- Value of horizontal position.

	y: INTEGER;
			-- Value of vertical position.

feature -- Element change

	set (new_x, new_y: INTEGER) is
			-- Set position
		do
			x := new_x;
			y := new_y
		ensure
			x_set: x = new_x 
			y_set: y = new_y
		end

end -- class COORD_XY

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

