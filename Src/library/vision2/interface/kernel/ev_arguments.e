indexing
	description: "EiffelVision EV_ARGUMENTS. Base class for command arguments";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class 
	EV_ARGUMENTS 


	
feature -- Access
	
	data: EV_EVENT_DATA
	
	
feature {EV_WIDGET_I} -- Element change
	
	set_data (d: EV_EVENT_DATA) is		
		do
			data := d
		end
	
end -- class EV_ARGUMENTS
