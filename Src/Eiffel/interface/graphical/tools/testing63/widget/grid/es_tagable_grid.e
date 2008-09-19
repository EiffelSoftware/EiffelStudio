indexing
	description: "[
		Objects that display tagable items in an ES_GRID.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_TAGABLE_GRID [G -> TAGABLE_I]

inherit
	ES_TAGABLE_WIDGET [G]

feature {NONE} -- Initialization

	build_widget_interface (a_cell: EV_CELL)
			-- <Precursor>
		local
			l_support: EB_EDITOR_TOKEN_GRID_SUPPORT
		do
			create grid
			grid.enable_tree
			grid.enable_multiple_row_selection
			grid.hide_tree_node_connectors
			grid.enable_partial_dynamic_content
			grid.set_dynamic_content_function (agent computed_grid_item)

				-- grid appearance
			grid.set_focused_selection_color (colors.grid_focus_selection_color)
			grid.set_focused_selection_text_color (colors.grid_focus_selection_text_color)
			grid.set_non_focused_selection_color (colors.grid_unfocus_selection_color)
			grid.set_non_focused_selection_text_color (colors.grid_unfocus_selection_text_color)
			grid.row_select_actions.extend (agent highlight_row)
			grid.row_deselect_actions.extend (agent unhighlight_row)
			grid.focus_in_actions.extend (agent change_focus)
			grid.focus_out_actions.extend (agent change_focus)

				-- selection support
			grid.row_select_actions.extend (agent on_row_select)
			grid.row_deselect_actions.extend (agent on_row_deselect)
			propagate_selection_events := True

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
		local
			i: INTEGER
			l_col: EV_GRID_COLUMN
		do
			grid.clear
			grid.set_column_count_to (layout.column_count)
			from
				i := 1
			until
				i > layout.column_count
			loop
				if i = layout.auto_size_column then
					grid.enable_auto_size_best_fit_column (i)
				else
					l_col := grid.column (i)
					l_col.set_width (layout.column_width (i))
				end
				i := i + 1
			end
			if {l_header: !EV_GRID_HEADER} grid.header then
				layout.populate_header (l_header)
			end
		end

feature {NONE} -- Access

	grid: !ES_GRID
			-- Actual grid visualizing tree as in items

	layout: !ES_TAGABLE_GRID_LAYOUT [G]
			-- Layout responsible for drawing grid items and header
		do
			if internal_layout = Void then
				create internal_layout
			end
			Result ?= internal_layout
		end

	internal_layout: ?like layout
			-- Internal storage for factory

feature {ES_TAGABLE_TREE_GRID_NODE_CONTAINER} -- Query

	computed_grid_item (a_col_index, a_row_index: INTEGER): EV_GRID_ITEM is
			-- Computed grid item at given location
			--
			-- Note: this will reset all items in the according row and return the requested item.
			--
			-- `a_col_index': Column index of requested item.
			-- `a_row_index': Row index of requested item.
			-- `Result': Newly computed grid item for column and row index.
		local
			l_row: EV_GRID_ROW
			l_data: ES_TAGABLE_GRID_DATA [G]
			l_selected: BOOLEAN
		do
			propagate_selection_events := False
			l_row := grid.row (a_row_index)
			l_selected := l_row.is_selected
			l_data ?= l_row.data
			l_data.populate_row (layout)
			Result := l_row.item (a_col_index)
			if l_selected then
				l_row.enable_select
			end
			propagate_selection_events := True
		end

feature {NONE} -- Status setting

	propagate_selection_events: BOOLEAN
			-- If selection changes, should events be propagated to clients?

feature -- Status setting

	set_layout (a_layout: ?like layout)
			-- Define a specific layout for grid items
			--
			-- `a_layout': Layout which shall be used to build grid columns and items. Can be Void to make
			--             `Current' use the default layout {ES_TAGABLE_GRID_LAYOUT}.
		require
			not_connected: not is_connected
		do
			internal_layout := a_layout
		ensure
			internal_layout_set: internal_layout = a_layout
		end

feature {NONE} -- Implementation

	highlight_row (a_row: !EV_GRID_ROW) is
			-- Make `a_row' look like it is fully selected.
		do
			if grid.has_focus then
				a_row.set_background_color (colors.grid_focus_selection_color)
			else
				a_row.set_background_color (colors.grid_unfocus_selection_color)
			end
		end

	unhighlight_row (a_row: !EV_GRID_ROW) is
			-- Make `a_row' look like it is not selected.
		do
			a_row.set_background_color (grid.background_color)
		end

	change_focus is
			-- Make sure all selected rows have correct background color.
		local
			l_selected: LIST [!EV_GRID_ROW]
		do
			l_selected ?= grid.selected_rows
			l_selected.do_all (agent highlight_row)
		end

	on_row_select (a_row: !EV_GRID_ROW)
			-- Called when a row in `grid' is selected.
		do
			if propagate_selection_events then
				if {l_data: ES_TAGABLE_GRID_ITEM_DATA [G]} a_row.data then
					internal_selected_items.force (l_data.item)
					item_selected_event.call ([l_data.item])
				end
			end
		end

	on_row_deselect (a_row: !EV_GRID_ROW)
			-- Called when a row in `grid' is deselected.
		do
			if propagate_selection_events then
				if {l_data: ES_TAGABLE_GRID_ITEM_DATA [G]} a_row.data then
					internal_selected_items.remove (l_data.item)
					item_deselected_event.call ([l_data.item])
				end
			end
		end

feature {NONE} -- Factory

	create_widget: EV_CELL
			-- <Precursor>
		do
			create Result
		end
end
