note
	description: "Objects that manage timer events based on EB_DEVELOPMENT_WINDOW."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_EVENTS_HANDLER

inherit
	DEBUGGER_EVENTS_HANDLER

	EV_SHARED_APPLICATION

create
	make

feature {NONE} -- Initialization

	make (a: like development_window_agent)
		do
			development_window_agent := a
			create implementation
		end

feature -- Access

	development_window_agent: FUNCTION [ANY, TUPLE, EB_DEVELOPMENT_WINDOW]

feature -- Status

	start_events_handling
		do
			--| Do nothing
		end

	stop_events_handling
		do
			--| Do nothing			
		end

feature -- Access

	new_timer: EV_DEBUGGER_TIMER
			--
		do
			create Result
		end

	timer_win32_handle: POINTER
			--
		do
			if attached development_window_agent as agt then
				if attached agt.item (Void) as dw then
					Result := implementation.windows_handle_from (dw)
				end
			end
		ensure then
			result_not_null: Result /= Default_pointer
		end

feature -- Change

	recycle
			--
		do
			development_window_agent := Void
			implementation := Void
		end

	add_idle_action (v: PROCEDURE [ANY, TUPLE]; is_kamikazee: BOOLEAN)
			-- Add `a_idle_actions' to idle_actions if not already present.
			-- Thread safe
		do
			if is_kamikazee then
				ev_application.add_idle_action_kamikaze (v)
			else
				ev_application.add_idle_action (v)
			end
		end

	remove_idle_action (v: PROCEDURE [ANY, TUPLE])
			-- Remove `v' from `idle_actions'
		do
			ev_application.remove_idle_action (v)
		end

feature {NONE} -- Implementation

	implementation: EB_DEBUGGER_EVENTS_HANDLER_IMP ;

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
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

