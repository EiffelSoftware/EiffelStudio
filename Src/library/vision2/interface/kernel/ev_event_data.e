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
	
end -- clasds EV_EVENT_DATA

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

			
	
