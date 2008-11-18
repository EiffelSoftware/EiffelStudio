indexing
	description: "[
		Commander interface for interacting with eiffel test tools.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TEST_COMMANDER_I

feature -- Access

	test: !TEST_I
			-- Test currently beeing shown
		require
			active: is_active
		deferred
		end

feature -- Status report

	is_active: BOOLEAN
			-- Is a test currently beeing shown by the tool?
		deferred
		end

feature -- Basic operations

	show_test (a_test: !TEST_I)
			-- Display information about a test.
			--
			-- `a_test': Test for which information should be displayed.
		deferred
		ensure
			active: is_active
			test_set: test = a_test
		end

	remove_test
			-- Hide any information about current test.
		require
			active: is_active
		deferred
		ensure
			not_active: not is_active
		end

end
