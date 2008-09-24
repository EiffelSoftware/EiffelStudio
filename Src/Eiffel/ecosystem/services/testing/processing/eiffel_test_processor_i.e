indexing
	description: "[
		Interface of a processor performing tasks for a test suite. For example, this includes executing
		a number of tests or creating new tests.
		
		A processor is launched with generic arguments defining the task. Implementers should split
		any task into small stages. The test suite is than able to tell the processor when to execute the
		next stage. After executing a single stage, the processor should return and go into an idle
		state.
		Execution is controlled by the test suite. This allows the test suite to notify observers when
		a processor was launched or has finished its task.
		
		A processor represents a test collection with the tests it is working on. This collection is
		synchronized with the test suite last launching the processor. When the processor has stopped,
		the collection is still kept synchronized until a different test suite launches it again or the
		current one no longer is available.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_PROCESSOR_I

inherit
	EIFFEL_TEST_COLLECTION_I
		rename
			are_tests_available as is_test_suite_valid
		end

feature -- Access

	test_suite: !EIFFEL_TEST_SUITE_S
			-- Test suite `Current' is synchronized with.
		require
			usable: is_interface_usable
			test_suite_valid: is_test_suite_valid
		deferred
		ensure
			result_usable: Result.is_interface_usable
			result_available: Result.is_project_initialized
		end

	argument: !ANY
			-- Argument with which `Current' has been launched
		require
			usable: is_interface_usable
			running: is_running
		deferred
		end

	tests: !DS_LINEAR [!EIFFEL_TEST_I]
			-- <Precursor>
		deferred
		ensure then
			subset_of_test_suite: test_suite.is_subset (Result)
		end

feature -- Status report

	is_test_suite_valid: BOOLEAN
			-- <Precursor>
		deferred
		ensure then
			result_implies_usable: Result implies test_suite.is_interface_usable
		end

	is_ready (a_test_suite: !EIFFEL_TEST_SUITE_S): BOOLEAN is
			-- Can `Current' start performing a task for test suite?
			--
			-- `a_test_suite': Test suite which launches `Current'.
		require
			usable: is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_test_suite_has_project: a_test_suite.is_project_initialized
		do
			Result := not is_running
		ensure
			result_implies_not_running: Result implies not is_running
		end

	is_running: BOOLEAN
			-- Is `Current' running but has not performed any task yet?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_valid_test_suite: Result implies is_test_suite_valid
		end

	is_finished: BOOLEAN
			-- Has `Current' completet its task?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_idle: Result implies is_idle
		end

feature -- Status report

	is_idle: BOOLEAN
			-- Is `Current' in a state where it is waiting to continue with its task?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_running: Result implies is_running
		end

feature -- Query

	frozen is_valid_argument (a_arg: !ANY; a_test_suite: like test_suite): BOOLEAN
			-- Is `an_arg' a valid argument to start a task for `a_test_suite'?
		require
			usable: is_interface_usable
		do
			if {l_type: like argument} a_arg then
				Result := is_valid_typed_argument (l_type, a_test_suite)
			end
		ensure
			result_implies_valid_typed: Result implies ({l_type2: like argument} a_arg and then
				is_valid_typed_argument ({like argument} #? a_arg, a_test_suite))
		end

	is_stop_requested: BOOLEAN
			-- Should `Current'
		require
			usable: is_interface_usable
			running: is_running
		deferred
		end

feature {NONE} -- Query

	is_valid_typed_argument (a_arg: like argument; a_test_suite: like test_suite): BOOLEAN
			-- Is `an_arg' a valid argument to start a task for `a_test_suite'?
		require
			usable: is_interface_usable
		deferred
		end

feature -- Status setting

	request_stop
			-- Force `Current' to finish next time it proceeds its task.
		require
			usable: is_interface_usable
			running: is_running
		deferred
		ensure
			stop_requested: is_stop_requested
		end

feature {EIFFEL_TEST_SUITE_S} -- Status setting

	frozen start (a_arg: !ANY; a_test_suite: like test_suite)
			-- Start performing a task for given arguments.
			--
			-- `a_arg': Arguments defining the task.
			-- `a_test_suite': Test suite for which task will be processed.
		require
			usable: is_interface_usable
			ready: is_ready (a_test_suite)
			a_arg_valid: is_valid_argument (a_arg, a_test_suite)
			a_test_suite_usable: a_test_suite.is_interface_usable
		do
			attach_test_suite (a_test_suite)
			start_process ({like argument} #? a_arg)
		ensure
			idle: is_idle
			test_suite_set: test_suite = a_test_suite
		end

	proceed
			-- Proceed with next stage of task.
			--
			-- Note: If `Current' reaches the last stage of its task, it should not terminate by itself. By
			--       setting `is_finished' to True, the test suite will notify observers that `Current' is
			--       finished and then call `stop' externally.
		require
			usable: is_interface_usable
			idle: is_idle
		deferred
		ensure
			idle: is_idle
			stop_requested_implies_finished: old is_stop_requested implies is_finished
		end

	stop
			-- Terminate current task.
		require
			usable: is_interface_usable
			done: is_finished
		deferred
		ensure
			stopped: not is_running
		end

feature {NONE} -- Status setting

	attach_test_suite (a_test_suite: like test_suite)
			-- Set `test_suite' to `a_test_suite' and connect
		require
			usable: is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
		deferred
		ensure
			test_suite_set: test_suite = a_test_suite
		end

	start_process (a_arg: like argument)
			-- Start performing a task for given arguments.
			--
			-- `a_arg': Arguments defining the task.
		require
			usable: is_interface_usable
			ready: is_ready (test_suite)
			a_arg_valid: is_valid_argument (a_arg, test_suite)
		deferred
		ensure
			idle: is_idle
		end
end
