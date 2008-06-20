indexing
	description: "[
		An observer for events implemented on a {TEST_EXECUTOR_I} service interface.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_EXECUTOR_OBSERVER

inherit
	EVENT_OBSERVER_I

feature {TEST_EXECUTOR_I} -- Events

	on_preparing (a_executor: !TEST_EXECUTOR_I)
			-- Called when an executor starts preparing a test execution
		require
			is_interface_usable: is_interface_usable
			a_executor_usable: a_executor.is_interface_usable
			a_executor_preparing: a_executor.is_preparing
		do
		end

	on_testing (a_executor: !TEST_EXECUTOR_I)
			-- Called before an executor runs a single test
		require
			is_interface_usable: is_interface_usable
			a_executor_usable: a_executor.is_interface_usable
			a_executor_testing: a_executor.is_testing
		do
		end

	on_tested (a_executor: !TEST_EXECUTOR_I) is
			-- Called after an executor has ran a test and therefor
			-- a new outcome is available for that test
		require
			is_interface_usable: is_interface_usable
			a_executor_usable: a_executor.is_interface_usable
			a_executor_testing: a_executor.is_testing
			test_has_outcome: not a_executor.current_test.outcomes.is_empty
		do
		end

	on_cleaning_up (a_executor: TEST_EXECUTOR_I)
			-- Called when an executor is finished executing tests
			-- and performing some cleaning up tasks
		require
			is_interface_usable: is_interface_usable
			a_executor_usable: a_executor.is_interface_usable
			a_executor_cleaning_up: a_executor.is_cleaning_up
		do
		end

	on_finished (a_executor: TEST_EXECUTOR_I)
			-- Called when an executor has finished testing
		require
			is_interface_usable: is_interface_usable
			a_executor_usable: a_executor.is_interface_usable
			a_executor_not_running: not a_executor.is_running
		do
		end

end
