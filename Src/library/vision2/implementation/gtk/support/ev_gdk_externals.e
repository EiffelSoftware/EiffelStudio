indexing
	description: "External C routines for accessing gdk";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class EV_GDK_EXTERNALS

feature {NONE} -- GTK macros for casting types
	
	-- Events
	
 	c_gdk_event_type (event: POINTER): INTEGER is
 		external 
 			"C [macro %"gdk_eiffel.h%"]"
 		end	
	
	
	
	-- Button, Motion
	c_gdk_event_x  (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end
	
	c_gdk_event_y (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	c_gdk_event_state (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	-- Button
	c_gdk_event_button (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	-- Key
	c_gdk_event_keyval (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	

	c_gdk_event_length (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	c_gdk_event_string (p: POINTER): POINTER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end		
	
	-- Expose
	c_gdk_event_rectangle_x (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	c_gdk_event_rectangle_y (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	c_gdk_event_rectangle_width (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
	
	c_gdk_event_rectangle_height (p: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end	
end
