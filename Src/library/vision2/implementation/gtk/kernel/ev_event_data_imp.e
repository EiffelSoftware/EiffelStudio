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
	make, make_and_initialize
	
feature {NONE}  -- Initialization
	
	make is
			-- Create temporary object to be able to 
			-- determine the actual type of the object 
			-- from a given C pointer
		do
		end
	
	make_and_initialize (parent: EV_EVENT_DATA; p: POINTER) is
			-- Creation and initialization of 'parent's 
			-- fields according to C pointer 'p'
		do
			-- Initialize widget here XXXX

			-- Temporary
			io.put_string ("Type: ")
			io.put_integer (c_gdk_event_type (p))	
			io.put_string ("%N")
		end
	
feature {EV_EVENT_DATA} -- Metamorphosis
	
	metamorphosis (p: POINTER): EV_EVENT_DATA is	
			-- Event data object which type is determined 
			-- by p.
		do
			-- Change manifest constants!
			if c_gdk_event_type (p) = 3 then
				!EV_MOTION_EVENT_DATA! Result.make_and_initialize (p)
			elseif c_gdk_event_type (p) = 4 then
				!EV_BUTTON_EVENT_DATA! Result.make_and_initialize (p)
			else
				io.put_string ("%NWarning: no event, %
					       %creating the default!%N")
			
				!!Result.make_and_initialize (p)
			end	
		
		end

feature {EV_EVENT_DATA} -- Implementation	
	
	-- GDK
	c_gdk_event_type (event: POINTER): INTEGER is
		external 
			"C [macro %"gdk_eiffel.h%"]"
		end
	
	
end

	
