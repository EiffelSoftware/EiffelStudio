indexing

	description: 
		"EiffelVision application. This class is used in every EiffelVision program. The purpose of the class is to initialize the underlying toolkit and hide the implementation specific details from the application developer."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_APPLICATION
	

feature {NONE} -- Initialization
	
	make is
		do
			!EV_APPLICATION_IMP!implementation.make
			-- Ensure the call to main_window
			if (main_window = Void) then end
			implementation.iterate
		end
	
feature	
	
	main_window: EV_WINDOW is
			-- Must be defined as a once funtion to create
			-- the application's main_window.
		deferred
		end
	
	
feature {NONE} -- Implementation
	
	implementation: EV_APPLICATION_I

end

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
