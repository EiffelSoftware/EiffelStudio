indexing
	description: "EiffelVision motion event data. Implementation interface";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_MOTION_EVENT_DATA_I

inherit	
	EV_EVENT_DATA_I
		redefine
			print_contents
		end	

feature -- Access	
	
	x: INTEGER
			-- x coordinate of mouse pointer 

	y: INTEGER
			-- y coordinate of mouse pointer 

	state: INTEGER
			-- State of the mouse buttons
	
feature -- Element change

	set_x (value: INTEGER) is
			-- Make `value' the new x.
		do
			x := value
		end

	set_y (value: INTEGER) is
			-- Make `value' the new y.
		do
			y := value
		end

	set_state (value: INTEGER) is
			-- Make `value' the new state.
		do
			state := value
		end

feature -- Debug
	
	print_contents is
			-- print the contents of the object
		do
			io.put_string ("(X: ")
			io.put_double (x)
			io.put_string (", Y: ")			
			io.put_double (y)
			io.put_string (") State: ")			
			io.put_double (State)
			io.put_string ("%N")		
		end

end -- class EV_MOTION_EVENT_DATA_I

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
