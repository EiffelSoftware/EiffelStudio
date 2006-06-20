indexing
	description: "Flat view of class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_FLAT_VIEW

inherit
	EB_CLASS_BROWSER_GRID_VIEW
		redefine
			grid_selected_items,
			data,
			recycle_agents
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER

	SHARED_WORKBENCH

create
	make

feature -- Actions

	on_row_expanded (a_row: EV_GRID_ROW) is
			-- Action performed when `a_row' is expanded
		local
			l_row: EB_CLASS_BROWSER_FLAT_ROW
			l_height: INTEGER
			l_row_index: INTEGER
			done: BOOLEAN
			l_cur_row: EB_CLASS_BROWSER_FLAT_ROW
		do
			l_row ?= a_row.data
			check l_row /= Void end
			l_row.set_is_expanded (True)
			l_row.refresh
			l_height := line_height
			from
				l_row_index := a_row.index + 2
			until
				done or l_row_index > grid.row_count
			loop
				l_cur_row ?= grid.row (l_row_index).data
				check l_cur_row /= Void end
				if not l_cur_row.is_parent then
					grid.row (l_row_index).set_height (l_height)
					l_row_index := l_row_index + 1
				else
					done := True
				end
			end
		end

	on_row_collapsed (a_row: EV_GRID_ROW) is
			-- Action performed when `a_row' is collapsed
		local
			l_row: EB_CLASS_BROWSER_FLAT_ROW
			l_row_index: INTEGER
			done: BOOLEAN
			l_cur_row: EB_CLASS_BROWSER_FLAT_ROW
		do
			l_row ?= a_row.data
			check l_row /= Void end
			l_row.set_is_expanded (False)
			l_row.refresh
			from
				l_row_index := a_row.index + 2
			until
				done or l_row_index > grid.row_count
			loop
				l_cur_row ?= grid.row (l_row_index).data
				check l_cur_row /= Void end
				if not l_cur_row.is_parent then
					grid.row (l_row_index).set_height (0)
					l_row_index := l_row_index + 1
				else
					done := True
				end
			end
		end

	on_show_feature_from_any_changed is
			-- Action to be performed when selection status of `show_feature_from_any_checkbox' changes
		do
			if not is_displaying_class_any then
				is_up_to_date := False
				update_view
				preferences.class_browser_data.show_feature_from_any_preference.set_value (show_feature_from_any_checkbox.is_selected)
			end
		end

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

	on_show_feature_from_any_changed_from_outside is
			-- Action to be performed when selection status of `show_feature_from_any' changes from outside
		local
			l_displayed: BOOLEAN
		do
			if not is_displaying_class_any then
				l_displayed := preferences.class_browser_data.is_feature_from_any_shown
				if l_displayed /= show_feature_from_any_checkbox.is_selected then
					if l_displayed then
						show_feature_from_any_checkbox.enable_select
					else
						show_feature_from_any_checkbox.disable_select
					end
				end
			end
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
				if a_key.code = {EV_KEY_CONSTANTS}.key_right then
					on_expand_one_level
				elseif a_key.code = {EV_KEY_CONSTANTS}.key_left then
					on_collapse_one_level
				end
			end
		end

	on_enter_pressed is
			-- Action to be performed when enter key is pressed
		do
			on_expand_all_level
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

	on_key_pressed_in_feature_name_list (a_key: EV_KEY) is
			-- Action to be performed when key pressed in `feature_name_list'.
		local
			l_str: STRING_32
			l_feature_list: like feature_name_list
			l_exists: BOOLEAN
		do
			l_feature_list := feature_name_list
			if a_key.code = {EV_KEY_CONSTANTS}.key_enter then
				l_str := l_feature_list.text
				l_str.left_adjust
				l_str.right_adjust
				if not l_str.is_empty then
					from
						l_feature_list.start
					until
						l_feature_list.after or l_exists
					loop
						l_exists := l_feature_list.item.text.is_case_insensitive_equal (l_str)
						l_feature_list.forth
					end
					if not l_exists then
						if l_feature_list.count = 10 then
							l_feature_list.finish
							l_feature_list.remove
						end
						feature_name_list.put_front (create{EV_LIST_ITEM}.make_with_text (l_str))
					end
					is_up_to_date := False
					update_view
				end
			end
		end

	on_focus_in_feature_name_list is
			-- Action to be performed when `feature_name_list' gets focus
		do
			if not feature_name_list.text.is_empty then
				feature_name_list.select_all
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
			feature_name_list.set_text ("")
			cancel_delayed_update_matches
		end

