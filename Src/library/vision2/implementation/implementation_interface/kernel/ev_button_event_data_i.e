indexing
	description: "EiffelVision button event data. Implementation interface";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	EV_BUTTON_EVENT_DATA_I

inherit
	
	EV_EVENT_DATA_I	
		redefine
			interface
		end
	

feature {NONE} -- Implementation
	
	interface: EV_BUTTON_EVENT_DATA	
	
end
			
	
