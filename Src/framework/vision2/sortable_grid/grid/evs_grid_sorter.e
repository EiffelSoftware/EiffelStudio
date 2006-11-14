indexing
	description: "Object that represents sorter to sort a list of given grid items according to their positions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GRID_SORTER

feature -- Sort

	sort_with_position_comparator (a_list: DS_LIST [EVS_GRID_COORDINATED]; a_comparator: EVS_GRID_ITEM_POSITION_COMPARATOR) is
			-- Sort `a_list' with `a_comparator'.
		require
			a_list_attached: a_list /= Void
			a_comparator_attached: a_comparator /= Void
		local
			l_tester: AGENT_BASED_EQUALITY_TESTER [EVS_GRID_COORDINATED]
			l_sorter: DS_QUICK_SORTER [EVS_GRID_COORDINATED]
		do
			create l_tester.make (agent a_comparator.comparator)
			create l_sorter.make (l_tester)
			l_sorter.sort (a_list)
		end

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
