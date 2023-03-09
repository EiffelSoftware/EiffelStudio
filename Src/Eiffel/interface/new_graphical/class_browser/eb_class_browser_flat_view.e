note
	description: "Flat view of class browser."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_FLAT_VIEW

inherit
	EB_CLASS_BROWSER_GRID_VIEW [EB_CLASS_BROWSER_FLAT_ROW]
		redefine
			make,
			grid_selected_items,
			data,
			recycle_agents,
			default_ensure_visible_action,
			starting_element,
			update_view
		end

	EVS_GRID_TWO_WAY_SORTING_ORDER

	SHARED_WORKBENCH

create
	make

feature{NONE} -- Creation

	make (a_dev_window: like development_window)
			-- Initialize.
		do
			create filter.make (agent is_selected)
			create wild_matcher.make_empty
			Precursor (a_dev_window)
		end

feature -- Actions

	on_row_expanded (a_row: EV_GRID_ROW)
			-- Action performed when `a_row' is expanded
		local
			l_height: INTEGER
			l_row_index: INTEGER
			done: BOOLEAN
		do
			if attached {EB_CLASS_BROWSER_FLAT_ROW} a_row.data as l_row then
				l_row.set_is_expanded (True)
				l_row.refresh
				l_height := default_row_height
				from
					l_row_index := a_row.index + 2
				until
					done or l_row_index > grid.row_count
				loop
					if attached {EB_CLASS_BROWSER_FLAT_ROW} grid.row (l_row_index).data as l_cur_row then
						if l_cur_row.is_parent then
							done := True
						else
							grid.row (l_row_index).set_height (l_height)
							l_row_index := l_row_index + 1
						end
					end
				end
			end
		end

	on_row_collapsed (a_row: EV_GRID_ROW)
			-- Action performed when `a_row' is collapsed
		local
			l_row_index: INTEGER
			done: BOOLEAN
		do
			if attached {EB_CLASS_BROWSER_FLAT_ROW} a_row.data as l_row then
				l_row.set_is_expanded (False)
				l_row.refresh
				from
					l_row_index := a_row.index + 2
				until
					done or l_row_index > grid.row_count
				loop
					if attached {EB_CLASS_BROWSER_FLAT_ROW} grid.row (l_row_index).data as l_cur_row then
						if l_cur_row.is_parent then
							done := True
						else
							grid.row (l_row_index).set_height (0)
							l_row_index := l_row_index + 1
						end
					end
				end
			end
		end

	on_show_feature_from_any_changed
			-- Action to be performed when selection status of `show_feature_from_any_button' changes
		do
			if not is_displaying_class_any then
				is_up_to_date := False
				update_view
			end
		end

	on_key_pressed (a_key: EV_KEY)
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

	on_key_pressed_in_feature_name_list (a_key: EV_KEY)
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

	on_focus_in_feature_name_list
			-- Action to be performed when `feature_name_list' gets focus
		do
			if not feature_name_list.text.is_empty then
				feature_name_list.select_all
			end
		end

	on_expand_all_level
			-- Action to be performed to recursively expand all selected rows.
		do
			do_all_in_items (grid.selected_items, agent expand_item)
		end

	on_collapse_all_level
			-- Action to be performed to recursively collapse all selected rows.
		do
			do_all_in_items (grid.selected_items, agent collapse_item)
		end

	on_expand_one_level
			-- Action to be performed to expand all selected rows.
		do
			do_all_in_items (grid.selected_items, agent expand_item)
		end

	on_collapse_one_level
			-- Action to be performed to collapse all selected rows.
		do
			do_all_in_items (grid.selected_items, agent collapse_item)
		end

feature{NONE} -- Sorting

	class_column: INTEGER = 1
			-- Column index for class

	feature_column: INTEGER = 2
			-- Column index for feature

	sort_agent (a_column_list: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [EB_CLASS_BROWSER_FLAT_ROW])
			-- Action to be performed when sort `a_column_list' using `a_comparator'.
		require
			a_column_list_attached: a_column_list /= Void
			not_a_column_list_is_empty:
		do
			;(create {QUICK_SORTER [EB_CLASS_BROWSER_FLAT_ROW]}.make (a_comparator)).sort (rows)
			expand_all_rows
			bind_grid
		end

	feature_name_tester (row_a, row_b: EB_CLASS_BROWSER_FLAT_ROW; a_order: INTEGER): BOOLEAN
			-- Compare `row_a' and `row_b' ascendingly.
		require
			row_a_valid: row_a /= Void
			row_b_valid: row_b /= Void
		do
			if a_order = ascending_order then
				Result := row_a.e_feature.name_32 < row_b.e_feature.name_32
			else
				Result := row_a.e_feature.name_32 > row_b.e_feature.name_32
			end
		end

	class_name_tester (row_a, row_b: EB_CLASS_BROWSER_FLAT_ROW; a_order: INTEGER): BOOLEAN
			-- Compare `row_a' and `row_b' ascendingly.
		require
			row_a_valid: row_a /= Void
			row_b_valid: row_b /= Void
		local
			l_class_a_name: STRING
			l_class_b_name: STRING
			l_written_class_a: CLASS_C
			l_written_class_b: CLASS_C
		do
			l_written_class_a := row_a.written_class
			l_written_class_b := row_b.written_class
			l_class_a_name := l_written_class_a.name
			l_class_b_name := l_written_class_b.name
			if a_order = topology_order then
				Result := l_written_class_a.topological_id < l_written_class_b.topological_id
			else
				if a_order = ascending_order then
					Result := l_class_a_name < l_class_b_name
				else
					Result := l_class_a_name > l_class_b_name
				end
			end
		end

