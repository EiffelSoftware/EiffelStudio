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

	make (a_action_list: like action_list; a_sorting_order_list: like sorting_order_list; a_column_index_list: like column_index_list) is
			-- Use `a_action_list' to compare two elements of type G.
			-- The agent at lower index has higher priority.
			-- `a_sorting_order_list' stores sorting orders for every agent in `a_action_list'.
			-- `a_column_index_list' stores indexes of columns to be sorted.
		require
			a_action_list_not_void: a_action_list /= Void
			not_a_action_list_is_empty: not a_action_list.is_empty
			a_sorting_order_list_attached: a_sorting_order_list /= Void
			not_a_sorting_order_list_is_empty: not a_sorting_order_list.is_empty
			columns_match: a_sorting_order_list.count = a_action_list.count
			a_column_index_list_attached: a_column_index_list /= Void
			not_a_column_index_list_is_empty: not a_column_index_list.is_empty
			a_column_index_list_valid: a_sorting_order_list.count = a_column_index_list.count
		do
			action_list := a_action_list
			sorting_order_list := a_sorting_order_list
			column_index_list := a_column_index_list
		ensure
			action_list_set: action_list = a_action_list
			sorting_order_list_set: sorting_order_list = a_sorting_order_list
			column_index_list_set: column_index_list = a_column_index_list
		end

feature -- Access

	action_list: LIST [FUNCTION [ANY, TUPLE [G, G, INTEGER], BOOLEAN]]
			-- Action performed to compare two non-void items.

	sorting_order_list: LIST [INTEGER]
			-- List of sorting order

	column_index_list: LIST [INTEGER]

	new_agent_list_comparator (a_index_array: ARRAY [INTEGER]): like Current is
			-- New agent list comparator which contains columns whose indexes are specified in `a_index_array'
		require
			a_index_array_attached: a_index_array /= Void
			not_a_index_array_is_empty: not a_index_array.is_empty
		local
			l_action_list: like action_list
			l_order_list: like sorting_order_list
			l_index_list: like column_index_list
			i: INTEGER
			l_count: INTEGER
			l_item: INTEGER
			l_action_tbl: HASH_TABLE [FUNCTION [ANY, TUPLE [G, G, INTEGER], BOOLEAN], INTEGER]
			l_order_tbl: HASH_TABLE [INTEGER, INTEGER]
		do
			l_index_list := column_index_list
			l_count := l_index_list.count
			create l_action_tbl.make (l_count)
			create l_order_tbl.make (l_count)
			from
				l_index_list.start
				action_list.start
				sorting_order_list.start
			until
				l_index_list.after
			loop
				l_action_tbl.force (action_list.item, l_index_list.item)
				l_order_tbl.force (sorting_order_list.item, l_index_list.item)
				l_index_list.forth
				action_list.forth
				sorting_order_list.forth
			end

			create {ARRAYED_LIST [FUNCTION [ANY, TUPLE [G, G, INTEGER], BOOLEAN]]} l_action_list.make (l_count)
			create {ARRAYED_LIST [INTEGER]} l_order_list.make (l_count)
			from
				i := 1
				l_count := a_index_array.count
			until
				i > l_count
			loop
				l_item := a_index_array.item (i)
				if l_action_tbl.has (l_item) then
					l_action_list.extend (l_action_tbl.item (l_item))
					l_order_list.extend (l_order_tbl.item (l_item))
				end
				i := i + 1
			end
			create Result.make (l_action_list, l_order_list, create {ARRAYED_LIST [INTEGER]}.make_from_array (a_index_array))
		end

feature -- Status report

	less_than (u, v: G): BOOLEAN is
			-- Is `u' considered less than `v'?
		local
			l_tuple1, l_tuple2: TUPLE [a: G; b: G; sorting_order: INTEGER]
			l_action_list: like action_list
			l_sorting_order_list: like sorting_order_list
			l_item: FUNCTION [ANY, TUPLE [G, G, INTEGER], BOOLEAN]
			l_column_order: INTEGER
			done: BOOLEAN
		do
			l_action_list := action_list
			l_sorting_order_list := sorting_order_list

			l_tuple1 := [u, v, 0]
			if action_list.count = 1 then
				l_tuple1.sorting_order := l_sorting_order_list.first
				Result := l_action_list.first.item (l_tuple1)
			else
				l_tuple2 := [v, u, 0]
				from
					Result := False
					l_action_list.start
					l_sorting_order_list.start
				until
					l_action_list.after or Result or done
				loop
					check l_action_list.item /= Void end
					l_item := l_action_list.item
					l_column_order := l_sorting_order_list.item
					l_tuple1.sorting_order := l_column_order
					Result := l_item.item (l_tuple1)
					if not Result then
						l_tuple2.sorting_order := l_column_order
						done := l_item.item (l_tuple2)
					end
					l_action_list.forth
					l_sorting_order_list.forth
				end
			end
		end

invariant
	action_list_attached: action_list /= Void
	not_action_list_is_empty: not action_list.is_empty
	sorting_order_list_attached: sorting_order_list /= Void
	not_sorting_order_list_is_empty: not sorting_order_list.is_empty
	column_index_list_attached: column_index_list /= Void
	not_column_index_list_is_empty: not column_index_list.is_empty
	columns_match: sorting_order_list.count = action_list.count and then sorting_order_list.count = column_index_list

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
