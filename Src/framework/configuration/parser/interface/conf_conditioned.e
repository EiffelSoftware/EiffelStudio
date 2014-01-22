note
	description: "Objects that are only for a certain platform/build combination."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_CONDITIONED

inherit
	CONF_VALIDITY

feature -- Status report

	is_enabled (a_state: CONF_STATE): BOOLEAN
			-- Is `Current' enabled for `a_state'?
		require
			a_state_not_void: a_state /= Void
		do
			if attached internal_conditions as l_internal_conditions then
				from
					l_internal_conditions.start
				until
					Result or l_internal_conditions.after
				loop
					Result := l_internal_conditions.item.satisfied (a_state)
					l_internal_conditions.forth
				end
			else
				Result := True
			end
		end

feature {CONF_ACCESS} -- Status update

	add_condition (a_condition: CONF_CONDITION)
			-- Add `a_condition'.
		require
			a_condition_not_void: a_condition /= Void
		local
			l_internal_conditions: like internal_conditions
		do
			l_internal_conditions := internal_conditions
			if l_internal_conditions = Void then
				create l_internal_conditions.make (1)
				internal_conditions := l_internal_conditions
			end
			l_internal_conditions.force (a_condition)
		ensure
			condition_added: attached internal_conditions as l_conditions and then l_conditions.has (a_condition)
		end

	set_conditions (a_conditions: like internal_conditions)
			-- Set `internal_conditions' to `a_conditions'.
		require
			object_comparison: a_conditions /= Void implies a_conditions.object_comparison
		do
			if a_conditions /= Void and then a_conditions.is_empty then
				internal_conditions := Void
			else
				internal_conditions := a_conditions
			end
		ensure
			internal_conditions_set: a_conditions = Void or else not a_conditions.is_empty implies internal_conditions = a_conditions
		end

feature {CONF_VISITOR, CONF_ACCESS} -- Implementation, attributes stored in configuration file

	internal_conditions: detachable CONF_CONDITION_LIST;
			-- The list of conditions.

invariant
	internal_conditions_not_empty: not attached internal_conditions as inv_internal_conditions or else not inv_internal_conditions.is_empty

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
