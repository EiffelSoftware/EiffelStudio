note
	description: "[
					Object that represents a wrapper for an EV_GRID object
					This wrapper will add search/replace and sort ability to that EV_GRID object.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GRID_WRAPPER [G]

inherit
	EVS_UTILITY

	EVS_GRID_UTILITY

create
	make

feature{NONE} -- Initialization

	make (a_grid: like grid)
			-- Initialize `grid' with `a_grid'.
		require
			a_grid_attached: a_grid /= Void
		do
			grid := a_grid
			last_sorted_column_internal := 0
			create sorted_columns.make
			set_grid_item_function (agent a_grid.item)
			set_ensure_visible_action (agent default_ensure_visible_action)
		ensure
			grid_set: grid = a_grid
			sorted_columns_attached: sorted_columns /= Void
			last_sorted_column_set: last_sorted_column_internal = 0
			grid_item_function_attached: grid_item_function /= Void
			ensure_visible_action_attached: ensure_visible_action /= Void
		end

feature -- Setting

	set_sort_info (a_column_index: INTEGER; a_sort_info: EVS_GRID_SORTING_INFO [G])
			-- Set `a_sort_info' in `grid' to column indexed by `a_column_index'.
		require
			a_column_index_valid: is_column_index_valid (a_column_index)
			a_sort_info_attached: a_sort_info /= Void
		do
			a_sort_info.set_column_index (a_column_index)
			if a_column_index > column_sort_info.upper then
				column_sort_info.conservative_resize (1, a_column_index)
			end
			column_sort_info.put (a_sort_info, a_column_index)
			if not sort_agent_table.has (a_column_index) then
				sort_agent_table.force (agent sort (?, ?, ?, ?, ?, ?, ?, ?, a_column_index), a_column_index)
			end
			if attached sort_agent_table.item (a_column_index) as l_sort_agent then
				safe_register_agent (l_sort_agent, grid.column (a_column_index).header_item.pointer_button_press_actions)
			end
		ensure
			sort_info_set: column_sort_info.item (a_sort_info.column_index) = a_sort_info
		end

	remove_sort_info (a_column_index: INTEGER)
			-- Remove sort information associated with `a_column_index'-th column in `grid'.
		require
			a_column_index_valid: is_column_index_valid (a_column_index)
		do
			if attached column_sort_info.item (a_column_index) as l_sort_info then
				if l_sort_info.is_auto_indicator_enabled then
					grid.column (l_sort_info.column_index).header_item.remove_pixmap
				end
				if a_column_index <= column_sort_info.upper then
					column_sort_info.put (Void, a_column_index)
				end
				if attached sort_agent_table.item (a_column_index) as l_sort_agent then
					safe_remove_agent (l_sort_agent, grid.column (a_column_index).header_item.pointer_button_press_actions)
				end
			end
		ensure
			sort_info_removed:
				a_column_index <= column_sort_info.upper implies column_sort_info.item (a_column_index) = Void
		end

	enable_auto_sort_order_change
			-- Enable sort order will change automatically.
		do
			is_auto_sort_order_change_enabled := True
		ensure
			auto_sort_order_change_enabled: is_auto_sort_order_change_enabled
		end

	disable_auto_sort_order_change
			-- Disable automatical sort order change.
		do
			is_auto_sort_order_change_enabled := False
		ensure
			auto_sort_order_change_disabled: not is_auto_sort_order_change_enabled
		end

	ensure_visible (a_item: EVS_GRID_SEARCHABLE_ITEM; a_selected: BOOLEAN)
			-- Ensure `a_item' is visible in viewable area of `grid'.
			-- If `a_selected' is True, make sure that `a_item' is in its selected status.
		require
			a_item_attached: a_item /= Void
		do
			ensure_visible_action.call ([a_item, a_selected])
		end

	set_sort_action (a_action: like sort_action)
			-- Set `sort_action' with `a_action'.
		do
			sort_action := a_action
		ensure
			sort_action_set: sort_action = a_action
		end

	set_sorting_status (a_status:  LIST [TUPLE [a_column_index: INTEGER; a_sorting_order: INTEGER]])
			-- Set sorting status to `a_status'.
		require
			a_status_attached: a_status /= Void
			a_status_valid: is_sorting_status_valid (a_status)
		local
			l_columns: like sorted_columns
			l_tuple: TUPLE [a_column_index: INTEGER; a_sorting_order: INTEGER]
			l_column: INTEGER
			l_sort_info: like column_sort_info
		do
			l_sort_info := column_sort_info
			l_columns := sorted_columns
			l_columns.wipe_out
			from
				a_status.start
			until
				a_status.after
			loop
				l_tuple := a_status.item
				l_column := l_tuple.a_column_index
				l_columns.extend (l_column)
				if attached l_sort_info.item (l_column) as l_sort_info_item then
					l_sort_info_item.set_current_order (l_tuple.a_sorting_order)
				end
				a_status.forth
			end
		end

	enable_force_multi_column_sorting
			-- Enable force multi column sorting.
		do
			is_multi_column_sorting_forced := True
		ensure
			multi_column_sorting_forced: is_multi_column_sorting_forced
		end

	disable_force_multi_column_sorting
			-- Disable force multi column sorting.
		do
			is_multi_column_sorting_forced := False
		ensure
			multi_column_sorting_not_forced: not is_multi_column_sorting_forced
		end

	wipe_out_sorted_columns
			-- Wipe out `sorted_columns'.
		do
			sorted_columns.wipe_out
		ensure
			sorted_columns_is_empty: sorted_columns.is_empty
		end

	set_grid_item_function (a_function: like grid_item_function)
			-- Set `grid_item_function' with `a_function'.
		require
			a_function_attached: a_function /= Void
		do
			grid_item_function := a_function
		ensure
			grid_item_function_set: grid_item_function = a_function
		end

	set_ensure_visible_action (a_action: like ensure_visible_action)
			-- Set `ensure_visible_action' with `a_action'.
		require
			a_action_attached: a_action /= Void
		do
			ensure_visible_action := a_action
		ensure
			ensure_visible_action_set: ensure_visible_action = a_action
		end

	set_selection_function (a_function: like selection_function)
			-- Set `selection_function' with `a_function'.
		do
			selection_function := a_function
		ensure
			selection_function_set: selection_function = a_function
		end

	set_item_text_function (a_function: like item_text_function)
			-- Set `item_text_unction' with `a_function'.		
		do
			item_text_function := a_function
		ensure
			item_text_function_set: item_text_function = a_function
		end

	enable_copy
			-- Enable using Ctrl+A, Ctrl+C to select items and copy them to clipboard.
		do
			if not grid.key_press_actions.has (on_copy_using_key_agent) then
				grid.key_press_actions.extend (on_copy_using_key_agent)
			end
		end

	disable_copy
			-- Disable using Ctrl+A, Ctrl+C to select items and copy them to clipboard.
		do
			grid.key_press_actions.prune_all (on_copy_using_key_agent)
		end

	set_select_all_action (a_action: like select_all_action)
			-- Set `select_all_action" with `a_action'.
		do
			select_all_action := a_action
		ensure
			select_all_action_set: select_all_action = a_action
		end

