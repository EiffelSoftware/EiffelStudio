indexing
	description: "[
		Objects that represent a grid visualizing a {TAG_BASED_TREE} for items of type {TAGABLE_I}.
		
		The grid will add and remove rows according to the underlaying tree. In addition the grid
		contains separate rows at the end for all untagged items. The actual grid items are defined by an
		implementation of {ES_TBT_GRID_LAYOUT}. For more information, see {TAG_BASED_TREE}.
		
		Note: do not add or remove rows or columns directly, since they are tied to the tree structure.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TAGABLE_TREE_GRID [G -> TAGABLE_I]

inherit
	ES_TAGABLE_GRID [G]
		export
			{ES_TAGABLE_TREE_GRID_NODE_CONTAINER} grid
		redefine
			on_before_initialize,
			on_after_initialized
		end

	TAG_BASED_TREE [G]
		rename
			make as make_tree,
			parent as unused_parent
		undefine
			unused_parent,
			child_for_token,
			insert_tag_for_item,
			add_child,
			add_item,
			remove_child,
			remove_item
		redefine
			tree,
			wipe_out,
			fill,
			add_untagged_item,
			remove_untagged_item
		end

	ES_TAGABLE_TREE_GRID_NODE_CONTAINER [G]
		rename
			tag as tag_prefix,
			row as unused_row,
			parent as unused_parent
		end

create
	make

