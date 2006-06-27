indexing
	description: "Feature browser to display information"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_BROWSER_GRID_VIEW

inherit
	EB_CLASS_BROWSER_GRID_VIEW
		redefine
			data,
			recycle_agents
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER

create
	make

feature -- Status report

	is_branch_id_used: BOOLEAN
			-- Is branch id used?

	is_written_class_used: BOOLEAN
			-- Is written class used

	is_signature_displayed: BOOLEAN
			-- Is full feature signature displayed?
			-- If False, just display feature name.

	is_version_from_displayed: BOOLEAN
			-- Is message "version from" displayed?

	should_tooltip_be_displayed: BOOLEAN is
			-- Should tooltip display be vetoed?
		do
			Result := show_tooltip_checkbox.is_selected
		ensure
			good_result: Result = show_tooltip_checkbox.is_selected
		end

feature -- Setting

	set_is_written_class_used (b: BOOLEAN) is
			-- Set `is_written_class_used' with `b'.
		do
			is_written_class_used := b
		ensure
			is_written_class_used_set: is_written_class_used = b
		end

	set_is_branch_id_used (b: BOOLEAN) is
			-- Set `is_branch_id_used' with `b'.
		do
			is_branch_id_used := b
		ensure
			is_branch_id_used_set: is_branch_id_used = b
		end

	set_is_signature_displayed (b: BOOLEAN) is
			-- Set `is_signature_displayed' with `b'.
		do
			is_signature_displayed := b
		ensure
			is_signature_displayed_set: is_signature_displayed = b
		end

	set_is_version_from_displayed (b: BOOLEAN) is
			-- Set `is_version_from_displayed' with `b'.
		do
			is_version_from_displayed := b
		ensure
			is_version_from_displayed_set: is_version_from_displayed = b
		end

	set_feature_item (a_feature: like feature_item) is
			-- Set `feature_item' with `a_feature'.
		require
			a_feature_attached: a_feature /= Void
		do
			feature_item := a_feature
		ensure
			feature_item_set: feature_item = a_feature
		end

	rebuild_interface is
			-- Rebuild interface
		local
			l_written_class_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO
		do
			if is_written_class_used then
				grid.set_column_count_to (3)
				grid.header.i_th (3).set_text (interface_names.l_version_from)
				create l_written_class_sort_info.make (grid.column (3), agent written_class_sorter, ascending_order)
				l_written_class_sort_info.enable_auto_indicator
				set_sort_info (l_written_class_sort_info)
			else
				grid.set_column_count_to (2)
			end
		end

