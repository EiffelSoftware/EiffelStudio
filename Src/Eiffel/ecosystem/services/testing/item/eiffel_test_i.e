indexing
	description: "[
		Interface of a test that can be executed and contains a list of outcomes resulting from passed
		executions.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_I

inherit
	TAGABLE_I

feature -- Access

	name: !STRING
			-- Test routine name
		require
			usable: is_interface_usable
		deferred
		ensure
			result_not_empty: not Result.is_empty
		end

	class_name: !STRING
			-- Name of class in which `Current' is defined
		require
			usable: is_interface_usable
		deferred
		end

	outcomes: !DS_BILINEAR [like last_outcome]
			-- Test results from passed executions where the last is the most recent one.
		require
			usable: is_interface_usable
			has_been_tested: is_outcome_available
		deferred
		end

	last_outcome: !EIFFEL_TEST_OUTCOME_I
			-- Last test result if `Current' has been tested
		require
			usable: is_interface_usable
			has_been_tested: is_outcome_available
		do
			Result := outcomes.last
		ensure
			result_is_last: Result = outcomes.last
		end

	executor: !EIFFEL_TEST_EXECUTOR_I
			-- Executor running `Current' or having `Current' queued.
		require
			queued_or_running: is_queued or is_running
		deferred
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

feature {EIFFEL_TEST_SUITE_S} -- Status report

	have_tags_changed: BOOLEAN
			-- Have tags changed due to call to `add_outcome' or `update_tags'.
		require
			usable: is_interface_usable
		deferred
		end

feature {EIFFEL_TEST_EXECUTOR_I} -- Status setting

	set_queued (a_executor: like executor) is
			-- Set `Current' to be queued by an executor
			--
			-- `a_executor': Executor set to run `Current'.
		require
			usable: is_interface_usable
			not_queued_or_running: not (is_queued or is_running)
		deferred
		ensure
			queued: is_queued
			executor_set: executor = a_executor
		end

	set_ran
			-- Set `is_running' to True.
		require
			usable: is_interface_usable
			queued: is_queued
		deferred
		ensure
			running: is_running
		end

	abort
			-- Set `is_queued' and `is_running' to False.
		require
			usable: is_interface_usable
			queued_or_running: is_queued or is_running
		deferred
		ensure
			not_queued_or_running: not (is_queued or is_running)
		end

	add_outcome (a_outcome: like last_outcome)
			-- Add outcome to end of outcomes list.
			--
			-- `a_outcome': Outcome to be added to the end of `outcomes'.
		require
			usable: is_interface_usable
		deferred
		ensure
			outcome_available: is_outcome_available
			a_outcome_last: last_outcome = a_outcome
			not_queued_or_running: not (is_queued or is_running)
		end

feature {EIFFEL_TEST_SUITE_S} -- Status setting

	update_explicit_tags (a_list: like tags)
		require
			usable: is_interface_usable
		deferred
		end

end
