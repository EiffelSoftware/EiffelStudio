indexing
	description: "Object that represents a tree node list used in EQL resultset"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_TREE_NODE_LIST [G -> EQL_ITERABLE_ITEM]

inherit
	LINKED_LIST [EQL_TREE_NODE [G]]
		redefine
			append,
			extend,
			fill,
			force,
			merge_left,
			merge_right,
			put,
			put_front,
			put_i_th,
			put_left,
			put_right,
			replace,
			prune,
			prune_all,
			remove,
			remove_left,
			remove_right,
			wipe_out
		end

feature -- Element Change

	append (s: SEQUENCE [EQL_TREE_NODE [G]]) is
		do
			increase_modification_count
			Precursor (s)
		end

	extend (v: like item) is
		do
			increase_modification_count
			Precursor (v)
		end

	fill (other: CONTAINER [EQL_TREE_NODE [G]]) is
		do
			increase_modification_count
			Precursor (other)
		end

	force (v: like item) is
		do
			increase_modification_count
			Precursor (v)
		end

	merge_left (other: like Current) is
		do
			increase_modification_count
			Precursor (other)
		end

	merge_right (other: like Current) is
		do
			increase_modification_count
			Precursor (other)
		end

	put (v: like item) is
		do
			increase_modification_count
			Precursor (v)
		end

	put_front (v: like item) is
		do
			increase_modification_count
			Precursor (v)
		end

	put_i_th (v: like item; i: INTEGER) is
		do
			increase_modification_count
			Precursor (v, i)

		end

	put_left (v: like item) is
		do
			increase_modification_count
			Precursor (v)
		end

	put_right (v: like item) is
		do
			increase_modification_count
			Precursor (v)
		end

	replace (v: like item) is
		do
			increase_modification_count
			Precursor (v)
		end

feature -- Removal

	prune (v: like item) is
		do
			increase_modification_count
			Precursor (v)
		end

	prune_all (v: like item) is
		do
			increase_modification_count
			Precursor (v)
		end

	remove is
		do
			increase_modification_count
			Precursor
		end

	remove_left is
		do
			increase_modification_count
			Precursor
		end

	remove_right is
		do
			increase_modification_count
			Precursor
		end

	wipe_out is
		do
			increase_modification_count
			Precursor
		end

feature -- Sort

	sort (action: FUNCTION [ANY, TUPLE [EQL_TREE_NODE [G], EQL_TREE_NODE [G]], BOOLEAN]) is
			-- Sort Current using `comparator'.
		require
			action_not_void: action /= Void
		local
			l_sorter: DS_QUICK_SORTER [EQL_TREE_NODE [G]]
			l_comparator: AGENT_BASED_EQUALITY_TESTER [EQL_TREE_NODE [G]]
		do
			create l_comparator.make (action)
			create l_sorter.make (l_comparator)
			internal_sort (l_sorter)
		end

feature{EQL_TREE_NODE_LIST} -- Implementation

	internal_sort (sorter: DS_SORTER [EQL_TREE_NODE [G]]) is
			-- Sort Current using `sorter'.
		require
			sorter_not_void: sorter /= Void
		local
			l_list: DS_ARRAYED_LIST [EQL_TREE_NODE [G]]
		do
			if not is_empty then
					-- Sort Current.
				create l_list.make (count)
				do_all (agent l_list.force_last)
				l_list.sort (sorter)
				wipe_out
				from
					l_list.start
				until
					l_list.after
				loop
					extend (l_list.item_for_iteration)
					l_list.forth
				end
					-- Recursively sort children of current.
				do_all (agent {EQL_TREE_NODE[G]}.internal_sort (sorter))
			end
		end

feature{EQL_TREE_NODE_LIST}

	increase_modification_count is
			-- Increase modification count by 1.
			-- If modification count reaches its max value, reset it to 0.
			-- Modification count is used by fail fast iterator.
			--|`modification_count' is used to support fail fast iterator.
		deferred
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