feature {NONE} --Initialization

	on_before_initialize is
			-- <Precursor>
		do
			Precursor

				-- Attach since at root level we always want to insert children and items directly
			create cached_children.make_default
			create cached_items.make_default

				-- Create expansion cache
			create expansion_cache.make
			expansion_cache.set_equality_tester ({KL_EQUALITY_TESTER [!STRING]} #? create {KL_STRING_EQUALITY_TESTER})

				-- Initialize tree
			make_tree
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor

				-- Initialize grid
			register_action (grid.row_expand_actions, agent on_row_expansion)
			register_action (grid.row_collapse_actions, agent on_row_collapse)
		end

feature -- Access

	tree: !ES_TAGABLE_TREE_GRID [G]
			-- <Precursor>
		do
			Result := Current
		end

feature {ES_TAGABLE_TREE_GRID_NODE_CONTAINER} -- Access

	expansion_cache: !DS_LINKED_LIST [!STRING]
			-- Tags of nodes which are currently expanded in `grid'
			--
			-- Note: this list holds not more than `max_expansion_cache_count', where the first one the list
			--       will be removed whenever the user expands a new node.

feature {NONE} -- Access

	untagged_subrow: ?EV_GRID_ROW
			-- Anchor for row where list of untagged items start

	first_child_index: INTEGER
			-- <Precursor>
		do
			Result := 1
		end

	last_item_index: INTEGER
			-- <Precursor>
		do
			if untagged_subrow /= Void then
				Result := untagged_subrow.index
			else
				if untagged_subrow /= Void then
					Result := untagged_subrow.index
				else
					Result := last_untagged_index
				end
			end
		end

	first_untagged_index: INTEGER
			-- First valid index for untagged item
		do
			if untagged_subrow /= Void then
				Result := untagged_subrow.index + 1
			else
				Result := last_untagged_index
			end
		end

	last_untagged_index: INTEGER
			-- Last valid index for untagged item
		do
			Result := grid.row_count + 1
		end

feature {NONE} -- Status report

	is_untagged_subrow_expanded: BOOLEAN
			-- Is `untagged_subrow' currently expanded?
			--
			-- Note: this can be true even if not untagged items are displayed. This means the last time
			--       items were displayed, the user had expanded the row.

feature {NONE} -- Element change

	fill is
			-- <Precursor>
		do
			initialize_layout
			Precursor
		end

	wipe_out
			-- <Precursor>
		do
			grid.wipe_out
			cached_children.wipe_out
			cached_items.wipe_out
			internal_untagged_items.wipe_out
			untagged_subrow := Void
			first_item_subrow := Void
			initialize_layout
		end

	add_untagged_item (a_item: !G) is
			-- <Precursor>
		local
			i: INTEGER
			l_row: !EV_GRID_ROW
			l_ut_row: EV_GRID_ROW
			l_new: ES_TAGABLE_GRID_ITEM_DATA [G]
			l_new_ut: ES_TAGABLE_GRID_TEXT_DATA [G]
		do
			if untagged_subrow /= Void then
				from
					i := first_untagged_index
				until
					i = last_untagged_index or else ({l_data: ES_TAGABLE_GRID_ITEM_DATA [G]} grid.row (i).data and then
					l_data.item.name > a_item.name)
				loop
					i := i + grid.row (i).subrow_count_recursive + 1
				end
			else
					-- Insert a "untagged" row
				i := last_untagged_index
				grid.insert_new_row (i)
				l_ut_row ?= grid.row (i)
				check
					attached: l_ut_row /= Void
				end
				create l_new_ut.make (l_ut_row, "<untagged>")
				l_ut_row.ensure_expandable
				untagged_subrow := l_ut_row
				i := i + 1
			end
			Precursor (a_item)
			grid.insert_new_row_parented (i, untagged_subrow)
			l_row ?= grid.row (i)
			create l_new.make (l_row, a_item)
		end

	remove_untagged_item (a_item: !G)
			-- <Precursor>
		local
			i: INTEGER
		do
			Precursor (a_item)
			if untagged_items.is_empty then
					-- This will remove `untagged_subrow' from the grid along with any remaining subrow
				grid.remove_row (untagged_subrow.index)
				untagged_subrow := Void
			else
				from
					i := first_untagged_index
				until
					{l_data: ES_TAGABLE_GRID_ITEM_DATA [G]} tree.grid.row (i).data and then
						l_data.item = a_item
				loop
					i := i + grid.row (i).subrow_count_recursive + 1
				end
				grid.remove_row (i)
			end
		end

feature -- Basic functionality

	show_row_for_item (a_item: !G)
			-- Expand all rows in `Current' displaying `a_item' and select them.
		require
			connected: is_connected
			a_item_in_collection: collection.items.has (a_item)
		local
			l_tags: !DS_HASH_SET [!STRING]
			i: INTEGER
		do
			l_tags := tag_suffixes (a_item.tags, tag_prefix)
			if not l_tags.is_empty then
				l_tags.do_all (agent show_nodes_for_item (a_item, ?))
			else
				check
						-- `untagged_subrow' must be attached since item is in collection and does not have any
						-- matching tags.
					untagged_subrow_attached: untagged_subrow /= Void
					is_untagged_item: untagged_items.has (a_item)
				end
				if not untagged_subrow.is_expanded and untagged_subrow.is_expandable then
					untagged_subrow.expand
				end
				if untagged_subrow.is_expanded then
					from
						i := first_untagged_index
					until
						{l_data: ES_TAGABLE_GRID_ITEM_DATA [G]} tree.grid.row (i).data and then
							l_data.item = a_item
					loop
						i := i + grid.row (i).subrow_count_recursive + 1
					end
					grid.set_first_visible_row (untagged_subrow.index)
				end
			end
		end

feature {NONE} -- Implementation

	on_row_expansion (a_row: EV_GRID_ROW) is
			-- Make sure tree node represented by `a_row' is evaluated.
		do
			if {l_node: ES_TAGABLE_GRID_TAG_DATA [G]} a_row.data then
				if not l_node.is_evaluated then
					l_node.compute_descendants
				end
				if expansion_cache.count = max_expansion_cache_count then
					expansion_cache.remove_first
				end
				expansion_cache.put_last (l_node.tag)
			elseif a_row = untagged_subrow then
				is_untagged_subrow_expanded := True
			end
		end

	on_row_collapse (a_row: EV_GRID_ROW)
			-- Remove tag from `expansion_cache' if which is represented by node.
		do
			if {l_node: ES_TAGABLE_GRID_TAG_DATA [G]} a_row.data then
				expansion_cache.start
				expansion_cache.search_forth (l_node.tag)
				if not expansion_cache.off then
					expansion_cache.remove_at
				end
			elseif a_row = untagged_subrow then
				is_untagged_subrow_expanded := False
			end
		end

feature {NONE} -- Constants

	max_expansion_cache_count: INTEGER = 40

invariant
	untagged_subrow_valid: untagged_items.is_empty = (untagged_subrow = Void)
	expansion_cache_not_exceeded: expansion_cache.count <= max_expansion_cache_count

end
