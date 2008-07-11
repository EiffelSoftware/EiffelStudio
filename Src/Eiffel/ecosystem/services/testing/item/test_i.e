indexing
	description: "[
		Interface of a test that can be executed and contains a list of outcomes resulting from passed
		executions.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_I

inherit
	TAGABLE_I

feature -- Access

	name: !STRING
			-- Name of the test
		require
			usable: is_interface_usable
		deferred
		ensure
			result_not_empty: not name.is_empty
		end

	outcomes: !DS_BILINEAR [like last_outcome]
			-- Test results from passed executions where
			-- the last is the most recent one.
		require
			usable: is_interface_usable
			has_been_tested: is_outcome_available
		deferred
		end

	last_outcome: !TEST_OUTCOME_I
			-- Last test result if `Current' has been tested
		require
			usable: is_interface_usable
			has_been_tested: is_outcome_available
		do
			Result := outcomes.last
		ensure
			result_is_last: Result = outcomes.last
		end

	executor: !TEST_EXECUTOR_I
			-- Executor running `Current' or having `Current' queued.
		require
			queued_or_tested: is_queued or is_running
		deferred
		ensure
			result_running: Result.is_running
			is_queued_implies_queued: Result.tests.has (Current)
			is_running_implies_current: Result.current_test = Current
		end

feature -- Status report

	is_queued: BOOLEAN
			-- Is some implementation about to be tested by `Current'?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_not_running: Result implies not is_running
		end

	is_running: BOOLEAN
			-- Is some implementation beeing tested by `Current'?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_not_queued: Result implies not is_queued
			executor_testing: executor.is_testing
			executor_testing_result: executor.current_test = Current
		end

	is_outcome_available: BOOLEAN
			-- Has `Current' been executed yet?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_outcomes_attached: Result implies outcomes /= Void
		end

	passed: BOOLEAN
			-- Has `Current' passed the last execution?
		require
			usable: is_interface_usable
			has_been_tested: is_outcome_available
		do
			Result := outcomes.last.is_pass
		end

	failed: BOOLEAN
			-- Has `Current' failed the last execution?
		require
			usable: is_interface_usable
			has_been_tested: is_outcome_available
		do
			Result := outcomes.last.is_fail
		end

end
