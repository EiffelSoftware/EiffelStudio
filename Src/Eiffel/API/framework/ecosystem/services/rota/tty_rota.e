note
	description: "[
		Implementation of {ROTA_S} for command line applications, where `run_task' is only blocking for
		the first call.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TTY_ROTA

inherit
	ROTA
		redefine
			run_task
		end

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Status report

	is_looping: BOOLEAN
			-- Is `loop_to_end' currently called?

feature -- Basic operations

	run_task (a_task: ROTA_TIMED_TASK_I)
			-- <Precursor>
		do
			Precursor (a_task)
			if not is_looping then
				loop_to_end
			end
		end

feature {NONE} -- Implementation

	loop_to_end
			-- Step through `tasks' until empty.
		require
			usable: is_interface_usable
			not_looping: not is_looping
		local
			l_tasks: like tasks
			l_int_64: INTEGER_64
		do
			is_looping := True

			from
				l_tasks := tasks
			until
				l_tasks.is_empty
			loop
				proceed_all_tasks
				if not l_tasks.is_empty and min_sleep_time > 0 then
					l_int_64 := min_sleep_time.as_integer_64
					sleep (l_int_64 * {INTEGER_64} 1_000_000)
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
