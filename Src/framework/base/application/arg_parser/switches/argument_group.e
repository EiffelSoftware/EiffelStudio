indexing
	description: "Represents a group of switches for group validation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_GROUP

create
	make

feature {NONE} -- Initialization

	make (a_switches: like switches; a_loose: like accepts_loose_arguments) is
			-- Initializes an argument group
		require
			a_switches_attached: a_switches /= Void
			a_switches_contained_attached_items: a_switches.for_all (agent (a_item: ARGUMENT_SWITCH): BOOLEAN
				do
					Result := a_item /= Void
				end)
			a_switches_contained_unique_items: a_switches.for_all (agent (a_arr: ARRAY [ARGUMENT_SWITCH]; a_item: ARGUMENT_SWITCH): BOOLEAN
				require
					a_item_attached: a_item /= Void
				do
					Result := a_arr.occurrences (a_item) = 1
				end (a_switches, ?))
		do
			switches := a_switches
			accepts_loose_arguments := a_loose
		ensure
			switches_set: switches = a_switches
			accepts_loose_arguments_set: accepts_loose_arguments = a_loose
		end

feature -- Access

	switches: ARRAY [ARGUMENT_SWITCH]
			-- Switches belonging to group

feature -- Status report

	accepts_loose_arguments: BOOLEAN
			-- Indicates if loose arguments can be used in the group

invariant
	switches_attached: switches /= Void
	switches_contained_attached_items: switches.for_all (agent (a_item: ARGUMENT_SWITCH): BOOLEAN
		do
			Result := a_item /= Void
		end)
	switches_contained_unique_items: switches.for_all (agent (a_arr: ARRAY [ARGUMENT_SWITCH]; a_item: ARGUMENT_SWITCH): BOOLEAN
		require
			a_item_attached: a_item /= Void
		do
			Result := a_arr.occurrences (a_item) = 1
		end  (switches, ?))

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
