indexing
	description: "EiffelVision EV_ARGUMENTS. Base class for command arguments";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class 
	EV_ARGUMENTS 


feature -- Initialization
	
feature -- Status setting
	
	set_event_data (p: POINTER) is
		do
			-- Do we have data associated with this event
			if data /= Void then
				data.initialize (p)
			end
		end

	
feature -- Access
	
	data: EV_EVENT_DATA
	
	set_event_data_address: POINTER is
			-- Address of feature set_event_data
		do
			Result := routine_address ($set_event_data)
		end
	
feature {EV_WIDGET_I} -- Element change
	
	set_data (d: EV_EVENT_DATA) is		
		do
			data := d
		end
	
feature {NONE} -- Implementation
	
	routine_address (routine: POINTER): POINTER is
		do
			Result := routine
		end
end -- class EV_ARGUMENTS
