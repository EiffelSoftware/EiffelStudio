indexing
	description: "EiffelVision expose event data. Gtk implementation";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_EXPOSE_EVENT_DATA_IMP
	
inherit
	EV_EXPOSE_EVENT_DATA_I
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
			c: EV_COORD
			rec: EV_RECTANGLE
		do
			Precursor (p)			
			
			!!c.set (c_gdk_event_rectangle_x (p), 
				 c_gdk_event_rectangle_y (p))

			!!rec.set (c, c_gdk_event_rectangle_width (p), 
				   c_gdk_event_rectangle_height (p))
			
			interface.set_clip_region (rec)

		end
	
			
end
			
	
