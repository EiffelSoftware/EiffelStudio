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

	frozen record: like new_record
		require
			usable: is_interface_usable
			running: has_next_step
		local
			l_cache: like record_cache
		do
			l_cache := record_cache
			if l_cache = Void then
				l_cache := new_record
				record_cache := l_cache
			end
			Result := l_cache
		ensure
			result_attached: Result /= Void
			result_consistent: Result = record
		end

	progress: REAL
			-- Progress of current run between 0 and 1
		require
			usable: is_interface_usable
			running: has_next_step
		deferred
		ensure
			not_negative: Result >= {REAL} 0.0
			smaller_equal_one: Result <= {REAL} 1.0
		end

feature {NONE} -- Access

	record_cache: detachable like record
			-- Cache for `record'
			--
			-- Note: do not use directly, use `record' instead.

	connection_cache: detachable like connection
			-- Cache for `connection'
			--
			-- Note: do not use directly, use `connection' instead.

feature -- Status setting

	step
			-- <Precursor>
			--
			-- Note: implementors are responsible of calling `proceeded_event' frequently.
		deferred
		ensure then
			record_detached_if_finished: not has_next_step implies (record_cache = Void)
			old_record_completed: not has_next_step implies not (old record).is_running
		end

	cancel
			-- <Precursor>
		deferred
		ensure then
			record_detached: record_cache = Void
			old_record_completed: not (old record).is_running
		end

feature {TEST_SUITE_S} -- Status setting

	start
			-- Start performing tasks.
			--
			-- Note: If `has_next_step' is False after `start' returns, a record is not made available and
			--       the session is considered to be failed of some reason. Although this behavior is
			--       exceptional, it is not considered to be an error and will be silently ignored by the
			--       test suite.
		require
			usable: is_interface_usable
			not_running: not has_next_step
		deferred
		ensure
			has_next_step_implies_unattached_record: has_next_step implies not record.is_attached
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
									[proceeded_event, agent an_observer.on_proceeded],
									[error_event, agent an_observer.on_error]
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
			--
			-- session: `Current'.
		require
			usable: is_interface_usable
		deferred
		end

	error_event: EVENT_TYPE [TUPLE [session: TEST_SESSION_I; error: READABLE_STRING_GENERAL]]
			-- Events called when `Current' encountered an error.
			--
			-- session: `Current'.
			-- error: Error message.
		require
			usable: is_interface_usable
		deferred
		end

feature {NONE} -- Factory

	new_record: TEST_SESSION_RECORD
			-- Create new record for current run.
			--
			-- Note: redefine to have specific records in `Current'.
		require
			usable: is_interface_usable
			running: has_next_step
		do
			create Result.make (Current)
		ensure
			result_attached: Result /= Void
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
