indexing
	description: "[
		Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST.
		Implementation Interface.
			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_GRID_I

inherit
	EV_CELL_I
		rename
			item as cell_item
		redefine
			interface
		end
	
	REFACTORING_HELPER
	
	EV_STOCK_COLORS
		export
			{NONE} all
		end

feature -- Access

	row (a_row: INTEGER): EV_GRID_ROW is
			-- Row `a_row'
		require
			a_row_positive: a_row > 0
			a_row_not_greater_than_row_count: a_row <= row_count
		do
			Result := row_internal (a_row).interface
		ensure
			row_not_void: Result /= Void
		end

	column (a_column: INTEGER): EV_GRID_COLUMN is
			-- Column number `a_column'
		require
			a_column_positive: a_column > 0
			a_column_not_greater_than_column_count: a_column <= column_count
		do
			Result := column_internal (a_column).interface
		ensure
			column_not_void: Result /= Void
		end

	visible_column (i: INTEGER): EV_GRID_COLUMN is
			-- `i'-th visible column
		require
			i_positive: i > 0
			i_column_not_greater_than_visible_column_count: i <= visible_column_count
		local
			a_col_i: EV_GRID_COLUMN_I
		do
			a_col_i := grid_columns @ i
			if a_col_i /= Void then
				Result := a_col_i.interface
			end
		ensure
			column_not_void: Result /= Void
		end

	item (a_row: INTEGER; a_column: INTEGER): EV_GRID_ITEM is
			-- Cell at `a_row' and `a_column' position
		require
			a_row_positive: a_row > 0
			a_row_less_than_row_count: a_row <= row_count
			a_column_positive: a_column > 0
			a_column_less_than_column_count: a_column <= column_count
		local
			grid_row_i: EV_GRID_ROW_I
			grid_row: SPECIAL [EV_GRID_ITEM_I]
			a_item: EV_GRID_ITEM
			a_grid_column_i: EV_GRID_COLUMN_I
			grid_item_i: EV_GRID_ITEM_I
			col_index: INTEGER
		do
			grid_row_i := row_internal (a_row)
			grid_row :=  internal_row_data @ a_row
			if a_column > grid_row.count then
				enlarge_row (a_row, a_column)
				grid_row := internal_row_data @ a_row
			end
			
			a_grid_column_i := column_internal (a_column)
			col_index := a_grid_column_i.physical_index
			
			grid_item_i := grid_row @ (col_index)
			
			if grid_item_i = Void  then
				create a_item
				grid_item_i := a_item.implementation
				grid_item_i.set_parents (Current, a_grid_column_i, grid_row_i)
				grid_row.put (grid_item_i, (col_index))
			end
			Result := grid_item_i.interface
		ensure
			item_not_void: Result /= Void
		end
		
	selected_rows: ARRAYED_LIST [EV_GRID_ROW] is
			-- All rows selected in `Current'.
		do
			to_implement ("EV_GRID_I.selected_rows")
		ensure
			result_not_void: Result /= Void
		end
		
	selected_items: ARRAYED_LIST [EV_GRID_ITEM] is
			-- All items selected in `Current'.
		do
			to_implement ("EV_GRID_I.selected_items")
		ensure
			result_not_void: Result /= Void
		end
		
	is_header_displayed: BOOLEAN
			-- Is the header displayed in `Current'.
			
	is_resizing_divider_enabled: BOOLEAN
			-- Is a vertical divider displayed during column resizing?
			
	is_resizing_divider_solid: BOOLEAN
			-- Is resizing divider displayed during column resizing drawn as a solid line?
			-- If `False', a dashed line style is used.
			
	is_horizontal_scrolling_per_item: BOOLEAN
			-- Is horizontal scrolling performed on a per-item basis?
			-- If `True', each change of the horizontal scroll bar increments the horizontal
			-- offset by the current column width.
			-- If `False', the scrolling is smooth on a per-pixel basis.
		
	is_vertical_scrolling_per_item: BOOLEAN
			-- Is vertical scrolling performed on a per-item basis?
			-- If `True', each change of the vertical scroll bar increments the vertical
			-- offset by the current row height.
			-- If `False', the scrolling is smooth on a per-pixel basis.
			
	is_content_partially_dynamic: BOOLEAN
			-- Is the content of `Current' partially dynamic? If `True' then
			-- whenever an item must be re-drawn and it is not already set within `Current',
			-- then it is queried via `content_requested_actions'. The returned item is added
			-- to `Current' so the query only occurs once.
		
	is_content_completely_dynamic: BOOLEAN
			-- Is the content of `Current' completely dynamic? If `True' then
			-- whenever an item must be re-drawn it is always queried via `content_requested_actions'
			-- and not added to `Current'.
		
	is_row_height_fixed: BOOLEAN
			-- Must all rows in `Current' have the same height?
		
	row_height: INTEGER
			-- Height of all rows within `Current'.
			
	dynamic_content_function: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], EV_GRID_ITEM]
			-- Function which computes the item that resides in a particular position of the
			-- grid while `is_content_partially_dynamic' or `is_content_completely_dynamic.