feature -- Actions

	on_show_tooltip_changed is
			-- Action to be performed when selection status of `show_tooltip_checkbox' changes
		do
			if preferences.class_browser_data.is_tooltip_shown /= show_tooltip_checkbox.is_selected then
				preferences.class_browser_data.show_tooltip_preference.set_value (show_tooltip_checkbox.is_selected)
			end
		end

	on_show_tooltip_changed_from_outside is
			-- Action to be performed when selection status of `show_tooltip_checkbox' changes from outside
		local
			l_displayed: BOOLEAN
		do
			l_displayed := preferences.class_browser_data.is_tooltip_shown
			if l_displayed /= show_tooltip_checkbox.is_selected then
				if l_displayed then
					show_tooltip_checkbox.enable_select
				else
					show_tooltip_checkbox.disable_select
				end
			end
		end

	collapse_button_pressed_action: PROCEDURE [ANY, TUPLE] is
			-- Action to be performed when `collapse_button' is pressed
		do
			Result := agent on_collapse_one_level
		end

	expand_button_pressed_action: PROCEDURE [ANY, TUPLE] is
			-- Action to be performed when `expand_button' is pressed
		do
			Result := agent on_expand_one_level
		end

	on_enter_pressed is
			-- Action to be performed when enter key is pressed
		do
			on_expand_all_level
		end

	on_key_pressed (a_key: EV_KEY) is
			-- Action to be performed when some key is pressed in `grid'
		require
			a_key_attached: a_key /= Void
		local
			l_processed: BOOLEAN
		do
			l_processed := on_predefined_key_pressed (a_key)
			if not l_processed then
				if a_key.code = {EV_KEY_CONSTANTS}.key_left then
					do_all_in_items (grid.selected_items, agent go_to_parent)
				elseif a_key.code = {EV_KEY_CONSTANTS}.key_right then
					do_all_in_items (grid.selected_items, agent go_to_first_child)
				end
			end
		end

	go_to_parent (a_item: EV_GRID_ITEM) is
			-- Go to parent of `a_item', if any.
		require
			a_item_attached: a_item /= Void
			a_item_is_parented: a_item.parent /= Void
		local
			l_row: EV_GRID_ROW
			l_grid_item: EV_GRID_ITEM
		do
			if a_item.column.index = 1 then
				l_row := a_item.row
				if l_row.is_expandable and then l_row.is_expanded then
					l_row.collapse
				else
					if l_row.parent_row /= Void then
						l_row.disable_select
						l_grid_item := l_row.parent_row.item (1)
						l_grid_item.row.ensure_visible
						l_grid_item.enable_select
					end
				end
			end
		end

	go_to_first_child (a_item: EV_GRID_ITEM) is
			-- Go to first child of `a_item'.
		require
			a_item_attached: a_item /= Void
			a_item_is_parented: a_item.parent /= Void
		local
			l_row: EV_GRID_ROW
			l_grid_item: EVS_GRID_SEARCHABLE_ITEM
		do
			l_row := a_item.row
			if l_row.is_expandable then
				if not l_row.is_expanded then
					l_row.expand
				else
					if l_row.subrow_count > 0 then
						l_row.disable_select
						l_grid_item ?= l_row.subrow (1).item (1)
						check l_grid_item /= Void end
						ensure_visible (l_grid_item, True)
					end

				end
			end
		end

	on_expand_all_level is
			-- Action to be performed to recursively expand all selected rows.
		do
			do_all_in_items (grid.selected_items, agent expand_item)
		end

	on_collapse_all_level is
			-- Action to be performed to recursively collapse all selected rows.
		do
			do_all_in_items (grid.selected_items, agent collapse_item)
		end

	on_expand_one_level is
			-- Action to be performed to expand all selected rows.
		do
			do_all_in_items (grid.selected_items, agent expand_item)
		end

	on_collapse_one_level is
			-- Action to be performed to collapse all selected rows.
		do
			do_all_in_items (grid.selected_items, agent collapse_item)
		end

	on_notify is
			-- Action to be performed when `update' is called.
		do
		end

feature -- Access

	control_bar: EV_WIDGET is
			-- Widget of a control bar through which, certain control can be performed upon current view
		local
			l_tool_bar: EV_TOOL_BAR
		do
			if control_tool_bar = Void then
				create control_tool_bar
				create l_tool_bar
				l_tool_bar.extend (create{EV_TOOL_BAR_SEPARATOR})
				l_tool_bar.extend (show_tooltip_checkbox)
				control_tool_bar.set_padding (2)
				control_tool_bar.extend (l_tool_bar)
				control_tool_bar.disable_item_expand (l_tool_bar)
			end
			Result := control_tool_bar
		ensure then
			result_attached: Result /= Void
		end

	feature_item: e_feature
			-- Feature whose information is to be displayed						

