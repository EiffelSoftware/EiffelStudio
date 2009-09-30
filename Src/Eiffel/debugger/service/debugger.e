note
	description: "Objects that represents a debugger"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER

inherit
	DEBUGGER_S

	DISPOSABLE_SAFE

	SHARED_DEBUGGER_MANAGER

	DEBUGGER_MANAGER_OBSERVER
		redefine
			on_application_launched,
			on_application_resumed,
			on_application_stopped,
			on_application_exited,
			on_debugging_terminated
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			attach_to_debugger (debugger_manager)
		end

feature -- Status report

	has_active_debugging_session: BOOLEAN
		do
			Result := attached debugger_manager as dm and then dm.is_debugging
		end

	debuggee_exits: BOOLEAN
			-- Is there an active execution?
			-- (i.e: is the debugger running?)
		do
			Result := attached debugger_manager as dm and then dm.application_is_executing
		end

	debuggee_running: BOOLEAN
		do
			Result := debuggee_exits and then not debuggee_stopped
		end

	debuggee_stopped: BOOLEAN
		do
			Result := (attached {DEBUGGER_MANAGER} debugger_manager as dm) and then dm.safe_application_is_stopped
		end

feature {DEBUGGER_MANAGER} -- Debugger manager observer

	on_application_launched (dbg: DEBUGGER_MANAGER)
			-- The debugged application has just been launched.
		do
			application_launched_event.publish ([Current])
		end

	on_application_resumed (dbg: DEBUGGER_MANAGER)
			-- The debugged application has been resumed after a stop.
		do
			application_resumed_event.publish ([Current])
		end

	on_application_stopped (dbg: DEBUGGER_MANAGER)
			-- The debugged application has just stopped (paused).
		do
			application_stopped_event.publish ([Current])
		end

	on_application_exited (dbg: DEBUGGER_MANAGER)
			-- The debugged application has just died (exited).
		do
			application_exited_event.publish ([Current])
		end

	on_debugging_terminated (dbg: DEBUGGER_MANAGER)
			-- The debugging is terminated.
		do
			debugging_terminated_event.publish ([Current])
		end

feature -- Events

	application_launched_event: EVENT_TYPE [TUPLE [dbg: DEBUGGER_S]]
			-- <Precursor>
		do
			if attached internal_application_launched_event as l_result then
				Result := l_result
			else
				create Result
				internal_application_launched_event := Result
				auto_dispose (Result)
			end
		end

	application_resumed_event: EVENT_TYPE [TUPLE [dbg: DEBUGGER_S]]
			-- <Precursor>
		do
			if attached internal_application_resumed_event as l_result then
				Result := l_result
			else
				create Result
				internal_application_resumed_event := Result
				auto_dispose (Result)
			end
		end

	application_stopped_event: EVENT_TYPE [TUPLE [dbg: DEBUGGER_S]]
			-- <Precursor>
		do
			if attached internal_application_stopped_event as l_result then
				Result := l_result
			else
				create Result
				internal_application_stopped_event := Result
				auto_dispose (Result)
			end
		end

	application_exited_event: EVENT_TYPE [TUPLE [dbg: DEBUGGER_S]]
			-- <Precursor>
		do
			if attached internal_application_exited_event as l_result then
				Result := l_result
			else
				create Result
				internal_application_exited_event := Result
				auto_dispose (Result)
			end
		end

	debugging_terminated_event: EVENT_TYPE [TUPLE [dbg: DEBUGGER_S]]
			-- <Precursor>
		do
			if attached internal_debugging_terminated_event as l_result then
				Result := l_result
			else
				create Result
				internal_debugging_terminated_event := Result
				auto_dispose (Result)
			end
		end

feature -- Events: Connection point

	frozen debugger_connection: EVENT_CONNECTION [DEBUGGER_OBSERVER, DEBUGGER_S]
			-- <Precursor>
		do
			if attached internal_debugger_connection as l_result then
				Result := l_result
			else
				create Result.make (
					agent (ia_observer: DEBUGGER_OBSERVER): ARRAY [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE [ANY, TUPLE]]]
						do
							Result := <<
								 [application_launched_event, agent ia_observer.on_application_launched],
								 [application_resumed_event, agent ia_observer.on_application_resumed],
								 [application_stopped_event, agent ia_observer.on_application_stopped],
								 [application_exited_event, agent ia_observer.on_application_exited],
								 [debugging_terminated_event, agent ia_observer.on_debugging_terminated]
								>>
						end)
				auto_dispose (Result)
				internal_debugger_connection := Result
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_application_launched_event: detachable like application_launched_event
			-- Cached version of `application_launched_event'.
			-- Note: Do not use directly!

	internal_application_resumed_event: detachable like application_resumed_event
			-- Cached version of `application_resumed_event'.
			-- Note: Do not use directly!

	internal_application_stopped_event: detachable like application_stopped_event
			-- Cached version of `application_stopped_event'.
			-- Note: Do not use directly!

	internal_application_exited_event: detachable like application_exited_event
			-- Cached version of `application_exited_event'.
			-- Note: Do not use directly!

	internal_debugging_terminated_event: detachable like debugging_terminated_event
			-- Cached version of `debugging_terminated_event'.
			-- Note: Do not use directly!

	internal_debugger_connection: detachable like debugger_connection
			-- Cached version of `debugger_connection'.
			-- Note: Do not use directly!			

feature {NONE} -- Access: consumer

	frozen debugger_consumer: SERVICE_CONSUMER [DEBUGGER_S]
			-- Access to debugger service {DEBUGGER_S}
		do
			create Result
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		local
			l_debugger: DEBUGGER_S
		do
			if a_explicit then
				if debugger_consumer.is_service_available then
					l_debugger := debugger_consumer.service
					if l_debugger.is_interface_usable then
--						l_debugger.connection.disconnect_events (Current)
					end
				end
			end
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