feature -- Status setting

	enable_tree is
			-- Enable tree functionality for GRID
		do
			to_implement ("EV_GRID_I.enable_tree")
		ensure
			tree_enabled: is_tree_enabled
		end	
		
	show_column (a_column: INTEGER) is
			-- Ensure column `a_column' is visible in `Current'.
		require
			a_column_within_bounds: a_column > 0 and a_column <= column_count
		local
			a_col_i: EV_GRID_COLUMN_I
		do
			a_col_i := column (a_column).implementation
			if not a_col_i.is_visible then
				a_col_i.set_is_visible (True)
				visible_column_count := visible_column_count + 1
			end
			
			fixme ("Implement showing of column header%N")
		ensure
			column_displayed: column_displayed (a_column)
		end
		
	hide_column (a_column: INTEGER) is
			-- Ensure column `a_column' is not visible in `Current'.
		require
			a_column_within_bounds: a_column > 0 and a_column <= column_count
		local
			a_col_i: EV_GRID_COLUMN_I
		do
			a_col_i := column (a_column).implementation
			if a_col_i.is_visible then
				a_col_i.set_is_visible (False)
				visible_column_count := visible_column_count - 1
			end
			
			fixme ("Implement hiding of column header%N")
		ensure
			column_not_displayed: not column_displayed (a_column)
		end
		
	select_column (a_column: INTEGER) is
			-- Ensure all items in `a_column' are selected.
		require
			a_column_within_bounds: a_column > 0 and a_column <= column_count
			column_displayed: column_displayed (a_column)
		do
			to_implement ("EV_GRID_I.hide_column")
		ensure
			-- column_selected: column (a_column).forall (item (j).is_selected
		end
		
	select_row (a_row: INTEGER) is
			-- Ensure all items in `a_row' are selected.
		require
			a_row_within_bounds: a_row > 0 and a_row <= row_count
			column_displayed: column_displayed (a_row)
		do
			to_implement ("EV_GRID_I.hide_column")
		ensure
			-- column_selected: column (a_row).forall (item (i).is_selected
		end
		
	enable_single_row_selection is
			-- Set user selection mode so that clicking an item selects the whole row,
			-- unselecting any previous rows.
		do
			to_implement ("EV_GRID_I.enable_single_row_selection")
		ensure
			single_row_selection_enabled: single_row_selection_enabled
		end
		
	enable_multiple_row_selection is
			-- Set user selection mode so that clicking an item selects the whole row.
			-- Multiple rows may be selected.
		do
			to_implement ("EV_GRID_I.enable_multiple_row_selection")
		ensure
			multiple_row_selection_enabled: multiple_row_selection_enabled
		end
		
	enable_single_item_selection is
			-- Set user selection mode so that clicking an item selects the item,
			-- unselecting any previous items.
		do
			to_implement ("EV_GRID_I.enable_single_item_selection")
		ensure
			single_item_selection_enabled: single_item_selection_enabled
		end
		
	enable_multiple_item_selection is
			-- Set user selection mode so that clicking an item selects the item.
			-- Multiple items may be selected.
		do
			to_implement ("EV_GRID_I.enable_multiple_item_selection")
		ensure
			multiple_item_selection_enabled: multiple_item_selection_enabled
		end
		
	show_header is
			-- Ensure header displayed.
		do
			is_header_displayed := True
			header_viewport.show
		ensure
			header_displayed: is_header_displayed
		end
		
	hide_header is
			-- Ensure header is hidden.
		do
			is_header_displayed := False
			header_viewport.hide
		ensure
			header_not_displayed: not is_header_displayed
		end
		
	set_first_visible_row (a_row: INTEGER) is
			-- Set `a_row' as the first row visible in `Current' as long
			-- as there are enough rows after `a_row' to fill the remainder of `Current'.
		do
			to_implement ("EV_GRID_I.set_first_visible_row")
		ensure
			-- Enough following rows implies `first_visible_row' = a_row.
			-- Can be calculated from `height' of `Current' and row heights.
		end
		
	enable_resizing_divider is
			-- Ensure a vertical divider is displayed during column resizing.
		do
			is_resizing_divider_enabled := True
		ensure
			resizing_divider_enabled: is_resizing_divider_enabled
		end
		
	disable_resizing_divider is
			-- Ensure no vertical divider is displayed during column resizing.
		do
			is_resizing_divider_enabled := False
		ensure
			resizing_divider_disabled: not is_resizing_divider_enabled
		end
		
	enable_solid_resizing_divider is
			-- Ensure resizing divider displayed during column resizing
			-- is displayed as a solid line.
		do
			is_resizing_divider_solid := True
		ensure
			solid_resizing_divider: is_resizing_divider_solid
		end
		
	disable_solid_resizing_divider is
			-- Ensure resizing divider displayed during column resizing
			-- is displayed as a dashed line.
		do
			is_resizing_divider_solid := False
		ensure
			dashed_resizing_divider: not is_resizing_divider_solid
		end
		
	enable_horizontal_scrolling_per_item is
			-- Ensure horizontal scrolling is performed on a per-item basis.
		do
			is_horizontal_scrolling_per_item := True
			has_horizontal_scrolling_per_item_just_changed := True
			recompute_horizontal_scroll_bar
			has_horizontal_scrolling_per_item_just_changed := False
		ensure
			horizontal_scrolling_performed_per_item: is_horizontal_scrolling_per_item
		end
		
	disable_horizontal_scrolling_per_item is
			-- Ensure horizontal scrolling is performed on a per-pixel basis.
		do
			is_horizontal_scrolling_per_item := False
			has_horizontal_scrolling_per_item_just_changed := True
			recompute_horizontal_scroll_bar
			has_horizontal_scrolling_per_item_just_changed := False
		ensure
			horizontal_scrolling_performed_per_pixel: not is_horizontal_scrolling_per_item
		end
	
	has_horizontal_scrolling_per_item_just_changed: BOOLEAN
			-- Has the horizontal scrolling method just been changed between
			-- per item and per pixel? This is used to adjust the scroll bar's position
			-- to approximate it's original position during the recomputation of it's
			-- settings in `recompute_horizontal_scroll_bar'.
	
	has_vertical_scrolling_per_item_just_changed: BOOLEAN
			-- Has the vertical scrolling method just been changed between
			-- per item and per pixel? This is used to adjust the scroll bar's position
			-- to approximate it's original position during the recomputation of it's
			-- settings in `recompute_vertical_scroll_bar'.
			
	is_item_height_changing: BOOLEAN
			-- Is height of items in `Current' changing?

	enable_vertical_scrolling_per_item is
			-- Ensure vertical scrolling is performed on a per-item basis.
		do
			is_vertical_scrolling_per_item := True
			has_vertical_scrolling_per_item_just_changed := True
			recompute_vertical_scroll_bar
			has_vertical_scrolling_per_item_just_changed := False
		ensure
			vertical_scrolling_performed_per_item: is_vertical_scrolling_per_item
		end
		
	disable_vertical_scrolling_per_item is
			-- Ensure vertical scrolling is performed on a per-pixel basis.
		do
			is_vertical_scrolling_per_item := False
			has_vertical_scrolling_per_item_just_changed := True
			recompute_vertical_scroll_bar
			has_vertical_scrolling_per_item_just_changed := False
		ensure
			vertical_scrolling_performed_per_pixel: not is_vertical_scrolling_per_item
		end
		
	set_row_height (a_row_height: INTEGER) is
			-- Set height of all rows within `Current' to `a_row_height
			-- If not `is_row_height_fixed' then set the height individually per row instead.
		require
			is_row_height_fixed: is_row_height_fixed
			a_row_height_positive: a_row_height >= 1
		do
			row_height := a_row_height
			is_item_height_changing := True
			recompute_vertical_scroll_bar
			is_item_height_changing := False
			redraw_client_area
		ensure
			row_height_set: row_height = a_row_height
		end
		
	enable_complete_dynamic_content is
			-- Ensure contents of `Current' must be retrieved when required via
			-- `content_requested_actions'. Contents are requested each time they
			-- are displayed even if already contained in `Current'.
		do
			is_content_completely_dynamic := True
			is_content_partially_dynamic := False
		ensure
			content_completely_dynamic: is_content_completely_dynamic
		end
		
	enable_partial_dynamic_content is
			-- Ensure contents of `Current' must be retrieved when required via
			-- `content_requested_actions' only if the item is not already set
			-- in `Current'.
		do
			is_content_partially_dynamic := True
			is_content_completely_dynamic := False
		ensure
			content_partially_dynamic: is_content_partially_dynamic
		end
		
	disable_dynamic_content is
			-- Ensure contents of `Current' are not dynamic and are no longer retrieved as such.
		do
			is_content_partially_dynamic := False
			is_content_completely_dynamic := False
		ensure
			content_not_dynamic: not is_content_completely_dynamic and not is_content_partially_dynamic
		end
		
	enable_row_height_fixed is
			-- Ensure all rows have the same height.
		do
			is_row_height_fixed := True
			recompute_vertical_scroll_bar
			row_offsets := Void
			redraw_client_area
		end
		
	disable_row_height_fixed is
			-- Permit rows to have varying heights.
		do
			is_row_height_fixed := False
			recompute_row_offsets (0)
			recompute_vertical_scroll_bar
			redraw_client_area
		end
		
	set_column_count_to (a_column_count: INTEGER) is
			-- Resize `Current' to have `a_column_count' columns.
		require
			content_is_dynamic: is_content_completely_dynamic or is_content_partially_dynamic
			a_column_count_positive: a_column_count >= 1
		do
			fixme ("Implement correct reducing of column count")
			from
			until
				grid_columns.count = a_column_count
			loop
				add_column_at (grid_columns.count + 1, True)
			end
			recompute_horizontal_scroll_bar
			redraw_client_area
		ensure
			column_count_set: column_count = a_column_count
		end
		
	set_row_count_to (a_row_count: INTEGER) is
			-- Resize `Current' to have `a_row_count' columns.
		require
			content_is_dynamic: is_content_completely_dynamic or is_content_partially_dynamic
			a_row_count_positive: a_row_count >= 1
		do
			resize_row_lists (a_row_count)
			fixme ("Implement correct reducing of row count")
			recompute_vertical_scroll_bar
			redraw_client_area
		ensure
			row_count_set: row_count = a_row_count
		end
		
	set_dynamic_content_function (a_function: FUNCTION [ANY, TUPLE [INTEGER, INTEGER], EV_GRID_ITEM]) is
			-- Function which computes the item that resides in a particular position of the
			-- grid while `is_content_partially_dynamic' or `is_content_completely_dynamic.
		require
			a_function_not_void: a_function /= Void
		do
			dynamic_content_function := a_function
		ensure
			dynamic_content_function_set: dynamic_content_function = a_function
		end

feature -- Status report

	is_tree_enabled: BOOLEAN is
			-- Is tree functionality enabled?
		do
			to_implement ("EV_GRID_I.is_tree_enabled")
		end
		
	column_displayed (a_column: INTEGER): BOOLEAN is
			-- Is column `a_column' displayed in `Current'?
		require
			a_column_within_bounds: a_column > 0 and a_column <= column_count
		local
			a_col_i: EV_GRID_COLUMN_I
		do
			a_col_i := column (a_column).implementation
			Result := a_col_i.is_visible
		end
		
	single_row_selection_enabled: BOOLEAN is
			-- Does clicking an item select the whole row, unselecting
			-- any previous rows?
		do
			to_implement ("EV_GRID_I.single_row_selection_enabled")
		end

	multiple_row_selection_enabled: BOOLEAN is
			-- Does clicking an item select the whole row, with multiple
			-- row selection permitted?
		do
			to_implement ("EV_GRID_I.multiple_row_selection_enabled")
		end
		
	single_item_selection_enabled: BOOLEAN is
			-- Does clicking an item select the item, unselecting
			-- any previous items?
		do
			to_implement ("EV_GRID_I.single_item_selection_enabled")
		end

	multiple_item_selection_enabled: BOOLEAN is
			-- Does clicking an item select the item, with multiple
			-- item selection permitted?
		do
			to_implement ("EV_GRID_I.multiple_item_selection_enabled")
		end
		
	first_visible_row: INTEGER is
			-- Index of first row visible in `Current' or 0 if `row_count' = 0.
		do
			to_implement ("EV_GRID_I.first_visible_row")
		ensure
			not_empty_implies_result_positive: row_count > 0 implies result > 0
			empty_implies_result_zero: row_count = 0 implies result = 0
		end

feature -- Element change

	insert_new_row (a_index: INTEGER) is
			-- Insert a new row at index `a_index'.
		require
			i_positive: a_index > 0
		do
			add_row_at (a_index, False)
		ensure
			row_count_set: (a_index < old row_count implies (row_count = old row_count + 1)) or a_index = row_count
		end

	insert_new_row_parented (i: INTEGER; a_parent_row: EV_GRID_ROW) is
			-- Insert `a_row' between rows `i' and `i+1'
		require
			i_positive: i > 0
			i_less_than_row_count: i <= row_count
			a_parent_row_not_void: a_parent_row /= Void
		do
			insert_new_row (i)
			a_parent_row.add_subrow (row (i))
		ensure
			row_count_set: row_count = old row_count + 1
			subrow_count_set: a_parent_row.subrow_count = old a_parent_row.subrow_count + 1
		end

	insert_new_column (a_index: INTEGER) is
			-- Insert a new column at index `a_index'
		require
			i_positive: a_index > 0
		do
			add_column_at (a_index, False)
		end

	move_row (i, j: INTEGER) is
			-- Move row at index `i' to index `j'
		require
			i_positive: i > 0
			j_positive: j > 0
			i_less_than_row_count: i <= row_count
			j_less_than_row_count: j <= row_count
		local
			a_row: EV_GRID_ROW_I
			a_row_data: SPECIAL [EV_GRID_ITEM_I]
		do
				--Retrieve row at position `i' and remove from list
			a_row := row_internal (i)
			grid_rows.go_i_th (i)
			grid_rows.remove
			
				-- Insert retrieved row at position `j'
			grid_rows.go_i_th (j)
			grid_rows.put_left (a_row)
			
			internal_row_data.go_i_th (i)
			a_row_data := internal_row_data.item
			internal_row_data.remove
			
			internal_row_data.go_i_th (j)
			internal_row_data.put_left (a_row_data)
			
			update_grid_row_indices (i.min (j))
			

			fixme ("EV_GRID_I: move_row redraw")
		ensure
			moved: row (j) = old row (i) and then (i /= j implies row (j) /= row (i))
		end

	move_column (i, j: INTEGER) is
			-- Move row at index `i' to index `j'
		require
			i_positive: i > 0
			j_positive: j > 0
			i_less_than_column_count: i <= column_count
			j_less_than_column_count: j <= column_count
		local
			a_col: EV_GRID_COLUMN_I
		do
				--Retrieve column at position `i' and remove from list
			a_col := column_internal (i)
			grid_columns.go_i_th (i)
			grid_columns.remove
			
				-- Insert retrieved column at position `j'
			grid_columns.go_i_th (j)
			grid_columns.put_left (a_col)
			
				-- Remove column from header and insert at the appropriate position
			fixme ("EV_GRID_I:move_column  add column header removal and redraw")
		ensure
			moved: column (j) = old column (i) and then (i /= j implies column (j) /= column (i))
		end

	set_item (a_column, a_row: INTEGER; a_item: EV_GRID_ITEM) is
			-- Replace grid item at position (`a_column', `a_row') with `a_item'
		require
			a_column_positive: a_column > 0
			a_row_positive: a_row > 0
			a_item_not_void: a_item /= Void
		local
			a_grid_col_i: EV_GRID_COLUMN_I
			a_grid_row_i: EV_GRID_ROW_I
			a_row_data: SPECIAL [EV_GRID_ITEM_I]
		do
				-- Create the corresponding row and column if not already present
			a_grid_col_i :=  column_internal (a_column)
			a_grid_row_i := row_internal (a_row)
			
				-- Set the appropriate parent values for grid, column and row
			a_item.implementation.set_parents (Current, a_grid_col_i, a_grid_row_i)

			a_row_data := internal_row_data @ a_row
			if a_row_data.count < a_grid_col_i.physical_index + 1 then
				enlarge_row (a_row, a_grid_col_i.physical_index + 1)
			end
			internal_row_data.i_th (a_row).put (a_item.implementation, a_grid_col_i.physical_index)	
		ensure
			inserted: column (a_column).item (a_row) = a_item
		end
		
	do_something is
			--
		do
			do_not_compute_scroll_bar := True
		end
		
	do_not_compute_scroll_bar: BOOLEAN

feature -- Removal

	remove_column (a_column: INTEGER) is
			-- Remove column `a_column'.
		require
			a_column_positive: a_column > 0
			a_column_less_than_column_count: a_column <= column_count
		local
			a_col_i: EV_GRID_COLUMN_I
			a_physical_index: INTEGER
		do
			a_col_i := column_internal (a_column)
			a_physical_index := a_col_i.physical_index
			
			grid_columns.go_i_th (a_column)
			grid_columns.remove
			
			if a_col_i.is_visible then
				visible_column_count := visible_column_count - 1
			end
			
				-- Remove association of column with `Current'
			a_col_i.remove_parent_grid_i
			
			to_implement ("EV_GRID_I:remove_column removal of header, redraw and blanking of items")
		ensure
			column_count_updated: column_count = old column_count - 1
			old_column_removed: (old column (a_column)).parent = Void
		end
		
	remove_row (a_row: INTEGER) is
			-- Remove row `a_row'.
		require
			a_row_positive: a_row > 0
			a_row_less_than_row_count: a_row <= row_count
		local
			a_row_i: EV_GRID_ROW_I
		do
				-- Retrieve row from the grid
			a_row_i := row_internal (a_row)
			
			grid_rows.go_i_th (a_row)
			grid_rows.remove
			
			internal_row_data.go_i_th (a_row)
			internal_row_data.remove
			
			update_grid_row_indices (a_row)
			
			
			to_implement ("EV_GRID_I.remove_row redraw plus subnode removal handling")
		ensure
			row_count_updated: row_count = old row_count - 1
			old_row_removed: (old row (a_row)).parent = Void
		end

feature -- Measurements

	visible_column_count: INTEGER
			-- Number of visible columns in Current

	column_count: INTEGER is
			-- Number of columns in Current
		do
			if grid_columns /= Void then
				Result := grid_columns.count
			end
		end

	row_count: INTEGER is
			-- Number of rows in Current
		do
			if internal_row_data /= Void then
				Result := internal_row_data.count
			end
		end

feature {NONE} -- Implementation

	internal_row_data: EV_GRID_ARRAYED_LIST [SPECIAL [EV_GRID_ITEM_I]]
		-- Array of individual row's data, row by row
		-- The row data returned from `row_list' @ i may be Void for optimization purposes
		-- If the row data returned is not Void, some of the contents of this returned row data may be Void
		-- The row data stored in `row_list' @ i may not necessarily be in the order of logical columns
		-- The actual ordering is queried from `visible_physical_column_indexes'

feature {EV_GRID_COLUMN_I, EV_GRID_I, EV_GRID_DRAWER_I, EV_GRID_ROW_I} -- Implementation

	row_list: SPECIAL [SPECIAL [EV_GRID_ITEM_I]] is
		-- Memory Array of individual row's data, row by row
		-- The row data returned from `row_list' @ i may be Void for optimization purposes
		-- If the row data returned is not Void, some of the contents of this returned row data may be Void
		-- The row data stored in `row_list' @ i may not necessarily be in the order of logical columns
		-- The actual ordering is queried from `visible_physical_column_indexes'
		do
			fixme ("Remove me and have `area' called directly from grid drawer ")
			Result := internal_row_data.area
		end

	visible_physical_column_indexes: SPECIAL [INTEGER] is
			-- Zero-based physical data indexes of the visible columns needed for `row_data' lookup whilst rendering cells
			-- A call to insert_new_column (2) on an empty grid will result in a `physical_index' of 0 as this is the first column added (zero-based indexing for `row_list')
			-- A following call to `insert_new_column (1) will result in a `physical_index' of 1 as this is the second column added
			-- If both columns were visible this query returns <<0, 1>>, so to draw the data for the appropriate columns to the screen, the indexes 0 and 1 need to be
			-- used to query the value returned from `row_list' @ i
			-- (`row_list' @ (i - 1)) @ (visible_physical_column_indexes @ (j - 1)) returns the 'j'-th visible column value for the `i'-th row in the grid.
		local
			i: INTEGER
			a_col: EV_GRID_COLUMN
		do
			create Result.make (visible_column_count)
			from
				i := 1
			until
				i > visible_column_count
			loop
				a_col := column (i)
				Result.put (i - 1, a_col.implementation.physical_index)
				i := i + 1
			end
		end

	previous_visible_column_from_index (a_index: INTEGER): INTEGER is
			-- Return the index of the previous visible column's logical index from index `a_index'
		require
			a_index_valid: a_index > 0 and then a_index <= column_count
		local
			i: INTEGER
			found: BOOLEAN
			a_column: EV_GRID_COLUMN
		do
			from
				i := a_index - 1
			until
				found or else i = 0
			loop
				a_column := column (i)
				found := a_column.implementation.is_visible
				i := i - 1
			end
			Result := i
		ensure
			index_valid: Result >= 0 and then Result < column_count
		end

	grid_rows: EV_GRID_ARRAYED_LIST [EV_GRID_ROW_I]
		-- Arrayed list returning the appropriate EV_GRID_ROW from a given logical index
		
	grid_columns: EV_GRID_ARRAYED_LIST [EV_GRID_COLUMN_I]
		-- Arrayed list returning the appropriate EV_GRID_COLUMN from a given logical index

	physical_column_count: INTEGER
		-- Number of physical columns stored in `row_list'
		
	recompute_row_offsets (an_index: INTEGER) is
			-- Recompute contents of `row_offsets' from row index
			-- `an_index' to `row_count'.
		require
			an_index_valid: an_index >= 0 and an_index <= row_count
			pop: grid_rows.count >= an_index
		local
			i: INTEGER
		do
			if not is_row_height_fixed then
					-- Only perform recomputation if the rows do not all have the same height.
					-- If they do, we do not need to use `row_offsets'.
				if row_offsets = Void then
					create row_offsets.make (row_count)
					row_offsets.extend (0)
					grid_rows.start
				else
					i := row_offsets @ (an_index)
					grid_rows.go_i_th (an_index)
				end
				
				from
				until
					grid_rows.off
				loop
					if grid_rows.item /= Void then
						i := i + grid_rows.item.height
					else
						i := i + 16
					end
					if grid_rows.index < row_offsets.count then
						row_offsets.put_i_th (i, grid_rows.index + 1)
					else
						row_offsets.extend (i)
					end
					grid_rows.forth
				end
			end
		ensure
			offsets_consistent_when_not_fixed: not is_row_height_fixed implies row_offsets.count = grid_rows.count + 1
		end
		
	total_row_height: INTEGER is
			-- `Result' is total height of all rows contained in `Current'.
		do
			if is_row_height_fixed then
				Result := row_count * row_height
			else
				Result := row_offsets.last
			end
		ensure
			result_positive: result >= 0
		end
	
	redraw_client_area is
			-- Redraw complete visible client area of `Current'.
		do
			drawable.redraw
		end

feature {EV_GRID_DRAWER_I, EV_GRID_COLUMN_I, EV_GRID_ROW_I, EV_DRAWABLE_GRID_ITEM_I} -- Implementation

	column_offsets: ARRAYED_LIST [INTEGER]
		-- Cumulative offset of each column in pixels.
		-- For example, if there are 5 columns, each with a width of 80 pixels,
		-- `column_offsets' contains 0, 80, 160, 240, 320, 400 (Note this is 6 items)
		
	row_offsets: ARRAYED_LIST [INTEGER]
		-- Cumulative offset of each row in pixels.
		-- For example, if there are 5 rows, each with a height of 16 pixels,
		-- `row_offsets' contains 0, 16, 32, 48, 64, 80 (Note this is 6 items)

	drawable: EV_DRAWING_AREA
		-- Drawing area for `Current' on which all drawing operations are performed.
		
	virtual_x_position: INTEGER
			-- Virtual X coordinate of `viewport' relative to left hand edge of grid.
		
	virtual_y_position: INTEGER
			-- Virtual Y coordinate of `viewport' relative to top edge of grid.

	viewport: EV_VIEWPORT
		-- Viewport containing `header' and `drawable', permitting the header to be offset
		-- correctly in relation to the horizontal scroll bar.
		
	header: EV_HEADER
		-- Header displayed at top of `Current'.
	
feature {NONE} -- Drawing implementation

	initialize_grid is
			-- Initialize `Current'. To be called during `initialize' of
			-- the implementation classes.
		local
			vertical_box, l_vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
		do
			set_minimum_size (default_minimum_size, default_minimum_size)
			set_background_color (white)
			is_horizontal_scrolling_per_item := False
			is_vertical_scrolling_per_item := True
			is_header_displayed := True
			row_height := 16
			is_row_height_fixed := True
			
			create internal_row_data.make
			create grid_columns.make
			create grid_rows.make
			
			create drawer.make_with_grid (Current)
			create drawable
			drawable.set_minimum_size (buffered_drawable_size, buffered_drawable_size)
			create vertical_scroll_bar
			vertical_scroll_bar.hide
			vertical_scroll_bar.set_leap (default_scroll_bar_leap)
			vertical_scroll_bar.change_actions.extend (agent vertical_scroll_bar_changed)
			create horizontal_scroll_bar
			horizontal_scroll_bar.set_step (default_scroll_bar_leap)
			horizontal_scroll_bar.change_actions.extend (agent horizontal_scroll_bar_changed)
			create horizontal_box
			create vertical_box
			horizontal_box.extend (vertical_box)
			create l_vertical_box
			horizontal_box.extend (l_vertical_box)
			l_vertical_box.extend (vertical_scroll_bar)
			horizontal_box.disable_item_expand (l_vertical_box)
			create scroll_bar_spacer
			l_vertical_box.extend (scroll_bar_spacer)
			l_vertical_box.disable_item_expand (scroll_bar_spacer)
			
			create header_viewport
			vertical_box.extend (header_viewport)
			vertical_box.disable_item_expand (header_viewport)
			create viewport
			vertical_box.extend (viewport)
			vertical_box.extend (horizontal_scroll_bar)
			vertical_box.disable_item_expand (horizontal_scroll_bar)
			horizontal_scroll_bar.hide
			create vertical_box
			
			
			create header
				-- Now connect events to `header' which are used to update the "physical size" of
				-- Current in response to their re-sizing.
			header.item_resize_actions.extend (agent header_item_resizing)
			header.item_resize_end_actions.extend (agent header_item_resize_ended)
			
			header_viewport.extend (header)
			header_viewport.set_minimum_height (default_header_height)
			header_viewport.set_item_size (maximum_header_width, default_header_height)
			viewport.extend (drawable)
			extend (horizontal_box)
			viewport.resize_actions.extend (agent viewport_resized)
			drawable.expose_actions.force_extend (agent drawer.partial_redraw)
			update_scroll_bar_spacer
		end
		
	recompute_column_offsets is
			-- Recompute contents of `column_offsets'.
		local
			i: INTEGER
		do
			create column_offsets.make (column_count)
			column_offsets.extend (0)
			from
				grid_columns.start
			until
				grid_columns.off
			loop
				i := i + grid_columns.item.width
				column_offsets.extend (i)
				grid_columns.forth
			end
		ensure
			counts_equal: column_offsets.count = column_count + 1
		end

	header_item_resizing (header_item: EV_HEADER_ITEM) is
			-- Respond to `header_item' being resized.
		require
			header_item_not_void: header_item /= Void
		do
				-- Update horizontal scroll bar size and position.
			recompute_horizontal_scroll_bar
			
			if is_resizing_divider_enabled then
					-- Draw a resizing line if enabled.
				draw_resizing_line (header.item_x_offset (header_item) + header_item.width)
			end
		end
		
	total_header_width: INTEGER is
			-- `Result' is total width of all header items contained within `header'.
		do
			if column_count >= 1 then
				Result := header.item_x_offset (header.last) + header.last.width
			end
		ensure
			result_non_negative: Result >= 0
		end
		
	header_item_resize_ended (header_item: EV_HEADER_ITEM) is
			-- Resizing has completed on `header_item'.
		require
			header_item_not_void: header_item /= Void
		do
			if is_resizing_divider_enabled then
				remove_resizing_line
			end
			fixme ("Only invalidate to the right hand side of the resized header item")
			recompute_column_offsets
			redraw_client_area
		end
		
	screen: EV_SCREEN is
			-- Once access to object of type EV_SCREEN.
		once
			create Result
		end
		
	draw_resizing_line (position: INTEGER) is
			-- Draw a resizing line at horizontal position relative to `drawable'.
			-- Clip line to drawable width.
		do
			if (position - viewport.x_offset > viewport.width) or
				(position - viewport.x_offset < 0) then
				remove_resizing_line
			else
				
					-- Draw line representing position in current divider style.
				if is_resizing_divider_solid then
					screen.disable_dashed_line_style
				else
					screen.enable_dashed_line_style
				end
				screen.set_invert_mode
				screen.draw_segment (drawable.screen_x + position, drawable.screen_y + resizing_line_border, drawable.screen_x + position, drawable.screen_y + viewport.height - resizing_line_border)
				if last_dashed_line_position > 0 then
					screen.draw_segment (last_dashed_line_position, drawable.screen_y + resizing_line_border, last_dashed_line_position, drawable.screen_y + viewport.height - resizing_line_border)
				end
				last_dashed_line_position := drawable.screen_x + position
			end
		end
		
	remove_resizing_line is
			-- Remove resizing line drawn on `drawable'.
		do
			fixme ("Must remove resizing line if the area in which it was previously drawn has been re-drawn by `Current'")
				-- Remove line representing position in current divider style.
			if is_resizing_divider_solid then
				screen.disable_dashed_line_style
			else
				screen.enable_dashed_line_style
			end
			screen.set_invert_mode
			screen.draw_segment (last_dashed_line_position, drawable.screen_y + resizing_line_border, last_dashed_line_position, drawable.screen_y + viewport.height - resizing_line_border)
			last_dashed_line_position := - 1
		ensure
			last_position_negative: last_dashed_line_position = -1
		end
		
	last_dashed_line_position: INTEGER
		-- Last horizontal coordinate of dashed line drawn when slider is moved.

	recompute_horizontal_scroll_bar is
			-- Recompute horizontal scroll bar positioning.
		local
			l_total_header_width: INTEGER
			l_client_width: INTEGER
			average_column_width: INTEGER
			previous_scroll_bar_value: INTEGER
		do
				-- Retrieve the 
			l_total_header_width := total_header_width
			
			l_client_width := viewport.width
				-- Note that `width' was not used as we want it to represent only the width of
				-- the "client area" which is `viewport'.
			
				
			if l_total_header_width > l_client_width then
					-- The headers are wider than the visible client area.
				if not horizontal_scroll_bar.is_show_requested then
						-- Show `horizontal_scroll_bar' if not already shown.
					horizontal_scroll_bar.show
					update_scroll_bar_spacer
				end
					-- Update the range and leap of `horizontal_scroll_bar' to reflect the relationship between
					-- `l_total_header_width' and `l_client_width'. Note that the behavior depends on the state of
					-- `is_horizontal_scrolling_per_item'.
				if has_horizontal_scrolling_per_item_just_changed then
					previous_scroll_bar_value := horizontal_scroll_bar.value
				end
				if is_horizontal_scrolling_per_item then					
					horizontal_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, column_count - 1))
					average_column_width := (l_total_header_width // column_count)
					horizontal_scroll_bar.set_leap (l_client_width // average_column_width)
					if has_horizontal_scrolling_per_item_just_changed then
							-- If we are just switching from per pixel to per item horizontal
							-- scrolling, we must approximate the previous position of the scroll bar.
						horizontal_scroll_bar.set_value (previous_scroll_bar_value // average_column_width)
					end
				else
					horizontal_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, l_total_header_width - l_client_width))
					horizontal_scroll_bar.set_leap (width)
					if has_horizontal_scrolling_per_item_just_changed then
							-- If we are just switching from per item to per pixel horizontal
							-- scrolling, we can set the position of the scroll bar exactly to match it's
							-- previous position.
						horizontal_scroll_bar.set_value (column_offsets @ (previous_scroll_bar_value + 1))
					end
				end
			else
					-- The headers are not as wide as the visible client area.
				if horizontal_scroll_bar.is_show_requested then
						-- Hide `horizontal_scroll_bar' as it is not required.
					horizontal_scroll_bar.hide
					update_scroll_bar_spacer
				end
			end
			
			if viewport.x_offset > 0 and (l_total_header_width - viewport.x_offset < viewport.width) then
					-- If `header' and `drawable' currently have a position that starts before the client area of
					-- `viewport' and the total header width is small enough so that at the current position, `header' and
					-- `drawable' do not reach to the very left-hand edge of the `viewport', update the horizontal offset
					-- so that they do reach the very left-hand edge of `viewport'
				horizontal_scroll_bar.change_actions.block
				viewport.set_x_offset ((l_total_header_width - viewport.width).max (0))
				header_viewport.set_x_offset ((l_total_header_width - viewport.width).max (0))
				
				horizontal_scroll_bar.change_actions.resume
			end
		end
		
	last_computed_row_height: INTEGER
		
	recompute_vertical_scroll_bar is
			-- Recompute dimensions of `vertical_scroll_bar'.
		local
			l_total_row_height: INTEGER
			l_client_height: INTEGER
			average_row_height: INTEGER
			previous_scroll_bar_value: INTEGER
		do
				-- Retrieve the final row offset as this is the virtual height required for all rows.
			if row_offsets = Void and not is_row_height_fixed then
				fixme ("Ensure that `row_offsets' does not need special `Void' handling.")
				l_total_row_height := 0
			else
				l_total_row_height := total_row_height
			end
			if l_total_row_height /= last_computed_row_height or has_vertical_scrolling_per_item_just_changed then
				l_client_height := viewport.height
					-- Note that `height' was not used as we want it to represent only the height of
					-- the "client area" which is `viewport'.
				
					
				if l_total_row_height > l_client_height then
						-- The rows are higher than the visible client area.
					if not vertical_scroll_bar.is_show_requested then
							-- Show `vertical_scroll_bar' if not already shown.
						vertical_scroll_bar.show
						update_scroll_bar_spacer
					end
						-- Update the range and leap of `vertical_scroll_bar' to reflect the relationship between
						-- `l_total_row_height' and `l_client_height'. Note that the behavior depends on the state of
						-- `is_vertical_scrolling_per_item'.
					if has_vertical_scrolling_per_item_just_changed or is_item_height_changing then
						previous_scroll_bar_value := vertical_scroll_bar.value
					end
					if is_vertical_scrolling_per_item then					
						vertical_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, row_count - 1))
						average_row_height := (l_total_row_height // row_count)
						vertical_scroll_bar.set_leap ((l_client_height // average_row_height).max (1))
						if has_vertical_scrolling_per_item_just_changed then
								-- If we are just switching from per pixel to per item vertical
								-- scrolling, we must approximate the previous position of the scroll bar.
							vertical_scroll_bar.set_value (previous_scroll_bar_value // average_row_height)
						end
						if is_item_height_changing then
								-- The `value' of the scroll bar should not have changed.
							check
								scroll_bar_not_moved: vertical_scroll_bar.value = previous_scroll_bar_value
							end
								-- We call the change actions explicitly, so that it behaves as if the value had just
								-- changed, which ensures that the currently scrolled to item is still displayed at the top.
							vertical_scroll_bar.change_actions.call ([previous_scroll_bar_value])
						end
					else
						vertical_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (0, l_total_row_height - l_client_height))
						vertical_scroll_bar.set_leap (height)
						if has_vertical_scrolling_per_item_just_changed then
								-- If we are just switching from per item to per pixel vertical
								-- scrolling, we can set the position of the scroll bar exactly to match it's
								-- previous position.
							vertical_scroll_bar.set_value (row_offsets @ (previous_scroll_bar_value + 1))
						end
					end
				else
						-- The rows are not as high as the visible client area.
					if vertical_scroll_bar.is_show_requested then
							-- Hide `vertical_scroll_bar' as it is not required.
						vertical_scroll_bar.hide
						update_scroll_bar_spacer
					end
				end
			end
			last_computed_row_height := l_total_row_height
		end
		
	vertical_scroll_bar_changed (a_value: INTEGER) is
			-- Respond to a change in value from `vertical_scroll_bar'.
		require
			a_value_non_negative: a_value >= 0
		local
			buffer_space: INTEGER
			current_buffer_position: INTEGER
		do
			if is_vertical_scrolling_per_item then
				if is_row_height_fixed then
					virtual_y_position := row_height * a_value
				else
					virtual_y_position := row_offsets.i_th (a_value + 1)
				end
			else
				virtual_y_position := a_value
			end
			buffer_space := (buffered_drawable_size - viewport.height)
			current_buffer_position := viewport.y_offset
			
			if (virtual_y_position > last_vertical_scroll_bar_value) and ((virtual_y_position - last_vertical_scroll_bar_value) + (current_buffer_position)) >= buffer_space then
				viewport.set_y_offset (0)
				redraw_client_area
			elseif (virtual_y_position < last_vertical_scroll_bar_value) and ((virtual_y_position - last_vertical_scroll_bar_value) + (current_buffer_position)) <= 0 then
				viewport.set_y_offset (buffer_space)
				redraw_client_area
			else
				viewport.set_y_offset (current_buffer_position + virtual_y_position - last_vertical_scroll_bar_value)
			end
			
			last_vertical_scroll_bar_value := virtual_y_position
		end

	horizontal_scroll_bar_changed (a_value: INTEGER) is
			-- Respond to a change in value from `horizontal_scroll_bar'.
		require
			a_value_non_negative: a_value >= 0
		local
			buffer_space: INTEGER
			current_buffer_position: INTEGER
		do
			if is_horizontal_scrolling_per_item then
				virtual_x_position := column_offsets.i_th (a_value + 1)
			else
				virtual_x_position := a_value
			end
			
			buffer_space := (buffered_drawable_size - viewport.width)
			current_buffer_position := viewport.x_offset
			
			if (virtual_x_position > last_horizontal_scroll_bar_value) and ((virtual_x_position - last_horizontal_scroll_bar_value) + (current_buffer_position)) >= buffer_space then
				viewport.set_x_offset (0)
				redraw_client_area
			elseif (virtual_x_position < last_horizontal_scroll_bar_value) and ((virtual_x_position - last_horizontal_scroll_bar_value) + (current_buffer_position)) < 0 then
				viewport.set_x_offset (buffer_space)
				redraw_client_area
			else
				viewport.set_x_offset (current_buffer_position + virtual_x_position - last_horizontal_scroll_bar_value)
			end
			header_viewport.set_x_offset (virtual_x_position)
			
			last_horizontal_scroll_bar_value := virtual_x_position
		end
		
	last_horizontal_scroll_bar_value: INTEGER
		-- Last value of `horizontal_scroll_bar' used within `horizontal_scroll_bar_changed'
		-- to determine how far the scroll bar has moved and whether or not the position of the virtual drawable
		-- needs to be "flipped". Although removing this computation may initially appear to work, there are
		-- drawing issues in the case that two consecutive scroll bar positions are greater than the excess space for
		-- virtual drawing.
		
	last_vertical_scroll_bar_value: INTEGER
		-- Last value of `vertical_scroll_bar' used within `vertical_scroll_bar_changed'. See
		-- comment of `last_horizontal_scroll_bar_value' for details of it's use.
		

	update_scroll_bar_spacer is
			-- Update `scroll_bar_spacer' so that it has the appropriate minimum dimensions
			-- given the visible state of `horizontal_scroll_bar' and `vertical_scroll_bar
			-- which results in the two scroll bars being positioned correctly in relation
			-- to each other.
		do
			if horizontal_scroll_bar.is_show_requested and vertical_scroll_bar.is_show_requested then
				scroll_bar_spacer.set_minimum_size (vertical_scroll_bar.width, horizontal_scroll_bar.height)
			else
				scroll_bar_spacer.set_minimum_size (0, 0)
			end
		end
		
	viewport_resized (an_x, a_y, a_width, a_height: INTEGER) is
			-- Respond to resizing of `Viewport' to width and height `a_width', `a_height'.
		require
			a_width_non_negative: a_width >= 0
			a_height_non_negative: a_height >= 0
		do
			if not header.is_empty then
					-- Update horizontal scroll bar size and position.
				recompute_horizontal_scroll_bar
			end
			if row_count /= 0 then
				recompute_vertical_scroll_bar
			end
		ensure
			viewport_item_at_least_as_big_as_viewport: viewport.item.width >= viewport.width and
				viewport.item.height >= viewport.height
		end
		
	vertical_scroll_bar: EV_VERTICAL_SCROLL_BAR
		-- Vertical scroll bar of `Current'.
	
	horizontal_scroll_bar: EV_HORIZONTAL_SCROLL_BAR
		-- Horizontal scroll bar of `Current'.
		