feature{NONE} -- Initialization

	bind_grid is
			-- Bind `grid'.
		local
			l_rows: like rows
			l_bg_color: EV_COLOR
			l_branch_row: EV_GRID_ROW
			l_cur_branch_id: INTEGER
			l_grid: like grid
			l_bid: INTEGER_REF
			l_row: EB_FEATURE_BROWSER_GRID_ROW
		do
			l_grid := grid
			l_bg_color := preferences.class_browser_data.even_row_background_color
			l_rows := rows
			if l_grid.row_count > 0 then
				l_grid.remove_rows (1, l_grid.row_count)
			end
			l_grid.set_row_height (line_height)
			l_grid.enable_tree
			l_grid.show_tree_node_connectors
			if not l_rows.is_empty then
				from
					l_rows.start
				until
					l_rows.after
				loop
					if is_branch_id_used then
						l_bid ?= l_rows.item_for_iteration.feature_item.data
						if l_bid /= Void then
							if l_bid.item /= l_cur_branch_id then
								l_branch_row := Void
								l_cur_branch_id := l_bid.item
							end
						end
						if l_branch_row = Void then
							l_grid.insert_new_row (l_grid.row_count + 1)
							l_branch_row := l_grid.row (l_grid.row_count)
							l_branch_row.set_item (1, branch_item (l_cur_branch_id))
						end
					end
					l_row := rows.item_for_iteration
					l_row.bind_row (l_branch_row, grid, l_bg_color, 0)
					if l_branch_row /= Void and then l_branch_row.is_expandable then
						l_branch_row.expand
					end
					l_rows.forth
				end
			end
		end

	build_grid is
			-- Build `grid'.
		do
			create grid
			if is_written_class_used then
				grid.set_column_count_to (3)
				grid.header.i_th (3).set_text (interface_names.l_version_from)
			else
				grid.set_column_count_to (2)
			end
			grid.enable_selection_on_single_button_click
			grid.header.i_th (1).set_text (interface_names.l_class_browser_classes)
			grid.header.i_th (2).set_text (interface_names.l_class_browser_features)
			grid.enable_tree
			grid.pick_ended_actions.force_extend (agent on_pick_ended)
			grid.set_item_pebble_function (agent on_pick)
			grid.enable_multiple_item_selection
			grid.key_press_actions.extend (agent on_key_pressed)
			if drop_actions /= Void then
				grid.drop_actions.fill (drop_actions)
			end
			show_tooltip_checkbox.select_actions.extend (agent on_show_tooltip_changed)
			on_show_tooltip_changed_from_outside_agent := agent on_show_tooltip_changed_from_outside
			preferences.class_browser_data.show_tooltip_preference.change_actions.extend (on_show_tooltip_changed_from_outside_agent)
		end

	build_sortable_and_searchable is
			-- Build facilities to support sort and search
		local
			l_class_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO
			l_feature_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO
			l_written_class_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO
		do
			old_make (grid)
				-- Prepare sort facilities
			last_sorted_column := 0
			create l_class_sort_info.make (grid.column (1), agent class_sorter, topology_order)
			create l_feature_sort_info.make (grid.column (2), agent feature_sorter, ascending_order)
			if is_written_class_used then
				create l_written_class_sort_info.make (grid.column (3), agent written_class_sorter, ascending_order)
				l_written_class_sort_info.enable_auto_indicator
				set_sort_info (l_written_class_sort_info)
			end
			l_class_sort_info.enable_auto_indicator
			l_feature_sort_info.enable_auto_indicator
			set_sort_info (l_class_sort_info)
			set_sort_info (l_feature_sort_info)
				-- Prepare search facilities
			create quick_search_bar.make (development_window)
			quick_search_bar.attach_tool (Current)
			enable_search
			create column_tester_table.make (3)
			column_tester_table.put (agent class_tester, 1)
			column_tester_table.put (agent feature_name_tester, 2)
			column_tester_table.put (agent written_class_tester, 3)
			create {LINKED_LIST [INTEGER]}sort_column_list.make
		end

