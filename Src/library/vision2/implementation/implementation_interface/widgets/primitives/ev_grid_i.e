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
		do
			to_implement ("EV_GRID_I.row")
		ensure
			row_not_void: Result /= Void
		end

	column (a_column: INTEGER): EV_GRID_COLUMN is
			-- Column number `a_column'
		require
			a_column_positive: a_column > 0
			a_column_less_than_column_count: a_column <= column_count
		do
			Result := grid_columns @ a_column
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
		do
			to_implement ("EV_GRID_I.item")
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
			rebuild_widget_structure
		ensure
			header_displayed: is_header_displayed
		end
		
	hide_header is
			-- Ensure header is hidden.
		do
			is_header_displayed := False
			rebuild_widget_structure
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
		do
			create a_grid_row.make_with_grid_i (Current)
			grid_rows.put (a_grid_row, a_index)
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
		do
			create a_column.make_with_grid_i (Current)
			a_column.set_index (a_index)
			grid_columns.put (a_column, a_index)
			column_count := column_count + 1
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
			a_grid_col: EV_GRID_COLUMN
			a_grid_row: EV_GRID_ROW
		do
			a_item.implementation.set_parent_grid_i (Current)
			a_grid_col :=  grid_columns @ a_column
			if a_grid_col = Void then
				insert_new_column (a_column)
			end
			a_grid_row := grid_rows @ a_row
			if a_grid_row = Void then
				insert_new_row (a_row)
			end
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

feature {EV_GRID_COLUMN, EV_GRID_I} -- Implementation

	index_of_column (a_column: EV_GRID_COLUMN): INTEGER is
			-- index of column `a_column'.
		require
			a_column /= Void
			a_column_parent_grid_is_current: grid_columns.has_item (a_column)
		do
			Result := grid_columns.key_for_iteration
		end

feature {EV_GRID_COLUMN, EV_GRID_I} -- Implementation

	row_list: SPECIAL [SPECIAL [EV_GRID_ITEM]]
		-- Array of individual row's data, row by row
	
	grid_rows: HASH_TABLE [EV_GRID_ROW, INTEGER]
		-- Hash table returning the appropriate EV_GRID_ROW from a given index

	grid_columns: HASH_TABLE [EV_GRID_COLUMN, INTEGER]
		-- Hash table returning the appropriate EV_GRID_COLUMN from a given index

	visible_column_list: SPECIAL [INTEGER]
		-- List of the visible column indexes in the grid from left to right.

	visible_column_count: INTEGER
		-- Number of visible columns present in the grid.

feature {NONE} -- Implementation

	initialize_grid is
			-- Initialize `Current'. To be called during `initialize' of
			-- the implementation classes.
		local
			header_item: EV_HEADER_ITEM
		do
			set_minimum_size (default_minimum_size, default_minimum_size)
			create row_list.make (5)
			create grid_columns.make (5)
			create grid_rows.make (5)
			
			create drawer.make_with_grid (Current)	
			create drawable
			create vertical_scroll_bar
			create horizontal_scroll_bar
			create fixed
			fixed.extend (vertical_scroll_bar)
			fixed.extend (horizontal_scroll_bar)
			create viewport
			fixed.extend (viewport)
			create vertical_box
			create header
			header.set_minimum_height (default_header_height)
			vertical_box.extend (header)
			vertical_box.disable_item_expand (header)
			create drawable
			vertical_box.extend (drawable)
			viewport.extend (vertical_box)
			viewport.resize_actions.extend (agent viewport_resized)
			fixed.resize_actions.extend (agent fixed_resized)
			extend (fixed)
		end
		
	rebuild_widget_structure is
			-- Rebuild widget structure of `Current' based on current size
			-- and internal properties.
		do
			fixed_resized (0, 0, width, height)
			drawer.full_redraw
		end

	fixed_resized (an_x, a_y, a_width, a_height: INTEGER) is
			-- Respond to a resize of `fixed'. Must position all contents based
			-- on current state.
		do
			fixed.set_item_position (vertical_scroll_bar, a_width - vertical_scroll_bar.minimum_width, 0)
			fixed.set_item_size (vertical_scroll_bar, vertical_scroll_bar.minimum_width, height - horizontal_scroll_bar.height)
			
			fixed.set_item_position (horizontal_scroll_bar, 0, a_height - horizontal_scroll_bar.minimum_height)
			fixed.set_item_size (horizontal_scroll_bar, width - vertical_scroll_bar.width, horizontal_scroll_bar.minimum_height)
			fixed.set_item_size (viewport, width - vertical_scroll_bar.width, height - horizontal_scroll_bar.height)
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

	drawable: EV_DRAWING_AREA
		-- Drawing area for `Current' on which all drawing operations are performed.
		
	header: EV_HEADER
		-- Header displayed at top of `Current'.
	
	vertical_box: EV_VERTICAL_BOX
		-- A vertical box to hold `header' and and `drawable' which is inserted within `viewport'.
	
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

