note
	description: "Some additions to EV_APPLICATION which make testing easy as pie."
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"

	-- TODO: It may be a good idea to only allow the creation of a new application implementation object when the old one has been destroyed.
	--       We could possibly even create the new one automatically in that case.

class
	TEST_APPLICATION

inherit
	EV_APPLICATION
		redefine
			create_implementation,
			launch
		end

create
	default_create,
	make_new

feature

	make_new
			-- Always creates a completely new application object instead of reusing the existing one
		do
			create_new := True
			default_create
		end

	launch
			-- Start the application.
			-- This begins the event processing loop.
		do
			is_launched := True
			implementation.launch
		end

	create_implementation
			-- We allow the creation of new application-objects
		local
			l_environment: TEST_ENVIRONMENT
			l_environement_imp: detachable TEST_ENVIRONMENT_IMP
		do
			if create_new then
					-- Create a new application implementation object and set it in TEST_ENVIRONMENT.
				create {TEST_APPLICATION_IMP}implementation.make
				create l_environment
				l_environement_imp ?= l_environment.implementation
				check l_environement_imp /= Void end
				l_environement_imp.set_application_i (implementation)
			else
					-- Set the application implementation object from the shared one in TEST_ENVIRONMENT.
				create l_environment
				implementation := l_environment.implementation.application_i
			end
		end

feature {NONE} -- Implementation

	create_new: BOOLEAN
			-- Indicates whether a new application should be created in create_implementation

end
