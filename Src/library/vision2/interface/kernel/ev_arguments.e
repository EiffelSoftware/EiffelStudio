indexing
	description: "EiffelVision EV_ARGUMENTS. Base class for command arguments";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class 
	EV_ARGUMENTS 

inherit
	EV_GTK_EXTERNALS
	
feature -- Initialization
	
feature -- Status setting
	
	set_event_data (p: POINTER) is
		do
			io.put_string ("Type: ")
			io.put_integer (c_gdk_event_type (p))	
			io.put_string ("%N")
			
			-- Temporary
			if c_gdk_event_type (p) = 3 then
				!EV_MOTION_EVENT_DATA! data.make (p)
			elseif c_gdk_event_type (p) = 4 then
				!EV_BUTTON_EVENT_DATA! data.make (p)
			else
				io.put_string ("%NWarning: no event, %
					       %creating the default!%N")
			
				!!data.make (p)
			end
		end

	
feature -- Access
	
	data: EV_EVENT_DATA
	
	set_event_data_address: POINTER is
			-- Address of feature set_event_data
		do
			Result := routine_address ($set_event_data)
		end
	
	
end -- class EV_ARGUMENTS
