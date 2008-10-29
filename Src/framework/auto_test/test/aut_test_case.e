indexing

	description:

		"AutoTest manual unit test cases"

	library: "AutoTest Library"
	copyright: "Copyright (c) 2006, Andresa Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

deferred class AUT_TEST_CASE

feature -- Execution

	set_up is
			-- Setup for a test.
			-- (Can be redefined in descendant classes.)
		do
		end

	tear_down is
			-- Tear down after a test.
			-- (Can be redefined in descendant classes.)
		do
		end

end
