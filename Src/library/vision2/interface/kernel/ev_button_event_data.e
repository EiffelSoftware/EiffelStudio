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
			print_contents
		end
	
	
creation
	make
	
feature -- Access	
	
	x: DOUBLE is
			-- x coordinate of mouse pointer 
		do
			Result := c_x (item)
		end
	
	y: DOUBLE is
		do
			Result := c_y (item)
		end
	
	state: INTEGER is
		do
			Result := c_state (item)
		end
		
	button: INTEGER is
		do
			Result := c_button (item)
		end

	keyval: INTEGER is
		do
			Result := c_keyval (item)
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
	
	
	c_x  (p: POINTER): DOUBLE is
		external 
			"C [macro %"gtk_eiffel.h%"]"
		alias
			"GDK_EVENT_GET_X"
		end
	
	c_y (p: POINTER): DOUBLE is
		external 
			"C [macro %"gtk_eiffel.h%"]"
		alias
			"GDK_EVENT_GET_Y"
		end	
	
	c_state (p: POINTER): INTEGER is
		external 
			"C [macro %"gtk_eiffel.h%"]"
		alias
			"GDK_EVENT_GET_STATE"
		end	
	
	c_button (p: POINTER): INTEGER is
		external 
			"C [macro %"gtk_eiffel.h%"]"
		alias
			"GDK_EVENT_GET_BUTTON"
		end	
	
	c_keyval (p: POINTER): INTEGER is
		external 
			"C [macro %"gtk_eiffel.h%"]"
		alias
			"GDK_EVENT_GET_KEYVAL"
		end	
			
end
			
	
