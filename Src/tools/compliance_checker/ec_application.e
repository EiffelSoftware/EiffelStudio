indexing
	description: "[
		Actual application entry point.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_APPLICATION

inherit
	EV_APPLICATION

create
	make_and_launch
	
feature {NONE} -- Initialization

	make_and_launch is
			-- Create `Current', build and display `main_window',
			-- then launch the application.
		local
			l_x: INTEGER
			l_y: INTEGER
			l_screen: EV_SCREEN
			l_window: EC_MAIN_WINDOW
		do
			default_create
			
			create l_window
			create l_screen
			l_x := ((l_screen.width / 2).floor - (l_window.width / 2).floor)
			l_y := ((l_screen.height / 2).floor - (l_window.height / 2).floor)
			l_window.set_position (l_x, l_y)
			l_window.show
			
			launch
		end
		
		l: EC_CHECK_WORKER
		
feature {NONE} -- Implementation

	main_window: EC_MAIN_WINDOW
		-- Main window of `Current'.

end -- class EC_APPLICATION
