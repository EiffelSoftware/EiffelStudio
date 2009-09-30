note
	description: "[
		Service for debugger
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DEBUGGER_S

inherit
	SERVICE_I

	EVENT_CONNECTION_POINT_I [DEBUGGER_OBSERVER, DEBUGGER_S]
		rename
			connection as debugger_connection
		end

feature -- Status report: debugger

	has_active_debugging_session: BOOLEAN
			-- Is there an active or starting execution?
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Status report: debuggee

	debuggee_exits: BOOLEAN
			-- Is there an active execution?
			-- (i.e: is the debugger running?)
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	debuggee_running: BOOLEAN
			-- Is the debuggee running?
			-- (i.e: exists and not stopped)
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			is_running_implies_in_execution: Result implies debuggee_exits
		end

	debuggee_stopped: BOOLEAN
			-- Is the debuggee stopped?
			-- (i.e: exists and stopped at breakpoints, step completed, paused, ...)	
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			not_is_stopped_implies_in_execution: not Result implies not debuggee_exits
		end

feature -- Events

	application_launched_event: EVENT_TYPE_I [TUPLE [dbg: DEBUGGER_S]]
			-- Event call when application has just been launched.
			--
			-- dbg: The Current debugger object publishing the event.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result ~ application_launched_event
		end

	application_resumed_event: EVENT_TYPE_I [TUPLE [dbg: DEBUGGER_S]]
			-- Event call when application has just been resumed.
			--
			-- dbg: The Current debugger object publishing the event.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result ~ application_resumed_event
		end

	application_stopped_event: EVENT_TYPE_I [TUPLE [sender: DEBUGGER_S]]
			-- Event call when application has just stopped (paused).
			--
			-- dbg: The Current debugger object publishing the event.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result ~ application_stopped_event
		end

	application_exited_event: EVENT_TYPE_I [TUPLE [dbg: DEBUGGER_S]]
			-- Event call when application has just died (exited).
			--
			-- dbg: The Current debugger object publishing the event.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result ~ application_exited_event
		end

	debugging_terminated_event: EVENT_TYPE_I [TUPLE [dbg: DEBUGGER_S]]
			-- Event call when debugging is terminated.
			--
			-- dbg: The Current debugger object publishing the event.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_attached: Result /= Void
			result_consistent: Result ~ debugging_terminated_event
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