--	viewport: EV_VIEWPORT
--		-- Viewport containing `header' and `drawable', permitting the header to be offset
--		-- correctly in relation to the horizontal scroll bar.
		
	header_viewport: EV_VIEWPORT
		
	scroll_bar_spacer: EV_CELL
		-- A spacer to separate the corners of the scroll bars.
	
	fixed: EV_FIXED
		-- Main widget contained in `Current' used to manipulate the individual widgets required.
		
	drawer: EV_GRID_DRAWER_I
		-- Drawer which is able to redraw `Current'.
		
	default_header_height: INTEGER is 16
		-- Default height applied to `header'.
	
	default_minimum_size: INTEGER is 50
		-- Default minimum size dimensions for `Current'.
		
	resizing_line_border: INTEGER is 4
		-- Distance that resizing line is displayed from top and bottom edges of `drawable'.
		
	buffered_drawable_size: INTEGER is 2000
		-- Default size of `drawable' used for scrolling purposes.
		
feature {NONE} -- Implementation

	add_column_at (a_index: INTEGER; replace_existing_item: BOOLEAN) is
			-- Add a new column at index `a_index'.
			-- If `replace_existing_item' then replace value at `a_index', else insert at `a_index'
		require
			i_positive: a_index > 0
		local
			a_column_i: EV_GRID_COLUMN_I
		do
			a_column_i := (create {EV_GRID_COLUMN}).implementation
			a_column_i.set_grid_i (Current)

			a_column_i.set_physical_index (physical_column_count)
			physical_column_count := physical_column_count + 1
			
			if a_index > grid_columns.count then
				if replace_existing_item then
					grid_columns.resize (a_index)
				else
						-- Resize to new count minus 1 as we are inserting a new item, when item is inserted then count will be increased
					grid_columns.resize (a_index - 1)
				end
			end

			grid_columns.go_i_th (a_index)
			if replace_existing_item then
				grid_columns.replace (a_column_i)
			else
				grid_columns.put_left (a_column_i)
			end

			show_column (a_index)
			
				-- Now add the header for the new item.
				fixme ("[
					Needs to use the actual index of the column taking into account those that are hidden before it.
					Also headers before may be needed to pad it out.
					]")
			header.go_i_th (a_index)
			header.put_left (a_column_i.header_item)
			header_item_resizing (header.last)
			header_item_resize_ended (header.last)
		ensure
			column_count_set: not replace_existing_item implies ((a_index < old column_count implies (column_count = old column_count + 1)) or column_count = a_index)
		end

	add_row_at (a_index: INTEGER; replace_existing_item: BOOLEAN) is
			-- Add a new row at index `a_index'.
			-- If `replace_existing_item' then replace value at `a_index', else insert at `a_index'
		require
			i_positive: a_index > 0
		local
			grid_row_i: EV_GRID_ROW_I
			a_row_data: SPECIAL [EV_GRID_ITEM_I]
		do
			grid_row_i := (create {EV_GRID_ROW}).implementation
			
			create a_row_data.make (1)
			if a_index > row_count then
				if replace_existing_item then
						-- We are inserting at a certain value so we resize to one less
					resize_row_lists (a_index)
				else
					resize_row_lists (a_index - 1)
				end
			end

			grid_rows.go_i_th (a_index)
			internal_row_data.go_i_th (a_index)
			if replace_existing_item then
				internal_row_data.replace (a_row_data)
				grid_rows.replace (grid_row_i)
				grid_row_i.set_internal_index (a_index)
			else
				internal_row_data.put_left (a_row_data)
				grid_rows.put_left (grid_row_i)
					-- Update the index of `grid_row_i' and subsequent rows in `grid_rows'
				update_grid_row_indices (a_index)
			end
				-- Set grid of `grid_row' to `Current'
			grid_row_i.set_grid_i (Current)

			recompute_row_offsets (a_index)
			if do_not_compute_scroll_bar then
				recompute_vertical_scroll_bar
			end
		end

	update_grid_row_indices (a_index: INTEGER) is
			-- Recalculate subsequent row indexes starting from `a_index'
		local
			i, a_row_count: INTEGER
			row_i: EV_GRID_ROW_I
		do
				-- Set subsequent indexes to their new values
			from
				i := a_index
				a_row_count := grid_rows.count
			until
				i > a_row_count
			loop
				row_i := grid_rows @ i
				if row_i /= Void then
					row_i.set_internal_index (i)
				end
				i := i + 1
			end
		end

	resize_row_lists (new_count: INTEGER) is
			-- Resize the row lists so count equals `new_count'
		require
			valid_new_count: new_count >= 0
		do
			internal_row_data.resize (new_count)
			grid_rows.resize (new_count)
		ensure
			grid_rows_count_resized: grid_rows.count = new_count
			internal_row_data_count_resized: internal_row_data.count = new_count
			counts_equal: grid_rows.count = internal_row_data.count
		end
		
	maximum_header_width: INTEGER is 10000
		-- Maximium width of `header'.
		
	default_scroll_bar_leap: INTEGER is 1

	enlarge_row (a_index, new_count: INTEGER) is
			-- Enlarge the row at index `a_index' to `new_count'.
		require
			row_exists: row_list @ (a_index - 1) /= Void
			row_can_expand: (row_list @ (a_index - 1)).count < new_count
		local
			a_row: SPECIAL [EV_GRID_ITEM_I]
		do
			a_row := internal_row_data @ a_index
			a_row := a_row.aliased_resized_area (new_count)
			internal_row_data.put_i_th (a_row, a_index)
		end

	column_internal (a_column: INTEGER): EV_GRID_COLUMN_I is
			-- Column number `a_column', returns a new column if it doesn't exist
		require
			a_column_positive: a_column > 0
		do
			if not grid_columns.valid_index (a_column) then
				from
				until
					grid_columns.count = a_column
				loop
					add_column_at (grid_columns.count + 1, True)
				end
			end
			Result := grid_columns @ a_column
		ensure
			column_not_void: Result /= Void
		end

	row_internal (a_row: INTEGER): EV_GRID_ROW_I is
			-- Row `a_row',  creates a new one if it doesn't exist
		require
			a_row_positive: a_row > 0
		do
			if grid_rows.valid_index (a_row) then
				Result := grid_rows @ a_row
			end
			if Result = Void then
				add_row_at (a_row, True)
				Result := grid_rows @ a_row
			end
		ensure
			row_not_void: Result /= Void
		end

