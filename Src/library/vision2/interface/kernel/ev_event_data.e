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
	make, make_and_initialize
	
feature {NONE}  -- Initialization
	
	make (p: POINTER) is
		do
			-- Initialize implementation
			!EV_EVENT_DATA_IMP!implementation.make
		end
	
	make_and_initialize (p: POINTER) is
		do
			!EV_EVENT_DATA_IMP!implementation.make_and_initialize (Current, p)
		end
	
feature -- Metamorphosis
	
	metamorphosis (p: POINTER): EV_EVENT_DATA is
		do
			Result := implementation.metamorphosis (p)
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
			
	
