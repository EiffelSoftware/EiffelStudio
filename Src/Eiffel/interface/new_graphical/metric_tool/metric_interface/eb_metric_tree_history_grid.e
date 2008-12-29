note
	description: "Tree grid to display metric history"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_TREE_HISTORY_GRID

inherit
	EB_METRIC_HISTORY_GRID
		redefine
			update,
			initialize_grid
		end

create
	make

feature -- Access

	checkbox_item_index: INTEGER
			-- Item index of checkbox grid item
		do
			Result := 1
		end

	sorting_order_preference: STRING_PREFERENCE
			-- Sort order preference
		do
			Result := preferences.metric_tool_data.tree_view_sorting_order_preference
		end

feature -- Grid binding

	bind_grid (a_selected_nodes: like selected_archives)
			-- Bind `archive' in `grid'.
			-- If `a_selected_nodes' is Void, use values from `selected_archives', otherwise, use `a_selected_nodes'.
		local
			l_archive: like archive
			l_archive_node: EB_METRIC_ARCHIVE_NODE
			l_cursor: DS_ARRAYED_LIST_CURSOR [EB_METRIC_ARCHIVE_NODE]
			l_selected_archives: like selected_archives
			l_newly_changed_archives: like newly_changed_archives
			l_checked: BOOLEAN
			l_grid_row: EV_GRID_ROW
			l_base_row: EV_GRID_ROW
			l_grid: like grid
			l_row_count: INTEGER
			l_name_row_table: HASH_TABLE [EV_GRID_ROW, STRING]
			l_lower_name: STRING
			l_name_item: EV_GRID_LABEL_ITEM
			l_row_type: INTEGER
		do
			if a_selected_nodes = Void then
				l_selected_archives := selected_archives
			else
				l_selected_archives := a_selected_nodes
			end
			l_newly_changed_archives := newly_changed_archives
			l_grid := grid
			if l_grid.row_count > 0 then
				l_grid.remove_rows (1, l_grid.row_count)
			end
			l_archive := archive
			l_cursor := l_archive.new_cursor
			row_archive_table.wipe_out
			create l_name_row_table.make (20)
			selection_change_actions.block
			from
				l_cursor.start
				l_row_count := 1
				l_row_type := 1
			until
				l_cursor.after
			loop
				l_archive_node := l_cursor.item
				l_lower_name := l_archive_node.metric_name.as_lower
				if not l_name_row_table.has (l_lower_name) then
					l_grid.insert_new_row (l_grid.row_count + 1)
					l_base_row := l_grid.row (l_grid.row_count)
					l_name_row_table.put (l_base_row, l_lower_name)
					create l_name_item.make_with_text (l_archive_node.metric_name)
					l_name_item.set_pixmap (pixmap_from_metric_type (l_archive_node.metric_type))
					if l_archive_node.is_metric_valid then
						l_base_row.set_foreground_color (normal_color)
					else
						l_base_row.set_foreground_color (red_color)
						l_name_item.set_tooltip (metric_names.err_metric_not_exist (metric_type_name (l_archive_node.metric_type)))
					end
					l_base_row.set_item (1, l_name_item)
					if l_row_type \\ 2 = 0 then
						l_base_row.set_background_color (even_row_background_color)
					else
						l_base_row.set_background_color (odd_row_background_color)
					end
					l_row_type := l_row_type + 1
				else
					l_base_row := l_name_row_table.item (l_lower_name)
				end
				l_base_row.insert_subrow (l_base_row.subrow_count + 1)
				if l_base_row.is_expandable and then not l_base_row.is_expanded then
					l_base_row.expand
				end
				l_grid_row := l_base_row.subrow (l_base_row.subrow_count)
				l_checked := l_selected_archives.has (l_archive_node)
				set_row_background_color (l_grid_row, l_archive_node)
				bind_row (l_grid_row, l_archive_node, l_checked)
				l_cursor.forth
			end
			if not has_grid_been_binded then
				set_has_grid_been_binded (True)
				auto_resize
			end
			selection_change_actions.resume
		end

	update
			-- Update status of current
		local
			l_grid: like grid
			l_row_index: INTEGER
			l_row_count: INTEGER
			l_grid_row: EV_GRID_ROW
			l_row_type: INTEGER
		do
			from
				l_row_type := 1
				l_grid := grid
				l_row_index := 1
				l_row_count := l_grid.row_count
			until
				l_row_index > l_row_count
			loop
				l_grid_row := l_grid.row (l_row_index)
				if l_grid_row.parent_row = Void then
					update_base_row (l_grid_row, l_row_type \\ 2)
					l_row_type := l_row_type + 1
				end
				l_row_index := l_row_index + 1
			end
			Precursor
		end