feature -- Notification

	update_view is
			-- Update current view according to change in `model'.
		local
			l_msg: STRING
		do
			if not is_up_to_date then
				if data /= Void then
					text.hide
					component_widget.show
					fill_rows
					if last_sorted_column = 0 then
						last_sorted_column := class_column
					end
					disable_auto_sort_order_change
					sort (0, 0, 1, 0, 0, 0, 0, 0, class_column)
					enable_auto_sort_order_change
				else
					component_widget.hide
					text.show
					l_msg := Warning_messages.w_Formatter_failed
					if trace /= Void then
						l_msg.append ("%N")
						l_msg.append (trace)
					end
					text.set_text (l_msg)
				end
				auto_resize
				is_up_to_date := True
			end
		end

	auto_resize is
			-- Auto resize columns to give a best view point.
		local
			l_requested_width: INTEGER
			l_font: EV_FONT
			l_header_width: INTEGER
		do
			create l_font
			if grid.row_count > 0 then
				l_requested_width := grid.column (1).required_width_of_item_span (1, grid.row_count)
				if l_requested_width > 300 then
					l_requested_width := 300
				else
					l_header_width := l_font.string_width (grid.header.i_th (1).text)
					if l_requested_width < l_header_width then
						l_requested_width := l_header_width + 30
					else
						l_requested_width := l_requested_width + 10
					end
				end
				grid.column (1).set_width (l_requested_width)
				l_requested_width := grid.column (2).required_width_of_item_span (1, grid.row_count)
				if l_requested_width > 500 then
					l_requested_width := 500
				else
					l_header_width := l_font.string_width (grid.header.i_th (2).text)
					if l_requested_width < l_header_width then
						l_requested_width := l_header_width + 30
					else
						l_requested_width := l_requested_width + 10
					end
				end
				grid.column (2).set_width (l_requested_width)
				if grid.column_count > 2 then
					grid.column (3).resize_to_content
				end
			end
		end

	fill_rows is
			-- Fill `rows' using `data'.
		local
			l_data: like data
			l_row: EB_FEATURE_BROWSER_GRID_ROW
			l_bid: INTEGER_REF
			l_feature: QL_FEATURE
			l_branch_id: INTEGER
			l_rows: like rows
			l_is_first: BOOLEAN
			l_last_bid: INTEGER
			l_is_single_branch_id: BOOLEAN
		do
			l_rows := rows
			l_rows.wipe_out
			l_data := data
			from
				l_data.start
				l_is_first := True
				l_is_single_branch_id := True
			until
				l_data.after
			loop
				l_feature := l_data.item
				l_bid ?= l_feature.data
				if l_bid /= Void then
					l_branch_id := l_bid.item
				else
					l_branch_id := 0
				end
				if l_is_first then
					l_is_first := False
				else
					if l_is_single_branch_id then
						l_is_single_branch_id := l_last_bid = l_branch_id
					end
				end
				l_last_bid := l_branch_id
				create l_row.make (l_data.item, l_branch_id, Current)
				l_row.set_is_written_class_used (is_written_class_used)
				l_row.set_is_signature_displayed (is_signature_displayed)
				l_rows.force_last (l_row)
				l_data.forth
			end
			set_is_branch_id_used (not l_is_single_branch_id)
		end


feature -- Visiability

	ensure_visible (a_item: EVS_GRID_SEARCHABLE_ITEM; a_selected: BOOLEAN) is
			-- Ensure `a_item' is visible in viewable area of `grid'.
			-- If `a_selected' is True, make sure that `a_item' is in its selected status.
		local
			l_grid_row: EV_GRID_ROW
			l_row: EB_FEATURE_BROWSER_GRID_ROW

		do
			l_grid_row := a_item.grid_item.row
			l_row ?= l_grid_row.data
			check l_row /= Void end
			if l_row.parent /= Void then
				if l_row.parent.is_expandable then
					l_row.parent.expand
				end
				l_grid_row.ensure_visible
			end
			grid.remove_selection
			a_item.grid_item.enable_select
		end

