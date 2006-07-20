indexing
	description: "[
					Object that represents a wrapper for an EV_GRID object
					This wrapper will add search/replace and sort ability to that EV_GRID object.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EVS_GRID_WRAPPER [G]

inherit
	EVS_UTILITY

feature{NONE} -- Initialization

	make (a_grid: like grid) is
			-- Initialize `grid' with `a_grid'.
		require
			a_grid_attached: a_grid /= Void
		do
			grid := a_grid
			last_sorted_column := 0
			create sorted_columns.make
		ensure
			grid_set: grid = a_grid
			sorted_columns_attached: sorted_columns /= Void
			last_sorted_column_set: last_sorted_column = 0
		end

feature -- Setting

	set_sort_info (a_column_index: INTEGER; a_sort_info: EVS_GRID_SORTING_INFO [G]) is
			-- Set `a_sort_info' in `grid' to column indexed by `a_column_index'.
		require
			a_column_index_valid: is_column_index_valid (a_column_index)
			a_sort_info_attached: a_sort_info /= Void
		local
			l_sort_agent: PROCEDURE [ANY, TUPLE]
		do
			a_sort_info.set_column_index (a_column_index)
			if a_column_index > column_sort_info.upper then
				column_sort_info.conservative_resize (1, a_column_index)
			end
			column_sort_info.put (a_sort_info, a_column_index)
			if not sort_agent_table.has (a_column_index) then
				sort_agent_table.force (agent sort (?, ?, ?, ?, ?, ?, ?, ?, a_column_index), a_column_index)
			end
			l_sort_agent := sort_agent_table.item (a_column_index)
			safe_register_agent (l_sort_agent, grid.column (a_column_index).header_item.pointer_button_press_actions)
		ensure
			sort_info_set: column_sort_info.item (a_sort_info.column_index) = a_sort_info
		end

	remove_sort_info (a_column_index: INTEGER) is
			-- Remove sort information associated with `a_column_index'-th column in `grid'.
		require
			a_column_index_valid: is_column_index_valid (a_column_index)
		local
			l_sort_agent: PROCEDURE [ANY, TUPLE]
		do
			if a_column_index <= column_sort_info.upper then
				column_sort_info.put (Void, a_column_index)
			end
			l_sort_agent := sort_agent_table.item (a_column_index)
			if l_sort_agent /= Void then
				safe_remove_agent (l_sort_agent, grid.column (a_column_index).header_item.pointer_button_press_actions)
			end
		ensure
			sort_info_removed:
				a_column_index <= column_sort_info.upper implies column_sort_info.item (a_column_index) = Void
		end

	enable_auto_sort_order_change is
			-- Enable sort order will change automatically.
		do
			is_auto_sort_order_change_enabled := True
		ensure
			auto_sort_order_change_enabled: is_auto_sort_order_change_enabled
		end

	disable_auto_sort_order_change is
			-- Disable automatical sort order change.
		do
			is_auto_sort_order_change_enabled := False
		ensure
			auto_sort_order_change_disabled: not is_auto_sort_order_change_enabled
		end

	ensure_visible (a_item: EVS_GRID_SEARCHABLE_ITEM; a_selected: BOOLEAN) is
			-- Ensure `a_item' is visible in viewable area of `grid'.
			-- If `a_selected' is True, make sure that `a_item' is in its selected status.
		require
			a_item_attached: a_item /= Void
		do
		end

	set_sort_action (a_action: like sort_action) is
			-- Set `sort_action' with `a_action'.
		do
			sort_action := a_action
		ensure
			sort_action_set: sort_action = a_action
		end

