note
	description: "[
		Observer for events in {TEST_SUITE_S}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SUITE_OBSERVER

inherit
	EVENT_OBSERVER_I

feature {TEST_SUITE_S} -- Events

	on_test_added (a_test_suite: TEST_SUITE_S; a_test: TEST_I)
			-- Called when a test was added to the test suite.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_test': Test added to `a_test_suite'.
		require
			a_test_suite_attached: a_test_suite /= Void
			a_test_attached: a_test /= Void
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_test_suite_has_test: a_test_suite.has_test (a_test.name) and then
				a_test_suite.test (a_test.name) = a_test
		do
		end

	on_test_removed (a_test_suite: TEST_SUITE_S; a_test: TEST_I)
			-- Called when a test was removed from the test suite.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_test': Test removed from `a_test_suite'.
		require
			a_test_suite_attached: a_test_suite /= Void
			a_test_attached: a_test /= Void
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_test_suite_has_test: not a_test_suite.has_test (a_test.name)
		do
		end

	on_session_launched (a_test_suite: TEST_SUITE_S; a_session: TEST_SESSION_I)
			-- Called when test suite launches a session.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_session': Session which was launched by test suite.
		require
			a_test_suite_attached: a_test_suite /= Void
			a_session_attached: a_session /= Void
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_session_usable: a_session.is_interface_usable
			a_session_running: a_session.has_next_step
			record_added_to_repo: a_test_suite.record_repository.has_record (a_session.record)
		do

		ensure
			a_session_usable: a_session.is_interface_usable
			record_added_to_repo: a_test_suite.record_repository.has_record (a_session.record)
		end

	on_session_finished (a_test_suite: TEST_SUITE_S; a_session: TEST_SESSION_I)
			-- Called when a session is finished.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_session': Session which was launched by test suite and is finished now.
		require
			a_test_suite_attached: a_test_suite /= Void
			a_session_attached: a_session /= Void
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_session_usable: a_session.is_interface_usable
			a_session_finished: not a_session.has_next_step
		do
		ensure
			a_session_usable: a_session.is_interface_usable
			a_session_not_launched: not a_session.has_next_step
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
