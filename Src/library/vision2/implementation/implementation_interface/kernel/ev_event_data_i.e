indexing
	description: "EiffelVision event data. Implementation interface";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_EVENT_DATA_I
	
feature {NONE}  -- Creation
	
		
	make (parent: EV_EVENT_DATA) is
			-- Creation and initialization of 'parent's 
			-- fields according to C pointer 'p'	
		do
			interface := parent		
		end

	
feature {NONE} -- Implementation
	
	interface: EV_EVENT_DATA
end
			
	
