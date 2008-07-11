indexing
	description: "[
		Service interface for managing, creating and executing tests.
		
		A test suite contains a number of tests which can be executed by an descendants of {TEST_EXECUTOR_I}. There
		is only one executor running at a time, stored as the active executor in the test suite. Clients can tell
		the test suite to activate an executor by providing a valid type.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_SUITE_S

inherit
	SERVICE_I

	TEST_COLLECTION_I
		redefine
			events
		end

feature -- Access

	default_executor: !TYPE [!TEST_EXECUTOR_I]
			-- Type for default executor
		require
			usable: is_interface_usable
		deferred
		ensure
			result_registered: processor_registrar.is_registered (Result)
		end

	executor (a_type: !TYPE [!TEST_EXECUTOR_I]): !TEST_EXECUTOR_I is
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

	factory (a_type: !TYPE [!TEST_FACTORY_I [TEST_CONFIGURATION_I]]): !TEST_FACTORY_I [TEST_CONFIGURATION_I] is
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

	processor_registrar: !TEST_PROCESSOR_REGISTRAR_I [!TEST_PROCESSOR_I [ANY]]
			-- Registrar managing available test processors
		require
			usable: is_interface_usable
		deferred
		ensure
			registrar_usable: Result.is_interface_usable
		end

feature -- Status report

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

	run_all (a_type: !TYPE [!TEST_EXECUTOR_I]; a_blocking: BOOLEAN)
			-- Run all tests in `tests' with executor of type `a_executor'
			-- and notify observers that executor has been launched.
		require
			usable: is_interface_usable
			executor_available: processor_registrar.is_registered (a_type)
			executor_ready: executor (a_type).is_ready
			executor_suitable: executor (a_type).is_valid_test_list (tests)
		do
			run_list (a_type, tests, a_blocking)
		ensure
			not_blocking_equals_preparing_tests: not a_blocking = (executor (a_type).is_preparing and
				executor (a_type).tests.is_equal (tests))
		end

	run_list (a_type: !TYPE [!TEST_EXECUTOR_I]; a_list: !DS_LINEAR [!TEST_I]; a_blocking: BOOLEAN)
			-- Run all tests in `a_list' with executor of type `a_executor'
			-- and notify observers that executor has been launched.
		require
			usable: is_interface_usable
			executor_available: processor_registrar.is_registered (a_type)
			executor_ready: executor (a_type).is_ready
			executor_suitable: executor (a_type).is_valid_test_list (tests)
			tests_belong_to_suite: a_list.for_all (agent tests.has)
		deferred
		ensure
			not_blocking_equals_preparing_a_list: not a_blocking = (executor (a_type).is_preparing and
				executor (a_type).tests.is_equal (a_list))
		end

	create_tests (a_type: !TYPE [!TEST_FACTORY_I [TEST_CONFIGURATION_I]]; a_conf: !TEST_CONFIGURATION_I; a_blocking: BOOLEAN)
			-- Launch test creation and notify all observers
		require
			usable: is_interface_usable
			factory_available: processor_registrar.is_registered (a_type)
			factory_ready: factory (a_type).is_ready
			factory_suitable: factory (a_type).is_valid_configuration (a_conf)
		deferred
		ensure
			not_blocking_equals_running_conf: not a_blocking = (factory (a_type).is_running and
				factory (a_type).configuration = a_conf)
		end

feature -- Events

	executor_launched_event: !EVENT_TYPE [TUPLE [test_suite: !TEST_SUITE_S; executor: !TEST_EXECUTOR_I]]
			-- Events called when test suite launches an executor.
			--
			-- test_suite: `Current'
			-- executor: Executor which was launched by `Current'.
		require
			usable: is_interface_usable
		deferred
		end

	factory_launched_event: !EVENT_TYPE [TUPLE [test_suite: !TEST_SUITE_S; factory: !TEST_FACTORY_I [TEST_CONFIGURATION_I]]]
			-- Events called when test suite launches a factory.
			--
			-- test_suite: `Current'
			-- factory: Factory which was launched by `Current'.
		require
			usable: is_interface_usable
		deferred
		end

	test_launched_event: !EVENT_TYPE [TUPLE [test_suite: !TEST_SUITE_S; test: !TEST_I]]
			-- Events called when some executor launches a test.
			--
			-- test_suite: `Current'
			-- test: Test which was launched.
		require
			usable: is_interface_usable
		deferred
		end

	test_revealed_event: !EVENT_TYPE [TUPLE [test_suite: !TEST_SUITE_S; test: !TEST_I]]
			-- Events called when new outcome is available for test.
			--
			-- test_suite: `Current'
			-- test: Test containing new outcome.
		require
			usable: is_interface_usable
		deferred
		end

	processor_finished_event: !EVENT_TYPE [TUPLE [test_suite: !TEST_SUITE_S; processor: !TEST_PROCESSOR_I [ANY]]]
			-- Events called when some processor finished its task.
			--
			-- test_suite: `Current'
			-- processor: Processor that finished its task.
		require
			usable: is_interface_usable
		deferred
		end

feature {NONE} -- Query

	events (a_observer: !ACTIVE_COLLECTION_OBSERVER [!TEST_I]): DS_ARRAYED_LIST [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE [ANY, TUPLE]]]
			-- <Precursor>
		do
			Result := Precursor (a_observer)
			if {l_observer: TEST_SUITE_OBSERVER} a_observer then
				Result.force_last ([executor_launched_event, agent l_observer.on_executor_launched])
				Result.force_last ([factory_launched_event, agent l_observer.on_factory_launched])
				Result.force_last ([test_launched_event, agent l_observer.on_test_launched])
				Result.force_last ([test_revealed_event, agent l_observer.on_test_revealed])
				Result.force_last ([processor_finished_event, agent l_observer.on_processor_finished])
			end
		end

end
