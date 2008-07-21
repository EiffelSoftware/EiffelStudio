indexing
	description: "[
		Service interface for managing, creating and executing tests.
		
		Tests are added or removed by the service internally. Usually the list of tests is updated after
		a compilation. However clients such as test factories can request that the test suite
		synchronizes with classes changed since last compilation. Since in these cases it can not be
		determined whether a class is a valid test class, the test suite will assume it. After the system
		has compiled, it assures all tests are actually valid tests.
		
		The test suite provides a registrar containing a number of available test processors. Test
		processors are used to perform actions on existing tests or to produce new tests. See
		{EIFFEL_TEST_PROCESSOR_I} and descendants for more details. Test processors can only be launched
		by the test suite.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_SUITE_S

inherit
	SERVICE_I

	EIFFEL_TEST_COLLECTION_I
		rename
			are_tests_available as is_project_initialized
		redefine
			events
		end

feature -- Access

	project: !E_PROJECT
		require
			usable: is_interface_usable
			project_available: is_project_initialized
		deferred
		ensure
			result_initialized: project.initialized and
				project.workbench.universe_defined and
				project.system_defined and then
				project.universe.target /= Void
		end

	default_executor: !TYPE [!EIFFEL_TEST_EXECUTOR_I]
			-- Type for default executor
		require
			usable: is_interface_usable
		deferred
		ensure
			result_registered: processor_registrar.is_registered (Result)
		end

	executor (a_type: !TYPE [!EIFFEL_TEST_EXECUTOR_I]): !EIFFEL_TEST_EXECUTOR_I is
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

	factory (a_type: !TYPE [!EIFFEL_TEST_FACTORY_I [EIFFEL_TEST_CONFIGURATION_I]]): !EIFFEL_TEST_FACTORY_I [EIFFEL_TEST_CONFIGURATION_I] is
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

	processor_registrar: !EIFFEL_TEST_PROCESSOR_REGISTRAR_I [!EIFFEL_TEST_PROCESSOR_I [ANY]]
			-- Registrar managing available test processors
		require
			usable: is_interface_usable
		deferred
		ensure
			registrar_usable: Result.is_interface_usable
		end

feature -- Status report

	is_project_initialized: BOOLEAN
			-- Has `Current' already received a project for which it should manage tests?
		deferred
		end

	is_updating_tests: BOOLEAN
			-- Is test list currently beeing updated?
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

	run_all (a_type: !TYPE [!EIFFEL_TEST_EXECUTOR_I]; a_blocking: BOOLEAN)
			-- Run all tests in `tests' with executor of type `a_executor'
			-- and notify observers that executor has been launched.
		require
			usable: is_interface_usable
			project_available: is_project_initialized
			executor_available: processor_registrar.is_registered (a_type)
			executor_ready: executor (a_type).is_ready
			executor_suitable: executor (a_type).is_valid_test_list (tests)
		do
			run_list (a_type, tests, a_blocking)
		ensure
			not_blocking_equals_preparing_tests: not a_blocking = (executor (a_type).is_preparing and
				executor (a_type).queued_tests.is_equal (tests))
		end

	run_list (a_type: !TYPE [!EIFFEL_TEST_EXECUTOR_I]; a_list: !DS_LINEAR [!EIFFEL_TEST_I]; a_blocking: BOOLEAN)
			-- Run all tests in `a_list' with executor of type `a_executor'
			-- and notify observers that executor has been launched.
		require
			usable: is_interface_usable
			project_available: is_project_initialized
			executor_available: processor_registrar.is_registered (a_type)
			executor_ready: executor (a_type).is_ready
			executor_suitable: executor (a_type).is_valid_test_list (tests)
			tests_belong_to_suite: a_list.for_all (agent tests.has)
		deferred
		ensure
			not_blocking_equals_preparing_a_list: not a_blocking = (executor (a_type).is_preparing and
				executor (a_type).queued_tests.is_equal (a_list))
		end

	create_tests (a_type: !TYPE [!EIFFEL_TEST_FACTORY_I [EIFFEL_TEST_CONFIGURATION_I]]; a_conf: !EIFFEL_TEST_CONFIGURATION_I; a_blocking: BOOLEAN)
			-- Launch test creation and notify all observers
		require
			usable: is_interface_usable
			project_available: is_project_initialized
			factory_available: processor_registrar.is_registered (a_type)
			factory_ready: factory (a_type).is_ready
			factory_suitable: factory (a_type).is_valid_configuration (a_conf)
		deferred
		ensure
			not_blocking_equals_running_conf: not a_blocking = (factory (a_type).is_running and
				factory (a_type).configuration = a_conf)
		end

