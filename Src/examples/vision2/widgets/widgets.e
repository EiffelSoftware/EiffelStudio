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