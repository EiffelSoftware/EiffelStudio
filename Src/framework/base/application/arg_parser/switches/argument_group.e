indexing
	description: "Represents a group of switches for group validation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_GROUP

create
	make,
	make_hidden

feature {NONE} -- Initialization

	make (a_switches: !ARRAY [?ARGUMENT_SWITCH]; a_allow_non_switched: like is_allowing_non_switched_arguments)
			-- Initializes an argument group with a collection of switches.
			--
			-- `a_switches': The switches allowed in the group.
			-- `a_allow_non_switched': True to allow non switched arguments; False to allow only switch qualified arguments.
		require
			a_switches_contained_attached_items: not a_switches.has (Void)
			a_switches_contained_unique_items: a_switches.for_all (
				agent (ia_arr: !ARRAY [?ARGUMENT_SWITCH]; ia_item: ?ARGUMENT_SWITCH): BOOLEAN
					do
						Result := ia_arr.occurrences (ia_item) = 1
					end  (a_switches, ?))
		do
			switches ?= a_switches
			is_allowing_non_switched_arguments := a_allow_non_switched
			is_hidden := False
		ensure
			switches_set: switches = a_switches
			a_allow_non_switched_set: a_allow_non_switched = a_allow_non_switched
			not_is_hidden: not is_hidden
		end

	make_hidden (a_switches: !ARRAY [?ARGUMENT_SWITCH]; a_allow_non_switched: like is_allowing_non_switched_arguments)
			-- Initializes an argument group, not to be shown in the usage, with a collection of switches.
			--
			-- `a_switches': The switches allowed in the group.
			-- `a_allow_non_switched': True to allow non switched arguments; False to allow only switch qualified arguments.
		require
			a_switches_contained_attached_items: not a_switches.has (Void)
			a_switches_contained_unique_items: a_switches.for_all (
				agent (ia_arr: !ARRAY [?ARGUMENT_SWITCH]; ia_item: ?ARGUMENT_SWITCH): BOOLEAN
					do
						Result := ia_arr.occurrences (ia_item) = 1
					end  (a_switches, ?))
		do
			make (a_switches, a_allow_non_switched)
			is_hidden := True
		ensure
			switches_set: switches = a_switches
			a_allow_non_switched_set: a_allow_non_switched = a_allow_non_switched
			is_hidden: is_hidden
		end

feature -- Access

	switches: !ARRAY [!ARGUMENT_SWITCH]
			-- Switches applicable to the group.

feature -- Status report

	is_hidden: BOOLEAN
			-- Indicates if a usage group command should be generated.

	is_allowing_non_switched_arguments: BOOLEAN
			-- Indicates if non-switched arguments can be used in the group.

invariant
	switches_contained_unique_items: switches.for_all (
		agent (ia_arr: !ARRAY [!ARGUMENT_SWITCH]; ia_item: !ARGUMENT_SWITCH): BOOLEAN
			do
				Result := ia_arr.occurrences (ia_item) = 1
			end  (switches, ?))

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {ARGUMENT_GROUP}
