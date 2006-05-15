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
			data
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
				set_sort_info (l_written_class_sort_info, 3)
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
				control_tool_bar.set_padding (2)
				control_tool_bar.extend (l_tool_bar)
				control_tool_bar.disable_item_expand (l_tool_bar)
				control_tool_bar.extend (show_tooltip_checkbox)
				control_tool_bar.disable_item_expand (show_tooltip_checkbox)
			end
			Result := control_tool_bar
		ensure then
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
							l_branch_row.set_item (1, create{EV_GRID_LABEL_ITEM}.make_with_text (interface_names.l_branch+l_cur_branch_id.out))
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
			if drop_actions /= Void then
				grid.drop_actions.fill (drop_actions)
			end
			show_tooltip_checkbox.select_actions.extend (agent on_show_tooltip_changed)
			preferences.class_browser_data.show_tooltip_preference.change_actions.extend (agent on_show_tooltip_changed_from_outside)
		end

	build_sortable_and_searchable is
			-- Build facilities to support sort and search
		local
			l_class_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO
			l_feature_sort_info: EVS_GRID_TWO_WAY_SORTING_INFO
			l_written_class_sort_info: EVS_GRID_THREE_WAY_SORTING_INFO
			l_quick_search_bar: EB_GRID_QUICK_SEARCH_TOOL
		do
			old_make (grid)
				-- Prepare sort facilities
			last_sorted_column := 0
			create l_class_sort_info.make (grid.column (1), agent class_sorter, topology_order)
			create l_feature_sort_info.make (grid.column (2), agent feature_sorter, ascending_order)
			if is_written_class_used then
				create l_written_class_sort_info.make (grid.column (3), agent written_class_sorter, ascending_order)
				l_written_class_sort_info.enable_auto_indicator
				set_sort_info (l_written_class_sort_info, 3)
			end
			l_class_sort_info.enable_auto_indicator
			l_feature_sort_info.enable_auto_indicator
			set_sort_info (l_class_sort_info, 1)
			set_sort_info (l_feature_sort_info, 2)
				-- Prepare search facilities
			create l_quick_search_bar.make (development_window)
			l_quick_search_bar.attach_tool (Current)
			enable_search
		end

feature -- Notification

	update_view is
			-- Update current view according to change in `model'.
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
					sort (0, 0, 0, 0, 0, 0, 0, 0, class_column)
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
		local
			l_sorter: DS_QUICK_SORTER [EB_FEATURE_BROWSER_GRID_ROW]
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [EB_FEATURE_BROWSER_GRID_ROW]
		do
			create l_agent_sorter.make (agent class_tester)
			create l_sorter.make (l_agent_sorter)
			l_sorter.sort (rows)
			bind_grid
		end

	written_class_sorter (a_order: INTEGER) is
			-- Sorter for class name
		local
			l_sorter: DS_QUICK_SORTER [EB_FEATURE_BROWSER_GRID_ROW]
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [EB_FEATURE_BROWSER_GRID_ROW]
		do
			create l_agent_sorter.make (agent written_class_tester)
			create l_sorter.make (l_agent_sorter)
			l_sorter.sort (rows)
			bind_grid
		end

	feature_sorter (a_order: INTEGER) is
			-- Sorter for feature name
		local
			l_sorter: DS_QUICK_SORTER [EB_FEATURE_BROWSER_GRID_ROW]
			l_agent_sorter: AGENT_BASED_EQUALITY_TESTER [EB_FEATURE_BROWSER_GRID_ROW]
		do
			create l_agent_sorter.make (agent feature_name_tester)
			create l_sorter.make (l_agent_sorter)
			l_sorter.sort (rows)
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

feature{NONE} -- Implementation

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

	show_tooltip_checkbox_internal: like show_tooltip_checkbox;
			-- Implementation of `show_tooltip_checkbox'

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
