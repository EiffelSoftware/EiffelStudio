indexing
	description: "[
		General interface for asynchronously executing a list of tests.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_EXECUTOR_I

inherit
	EVENT_OBSERVER_CONNECTION_I [!TEST_EXECUTOR_OBSERVER]

feature -- Status report

	is_preparing: BOOLEAN
			-- Is `Current' preparing the actual test execution?
		require
			usable: is_interface_usable
		deferred
		end

	is_testing: BOOLEAN
			-- Is `Current' executing a test?
		require
			usable: is_interface_usable
		deferred
		end

	is_cleaning_up: BOOLEAN
			-- Has `Current' run all tests and is performing some cleaning up?
		require
			usable: is_interface_usable
		deferred
		end

	is_running: BOOLEAN
			-- Is `Current' performing any task?
		require
			usable: is_interface_usable
		do
			Result := is_preparing or is_testing or is_cleaning_up
		end

	is_ready: BOOLEAN
			-- Are we ready to perform any testing?
		require
			usable: is_interface_usable
		do
			Result := not is_running
		end

feature -- Query

	is_valid_test (a_test: !TEST_I): BOOLEAN
			-- Can `a_test' be executed by `Current'?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_usable: Result implies a_test.is_interface_usable
		end

	is_valid_list (a_list: !DS_LINEAR [!TEST_I]): BOOLEAN is
			-- Can all items of `a_list' be tested by `Current'?
		require
			usable: is_interface_usable
		do
			Result := a_list.for_all (agent is_valid_test)
		end

feature -- Access

	tests: !DS_LINEAR [!TEST_I]
			-- Tests which will be or have been tested in the current run
		require
			usable: is_interface_usable
			testing: is_running
		deferred
		ensure
			result_consistent: Result = tests
			result_contains_valid_items: Result.for_all (agent is_valid_test)
		end

	current_test: !TEST_I
			-- Test currently being executed
		require
			usable: is_interface_usable
			testing: is_testing
		deferred
		ensure
			result_in_tests: tests.has (Result)
		end

feature {TEST_SUITE_S} -- Execution

	run_tests (a_list: !DS_LINEAR [!TEST_I]) is
			-- Execute all tests in `a_list' asynchronously.
		require
			usable: is_interface_usable
			ready: is_ready
			a_list_contains_valid_items: a_list.for_all (agent is_valid_test)
		deferred
		ensure
			run_asynchronously: is_running
			tests_equals_a_list: tests.is_equal (a_list)
		end

	stop
			-- Terminate any task.
		require
			usable: is_interface_usable
			running: is_running
		deferred
		ensure
			not_running: not is_running
		end

feature -- Events

	preparing_event: EVENT_TYPE [TUPLE [executor: !TEST_EXECUTOR_I]]
			-- Called when `Current' starts preparing execution
		require
			usable: is_interface_usable
		deferred
		end

	testing_event: EVENT_TYPE [TUPLE [executor: !TEST_EXECUTOR_I]]
			-- Called when `Current' starts executing a test
		require
			usable: is_interface_usable
		deferred
		end

	tested_event: EVENT_TYPE [TUPLE [executor: !TEST_EXECUTOR_I]]
			-- Called when `Current' has finished executing a test and
			-- some outcome is available
		require
			usable: is_interface_usable
		deferred
		end

	cleaning_up_event: EVENT_TYPE [TUPLE [executor: !TEST_EXECUTOR_I]]
			-- Called when `Current' starts cleaning up after execution
		require
			usable: is_interface_usable
		deferred
		end

	finished_event: EVENT_TYPE [TUPLE [executor: !TEST_EXECUTOR_I]]
			-- Calles when `Current' is finished executing
		require
			usable: is_interface_usable
		deferred
		end

feature {NONE} -- Query

	events (a_observer: !TEST_EXECUTOR_OBSERVER): DS_ARRAYED_LIST [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE [ANY, TUPLE]]] is
			-- <Precursor>
		do
			create Result.make (5)
			Result.put_last ([preparing_event, agent a_observer.on_preparing])
			Result.put_last ([testing_event, agent a_observer.on_testing])
			Result.put_last ([tested_event, agent a_observer.on_tested])
			Result.put_last ([cleaning_up_event, agent a_observer.on_cleaning_up])
			Result.put_last ([finished_event, agent a_observer.on_finished])
		end

end
