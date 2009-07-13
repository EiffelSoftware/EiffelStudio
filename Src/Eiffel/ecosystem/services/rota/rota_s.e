note
	description: "[
		Service for running tasks of type {ROTA_TIMED_TASK_I} asynchronously.
		
		{ROTA_S} provides asynchronous functionality without the usage of multithreading, which is
		basically a main loop iteratively calling `step' on any tasks added through `run_task'.
		By specifying a `sleep_time' the tasks tells the service how often it wants to be called.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROTA_S

inherit
	SERVICE_I

feature -- Basic operations

	run_task (a_task: ROTA_TIMED_TASK_I)
			-- Call `step' on given task until it has finished its work.
			--
			-- Note: for a GUI application it should be guaranteed that `run_task' returns immediately,
			--       this however is not the case for console applications unless the instance adding
			--       a task represents a task itself.
			--
			-- `a_task': Task to be stepped through.
		require
			a_task_attached: a_task /= Void
			interface_usable: is_interface_usable
			a_task_usable: a_task.is_interface_usable
			a_task_not_launched: a_task.has_next_step
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
