note
	description: "Summary description for {TEST_ENVIRONEMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_ENVIRONMENT

inherit
	EV_ENVIRONMENT
		redefine
			create_implementation
		end

feature

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {TEST_ENVIRONMENT_IMP} implementation.make
		end

end
