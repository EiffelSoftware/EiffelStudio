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
			data

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
			is_up_to_date := False
			update_view
			preferences.class_browser_data.show_feature_from_any_preference.set_value (show_feature_from_any_checkbox.is_selected)
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
			l_displayed := preferences.class_browser_data.is_feature_from_any_shown
			if l_displayed /= show_feature_from_any_checkbox.is_selected then
				if l_displayed then
					show_feature_from_any_checkbox.enable_select
				else
					show_feature_from_any_checkbox.disable_select
				end
			end
		end

	on_color_or_font_changed is
			-- Action performed when color or font used to display editor tokens changes
		do
			if grid.is_displayed then
				fill_features (data, show_feature_from_any_checkbox.is_selected)
				build_row_relation
				bind_grid
			else
				text.set_background_color (editor_preferences.normal_background_color)
				text.set_foreground_color (editor_preferences.normal_text_color)
				text.set_font (font)
				text.refresh_now
			end
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
			build_row_relation
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
			if last_sorted_column /= feature_column then
				expand_all_rows
			end
			build_row_relation
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

feature -- Access

	show_feature_from_any_checkbox: EV_CHECK_BUTTON is
			-- Checkbox to indicate whether or not unchanged features from ANY is displayed
		do
			if show_feature_from_any_checkbox_internal = Void then
				create show_feature_from_any_checkbox_internal.make_with_text (interface_names.l_show_feature_from_any)
				show_feature_from_any_checkbox_internal.set_tooltip (interface_names.h_show_feature_from_any)
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

	show_tooltip_checkbox: EV_CHECK_BUTTON is
			-- Checkbox to indicate whether or not tooltip is displayed
		do
			if show_tooltip_checkbox_internal = Void then
				create show_tooltip_checkbox_internal.make_with_text (interface_names.l_show_tooltip)
				show_tooltip_checkbox_internal.set_tooltip (interface_names.h_show_tooltip)
				if preferences.class_browser_data.is_tooltip_shown then
					show_tooltip_checkbox_internal.enable_select
				else
					show_tooltip_checkbox_internal.disable_select
				end
			end
			Result := show_tooltip_checkbox_internal
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
		do
			if control_tool_bar = Void then
				create control_tool_bar
				create l_tool_bar
				l_tool_bar.extend (create{EV_TOOL_BAR_SEPARATOR})
				control_tool_bar.set_padding (2)
				control_tool_bar.extend (l_tool_bar)
				control_tool_bar.disable_item_expand (l_tool_bar)
				control_tool_bar.extend (show_feature_from_any_checkbox)
				control_tool_bar.disable_item_expand (show_feature_from_any_checkbox)
				control_tool_bar.extend (show_tooltip_checkbox)
				control_tool_bar.disable_item_expand (show_tooltip_checkbox)
			end
			Result := control_tool_bar
		ensure then
			result_attached: Result /= Void
		end

	data: QL_FEATURE_DOMAIN
			-- Data to be displayed

	rows: DS_ARRAYED_LIST [EB_CLASS_BROWSER_FLAT_ROW]
			-- Rows for features that are to be displayed

feature{NONE} -- Update

	update_view is
			-- Update current view according to change in `model'.
		do
			if not is_up_to_date then
				if data /= Void then
					text.hide
					component_widget.show
					fill_features (data, show_feature_from_any_checkbox.is_selected)
					if last_sorted_column = 0 then
						expand_all_rows
						last_sorted_column := class_column
					end
					disable_auto_sort_order_change
					sort (0, 0, 0, 0, 0, 0, 0, 0, feature_column)
					enable_auto_sort_order_change
				else
					component_widget.hide
					text.show
					text.set_text (Warning_messages.w_Formatter_failed)
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
			l_odd_line_color := preferences.class_browser_data.odd_row_background_color
			l_even_line_color := preferences.class_browser_data.even_row_background_color
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
			grid.header.i_th (1).set_text (interface_names.l_class_browser_classes)
			grid.header.i_th (2).set_text (interface_names.l_class_browser_features)
			grid.enable_tree
			grid.disable_row_height_fixed
			grid.pick_ended_actions.force_extend (agent on_pick_ended)
			grid.set_item_pebble_function (agent on_pick)

			grid.row_expand_actions.force_extend (agent on_row_expanded)
			grid.row_collapse_actions.force_extend (agent on_row_collapsed)
			if drop_actions /= Void then
				grid.drop_actions.fill (drop_actions)
			end
			show_feature_from_any_checkbox.select_actions.extend (agent on_show_feature_from_any_changed)
			show_tooltip_checkbox.select_actions.extend (agent on_show_tooltip_changed)
			preferences.class_browser_data.show_tooltip_preference.change_actions.extend (agent on_show_tooltip_changed_from_outside)
			preferences.class_browser_data.show_feature_from_any_preference.change_actions.extend (agent on_show_feature_from_any_changed_from_outside)
		end

	build_sortable_and_searchable is
			-- Build facilities to support sort and search
		local
			l_class_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO
			l_feature_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO
			l_quick_search_bar: EB_GRID_QUICK_SEARCH_TOOL
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
			create l_quick_search_bar.make (development_window)
			l_quick_search_bar.attach_tool (Current)
			enable_search
		end

feature{NONE} -- Implementation/Data

	control_tool_bar: EV_HORIZONTAL_BOX
			-- Tool bar of current view

	show_feature_from_any_checkbox_internal: like show_feature_from_any_checkbox
			-- Implementation of `show_feature_from_any_checkbox'

	show_tooltip_checkbox_internal: like show_tooltip_checkbox
			-- Implementation of `show_tooltip_checkbox'

feature{NONE} -- Implementation			

	fill_features (a_data: QL_FEATURE_DOMAIN; a_feature_from_any_displayed: BOOLEAN) is
			-- Fill `rows' with `a_data'.
			-- If `a_feature_from_any_displayed' is True, display unchanged features from class {ANY}.
		require
			a_data_not_void: a_data /= Void
		local
			l_feature_list: LIST [QL_FEATURE]
			l_row: EB_CLASS_BROWSER_FLAT_ROW
			l_feature: QL_FEATURE
			l_any_class_id: INTEGER
		do
			l_feature_list := data.content
			if rows = Void then
				create rows.make (l_feature_list.count)
			else
				rows.wipe_out
			end
			l_any_class_id := system.any_id
			from
				l_feature_list.start
			until
				l_feature_list.after
			loop
				l_feature := l_feature_list.item
				if a_feature_from_any_displayed or else (l_feature.written_class.class_id /= l_any_class_id) then
					create l_row.make (l_feature_list.item, Current)
					l_row.set_is_expanded (True)
					rows.force_last (l_row)
				end
				l_feature_list.forth
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

invariant
	development_window_attached: development_window /= Void

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
