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

feature -- Access

	row (a_row: INTEGER): EV_GRID_ROW is
			-- Row `a_row'
		require
			a_row_positive: a_row > 0
			a_row_not_greater_than_row_count: a_row <= row_count
		do
			to_implement ("EV_GRID_I.row")
		ensure
			row_not_void: Result /= Void
		end

	column (a_column: INTEGER): EV_GRID_COLUMN is
			-- Column number `a_column'
		require
			a_column_positive: a_column > 0
			a_column_not_greater_than_column_count: a_column <= column_count
		local
			a_col_i: EV_GRID_COLUMN_I
		do
			a_col_i := grid_columns @ a_column
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
			grid_row: SPECIAL [EV_GRID_ITEM_I]
			a_item: EV_GRID_ITEM
			a_grid_column: EV_GRID_COLUMN
			grid_item_i: EV_GRID_ITEM_I
		do
			grid_row :=  row_list @ (a_row - 1)
			if grid_row = Void then
					insert_new_row (a_row)
					grid_row := row_list @ (a_row - 1)
			end
			if a_column > grid_row.count then
				enlarge_row (a_row, a_column)
			end
			
			grid_item_i := grid_row @ (a_column - 1)
			
			if grid_item_i = Void  then
				create a_item
				grid_item_i := a_item.implementation
				grid_row.put (grid_item_i, (a_column - 1))
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
		do
			to_implement ("EV_GRID_I.show_column")
		ensure
			column_displayed: column_displayed (a_column)
		end
		
	hide_column (a_column: INTEGER) is
			-- Ensure column `a_column' is not visible in `Current'.
		require
			a_column_within_bounds: a_column > 0 and a_column <= column_count
		do
			to_implement ("EV_GRID_I.hide_column")
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
			header.show
		ensure
			header_displayed: is_header_displayed
		end
		
	hide_header is
			-- Ensure header is hidden.
		do
			is_header_displayed := False
			header.hide
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
		do
			to_implement ("EV_GRID_I.column_displayed")
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
		local
			a_grid_row: EV_GRID_ROW
			a_row_data: SPECIAL [EV_GRID_ITEM_I]
		do
			create a_grid_row
			a_grid_row.implementation.set_grid_i (Current)
			
			create a_row_data.make (1)
			if row_list.count < a_index then
				enlarge_row_list (a_index)
			end
			row_list.put (a_row_data, a_index - 1)
			
			grid_rows.put (a_grid_row.implementation, a_index)
			row_count := row_count + 1
		ensure
			row_count_set: row_count = old row_count + 1
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
			-- Insert a new column at index `a_index'.
		require
			i_positive: a_index > 0
		local
			a_column: EV_GRID_COLUMN
			column_implementation: EV_GRID_COLUMN_I
		do
			create a_column
			column_implementation := a_column.implementation
			column_implementation.set_grid_i (Current)
			column_implementation.set_index (a_index)
			column_implementation.set_physical_index (column_count)
			grid_columns.put (column_implementation, a_index)
			column_count := column_count + 1
			
				-- Now add the header for the new item.
				fixme ("[
					Needs to use the actual index of the column taking into account those that are hidden before it.
					Also headers before may be needed to pad it out.
					]")
			header.go_i_th (a_index)
			header.put_left (column_implementation.header_item)
		ensure
			column_count_set: column_count = old column_count + 1
		end

	move_row (i, j: INTEGER) is
			-- Move row at index `i' to index `j'
		require
			i_positive: i > 0
			j_positive: j > 0
			i_less_than_row_count: i <= row_count
			j_less_than_row_count: j <= row_count
		do

		ensure
			moved: row (j) = old row (i) and then row (j) /= row (i)
		end

	move_column (i, j: INTEGER) is
			-- Move row at index `i' to index `j'
		require
			i_positive: i > 0
			i_less_than_column_count: i <= column_count
			j_less_than_column_count: j <= column_count
		do

		ensure
			moved: column (j) = old column (i) and then column (j) /= column (i)
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
		do
			a_item.implementation.set_parent_grid_i (Current)
			a_grid_col_i :=  grid_columns @ a_column
			if a_grid_col_i = Void then
				insert_new_column (a_column)
				a_grid_col_i := grid_columns @ a_column
			end
			a_grid_row_i := grid_rows @ a_row
			if a_grid_row_i = Void then
				insert_new_row (a_row)
				a_grid_row_i := grid_rows @ a_row
			end
			if a_grid_row_i.count < a_column then
				enlarge_row (a_row, a_column)
			end
			
			row_list.item (a_row - 1).put (a_item.implementation, a_grid_col_i.physical_index)
			
		ensure
			inserted: column (a_column).item (a_row) = a_item
		end

feature -- Removal

	remove_column (a_column: INTEGER) is
			-- Remove column `a_column'.
		require
			a_column_positive: a_column > 0
			a_column_less_than_column_count: a_column <= column_count
		do
			to_implement ("EV_GRID_I.remove_column")
			column_count := column_count - 1
		ensure
			column_count_updated: column_count = old column_count - 1
			old_column_removed: (old column (a_column)).parent = Void
		end
		
	remove_row (a_row: INTEGER) is
			-- Remove row `a_row'.
		require
			a_row_positive: a_row > 0
			a_row_less_than_row_count: a_row <= row_count
		do
			to_implement ("EV_GRID_I.remove_row")
			row_count := row_count - 1
		ensure
			row_count_updated: row_count = old row_count - 1
			old_row_removed: (old row (a_row)).parent = Void
		end

