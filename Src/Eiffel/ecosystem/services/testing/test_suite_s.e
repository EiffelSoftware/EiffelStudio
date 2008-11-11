indexing
	description: "[
		Service interface for managing, creating and executing tests.
		
		The test suite provides a registrar containing a number of available test processors. Test
		processors are usedon_ to perform actions on existing tests or to produce new tests. See
		{TEST_PROCESSOR_I} and descendants for more details. Test processors can only be launched
		by the test suite.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_SUITE_S

inherit
	SERVICE_I

	TEST_PROJECT_I
		redefine
			events
		end

feature -- Access

	executor (a_type: !TYPE [TEST_EXECUTOR_I]): !TEST_EXECUTOR_I is
			-- Test executor registered under `a_type'.
			--
			-- `a_type': Type under which executor is registered.
			-- `Result': Executor registered in `processor_registrar' for `a_type'.
		require
			usable: is_interface_usable
			a_type_registered: processor_registrar.is_valid_type (a_type, Current)
		do
			if {l_executor: like executor} processor_registrar.processor (a_type, Current) then
				Result := l_executor
			else
				check
					False
				end
			end
		ensure
			result_from_registrar: Result = processor_registrar.processor (a_type, Current)
		end

	factory (a_type: !TYPE [TEST_CREATOR_I]): !TEST_CREATOR_I is
			-- Test factory registered under `a_type'.
			--
			-- `a_type': Type under which factory is registered.
			-- `Result': Factory registered in `processor_registrar' for `a_type'.
		require
			usable: is_interface_usable
			a_type_registered: processor_registrar.is_valid_type (a_type, Current)
		do
			if {l_factory: like factory} processor_registrar.processor (a_type, Current) then
				Result := l_factory
			else
				check
					False
				end
			end
		ensure
			result_from_registrar: Result = processor_registrar.processor (a_type, Current)
		end

	processor_registrar: !TEST_PROCESSOR_REGISTRAR_I
			-- Registrar managing available test processors
		require
			usable: is_interface_usable
		deferred
		ensure
			registrar_usable: Result.is_interface_usable
		end

feature -- Status report

	count_executed: NATURAL
			-- Number of tests in `test' which have been executed
		require
			usable: is_interface_usable
		deferred
		end

	count_passing: NATURAL
			-- Number of passing tests in `tests'
		require
			usable: is_interface_usable
		deferred
		end

	count_failing: NATURAL
			-- Number of failing tests in `tests'
		require
			usable: is_interface_usable
		deferred
		end

feature -- Status setting

	synchronize_processors
			-- Synchronize `tests' with status of processors.
			--
			-- Note: this routine should be called whenever the system becomes idle
		require
			usable: is_interface_usable
		deferred
		end

	launch_processor (a_processor: !TEST_PROCESSOR_I; a_arg: !TEST_PROCESSOR_CONF_I; a_blocking: BOOLEAN)
			-- Launch test processor and notify all observers
		require
			usable: is_interface_usable
			project_initialized: is_project_initialized
			processor_ready: a_processor.is_ready
			processor_suitable: a_processor.is_valid_configuration (a_arg)
		deferred
		ensure
			not_blocking_equals_running: not a_blocking = a_processor.is_idle
		end

feature {TEST_PROCESSOR_I} -- Status setting

	propagate_error (a_error: !STRING; a_token_values: !TUPLE; a_processor: !TEST_PROCESSOR_I)
			-- Propagate error message raised by processor
		require
			usable: is_interface_usable
			a_processor_usable: a_processor.is_interface_usable
			a_processor_running: a_processor.is_running
		deferred
		end

