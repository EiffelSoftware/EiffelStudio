indexing
	description: "EiffelVision button event data. Implementation interface";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_BUTTON_EVENT_DATA_I

inherit
	EV_EVENT_DATA_I	
		redefine
			print_contents
		end	

feature -- Access	
	
	x: INTEGER
			-- x coordinate of mouse pointer relative to widget

	y: INTEGER
			-- y coordinate of mouse pointer relative to widget

	absolute_x: INTEGER is
			-- absolute x of the mouse pointer
		deferred
		end

	absolute_y: INTEGER is
			-- absolute y of the mouse pointer
		deferred
		end

	state: INTEGER
			-- ??

	button: INTEGER
			-- Button pressed

	keyval: INTEGER
			-- ??

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
	
	set_button (value: INTEGER) is
			-- Make `value' the new button.
		do
			button := value
		end

feature -- Debug
	
	print_contents is
			-- print the contents of the object
		do
			io.put_string ("(X: ")
			io.put_double (x)
			io.put_string (", Y: ")			
			io.put_double (y)
			io.put_string (") Button: ")			
			io.put_integer (button)
			io.put_string (" State: ")			
			io.put_integer (state)
			io.put_string ("%N")		
		end

end -- class EV_BUTTON_EVENT_DATA_I

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
