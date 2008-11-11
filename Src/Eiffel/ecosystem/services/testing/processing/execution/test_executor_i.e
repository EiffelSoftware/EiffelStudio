indexing
	description: "[
		An interface of an executor taking a list of tests and queues them to later be run and determined
		whether the implementation under test has passed or failed the test.
		
		When a executor is launched it will first go into preparation state. The executor represents a
		collection of tests which are simply the tests provided as the argument. The collection is
		synchronised with the test suite. This means when a test is changed or deleted in the test suite,
		the executor will adopt its own collection. During the actual testing, the execution will simply
		iterate through the list of tests and remove each item once it starts testing it.
		
		See {TEST_PROCESSOR_I} for details on the execution flow.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_EXECUTOR_I

inherit
	TEST_PROCESSOR_I
		rename
			tests as active_tests
		redefine
			conf_type
		end

feature
	argument: !DS_LINEAR [!TEST_I]
		do
		end


feature -- Access

	active_tests: !DS_LINEAR [!TEST_I]
			-- <Precursor>
			--
			-- Note: list contains tests which are queued or currently executed.
		deferred
		end

feature {NONE} -- Query

	is_valid_typed_configuration (a_conf: like conf_type): BOOLEAN
			-- <Precursor>
		deferred
		ensure then
			tests_executable: not a_conf.is_specific implies test_suite.tests.for_all (agent is_test_executable)
			subset_executable: a_conf.is_specific implies (test_suite.is_subset (a_conf.tests) and
				a_conf.tests.for_all (agent is_test_executable))

		end

	frozen is_test_executable (a_test: !TEST_I): BOOLEAN is
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

	skip_test (a_test: !TEST_I)
			-- Remove test from `active_tests'
			--
			-- `a_test': Test to be removed from active tests.
		require
			usable: is_interface_usable
			running: is_running
			a_test_active: active_tests.has (a_test)
		deferred
		ensure
			a_test_not_active: (a_test.is_queued or a_test.is_running) implies a_test.executor /= Current
		end

feature {NONE} -- Typing

	conf_type: !TEST_EXECUTOR_CONF_I
			-- <Precursor>
		do
		end

end
