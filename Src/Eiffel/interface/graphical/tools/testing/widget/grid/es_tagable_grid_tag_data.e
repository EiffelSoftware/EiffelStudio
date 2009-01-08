note
	description: "[
		Objects that represent a tree node of {TAG_BASED_TREE} associated with a grid row for
		{ES_TAGABLE_TREE_GRID}.
		
		Object redefines insertion and removal of child nodes and items from {TAG_BASED_TREE_NODE}. That
		way the grid is kept synchronized with the underlaying tree.
		
		See {TAG_BASED_TREE_NODE} and {ES_TAGABLE_TREE_GRID_NODE_CONTAINER} for more information.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TAGABLE_GRID_TAG_DATA [G -> TAGABLE_I]

inherit
	TAG_BASED_TREE_NODE [G]
		rename
			make as make_node
		undefine
			child_for_token,
			insert_tag_for_item,
			add_child,
			add_item,
			remove_child,
			remove_item,
			propagate_item_change
		redefine
			parent,
			tree
		end

	ES_TAGABLE_TREE_GRID_NODE_CONTAINER [G]
		undefine
			token,
			row
		redefine
			parent,
			propagate_item_change
		end

	ES_TAGABLE_GRID_DATA [G]

create
	make

feature {NONE} -- Initialize

	make (a_row: like row; a_parent: like parent; a_token: like token)
			-- Initialize `Current'
			--
			--| Note: `make_container' is called implicitly through `make_node'
			--
			-- `a_row': Row representing node.
			-- `a_parent': Parent node for `Current'.
			-- `a_token': Token represented by node.
		require
			a_token_valid: is_valid_token (a_token)
		do
			make_node (a_parent, a_token)
			row := a_row
			row.set_data (Current)
		ensure
			parent_set: parent = a_parent
			token_set: token.is_equal (a_token)
			not_cached: not is_evaluated
			descending_tags_empty: descending_tags.is_empty
			item_count_zero: item_count = 0
		end

feature -- Access

	parent: !ES_TAGABLE_TREE_GRID_NODE_CONTAINER [G]
			-- <Precursor>

feature {TAG_BASED_TREE_NODE_CONTAINER} -- Access

	tree: !ES_TAGABLE_TREE_GRID [G]
			-- <Precursor>

feature {NONE} -- Access

	first_child_index: INTEGER
			-- <Precursor>
		do
			Result := row.index + 1
		end

	last_item_index: INTEGER
			-- <Precursor>
		do
			Result := row.index + row.subrow_count_recursive + 1
		end

feature -- Basic functionality

	populate_row (a_layout: ES_TAGABLE_GRID_LAYOUT [G])
			-- <Precursor>
		do
			a_layout.populate_node_row (row, Current)
		end

feature {TAG_BASED_TREE_NODE_CONTAINER} -- Element change

	propagate_item_change (a_tag: !STRING_8; a_item: !G)
			-- <Precursor>
		local
			i: INTEGER
			l_item: EV_GRID_ITEM
		do
			l_item := tree.computed_grid_item (1, row.index)
			if is_evaluated then
				if a_tag.is_empty then
					i := row_data_for_item (a_item).row.index
					l_item := tree.computed_grid_item (1, i)
				end
			end
			Precursor {ES_TAGABLE_TREE_GRID_NODE_CONTAINER} (a_tag, a_item)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