feature{NONE} -- Implementation

	bind_row (a_row: EV_GRID_ROW; a_archive: EB_METRIC_ARCHIVE_NODE; a_checked: BOOLEAN)
			-- Bind `a_archive_node' in `a_row'.
		require
			a_row_attached: a_row /= Void
			a_archive_attached: a_archive /= Void
		do
			row_archive_table.force (a_row, a_archive)
			a_row.clear
			a_row.set_item (1, metric_name_item (a_archive, a_checked, False))
			a_row.set_item (2, input_domain_item (a_archive))
			a_row.set_item (3, status_item (a_archive))
			a_row.set_item (4, value_item (a_archive))
			a_row.set_item (5, previous_value_item (a_archive))
			a_row.set_item (6, value_difference_item (a_archive))
			a_row.set_item (7, filter_result_item (a_archive))
			a_row.set_item (8, detailed_result_item (a_archive, agent go_to_result_panel))
			a_row.set_item (9, time_item (a_archive))
			a_row.set_item (10, value_tester_item (a_archive))
			a_row.set_data (a_archive)
		end

	update_base_row (a_row: EV_GRID_ROW; a_row_type: INTEGER)
			-- Update base row `a_row'.
			-- `a_row_type' is 0 indicates if `a_row' is an even row, otherwise an odd row.
		require
			a_row_attached: a_row /= Void
			a_row_has_subrow: a_row.subrow_count > 0
		local
			l_label_item: EV_GRID_LABEL_ITEM
			l_subrow: EV_GRID_ROW
			l_archive: EB_METRIC_ARCHIVE_NODE
		do
			l_label_item ?= a_row.item (1)
			check l_label_item /= Void end
			l_subrow := a_row.subrow (1)
			l_archive ?= l_subrow.data
			check l_archive /= Void end
			if l_archive.is_metric_valid then
				a_row.set_foreground_color (normal_color)
			else
				a_row.set_foreground_color (red_color)
				l_label_item.set_tooltip (metric_names.err_metric_not_exist (metric_type_name (l_archive.metric_type)))
			end
			l_label_item.set_text (l_archive.metric_name)
			l_label_item.set_pixmap (pixmap_from_metric_type (l_archive.metric_type))
			if a_row_type = 0 then
				a_row.set_background_color (even_row_background_color)
			else
				a_row.set_background_color (odd_row_background_color)
			end
		end

	update_row (a_archive_node: EB_METRIC_ARCHIVE_NODE)
			-- Update the row that contains `a_archive_node'.
		local
			l_grid_row: EV_GRID_ROW
			l_checkbox_item: like metric_name_item
			l_status_item: like status_item
			l_value_item: like value_item
			l_previous_value_item: like previous_value_item
			l_value_difference_item: like value_difference_item
			l_detailed_result_item: like detailed_result_item
			l_time_item: like time_item
			l_input_domain_item: like input_domain_item
			l_filter_item: like filter_result_item
			l_value_tester_item: like value_tester_item
		do
			l_grid_row := row_archive_table.item (a_archive_node)
			if l_grid_row /= Void then
					-- Setup background color.
--				if newly_changed_archives.has (a_archive_node) then
--					l_grid_row.set_background_color (newly_changed_row_background_color)
--				else
--					l_grid_row.set_background_color (background_color_of_parent_row (l_grid_row))
--				end
				set_row_background_color (l_grid_row, a_archive_node)
				l_checkbox_item ?= l_grid_row.item (1)
				update_metric_name_item (l_checkbox_item, a_archive_node, False)

				l_input_domain_item ?= l_grid_row.item (2)
				update_input_domain_item (l_input_domain_item, a_archive_node)

				l_status_item ?= l_grid_row.item (3)
				update_status_item (l_status_item, a_archive_node)

				l_value_item ?= l_grid_row.item (4)
				update_value_item (l_value_item, a_archive_node)

				l_previous_value_item ?= l_grid_row.item (5)
				update_previous_value_item (l_previous_value_item, a_archive_node)

				l_value_difference_item ?= l_grid_row.item (6)
				update_value_difference_item (l_value_difference_item, a_archive_node)

				l_filter_item ?= l_grid_row.item (7)
				update_filter_result_item (l_filter_item, a_archive_node)

				l_detailed_result_item ?= l_grid_row.item (8)
				update_detailed_result_item (l_detailed_result_item, a_archive_node, agent go_to_result_panel)

				l_time_item ?= l_grid_row.item (9)
				update_time_item (l_time_item, a_archive_node)

				l_value_tester_item ?= l_grid_row.item (10)
				update_value_tester_item (l_value_tester_item, a_archive_node)
			end
		end

	auto_resize
			-- Auto resize columns
		local
			l_column_tbl: HASH_TABLE [TUPLE [INTEGER, INTEGER], INTEGER]
		do
			create l_column_tbl.make (8)
			l_column_tbl.put ([250, 300], 1)
			l_column_tbl.put ([200, 400], 2)
			l_column_tbl.put ([40, 40], 3)
			l_column_tbl.put ([100, 200], 4)
			l_column_tbl.put ([100, 200], 5)
			l_column_tbl.put ([100, 200], 6)
			l_column_tbl.put ([60, 60], 7)
			l_column_tbl.put ([160, 200], 8)
			auto_resize_columns (grid, l_column_tbl)
		end

	initialize_grid
			-- Initialize `grid'.
		do
			grid.set_column_count_to (10)
			grid.enable_tree
			grid.column (1).header_item.set_text (metric_names.t_metric_name)
			grid.column (2).header_item.set_text (metric_names.t_input_domain)
			grid.column (4).header_item.set_text (metric_names.t_value_of_current)
			grid.column (5).header_item.set_text (metric_names.t_previous_value)
			grid.column (6).header_item.set_text (metric_names.t_difference)
			grid.column (7).header_item.set_text (metric_names.t_filter)
			grid.column (8).header_item.set_text (metric_names.t_detailed_result)
			grid.column (9).header_item.set_text (metric_names.t_calculated_time)
			grid.column (10).header_item.set_text (metric_names.t_warning)

			set_sort_info (1, create {EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_ARCHIVE_NODE]}.make (agent metric_name_tester, ascending_order))
			set_sort_info (3, create {EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_ARCHIVE_NODE]}.make (agent archive_status_tester, ascending_order))
			set_sort_info (4, create {EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_ARCHIVE_NODE]}.make (agent archive_value_tester, ascending_order))
			set_sort_info (5, create {EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_ARCHIVE_NODE]}.make (agent archive_previous_value_tester, ascending_order))
			set_sort_info (6, create {EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_ARCHIVE_NODE]}.make (agent archive_difference_tester, ascending_order))
			set_sort_info (9, create {EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_ARCHIVE_NODE]}.make (agent archive_time_tester, ascending_order))
			grid.enable_default_tree_navigation_behavior (True, True, True, True)
			Precursor
		end

feature{NONE} -- Color

	even_row_background_color: EV_COLOR
			-- Background color for even rows
		do
			Result := preferences.class_browser_data.even_row_background_color
		ensure
			result_attached: Result /= Void
		end

	odd_row_background_color: EV_COLOR
			-- Background color for odd rows
		do
			Result := preferences.class_browser_data.odd_row_background_color
		end

	set_row_background_color (a_grid_row: EV_GRID_ROW; a_archive_node: EB_METRIC_ARCHIVE_NODE)
			-- Set background color for `a_grid_row' which contains `a_archive_node'.
		local
			l_parent_row: EV_GRID_ROW
		do
			if newly_changed_archives.has (a_archive_node) then
				if a_archive_node.is_last_warning_check_successful then
					a_grid_row.set_background_color (newly_changed_row_background_color)
				else
					a_grid_row.set_background_color (warning_row_background_color)
				end
			else
				l_parent_row := a_grid_row.parent_row
				if l_parent_row /= Void then
					a_grid_row.set_background_color (l_parent_row.background_color)
				else
					a_grid_row.set_background_color (normal_row_background_color)
				end
			end
		end

note
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