feature -- Sort

	sort (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER; a_column_index: INTEGER)
			-- Sort on column indicated by `column_index' and change sort order.
		require
			a_column_index_valid: a_column_index >= 1 and a_column_index <= grid_column_count
		local
			l_sort_info: detachable EVS_GRID_SORTING_INFO [G]
			l_current_order: INTEGER
		do
				-- We only sort on column where sorting information is set.									
			if button = {EV_POINTER_CONSTANTS}.left and then is_column_sortable (a_column_index) then
				update_sorted_columns (is_ctrl_key_pressed, a_column_index)
				l_sort_info := column_sort_info.item (a_column_index)
				if l_sort_info /= Void then
					if is_auto_sort_order_change_enabled then
						l_sort_info.change_order
					end
					if attached sort_action as l_sort_action then
						l_sort_action.call ([sorted_columns, current_comparator])
							-- Change sort indicator.
						l_current_order := l_sort_info.current_order
						if l_sort_info.is_auto_indicator_enabled and then l_sort_info.indicator.has (l_current_order) then
							if attached l_sort_info.indicator.item (l_current_order) as l_indicator then
								grid.column (l_sort_info.column_index).set_pixmap (l_indicator)
							else
								grid.column (l_sort_info.column_index).remove_pixmap
							end
						end
						if
							is_column_index_valid (last_sorted_column_internal) and then
							last_sorted_column_internal /= a_column_index and then
							is_column_sortable (a_column_index)
						then
							l_sort_info := column_sort_info.item (last_sorted_column_internal)
							if l_sort_info /= Void then
								if l_sort_info.is_auto_indicator_enabled then
									grid.column (last_sorted_column_internal).header_item.remove_pixmap
								end
							end
						end
						last_sorted_column_internal := a_column_index
						post_sort_actions.call ([sorting_order_snapshort])
					end
				end
			end
		ensure
			column_sorted:
				(button = 1 and then a_column_index <= column_sort_info.upper and then sort_action /= Void and then
				 column_sort_info.item (a_column_index) /= Void) implies last_sorted_column_internal = a_column_index
		end

feature -- Status report

	is_column_sortable (a_column_index: INTEGER): BOOLEAN
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

	is_multi_column_sorting_forced: BOOLEAN
			-- Is multi-column soring forced?
			-- This means we conduct a multi-column sorting even though Ctrl key is not pressed

	is_sorting_status_valid (a_status: LIST [TUPLE [a_sorted_column: INTEGER; a_sorting_order: INTEGER]]): BOOLEAN
			-- Is `a_status' valid for `grid'?
			-- e.g., every column whose index is `a_sorted_clumn' is a valid sortable column and `a_sorting_order' is
			-- a valid sorting order for that column?
		require
			a_status_attached: a_status /= Void
		local
			l_cursor: CURSOR
		do
			if not a_status.is_empty then
				l_cursor := a_status.cursor
				Result := True
				from
					a_status.start
				until
					a_status.after or a_status.item = Void or (not Result)
				loop
					Result := is_column_sortable (a_status.item.a_sorted_column)
					a_status.forth
				end
				a_status.go_to (l_cursor)
			end
		end

