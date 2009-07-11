note
	description: "[
		Observer for events in {TEST_SUITE_S}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SUITE_OBSERVER

inherit
	ACTIVE_COLLECTION_OBSERVER [TEST_I]
		rename
			on_item_added as on_test_added,
			on_item_removed as on_test_removed,
			on_item_changed as on_test_changed,
			on_items_reset as on_tests_reset
		end

feature {TEST_SUITE_S} -- Events

	on_processor_launched (a_test_suite: TEST_SUITE_S; a_processor: TEST_PROCESSOR_I)
			-- Called when test suite launches a processor.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_factory': Factory which was launched by test suite.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_processor_running: a_processor.is_running
			a_test_suite_launched_a_processor: a_processor.test_suite = a_test_suite
		do
		end

	on_processor_proceeded (a_test_suite: TEST_SUITE_S; a_processor: TEST_PROCESSOR_I)
			-- Called when some processor has proceeded with its task.
			--
			-- `a_test_suite': Test suite managing processor.
			-- `a_processor': Processor that has proceeded with its task.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_processor_usable: a_processor.is_interface_usable
			a_processor_not_finished: a_processor.is_running and not a_processor.is_finished
			a_test_suite_launched_a_processor: a_processor.test_suite = a_test_suite
		do
		end

	on_processor_finished (a_test_suite: TEST_SUITE_S; a_processor: TEST_PROCESSOR_I)
			-- Called when some processor finished its task.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_processor': Processor that finished its task.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_processor_usable: a_processor.is_interface_usable
			a_processor_finished: a_processor.is_finished
			a_test_suite_launched_a_processor: a_processor.test_suite = a_test_suite
		do
		end

	on_processor_stopped (a_test_suite: TEST_SUITE_S; a_processor: TEST_PROCESSOR_I)
			-- Called when a processor has completely stopped
			--
			-- Note: It is not guaranteed that all observers will receive this notification. This is because
			--       any observer in the list can restart the processor during the notification.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_processor': Processor that has just stopped.
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_processor_usable: a_processor.is_interface_usable
			a_processor_stopped: not a_processor.is_running
		do
		end

	on_processor_error (a_test_suite: TEST_SUITE_S; a_processor: TEST_PROCESSOR_I; a_error: STRING; a_token_values: TUPLE)
			-- Called when a processor raises an error
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_processor': Processor raising error.
			-- `a_error' : Readable error message containing tokens
			-- `a_token_values': Values for each token in `a_error'
		require
			is_interface_usable: attached {USABLE_I} Current as l_usable implies l_usable.is_interface_usable
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_processor_usable: a_processor.is_interface_usable
			a_processor_stopped: a_processor.is_running
			a_token_values_attached: a_token_values /= Void
		do
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