feature {EV_ANY_I, EV_GRID_ROW, EV_GRID_COLUMN, EV_GRID} -- Implementation

	interface: EV_GRID
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.
			
invariant
	row_count_non_negative: row_count >= 0
	column_count_non_negative: column_count >= 0
	drawer_not_void: is_initialized implies drawer /= Void
	drawable_not_void: is_initialized implies drawable /= Void
	header_positioned_corrently: is_initialized implies header_viewport.x_offset >= 0 and header_viewport.y_offset = 0
	virtual_x_position_valid_while_vertical_scrollbar_hidden: is_initialized and then not vertical_scroll_bar.is_show_requested implies virtual_x_position = 0
	virtual_x_position_valid_while_vertical_scrollbar_shown: is_initialized and then vertical_scroll_bar.is_show_requested implies virtual_x_position >= 0
	virtual_y_position_valid_while_horizontal_scrollbar_hidden: is_initialized and then not horizontal_scroll_bar.is_show_requested implies virtual_y_position = 0
	virtual_y_position_valid_while_horizontal_scrollbar_shown: is_initialized and then horizontal_scroll_bar.is_show_requested implies virtual_y_position >= 0
	row_heights_fixed_implies_row_offsets_void: is_row_height_fixed implies row_offsets = Void
	row_lists_count_equal: is_initialized implies internal_row_data.count = grid_rows.count
	dynamic_modes_mutually_exclusive: not (is_content_completely_dynamic and is_content_partially_dynamic)
	
end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

