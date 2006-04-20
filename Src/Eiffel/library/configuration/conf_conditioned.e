indexing
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

	is_enabled (a_state: CONF_STATE): BOOLEAN is
			-- Is `Current' enabled for `a_state'?
		require
			a_state_not_void: a_state /= Void
		do
			Result := internal_conditions = Void
			if not Result then
				from
					internal_conditions.start
				until
					Result or internal_conditions.after
				loop
					Result := internal_conditions.item.satisfied (a_state)
					internal_conditions.forth
				end
			end
		end

feature {CONF_ACCESS} -- Status update

	add_condition (a_condition: CONF_CONDITION) is
			-- Add `a_condition'.
		require
			a_condition_not_void: a_condition /= Void
		do
			if internal_conditions = Void then
				create internal_conditions.make (1)
			end
			internal_conditions.force (a_condition)
		ensure
			condition_added: internal_conditions /= Void and then internal_conditions.has (a_condition)
		end


feature {CONF_VISITOR} -- Implementation, attributes stored in configuration file

	internal_conditions: ARRAYED_LIST [CONF_CONDITION];
			-- The list of conditions.

invariant
	internal_conditions_not_empty: internal_conditions = Void or else not internal_conditions.is_empty

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
