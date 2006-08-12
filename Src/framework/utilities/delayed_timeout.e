indexing
	description: "[
					Objects that provides the functionality of calling actions after certain amount of time
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DELAYED_TIMEOUT

create
	make

feature{NONE} -- Initialization

	make (a_delayed_time: INTEGER; a_interval: INTEGER) is
			-- Initialize `delayed_time' with `a_delayed_time' and `interval' with `a_interval'.
		require
			a_delayed_time_non_negative: a_delayed_time >= 0
			a_interval_non_negative: a_interval >= 0
		do
			create actions

			create delayed_timer
			set_delayed_time (a_delayed_time)
			delayed_timer.actions.extend (agent start_actions_timer)

			create timer
			set_interval (a_interval)
		ensure
			actions_attached: actions /= Void
			timer_attached: timer /= Void
			delayed_timer_attached: delayed_timer /= Void
			delayed_time_set: delayed_time = a_delayed_time
			internval_set: interval = a_interval
		end

feature -- Access

	delayed_time: INTEGER
			-- Time (in milliseconds) to be waited before `actions' get called			
			-- If 0, `actions' will be called immediately.

	interval: INTEGER
			-- Time between calls to `actions' in milliseconds.
			-- If 0, then `actions' are disabled.

	actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Action to be called when time out

feature -- Status report

	is_kamikazed: BOOLEAN
			-- Is `actions' kamikazed?
			-- e.g., should agents in `actions' only be called once?
			-- Note: agents won't be removed from `actions'.

feature -- Timer manipulation

	start_timer is
			-- Start timer and after `delayed_time', `ations' will be called every `internal' milliseconds.
		local
			l_delayed_time: INTEGER
		do
			stop_timer
			l_delayed_time := delayed_time
			if l_delayed_time > 0 then
				delayed_timer.set_interval (l_delayed_time)
			else
				start_actions_timer
			end
		end

	stop_timer is
			-- Stop timer.
		do
			timer.set_interval (0)
			delayed_timer.set_interval (0)
		end

feature -- Setting

	set_delayed_time (a_delayed_time: INTEGER) is
			-- Set `delayed_time' with `a_delayed_time'.
			-- Has effects the next time when `start_timer' is called.
		require
			a_delayed_time_non_negative: a_delayed_time >= 0
		do
			delayed_time := a_delayed_time
		ensure
			delayed_time_set: delayed_time = a_delayed_time
		end

	set_interval (a_interval: INTEGER) is
			-- Set `interval' with `a_interval'.
			-- Has effects the next time when `start_timer' is called.
		do
			interval := a_interval
		ensure
			interval_set: interval = a_interval
		end

	enable_kamikazed is
			-- Ensure `actions' will be invoked in kamikazed mode.
			-- Has effects the next time when `start_timer' is called.
		do
			is_kamikazed := True
		ensure
			is_kamikazed_set: is_kamikazed
		end

	disable_kamikazed is
			-- Ensure `actions' will be invoked in non-kamikazed mode.
			-- Has effects the next time when `start_timer' is called.
		do
			is_kamikazed := False
		ensure
			is_kamikazed_set: not is_kamikazed
		end

feature{NONE} -- Implementation

	delayed_timer: EV_TIMEOUT
			-- Timer used to delay invocation of `actions'

	timer: EV_TIMEOUT
			-- Timer

	start_actions_timer is
			-- Start `timer' for `actions' invocation.
		local
			l_timer: like timer
		do
			delayed_timer.set_interval (0)
			l_timer := timer
			l_timer.actions.wipe_out
			if is_kamikazed then
				l_timer.actions.extend_kamikaze (agent call_actions)
			else
				l_timer.actions.extend (agent call_actions)
			end
			l_timer.set_interval (interval)
		end

	call_actions is
			-- Call `actions'.
		do
			actions.call ([])
		end

invariant
	delayed_timer_attached: delayed_timer /= Void
	timer_attached: timer /= Void
	actions_attached: actions /= Void

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

