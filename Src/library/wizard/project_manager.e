indexing
	description: "Class which is launching the application."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECT_MANAGER

inherit
	EV_APPLICATION

	SHARED
		undefine
			default_create
		end

Creation
	make_and_launch

feature -- Initialization

	prepare is
			-- Prepare the first window to be displayed.
			-- Perform one call to first window in order to
			-- avoid to violate the invariant of class EV_APPLICATION.
		do
			first_window.set_title("Wizard Version 1.1")
		end 
 	
end -- class PROJECT_MANAGER
