indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TTY_DEBUGGER_EVENTS_HANDLER

inherit
	DEBUGGER_EVENTS_HANDLER

	THREAD_CONTROL

create
	make

feature {NONE} -- Initialization

	make is
			--
		do
			create idle_actions
			create implementation.make (Current)
		end

feature -- Status

	start_events_handling is
		do
			leave_requested := False
			wait_until_application_is_dead
		end

	stop_events_handling is
		do
			leave_requested := True
		end

feature -- Access

	new_timer: TTY_DEBUGGER_TIMER is
			--
		do
			create Result.make (implementation)
		end

	timer_win32_handle: POINTER is
		do
			Result := implementation.timer_win32_handle
		end

feature -- Change

	add_idle_action (v: PROCEDURE [ANY, TUPLE]) is
			-- Extend `idle_actions' with `v'.
		do
			if not idle_actions.has (v) then
				idle_actions.extend (v)
			end
		end

	remove_idle_action (v: PROCEDURE [ANY, TUPLE]) is
			-- Remove `v' from `idle_actions'
		local
			l_cursor: CURSOR
			l_idle_actions: like idle_actions
		do
			l_idle_actions := idle_actions
			l_cursor := l_idle_actions.cursor
			l_idle_actions.prune_all (v)
			if l_idle_actions.valid_cursor (l_cursor) then
				l_idle_actions.go_to (l_cursor)
			end
		end

	recycle	is
			--
		do
			stop_events_handling
			idle_actions.wipe_out
			idle_actions := Void
			implementation := Void
		end

feature {NONE} -- Implementation

	wait_until_application_is_dead is
			-- Wait until application is dead
		local
			stop_process_loop_on_events: BOOLEAN
		do
			from
				stop_process_loop_on_events := False
			until
				stop_process_loop_on_events
			loop
--				if not inside_debugger_menu then
					implementation.process_underlying_toolkit_event_queue
					idle_actions.call (Void)
--				end
				if not leave_requested then
					sleep (10 * 1000)
				else
					stop_process_loop_on_events := True
				end
			end
		end

	idle_actions: ACTION_SEQUENCE [TUPLE]
			-- Internal idle actions.

feature {NONE} -- Implementation

	leave_requested: BOOLEAN

	implementation: TTY_DEBUGGER_EVENTS_HANDLER_IMP;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
