indexing
	description: "EiffelVision event data. Information given by% 
	%EiffelVision when a callback is triggered. Type of event is% 
	%determined byt the C pointer 'p' in the creation routine.%
	%This is the base class for representing event data";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_EVENT_DATA
	
creation
	make
	
feature {NONE}  -- Creation
	
	make is
		do
			-- do nothing, because the initialization is 
			-- done in 'Initialize'
		end
	
feature -- Initialization
	
	initialize (p: POINTER) is
			-- Initialize from c using C pointer 'p'
		do
			!EV_EVENT_DATA_IMP!implementation.make (Current, p)
		end
	
		
feature -- Access
	
	widget: EV_WIDGET
			-- The mouse pointer was over this widget 
			-- when event happened
	
feature -- Debug
	
	print_contents is
		do
			io.put_string ("EV_EVENT_DATA: ")
			print (widget)
			io.put_string ("%N")
		end
	
feature {NONE} -- Implementation
	
	implementation: EV_EVENT_DATA_I
	
end
			
	
