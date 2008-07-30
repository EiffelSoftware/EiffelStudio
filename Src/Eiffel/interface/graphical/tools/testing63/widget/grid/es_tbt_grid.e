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
	ES_WINDOW_WIDGET [EV_CELL]
		undefine
			is_interface_usable
		redefine
			on_before_initialize
		end

	TAG_BASED_TREE [G]
		rename
			make as make_tree,
			parent as unused_parent
		undefine
			is_interface_usable,
			unused_parent,
			child_for_token,
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

	ES_TBT_GRID_NODE_CONTAINER [G]
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
				-- attach since at root level we always want to insert children and items directly
			create cached_children.make_default
			create cached_items.make_default
				-- Unfortunately, `default_create' causes a qualified call to `Current', so we need to
				-- satisfy all invariants by creating `internal_untagged_item', even though `make_tree'
				-- will overwrite it again.
			create internal_untagged_items.make_default
		end

	build_widget_interface (a_cell: EV_CELL)
			-- <Precursor>
		local
			l_support: EB_EDITOR_TOKEN_GRID_SUPPORT
		do
			create grid
			grid.enable_tree
			grid.enable_single_row_selection
			grid.hide_tree_node_connectors
			grid.set_dynamic_content_function (agent computed_grid_item)
			grid.enable_partial_dynamic_content
			grid.row_expand_actions.extend (agent on_row_expansion)

				-- grid appearance
			grid.set_focused_selection_color (preferences.editor_data.selection_background_color)
			grid.set_focused_selection_text_color (colors.grid_focus_selection_text_color)
			grid.set_non_focused_selection_color (colors.grid_unfocus_selection_color)
			grid.set_non_focused_selection_text_color (colors.grid_unfocus_selection_text_color)
			grid.row_select_actions.extend (agent highlight_row)
			grid.row_deselect_actions.extend (agent dehighlight_row)
			grid.focus_in_actions.extend (agent change_focus)
			grid.focus_out_actions.extend (agent change_focus)

				-- pick and drop support
			create l_support.make_with_grid (grid)
			l_support.synchronize_color_or_font_change_with_editor
			l_support.enable_grid_item_pnd_support
			l_support.enable_ctrl_right_click_to_open_new_window
			l_support.set_context_menu_factory_function (agent (develop_window.menus).context_menu_factory)

			auto_recycle (l_support)

			a_cell.extend (grid)
		end

	initialize_layout
			-- Initialize columns of `grid'.
		do
			grid.clear
			grid.set_column_count_to (layout.column_count.as_integer_32)
			if {l_header: !EV_GRID_HEADER} grid.header then
				layout.populate_header (l_header)
			end
		end

feature -- Access

	tree: !ES_TBT_GRID [G]
			-- <Precursor>
		do
			Result := Current
		end

feature {ES_TBT_GRID_NODE_CONTAINER} -- Access

	grid: !ES_GRID
			-- Actual grid visualizing tree as in items

feature {NONE} -- Access

	layout: !ES_TBT_GRID_LAYOUT [G]
			-- Layout responsible for drawing grid items and header
		do
			if internal_layout = Void then
				create internal_layout
			end
			Result ?= internal_layout
		end

	internal_layout: ?like layout
			-- Internal storage for factory

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

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := Precursor {ES_WINDOW_WIDGET} and Precursor {TAG_BASED_TREE}
		end

feature -- Status setting

	set_layout (a_layout: ?like layout)
			-- Define a specific layout for grid items
			--
			-- `a_layout': Layout which shall be used to build grid columns and items. Can be Void to make
			--             `Current' use the default layout {ES_TBT_GRID_LAYOUT}.
		require
			not_connected: not is_connected
		do
			internal_layout := a_layout
			if is_connected then
				grid.clear
				initialize_layout
			end
		ensure
			internal_layout_set: internal_layout = a_layout
		end

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
		end

	add_untagged_item (a_item: !G) is
			-- <Precursor>
		local
			i: INTEGER
			l_row: !EV_GRID_ROW
			l_ut_row: EV_GRID_ROW
			l_new: ES_TBT_GRID_TAGABLE [G]
			l_new_ut: ES_TBT_GRID_UNTAGGED_ROW [G]
		do
			if untagged_subrow /= Void then
				from
					i := first_untagged_index
				until
					i = last_untagged_index or else ({l_data: ES_TBT_GRID_TAGABLE [G]} grid.row (i).data and then
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
				create l_new_ut.make (l_ut_row)
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
				grid.remove_row (untagged_subrow.index)
			else
				from
					i := first_untagged_index
				until
					{l_data: ES_TBT_GRID_TAGABLE [G]} tree.grid.row (i).data and then
						l_data.item = a_item
				loop
					i := i + grid.row (i).subrow_count_recursive + 1
				end
				grid.remove_row (i)
			end
		end

feature {NONE} -- Implementation

	computed_grid_item (a_col_index, a_row_index: INTEGER): EV_GRID_ITEM is
			-- Computed grid item at given location
		local
			l_row: EV_GRID_ROW
			l_data: ES_TBT_GRID_DATA [G]
		do
			l_row := grid.row (a_row_index)
			l_data ?= l_row.data
			l_data.populate_row (layout)
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
			if grid.has_focus then
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
			l_selected ?= grid.selected_rows
			l_selected.do_all (agent highlight_row)
		end

feature {NONE} -- Factory

	create_widget: EV_CELL
			-- <Precursor>
		do
			create Result
		end

invariant
	untagged_subrow_valid: untagged_items.is_empty = (untagged_subrow = Void)

end
