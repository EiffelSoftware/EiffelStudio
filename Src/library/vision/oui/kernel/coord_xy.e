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
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

