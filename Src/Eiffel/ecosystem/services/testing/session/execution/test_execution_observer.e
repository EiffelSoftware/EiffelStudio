note
	description: "[
		Observer for events in {TEST_EXECUTION_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EXECUTION_OBSERVER

inherit
	TEST_SESSION_OBSERVER

feature {TEST_EXECUTION_I} -- Events

	on_test_running (a_session: TEST_EXECUTION_I; a_test: TEST_I)
			-- Called when a test is being executed.
			--
			-- `a_session': Test execution session which triggered event.
			-- `a_test': Test which is being run by `a_session'.
		require
			a_session_attached: a_session /= Void
			a_test_attached: a_test /= Void
			a_session_usable: a_session.is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_test_running: a_session.is_test_running (a_test)
		do
		ensure
			a_session.is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_test_runing: a_session.is_test_running (a_test)
		end

	on_test_executed (a_session: TEST_EXECUTION_I; a_test: TEST_I; a_result: EQA_RESULT)
			-- Called when a test is finished executing.
			--
			-- Note: a call to `on_test_executed' implies that the test will be immediately removed
			--       from the session after all observers have been notified.
			--
			-- `a_session': Test execution session which triggered event.
			-- `a_test': Test which was run by `a_session'.
			-- `a_result': Obtained result from execution.
		require
			a_session_attached: a_session /= Void
			a_test_attached: a_test /= Void
			a_result_attached: a_result /= Void
			a_session_usable: a_session.is_interface_usable
			a_session_running: a_session.has_next_step
			a_test_usable: a_test.is_interface_usable
			not_a_session_has_test: not a_session.has_test (a_test)
			has_result: a_session.record.has_result_for_test (a_test)
			a_result_valid: a_session.record.result_for_test (a_test) = a_result
		do
		ensure
			a_session_usable: a_session.is_interface_usable
			a_session_running: a_session.has_next_step
			a_test_usable: a_test.is_interface_usable
			not_a_session_has_test: not a_session.has_test (a_test)
			has_result: a_session.record.has_result_for_test (a_test)
			a_result_valid: a_session.record.result_for_test (a_test) = a_result
		end

	on_test_aborted (a_session: TEST_EXECUTION_I; a_test: TEST_I)
			-- Called when a test is removed from `Current' without being executed.
			--
			-- `a_session': Test execution session which triggered event.
			-- `a_test': Test which was removed.
		require
			a_session_attached: a_session /= Void
			a_test_attached: a_test /= Void
			a_session_usable: a_session.is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_session_running: a_session.has_next_step
			a_session_not_has_test: not a_session.has_test (a_test)
		do
		ensure
			a_session_usable: a_session.is_interface_usable
			a_test_usable: a_test.is_interface_usable
			a_session_running: a_session.has_next_step
			a_session_not_has_test: not a_session.has_test (a_test)
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
