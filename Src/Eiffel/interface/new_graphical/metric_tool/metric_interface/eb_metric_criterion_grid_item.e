note
	description: "Grid item for metric critrion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_CRITERION_GRID_ITEM [G -> EB_METRIC_CRITERION]

feature -- Access

	grid_item: EV_GRID_ITEM
			-- Grid item for Current property
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	load_criterion (a_criterion: G)
			-- Load `a_criterion' into Current.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	store_criterion (a_criterion: G)
			-- Store Current in `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions called if the value has been changed. A value of `Void' means the value has been unset.
		deferred
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
