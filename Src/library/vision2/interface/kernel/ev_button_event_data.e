indexing
	description: "EiffelVision button event data.% 
	%Base class for representing event data";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_BUTTON_EVENT_DATA
	
inherit
	
	EV_EVENT_DATA	
		redefine
			make,
			print_contents
		end
	
	
creation
	make
	
feature {NONE} -- Initialization
	
	make (p: POINTER) is
		do
			x := c_gdk_event_x (p)
			y := c_gdk_event_y (p)
			state := c_gdk_event_state (p)
			button := c_gdk_event_button (p)
			keyval := c_gdk_event_keyval (p)
		end
	
	
feature -- Access	
	
	x: DOUBLE
			-- x coordinate of mouse pointer 
	y: DOUBLE 
			-- y coordinate of mouse pointer 
	state: INTEGER
	button: INTEGER
	keyval: INTEGER
	
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
	
	
	c_gdk_event_x  (p: POINTER): DOUBLE is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end
	
	c_gdk_event_y (p: POINTER): DOUBLE is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	c_gdk_event_state (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	c_gdk_event_button (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	c_gdk_event_keyval (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
			
end
			
	