feature {TEST_EXECUTOR_I} -- Status setting

	set_test_queued (a_test: !TEST_I; a_executor: !TEST_EXECUTOR_I) is
			-- Set status of test to queued and notify observers.
			--
			-- `a_test': Test being queued.
		require
			usable: is_interface_usable
			tests_available: is_project_initialized
			tests_has_a_test: tests.has (a_test)
			test_not_queued_or_running: not (a_test.is_queued or a_test.is_running)
		deferred
		ensure
			a_test_queued: a_test.is_queued
			a_executor_queues_a_test: a_test.executor = a_executor
		end

	set_test_running (a_test: !TEST_I)
			-- Set status of test to running and notify observers.
			--
			-- `a_test': Test being executed.
		require
			usable: is_interface_usable
			tests_available: is_project_initialized
			tests_has_a_test: tests.has (a_test)
			test_queued: a_test.is_queued
		deferred
		ensure
			a_test_running: a_test.is_running
		end

	add_outcome_to_test (a_test: !TEST_I; a_outcome: !EQA_TEST_OUTCOME)
			-- Add outcome to test being executed and notify observers.
			--
			-- `a_test': Test for which outcome is available.
			-- `a_outcome': Outcome received from last execution.
		require
			usable: is_interface_usable
			tests_available: is_project_initialized
			tests_has_a_test: tests.has (a_test)
			test_running: a_test.is_running
		deferred
		ensure
			a_test_not_queued_or_running: not (a_test.is_queued or a_test.is_running)
			a_test_has_outcome: a_test.is_outcome_available
			a_outcome_is_last_outcome: a_test.last_outcome = a_outcome
		end

	set_test_aborted (a_test: !TEST_I)
			-- Abort execution of test and notify observers.
			--
			-- `a_test': Test which was not completely executed.
		require
			usable: is_interface_usable
			tests_available: is_project_initialized
			tests_has_a_test: tests.has (a_test)
			test_queued_or_running: (a_test.is_queued or a_test.is_running)
		deferred
		ensure
			a_test_not_queued_or_running: not (a_test.is_queued or a_test.is_running)
		end

feature {NONE} -- Query

	events (a_observer: !ACTIVE_COLLECTION_OBSERVER [!TEST_I]): !DS_ARRAYED_LIST [!TUPLE [event: !EVENT_TYPE [TUPLE]; action: !PROCEDURE [ANY, TUPLE]]]
			-- <Precursor>
		do
			Result := Precursor (a_observer)
			if {l_observer: TEST_SUITE_OBSERVER} a_observer then
				Result.force_last ([processor_launched_event, agent l_observer.on_processor_launched])
				Result.force_last ([processor_proceeded_event, agent l_observer.on_processor_proceeded])
				Result.force_last ([processor_finished_event, agent l_observer.on_processor_finished])
				Result.force_last ([processor_stopped_event, agent l_observer.on_processor_stopped])
				Result.force_last ([processor_error_event, agent l_observer.on_processor_error])
			end
		end

feature -- Events

	processor_launched_event: !EVENT_TYPE [TUPLE [test_suite: !TEST_SUITE_S; processor: !TEST_PROCESSOR_I]]
			-- Events called when `Current' launches a processor.
			--
			-- test_suite: `Current'
			-- processor: Processor which was launched by `Current'
		require
			usable: is_interface_usable
		deferred
		end

	processor_proceeded_event: !EVENT_TYPE [TUPLE [test_suite: !TEST_SUITE_S; processor: !TEST_PROCESSOR_I]]
			-- Events called after some processor has proceeded with its task.
			--
			-- test_suite: `Current'
			-- processor: Processor that proceeded with its task.
		require
			usable: is_interface_usable
		deferred
		end

	processor_finished_event: !EVENT_TYPE [TUPLE [test_suite: !TEST_SUITE_S; processor: !TEST_PROCESSOR_I]]
			-- Events called when some processor finished its task.
			--
			-- test_suite: `Current'
			-- processor: Processor that finished its task.
		require
			usable: is_interface_usable
		deferred
		end

	processor_stopped_event: !EVENT_TYPE [TUPLE [test_suite: !TEST_SUITE_S; processor: !TEST_PROCESSOR_I]]
			-- Events called when a processor has completely stopped
			--
			-- Note: It is not guaranteed that all observers will receive this notification. This is because
			--       any observer in the list can restart the processor during the notification.
			--
			-- test_suite: `Current'
			-- processor: Processor that has just stopped
		require
			usable: is_interface_usable
		deferred
		end

	processor_error_event: !EVENT_TYPE [TUPLE [test_suite: !TEST_SUITE_S; processor: !TEST_PROCESSOR_I; error: !STRING; token_values: !TUPLE]]
			-- Events called when a processor raises an error message
			--
			-- test_suite: `Current'
			-- processor: Processor raising error
			-- error: Readable error message containing tokens
			-- token_values: Values for tokens in error message
		require
			usable: is_interface_usable
		deferred
		end

end
