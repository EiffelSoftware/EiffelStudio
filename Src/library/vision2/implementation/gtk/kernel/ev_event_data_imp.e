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
	
feature -- Initialization
	
	initialize (p: POINTER) is
			-- Initialize the object according to C 
			-- pointer 'p'
		do
				-- Initialize widget here XXXX
		end	
	
	initialize_address: POINTER is
			-- Address of feature initialize
		do
			Result := routine_address ($initialize)
		end
	
feature {EV_EVENT_DATA} -- Implementation	
	 	
	-- Temporary
 	-- GDK
 	c_gdk_event_type (event: POINTER): INTEGER is
 		external 
 			"C [macro %"gdk_eiffel.h%"]"
 		end
	

 	
end

	
