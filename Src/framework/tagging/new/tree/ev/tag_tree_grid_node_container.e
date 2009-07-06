note
	description: "Summary description for {TAG_TREE_GRID_NODE_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TAG_TREE_GRID_NODE_CONTAINER [G -> TAG_ITEM]

inherit
	TAG_SHARED_EQUALITY_TESTER

feature -- Access

	node: TAG_TREE_NODE [G]
			-- Corresponding node
		require
			connected: is_connected
		deferred
		ensure
			active: node.is_active
		end

feature {TAG_TREE_GRID_NODE_CONTAINER} -- Access

	child_with_token (a_token: READABLE_STRING_GENERAL): like new_child
		require
			a_token_attached: a_token /= Void
			connected: is_connected
			evaluated: is_evaluated
			has_child_with_a_token: has_child_with_token (a_token)
		local
			l_table: like child_table
		do
			l_table := child_table
			check l_table /= Void end
			Result := l_table.item (a_token)
		end

feature {NONE} -- Access

	sparse_tree: TAG_TREE_GRID [G]
			-- Sparse tree
		deferred
		ensure
			result_attached: Result /= Void
		end

	grid: EV_GRID
			-- Grid
		deferred
		end

feature {NONE} -- Access

	child_table: detachable DS_HASH_TABLE [like new_child, READABLE_STRING_GENERAL]

	new_row_start_index: INTEGER
			-- Starting index of a new row
		require
			connected: is_connected
			evaluated: is_evaluated
		deferred
		ensure
			valid: is_valid_index (Result)
		end

feature -- Status report

	is_connected: BOOLEAN
		deferred
		end

	is_evaluated: BOOLEAN
		do
			Result := child_table /= Void
		ensure
			result_implies_child_table_attached: Result implies child_table /= Void
		end

feature {TAG_TREE_GRID_NODE_CONTAINER} -- Status setting

	evaluate
		require
			connected: is_connected
			not_evaluated: not is_evaluated
		local
			l_table: like child_table
		do
			create l_table.make_default
			l_table.set_key_equality_tester (equality_tester)
			child_table := l_table
			rebuild
		ensure
			evaluated: is_evaluated
		end

	rebuild
		require
			connected: is_connected
			evaluated: is_evaluated
		local
			l_table: like child_table
		do
			l_table := child_table
			check l_table /= Void end
			from until
				l_table.is_empty
			loop
				remove_child (l_table.first.node)
			end
			if not node.is_leaf then
				node.children.do_all (
					agent (a_node: TAG_TREE_NODE [G])
						do
							if
								sparse_tree.is_node_in_grid (a_node)
							then
								add_child (a_node)
							end
						end)
			end
		end

feature -- Query

	has_child_with_token (a_token: READABLE_STRING_GENERAL): BOOLEAN
		require
			a_token_attached: a_token /= Void
			connected: is_connected
			evaluated: is_evaluated
		local
			l_table: like child_table
		do
			l_table := child_table
			check l_table /= Void end
			Result := l_table.has (a_token)
		end

feature {NONE} -- Query

	is_valid_index (a_pos: INTEGER): BOOLEAN
			-- Is position a valid index for a new grid row?
			--
			-- `a_pos': Index for a new grid new.
		require
			connected: is_connected
			evaluated: is_evaluated
		deferred
		end

feature {TAG_TREE_GRID_NODE_CONTAINER} -- Element change

	add_child (a_node: TAG_TREE_NODE [G])
		require
			a_node_attached: a_node /= Void
			connected: is_connected
			evaluated: is_evaluated
			a_node_active: a_node.is_active
			a_node_not_root: not a_node.is_root
			node_is_parent: node.is_parent_of (a_node)
			not_has_child_with_token: not has_child_with_token (a_node.token)
		local
			l_pos: INTEGER
			l_table: like child_table
			l_token: READABLE_STRING_GENERAL
			l_child: like new_child
			l_new: like new_child
		do
			l_pos := new_row_start_index
			l_token := a_node.token
			l_table := child_table
			check l_table /= Void end
			from
				l_table.start
			until
				l_table.after
			loop
				l_child := l_table.item_for_iteration
				if l_pos <= l_child.row.index then
					if l_token > l_child.node.token then
						l_pos := l_child.row.index + l_child.row.subrow_count_recursive + 1
					end
				end
				l_table.forth
			end
			insert_new_row (l_pos)
			l_new := new_child (a_node, grid.row (l_pos))
			l_table.force_last (l_new, a_node.tree.formatter.immutable_string (l_token))
		ensure
			has_child_with_token: has_child_with_token (a_node.token)
		end

	remove_child (a_node: TAG_TREE_NODE [G])
		require
			a_node_attached: a_node /= Void
			connected: is_connected
			evaluated: is_evaluated
			a_node_active: a_node.is_active
			a_node_not_root: not a_node.is_root
			a_node_is_child: has_child_with_token (a_node.token) and then
				child_with_token (a_node.token).node = a_node
		local
			l_table: like child_table
			l_child: like new_child
		do
			l_table := child_table
			check l_table /= Void end
			l_child := l_table.item (a_node.token)
			grid.remove_row (l_child.row.index)
			l_table.remove (a_node.token)
		end

feature {NONE} -- Implementation

	insert_new_row (a_pos: INTEGER)
		require
			connected: is_connected
			evaluated: is_evaluated
			a_pos_valid: is_valid_index (a_pos)
		deferred
		ensure
			row_count_increased: grid.row_count = old grid.row_count + 1
			new_row_has_no_data: grid.row (a_pos).data = Void
		end

feature {NONE} -- Factory

	new_child (a_node: TAG_TREE_NODE [G]; a_row: EV_GRID_ROW): TAG_TREE_GRID_ROW_DATA [G]
		do
			create Result.make (sparse_tree, a_node, a_row)
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
