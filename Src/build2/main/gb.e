indexing
	description: "Graphical builder application."
	date : "$Date$"
	id : "$Id$"
	revision : "$Revision$"

class
	GB

inherit

	EV_APPLICATION
		redefine
			initialize
		end

create
	execute

feature {NONE} -- Initialization

	execute is
		do
			default_create
			main_window.show
			launch	
		end
		
	initialize is
			-- `Initialize `Current'.
		do
			Precursor {EV_APPLICATION}
			-- Any General initialization can be added here.
			-- This will be executed before the program is launched.
		end
		
	main_window: GB_MAIN_WINDOW is
			-- `Result' is main window of `Current'.
		once
			create Result
		end

end