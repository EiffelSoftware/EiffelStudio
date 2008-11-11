indexing
	description: "[
		Interface of a processor performing tasks for a test suite. For example, this includes executing
		a number of tests or creating new tests.
		
		A processor is launched with a configuriation defining the task. Implementers should split
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
	TEST_PROCESSOR_I

inherit
	TEST_COLLECTION_I

feature -- Access

	test_suite: !TEST_SUITE_S
			-- Test suite `Current' is synchronized with.
		require
			usable: is_interface_usable
		deferred
		ensure
			result_usable: Result.is_interface_usable
			result_available: Result.is_project_initialized
		end

	tests: !DS_LINEAR [!TEST_I]
			-- <Precursor>
		deferred
		ensure then
			subset_of_test_suite: test_suite.is_subset (Result)
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		deferred
		ensure then
			result_implies_test_suite_usable: Result implies test_suite.is_interface_usable
		end

	are_tests_available: BOOLEAN
			-- <Precursor>
		do
			Result := test_suite.is_project_initialized
		ensure then
			result_implies_project_initialized: Result implies test_suite.is_project_initialized
		end

	is_ready: BOOLEAN is
			-- Can `Current' start performing a task for test suite?
			--
			-- `a_test_suite': Test suite which launches `Current'.
		require
			usable: is_interface_usable
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
			result_implies_valid_test_suite: Result implies are_tests_available
		end

	is_finished: BOOLEAN
			-- Has `Current' completet its task?
		require
			usable: is_interface_usable
			running: is_running
		deferred
		end

	is_idle: BOOLEAN
			-- Is `Current' in a state where it is waiting to continue with its task?
		require
			usable: is_interface_usable
			running: is_running
		deferred
		end

	progress: REAL
			-- Progress of current run between 0 and 1
		require
			usable: is_interface_usable
			running: is_running
		deferred
		ensure
			not_negative: Result >= {REAL} 0.0
			smaller_equal_one: Result <= {REAL} 1.0
			finished_implies_one: is_finished implies Result = {REAL} 1.0
		end

feature -- Query

	frozen is_valid_configuration (a_arg: !TEST_PROCESSOR_CONF_I): BOOLEAN
			-- Is `an_arg' a valid configuration to start a task for `a_test_suite'?
		require
			usable: is_interface_usable
		do
			if {l_type: like conf_type} a_arg then
				Result := is_valid_typed_configuration (l_type)
			end
		ensure
			result_implies_valid_typed: Result implies ({l_type2: like conf_type} a_arg and then
				is_valid_typed_configuration (l_type2))
		end

	is_stop_requested: BOOLEAN
			-- Should `Current'
		require
			usable: is_interface_usable
			running: is_running
		deferred
		end

feature {NONE} -- Query

	is_valid_typed_configuration (a_arg: like conf_type): BOOLEAN
			-- Is `an_arg' a valid configuration to start a task for `a_test_suite'?
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

feature {TEST_SUITE_S} -- Status setting

	frozen start (a_arg: !TEST_PROCESSOR_CONF_I)
			-- Start performing a task for given configuration.
			--
			-- `a_arg': Arguments defining the task.
			-- `a_test_suite': Test suite for which task will be processed.
		require
			usable: is_interface_usable
			ready: is_ready
			a_arg_valid: is_valid_configuration (a_arg)
		do
			if {l_arg: like conf_type} a_arg then
				start_process (l_arg)
			end
		ensure
			idle: is_idle
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
			running: is_running
			finished: is_finished
			idle: is_idle
		deferred
		ensure
			running: not is_running
		end

feature {NONE} -- Status setting

	start_process (a_arg: like conf_type)
			-- Start performing a task for given arguments.
			--
			-- `a_arg': Arguments defining the task.
		require
			usable: is_interface_usable
			ready: is_ready
			a_arg_valid: is_valid_configuration (a_arg)
		deferred
		ensure
			idle: is_idle
		end

feature {NONE} -- Typing

	conf_type: !TEST_PROCESSOR_CONF_I
			-- Type anchor for configuration used by `Current'.
		do
		ensure
			not_to_be_called: False
		end

end
