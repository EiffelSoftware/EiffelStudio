indexing
	description: "EiffelVision button event data.% 
	%Class for representing button event data";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_BUTTON_EVENT_DATA
	
inherit
	
	EV_EVENT_DATA	
		redefine
			make_and_initialize,
			implementation,
			print_contents
		end
	
	
creation
	make_and_initialize
	
feature {NONE} -- Initialization
	
	make_and_initialize (p: POINTER) is
		do
			!EV_BUTTON_EVENT_DATA_IMP!implementation.make_and_initialize (Current, p)
		end

feature -- Access	
	
	x: DOUBLE
			-- x coordinate of mouse pointer 
	y: DOUBLE 
			-- y coordinate of mouse pointer 
	state: INTEGER
	button: INTEGER
	keyval: INTEGER

feature {EV_BUTTON_EVENT_DATA_I} -- Element change
	
	set_x (new_x: DOUBLE) is
		do
			x := new_x
		end
	
	set_y (new_y: DOUBLE) is
		do
			y := new_y
		end
	
	set_state (new_state: INTEGER) is
		do
			state := new_state
		end
	
	set_button (new_button: INTEGER) is
		do
			button := new_button
		end
	
	set_keyval (new_keyval: INTEGER) is
		do
			keyval := new_keyval
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
			io.put_string (")%N")		
		end
	
	
	
feature {NONE} -- Implementation
	
	implementation: EV_BUTTON_EVENT_DATA_I
	
end
			
	
