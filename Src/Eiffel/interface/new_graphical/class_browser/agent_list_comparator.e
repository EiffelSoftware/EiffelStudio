indexing
	description: "Object that uses a list of agents to compare two items"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AGENT_LIST_COMPARATOR [G]

inherit
	KL_PART_COMPARATOR [G]

create
	make

feature {NONE} -- Initialization

	make (a_action_list: like action_list) is
			-- Use `a_action_list' to compare two elements of type G.
			-- The agent at lower index has higher priority.
		require
			a_action_list_not_void: a_action_list /= Void
			not_a_action_list_is_empty: not a_action_list.is_empty
		do
			action_list := a_action_list
		ensure
			action_list_set: action_list = a_action_list
		end

feature -- Access

	action_list: LIST [FUNCTION [ANY, TUPLE [G, G], BOOLEAN]]
			-- Action performed to compare two non-void items.

feature -- Status report

	less_than (u, v: G): BOOLEAN is
			-- Is `u' considered less than `v'?
		local
			l_cursor: CURSOR
			l_tuple: TUPLE [G, G]
			l_tuple2: TUPLE [G, G]
			done: BOOLEAN
			l_item: FUNCTION [ANY, TUPLE [G, G], BOOLEAN]
		do
			create l_tuple
			l_tuple.put (u, 1)
			l_tuple.put (v, 2)
			if action_list.count = 1 then
				Result := action_list.first.item (l_tuple)
			else
				create l_tuple2
				l_tuple2.put (v, 1)
				l_tuple2.put (u, 2)
				l_cursor := action_list.cursor
				from
					Result := False
					action_list.start
				until
					action_list.after or Result or done
				loop
					check action_list.item /= Void end
					l_item := action_list.item
					Result := l_item.item (l_tuple)
					if not Result then
						done := l_item.item (l_tuple2)
					end
					action_list.forth
				end
				action_list.go_to (l_cursor)
			end
		end

invariant
	action_list_not_void: action_list /= Void
	not_action_list_is_empty: not action_list.is_empty

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
