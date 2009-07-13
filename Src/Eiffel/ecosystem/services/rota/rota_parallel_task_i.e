note
	description: "[
		{ROTA_TASK_I} consisting of one or more asynchronously executed sub tasks.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROTA_PARALLEL_TASK_I

inherit
	ROTA_TASK_I

	ROTA_TASK_COLLECTION_I [ROTA_TASK_I]

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>
		do
			Result := not tasks.is_empty
		ensure then
			result_implies_tasks_not_empty: Result implies not tasks.is_empty
		end

feature {NONE} -- Status report

	one_per_step: BOOLEAN
			-- Should only a single task be proceeded per call to `step'?
		require
			usable: is_interface_usable
		deferred
		end

feature {ROTA_S, ROTA_TASK_I} -- Status setting

	step
			-- <Precursor>
		do
			if one_per_step then
				proceed_current_task
			else
				proceed_all_tasks
			end
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