feature{NONE} -- Sorting

	class_column: INTEGER is 1
			-- Column index for class

	feature_column: INTEGER is 2
			-- Column index for feature

	written_class_column: INTEGER is 3
			-- Column index for written class

	class_sorter (a_order: INTEGER) is
			-- Sorter for class name
		do
			if ev_application.ctrl_pressed then
				extend_sort_column_list (class_column)
			else
				sort_column_list.wipe_out
				sort_column_list.extend (class_column)
			end
			sort_rows (rows, sort_column_list)
			bind_grid
		end

	written_class_sorter (a_order: INTEGER) is
			-- Sorter for class name
		do
			if ev_application.ctrl_pressed then
				extend_sort_column_list (written_class_column)
			else
				sort_column_list.wipe_out
				sort_column_list.extend (written_class_column)
			end
			sort_rows (rows, sort_column_list)

			bind_grid
		end

	feature_sorter (a_order: INTEGER) is
			-- Sorter for feature name
		do
			if ev_application.ctrl_pressed then
				extend_sort_column_list (feature_column)
			else
				sort_column_list.wipe_out
				sort_column_list.extend (feature_column)
			end
			sort_rows (rows, sort_column_list)
			bind_grid
		end

	feature_name_tester (row_a, row_b: EB_FEATURE_BROWSER_GRID_ROW): BOOLEAN is
			-- Compare `row_a' and `row_b' ascendingly.
		require
			row_a_valid: row_a /= Void
			row_b_valid: row_b /= Void
		do
			if row_a.branch_id /= row_b.branch_id then
				Result := row_a.branch_id < row_b.branch_id
			else
				if current_feature_sort_order = ascending_order then
					Result := row_a.feature_item.name < row_b.feature_item.name
				else
					Result := row_a.feature_item.name > row_b.feature_item.name
				end
			end
		end

	class_tester (row_a, row_b: EB_FEATURE_BROWSER_GRID_ROW): BOOLEAN is
			-- Compare `row_a' and `row_b' ascendingly.
		require
			row_a_valid: row_a /= Void
			row_b_valid: row_b /= Void
		local
			l_class_a_name: STRING
			l_class_b_name: STRING
		do
			if row_a.branch_id /= row_b.branch_id then
				Result := row_a.branch_id < row_b.branch_id
			else
				l_class_a_name := row_a.feature_item.class_c.name
				l_class_b_name := row_b.feature_item.class_c.name
				if current_class_sort_order = topology_order then
					Result := row_a.feature_item.class_c.topological_id < row_b.feature_item.class_c.topological_id
				else
					if current_class_sort_order = ascending_order then
						Result := l_class_a_name < l_class_b_name
					else
						Result := l_class_a_name > l_class_b_name
					end
				end
			end
		end

	written_class_tester (row_a, row_b: EB_FEATURE_BROWSER_GRID_ROW): BOOLEAN is
			-- Compare `row_a' and `row_b' ascendingly.
		require
			row_a_valid: row_a /= Void
			row_b_valid: row_b /= Void
		local
			l_class_a_name: STRING
			l_class_b_name: STRING
		do
			if row_a.branch_id /= row_b.branch_id then
				Result := row_a.branch_id < row_b.branch_id
			else
				l_class_a_name := row_a.feature_item.written_class.name
				l_class_b_name := row_b.feature_item.written_class.name
				if current_written_class_sort_order = topology_order then
					Result := row_a.feature_item.written_class.topological_id < row_b.feature_item.written_class.topological_id
				else
					if current_written_class_sort_order = ascending_order then
						Result := l_class_a_name < l_class_b_name
					else
						Result := l_class_a_name > l_class_b_name
					end
				end
			end
		end

	current_class_sort_order: INTEGER is
			-- Current sort order on class column
		do
			Result := column_sort_info.item (class_column).current_order
		end

	current_feature_sort_order: INTEGER is
			-- Current sort order on feature column
		do
			Result := column_sort_info.item (feature_column).current_order
		end

	current_written_class_sort_order: INTEGER is
			-- Current sort order on written_class column
		do
			Result := column_sort_info.item (written_class_column).current_order
		end

	column_tester_table: HASH_TABLE [FUNCTION [ANY, TUPLE [u, v: EB_FEATURE_BROWSER_GRID_ROW], BOOLEAN], INTEGER]
			-- Table of column testers
			-- Key is column index, value is the tester.

	sort_rows (a_rows: like rows; a_column_list: LIST [INTEGER]) is
			-- Sort `a_rows' column by column for every column whose indexes are in `a_column_list'.
		require
			a_rows_attached: a_rows /= Void
			a_column_list_attached: a_column_list /= Void
			not_a_column_list_is_empty: not a_column_list.is_empty
		local
			l_list: ARRAYED_LIST [FUNCTION [ANY, TUPLE [u, v: EB_FEATURE_BROWSER_GRID_ROW], BOOLEAN]]
			l_cursor: CURSOR
			l_tester: AGENT_LIST_COMPARATOR [EB_FEATURE_BROWSER_GRID_ROW]
			l_sorter: DS_QUICK_SORTER [EB_FEATURE_BROWSER_GRID_ROW]
		do
			create l_list.make (a_column_list.count)
			l_cursor := a_column_list.cursor
			from
				a_column_list.start
			until
				a_column_list.after
			loop
				l_list.extend (column_tester_table.item (a_column_list.item))
				a_column_list.forth
			end
			a_column_list.go_to (l_cursor)
			create l_tester.make (l_list)
			create l_sorter.make (l_tester)
			l_sorter.sort (a_rows)
		end

	sort_column_list: LIST [INTEGER]
			-- List of columns to sort

	extend_sort_column_list (a_column: INTEGER) is
			-- Extend `a_column' in `sort_column_list'.
		require
			a_column_positive: a_column > 0
		do
			sort_column_list.prune_all (a_column)
			sort_column_list.extend (a_column)
		end

