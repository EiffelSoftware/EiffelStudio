note
	description: "[
		Objects that support insertion and removal of grid rows in a {ES_TAGABLE_TREE_GRID}, based on the changes
		of an underlaying {TAG_BASED_TREE}.
		
		Insertion and removal of child nodes and items in {TAG_BASED_TREE_NODE_CONTAINER} are redefined to
		keep grid synchronized.
		
		See {ES_TAGABLE_TREE_GRID} and {TAG_BASED_TREE} for more information.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TAGABLE_TREE_GRID_NODE_CONTAINER [G -> TAGABLE_I]

inherit
	TAG_BASED_TREE_NODE_CONTAINER [G]
		rename
			make as make_container
		redefine
			parent,
			child_for_token,
			tree,
			insert_tag_for_item,
			add_child,
			add_item,
			remove_child,
			remove_item
		end

feature -- Access

	parent: !ES_TAGABLE_TREE_GRID_NODE_CONTAINER [G]
			-- <Precursor>
		do
		end

	row: !EV_GRID_ROW
			-- <Precursor>
		require
			not_root: not is_root
		do
		end

feature {TAG_BASED_TREE_NODE_CONTAINER} -- Access

	tree: !ES_TAGABLE_TREE_GRID [G]
			-- <Precursor>
		deferred
		end

feature {NONE} -- Access

	first_item_subrow: ?EV_GRID_ROW
			-- First subrow that contains an item, Void if `Current' does not contain any items

	first_child_index: INTEGER
			-- First valid index for child item row
		deferred
		end

	last_child_index: INTEGER
			-- Last valid index for child row
		do
			Result := first_item_index
		end

	first_item_index: INTEGER
			-- First valid index for item rows
		do
			if first_item_subrow /= Void then
				Result := first_item_subrow.index
			else
				Result := last_item_index
			end
		end

	last_item_index: INTEGER
			-- Last valid index for item row
		deferred
		end

feature -- Query

	child_for_token (a_token: !STRING): !ES_TAGABLE_GRID_TAG_DATA [G]
			-- <Precursor>
		do
			Result := cached_children.item (a_token)
		end

feature {NONE} -- Query

	row_data_for_item (a_item: !G): !ES_TAGABLE_GRID_ITEM_DATA [G]
			-- {ES_TAGABLE_GRID_ITEM_DATA} instance for item
		require
			usable: is_interface_usable
			evaluated: is_evaluated
			a_item_added: items.has (a_item)
		local
			l_data: ?like row_data_for_item
			i: INTEGER
		do
			from
				i := first_item_index
			until
				l_data /= Void
			loop
				if {l_row_data: like row_data_for_item} tree.grid.row (i).data then
					l_data := l_row_data
				end
				check l_data /= Void end
				if l_data.item /= a_item then
					l_data := Void
					i := i + tree.grid.row (i).subrow_count_recursive + 1
				else
					Result := l_data
				end
			end
		ensure
			correct_result: Result.item = a_item
		end

feature {NONE} -- Element change

	insert_tag_for_item (a_tag: !STRING; a_item: !G)
			-- <Precursor>
		local
			l_expand: BOOLEAN
		do
			if not is_root and not is_evaluated then
				if descending_tags.is_empty and item_count = 0 then
					tree.expansion_cache.start
					tree.expansion_cache.search_forth (tag)
					l_expand := not tree.expansion_cache.off
					if l_expand then
							-- We remove the row here since it will be added when the row expands again
						tree.expansion_cache.remove_at
						compute_descendants
					end
				end
			end
			Precursor (a_tag, a_item)
			if l_expand then
				if row.is_expandable then
					row.expand
				end
			end
		end

	add_child (a_token: !STRING)
			-- <Precursor>
		local
			i: INTEGER
			l_new: ES_TAGABLE_GRID_TAG_DATA [G]
			l_row: EV_GRID_ROW
		do
			from
				i := first_child_index
			until
				i = last_child_index or else ({l_item: ES_TAGABLE_GRID_TAG_DATA [G]} tree.grid.row (i).data and then
					l_item.token > a_token)
			loop
				i := i + tree.grid.row (i).subrow_count_recursive + 1
			end
			if is_root then
				tree.grid.insert_new_row (i)
			else
				tree.grid.insert_new_row_parented (i, row)
			end
			l_row := tree.grid.row (i)
			check l_row /= Void end
			l_row.ensure_expandable
			create l_new.make (l_row, Current, a_token)
			cached_children.force (l_new, a_token)
		end

	add_item (a_item: !G)
			-- <Precursor>
		local
			i: INTEGER
			l_row: EV_GRID_ROW
			l_new: ES_TAGABLE_GRID_ITEM_DATA [G]
		do
			from
				i := first_item_index
			until
				i = last_item_index or else ({l_data: ES_TAGABLE_GRID_ITEM_DATA [G]} tree.grid.row (i).data and then
					l_data.item.name > a_item.name)
			loop
				i := i + tree.grid.row (i).subrow_count_recursive + 1
			end
			if is_root then
				tree.grid.insert_new_row (i)
			else
				tree.grid.insert_new_row_parented (i, row)
			end
			l_row := tree.grid.row (i)
			check l_row /= Void end
			if first_item_subrow = Void or else first_item_subrow.index > l_row.index then
				first_item_subrow := l_row
			end
			create l_new.make (l_row, a_item)
			Precursor (a_item)
		end

	remove_child (a_token: !STRING)
			-- <Precursor>
		local
			l_node: like child_for_token
		do
			l_node := child_for_token (a_token)
			tree.grid.remove_row (l_node.row.index)
			Precursor (a_token)
		end

	remove_item (a_item: !G)
			-- <Precursor>
		local
			i: INTEGER
			l_data: like row_data_for_item
		do
			l_data := row_data_for_item (a_item)
			Precursor (a_item)
			i := l_data.row.index
			if cached_items.is_empty then
				first_item_subrow := Void
			elseif tree.grid.row (i) = first_item_subrow then
				first_item_subrow := tree.grid.row (i + 1)
			end
			tree.grid.remove_row (i)
		end

feature {ES_TAGABLE_TREE_GRID_NODE_CONTAINER} -- Basic functionality

	show_nodes_for_item (a_item: !G; a_tag: !STRING)
			-- Expand rows for children showing item in given tag and select row that contains item.
		require
			a_tag_valid: is_valid_tag (a_tag)
			a_item_has_tag: a_item.tags.has (join_tags (tag, a_tag))
			evaluated: is_evaluated
		local
			l_token: !STRING
			l_child: ES_TAGABLE_TREE_GRID_NODE_CONTAINER [G]
		do
			if a_tag.is_empty then
				show_subrow_with_item (a_item)
			else
				l_token := first_token (a_tag)
				l_child := child_for_token (l_token)
				if not l_child.row.is_expanded then
					l_child.row.expand
				end
				l_child.show_nodes_for_item (a_item, suffix (l_token, a_tag))
			end
		end

	show_subrow_with_item (a_item: !G)
			-- Select row containing `a_item'.
		require
			evaluated: is_evaluated
			a_item_added: items.has (a_item)
		local
			l_data: like row_data_for_item
		do
			l_data := row_data_for_item (a_item)
			tree.grid.set_first_visible_row (l_data.row.index)
		end

invariant
	items_not_empty_implies_subrow: (is_interface_usable and then is_evaluated and then not items.is_empty)
		implies first_item_subrow /= Void

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
