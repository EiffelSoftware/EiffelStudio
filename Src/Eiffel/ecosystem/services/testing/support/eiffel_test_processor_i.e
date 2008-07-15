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
	EIFFEL_TEST_PROCESSOR_I [G]

inherit
	EIFFEL_TEST_COLLECTION_I
		rename
			are_tests_available as is_test_suite_valid
		redefine
			events
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
			result_valid: Result.is_project_initialized
		end

	tests: !DS_LINEAR [!EIFFEL_TEST_I]
			-- <Precursor>
		deferred
		ensure then
			subset_of_test_suite: test_suite.is_subset (Result)
		end

feature -- Status report

	is_ready: BOOLEAN
			-- Can `Current' start performing a task?
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
		end

	is_finished: BOOLEAN
			--
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_idle: Result implies is_idle
		end

feature {EIFFEL_TEST_SUITE_S} -- Status report

	is_idle: BOOLEAN
			-- Is `Current' in a state where it is waiting to continue with its task?
		require
			usable: is_interface_usable
		deferred
		ensure
			result_implies_running: Result implies is_running
		end

feature -- Query

	is_valid_argument (a_arg: G): BOOLEAN
			-- Is `an_arg' a valid argument to start a task?
		require
			usable: is_interface_usable
		deferred
		end

	is_stop_requested: BOOLEAN
			-- Should `Current'
		require
			usable: is_interface_usable
			running: is_running
		deferred
		end

feature {NONE} -- Query

	events (a_observer: !ACTIVE_COLLECTION_OBSERVER [!EIFFEL_TEST_I]): DS_ARRAYED_LIST [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE [ANY, TUPLE]]]
			-- <Precursor>
		do
			Result := Precursor (a_observer)
			if {l_observer: !EIFFEL_TEST_PROCESSOR_OBSERVER} a_observer then
				Result.force_last ([status_changed_event, agent l_observer.on_status_changed])
			end
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

	start (a_arg: G; a_test_suite: like test_suite)
			-- Start performing a task for given arguments.
			--
			-- `a_arg': Arguments defining the task.
			-- `a_test_suite': Test suite for which task will be processed.
		require
			usable: is_interface_usable
			ready: is_ready
			a_arg_valid: is_valid_argument (a_arg)
			a_test_suite_usable: a_test_suite.is_interface_usable
		deferred
		ensure
			idle: is_idle
			test_suite_set: test_suite = a_test_suite
			stop_not_requested: not is_stop_requested
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

feature -- Event

	status_changed_event: !EVENT_TYPE [TUPLE [processor: !EIFFEL_TEST_PROCESSOR_I [ANY]]]
			-- Events called when processor changes its status
			--
			-- processor: `Current'
		require
			usable: is_interface_usable
		deferred
		end

end
