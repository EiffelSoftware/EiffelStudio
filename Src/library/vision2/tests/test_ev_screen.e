note
	description: "Tests for EV_SCREEN"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_SCREEN

inherit
	VISION2_TEST_SET

feature -- Test routines

	test_creation
			-- New test routine
		local
			main: EV_SCREEN
		do
			create main.default_create
		end

end
