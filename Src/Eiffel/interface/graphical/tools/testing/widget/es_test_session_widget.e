note
	description: "[
		Widget containing list of test session status bars.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TEST_SESSION_WIDGET

inherit
	ES_WINDOW_WIDGET [EV_VERTICAL_BOX]
		redefine
			on_before_initialize,
			on_after_initialized,
			internal_recycle
		end

	ES_SHARED_TEST_SERVICE

	TEST_SUITE_OBSERVER
		redefine
			on_session_launched,
			on_session_finished
		end

feature {NONE} -- Initialization

	on_before_initialize
			-- <Precursor>
		do
			create sessions.make
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor
			perform_with_test_suite (
				agent (a_test_suite: TEST_SUITE_S)
					do
						a_test_suite.test_suite_connection.connect_events (Current)
					end)
		end

feature {NONE} -- Access

	sessions: LINKED_LIST [ES_TEST_SESSION_STATUS_WIDGET]
			-- List of displayed sessions

feature {NONE} -- Query

	is_valid_session (a_session: TEST_SESSION_I): BOOLEAN
			-- Should a status widget be displayed for given session?
			--
			-- `a_session': A session.
			-- `Result': True if `Current' should display a status widget for `a_session', False otherwise.
		deferred
		end

feature {TEST_SUITE_S} -- Events

	frozen on_session_launched (a_test_suite: TEST_SUITE_S; a_session: TEST_SESSION_I)
			-- <Precursor>
		do
			if is_valid_session (a_session) then
				append_session (a_test_suite, a_session)
			end
		end

	frozen on_session_finished (a_test_suite: TEST_SUITE_S; a_session: TEST_SESSION_I)
			-- <Precursor>
		do
			remove_session (a_test_suite, a_session)
		end

feature {NONE} -- Events

	append_session (a_test_suite: TEST_SUITE_S; a_session: TEST_SESSION_I)
			-- Append status widget for given session.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_session': Session which was launched by test suite.
		require
			a_test_suite_attached: a_test_suite /= Void
			a_session_attached: a_session /= Void
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_session_usable: a_session.is_interface_usable
			a_session_running: a_session.has_next_step
		local
			l_status_bar: ES_TEST_SESSION_STATUS_WIDGET
			l_widget: EV_WIDGET
			l_append: BOOLEAN
		do
			from
				l_append := True
				sessions.start
			until
				not l_append or sessions.after
			loop
				l_append := sessions.item_for_iteration.session /= a_session
				sessions.forth
			end
			if l_append then
				create l_status_bar.make (a_session)
				l_widget := l_status_bar.widget
				widget.extend (l_widget)
				widget.disable_item_expand (l_widget)
				sessions.force (l_status_bar)
			end
		ensure
			a_session_usable: a_session.is_interface_usable
		end

	remove_session (a_test_suite: TEST_SUITE_S; a_session: TEST_SESSION_I)
			-- Remove any status widget for given session.
			--
			-- `a_test_suite': Test suite that triggered event.
			-- `a_session': Session which was launched by test suite and is finished now.
		require
			a_test_suite_attached: a_test_suite /= Void
			a_session_attached: a_session /= Void
			a_test_suite_usable: a_test_suite.is_interface_usable
			a_session_usable: a_session.is_interface_usable
			a_session_finished: not a_session.has_next_step
		local
			l_session: ES_TEST_SESSION_STATUS_WIDGET
			l_sessions: like sessions
		do
			from
				l_sessions := sessions
				l_sessions.start
			until
				l_sessions.after
			loop
				l_session := l_sessions.item_for_iteration
				if l_session.session = a_session then
					widget.prune (l_session.widget)
					l_session.recycle
					l_sessions.remove
				else
					l_sessions.forth
				end
			end
		ensure
			a_session_usable: a_session.is_interface_usable
			a_session_not_launched: not a_session.has_next_step
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			Precursor
			perform_with_test_suite (
				agent (a_test_suite: TEST_SUITE_S)
					do
						a_test_suite.test_suite_connection.disconnect_events (Current)
					end)
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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
