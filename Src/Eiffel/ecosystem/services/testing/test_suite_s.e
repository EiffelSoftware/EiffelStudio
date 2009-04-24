note
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
		select
			active_collection_connection
		end

	EVENT_CONNECTION_POINT_I [TEST_SUITE_OBSERVER, TEST_SUITE_S]
		rename
			connection as test_suite_connection
		end

feature -- Access

	executor (a_type: attached TYPE [TEST_EXECUTOR_I]): attached TEST_EXECUTOR_I
			-- Test executor registered under `a_type'.
			--
			-- `a_type': Type under which executor is registered.
			-- `Result': Executor registered in `processor_registrar' for `a_type'.
		require
			usable: is_interface_usable
			a_type_registered: processor_registrar.is_valid_type (a_type, Current)
		do
			if attached {like executor} processor_registrar.processor (a_type, Current) as l_executor then
				Result := l_executor
			else
				check
					False
				end
			end
		ensure
			result_from_registrar: Result = processor_registrar.processor (a_type, Current)
		end

	factory (a_type: attached TYPE [TEST_CREATOR_I]): attached TEST_CREATOR_I
			-- Test factory registered under `a_type'.
			--
			-- `a_type': Type under which factory is registered.
			-- `Result': Factory registered in `processor_registrar' for `a_type'.
		require
			usable: is_interface_usable
			a_type_registered: processor_registrar.is_valid_type (a_type, Current)
		do
			if attached {like factory} processor_registrar.processor (a_type, Current) as l_factory then
				Result := l_factory
			else
				check
					False
				end
			end
		ensure
			result_from_registrar: Result = processor_registrar.processor (a_type, Current)
		end

	processor_registrar: attached TEST_PROCESSOR_REGISTRAR_I
			-- Registrar managing available test processors
		require
			usable: is_interface_usable
		deferred
		ensure
			registrar_usable: Result.is_interface_usable
		end

	scheduler: attached TEST_PROCESSOR_SCHEDULER_I
			-- Scheduler for launching test processors
		require
			usable: is_interface_usable
		deferred
		ensure
			schduler_usable: Result.is_interface_usable
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

feature {TEST_PROCESSOR_I} -- Status setting

	propagate_error (a_error: attached STRING; a_token_values: attached TUPLE; a_processor: attached TEST_PROCESSOR_I)
			-- Propagate error message raised by processor
		require
			usable: is_interface_usable
			a_processor_usable: a_processor.is_interface_usable
			a_processor_running: a_processor.is_running
		deferred
		end

feature {TEST_EXECUTOR_I} -- Status setting

	set_test_queued (a_test: attached TEST_I; a_executor: attached TEST_EXECUTOR_I)
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

	set_test_running (a_test: attached TEST_I)
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

	add_outcome_to_test (a_test: attached TEST_I; a_outcome: attached EQA_TEST_RESULT)
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

	set_test_aborted (a_test: attached TEST_I)
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

feature -- Events

	processor_launched_event: attached EVENT_TYPE [TUPLE [test_suite: attached TEST_SUITE_S; processor: attached TEST_PROCESSOR_I]]
			-- Events called when `Current' launches a processor.
			--
			-- test_suite: `Current'
			-- processor: Processor which was launched by `Current'
		require
			usable: is_interface_usable
		deferred
		end

	processor_proceeded_event: attached EVENT_TYPE [TUPLE [test_suite: attached TEST_SUITE_S; processor: attached TEST_PROCESSOR_I]]
			-- Events called after some processor has proceeded with its task.
			--
			-- test_suite: `Current'
			-- processor: Processor that proceeded with its task.
		require
			usable: is_interface_usable
		deferred
		end

	processor_finished_event: attached EVENT_TYPE [TUPLE [test_suite: attached TEST_SUITE_S; processor: attached TEST_PROCESSOR_I]]
			-- Events called when some processor finished its task.
			--
			-- test_suite: `Current'
			-- processor: Processor that finished its task.
		require
			usable: is_interface_usable
		deferred
		end

	processor_stopped_event: attached EVENT_TYPE [TUPLE [test_suite: attached TEST_SUITE_S; processor: attached TEST_PROCESSOR_I]]
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

	processor_error_event: attached EVENT_TYPE [TUPLE [test_suite: attached TEST_SUITE_S; processor: attached TEST_PROCESSOR_I; error: attached STRING; token_values: TUPLE]]
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

feature -- Event: Connection point

	test_suite_connection: attached EVENT_CONNECTION_I [TEST_SUITE_OBSERVER, TEST_SUITE_S]
			-- <Precursor>
		local
			l_result: like internal_test_suite_connection
		do
			l_result := internal_test_suite_connection
			if l_result = Void then
				create {EVENT_CHAINED_CONNECTION [TEST_SUITE_OBSERVER, TEST_SUITE_S, ACTIVE_COLLECTION_OBSERVER [attached TEST_I], ACTIVE_COLLECTION_I [attached TEST_I]]}
					Result.make (
						agent (ia_observer: attached TEST_SUITE_OBSERVER): attached ARRAY [TUPLE [event: attached EVENT_TYPE [TUPLE]; action: attached PROCEDURE [ANY, TUPLE]]]
							do
								Result := << [processor_launched_event, agent ia_observer.on_processor_launched],
									[processor_proceeded_event, agent ia_observer.on_processor_proceeded],
									[processor_finished_event, agent ia_observer.on_processor_finished],
									[processor_stopped_event, agent ia_observer.on_processor_stopped],
									[processor_error_event, agent ia_observer.on_processor_error] >>
							end, active_collection_connection)
				automation.auto_dispose (Result)
				internal_test_suite_connection := Result
			else
				Result := l_result
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_test_suite_connection: detachable like test_suite_connection
			-- Cached version of `test_suite_connection'.
			-- Note: Do not use directly!

end
