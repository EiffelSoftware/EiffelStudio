indexing
	description: "EiffelVision event data. Gtk implementation";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_EVENT_DATA_IMP

inherit
	EV_EVENT_DATA_I
	
	EV_GTK_EXTERNALS	
	
creation
	make
	
feature {NONE}  -- Initialization
	
	make (parent: EV_EVENT_DATA; p: POINTER) is
			-- Creation and initialization of 'parent's 
			-- fields according to C pointer 'p'
		do
			-- Initialize widget here XXXX

			-- Temporary
			io.put_string ("Type: ")
			io.put_integer (c_gdk_event_type (p))	
			io.put_string ("%N")
		end
	
	
feature {EV_EVENT_DATA} -- Implementation	
	 	
	-- Temporary
 	-- GDK
 	c_gdk_event_type (event: POINTER): INTEGER is
 		external 
 			"C [macro %"gdk_eiffel.h%"]"
 		end
 	
end

	