feature{NONE} -- Sorting

	class_column: INTEGER is 1
			-- Column index for class

	feature_column: INTEGER is 2
			-- Column index for feature

	class_sorter (a_order: INTEGER) is
			-- Sorter for class name
		local
			l_sorter: DS_QUICK_SORTER [EB_CLASS_BROWSER_FLAT_ROW]
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [EB_CLASS_BROWSER_FLAT_ROW]
		do
			create l_agent_sorter.make (agent class_name_tester)
			create l_sorter.make (l_agent_sorter)
			l_sorter.sort (rows)
			if last_sorted_column /= class_column then
				expand_all_rows
			end
			bind_grid
		end

	feature_sorter (a_order: INTEGER) is
			-- Sorter for feature name
		local
			l_sorter: DS_QUICK_SORTER [EB_CLASS_BROWSER_FLAT_ROW]
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [EB_CLASS_BROWSER_FLAT_ROW]
		do
			create l_agent_sorter.make (agent feature_name_tester)
			create l_sorter.make (l_agent_sorter)
			l_sorter.sort (rows)
			expand_all_rows
			bind_grid
		end

	feature_name_tester (row_a, row_b: EB_CLASS_BROWSER_FLAT_ROW): BOOLEAN is
			-- Compare `row_a' and `row_b' ascendingly.
		require
			row_a_valid: row_a /= Void
			row_b_valid: row_b /= Void
		do
			if current_feature_sort_order = ascending_order then
				Result := row_a.e_feature.name < row_b.e_feature.name
			else
				Result := row_a.e_feature.name > row_b.e_feature.name
			end
		end

	class_name_tester (row_a, row_b: EB_CLASS_BROWSER_FLAT_ROW): BOOLEAN is
			-- Compare `row_a' and `row_b' ascendingly.
		require
			row_a_valid: row_a /= Void
			row_b_valid: row_b /= Void
		local
			l_class_a_name: STRING
			l_class_b_name: STRING
			l_order: INTEGER
			l_written_class_a: CLASS_C
			l_written_class_b: CLASS_C
		do
			l_order := current_class_sort_order
			l_written_class_a := row_a.written_class
			l_written_class_b := row_b.written_class
			l_class_a_name := l_written_class_a.name
			l_class_b_name := l_written_class_b.name
			if l_order = topology_order then
				if l_written_class_a.topological_id = l_written_class_b.topological_id then
					if current_feature_sort_order = ascending_order then
						Result := row_a.e_feature.name < row_b.e_feature.name
					else
						Result := row_a.e_feature.name > row_b.e_feature.name
					end
				else
					Result := l_written_class_a.topological_id < l_written_class_b.topological_id
				end
			elseif l_class_a_name.is_equal (l_class_b_name) then
				if current_feature_sort_order = ascending_order then
					Result := row_a.e_feature.name < row_b.e_feature.name
				else
					Result := row_a.e_feature.name > row_b.e_feature.name
				end
			else
				if l_order = ascending_order then
					Result := l_class_a_name < l_class_b_name
				else
					Result := l_class_a_name > l_class_b_name
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
		ensure
			good_result: Result = ascending_order or Result = descending_order
		end

feature -- Status report

	should_tooltip_be_displayed: BOOLEAN is
			-- Should tooltip display be vetoed?
		do
			Result := show_tooltip_checkbox.is_selected
		ensure
			good_result: Result = show_tooltip_checkbox.is_selected
		end

	is_displaying_class_any: BOOLEAN is
			-- Is class any been displayed currently?
		do
			Result := start_class /= Void and then start_class.is_compiled and then start_class.class_c.class_id = system.any_id
		end

