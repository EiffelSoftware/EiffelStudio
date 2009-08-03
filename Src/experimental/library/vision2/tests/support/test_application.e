note
	description: "Summary description for {TEST_APPLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_APPLICATION

inherit
	EV_APPLICATION
		redefine
			create_implementation,
			launch
		end

feature

	launch
			-- Start the application.
			-- This begins the event processing loop.
		do
			is_launched := True
			implementation.launch
		end

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		local
			l_environment: TEST_ENVIRONMENT
		do
				-- Set the application implementation object from the shared one in EV_ENVIRONMENT.
			create l_environment
			implementation := l_environment.implementation.application_i
		end

end
