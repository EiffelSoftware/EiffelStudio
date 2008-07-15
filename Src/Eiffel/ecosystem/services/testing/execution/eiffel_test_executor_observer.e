indexing
	description: "[
		An observer for events in {EIFFEL_TEST_EXECUTOR_I}.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_EXECUTOR_OBSERVER

inherit
	ACTIVE_COLLECTION_OBSERVER [!EIFFEL_TEST_I]
		rename
			on_item_added as on_test_added,
			on_item_changed as on_test_changed
		end

feature {EIFFEL_TEST_EXECUTOR_I} -- Events

	on_test_launched (a_executor: !EIFFEL_TEST_EXECUTOR_I)
			-- Called after test has been launched
			--
			-- `a_executor': Executor triggering event
		require
			usable: is_interface_usable
			a_executor_usable: a_executor.is_interface_usable
			a_executor_testing: a_executor.is_testing
		do
		end

	on_test_finished (a_executor: !EIFFEL_TEST_EXECUTOR_I; a_test: !EIFFEL_TEST_I)
			-- Called after a new outcome for current test has been produced
			--
			-- `a_executor': Executor triggering event
		require
			is_interface_usable: is_interface_usable
			a_executor_usable: a_executor.is_interface_usable
			a_executor_running: a_executor.is_testing
			test_has_outcome: a_test.is_outcome_available
		do
		end

	on_cleaning_up (a_executor: EIFFEL_TEST_EXECUTOR_I)
			-- Called after executor started cleaning up after an execution session
			--
			-- `a_executor': Executor triggering event
		require
			is_interface_usable: is_interface_usable
			a_executor_usable: a_executor.is_interface_usable
			a_executor_cleaning_up: a_executor.is_cleaning_up
		do
		end

end
