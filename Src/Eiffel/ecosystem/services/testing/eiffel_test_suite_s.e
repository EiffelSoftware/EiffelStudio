indexing
	description: "[
		Service interface for managing, creating and executing tests.
		
		The test suite provides a registrar containing a number of available test processors. Test
		processors are usedon_ to perform actions on existing tests or to produce new tests. See
		{EIFFEL_TEST_PROCESSOR_I} and descendants for more details. Test processors can only be launched
		by the test suite.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_SUITE_S

inherit
	SERVICE_I

	EIFFEL_TEST_PROJECT_I
		redefine
			events
		end

feature -- Access

	executor (a_type: !TYPE [EIFFEL_TEST_EXECUTOR_I]): !EIFFEL_TEST_EXECUTOR_I is
			-- Test executor registered under `a_type'.
			--
			-- `a_type': Type under which executor is registered.
			-- `Result': Executor registered in `processor_registrar' for `a_type'.
		require
			usable: is_interface_usable
			a_type_registered: processor_registrar.is_registered (a_type)
		do
			Result ?= processor_registrar.processor (a_type)
		ensure
			result_registered: Result = processor_registrar.processor (a_type)
			result_conforms: a_type.attempt (Result) /= Void
		end

	factory (a_type: !TYPE [EIFFEL_TEST_FACTORY_I [!EIFFEL_TEST_CONFIGURATION_I]]): !EIFFEL_TEST_FACTORY_I [!EIFFEL_TEST_CONFIGURATION_I] is
			-- Test factory registered under `a_type'.
			--
			-- `a_type': Type under which factory is registered.
			-- `Result': Factory registered in `processor_registrar' for `a_type'.
		require
			usable: is_interface_usable
			a_type_registered: processor_registrar.is_registered (a_type)
		do
			Result ?= processor_registrar.processor (a_type)
		ensure
			result_registered: Result = processor_registrar.processor (a_type)
			result_conforms: a_type.attempt (Result) /= Void
		end

	processor_registrar: !EIFFEL_TEST_PROCESSOR_REGISTRAR_I [EIFFEL_TEST_PROCESSOR_I]
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

	run_all (a_executor: !EIFFEL_TEST_EXECUTOR_I; a_blocking: BOOLEAN)
			-- Run all tests in `tests' with executor of type `a_executor'
			-- and notify observers that executor has been launched.
		require
			usable: is_interface_usable
			project_initialized: is_project_initialized
			executor_ready: a_executor.is_ready (Current)
			executor_suitable: a_executor.is_valid_test_list (tests, Current)
		do
			run_list (a_executor, tests, a_blocking)
		ensure
			not_blocking_equals_preparing_tests: not a_blocking = a_executor.is_idle
		end

	run_list (a_executor: !EIFFEL_TEST_EXECUTOR_I; a_list: !DS_LINEAR [!EIFFEL_TEST_I]; a_blocking: BOOLEAN)
			-- Run all tests in `a_list' with executor of type `a_executor'
			-- and notify observers that executor has been launched.
		require
			usable: is_interface_usable
			project_initialized: is_project_initialized
			executor_ready: a_executor.is_ready (Current)
			executor_suitable: a_executor.is_valid_test_list (tests, Current)
		do
			launch_processor (a_executor, a_list, a_blocking)
		ensure
			not_blocking_equals_preparing_a_list: not a_blocking = a_executor.is_idle
		end

	create_tests (a_factory: !EIFFEL_TEST_FACTORY_I [!EIFFEL_TEST_CONFIGURATION_I]; a_conf: !EIFFEL_TEST_CONFIGURATION_I; a_blocking: BOOLEAN)
			-- Launch test creation and notify all observers
		require
			usable: is_interface_usable
			project_initialized: is_project_initialized
			factory_ready: a_factory.is_ready (Current)
			factory_suitable: a_factory.is_valid_configuration (a_conf, Current)
		do
			launch_processor (a_factory, a_conf, a_blocking)
		ensure
			not_blocking_equals_running: not a_blocking = a_factory.is_idle
			not_blocking_equals_running_conf: not a_blocking implies (a_factory.configuration = a_conf)
		end

	launch_processor (a_processor: !EIFFEL_TEST_PROCESSOR_I; a_arg: !ANY; a_blocking: BOOLEAN)
			-- Launch test processor and notify all observers
		require
			usable: is_interface_usable
			project_initialized: is_project_initialized
			processor_ready: a_processor.is_ready (Current)
			processor_suitable: a_processor.is_valid_argument (a_arg, Current)
		deferred
		ensure
			not_blocking_equals_running: not a_blocking = a_processor.is_idle
		end

feature {EIFFEL_TEST_EXECUTOR_I} -- Status setting

	set_test_queued (a_test: !EIFFEL_TEST_I; a_executor: !EIFFEL_TEST_EXECUTOR_I) is
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

	set_test_running (a_test: !EIFFEL_TEST_I)
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

	add_outcome_to_test (a_test: !EIFFEL_TEST_I; a_outcome: !EQA_TEST_OUTCOME)
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

	set_test_aborted (a_test: !EIFFEL_TEST_I)
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

	events (a_observer: !ACTIVE_COLLECTION_OBSERVER [!EIFFEL_TEST_I]): !DS_ARRAYED_LIST [!TUPLE [event: !EVENT_TYPE [TUPLE]; action: !PROCEDURE [ANY, TUPLE]]]
			-- <Precursor>
		do
			Result := Precursor (a_observer)
			if {l_observer: EIFFEL_TEST_SUITE_OBSERVER} a_observer then
				Result.force_last ([processor_launched_event, agent l_observer.on_processor_launched])
				Result.force_last ([processor_proceeded_event, agent l_observer.on_processor_proceeded])
				Result.force_last ([processor_finished_event, agent l_observer.on_processor_finished])
				Result.force_last ([processor_stopped_event, agent l_observer.on_processor_stopped])
			end
		end

feature -- Events

	processor_launched_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I]]
			-- Events called when `Current' launches a processor.
			--
			-- test_suite: `Current'
			-- processor: Processor which was launched by `Current'
		require
			usable: is_interface_usable
		deferred
		end

	processor_proceeded_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I]]
			-- Events called after some processor has proceeded with its task.
			--
			-- test_suite: `Current'
			-- processor: Processor that proceeded with its task.
		require
			usable: is_interface_usable
		deferred
		end

	processor_finished_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I]]
			-- Events called when some processor finished its task.
			--
			-- test_suite: `Current'
			-- processor: Processor that finished its task.
		require
			usable: is_interface_usable
		deferred
		end

	processor_stopped_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I]]
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

end
