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
	ES_TBT_GRID [G -> TAGABLE_I]

inherit
	ES_GRID
		rename
			remove_item as remove_grid_item,
			wipe_out as wipe_out_grid
		end

	TAG_BASED_TREE [G]
		rename
			make as make_tree,
			parent as unused_parent
		undefine
			default_create,
			copy,
			unused_parent,
			child_for_token,
			add_child,
			add_item,
			remove_child,
			remove_item
		redefine
			tree,
			wipe_out,
			refill,
			add_untagged_item,
			remove_untagged_item
		end

	ES_TBT_GRID_NODE_CONTAINER [G]
		rename
			tag as tag_prefix,
			row as unused_row,
			parent as unused_parent
		undefine
			default_create,
			copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make

feature {NONE} --Initialization

	make (a_collection: like observed_collection; a_prefix: like tag_prefix; a_factory: like factory)
			-- Initialize `Current'
			--
			-- `a_collection': Active collection containing items for which tree shall be built.
			-- `a_prefix': The tree will search for tags in the collection beginning with `a_prefix'. For
			--             each tag found, it will insert a leaf holding the corresponding item. The path to
			--             the leaf is represented by the remaining suffix, which is the original tag
			--             without the leading prefix.
			--             Items which were not tagged with a tag beginning with `a_prefix', are shown
			--             in separate rows at the botton of the grid.
			-- `a_layout': Layout defining look and functionality of grid items
		require
			a_collection_usable: a_collection.is_interface_usable
			a_prefix_valid: is_valid_tag (a_prefix)
		local
			l_pnd_helper: EB_EDITOR_TOKEN_GRID_SUPPORT
		do
			factory := a_factory

				-- attach since at root level we always want to insert children and items directly
			create cached_children.make_default
			create cached_items.make_default
				-- Unfortunately, `default_create' causes a qualified call to `Current', so we need to
				-- satisfy all invariants by creating `internal_untagged_item', even though `make_tree'
				-- will overwrite it again.
			create internal_untagged_items.make_default

				-- create grid
			default_create
			enable_tree
			hide_tree_node_connectors
			set_dynamic_content_function (agent computed_grid_item)
			enable_partial_dynamic_content
			enable_single_row_selection
			row_expand_actions.extend (agent on_row_expansion)

				-- grid appearance
			set_focused_selection_color (preferences.editor_data.selection_background_color)
			set_non_focused_selection_color (preferences.editor_data.focus_out_selection_background_color)
			row_select_actions.extend (agent highlight_row)
			row_deselect_actions.extend (agent dehighlight_row)
			focus_in_actions.extend (agent change_focus)
			focus_out_actions.extend (agent change_focus)
			set_focused_selection_text_color (preferences.editor_data.selection_text_color)

				-- pick and drop support
			create l_pnd_helper.make_with_grid (Current)
			l_pnd_helper.enable_grid_item_pnd_support

				-- initialize tree
			make_tree (a_collection, a_prefix)
		end

	initialize_layout
			-- Initialize columns of `grid'.
		do
			set_column_count_to (factory.column_count.as_integer_32)
			if {l_header: !EV_GRID_HEADER} header then
				factory.populate_header (l_header)
			end
		end

feature -- Access

	tree: !ES_TBT_GRID [G]
			-- <Precursor>
		do
			Result := Current
		end

feature {NONE} -- Access

	factory: !ES_TBT_GRID_LAYOUT [G]
			-- Factory responsible for drawing grid items

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
			Result := row_count + 1
		end

feature {NONE} -- Element change

	refill is
			-- <Precursor>
		do
			initialize_layout
			Precursor
		end

	wipe_out
			-- <Precursor>
		do
			wipe_out_grid
			cached_children.wipe_out
			cached_items.wipe_out
			internal_untagged_items.wipe_out
		end

	add_untagged_item (a_item: !G) is
			-- <Precursor>
		local
			i: INTEGER
			l_row: !EV_GRID_ROW
			l_new: ES_TBT_GRID_TAGABLE [G]
			l_new_ut: ES_TBT_GRID_UNTAGGED_ROW
		do
			if untagged_subrow /= Void then
				from
					i := first_untagged_index
				until
					i = last_untagged_index or else ({l_data: ES_TBT_GRID_TAGABLE [G]} row (i).data and then
					l_data.item.name > a_item.name)
				loop
					i := i + row (i).subrow_count_recursive + 1
				end
			else
					-- Insert a "untagged" row
				i := last_untagged_index
				insert_new_row (i)
				l_row ?= row (i)
				create l_new_ut.make (l_row)
				untagged_subrow := l_row
				i := i + 1
			end
			insert_new_row (i)
			l_row ?= row (i)
			create l_new.make (l_row, a_item)
			Precursor (a_item)
		end

	remove_untagged_item (a_item: !G)
			-- <Precursor>
		local
			i: INTEGER
		do
			Precursor (a_item)
			if untagged_items.is_empty then
				remove_row (untagged_subrow.index)
			else
				from
					i := first_untagged_index
				until
					{l_data: ES_TBT_GRID_TAGABLE [G]} tree.row (i).data and then
						l_data.item = a_item
				loop
					i := i + row (i).subrow_count_recursive + 1
				end
				remove_row (i)
			end
		end

feature {NONE} -- Implementation

	computed_grid_item (a_col_index, a_row_index: INTEGER): EV_GRID_ITEM is
			-- Computed grid item at given location
		local
			l_row: EV_GRID_ROW
			l_data: ES_TBT_GRID_DATA [G]
		do
			l_row := row (a_row_index)
			l_data ?= l_row.data
			l_data.populate_row (factory)
			Result := l_row.item (a_col_index)
		end

	on_row_expansion (a_row: EV_GRID_ROW) is
			-- Make sure tree node represented by `a_row' is evaluated.
		do
			if {l_node: ES_TBT_GRID_NODE [G]} a_row.data then
				if not l_node.is_evaluated then
					l_node.compute_descendants
				end
			end
		end

	highlight_row (a_row: !EV_GRID_ROW) is
			-- Make `a_row' look like it is fully selected.
		do
			if has_focus then
				a_row.set_background_color (preferences.editor_data.selection_background_color)
			else
				a_row.set_background_color (preferences.editor_data.focus_out_selection_background_color)
			end
		end

	dehighlight_row (a_row: !EV_GRID_ROW) is
			-- Make `a_row' look like it is not selected.
		do
			a_row.set_background_color (preferences.editor_data.class_background_color)
		end

	change_focus is
			-- Make sure all selected rows have correct background color.
		local
			l_selected: LIST [!EV_GRID_ROW]
		do
			l_selected ?= selected_rows
			l_selected.do_all (agent highlight_row)
		end

invariant
	untagged_subrow_valid: untagged_items.is_empty = (untagged_subrow = Void)

end
