indexing
	description: "[
		Interface of a basic test
		
		The basic representation of a test consists of a name and a list
		of tags. It also stores information about passed execution and
		therefor it can be directly queried whether the implemention
		being tested passes or fails the test.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_I

inherit
	TAGABLE_I

feature -- Access

	name: !STRING_32
			-- Name of the test
		require
			usable: is_interface_usable
		deferred
		end

	outcomes: !DS_BILINEAR [like last_outcome]
			-- Test results from passed executions where
			-- the last is the most recent one.
		require
			usable: is_interface_usable
		deferred
		end

	last_outcome: !TEST_OUTCOME_I
			-- Last test result if `Current' has been tested
		require
			usable: is_interface_usable
			is_tested
		do
			Result := outcomes.last
		ensure
			result_is_last: Result = outcomes.last
		end

feature -- Query

	is_tested: BOOLEAN
			-- Has `Current' been tested yet?
		require
			usable: is_interface_usable
		do
			Result := not outcomes.is_empty
		end

	passed: BOOLEAN
			-- Has `Current' passed the last execution?
		require
			usable: is_interface_usable
			tested: is_tested
		do
			Result := outcomes.last.is_pass
		end

	failed: BOOLEAN
			-- Has `Current' failed the last execution?
		require
			usable: is_interface_usable
			tested: is_tested
		do
			Result := outcomes.last.is_fail
		end

end
