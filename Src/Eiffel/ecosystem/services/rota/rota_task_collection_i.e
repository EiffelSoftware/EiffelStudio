note
	description: "[
		Interface for objects which contain a list of {ROTA_TASK_I} and eventually let them proceed
		asynchronously.
		
		Note: This class mainly provides shared functionality for {ROTA_PARALLEL_TASK_I} and possible
		      descendants of {ROTA_S}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROTA_TASK_COLLECTION_I [G -> attached ROTA_TASK_I]

inherit
	USABLE_I

feature {NONE} -- Access

	tasks: DS_LIST [like new_task_data]
			-- List of tuples containing running tasks
		require
			interface_usable: is_interface_usable
		deferred
		ensure
			consistent: Result = tasks
		end

feature {NONE} -- Basic operations

	append_task (a_task: G)
			-- Add given task to `tasks'.
			--
			-- `a_task': Task to be added to `tasks'.
		require
			interface_usable: is_interface_usable
			a_task_attached: a_task /= Void
		do
			tasks.force_last (new_task_data (a_task))
		ensure
			tasks_increased: tasks.count > old tasks.count + 1
			a_task_appended: tasks.last.task = a_task
		end

	proceed_all_tasks
			-- Call `step' on all tasks in `tasks'.
			--
			-- Note: do not call recursively!
		require
			interface_usable: is_interface_usable
		do
			from
				tasks.start
			until
				tasks.after
			loop
				proceed_current_task
			end
		end

	proceed_current_task
			-- Proceed with task at current cursor of `tasks'. If task does not have a next step, it is
			-- removed. Otherwise cursor of `tasks' is moved forward.
			--
			-- Note: do not call recursively!
		require
			interface_usable: is_interface_usable
			tasks_not_empty: not tasks.is_empty
		local
			l_tasks: like tasks
			l_data: like new_task_data
			l_task: G
		do
			l_tasks := tasks
			if l_tasks.off then
				l_tasks.start
			end
			l_data := l_tasks.item_for_iteration
			l_task := l_data.task
			if l_task.has_next_step then
				perform_step
				if l_task.has_next_step then
					l_tasks.forth
				else
					remove_task
				end
			else
				remove_task
			end
		ensure
			tasks_cursor_moved: tasks.index /= old tasks.index
		end

	perform_step
			-- Perform step on task at current position of `tasks'.
		require
			interface_usable: is_interface_usable
			tasks_not_off: not tasks.off
		do
			tasks.item_for_iteration.task.step
		ensure
			cursor_not_moved: tasks.index = old tasks.index
		end

	remove_task
			-- Remove task at current position of `tasks'.
			--
			-- Note: implementers can redefine in order to remove, reuse or add other tasks.
		require
			interface_usable: is_interface_usable
			tasks_not_off: not tasks.off
			task_finished: not tasks.item_for_iteration.task.has_next_step
		do
			tasks.remove_at
		end

feature {NONE} -- Factory

	new_task_data (a_task: G): TUPLE [task: G]
			-- Create new task status tuple for given task
			--
			-- `a_task': Task for which tuple should be created.
			-- `Result': new status tuple for `a_task'.
			--           task: running task
		require
			interface_usable: is_interface_usable
			a_task_attached: a_task /= Void
		do
				-- Set sleep_time to zero so `a_task' gets executed during next iteration
			Result := [a_task]
		ensure
			result_attached: Result /= Void
			result_task_attached: Result.task /= Void
		end

invariant
	tasks_attached: tasks /= Void

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