feature -- Sort

	sort (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER; a_column_index: INTEGER) is
			-- Sort on column indicated by `column_index' and change sort order.
		require
			a_column_index_valid: a_column_index >= 1 and a_column_index <= grid_column_count
		local
			l_sort_info: EVS_GRID_SORTING_INFO [G]
			l_current_order: INTEGER
			l_indicator: EV_PIXMAP
		do
				-- We only sort on column where sorting information is set.									
			if button = 1 and then is_column_sortable (a_column_index) then
				update_sorted_columns (ev_application.ctrl_pressed, a_column_index)
				l_sort_info := column_sort_info.item (a_column_index)
				if is_auto_sort_order_change_enabled then
					l_sort_info.change_order
				end
				if sort_action /= Void then
					sort_action.call ([sorted_columns, current_comparator])
						-- Change sort indicator.
					l_current_order := l_sort_info.current_order
					if l_sort_info.is_auto_indicator_enabled and then l_sort_info.indicator.has (l_current_order) then
						l_indicator := l_sort_info.indicator.item (l_current_order)
						if l_indicator /= Void then
							grid.column (l_sort_info.column_index).set_pixmap (l_indicator)
						else
							grid.column (l_sort_info.column_index).remove_pixmap
						end
					end
					if
						is_column_index_valid (last_sorted_column) and then
						last_sorted_column /= a_column_index and then
						is_column_sortable (a_column_index)
					then
						l_sort_info := column_sort_info.item (last_sorted_column)
						if l_sort_info.is_auto_indicator_enabled then
							grid.column (last_sorted_column).header_item.remove_pixmap
						end
					end
					last_sorted_column := a_column_index
				end
			end
		ensure
			column_sorted:
				(button = 1 and then a_column_index <= column_sort_info.upper and then sort_action /= Void and then
				 column_sort_info.item (a_column_index) /= Void) implies last_sorted_column = a_column_index
		end

feature -- Status report

	is_column_sortable (a_column_index: INTEGER): BOOLEAN is
			-- Is column indicated by `a_column_index' sortable?
		do
			Result := (a_column_index > 0 and a_column_index <= grid.column_count) and then (
				a_column_index <= column_sort_info.upper and then
			    column_sort_info.item (a_column_index) /= Void)
		ensure
			good_result: Result implies ((a_column_index > 0 and a_column_index <= grid.column_count) and then
				(a_column_index <= column_sort_info.upper and then
			    column_sort_info.item (a_column_index) /= Void))
		end

	is_auto_sort_order_change_enabled: BOOLEAN
			-- Is auto sort order change enabled?
			-- This means whether or not sort order of a column will change automatically to the next
			-- order after every `change_sorting_order_indicator'.

	column_sort_info: ARRAY [EVS_GRID_SORTING_INFO [G]] is
			-- Sort information of every column in `grid'.
			-- If `column_sort_info'.`item' (i) is Void, then i-th column in `grid' is not sortable.
		local
			l_column_count: INTEGER
		do
			if column_sort_info_internal = Void then
				l_column_count := grid.column_count
				if l_column_count = 0 then
					l_column_count := 1
				end
				create column_sort_info_internal.make (1, l_column_count)
			end
			Result := column_sort_info_internal
		ensure
			result_attached: Result /= Void
		end

	last_sorted_column: INTEGER
			-- Index of last sorted column

	sort_agent_table: HASH_TABLE [PROCEDURE [ANY, TUPLE], INTEGER] is
			-- Table to store sort agents, key is column index, value is sort agent for that column
		do
			if sort_agent_table_internal = Void then
				create sort_agent_table_internal.make (grid.column_count)
			end
			Result := sort_agent_table_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Virtual grid

	is_grid_empty: BOOLEAN is
			-- Does `grid' contain no item even Void item?
		do
			Result := grid_row_count = 0 or grid_column_count = 0
		ensure
			good_result: Result implies (grid_row_count = 0 or grid_column_count = 0)
		end

	is_position_valid (a_column_index, a_row_index: INTEGER): BOOLEAN is
			-- Is position (`a_column_index', `a_row_index') valid in `grid'?
		do
			Result := (a_column_index > 0 and a_column_index <= grid_column_count and
					 a_row_index > 0 and a_row_index <= grid_row_count)
		ensure
			good_result:
				Result implies
					(a_column_index > 0 and a_column_index <= grid_column_count and
					 a_row_index > 0 and a_row_index <= grid_row_count)
		end

	is_column_index_valid (a_column_index: INTEGER): BOOLEAN is
			-- Is column indicated by `a_column_index' a valid column in `grid'?
		do
			Result := a_column_index > 0 and a_column_index <= grid_column_count
		ensure
			good_result: Result implies (a_column_index > 0 and a_column_index <= grid_column_count)
		end

	is_row_index_valid (a_row_index: INTEGER): BOOLEAN is
			-- Is row indicated by `a_row_index' a valid row in `grid'?
		do
			Result := a_row_index > 0 and a_row_index <= grid_row_count
		ensure
			good_result: Result implies (a_row_index > 0 and a_row_index <= grid_row_count)
		end

	grid_column_count: INTEGER is
			-- Number of columns in `grid'.		
		do
			Result := grid.column_count
		ensure
			result_non_negative: Result >= 0
		end

	grid_row_count: INTEGER is
			-- Number of rows in `grid'.		
		do
			Result := grid.row_count
		ensure
			result_non_negative: Result >= 0
		end

	grid_selected_items: DS_ARRAYED_LIST [EVS_GRID_COORDINATED] is
			-- Selected items in `grid'.
			-- Returned list is unsorted so no particular ordering is guaranteed.			
		local
			l_selected: ARRAYED_LIST [EV_GRID_ITEM]
			l_item: EV_GRID_ITEM
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
					Result.force_last (create {EVS_EMPTY_COORDINATED_ITEM}.make (l_item.column.index, l_item.row.index))
					l_selected.forth
				end
			end
		ensure
			result_attached: Result /= Void
		end

	grid_item (a_column: INTEGER; a_row: INTEGER): EVS_GRID_SEARCHABLE_ITEM is
			-- Cell at `a_row' and `a_column' position.
			-- It may not be actual item in `grid' but your own item.
		require
			position_valid: is_position_valid (a_column, a_row)
		do
			Result ?= grid.item (a_column, a_row)
		end

feature -- Access

	grid: EV_GRID
			-- Grid for display			

	sort_action: PROCEDURE [ANY, TUPLE [a_sorted_columns: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [G]]]
			-- Action used to sort

feature{NONE} -- Implementation

	sorted_columns: LINKED_LIST [INTEGER]
			-- Columns to be sorted
			-- This is used to support multi-column sort. When you sorted the first column, and thne
			-- sort the second column with control key pressed, the result would be first sort the first column,
			-- and then sort the second column.
			-- In this list, a list of column index are maintained, the first item is the oldest sorted column, the last item is
			-- the most recent sorted column.

	column_sort_info_internal: like column_sort_info
			-- Internal `column_sort_info'

	sort_agent_table_internal: like sort_agent_table
			-- Internal `sort_agent_table'

	update_sorted_columns (a_ctrl_pressed: BOOLEAN; a_next_column_to_sort: INTEGER) is
			-- Prepare `sorted_columns' for next column (whose index is in `a_next_column_to_sort') to be sorted.
			-- `a_ctrl_pressed' indicates if Ctrl key is pressed.		
		local
			l_columns: like sorted_columns
		do
			l_columns := sorted_columns
			if not l_columns.is_empty then
				if l_columns.last = a_next_column_to_sort then
					if not a_ctrl_pressed then
						l_columns.wipe_out
						l_columns.extend (a_next_column_to_sort)
					end
				else
					if a_ctrl_pressed then
						l_columns.start
						l_columns.search (a_next_column_to_sort)
						if not l_columns.exhausted then
							from
							until
								l_columns.index = 1
							loop
								l_columns.remove_left
							end
							l_columns.remove
						end
						l_columns.extend (a_next_column_to_sort)
					else
						l_columns.wipe_out
						l_columns.extend (a_next_column_to_sort)
					end
				end
			else
				l_columns.extend (a_next_column_to_sort)
			end
		end

	current_comparator: AGENT_LIST_COMPARATOR [G] is
			-- Comparator used to sort
			-- 	The first two arguments are rows to be compared with each other
			-- 	The third integer argument is current sorting order
			-- 	Return value of this comparator should be True if the first row is less thant the second one.			
		local
			l_columns: like sorted_columns
			l_list_comparator: AGENT_LIST_COMPARATOR [G]
			l_sort_info: like column_sort_info
			l_action_list: ARRAYED_LIST [FUNCTION [ANY, TUPLE [G, G, INTEGER], BOOLEAN]]
			l_order_list: ARRAYED_LIST [INTEGER]
			l_sort_info_item: EVS_GRID_SORTING_INFO [G]
		do
			l_columns := sorted_columns
			l_sort_info := column_sort_info
			create l_action_list.make (l_columns.count)
			create l_order_list.make (l_columns.count)

			from
				l_columns.start
			until
				l_columns.after
			loop
				l_sort_info_item := l_sort_info.item (l_columns.item)
				l_action_list.extend (l_sort_info_item.comparator)
				l_order_list.extend (l_sort_info_item.current_order)
				l_columns.forth
			end
			create Result.make (l_action_list, l_order_list)
		ensure
			result_attached: Result /= Void
		end


invariant
	sorted_columns_attached: sorted_columns /= Void
	grid_attached: grid /= Void

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