feature -- Measurements

	column_count: INTEGER
			-- Number of columns in Current

	row_count: INTEGER
			-- Number of rows in Current

feature {EV_GRID_COLUMN_I, EV_GRID_I} -- Implementation

	index_of_column (a_column: EV_GRID_COLUMN): INTEGER is
			-- index of column `a_column'.
		require
			a_column /= Void
			a_column_parent_grid_is_current: grid_columns.has_item (a_column.implementation)
		do
			Result := grid_columns.key_for_iteration
		end

feature {EV_GRID_COLUMN_I, EV_GRID_I, EV_GRID_DRAWER_I} -- Implementation

	enlarge_row_list (new_count: INTEGER) is
			-- Enlarge the row list to to count `new_count'
		require
			valid_new_count: new_count > row_list.count
		do
			row_list := row_list.aliased_resized_area (new_count)
			row_count := new_count
		ensure
			count_increased: row_list.count = new_count
		end

	enlarge_row (a_index, new_count: INTEGER) is
			-- Enlarge the row at index `a_index' to `new_count'.
		require
			row_exists: row_list @ (a_index - 1) /= Void
			row_can_expand: (row_list @ a_index).count < new_count
		local
			a_row: SPECIAL [EV_GRID_ITEM_I]
		do
			a_row := row_list @ (a_index - 1)
			a_row := a_row.aliased_resized_area (new_count)
			row_list.put (a_row, (a_index - 1))
		end

	row_list: SPECIAL [SPECIAL [EV_GRID_ITEM_I]]
		-- Array of individual row's data, row by row
		-- The row data returned from `row_list' @ i may be Void for optimization purposes
		-- If the row data returned is not Void, some of the contents of this returned row data may be Void
		-- The row data stored in `row_list' @ i may not necessarily be in the order of logical columns
		-- The actual ordering is queried from `logical_to_physical_mapping'

	visible_physical_column_indexes: SPECIAL [INTEGER] is
			-- Phy
		local
			i: INTEGER
		do
			create Result.make (column_count)
			from
				i := 1
			until
				i > column_count
			loop
				Result.put (i, i)
			end
		end
	
	grid_rows: HASH_TABLE [EV_GRID_ROW_I, INTEGER]
		-- Hash table returning the appropriate EV_GRID_ROW from a given index

	grid_columns: HASH_TABLE [EV_GRID_COLUMN_I, INTEGER]
		-- Hash table returning the appropriate EV_GRID_COLUMN from a given index

	visible_column_list: SPECIAL [INTEGER]
		-- List of the visible column indexes in the grid from left to right.

	visible_column_count: INTEGER
		-- Number of visible columns present in the grid.
		
feature {EV_GRID_DRAWER_I} -- Implementation

	drawable: EV_DRAWING_AREA
		-- Drawing area for `Current' on which all drawing operations are performed.

feature {NONE} -- Implementation

	initialize_grid is
			-- Initialize `Current'. To be called during `initialize' of
			-- the implementation classes.
		local
			vertical_box, l_vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
		do
			set_minimum_size (default_minimum_size, default_minimum_size)
			create row_list.make (5)
			create grid_columns.make (5)
			create grid_rows.make (5)
			
			create drawer.make_with_grid (Current)
			create drawable
			create vertical_scroll_bar
			create horizontal_scroll_bar
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
			
				-- This ensures that the two scroll bars meet exactly at the corners
				-- with `scroll_bar_spacer' displayed in the corner.
			scroll_bar_spacer.set_minimum_height (horizontal_scroll_bar.minimum_height)
			
			create viewport
			vertical_box.extend (viewport)
			vertical_box.extend (horizontal_scroll_bar)
			vertical_box.disable_item_expand (horizontal_scroll_bar)
			create vertical_box
			create header
			header.set_minimum_height (default_header_height)
			vertical_box.extend (header)
			vertical_box.disable_item_expand (header)
			create drawable
			vertical_box.extend (drawable)
			viewport.extend (vertical_box)
			extend (horizontal_box)
			viewport.resize_actions.extend (agent viewport_resized)
			drawable.resize_actions.force_extend (agent drawer.partial_redraw)
		end
		
	viewport_resized (an_x, a_y, a_width, a_height: INTEGER) is
			--
		do
			viewport.set_item_size ((viewport.width).max (viewport.item.minimum_width), (viewport.height).max (viewport.item.minimum_height))
		end
		
	vertical_scroll_bar: EV_VERTICAL_SCROLL_BAR
		-- Vertical scroll bar of `Current'.
	
	horizontal_scroll_bar: EV_HORIZONTAL_SCROLL_BAR
		-- Horizontal scroll bar of `Current'.
		
	viewport: EV_VIEWPORT
		-- Viewport containing `header' and `drawable', permitting the header to be offset
		-- correctly in relation to the horizontal scroll bar.
		
	header: EV_HEADER
		-- Header displayed at top of `Current'.
		
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

feature {EV_ANY_I, EV_GRID_ROW, EV_GRID_COLUMN, EV_GRID} -- Implementation

	interface: EV_GRID
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.
			
invariant
	row_count_non_negative: row_count >= 0
	column_count_non_negative: column_count >= 0
	drawer_not_void: is_initialized implies drawer /= Void
	drawable_not_void: is_initialized implies drawable /= Void
	
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

