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
	
	EV_PRIMITIVE_I
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
			to_implement ("EV_GRID_I.column")
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
		
	is_header_displayed: BOOLEAN is
			-- Is the header displayed in `Current'.
		do
			to_implement ("EV_GRID_I.is_header_displayed")
		end

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
			to_implement ("EV_GRID_I.show_header")
		ensure
			header_displayed: is_header_displayed
		end
		
	hide_header is
			-- Ensure header is hidden.
		do
			to_implement ("EV_GRID_I.hide_header")
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

	insert_row (a_row: EV_GRID_ROW; i: INTEGER) is
			-- Insert `a_row' between rows `i' and `i+1'
		require
			a_row_not_void: a_row /= Void
			a_row_not_parented: a_row.parent = Void
			i_positive: i > 0
			i_less_than_row_count: i <= row_count
		do
			to_implement ("EV_GRID_I.insert_row")
		ensure
			row_count_set: row_count = old row_count + 1
			row_i_unchanged: row (i) = old row (i)
			row_inserted: row (i + 1) = a_row
			row_i_plus_one_shifted:
				(i < old row_count) implies (row (i + 2) = old row (i + 1))
			row_parented: a_row.parent /= Void
		end

	insert_row_parented (a_row: EV_GRID_ROW; i: INTEGER; a_parent_row: EV_GRID_ROW) is
			-- Insert `a_row' between rows `i' and `i+1'
		require
			a_row_not_void: a_row /= Void
			a_row_not_parented: a_row.parent = Void
			i_positive: i > 0
			i_less_than_row_count: i <= row_count
			a_parent_row: a_parent_row /= Void
		do
			to_implement ("EV_GRID_I.insert_row_parented")
		ensure
			row_count_set: row_count = old row_count + 1
			row_i_unchanged: row (i) = old row (i)
			row_inserted: row (i + 1) = a_row
			row_i_plus_one_shifted:
				(i < old row_count) implies (row (i + 2) = old row (i + 1))
			row_parented: a_row.parent_row = a_parent_row
		end

	insert_column (a_column: EV_GRID_COLUMN; i: INTEGER) is
			-- Insert `a_column' between columns `i' and `i+1'
		require
			a_column_not_void: a_column /= Void
			a_column_not_parented: a_column.parent = Void
			i_positive: i > 0
			i_less_than_column_count: i <= column_count
		do
			to_implement ("EV_GRID_I.insert_column")
		ensure
			column_count_set: column_count = old column_count + 1
			column_i_unchanged: column (i) = old column (i)
			column_inserted: column (i + 1) = a_column
			column_i_plus_one_shifted:
				(i < old column_count) implies (column (i + 2) = old column (i + 1))
			column_parented: a_column.parent /= Void
		end

	set_row (a_row: EV_GRID_ROW; i: INTEGER) is
			-- Replace column `i' by `a_row'
		require
			a_row_not_void: a_row /= Void
			a_row_not_parented: a_row.parent = Void
			i_positive: i > 0
			i_less_than_row_count: i <= row_count
		do
			to_implement ("EV_GRID_I.set_row")
		ensure
			inserted: row (i) = a_row
			a_row_parented: a_row.parent /= Void
		end

	set_column (a_column: EV_GRID_COLUMN; i: INTEGER) is
			-- Replace column at position `i' by `a_column'
		require
			a_column_not_void: a_column /= Void
			a_column_not_parented: a_column.parent = Void
			i_positive: i > 0
			i_less_than_column_count: i <= column_count
		do
			to_implement ("EV_GRID_I.set_column")
		ensure
			inserted: column (i) = a_column
			a_column_parented: a_column.parent /= Void
		end

	set_item (a_column, a_row: INTEGER; a_item: EV_GRID_ITEM) is
			-- Replace grid item at position (`a_column', `a_row') with `a_item'
		require
			a_column_positive: a_column > 0
			a_row_positive: a_row > 0
			a_item_not_void: a_item /= Void
		do
			to_implement ("EV_GRID_I.set_item")
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
		ensure
			row_count_updated: row_count = old row_count - 1
			old_row_removed: (old row (a_row)).parent = Void
		end

feature -- Measurements

	column_count: INTEGER
			-- Number of columns in Current

	row_count: INTEGER
			-- Number of rows in Current

feature {NONE} -- Implementation

	row_list: SPECIAL [SPECIAL [EV_GRID_ITEM]]
	
		-- Drawing object used to display `Current'

	initialize_grid is
			-- Initialize `Current'. To be called during `initialize' of
			-- the implementation classes.
		do
			create drawer.make_with_grid (Current)	
			create drawable
		end

	drawable: EV_DRAWING_AREA
		-- Drawing area for `Current' on which all drawing operations are performed.
		
	drawer: EV_GRID_DRAWER_I
		-- Drawer which is able to redraw `Current'.

feature {EV_ANY_I} -- Implementation

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

