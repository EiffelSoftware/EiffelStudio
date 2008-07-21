indexing
	description: "[
					  Objects that represent a test case. To add a test case
					  to the system:
						 - Create a new class, whose name contains the word 'TEST'
						 - Let it inherit from CDD_TEST_CASE
						 - Add routines that start with 'test_'
						 - Redefine `set_up' and `tear_down' if you need to do things before resp. after each test routine.
					  ]"
	author: "fivaa"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CDD_TEST_CASE

inherit
	CDD_ASSERTION_ROUTINES

feature -- Basic operations

	set_up is
			-- Setup test case. Called by test harness
			-- before each test routine invocation. Redefine
			-- this routine in descendants.
		do
		end

	tear_down is
			-- Tear down test case. Called by test harness
			-- before each test routine invocation. Redefine
			-- this routine in descendants.
		do
		end

end