feature -- Status report

	should_tooltip_be_displayed: BOOLEAN
			-- Should tooltip display be vetoed?
		do
			Result := show_tooltip_button.is_selected
		ensure then
			good_result: Result = show_tooltip_button.is_selected
		end

	is_displaying_class_any: BOOLEAN
			-- Is class any been displayed currently?
		do
			Result := starting_element /= Void and then starting_element.is_compiled and then starting_element.class_c.class_id = system.any_id
		end

feature -- Access

	show_feature_from_any_button: EB_PREFERENCED_SD_TOOL_BAR_TOGGLE_BUTTON
			-- Checkbox to indicate whether or not unchanged features from ANY is displayed
		do
			if show_feature_from_any_button_internal = Void then
				create show_feature_from_any_button_internal.make (preferences.class_browser_data.show_feature_from_any_preference)
				show_feature_from_any_button_internal.set_pixmap (pixmaps.icon_pixmaps.command_show_features_of_any_icon)
				show_feature_from_any_button_internal.set_tooltip (interface_names.h_show_feature_from_any)
				show_feature_from_any_button_internal.select_actions.extend (agent on_show_feature_from_any_changed)
			end
			Result := show_feature_from_any_button_internal
		ensure
			result_attached: Result /= Void
		end

	grid_selected_items: ARRAYED_LIST [EVS_GRID_COORDINATED]
			-- Selected items in `grid'.
			-- Returned list is unsorted so no particular ordering is guaranteed.			
		local
			l_selected: ARRAYED_LIST [EV_GRID_ITEM]
			l_item: EV_GRID_ITEM
		do
			l_selected := grid.selected_items
			create Result.make (l_selected.count)
			across
				l_selected as s
			loop
				l_item := s.item
				if attached {EB_CLASS_BROWSER_FLAT_ROW} l_item.row.data as l_row then
					Result.force (create {EVS_EMPTY_COORDINATED_ITEM}.make (l_item.column.index, l_item.row.index))
				end
			end
		end

	control_bar: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Widget of a control bar through which, certain control can be performed upon current view
		local
			l_label: EV_LABEL
			l_box: EV_HORIZONTAL_BOX
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			if control_tool_bar = Void then
				create control_tool_bar.make (5)
				control_tool_bar.extend (create{SD_TOOL_BAR_SEPARATOR}.make)
				control_tool_bar.extend (show_feature_from_any_button)
				control_tool_bar.extend (show_tooltip_button)

				control_tool_bar.extend (create{SD_TOOL_BAR_SEPARATOR}.make)

				create l_label.make_with_text (interface_names.l_filter)
				create l_box
				l_box.extend (l_label)
				l_box.set_border_width ((create {EV_LAYOUT_CONSTANTS}).small_border_size)
				create l_widget_item.make (l_box)
				control_tool_bar.extend (l_widget_item)

				feature_name_list.set_minimum_width (100)
				create l_widget_item.make (feature_name_list)
				control_tool_bar.extend (l_widget_item)
			end
			Result := control_tool_bar
		ensure then
			result_attached: Result /= Void
		end

	feature_name_list: EV_COMBO_BOX
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

	rows: ARRAYED_LIST [EB_CLASS_BROWSER_FLAT_ROW]
			-- Rows for features that are to be displayed

	starting_element: QL_CLASS
			-- Starting element as root of the tree displayed in current browser.
			-- This is used when a tree view is to be built. And starting element serves as the root of that tree.
			-- If `starting_element' is Void, don't build tree.			

