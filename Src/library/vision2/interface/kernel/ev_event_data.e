indexing
	description: "EiffelVision event data. Information given by% 
	%EiffelVision when a callback is triggered.%
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
			!EV_EVENT_DATA_IMP!implementation.make (Current)
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

feature {EV_WIDGET_IMP, EV_WEL_COMMAND} -- Implementation
	
	implementation: EV_EVENT_DATA_I
	
end
			
	
