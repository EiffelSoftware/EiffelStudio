note
	description: "Flat grid to display metric history"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_FLAT_HISTORY_GRID

inherit
	EB_METRIC_HISTORY_GRID
		redefine
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
			Result := preferences.metric_tool_data.flat_view_sorting_order_preference
		end

feature{NONE} -- Implementation

	auto_resize
			-- Auto resize columns
		local
			l_column_tbl: HASH_TABLE [TUPLE [INTEGER, INTEGER], INTEGER]
		do
			create l_column_tbl.make (10)
			l_column_tbl.put ([250, 300], 1)
			l_column_tbl.put ([40, 40], 2)
			l_column_tbl.put ([100, 200], 3)
			l_column_tbl.put ([100, 200], 4)
			l_column_tbl.put ([100, 200], 5)
			l_column_tbl.put ([40, 40], 6)
			l_column_tbl.put ([60, 60], 7)
			l_column_tbl.put ([160, 200], 8)
			l_column_tbl.put ([160, 200], 9)
			l_column_tbl.put (Void, 10)
			auto_resize_columns (grid, l_column_tbl)
		end

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
			l_grid: like grid
			l_row_count: INTEGER
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
			selection_change_actions.block
			from
				l_cursor.start
				l_row_count := 1
			until
				l_cursor.after
			loop
				l_archive_node := l_cursor.item
				l_checked := l_selected_archives.has (l_archive_node)
				l_grid.insert_new_row (l_row_count)
				l_grid_row := l_grid.row (l_row_count)
				set_row_background_color (l_grid_row, l_archive_node)
				bind_row (l_grid_row, l_archive_node, l_checked)
				l_row_count := l_row_count + 1
				l_cursor.forth
			end
			if not has_grid_been_binded then
				set_has_grid_been_binded (True)
				auto_resize
			end
			selection_change_actions.resume
		end

	bind_row (a_row: EV_GRID_ROW; a_archive: EB_METRIC_ARCHIVE_NODE; a_checked: BOOLEAN)
			-- Bind `a_archive' in `a_row'.
		require
			a_row_attached: a_row /= Void
			a_archive_attached: a_archive /= Void
		do
			row_archive_table.force (a_row, a_archive)
			a_row.clear
			a_row.set_item (1, metric_name_item (a_archive, a_checked, True))
			a_row.set_item (2, status_item (a_archive))
			a_row.set_item (3, value_item (a_archive))
			a_row.set_item (4, previous_value_item (a_archive))
			a_row.set_item (5, value_difference_item (a_archive))
			a_row.set_item (6, filter_result_item (a_archive))
			a_row.set_item (7, detailed_result_item (a_archive, agent go_to_result_panel))
			a_row.set_item (8, time_item (a_archive))
			a_row.set_item (9, input_domain_item (a_archive))
			a_row.set_item (10, value_tester_item (a_archive))
			a_row.set_data (a_archive)
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
				set_row_background_color (l_grid_row, a_archive_node)
				l_checkbox_item ?= l_grid_row.item (1)
				update_metric_name_item (l_checkbox_item, a_archive_node, True)

				l_status_item ?= l_grid_row.item (2)
				update_status_item (l_status_item, a_archive_node)

				l_value_item ?= l_grid_row.item (3)
				update_value_item (l_value_item, a_archive_node)

				l_previous_value_item ?= l_grid_row.item (4)
				update_previous_value_item (l_previous_value_item, a_archive_node)

				l_value_difference_item ?= l_grid_row.item (5)
				update_value_difference_item (l_value_difference_item, a_archive_node)

				l_filter_item ?= l_grid_row.item (6)
				update_filter_result_item (l_filter_item, a_archive_node)

				l_detailed_result_item ?= l_grid_row.item (7)
				update_detailed_result_item (l_detailed_result_item, a_archive_node, agent go_to_result_panel)

				l_time_item ?= l_grid_row.item (8)
				update_time_item (l_time_item, a_archive_node)

				l_input_domain_item ?= l_grid_row.item (9)
				update_input_domain_item (l_input_domain_item, a_archive_node)

				l_value_tester_item ?= l_grid_row.item (10)
				update_value_tester_item (l_value_tester_item, a_archive_node)
			end
		end

	initialize_grid
			-- Initialize `grid'.
		do
			grid.set_column_count_to (10)
			grid.column (1).header_item.set_text (metric_names.t_metric_name)
			grid.column (3).header_item.set_text (metric_names.t_value_of_current)
			grid.column (4).header_item.set_text (metric_names.t_previous_value)
			grid.column (5).header_item.set_text (metric_names.t_difference)
			grid.column (6).header_item.set_text (metric_names.t_filter)
			grid.column (7).header_item.set_text (metric_names.t_detailed_result)
			grid.column (8).header_item.set_text (metric_names.t_calculated_time)
			grid.column (9).header_item.set_text (metric_names.t_input_domain)
			grid.column (10).header_item.set_text (metric_names.t_warning)
			set_sort_info (1, create {EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_ARCHIVE_NODE]}.make (agent metric_name_tester, ascending_order))
			set_sort_info (2, create {EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_ARCHIVE_NODE]}.make (agent archive_status_tester, ascending_order))
			set_sort_info (3, create {EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_ARCHIVE_NODE]}.make (agent archive_value_tester, ascending_order))
			set_sort_info (4, create {EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_ARCHIVE_NODE]}.make (agent archive_previous_value_tester, ascending_order))
			set_sort_info (5, create {EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_ARCHIVE_NODE]}.make (agent archive_difference_tester, ascending_order))
			set_sort_info (8, create {EVS_GRID_TWO_WAY_SORTING_INFO [EB_METRIC_ARCHIVE_NODE]}.make (agent archive_time_tester, ascending_order))
			Precursor
		end

	set_row_background_color (a_grid_row: EV_GRID_ROW; a_archive_node: EB_METRIC_ARCHIVE_NODE)
			-- Set background color for `a_grid_row' which contains `a_archive_node'.
		do
			if newly_changed_archives.has (a_archive_node) then
				if a_archive_node.is_last_warning_check_successful then
					a_grid_row.set_background_color (newly_changed_row_background_color)
				else
					a_grid_row.set_background_color (warning_row_background_color)
				end
			else
				a_grid_row.set_background_color (normal_row_background_color)
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