feature -- Access

	column_sort_info: ARRAY [detachable EVS_GRID_SORTING_INFO [G]]
			-- Sort information of every column in `grid'.
			-- If `column_sort_info'.`item' (i) is Void, then i-th column in `grid' is not sortable.
		local
			l_column_count: INTEGER
			l_column_sort_info_internal: like column_sort_info_internal
		do
			l_column_sort_info_internal := column_sort_info_internal
			if l_column_sort_info_internal = Void then
				l_column_count := grid.column_count
				if l_column_count = 0 then
					l_column_count := 1
				end
				create l_column_sort_info_internal.make (1, l_column_count)
				column_sort_info_internal := l_column_sort_info_internal
			end
			Result := l_column_sort_info_internal
		ensure
			result_attached: Result /= Void
		end

	sorted_columns: LINKED_LIST [INTEGER]
			-- Columns to be sorted
			-- This is used to support multi-column sort. When you sorted the first column, and then
			-- sort the second column with control key pressed, the result would be first sort the first column,
			-- and then sort the second column.
			-- In this list, a list of column index are maintained, the first item is the earliest sorted column, the last item is
			-- the most recently sorted column.

	last_sorted_column: INTEGER
			-- Index of last sorted column
			-- 0 if no sorting has been applied
		local
			l_sorted_columns: like sorted_columns
		do
			l_sorted_columns := sorted_columns
			if not l_sorted_columns.is_empty then
				Result := l_sorted_columns.last
			end
		ensure
			good_result: Result >= 0
		end

	grid: EV_GRID
			-- Grid for display			

	sort_action: detachable PROCEDURE [TUPLE [a_sorted_columns: LIST [INTEGER]; a_comparator: AGENT_LIST_COMPARATOR [G]]]
			-- Action used to sort

	post_sort_actions: ACTION_SEQUENCE [TUPLE [LINKED_LIST [TUPLE [a_column_index: INTEGER; a_sorting_order: INTEGER]]]]
			-- Actions got called after sorting is finished
			-- Argument of those actions is a list of columns to be sorted.
		local
			l_post_sort_actions_internal: like post_sort_actions_internal
		do
			l_post_sort_actions_internal := post_sort_actions_internal
			if l_post_sort_actions_internal = Void then
				create l_post_sort_actions_internal
				post_sort_actions_internal := l_post_sort_actions_internal
			end
			Result := l_post_sort_actions_internal
		ensure
			result_attached: Result /= Void
		end

	grid_item_function: FUNCTION [TUPLE [a_column: INTEGER; a_row: INTEGER], detachable EV_GRID_ITEM]
			-- Function that returns grid item at position (`a_column', `a_row')

	ensure_visible_action: PROCEDURE [TUPLE [a_item: EVS_GRID_SEARCHABLE_ITEM; a_selected: BOOLEAN]]
			-- Action to be performed to ensure that `a_item' is visible.
			-- `a_selected' is True indicates that `a_item' should be selected by default.

	selection_function: detachable FUNCTION [STRING_GENERAL]
			-- Function to return selected text in grid' (all selected rows or items should be taken into consideration).
			-- If Void, `selection' will return an empty string.

	selection: STRING_GENERAL
			-- String representation of all selected rows or items in `grid'.
			-- If `selection_function' is Void, `default_selection_function' will be used to get selected text.
			-- In this case, make sure `item_text_function' is set.
		local
			st: STRING_GENERAL
		do
			if attached selection_function as fct then
				st := fct.item (Void)
			else
				st := default_selection_function
			end
			if st = Void then
				Result := ""
			else
				Result := st
			end
		end

	select_all_action: detachable PROCEDURE
			-- Action to be performed to select all items in `grid'
			-- Used in Ctrl+A.
			-- If Void, `default_select_all_action' will be used.

	largest_sorted_column_index: INTEGER
			-- Index of largest sorted column
			-- 0 if no sort had occurred
		do
			Result := extreme_index_of_sorted_columns (True)
		end

	smallest_sorted_column_index: INTEGER
			-- Index of smallest sorted column
			-- 0 if no sort had occurred
		do
			Result := extreme_index_of_sorted_columns (False)
		end

	string_representation_of_sorted_columns: STRING
			-- String representation of a list of sorted columns from `a_columns'
		local
			c: INTEGER
			l_sorting_snapshot: like sorting_order_snapshort
			l_tuple: TUPLE [a_column_index: INTEGER; a_sorting_order: INTEGER]
		do
			create Result.make (20)
			l_sorting_snapshot := sorting_order_snapshort
			from
				l_sorting_snapshot.start
				c := l_sorting_snapshot.count
			until
				l_sorting_snapshot.after
			loop
				l_tuple := l_sorting_snapshot.item
				if l_tuple /= Void then
					Result.append (l_tuple.a_column_index.out)
					Result.append_character (':')
					Result.append (l_tuple.a_sorting_order.out)
					if l_sorting_snapshot.index < c then
						Result.append_character (',')
					end
				end
				l_sorting_snapshot.forth
			end
		ensure
			result_attached: Result /= Void
		end

	sorted_columns_from_string (a_str: STRING): LINKED_LIST [TUPLE [a_column_index: INTEGER; a_sorting_order: INTEGER]]
			-- A list of sorting columns from its string representation
		require
			a_str_attached: a_str /= Void
		local
			l_list: LIST [STRING]
			l_list2: LIST [STRING]
		do
			create Result.make
			from
				l_list := a_str.split (',')
				l_list.start
			until
				l_list.after
			loop
				l_list2 := l_list.item.split (':')
				if l_list2.count = 2 and then l_list2.first.is_integer and then l_list2.last.is_integer then
					Result.extend ([l_list2.first.to_integer, l_list2.last.to_integer])
				end
				l_list.forth
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Virtual grid

	is_grid_empty: BOOLEAN
			-- Does `grid' contain no item even Void item?
		do
			Result := grid_row_count = 0 or grid_column_count = 0
		ensure
			good_result: Result implies (grid_row_count = 0 or grid_column_count = 0)
		end

	is_position_valid (a_column_index, a_row_index: INTEGER): BOOLEAN
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

	is_column_index_valid (a_column_index: INTEGER): BOOLEAN
			-- Is column indicated by `a_column_index' a valid column in `grid'?
		do
			Result := a_column_index > 0 and a_column_index <= grid_column_count
		ensure
			good_result: Result implies (a_column_index > 0 and a_column_index <= grid_column_count)
		end

	is_row_index_valid (a_row_index: INTEGER): BOOLEAN
			-- Is row indicated by `a_row_index' a valid row in `grid'?
		do
			Result := a_row_index > 0 and a_row_index <= grid_row_count
		ensure
			good_result: Result implies (a_row_index > 0 and a_row_index <= grid_row_count)
		end

	grid_column_count: INTEGER
			-- Number of columns in `grid'.		
		do
			Result := grid.column_count
		ensure
			result_non_negative: Result >= 0
		end

	grid_row_count: INTEGER
			-- Number of rows in `grid'.		
		do
			Result := grid.row_count
		ensure
			result_non_negative: Result >= 0
		end

	grid_selected_items: ARRAYED_LIST [EVS_GRID_COORDINATED]
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
					Result.force (create {EVS_EMPTY_COORDINATED_ITEM}.make (l_item.column.index, l_item.row.index))
					l_selected.forth
				end
			end
		ensure
			result_attached: Result /= Void
		end

	grid_item (a_column: INTEGER; a_row: INTEGER): detachable EVS_GRID_SEARCHABLE_ITEM
			-- Cell at `a_row' and `a_column' position.
			-- It may not be actual item in `grid' but your own item.
		require
			position_valid: is_position_valid (a_column, a_row)
		do
			Result := {like grid_item} / grid_item_function.item ([a_column, a_row])
		end

	item_text_function: detachable FUNCTION [TUPLE [a_item: EV_GRID_ITEM], like selection]
			-- Function to return text of `a_item'

