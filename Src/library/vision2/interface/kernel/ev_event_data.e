indexing
	description: "EiffelVision event data. Information given by EiffelVision when a callback is triggered. Base class for representing%
	%event data";
	status: "See notice at end of class";
	id: "$Id$";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_EVENT_DATA
	
creation
	make
	
feature {NONE}  -- Initialization
	
	make (p: POINTER) is
		do
			-- Initialize widget XX
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
	
end
			
	
