indexing
	description: "EiffelVision coordinate pair (x, y)";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_POINT
	
inherit
	ANY
				
creation
	make,
	set

feature {NONE} -- Initialization

	make is
			-- A feature to be consistant, but nothing to do.
		do
		end
	
feature -- Access

	x: INTEGER
			-- Value of horizontal position.

	y: INTEGER
			-- Value of vertical position.

feature -- Element change

	set (new_x, new_y: INTEGER) is
			-- Set position
		do
			x := new_x
			y := new_y
		ensure
			x_set: x = new_x 
			y_set: y = new_y
		end
	
feature -- Debug
	
	print_contents is
		do
			io.put_string ("(X: ")
			print (x)
			io.put_string (", Y: ")
			print (y)
			io.put_string (")%N")
		end
	

end -- class EV_POINT

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

