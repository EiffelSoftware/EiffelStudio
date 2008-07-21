indexing
	description: "[
		Observer for events in {EIFFEL_TEST_SUITE_S}.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_SUITE_OBSERVER

inherit
	ACTIVE_COLLECTION_OBSERVER [!EIFFEL_TEST_I]
		rename
			on_item_added as on_test_added,
			on_item_removed as on_test_removed,
			on_item_changed as on_test_changed
		end

feature {EIFFEL_TEST_SUITE_S} -- Events

	on_executor_launched (a_test_suite: !EIFFEL_TEST_SUITE_S; a_executor: !EIFFEL_TEST_EXECUTOR_I)
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

	on_factory_launched (a_test_suite: !EIFFEL_TEST_SUITE_S; a_factory: !EIFFEL_TEST_FACTORY_I [EIFFEL_TEST_CONFIGURATION_I])
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

	on_processor_finished (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I [ANY])
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

	on_processor_stopped (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I [ANY]) is
			-- Called when a processor has completely stopped
			--
			-- Note: It is not guaranteed that all observers will receive this notification. This is because
			--       any observer in the list can restart the processor during the notification.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_processor': Processor that has just stopped.
		require
			usable: is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_processor_usable: a_processor.is_interface_usable
			a_processor_stopped: not a_processor.is_running
		do
		end

end
