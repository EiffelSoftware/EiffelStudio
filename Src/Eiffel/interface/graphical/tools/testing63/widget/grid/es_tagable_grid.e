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

	build_widget_interface (a_box: like widget)
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
			register_action (grid.row_select_actions, agent on_row_select)
			register_action (grid.row_deselect_actions, agent on_row_deselect)
			register_action (grid.pointer_double_press_item_actions, agent on_item_double_press)
			propagate_selection_events := True

				-- pick and drop support
			create l_support.make_with_grid (grid)
			l_support.synchronize_color_or_font_change_with_editor
			l_support.enable_grid_item_pnd_support
			l_support.enable_ctrl_right_click_to_open_new_window
			l_support.set_context_menu_factory_function (agent (develop_window.menus).context_menu_factory)

			auto_recycle (l_support)

			a_box.set_border_width (1)
			a_box.set_background_color ((create {EV_STOCK_COLORS}).gray)
			a_box.extend (grid)

			create timer
			timer.actions.extend (agent on_timer_elapse)
			on_timer_elapse
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
		local
			l_layout: like internal_layout
		do
			l_layout := internal_layout
			if l_layout = Void then
				create l_layout
				internal_layout := l_layout
			end
			Result := l_layout
		end

	internal_layout: ?like layout
			-- Internal storage for factory

	timer: !EV_TIMEOUT
			-- Timer for redrawing items in `grid'

	timer_interval: INTEGER = 10000
			-- Interval used for timer

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
			l_selected: BOOLEAN
		do
			propagate_selection_events := False
			l_row := grid.row (a_row_index)
			l_selected := l_row.is_selected
			if {l_data: ES_TAGABLE_GRID_DATA [G]} l_row.data then
				l_data.populate_row (layout)
			else
				check
					dead_end: False
				end
			end
			Result := l_row.item (a_col_index)
			if l_selected then
				l_row.enable_select
			end
			propagate_selection_events := True
		end

feature {NONE} -- Status report

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
		do
			grid.selected_rows.do_all (
				agent (a_row: EV_GRID_ROW)
					require
						a_row /= Void
					do
						highlight_row (a_row)
					end)
		end

	redraw_items
			-- Redraw all items in `grid'
		local
			i: INTEGER
			l_list: ARRAYED_LIST [INTEGER]
			l_item: EV_GRID_ITEM
		do
			if grid.is_displayed then
				from
					l_list := grid.visible_row_indexes
					i := 1
				until
					i > l_list.count
				loop
					l_item := computed_grid_item (1, l_list.i_th (i))
					i := i + 1
				end
			end
		end

feature {NONE} -- Events

	on_timer_elapse
			-- Called when timer reached timeout
		do
			redraw_items
			timer.set_interval (0)
			timer.set_interval (timer_interval)
		end

	on_row_select (a_row: !EV_GRID_ROW)
			-- Called when a row in `grid' is selected.
		do
			if propagate_selection_events then
				if {l_data: ES_TAGABLE_GRID_ITEM_DATA [G]} a_row.data then
					internal_selected_items.force (l_data.item)
					item_selected_actions.call ([l_data.item])
				end
			end
		end

	on_row_deselect (a_row: !EV_GRID_ROW)
			-- Called when a row in `grid' is deselected.
		do
			if propagate_selection_events then
				if {l_data: ES_TAGABLE_GRID_ITEM_DATA [G]} a_row.data then
					internal_selected_items.remove (l_data.item)
					item_deselected_actions.call ([l_data.item])
				end
			end
		end

	on_item_double_press (a_x, a_y, a_button: INTEGER; a_item: EV_GRID_ITEM)
			-- Called when a item has been double clicked in `grid'
		do
			if a_button = {EV_POINTER_CONSTANTS}.left then
				if a_item /= Void and then {l_data: ES_TAGABLE_GRID_ITEM_DATA [G]} a_item.row.data then
					item_pointer_double_press_actions.call ([l_data.item])
				end
			end
		end

feature {NONE} -- Factory

	create_widget: like widget
			-- <Precursor>
		do
			create Result
		end
end
