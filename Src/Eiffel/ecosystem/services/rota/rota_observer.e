note
	description: "[
		Observer for events in {ROTA_S}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROTA_OBSERVER

inherit
	EVENT_OBSERVER_I

feature -- Events

	on_task_run (a_rota: ROTA_S; a_task: ROTA_TIMED_TASK_I)
			-- Events called when task is run through a {ROTA_S}.
			--
			-- Note: it can not be guaranteed that `has_next_step' is still true for `a_task'.
			--
			-- `a_rota': Service running `a_task'.
			-- `a_task': Task which is run by `a_rota'.
		require
			a_rota_attached: a_rota /= Void
			a_task_attached: a_task /= Void
			a_rota_usable: a_rota.is_interface_usable
			a_task_usable: a_task.is_interface_usable
			a_rota_has_task: a_rota.has_task (a_task)
		do

		ensure
			a_rota_usable: a_rota.is_interface_usable
			a_task_usable: a_task.is_interface_usable
		end

	on_task_finished (a_rota: ROTA_S; a_task: ROTA_TIMED_TASK_I)
			-- Events called when a task is done.
			--
			-- Note: this routine must not restart `a_task' or make it unusable!
			--
			-- `a_rota': Service which finished `a_task'.
			-- `a_task': Finished task.
		require
			a_rota_attached: a_rota /= Void
			a_task_attached: a_task /= Void
			a_rota_usable: a_rota.is_interface_usable
			a_task_usable: a_task.is_interface_usable
			a_task_finished: not a_task.has_next_step
			a_rota_has_task: a_rota.has_task (a_task)
		do
		ensure
			a_rota_usable: a_rota.is_interface_usable
			a_task_usable: a_task.is_interface_usable
		end

	on_task_remove (a_rota: ROTA_S; a_task: ROTA_TIMED_TASK_I)
			-- Events called when a task is removed from service.
			--
			-- Note: here a task may be launched again or disposed.
			--
			-- `a_rota': Service which removed `a_task'.
			-- `a_task': Finished task.
		require
			a_rota_attached: a_rota /= Void
			a_task_attached: a_task /= Void
			a_rota_usable: a_rota.is_interface_usable
			a_task_usable: a_task.is_interface_usable
			a_task_finished: not a_task.has_next_step
			a_rota_not_has_task: not a_rota.has_task (a_task)
		do

		ensure
			a_rota_usable: a_rota.is_interface_usable
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
