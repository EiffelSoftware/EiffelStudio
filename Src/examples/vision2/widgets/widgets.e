indexing
	description: 
		"Vision2 widget test application"
	status: "See notice at end of class"
	keywords: "test"
	date: "$Date$"
	revision: "$Revision$"
	
class
	WIDGETS

inherit
	EV_APPLICATION 

create
	start

feature -- Initialization

	main_window: MAIN_WINDOW
		-- The window used in `Current'.

	start is
			-- Create the application, set up `main_window'
			-- and then launch the application.
		do
			default_create
			create main_window
			launch
		end

end
--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