feature -- Access

	show_feature_from_any_checkbox: EV_TOOL_BAR_TOGGLE_BUTTON is
			-- Checkbox to indicate whether or not unchanged features from ANY is displayed
		do
			if show_feature_from_any_checkbox_internal = Void then
				create show_feature_from_any_checkbox_internal
				show_feature_from_any_checkbox_internal.set_tooltip (interface_names.h_show_feature_from_any)
				show_feature_from_any_checkbox_internal.set_pixmap (pixmaps.icon_pixmaps.feature_routine_icon)
				if preferences.class_browser_data.is_feature_from_any_shown then
					show_feature_from_any_checkbox_internal.enable_select
				else
					show_feature_from_any_checkbox_internal.disable_select
				end
			end
			Result := show_feature_from_any_checkbox_internal
		ensure
			result_attached: Result /= Void
		end

	grid_selected_items: DS_ARRAYED_LIST [EVS_GRID_COORDINATED] is
			-- Selected items in `grid'.
			-- Returned list is unsorted so no particular ordering is guaranteed.			
		local
			l_selected: ARRAYED_LIST [EV_GRID_ITEM]
			l_item: EV_GRID_ITEM
			l_row: EB_CLASS_BROWSER_FLAT_ROW
		do
			l_selected := grid.selected_items
			if l_selected.is_empty then
				create Result.make (0)
			else
				create Result.make (l_selected.count)
				from
					l_selected.start
				until
					l_selected.after
				loop
					l_item := l_selected.item
					l_row ?= l_item.row.data
					if l_row /= Void then
						Result.force_last (create {EVS_EMPTY_COORDINATED_ITEM}.make (l_item.column.index, l_item.row.index))
					end
					l_selected.forth
				end
			end
		end

	control_bar: EV_WIDGET is
			-- Widget of a control bar through which, certain control can be performed upon current view
		local
			l_tool_bar: EV_TOOL_BAR
			l_tool_bar2: EV_TOOL_BAR
			l_label: EV_LABEL
			l_tool_bar3: EV_TOOL_BAR
		do
			if control_tool_bar = Void then
				create control_tool_bar
				create l_tool_bar
				create l_tool_bar3
				l_tool_bar.extend (create{EV_TOOL_BAR_SEPARATOR})
				l_tool_bar.extend (show_tooltip_checkbox)
				l_tool_bar.extend (show_feature_from_any_checkbox)
				control_tool_bar.set_padding (2)
				control_tool_bar.extend (l_tool_bar)
				control_tool_bar.disable_item_expand (l_tool_bar)
				create l_tool_bar2
				l_tool_bar2.extend (create{EV_TOOL_BAR_SEPARATOR})
				control_tool_bar.extend (l_tool_bar2)
				control_tool_bar.disable_item_expand (l_tool_bar2)
				create l_label.make_with_text (interface_names.l_filter)
				control_tool_bar.extend (l_label)
				control_tool_bar.disable_item_expand (l_label)
				feature_name_list.set_minimum_width (150)
				control_tool_bar.extend (feature_name_list)
				control_tool_bar.disable_item_expand (feature_name_list)
			end
			Result := control_tool_bar
		ensure then
			result_attached: Result /= Void
		end

	feature_name_list: EV_COMBO_BOX is
			-- List to contain feature name filter
		do
			if feature_name_list_internal = Void then
				create feature_name_list_internal
				feature_name_list_internal.change_actions.extend (agent request_update_matches)
				feature_name_list_internal.key_press_actions.extend (agent on_key_pressed_in_feature_name_list)
				feature_name_list_internal.focus_in_actions.extend (agent on_focus_in_feature_name_list)
			end
			Result := feature_name_list_internal
		ensure
			result_attached: Result /= Void
		end

	data: QL_FEATURE_DOMAIN
			-- Data to be displayed

	rows: DS_ARRAYED_LIST [EB_CLASS_BROWSER_FLAT_ROW]
			-- Rows for features that are to be displayed

feature{NONE} -- Update

	update_view is
			-- Update current view according to change in `model'.
		local
			l_msg: STRING
		do
			if not is_up_to_date then
				if data /= Void then
					if is_displaying_class_any then
						show_feature_from_any_checkbox.enable_select
						show_feature_from_any_checkbox.disable_sensitive
					else
						show_feature_from_any_checkbox.enable_sensitive
					end
					text.hide
					component_widget.show
					fill_rows
					if last_sorted_column = 0 then
						expand_all_rows
						last_sorted_column := class_column
					end
					disable_auto_sort_order_change
					sort (0, 0, 1, 0, 0, 0, 0, 0, feature_column)
					bind_grid
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

	bind_grid is
			-- Bind `features' in `grid'.
		local
			l_color: EV_COLOR
			l_feature: EB_CLASS_BROWSER_FLAT_ROW
			l_height: INTEGER
			l_rows: like rows
			l_odd_line_color: EV_COLOR
			l_even_line_color: EV_COLOR

		do
			build_row_relation
			l_odd_line_color := odd_line_color
			l_even_line_color := even_line_color
			if grid.row_count > 0 then
				grid.remove_rows (1, grid.row_count)
			end
			grid.row_expand_actions.wipe_out
			grid.row_collapse_actions.wipe_out
			l_color := l_odd_line_color
			l_height := line_height
			from
				l_rows := rows
				l_rows.start
			until
				l_rows.after
			loop
				l_feature := l_rows.item_for_iteration
				if l_feature.is_parent then
					if l_color = l_odd_line_color then
						l_color := l_even_line_color
					else
						l_color := l_odd_line_color
					end
				end
				l_feature.bind_row (grid, l_color, l_height)
				l_rows.forth
			end
			if grid.row_count > 0 then
				grid.column (2).resize_to_content
			end
			grid.row_expand_actions.force_extend (agent on_row_expanded)
			grid.row_collapse_actions.force_extend (agent on_row_collapsed)
		end

	auto_resize is
			-- Auto resize columns to give a best view point.
		local
			l_requested_width: INTEGER
		do
			if grid.row_count > 0 then
				l_requested_width := grid.column (1).required_width_of_item_span (1, grid.row_count)
				if l_requested_width > 300 then
					l_requested_width := 300
				else
					l_requested_width := l_requested_width + 10
				end
				grid.column (1).set_width (l_requested_width)
			end
		end

	ensure_visible (a_item: EVS_GRID_SEARCHABLE_ITEM; a_selected: BOOLEAN) is
			-- Ensure `a_item' is visible in viewable area of `grid'.
			-- If `a_selected' is True, make sure that `a_item' is in its selected status.			
		local
			l_compiler_item: EB_GRID_COMPILER_ITEM
			l_item: EV_GRID_ITEM
			l_row: EB_CLASS_BROWSER_FLAT_ROW
			l_grid_row: EV_GRID_ROW
		do
			grid.remove_selection
			l_compiler_item ?= a_item
			if l_compiler_item /= Void then
				l_row ?= l_compiler_item.row.data
				if not l_row.parent.is_expanded then
					if l_row.parent.grid_row.is_expandable then
						l_row.parent.grid_row.expand
					end
				end
				if l_row /= Void then
					l_grid_row := l_row.grid_row
					l_grid_row.ensure_visible
					l_item ?= a_item
					if l_item /= Void and then l_item.is_parented then
						l_item.ensure_visible
						if a_selected then
							l_item.enable_select
						end
					end
				end
			end
		end

