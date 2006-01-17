indexing
	description:
		"A delayed action operation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DELAYED_ACTION

create
	make

feature {NONE} -- Initialization

	make (	a_delayed_action: like delayed_action;
			a_delay: like delay
			) is
		require
			a_delayed_action /= Void
			a_delay >= 0
		do
			delayed_action := a_delayed_action
			delay := a_delay
		ensure
			delayed_action = a_delayed_action
			delay = a_delay
		end

feature -- Changes

	set_delayed_action (v: like delayed_action) is
		do
			delayed_action := v
		end

	set_delay (d: like delay) is
		do
			delay := d
		end

	set_starting_delayed_action (v: like starting_delayed_action) is
		do
			starting_delayed_action := v
		end

	set_ending_delayed_action (v: like ending_delayed_action) is
		do
			ending_delayed_action := v
		end

feature -- Delayed action access

	delayed_action_exists: BOOLEAN is
		do
			Result := delayed_action /= Void
		end

	call is
		require
			delayed_action_exists: delayed_action_exists
		do
			cancel
			delayed_action.call (Void)
		ensure
			delayed_action_timer_destroyed: delayed_action_timer = Void
		end

	request_call is
		require
			delayed_action_exists: delayed_action_exists
		do
			if delay = 0 then
				call
			elseif delayed_action_timer = Void then
				if starting_delayed_action /= Void then
					starting_delayed_action.call ([])
				end
				create delayed_action_timer.make_with_interval (delay)
				delayed_action_timer.actions.extend (agent call)
			end
		ensure
			delayed_action_timer_created: delay >0 implies delayed_action_timer /= Void
		end

	cancel is
		require
			delayed_action_exists: delayed_action_exists
		do
			if delayed_action_timer /= Void then
				delayed_action_timer.actions.wipe_out
				delayed_action_timer.destroy
				delayed_action_timer := Void
				if ending_delayed_action /= Void then
					ending_delayed_action.call ([])
				end
			end
		ensure
			delayed_action_timer_destroyed: delayed_action_timer = Void
		end

feature {NONE} -- Delayed cleaning implementation

	delay: INTEGER
			-- Number of milliseconds waited before clearing grid
			-- By waiting for a short period of time, the flicker is removed

	starting_delayed_action: PROCEDURE [ANY, TUPLE]
	ending_delayed_action: PROCEDURE [ANY, TUPLE]

	delayed_action: PROCEDURE [ANY, TUPLE]

	delayed_action_timer: EV_TIMEOUT;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
