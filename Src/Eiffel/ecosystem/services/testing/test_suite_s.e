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

	USABLE_I

	TEST_COLLECTION_I
		redefine
			events
		end

	TEST_EXECUTOR_OBSERVER

feature -- Status report

	has_active_executor: BOOLEAN
			-- Is an executor currently executing tests?
		require
			usable: is_interface_usable
		deferred
		end

	is_executor_ready (a_type: !TYPE [TEST_EXECUTOR_I]): BOOLEAN
			-- Is an executor of `a_type' available and is it ready to run tests?
		require
			interface_usable: is_interface_usable
		do
			Result := executor_registrar.is_registered (a_type) and then
				executor_registrar.executor (a_type).is_ready
		end

feature -- Access

	active_executor: !TEST_EXECUTOR_I
			-- Executor currently executing tests
		require
			usable: is_interface_usable
			executor_active: has_active_executor
		deferred
		ensure
			executor_running: Result.is_running
		end

	executor_registrar: !TEST_EXECUTOR_REGISTRAR_I
			-- Registrar managing available executors
		require
			usable: is_interface_usable
		deferred
		ensure
			registrar_usable: Result.is_interface_usable
		end

	factory_registrar: !TEST_FACTORY_REGISTRAR_I
			-- Registrar managing available test factories
		require
			usable: is_interface_usable
		deferred
		ensure
			registrar_usable: Result.is_interface_usable
		end

feature -- Status setting

	run_test (a_executor: !TYPE [TEST_EXECUTOR_I]; a_test: !TEST_I)
			-- Run `a_test' with executor of type `a_executor'.
		require
			usable: is_interface_usable
			not_has_active_executor: not has_active_executor
			a_executor_ready: is_executor_ready (a_executor)
			a_test_valid: executor_registrar.executor (a_executor).is_valid_test (a_test)
		local
			l_list: !DS_ARRAYED_LIST [!TEST_I]
		do
			create l_list.make (1)
			l_list.put_first (a_test)
			run_list (a_executor, l_list)
		ensure
			has_active_executor: has_active_executor
			testing_a_test: active_executor.tests.count = 1 and then
				active_executor.tests.first = a_test
		end

	run_all (a_executor: !TYPE [TEST_EXECUTOR_I])
			-- Run all tests in `tests' with executor of type `a_executor'.
		require
			usable: is_interface_usable
			not_has_active_executor: not has_active_executor
			a_executor_ready: is_executor_ready (a_executor)
			tests_valid: executor_registrar.executor (a_executor).is_valid_list (tests)
		do
			run_list (a_executor, tests)
		ensure
			has_active_executor: has_active_executor
			testing_tests: active_executor.tests.is_equal (tests)
		end

	run_list (a_executor: !TYPE [TEST_EXECUTOR_I]; a_list: !DS_LINEAR [!TEST_I])
			-- Run all tests in `a_list' with executor of type `a_executor'.
		require
			usable: is_interface_usable
			not_has_active_executor: not has_active_executor
			a_executor_ready: is_executor_ready (a_executor)
			a_list_valid: executor_registrar.executor (a_executor).is_valid_list (a_list)
		deferred
		ensure
			has_active_executor: has_active_executor
			testing_a_list: active_executor.tests.is_equal (a_list)
		end

	stop is
			-- Stop the current execution of tests.
		require
			usable: is_interface_usable
			has_active_executor: has_active_executor
		deferred
		ensure
			not_has_active_executor: not has_active_executor
		end

feature -- Events

	executor_activated_event: !EVENT_TYPE [TUPLE [test_suite: !TEST_SUITE_S]]
			-- Called after an executor has been activated.
		require
			usable: is_interface_usable
		deferred
		end

	executor_deactivated_event: !EVENT_TYPE [TUPLE [test_suite: !TEST_SUITE_S; executor: !TEST_EXECUTOR_I]]
			-- Called after an executor has been deactivated.
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
				Result.force_last ([executor_activated_event, agent l_observer.on_executor_activated])
				Result.force_last ([executor_deactivated_event, agent l_observer.on_executor_deactivated])
			end
		end

end
