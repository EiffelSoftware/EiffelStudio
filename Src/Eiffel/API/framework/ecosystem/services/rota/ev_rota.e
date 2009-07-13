note
	description: "[
		Implementation of {ROTA_S} to be used in a vision2 application. A call to `run_task' will alsways
		return immediately.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ROTA

inherit
	ROTA
		redefine
			make,
			run_task,
			safe_dispose
		end

	EV_SHARED_APPLICATION

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			Precursor
			create timer
			timer.actions.extend (agent loop_to_next_pause)
		end

feature {NONE} -- Access

	timer: EV_TIMEOUT
			-- Timer for calling back `iterate'

feature -- Status report

	is_looping: BOOLEAN
			-- Is `loop_to_next_pause' already called?

feature -- Basic operations

	run_task (a_task: ROTA_TIMED_TASK_I)
			-- <Precursor>
		do
			Precursor (a_task)
			if not is_looping then
					-- Note: we do not call iterate directly to garuantee that `append_task' returns before
					--       stepping through `a_task'.
				timer.set_interval (0)
				ev_application.add_idle_action_kamikaze (agent loop_to_next_pause)
			end
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				timer.destroy
			end
		end

feature {NONE} -- Implementation

	loop_to_next_pause
			-- Call `iterate' through a loop.
			--
			-- Note: this routine does only return if `min_sleep_time' is greater zero after calling
			--       `iterate', using `timer' to be called back. To make sure ev events are still processed,
			--       `process_events' is called after every iteration.
		require
			not_looping: not is_looping
		local
			l_pause: BOOLEAN
		do
			is_looping := True
			from
				timer.set_interval (0)
			until
				l_pause
			loop
				min_sleep_time := min_sleep_time.max_value
				proceed_all_tasks
				if tasks.is_empty then
					l_pause := True
				elseif min_sleep_time > 0 then
					timer.set_interval (min_sleep_time.to_integer_32)
					l_pause := True
				else
					ev_application.process_events
				end
			end
			is_looping := False
		ensure
			not_looping: not is_looping
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
