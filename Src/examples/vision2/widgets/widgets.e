indexing
	description: 
		"Vision2 widget test application"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