feature -- Basic functionality

	synchronize_tests (a_class: !CLASS_I)
			-- Parse class text and add test for every new test routine found. Tests found in class which
			-- test suite is already aware of will be updated. Existing tests which can not be found in
			-- class text will be removed.
			--
			-- Note: Any changes made to test collection by calling `synchronize_tests' are tempoary and might be
			--       undone next time the system recompiles. Also it can not be guarantueed that `a_class'
			--       is a valid test class inheriting from {TEST_SET}, so `synchronize_tests' will add or update
			--       any tests optimistically.
			--       If the class contains syntax errors, no changes to `tests' will be made.
			--
			-- `a_class': Class to be parsed for new, updated or removed tests.
		require
			usable: is_interface_usable
			project_available: is_project_initialized
			not_updating: not is_updating_tests
			a_class_in_project: is_class_in_project (a_class)
		deferred
		ensure
			not_updating: not is_updating_tests
		end

feature -- Query

	is_class_in_project (a_class: !CLASS_I): BOOLEAN is
			-- Does `a_class' belong to `project'?
			--
			-- `a_class': Class for which it should be determined whether it exists in `project'.
			-- `Result': True is class can be found in `project', False otherwise
		require
			usable: is_interface_usable
			project_available: is_project_initialized
		do
			Result := project.universe.class_named (a_class.name, a_class.group) /= Void
		end

	is_test_class (a_class: !CLASS_I): BOOLEAN is
			-- Does `Current' recognize `a_class' as a valid test class?
			--
			-- `a_class': Class for which it should be determined whether it is a test class.
			-- `Result': True is `a_class' is a test class, False otherwise.
		require
			usable: is_interface_usable
			project_available: is_project_initialized
			class_in_project: is_class_in_project (a_class)
		deferred
		end

feature {NONE} -- Query

	events (a_observer: !ACTIVE_COLLECTION_OBSERVER [!EIFFEL_TEST_I]): DS_ARRAYED_LIST [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE [ANY, TUPLE]]]
			-- <Precursor>
		do
			Result := Precursor (a_observer)
			if {l_observer: EIFFEL_TEST_SUITE_OBSERVER} a_observer then
				Result.force_last ([executor_launched_event, agent l_observer.on_executor_launched])
				Result.force_last ([factory_launched_event, agent l_observer.on_factory_launched])
				Result.force_last ([processor_finished_event, agent l_observer.on_processor_finished])
				Result.force_last ([processor_stopped_event, agent l_observer.on_processor_stopped])
			end
		end

feature -- Events

	executor_launched_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; executor: !EIFFEL_TEST_EXECUTOR_I]]
			-- Events called when test suite launches an executor.
			--
			-- test_suite: `Current'
			-- executor: Executor which was launched by `Current'.
		require
			usable: is_interface_usable
		deferred
		end

	factory_launched_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; factory: !EIFFEL_TEST_FACTORY_I [EIFFEL_TEST_CONFIGURATION_I]]]
			-- Events called when test suite launches a factory.
			--
			-- test_suite: `Current'
			-- factory: Factory which was launched by `Current'.
		require
			usable: is_interface_usable
		deferred
		end

	processor_finished_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I [ANY]]]
			-- Events called when some processor finished its task.
			--
			-- test_suite: `Current'
			-- processor: Processor that finished its task.
		require
			usable: is_interface_usable
		deferred
		end

	processor_stopped_event: !EVENT_TYPE [TUPLE [test_suite: !EIFFEL_TEST_SUITE_S; processor: !EIFFEL_TEST_PROCESSOR_I [ANY]]]
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
