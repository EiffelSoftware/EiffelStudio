indexing
	description: "[
		An interface of an executor taking a list of tests and queues them to later be run and determined
		whether the implementation under test has passed or failed the test.
		
		When a executor is launched it will first go into preparation state. The executor represents a
		collection of tests which are simply the tests provided as the argument. The collection is
		synchronised with the test suite. This means when a test is changed or deleted in the test suite,
		the executor will adopt its own collection. During the actual testing, the execution will simply
		iterate through the list of tests and remove each item once it starts testing it.
		
		See {EIFFEL_TEST_PROCESSOR_I} for details on the execution flow.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_EXECUTOR_I

inherit
	EIFFEL_TEST_PROCESSOR_I [!DS_LINEAR [!EIFFEL_TEST_I]]
		rename
			is_valid_argument as is_valid_test_list,
			tests as queued_tests
		redefine
			events
		end

feature -- Access

	queued_tests: !DS_LINEAR [!EIFFEL_TEST_I]
			-- <Precursor>
		deferred
		ensure then
				-- Tests queued by `Current'
			results_queued: ({!DS_LINEAR [!EIFFEL_TEST_I]} #? Result).for_all (
				agent (a_test: !EIFFEL_TEST_I): BOOLEAN
					do
						Result := a_test.is_queued and then a_test.executor = Current
					end)
		end

	current_test: !EIFFEL_TEST_I
			-- Test currently being executed
		require
			usable: is_interface_usable
			testing: is_testing
		deferred
		ensure
				-- Test being run by `Current'
			result_running: Result.is_running and then Result.executor = Current
		end

feature -- Status report

	is_preparing: BOOLEAN
			-- Is the execution beeing prepared?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_no_other_state: Result implies not (is_testing or is_cleaning_up)
		end

	is_testing: BOOLEAN
			-- Is a test currently beeing executed?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_no_other_state: Result implies not (is_preparing or is_cleaning_up)
		end

	is_cleaning_up: BOOLEAN
			-- Is any cleaning up being performed?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_no_other_state: Result implies not (is_preparing or is_testing)
		end

	is_running: BOOLEAN
			-- <Precursor>
		do
			Result := is_preparing or is_testing or is_cleaning_up
		end

feature -- Query

	is_valid_test_list (a_list: !DS_LINEAR [!EIFFEL_TEST_I]): BOOLEAN
			-- <Precursor>
		do
			Result := a_list.for_all (agent is_test_executable)
		end

	is_test_executable (a_test: !EIFFEL_TEST_I): BOOLEAN is
			-- Can test instance be executed by `Current'?
			--
			-- `a_test': Test to be executed.
			-- `Result': Is True if `a_test' can be executed, False otherwise.
		require
			a_test_usable: a_test.is_interface_usable
		do
			Result := is_test_compatible (a_test) and not
				(a_test.is_queued or a_test.is_running)
		ensure
			result_implies_compatible: Result implies is_test_compatible (a_test)
			result_implies_not_queued: Result implies not a_test.is_queued
			result_implies_not_running: Result implies not a_test.is_running
		end

	is_test_compatible (a_test: !EIFFEL_TEST_I): BOOLEAN is
			-- Is test compatible with current executor?
		require
			a_test_usable: a_test.is_interface_usable
		do
			Result := True
		end

feature {EIFFEL_TEST_SUITE_S} -- Status setting

	start (a_list: !DS_LINEAR [!EIFFEL_TEST_I]; a_test_suite: !EIFFEL_TEST_SUITE_S) is
			-- Launch test execution for a given list of tests. Once `Current' is preparing return and
			-- continue execution asynchronously.
			--
			-- Note: Implementors should respect list order.
			--
			-- `a_list': List containing tests to be executed
			-- `a_test_suite': Test suite containing tests
		require else
			tests_belong_to_suite: a_test_suite.is_subset (a_list)
		deferred
		ensure then
			preparing: is_preparing
			a_list_queued: queued_tests.is_equal (a_list)
		end

feature -- Events

	test_launched_event: EVENT_TYPE [TUPLE [executor: !EIFFEL_TEST_EXECUTOR_I]]
			-- Events called after a test has been launched.
			--
			-- executor: `Current'
		require
			usable: is_interface_usable
		deferred
		end

	test_finished_event: EVENT_TYPE [TUPLE [executor: !EIFFEL_TEST_EXECUTOR_I]]
			-- Events called after a new outcome for `current_test' has been determined.
			--
			-- executor: `Current'
		require
			usable: is_interface_usable
		deferred
		end

	cleaning_up_event: EVENT_TYPE [TUPLE [executor: !EIFFEL_TEST_EXECUTOR_I]]
			-- Events called after `Current' started cleaning up after an execution session.
			--
			-- executor: `Current'
		require
			usable: is_interface_usable
		deferred
		end

feature {NONE} -- Query

	events (a_observer: !ACTIVE_COLLECTION_OBSERVER [!EIFFEL_TEST_I]): DS_ARRAYED_LIST [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE [ANY, TUPLE]]] is
			-- <Precursor>
		do
			Result := Precursor (a_observer)
			if {l_observer: EIFFEL_TEST_EXECUTOR_OBSERVER} a_observer then
				Result.force_last ([test_launched_event, agent l_observer.on_test_launched])
				Result.force_last ([test_finished_event, agent l_observer.on_test_finished])
				Result.force_last ([cleaning_up_event, agent l_observer.on_cleaning_up])
			end
		end

end
