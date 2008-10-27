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
			on_item_changed as on_test_changed,
			on_items_reset as on_tests_reset
		end

feature {EIFFEL_TEST_SUITE_S} -- Events

	on_processor_launched (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
			-- Called when test suite launches a processor.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_factory': Factory which was launched by test suite.
		require
			usable: is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_processor_running: a_processor.is_running
			a_test_suite_launched_a_processor: a_processor.test_suite = a_test_suite
		do
		end

	on_processor_proceeded (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I) is
			-- Called when some processor has proceeded with its task.
			--
			-- `a_test_suite': Test suite managing processor.
			-- `a_processor': Processor that has proceeded with its task.
		require
			usable: is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_processor_usable: a_processor.is_interface_usable
			a_processor_not_finished: a_processor.is_running and not a_processor.is_finished
			a_test_suite_launched_a_processor: a_processor.test_suite = a_test_suite
		do
		end

	on_processor_finished (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I)
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

	on_processor_stopped (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I) is
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

	on_processor_error (a_test_suite: !EIFFEL_TEST_SUITE_S; a_processor: !EIFFEL_TEST_PROCESSOR_I; a_error: !STRING; a_token_values: !TUPLE)
			-- Called when a processor raises an error
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_processor': Processor raising error.
			-- `a_error' : Readable error message containing tokens
			-- `a_token_values': Values for each token in `a_error'
		require
			usable: is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_processor_usable: a_processor.is_interface_usable
			a_processor_stopped: a_processor.is_running
		do
		end

end
