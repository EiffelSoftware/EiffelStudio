indexing
	description: "Test of tests."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	prepare is
		do
			first_window.set_title ("Main window")
		end

	first_window: EV_TITLED_WINDOW is
		once
			create Result
		end

end -- class TEST_TEST