feature{NONE} -- Initialization

	build_grid is
			-- Build `grid'.
		do
			create grid
			grid.set_column_count_to (2)
			grid.enable_selection_on_single_button_click
			grid.header.i_th (1).set_text (interface_names.l_version_from)
			grid.header.i_th (2).set_text (interface_names.l_class_browser_features)
			grid.enable_tree
			grid.disable_row_height_fixed
			grid.pick_ended_actions.force_extend (agent on_pick_ended)
			grid.set_item_pebble_function (agent on_pick)
			grid.enable_multiple_item_selection
			grid.row_expand_actions.force_extend (agent on_row_expanded)
			grid.row_collapse_actions.force_extend (agent on_row_collapsed)
			if drop_actions /= Void then
				grid.drop_actions.fill (drop_actions)
			end
			create filter_engine.make
			filter_engine.set_empty_allowed (False)
			filter_engine.set_multiline (False)
			filter_engine.set_caseless (True)
			grid.key_press_actions.extend (agent on_key_pressed)
			show_feature_from_any_checkbox.select_actions.extend (agent on_show_feature_from_any_changed)
			show_tooltip_checkbox.select_actions.extend (agent on_show_tooltip_changed)

			on_show_tooltip_changed_from_outside_agent := agent on_show_tooltip_changed_from_outside
			on_show_feature_from_any_changed_from_outside_agent := agent on_show_feature_from_any_changed_from_outside
			preferences.class_browser_data.show_tooltip_preference.change_actions.extend (on_show_tooltip_changed_from_outside_agent)
			preferences.class_browser_data.show_feature_from_any_preference.change_actions.extend (on_show_feature_from_any_changed_from_outside_agent)
		end

	build_sortable_and_searchable is
			-- Build facilities to support sort and search
		local
			l_class_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO
			l_feature_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO
		do
			old_make (grid)
				-- Prepare sort facilities
			last_sorted_column := 0
			create l_class_sort_info.make (grid.column (1), agent class_sorter, ascending_order)
			create l_feature_sort_info.make (grid.column (2), agent feature_sorter, ascending_order)
			l_class_sort_info.enable_auto_indicator
			l_feature_sort_info.enable_auto_indicator
			set_sort_info (l_class_sort_info, 1)
			set_sort_info (l_feature_sort_info, 2)

				-- Prepare search facilities
			create quick_search_bar.make (development_window)
			quick_search_bar.attach_tool (Current)
			enable_search
		end

feature{NONE} -- Implementation/Data

	control_tool_bar: EV_HORIZONTAL_BOX
			-- Tool bar of current view

	show_feature_from_any_checkbox_internal: like show_feature_from_any_checkbox
			-- Implementation of `show_feature_from_any_checkbox'

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
						-- If there is only one item selected				
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

