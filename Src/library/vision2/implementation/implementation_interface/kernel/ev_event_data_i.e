indexing
	description: "EiffelVision event data. Implementation interface";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_EVENT_DATA_I
	
feature {NONE}  -- Initialization
	
		
	make (parent: EV_EVENT_DATA; p: POINTER) is
			-- Creation and initialization of 'parent's 
			-- fields according to C pointer 'p'	
		deferred
		end

end
			
	
