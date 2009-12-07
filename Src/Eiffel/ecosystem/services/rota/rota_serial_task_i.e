note
	description: "[
		{ROTA_TASK_I} which consists of one or more serially executed sub tasks.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROTA_SERIAL_TASK_I

inherit
	ROTA_TASK_I

feature {NONE} -- Access

	sub_task: detachable ROTA_TASK_I
			-- Task being stepped through whenever `Current' proceeds
		require
			interface_usable: is_interface_usable
		deferred
		ensure
			consistent: Result = sub_task
			consistent_status: attached Result implies
				(attached old sub_task as l_old and then Result.has_next_step = l_old.has_next_step)
		end

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>
		do
			if attached sub_task as l_task then
				Result := l_task.has_next_step
			end
		ensure then
			result_implies_sub_task_has_step: Result implies
				(attached sub_task as l_task and then l_task.has_next_step)
		end

feature {ROTA_S, ROTA_TASK_I} -- Status setting

	step
			-- <Precursor>
		local
			l_sub_task: like sub_task
		do
			l_sub_task := sub_task
			check l_sub_task_attached: l_sub_task /= Void end
			l_sub_task.step
			if not l_sub_task.has_next_step then
				remove_task (l_sub_task, False)
			end
		end

	cancel
			-- <Precursor>
		local
			l_sub_task: like sub_task
		do
			l_sub_task := sub_task
			check l_sub_task_attached: l_sub_task /= Void end
			l_sub_task.cancel
			remove_task (l_sub_task, True)
		end

feature {NONE} -- Events

	remove_task (a_task: attached like sub_task; a_cancel: BOOLEAN)
			-- Called when current `sub_task' does not have a next step.
			--
			-- Note: it is up to the implementation whether `sub_task' is removed, reused or replaced by
			--       another task.
			--
			-- `a_task': Finished task.
			-- `a_cancel': True if `cancel' was called.
		require
			a_task_attached: a_task /= Void
			a_task_is_sub_task: a_task = sub_task
			a_task_done: not a_task.has_next_step
		do
		ensure
			cancel_implies_not_has_next_step: a_cancel implies not has_next_step
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