feature{NONE} -- Implementation			

	filter_engine: RX_PCRE_REGULAR_EXPRESSION
			-- Filter engine used to filter features whose name is given by `feature_name_list'

	fill_rows is
			-- Fill `rows' using information from `data'.
		local
			l_feature_list: LIST [QL_FEATURE]
			l_row: EB_CLASS_BROWSER_FLAT_ROW
			l_feature: QL_FEATURE
			l_any_class_id: INTEGER
			l_feature_from_any_displayed: BOOLEAN
			l_filter_used: BOOLEAN
			l_filter_name: STRING
			l_filter: like filter_engine
			l_ok: BOOLEAN
		do
			l_feature_list := data
			if rows = Void then
				create rows.make (l_feature_list.count)
			else
				rows.wipe_out
			end
			l_any_class_id := system.any_id
			l_feature_from_any_displayed := show_feature_from_any_checkbox.is_selected or is_displaying_class_any
			l_filter_name := feature_name_list.text
			l_filter_name.left_adjust
			l_filter_name.right_adjust
			if not l_filter_name.is_empty then
				l_filter_used := True
				l_filter := filter_engine
				l_filter.compile (l_filter_name)
			end
			from
				l_feature_list.start
			until
				l_feature_list.after
			loop
				l_feature := l_feature_list.item
				if l_feature_from_any_displayed or else (l_feature.written_class.class_id /= l_any_class_id) then
					if l_filter_used then
						l_filter.match (l_feature.name)
						if l_filter.has_matched then
							l_ok := True
						end
					else
						l_ok := True
					end
					if l_ok then
						create l_row.make (l_feature_list.item, Current)
						l_row.set_is_expanded (True)
						rows.force_last (l_row)
					end
				end
				l_feature_list.forth
				l_ok := False
			end
		end

	build_row_relation is
			-- Build relation between rows
		require
			data_attached: rows /= Void
		local
			l_rows: like rows
			l_parent_row: EB_CLASS_BROWSER_FLAT_ROW
			l_cur_row: EB_CLASS_BROWSER_FLAT_ROW
			l_children_count: INTEGER
		do
			l_rows := rows
			from
				l_rows.start
			until
				l_rows.after
			loop
				l_cur_row := l_rows.item_for_iteration
				if l_parent_row = Void or else l_parent_row.written_class.class_id /= l_cur_row.written_class.class_id then
					if l_parent_row /= Void then
						l_parent_row.set_children_count (l_children_count)
					end
					l_cur_row.set_parent (l_cur_row)
					l_cur_row.set_children_count (0)
					l_parent_row := l_cur_row
					l_children_count := 0
				else
					l_cur_row.set_parent (l_parent_row)
					l_children_count := l_children_count + 1
				end
				l_rows.forth
			end
			if l_children_count > 0 and then l_parent_row /= Void then
				l_parent_row.set_children_count (l_children_count)
			end
		end

	expand_all_rows is
			-- Set `is_expanded' flag of every row to True.
		local
			l_rows: like rows
		do
			from
				l_rows := rows
				l_rows.start
			until
				l_rows.after
			loop
				l_rows.item_for_iteration.set_is_expanded (True)
				l_rows.forth
			end
		end

	expand_item (a_item: EV_GRID_ITEM) is
			-- Expand `a_item'.
		require
			a_item_attached: a_item /= Void
			a_item_is_parented: a_item.is_parented
		local
			l_row: EB_CLASS_BROWSER_FLAT_ROW
		do
			if a_item.column.index = 1 then
				l_row ?= a_item.row.data
				if l_row /= Void and then l_row.is_parent and then not l_row.is_expanded then
					if a_item.row.is_expandable then
						a_item.row.expand
					end
				end
			end
		end

	recycle_agents is
			-- Recycle agents
		do
			Precursor {EB_CLASS_BROWSER_GRID_VIEW}
			if on_show_tooltip_changed_from_outside_agent /= Void then
				preferences.class_browser_data.show_tooltip_preference.change_actions.prune_all (on_show_tooltip_changed_from_outside_agent)
			end
			if on_show_feature_from_any_changed_from_outside_agent /= Void then
				preferences.class_browser_data.show_feature_from_any_preference.change_actions.prune_all (on_show_feature_from_any_changed_from_outside_agent)
			end
		end

	collapse_item (a_item: EV_GRID_ITEM) is
			-- Expand `a_item'.
		require
			a_item_attached: a_item /= Void
			a_item_is_parented: a_item.is_parented
		local
			l_row: EB_CLASS_BROWSER_FLAT_ROW
		do
			if a_item.column.index = 1 then
				l_row ?= a_item.row.data
				if l_row /= Void and then l_row.is_parent and then l_row.is_expanded then
					if a_item.row.is_expandable then
						a_item.row.collapse
					end
				end
			end
		end

	feature_name_list_internal: like feature_name_list
			-- Implementation of `feature_name_list'