feature{NONE} -- Implementation

	post_sort_actions_internal: detachable like post_sort_actions
			-- Implementation of `post_sort_actions'

	column_sort_info_internal: detachable like column_sort_info
			-- Internal `column_sort_info'

	sort_agent_table_internal: detachable like sort_agent_table
			-- Internal `sort_agent_table'

	update_sorted_columns (a_ctrl_pressed: BOOLEAN; a_next_column_to_sort: INTEGER)
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

	current_comparator: AGENT_LIST_COMPARATOR [G]
			-- Comparator used to sort
			-- 	The first two arguments are rows to be compared with each other
			-- 	The third integer argument is current sorting order
			-- 	Return value of this comparator should be True if the first row is less thant the second one.			
		do
			Result := comparator (sorted_columns)
		ensure
			result_attached: Result /= Void
		end

	comparator (a_column_index: LIST [INTEGER]): AGENT_LIST_COMPARATOR [G]
			-- Comparator to sort columns whose indexes are specified by `a_comlumn_index'
		require
			a_column_index_attached: a_column_index /= Void
			not_a_column_index_is_empty: not a_column_index.is_empty
		local
			l_sort_info: like column_sort_info
			l_action_list: ARRAYED_LIST [FUNCTION [G, G, INTEGER, BOOLEAN]]
			l_order_list: ARRAYED_LIST [INTEGER]
			l_index_list: ARRAYED_LIST [INTEGER]
		do
			l_sort_info := column_sort_info
			create l_action_list.make (a_column_index.count)
			create l_order_list.make (a_column_index.count)
			create l_index_list.make (a_column_index.count)
			from
				a_column_index.start
			until
				a_column_index.after
			loop
				if attached l_sort_info.item (a_column_index.item) as l_sort_info_item then
					l_action_list.extend (l_sort_info_item.comparator)
					l_order_list.extend (l_sort_info_item.current_order)
					l_index_list.extend (a_column_index.item)
				end
				a_column_index.forth
			end
			create Result.make (l_action_list, l_order_list, l_index_list)
		ensure
			result_attached: Result /= Void
		end

	is_ctrl_key_pressed: BOOLEAN
			-- Is Ctrl key pressed?
			-- Take `is_multi_column_sorting_forced' into consideration.
		do
			Result := is_multi_column_sorting_forced or else ev_application.ctrl_pressed
		end

	sort_agent_table: HASH_TABLE [PROCEDURE, INTEGER]
			-- Table to store sort agents, key is column index, value is sort agent for that column
		local
			l_sort_agent_table_internal: like sort_agent_table_internal
		do
			l_sort_agent_table_internal := sort_agent_table_internal
			if l_sort_agent_table_internal = Void then
				create l_sort_agent_table_internal.make (grid.column_count)
				sort_agent_table_internal := l_sort_agent_table_internal
			end
			Result := l_sort_agent_table_internal
		ensure
			result_attached: Result /= Void
		end

	last_sorted_column_internal: INTEGER
			-- Index of last sorted column
			-- 0 if no sort has been applied.

	sorting_order_snapshort: LINKED_LIST [TUPLE [a_column_index: INTEGER; a_sorting_order: INTEGER]]
			-- Snapshot of current sorting status
			-- The first item in list is the first column (whose index is `a_column_index') to be sorted usring `a_sorting_order'.			
		local
			l_columns: like sorted_columns
		do
			l_columns := sorted_columns
			create Result.make
			from
				l_columns.start
			until
				l_columns.after
			loop
				if attached column_sort_info.item (l_columns.item) as l_item then
					Result.extend ([l_columns.item, l_item.current_order])
				end
				l_columns.forth
			end
		ensure
			result_attached: Result /= Void
		end

	default_ensure_visible_action (a_item: EVS_GRID_SEARCHABLE_ITEM; a_selected: BOOLEAN)
			-- Ensure that `a_item' is visible.
			-- If `a_selected' is True, make sure that `a_item' is in its selected status.
		require
			a_item_attached: a_item /= Void
		local
			l_grid_item: EV_GRID_ITEM
			l_grid: like grid
		do
			l_grid_item := a_item.grid_item
			if not l_grid_item.is_destroyed and then l_grid_item.is_parented then
				l_grid := grid
				l_grid.remove_selection
				if l_grid.is_single_item_selection_enabled then
					l_grid_item.enable_select
				elseif l_grid.is_single_row_selection_enabled then
					l_grid_item.row.enable_select
				end
				if a_selected then
					l_grid_item.enable_select
				end
			end
		end

	default_selection_function: like selection
			-- Default implementation for `selection_function'
			-- This feature only take EV_GRID_LABEL_ITEM and its descendants into consideration.
			-- If you have other type of grid item, use `selection_function' to define your own selection function.
		local
			l_sorted_items: LIST [EV_GRID_ITEM]
			l_last_column_index: INTEGER
			l_last_row_index: INTEGER
			l_is_grid_tree_enabled: BOOLEAN
			l_item: EV_GRID_ITEM
			l_item_text_functon: like item_text_function

			l_sorted_rows: LIST [EV_GRID_ROW]
			l_row: EV_GRID_ROW
			l_column_index: INTEGER
			l_column_count: INTEGER
		do
			l_item_text_functon := item_text_function
			if l_item_text_functon /= Void then
				create {STRING_32} Result.make (512)
				l_is_grid_tree_enabled := grid.is_tree_enabled
				if not grid.is_single_item_selection_enabled then
					l_sorted_items := topologically_sorted_items (grid.selected_items)
					from
						l_last_column_index := 1
						l_sorted_items.start
					until
						l_sorted_items.after
					loop
						l_item := l_sorted_items.item_for_iteration
						l_row := l_item.row
						if l_row.height > 0 and then is_row_recursively_expanded (l_row) then
							if l_item.row.index /= l_last_row_index then
								if l_last_row_index /= 0 then
									Result.append ("%N")
								end
								if l_is_grid_tree_enabled then
									Result.append (tabs (row_indentation (l_item.row)))
								end
								l_last_row_index := l_item.row.index
								l_last_column_index := 1
							end
							Result.append (tabs (l_item.column.index - l_last_column_index))
							l_last_column_index := l_item.column.index
							if attached l_item_text_functon.item ([l_item]) as l_text then
								Result.append (l_text)
							end
						end
						l_sorted_items.forth
					end
				else
					l_sorted_rows := topologically_sorted_rows (grid.selected_rows)
					from
						l_sorted_rows.start
					until
						l_sorted_rows.after
					loop
						l_row := l_sorted_rows.item_for_iteration
						if l_row.height > 0 and then is_row_recursively_expanded (l_row) then
							if l_is_grid_tree_enabled then
								Result.append (tabs (row_indentation (l_row)))
							end
							from
								l_column_index := 1
								l_column_count := grid.column_count
							until
								l_column_index > l_column_count
							loop
								if attached l_row.item (l_column_index) as l_row_item and then attached l_item_text_functon.item ([l_row_item]) as l_text then
									Result.append (l_text)
									Result.append ("%T")
								else
									Result.append (once "%T%T")
								end
								l_column_index := l_column_index + 1
							end
							Result.append ("%N")
						end
						l_sorted_rows.forth
					end
				end
			else
				Result := ""
			end
		ensure
			result_attached: Result /= Void
		end

	is_row_recursively_expanded (a_row: EV_GRID_ROW): BOOLEAN
			-- Is `a_row' recursively expanded?
		require
			a_row_attached: a_row /= Void
			a_row.parent /= Void
		local
			l_row: detachable EV_GRID_ROW
		do
			Result := True
			from
				l_row := a_row.parent_row
			until
				l_row = Void or else not Result
			loop
				Result := l_row.is_expandable and then l_row.is_expanded
				l_row := l_row.parent_row
			end
		end

	topologically_sorted_items (a_item_list: LIST [EV_GRID_ITEM]): LIST [EV_GRID_ITEM]
			-- Sorted representation of `a_item_list'.
			-- Item order is decided by `grid_item_order_tester'.
		require
			a_item_list_attached: a_item_list /= Void
		local
			l_tester: AGENT_EQUALITY_TESTER [EV_GRID_ITEM]
			l_sorter: QUICK_SORTER [EV_GRID_ITEM]
		do
			create {ARRAYED_LIST [EV_GRID_ITEM]}Result.make (a_item_list.count)
			from
				a_item_list.start
			until
				a_item_list.after
			loop
				Result.force (a_item_list.item)
				a_item_list.forth
			end
			create l_tester.make (agent grid_item_order_tester)
			create l_sorter.make (l_tester)
			l_sorter.sort (Result)
		ensure
			result_attached: Result /= Void
		end

	topologically_sorted_rows (a_row_list: LIST [EV_GRID_ROW]): LIST [EV_GRID_ROW]
			-- Sorted representation of `a_item_list'.
			-- Item order is decided by `grid_item_order_tester'.
		require
			a_row_list_attached: a_row_list /= Void
		local
			l_tester: AGENT_EQUALITY_TESTER [EV_GRID_ROW]
			l_sorter: QUICK_SORTER [EV_GRID_ROW]
		do
			create {ARRAYED_LIST [EV_GRID_ROW]}Result.make (a_row_list.count)
			from
				a_row_list.start
			until
				a_row_list.after
			loop
				Result.force (a_row_list.item)
				a_row_list.forth
			end
			create l_tester.make (agent grid_row_order_tester)
			create l_sorter.make (l_tester)
			l_sorter.sort (Result)
		ensure
			result_attached: Result /= Void
		end

	grid_item_order_tester (a_item: EV_GRID_ITEM; b_item: EV_GRID_ITEM): BOOLEAN
			-- Grid item order tester.
			-- If `a_item' is smaller than `b_item', return True, otherwise, False.
		require
			a_item_attached: a_item /= Void
			a_item_parented: a_item.is_parented
			b_item_attached: b_item /= Void
			b_item_parented: b_item.is_parented
		local
			l_a_item_row_index: INTEGER
			l_b_item_row_index: INTEGER
		do
			l_a_item_row_index := a_item.row.index
			l_b_item_row_index := b_item.row.index
			if l_a_item_row_index = l_b_item_row_index then
				Result := a_item.column.index < b_item.column.index
			else
				Result := l_a_item_row_index < l_b_item_row_index
			end
		end

	grid_row_order_tester (a_row, b_row: EV_GRID_ROW): BOOLEAN
			-- Grid row order tester.
			-- If `a_row' is smaller than `b_row', return True, otherwise, False.
		require
			a_row_attached: a_row /= Void
			b_row_attached: b_row /= Void
		do
			Result := a_row.index < b_row.index
		end

	tabs (n: INTEGER): STRING
			-- String representation of `n' tabs
		require
			n_non_negative: n >= 0
		do
			create Result.make_filled ('%T', n)
		ensure
			result_attached: Result /= Void
		end

	row_indentation (a_row: EV_GRID_ROW): INTEGER
			-- Row indentation of `a_row'.
			-- Root row has indentation 0.
		require
			a_row_attached: a_row /= Void
			a_row_parented: a_row.parent /= Void
		local
			l_row: detachable EV_GRID_ROW
		do
			from
				l_row := a_row.parent_row
			until
				l_row = Void
			loop
				Result := Result + 1
				l_row := l_row.parent_row
			end
		ensure
			good_result: Result >= 0
		end

	on_ctrl_c_pressed
			-- Action to be performed when Ctrl+C is pressed
		do
			if attached selection as l_text and then not l_text.is_empty then
				ev_application.clipboard.set_text (l_text.twin)
			end
		end

	on_ctrl_a_pressed
			-- Action to be performed when Ctrl+A is pressed
		do
			if grid.is_multiple_row_selection_enabled or grid.is_multiple_item_selection_enabled then
				if attached select_all_action as act then
					act.call (Void)
				else
					default_select_all_action
				end
			end
		end

	on_copy_using_key (a_key: EV_KEY)
			-- Action to be performed to deal with Ctr+A or Ctrl+C key press
		require
			a_key_attached: a_key /= Void
		local
			l_code: INTEGER
		do
			if ev_application.ctrl_pressed then
				l_code := a_key.code
				if l_code = {EV_KEY_CONSTANTS}.key_c or l_code = {EV_KEY_CONSTANTS}.key_insert then
					on_ctrl_c_pressed
				elseif l_code = {EV_KEY_CONSTANTS}.key_a then
					on_ctrl_a_pressed
				end
			end
		end

	on_copy_using_key_agent: PROCEDURE [EV_KEY]
			-- Agent of `on_copy_using_key'
		local
			l_on_copy_using_key_agent_internal: like on_copy_using_key_agent_internal
		do
			l_on_copy_using_key_agent_internal := on_copy_using_key_agent_internal
			if l_on_copy_using_key_agent_internal = Void then
				l_on_copy_using_key_agent_internal := agent on_copy_using_key
				on_copy_using_key_agent_internal := l_on_copy_using_key_agent_internal
			end
			Result := l_on_copy_using_key_agent_internal
		ensure
			result_attached: Result /= Void
		end

	on_copy_using_key_agent_internal: detachable like on_copy_using_key_agent
			-- Implementation of `on_copy_using_key_agent'

	default_select_all_action
			-- Default action to select all items in `grid'
		local
			l_grid: like grid
			l_row_index: INTEGER
			l_row_count: INTEGER
		do
			l_grid := grid
			l_row_count := l_grid.row_count
			if l_row_count > 0 then
				from
					l_row_index := 1
				until
					l_row_index > l_row_count
				loop
					l_grid.select_row (l_row_index)
					l_row_index := l_row_index + 1
				end
			end
		end

	extreme_index_of_sorted_columns (a_largest: BOOLEAN): INTEGER
			-- Max (if `a_largest' is True) or min (if `a_largest' is False) index of sorted columns
			-- 0 if no sort had occurred.
		local
			l_sorted_columns: like sorted_columns
		do
			l_sorted_columns := sorted_columns
			if not l_sorted_columns.is_empty then
				Result := l_sorted_columns.first
				if l_sorted_columns.count > 1 then
					from
						l_sorted_columns.move (2)
					until
						l_sorted_columns.after
					loop
						if a_largest then
							Result := Result.max (l_sorted_columns.item)
						else
							Result := Result.min (l_sorted_columns.item)
						end
						l_sorted_columns.forth
					end
				end
			end
		end

invariant
	sorted_columns_attached: sorted_columns /= Void
	grid_attached: grid /= Void
	grid_item_function_attached: grid_item_function /= Void
	ensure_visible_action_attached: ensure_visible_action /= Void

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
