note
	description: "[
		Base implementation of a {ROTA_S} service.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROTA

inherit
	ROTA_S

	ROTA_TASK_COLLECTION_I [ROTA_TIMED_TASK_I]
		redefine
			new_task_data,
			perform_step,
			remove_task
		end

	DISPOSABLE_SAFE

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			task_cursor := (create {DS_LINKED_LIST [like new_task_data]}.make).new_cursor
			create task_run_event
			create task_finished_event
			create task_removed_event
		end

feature -- Access

	connection: EVENT_CONNECTION_I [ROTA_OBSERVER, ROTA_S]
			-- <Precursor>
		local
			l_result: like connection_cache
		do
			l_result := connection_cache
			if l_result = Void then
				l_result := create {EVENT_CONNECTION [ROTA_OBSERVER, ROTA_S]}.make (
					agent (an_observer: ROTA_OBSERVER): ARRAY [TUPLE[ EVENT_TYPE [TUPLE], PROCEDURE [ANY, TUPLE]]]
						do
							Result := <<
									[task_run_event, agent an_observer.on_task_run],
									[task_finished_event, agent an_observer.on_task_finished],
									[task_removed_event, agent an_observer.on_task_remove]
								>>
						end)
			end
			Result := l_result
		end

feature {NONE} -- Access

	task_cursor: DS_LINKED_LIST_CURSOR [like new_task_data]
			-- <Precursor>

	min_sleep_time: NATURAL
			-- Minimum sleep time of all tasks in `tasks'

	elapsed_milliseconds (a_time_a, a_time_b: TIME): NATURAL
			-- Number of milliseconds between two given times.
			--
			-- `a_time': A start time.
		require
			a_time_a_attached: a_time_a /= Void
			a_time_b_attached: a_time_b /= Void
		local
			l_fine_seconds: DOUBLE
		do
			l_fine_seconds := a_time_b.relative_duration (a_time_a).fine_seconds_count
			Result := (l_fine_seconds * 1_000).truncated_to_integer.as_natural_32
		end

feature -- Query

	has_task (a_task: ROTA_TIMED_TASK_I): BOOLEAN
			-- <Precursor>
		do
			Result := tasks.there_exists (
				agent (a_data: like new_task_data; a_t: ROTA_TIMED_TASK_I): BOOLEAN
					do
						Result := a_data.task = a_t
					end (?, a_task))
		end

feature -- Basic operations

	run_task (a_task: ROTA_TIMED_TASK_I)
			-- <Precursor>
		do
			tasks.force_last (new_task_data (a_task))
			task_run_event.publish ([Current, a_task])
		end

feature {NONE} -- Basic operations

	perform_step
			-- <Precursor>
		local
			l_data: like new_task_data
			l_task: ROTA_TIMED_TASK_I
			l_now: TIME
			l_duration: NATURAL
		do
			l_data := task_cursor.item
			create l_now.make_now
			l_duration := elapsed_milliseconds (l_data.last_step, l_now)
			if l_data.sleep_time <= l_duration then
				Precursor
				l_task := l_data.task
				if l_task.has_next_step then
					l_data.sleep_time := l_task.sleep_time
					l_data.last_step := l_now
					min_sleep_time := min_sleep_time.min (l_data.sleep_time)
				end
			else
				min_sleep_time := min_sleep_time.min (l_data.sleep_time - l_duration)
			end
		end

	remove_task (a_force: BOOLEAN)
			-- <Precursor>
		local
			l_task: ROTA_TIMED_TASK_I
		do
			l_task := task_cursor.item.task
			task_finished_event.publish ([Current, l_task])
			Precursor (a_force)
			task_removed_event.publish_if ([Current, l_task],
				agent (a_rota: ROTA_S; a_task: ROTA_TIMED_TASK_I): BOOLEAN
					do
						Result := a_task.is_interface_usable and then not a_task.has_next_step
					end)
		end

feature -- Events

	task_run_event: EVENT_TYPE [TUPLE [service: ROTA_S; task: ROTA_TIMED_TASK_I]]
			-- <Precursor>

	task_finished_event: EVENT_TYPE [TUPLE [service: ROTA_S; task: ROTA_TIMED_TASK_I]]
			-- <Precursor>

	task_removed_event: EVENT_TYPE [TUPLE [service: ROTA_S; task: ROTA_TIMED_TASK_I]]
			-- <Precursor>

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				tasks.wipe_out
			end
		end

feature {NONE} -- Factory

	new_task_data (a_task: ROTA_TIMED_TASK_I): TUPLE [task: ROTA_TIMED_TASK_I; last_step: TIME; sleep_time: NATURAL]
			-- Create new task status tuple for given task
			--
			-- `a_task': Task for which tuple should be created.
			-- `Result': new status tuple for `a_task'.
			--           task: running task
			--           last_step: time when `step' has been called last on task
			--           sleep_time: time between last and next call to `step' (in milliseconds)
		do
				-- Set sleep_time to zero so `a_task' gets executed during next iteration
			Result := [a_task, create {TIME}.make_now, {NATURAL} 0]
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