feature{NONE} -- Implementation

	update_matches_timeout: EV_TIMEOUT
			-- Internally used timer

	request_update_matches is
			-- Start `update_matches_timeout' and if no text change in `feature_name_list' in certain
			-- amount of time, update view.
		do
			cancel_delayed_update_matches
			if update_matches_timeout = Void then
				create update_matches_timeout
				update_matches_timeout.actions.extend_kamikaze (agent delayed_update_matches)
			end
			update_matches_timeout.set_interval (wait_to_update_view_time)
		end

	update_matches_requested: BOOLEAN is
		do
			Result := update_matches_timeout /= Void
		end

	cancel_delayed_update_matches is
		do
			if update_matches_timeout /= Void then
				update_matches_timeout.destroy
				update_matches_timeout := Void
			end
		end

	delayed_update_matches is
		do
			cancel_delayed_update_matches
			is_up_to_date := False
			update_view
		end

	on_show_tooltip_changed_from_outside_agent: PROCEDURE [ANY, TUPLE]
			-- Agent kept for recycling

	on_show_feature_from_any_changed_from_outside_agent: PROCEDURE [ANY, TUPLE]
			-- Agent kept for recycling

	wait_to_update_view_time: INTEGER is 500
			-- Time interval (in milliseconds) to wait before we update view

invariant
	development_window_attached: development_window /= Void
	filter_engine_attached: filter_engine /= Void

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