feature{NONE} -- Update

	update_view
			-- Update current view according to change in `model'.
		do
			cancel_delayed_update_matches
			Precursor
		end

	provide_result
			-- Provide result displayed in Current view.
		do
			if is_displaying_class_any then
				show_feature_from_any_button.enable_select
				show_feature_from_any_button.disable_sensitive
			else
				show_feature_from_any_button.enable_sensitive
			end
			fill_rows
			if last_sorted_column_internal = 0 then
				expand_all_rows
				last_sorted_column_internal := class_column
			end
			disable_auto_sort_order_change
			enable_force_multi_column_sorting
			if not sorted_columns.is_empty then
				sort (0, 0, 1, 0, 0, 0, 0, 0, sorted_columns.last)
			else
				sort (0, 0, 1, 0, 0, 0, 0, 0, feature_column)
			end
			disable_force_multi_column_sorting
			bind_grid
			enable_auto_sort_order_change
			try_auto_resize_grid (<<[150, 300, 1]>>, False)
		end

	bind_grid
			-- Bind `features' in `grid'.
		local
			l_color: EV_COLOR
			l_feature: EB_CLASS_BROWSER_FLAT_ROW
			l_height: INTEGER
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
			l_height := default_row_height
			across
				rows as r
			loop
				l_feature := r.item
				if l_feature.is_parent then
					if l_color = l_odd_line_color then
						l_color := l_even_line_color
					else
						l_color := l_odd_line_color
					end
				end
				l_feature.bind_row (grid, l_color, l_height)
			end
			if grid.row_count > 0 then
				grid.column (2).resize_to_content
			end
			grid.row_expand_actions.extend (agent on_row_expanded)
			grid.row_collapse_actions.extend (agent on_row_collapsed)
		end

	default_ensure_visible_action (a_item: EVS_GRID_SEARCHABLE_ITEM; a_selected: BOOLEAN)
			-- Ensure that `a_item' is visible.
			-- If `a_selected' is True, make sure that `a_item' is in its selected status.
		do
			grid.remove_selection
			if
				attached {EB_GRID_EDITOR_TOKEN_ITEM} a_item as l_compiler_item and then
				attached {EB_CLASS_BROWSER_FLAT_ROW} l_compiler_item.row.data as l_row
			then
				if
					not l_row.parent.is_expanded and then
					l_row.parent.grid_row.is_expandable
				then
					l_row.parent.grid_row.expand
				end
				l_row.grid_row.ensure_visible
				if attached {EV_GRID_ITEM} a_item as l_item and then l_item.is_parented then
					l_item.ensure_visible
					if a_selected then
						l_item.enable_select
					end
				end
			end
		end

feature{NONE} -- Initialization

	build_grid
			-- Build `grid'.
		do
			create grid
			grid.set_column_count_to (2)
			grid.enable_selection_on_single_button_click
			grid.header.i_th (1).set_text (interface_names.l_version_from)
			grid.header.i_th (2).set_text (interface_names.l_class_browser_features)
			grid.enable_tree
			grid.disable_row_height_fixed
			grid.enable_multiple_item_selection
			grid.row_expand_actions.extend (agent on_row_expanded)
			grid.row_collapse_actions.extend (agent on_row_collapsed)
			enable_ctrl_right_click_to_open_new_window
			grid.key_press_actions.extend (agent on_key_pressed)
			enable_grid_item_pnd_support
		end

	build_sortable_and_searchable
			-- Build facilities to support sort and search
		local
			l_class_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO [EB_CLASS_BROWSER_FLAT_ROW]
			l_feature_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO [EB_CLASS_BROWSER_FLAT_ROW]
		do
			old_make (grid)
				-- Prepare sort facilities
			last_sorted_column_internal := 0
			create l_class_sort_info.make (agent class_name_tester, ascending_order)
			create l_feature_sort_info.make (agent feature_name_tester, ascending_order)
			set_sort_action (agent sort_agent)
			l_class_sort_info.enable_auto_indicator
			l_feature_sort_info.enable_auto_indicator
			set_sort_info (1, l_class_sort_info)
			set_sort_info (2, l_feature_sort_info)

				-- Prepare search facilities
			create quick_search_bar.make (development_window)
			quick_search_bar.attach_tool (Current)
			enable_search
		end

feature{NONE} -- Implementation/Data

	control_tool_bar: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Tool bar of current view

	show_feature_from_any_button_internal: like show_feature_from_any_button
			-- Implementation of `show_feature_from_any_button'

