indexing
	description: "EiffelVision key event data. Gtk implementation";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_KEY_EVENT_DATA_IMP
	
inherit
	EV_KEY_EVENT_DATA_I
		select
			interface
		end
	
	EV_EVENT_DATA_IMP
		rename
			interface as x_interface
		redefine
			initialize
		end
	
	
creation
	make
	

feature -- Initialization
	
		initialize (p: POINTER) is
			-- Creation and initialization of 'parent's 
			-- fields according to C pointer 'p'
		local
			c_str: POINTER
			str: STRING
			
		do
			Precursor (p)			
			interface.set_state (c_gdk_event_state (p))
			interface.set_keyval (c_gdk_event_keyval (p))
			interface.set_length (c_gdk_event_length (p))
			
			c_str := c_gdk_event_string (p)
			!!str.make (0)
			str.from_c (c_str)
			interface.set_string (str)
		end
	
end
			
	
