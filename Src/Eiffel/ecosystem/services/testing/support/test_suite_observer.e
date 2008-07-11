indexing
	description: "[
		Observer for events in {TEST_SUITE_S}
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_SUITE_OBSERVER

inherit
	ACTIVE_COLLECTION_OBSERVER [!TEST_I]
		rename
			on_item_added as on_test_added,
			on_item_removed as on_test_removed,
			on_item_changed as on_test_changed
		end

feature {TEST_SUITE_S} -- Events

	on_executor_launched (a_test_suite: !TEST_SUITE_S; a_executor: !TEST_EXECUTOR_I)
			-- Called when test suite launches an executor.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_executor': Executor which was launched by test suite.
		require
			interface_usable: is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_executor_running: a_executor.is_running
			a_test_suite_launched_a_executor: a_executor.test_suite = a_test_suite
		do
		end

	on_factory_launched (a_test_suite: !TEST_SUITE_S; a_factory: !TEST_FACTORY_I [TEST_CONFIGURATION_I])
			-- Called when test suite launches a factory.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_factory': Factory which was launched by test suite.
		require
			usable: is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_factory_running: a_factory.is_running
			a_test_suite_launched_a_factory: a_factory.test_suite = a_test_suite
		do
		end

	on_test_launched (a_test_suite: !TEST_SUITE_S; a_test: !TEST_I)
			-- Called when some executor launches a test.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_test': Test which was launched.
		require
			interface_usable: is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_test_suite_contains_a_test: a_test_suite.tests.has (a_test)
			a_test_is_running: a_test.is_running
			a_test_suite_launched_execution: a_test.executor.test_suite = a_test_suite
		do
		end

	on_test_revealed (a_test_suite: !TEST_SUITE_S; a_test: !TEST_I)
			-- Called when new outcome is available for test.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_test': Test containing new outcome.
		require
			interface_usable: is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_test_suite_contains_a_test: a_test_suite.tests.has (a_test)
			a_test_has_outcome: a_test.is_outcome_available
		do
		end

	on_processor_finished (a_test_suite: !TEST_SUITE_S; a_processor: !TEST_PROCESSOR_I [ANY]) is
			-- Called when some processor finished its task.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_processor': Processor that finished its task.
		require
			usable: is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_processor_usable: a_processor.is_interface_usable
			a_processor_finished: a_processor.is_finished
			a_test_suite_launched_a_processor: a_processor.test_suite = a_test_suite
		do
		end

end