feature{NONE} -- Drawing			

	fill_rows
			-- Fill `rows' using information from `data'.
		local
			l_feature_list: LIST [QL_FEATURE]
			l_row: EB_CLASS_BROWSER_FLAT_ROW
			l_feature: QL_FEATURE
			l_any_class_id: INTEGER
			l_feature_from_any_displayed: BOOLEAN
			l_filter_used: BOOLEAN
			l_filter_name: STRING_32
			l_filter: like filter
		do
			l_feature_list := data
			if rows = Void then
				create rows.make (l_feature_list.count)
			else
				rows.wipe_out
			end
			l_any_class_id := system.any_id
			l_feature_from_any_displayed := show_feature_from_any_button.is_selected or is_displaying_class_any
			l_filter_name := feature_name_list.text
			l_filter_name.left_adjust
			l_filter_name.right_adjust
			l_filter_used := not l_filter_name.is_empty
			if l_filter_used then
				wild_matcher.set_pattern (l_filter_name)
				l_filter := filter
			end
			across
				l_feature_list as f
			loop
				l_feature := f.item
				if
					(l_feature_from_any_displayed or else l_feature.written_class.class_id /= l_any_class_id) and then
					(l_filter_used implies l_filter.is_selected (l_feature, Void, Current))
				then
					create l_row.make (l_feature, Current)
					l_row.set_is_expanded (True)
					rows.force (l_row)
				end
			end
		end

	build_row_relation
			-- Build relation between rows
		require
			data_attached: rows /= Void
		local
			l_parent_row: EB_CLASS_BROWSER_FLAT_ROW
			l_cur_row: EB_CLASS_BROWSER_FLAT_ROW
			l_children_count: INTEGER
		do
			across
				rows as r
			loop
				l_cur_row := r.item
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
			end
			if l_children_count > 0 and then l_parent_row /= Void then
				l_parent_row.set_children_count (l_children_count)
			end
		end

	expand_all_rows
			-- Set `is_expanded' flag of every row to True.
		do
			across
				rows as r
			loop
				r.item.set_is_expanded (True)
			end
		end

	expand_item (a_item: EV_GRID_ITEM)
			-- Expand `a_item'.
		require
			a_item_attached: a_item /= Void
			a_item_is_parented: a_item.is_parented
		do
			if
				a_item.column.index = 1 and then
				attached {EB_CLASS_BROWSER_FLAT_ROW} a_item.row.data as l_row and then
				l_row.is_parent and then
				not l_row.is_expanded and then
				a_item.row.is_expandable
			then
				a_item.row.expand
			end
		end

	recycle_agents
			-- Recycle agents
		do
			if show_feature_from_any_button_internal /= Void then
				show_feature_from_any_button.recycle
			end
			Precursor {EB_CLASS_BROWSER_GRID_VIEW}
		end

	collapse_item (a_item: EV_GRID_ITEM)
			-- Expand `a_item'.
		require
			a_item_attached: a_item /= Void
			a_item_is_parented: a_item.is_parented
		do
			if
				a_item.column.index = 1 and then
				attached {EB_CLASS_BROWSER_FLAT_ROW} a_item.row.data as l_row and then
				l_row.is_parent and then
				l_row.is_expanded and then
				a_item.row.is_expandable
			then
				a_item.row.collapse
			end
		end

	feature_name_list_internal: like feature_name_list
			-- Implementation of `feature_name_list'

feature{NONE} -- Timeout

	update_matches_timeout: EV_TIMEOUT
			-- Internally used timer

	request_update_matches
			-- Start `update_matches_timeout' and if no text change in `feature_name_list' in certain
			-- amount of time, update view.
		do
			delayed_timeout.request_call
		end

	delayed_timeout: ES_DELAYED_ACTION
			-- Delayed timeout
		do
			if delayed_timeout_internal = Void then
				create delayed_timeout_internal.make (agent delayed_update_matches, wait_to_update_view_time)
			end
			Result := delayed_timeout_internal
		ensure
			result_attached: Result /= Void
		end

	delayed_timeout_internal: like delayed_timeout
			-- Implementation of `delayed_timeout'

	cancel_delayed_update_matches
		do
			delayed_timeout.cancel_request
		end

	delayed_update_matches
		do
			cancel_delayed_update_matches
			is_up_to_date := False
			update_view
		end

	wait_to_update_view_time: INTEGER = 500
			-- Time interval (in milliseconds) to wait before we update view

feature{NONE} -- Implementation/Stone

	item_to_put_in_editor: EV_GRID_ITEM
			-- Grid item which may contain a stone to put into editor
			-- Void if no satisfied item is found.			
		do
			Result := item_to_put_in_editor_for_single_item_grid
		end

feature{NONE} -- Filter

	filter: EB_CLASS_BROWSER_AGENT_FILTER [QL_FEATURE]
			-- Filter used in Current view

	wild_matcher: KMP_WILD
			-- Wildcard matcher

	is_selected (a_feature: QL_FEATURE; a_context: EB_CLASS_BROWSER_FILTER_CONTEXT [QL_FEATURE]; a_viewer: like Current): BOOLEAN
			-- Will `a_feature' be filtered out?
		local
			l_wild_matcher: like wild_matcher
		do
			if a_feature /= Void then
				l_wild_matcher := wild_matcher
				l_wild_matcher.set_text (a_feature.name)
				Result := l_wild_matcher.pattern_matches
			end
		end

invariant
	filter_attached: filter /= Void
	wild_matcher_attached: wild_matcher /= Void

note
        copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
