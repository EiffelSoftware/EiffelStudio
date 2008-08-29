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
	EIFFEL_TEST_PROCESSOR_I
		rename
			tests as active_tests,
			argument as active_tests,
			is_valid_typed_argument as is_valid_test_list
		redefine
			is_valid_test_list
		end

feature -- Access

	active_tests: !DS_LINEAR [!EIFFEL_TEST_I]
			-- <Precursor>
			--
			-- Note: list contains tests which are queued or currently executed.
		deferred
		ensure then
				-- Tests queued by `Current'
			results_queued: ({!DS_LINEAR [!EIFFEL_TEST_I]} #? Result).for_all (
				agent (a_test: !EIFFEL_TEST_I): BOOLEAN
					do
						Result := (a_test.is_queued or a_test.is_running) and then a_test.executor = Current
					end)
		end

feature -- Query

	is_valid_test_list (a_list: !DS_LINEAR [!EIFFEL_TEST_I]; a_test_suite: like test_suite): BOOLEAN
			-- <Precursor>
		do
			Result := a_test_suite.is_subset (a_list) and a_list.for_all (agent is_test_executable)
		end

	is_test_executable (a_test: !EIFFEL_TEST_I): BOOLEAN is
			-- Can test instance be executed by `Current'?
			--
			-- `a_test': Test to be executed.
			-- `Result': Is True if `a_test' can be executed, False otherwise.
		require
			a_test_usable: a_test.is_interface_usable
		do
			Result := not (a_test.is_queued or a_test.is_running)
		ensure
			result_implies_not_queued: Result implies not a_test.is_queued
			result_implies_not_running: Result implies not a_test.is_running
		end

feature -- Status setting

	skip_test (a_test: !EIFFEL_TEST_I)
			-- Remove test from `active_tests'
			--
			-- `a_test': Test to be removed from active tests.
		require
			usable: is_interface_usable
			a_test_active: active_tests.has (a_test)
		deferred
		ensure
			a_test_not_active: not active_tests.has (a_test)
		end

end
