indexing
	description: "EiffelVision motion event data. Gtk implementation";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_MOTION_EVENT_DATA_IMP
	
inherit
	EV_MOTION_EVENT_DATA_I
	
	EV_EVENT_DATA_IMP
		redefine
			make_and_initialize,
			print_contents
		end
	
	
creation
	make_and_initialize
	
feature {NONE} -- Initialization
	
	make_and_initialize (parent: EV_MOTION_EVENT_DATA; p: POINTER) is
			-- Creation and initialization of 'parent's 
			-- fields according to C pointer 'p'
		do
			Precursor (parent, p)			
			parent.set_x (c_gdk_event_x (p))
			parent.set_y (c_gdk_event_y (p))
			parent.set_state (c_gdk_event_state (p))
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
	
end
			
	
