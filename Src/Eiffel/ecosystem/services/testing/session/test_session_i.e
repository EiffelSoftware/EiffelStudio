note
	description: "[
		Abstract interface of a session in which test suite related tasks are performed. This may include
		finding existing tests, creating new tests or executing tests.
		
		Sessions represent tasks which are launched and run by a {ROTA_S} service through the test suite.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_SESSION_I

inherit
	ROTA_TIMED_TASK_I
		export
			{ANY} step, cancel
		end

	EVENT_CONNECTION_POINT_I [TEST_SESSION_OBSERVER, TEST_SESSION_I]

feature -- Access

	test_suite: TEST_SUITE_S
			-- Test suite for which tasks are performed.
		require
			usable: is_interface_usable
		deferred
		ensure
			result_usable: Result.is_interface_usable
		end

	progress: REAL
			-- Progress of current run between 0 and 1
		require
			usable: is_interface_usable
			running: has_next_step
			has_progress: has_progress
		deferred
		ensure
			not_negative: Result >= {REAL} 0.0
			smaller_equal_one: Result <= {REAL} 1.0
		end

feature {NONE} -- Access

	connection_cache: detachable like connection
			-- Cache for `connection'
			--
			-- Note: do not use directly, use `connection' instead.

feature -- Status report

	has_progress: BOOLEAN
			-- Does current specify `progress'?
		require
			usable: is_interface_usable
			running: has_next_step
		deferred
		end

feature -- Status setting

	frozen step
			-- <Precursor>
		do
			proceed
			proceeded_event.publish ([Current])
		end

feature {TEST_SUITE_S} -- Status setting

	start
			-- Start performing tasks.
		require
			usable: is_interface_usable
			not_running: not has_next_step
		deferred
		end

feature {NONE} -- Status setting

	proceed
			-- Perform a next step.
		require
			usable: is_interface_usable
			has_next_step: has_next_step
		deferred
		end

feature -- Events

	connection: EVENT_CONNECTION_I [TEST_SESSION_OBSERVER, TEST_SESSION_I]
			-- <Precursor>
		local
			l_result: like connection_cache
		do
			l_result := connection_cache
			if l_result = Void then
				l_result := create {EVENT_CONNECTION [TEST_SESSION_OBSERVER, TEST_SESSION_I]}.make (
					agent (an_observer: TEST_SESSION_OBSERVER): ARRAY [TUPLE[ EVENT_TYPE [TUPLE], PROCEDURE [ANY, TUPLE]]]
						do
							Result := <<
									[proceeded_event, agent an_observer.on_proceeded]
								>>
						end)
				connection_cache := l_result
			end
			Result := l_result
		end

feature {NONE} -- Events

	proceeded_event: EVENT_TYPE [TUPLE [session: TEST_SESSION_I]]
			-- Events called after `Current' proceeded
			--
			-- Note: implementers do not have to publish this event since it is already done by `step_task'.
		require
			usable: is_interface_usable
		deferred
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