feature -- Recyclable

	recycle_agents is
			-- Recyclable
		do
			Precursor {EB_CLASS_BROWSER_GRID_VIEW}
			if on_show_tooltip_changed_from_outside_agent /= Void then
				preferences.class_browser_data.show_tooltip_preference.change_actions.prune_all (on_show_tooltip_changed_from_outside_agent)
			end
		end

feature{NONE} -- Implementation

	on_show_tooltip_changed_from_outside_agent: PROCEDURE [ANY, TUPLE]

	data: QL_FEATURE_DOMAIN
			-- Data to be displayed

	rows: DS_ARRAYED_LIST [EB_FEATURE_BROWSER_GRID_ROW] is
			-- Rows to be displayed
		do
			if rows_internal = Void then
				create rows_internal.make (50)
			end
			Result := rows_internal
		ensure
			result_attached: Result /= Void
		end

	rows_internal: like rows
			-- Implementation of `rows'	

	control_tool_bar: EV_HORIZONTAL_BOX
			-- Implementation of `control_bar'

--	show_tooltip_checkbox_internal: like show_tooltip_checkbox
--			-- Implementation of `show_tooltip_checkbox'

	branch_item (a_branch_id: INTEGER): EB_GRID_EDITOR_TOKEN_ITEM is
			-- A grid item to display branch id
		do
			create Result.make_with_text (interface_names.l_branch+a_branch_id.out)
		ensure
			result_attached: Result /= Void
		end

	expand_item (a_item: EV_GRID_ITEM) is
			-- Expand `a_item'.
		require
			a_item_attached: a_item /= Void
			a_item_is_parented: a_item.parent /= Void
		do
			if a_item.column.index = 1 then
				if a_item.row.is_expandable then
					a_item.row.expand
				end
			end
		end

	collapse_item (a_item: EV_GRID_ITEM) is
			-- Collapse `a_item'.
		require
			a_item_attached: a_item /= Void
			a_item_is_parented: a_item.parent /= Void
		do
			if a_item.column.index = 1 then
				if a_item.row.is_expandable then
					a_item.row.collapse
				end
			end
		end

	selected_text: STRING is
			-- String representation of selected rows/items
			-- If no row/item is selected, return an empty string.
		local
			l_sorted_items: DS_LIST [EV_GRID_ITEM]
			l_grid_item: EB_GRID_EDITOR_TOKEN_ITEM
			l_last_row_index: INTEGER
			l_last_column_index: INTEGER
			l_item: EV_GRID_ITEM
			l_list: LIST [EV_GRID_ITEM]
		do
			l_list := grid.selected_items
			if not l_list.is_empty then
				create Result.make (512)
				if l_list.count = 1 then
						-- For single selected item
					l_grid_item ?= l_list.first
					if l_grid_item /= Void then
						Result.append (l_grid_item.text)
					end
				else
						-- For multi selected items
					l_sorted_items := sorted_items (l_list)
					from
						l_last_column_index := 1
						l_sorted_items.start
					until
						l_sorted_items.after
					loop
						l_item := l_sorted_items.item_for_iteration
						if l_item.row.index /= l_last_row_index then
							if l_last_row_index /= 0 then
								Result.append_character ('%N')
							end
							l_last_row_index := l_item.row.index
							l_last_column_index := 1
						end
						Result.append (tabs (l_item.column.index - l_last_column_index))
						l_last_column_index := l_item.column.index
						l_grid_item ?= l_item
						if l_grid_item /= Void then
							Result.append (l_grid_item.text)
						end
						l_sorted_items.forth
					end
				end
			else
				create Result.make (0)
			end
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
