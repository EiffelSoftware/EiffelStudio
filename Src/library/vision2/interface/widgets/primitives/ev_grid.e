indexing
	description: "Widget which is a combination of an EV_TREE and an EV_MULTI_COLUMN_LIST"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID

inherit
	EV_CELL
		rename
			item as cell_item
		redefine
			implementation,
			create_implementation,
			prunable,
			readable,
			writable,
			is_in_default_state
		end
	
	EV_GRID_ACTION_SEQUENCES
		undefine
			copy, is_equal, default_create
		end
	
	REFACTORING_HELPER
		undefine
			copy, is_equal, default_create
		end

feature -- Access

	row (a_row: INTEGER): EV_GRID_ROW is
			-- Row `a_row'
		require
			not_destroyed: not is_destroyed
			a_row_positive: a_row > 0
			a_row_not_greater_than_row_count: a_row <= row_count
		do
			Result := implementation.row (a_row)
		ensure
			row_not_void: Result /= Void
		end

	visible_column (i: INTEGER): EV_GRID_COLUMN is
			-- `i'-th visible column
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			i_not_greater_than_visible_column_count: i <= visible_column_count
		do
			Result := implementation.visible_column (i)
		ensure
			column_not_void: Result /= Void
		end

	column (a_column: INTEGER): EV_GRID_COLUMN is
			-- Column number `a_column'
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column > 0
			a_column_not_greater_than_column_count: a_column <= column_count
		do
			Result := implementation.column (a_column)
		ensure
			column_not_void: Result /= Void
		end

	item (a_row: INTEGER; a_column: INTEGER): EV_GRID_ITEM is
			-- Cell at `a_row' and `a_column' position
		require
			not_destroyed: not is_destroyed
			a_row_positive: a_row > 0
			a_row_less_than_row_count: a_row <= row_count
			a_column_positive: a_column > 0
			a_column_less_than_column_count: a_column <= column_count
		do
			Result := implementation.item (a_row, a_column)
		ensure
			item_not_void: Result /= Void
		end
		
	selected_rows: ARRAYED_LIST [EV_GRID_ROW] is
			-- All rows selected in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_rows
		ensure
			result_not_void: Result /= Void
		end
		
	selected_items: ARRAYED_LIST [EV_GRID_ITEM] is
			-- All items selected in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_items
		ensure
			result_not_void: Result /= Void
		end
		
	is_header_displayed: BOOLEAN is
			-- Is the header displayed in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_header_displayed
		end
		
	is_resizing_divider_enabled: BOOLEAN is
			-- Is a vertical divider displayed during column resizing?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_resizing_divider_enabled
		end
		
	is_resizing_divider_solid: BOOLEAN is
			-- Is resizing divider displayed during column resizing drawn as a solid line?
			-- If `False', a dashed line style is used.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_resizing_divider_solid
		end
		
	is_horizontal_scrolling_per_item: BOOLEAN is
			-- Is horizontal scrolling performed on a per-item basis?
			-- If `True', each change of the horizontal scroll bar increments the horizontal
			-- offset by the current column width.
			-- If `False', the scrolling is smooth on a per-pixel basis.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_horizontal_scrolling_per_item
			
		end
		
	is_vertical_scrolling_per_item: BOOLEAN is
			-- Is vertical scrolling performed on a per-item basis?
			-- If `True', each change of the vertical scroll bar increments the vertical
			-- offset by the current row height.
			-- If `False', the scrolling is smooth on a per-pixel basis.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_vertical_scrolling_per_item
		end
		
	is_content_partially_dynamic: BOOLEAN is
			-- Is the content of `Current' partially dynamic? If `True' then
			-- whenever an item must be re-drawn and it is not already set within `Current',
			-- then it is queried via `content_requested_actions'. The returned item is added
			-- to `Current' so the query only occurs once.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_content_partially_dynamic
		end
		
	is_content_completely_dynamic: BOOLEAN is
			-- Is the content of `Current' completely dynamic? If `True' then
			-- whenever an item must be re-drawn it is always queried via `content_requested_actions'
			-- and not added to `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_content_completely_dynamic
		end
		
	is_row_height_fixed: BOOLEAN is
			-- Must all rows in `Current' have the same height?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_row_height_fixed
		end
		
	row_height: INTEGER is
			-- Height of all rows within `Current'.
		require
			not_destroyed: not is_destroyed
			is_row_height_fixed: is_row_height_fixed
		do
			Result := implementation.row_height
		ensure
			result_non_negative: result >= 0
		end

feature -- Status setting

	enable_tree is
			-- Enable tree functionality for GRID
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_tree
		ensure
			tree_enabled: is_tree_enabled
		end	
		
	show_column (a_column: INTEGER) is
			-- Ensure column `a_column' is visible in `Current'.
		require
			not_destroyed: not is_destroyed
			a_column_within_bounds: a_column > 0 and a_column <= column_count
		do
			implementation.show_column (a_column)
		ensure
			column_displayed: column_displayed (a_column)
		end
		
	hide_column (a_column: INTEGER) is
			-- Ensure column `a_column' is not visible in `Current'.
		require
			not_destroyed: not is_destroyed
			a_column_within_bounds: a_column > 0 and a_column <= column_count
		do
			implementation.hide_column (a_column)
		ensure
			column_not_displayed: not column_displayed (a_column)
		end
		
	select_column (a_column: INTEGER) is
			-- Ensure all items in `a_column' are selected.
		require
			not_destroyed: not is_destroyed
			a_column_within_bounds: a_column > 0 and a_column <= column_count
			column_displayed: column_displayed (a_column)
		do
			implementation.select_column (a_column)
		ensure
			-- column_selected: column (a_column).forall (item (j).is_selected
		end
		
	select_row (a_row: INTEGER) is
			-- Ensure all items in `a_row' are selected.
		require
			not_destroyed: not is_destroyed
			a_row_within_bounds: a_row > 0 and a_row <= row_count
			column_displayed: column_displayed (a_row)
		do
			implementation.select_row (a_row)
		ensure
			-- column_selected: column (a_row).forall (item (i).is_selected
		end
		
	enable_single_row_selection is
			-- Set user selection mode so that clicking an item selects the whole row,
			-- unselecting any previous rows.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_single_row_selection
		ensure
			single_row_selection_enabled: single_row_selection_enabled
		end
		
	enable_multiple_row_selection is
			-- Set user selection mode so that clicking an item selects the whole row.
			-- Multiple rows may be selected.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_multiple_row_selection
		ensure
			multiple_row_selection_enabled: multiple_row_selection_enabled
		end
		
	enable_single_item_selection is
			-- Set user selection mode so that clicking an item selects the item,
			-- unselecting any previous items.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_single_item_selection
		ensure
			single_item_selection_enabled: single_item_selection_enabled
		end
		
	enable_multiple_item_selection is
			-- Set user selection mode so that clicking an item selects the item.
			-- Multiple items may be selected.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_multiple_item_selection
		ensure
			multiple_item_selection_enabled: multiple_item_selection_enabled
		end
		
	show_header is
			-- Ensure header displayed.
		require
			not_destroyed: not is_destroyed
		do
			implementation.show_header
		ensure
			header_displayed: is_header_displayed
		end
		
	hide_header is
			-- Ensure header is hidden.
		require
			not_destroyed: not is_destroyed
		do
			implementation.hide_header
		ensure
			header_not_displayed: not is_header_displayed
		end
		
	set_first_visible_row (a_row: INTEGER) is
			-- Set `a_row' as the first row visible in `Current' as long
			-- as there are enough rows after `a_row' to fill the remainder of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_first_visible_row (a_row)
		ensure
			-- Enough following rows implies `first_visible_row' = a_row.
			-- Can be calculated from `height' of `Current' and row heights.
		end
		
	enable_resizing_divider is
			-- Ensure a vertical divider is displayed during column resizing.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_resizing_divider
		ensure
			resizing_divider_enabled: is_resizing_divider_enabled
		end
		
	disable_resizing_divider is
			-- Ensure no vertical divider is displayed during column resizing.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_resizing_divider
		ensure
			resizing_divider_disabled: not is_resizing_divider_enabled
		end
		
	enable_solid_resizing_divider is
			-- Ensure resizing divider displayed during column resizing
			-- is displayed as a solid line.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_solid_resizing_divider
		ensure
			solid_resizing_divider: is_resizing_divider_solid
		end
		
	disable_solid_resizing_divider is
			-- Ensure resizing divider displayed during column resizing
			-- is displayed as a dashed line.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_solid_resizing_divider
		ensure
			dashed_resizing_divider: not is_resizing_divider_solid
		end
		
	enable_horizontal_scrolling_per_item is
			-- Ensure horizontal scrolling is performed on a per-item basis.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_horizontal_scrolling_per_item
		ensure
			horizontal_scrolling_performed_per_item: is_horizontal_scrolling_per_item
		end
		
	disable_horizontal_scrolling_per_item is
			-- Ensure horizontal scrolling is performed on a per-pixel basis.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_horizontal_scrolling_per_item
		ensure
			horizontal_scrolling_performed_per_pixel: not is_horizontal_scrolling_per_item
		end
		
	enable_vertical_scrolling_per_item is
			-- Ensure vertical scrolling is performed on a per-item basis.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_vertical_scrolling_per_item
		ensure
			vertical_scrolling_performed_per_item: is_vertical_scrolling_per_item
		end
		
	disable_vertical_scrolling_per_item is
			-- Ensure vertical scrolling is performed on a per-pixel basis.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_vertical_scrolling_per_item
		ensure
			vertical_scrolling_performed_per_pixel: not is_vertical_scrolling_per_item
		end
		
	set_row_height (a_row_height: INTEGER) is
			-- Set height of all rows within `Current' to `a_row_height
			-- If not `is_row_height_fixed' then set the height individually per row instead.
		require
			not_destroyed: not is_destroyed
			is_row_height_fixed: is_row_height_fixed
			a_row_height_positive: a_row_height >= 1
		do
			implementation.set_row_height (a_row_height)
		ensure
			row_height_set: row_height = a_row_height
		end
		
	enable_complete_dynamic_content is
			-- Ensure contents of `Current' must be retrieved when required via
			-- `content_requested_actions'. Contents are requested each time they
			-- are displayed even if already contained in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_complete_dynamic_content
		ensure
			content_completely_dynamic: is_content_completely_dynamic
		end
		
	enable_partial_dynamic_content is
			-- Ensure contents of `Current' must be retrieved when required via
			-- `content_requested_actions' only if the item is not already set
			-- in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_partial_dynamic_content
		ensure
			content_partially_dynamic: is_content_partially_dynamic
		end
		
	disable_dynamic_content is
			-- Ensure contents of `Current' are not dynamic and are no longer retrieved as such.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_dynamic_content
		ensure
			content_not_dynamic: not is_content_completely_dynamic and not is_content_partially_dynamic
		end
		
	enable_row_height_fixed is
			-- Ensure all rows have the same height.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_row_height_fixed
		ensure
			row_height_fixed: is_row_height_fixed
		end
		
	disable_row_height_fixed is
			-- Permit rows to have varying heights.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_row_height_fixed
		ensure
			row_height_variable: not is_row_height_fixed
		end
		
	set_column_count_to (a_column_count: INTEGER) is
			-- Resize `Current' to have `a_column_count' columns.
		require
			not_destroyed: not is_destroyed
			content_is_dynamic: is_content_completely_dynamic or is_content_partially_dynamic
			a_column_count_positive: a_column_count >= 1
		do
			implementation.set_column_count_to (a_column_count)
		ensure
			column_count_set: column_count = a_column_count
		end
		
	set_row_count_to (a_row_count: INTEGER) is
			-- Resize `Current' to have `a_row_count' columns.
		require
			not_destroyed: not is_destroyed
			content_is_dynamic: is_content_completely_dynamic or is_content_partially_dynamic
			a_row_count_positive: a_row_count >= 1
		do
			implementation.set_row_count_to (a_row_count)
		ensure
			row_count_set: row_count = a_row_count
		end

feature -- Status report

	prunable: BOOLEAN is False
			-- May items be removed?
			
	writable: BOOLEAN is False
			-- Is there a current item that may be modified?

	readable: BOOLEAN is False
			-- Is there a current item that may be accessed?

	is_tree_enabled: BOOLEAN is
			-- Is tree functionality enabled?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_tree_enabled
		end
		
	column_displayed (a_column: INTEGER): BOOLEAN is
			-- Is column `a_column' displayed in `Current'?
		require
			not_destroyed: not is_destroyed
			a_column_within_bounds: a_column > 0 and a_column <= column_count
		do
			Result := implementation.column_displayed (a_column)
		end
		
	single_row_selection_enabled: BOOLEAN is
			-- Does clicking an item select the whole row, unselecting
			-- any previous rows?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.single_row_selection_enabled
		end

	multiple_row_selection_enabled: BOOLEAN is
			-- Does clicking an item select the whole row, with multiple
			-- row selection permitted?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.multiple_row_selection_enabled
		end
		
	single_item_selection_enabled: BOOLEAN is
			-- Does clicking an item select the item, unselecting
			-- any previous items?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.single_item_selection_enabled
		end

	multiple_item_selection_enabled: BOOLEAN is
			-- Does clicking an item select the item, with multiple
			-- item selection permitted?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.multiple_item_selection_enabled
		end
		
	first_visible_row: INTEGER is
			-- Index of first row visible in `Current' or 0 if `row_count' = 0.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.first_visible_row
		ensure
			not_empty_implies_result_positive: row_count > 0 implies result > 0
			empty_implies_result_zero: row_count = 0 implies result = 0
		end

feature -- Element change

	insert_new_row (a_index: INTEGER) is
			-- Insert a new row at index `a_index'.
		require
			not_destroyed: not is_destroyed
			i_positive: a_index > 0
		do
			implementation.insert_new_row (a_index)
		ensure
			row_count_set: row_count = old row_count + 1
		end

	insert_new_row_parented (i: INTEGER; a_parent_row: EV_GRID_ROW) is
			-- Insert `a_row' between rows `i' and `i+1'
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			i_less_than_row_count: i <= row_count
			a_parent_row_not_void: a_parent_row /= Void
			a_parent_row_in_current: a_parent_row.parent = Current
		do
			implementation.insert_new_row_parented (i, a_parent_row)
		ensure
			row_count_set: row_count = old row_count + 1
			subrow_count_set: a_parent_row.subrow_count = old a_parent_row.subrow_count + 1
		end

	insert_new_column (a_index: INTEGER) is
			-- Insert a new column at index `a_index'.
		require
			not_destroyed: not is_destroyed
			i_positive: a_index > 0
		do
			implementation.insert_new_column (a_index)
		ensure
			column_count_set: (a_index < old column_count implies column_count = old column_count + 1) or else (a_index > old column_count implies a_index = column_count) 
			visible_column_count_set: visible_column_count = old visible_column_count + 1
		end

	move_row (i, j: INTEGER) is
			-- Move row at index `i' to index `j'
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			j_positive: j > 0
			i_less_than_row_count: i <= row_count
			j_less_than_row_count: j <= row_count
		do
			implementation.move_row (i, j)
		ensure
			moved: row (j) = old row (i) and then row (j) /= row (i)
		end

	move_column (i, j: INTEGER) is
			-- Move row at index `i' to index `j'
		require
			not_destroyed: not is_destroyed
			i_positive: i > 0
			i_less_than_column_count: i <= column_count
			j_less_than_column_count: j <= column_count
		do
			implementation.move_column (i, j)
		ensure
			moved: column (j) = old column (i) and then column (j) /= column (i)
		end	

	set_item (a_column, a_row: INTEGER; a_item: EV_GRID_ITEM) is
			-- Replace grid item at position (`a_column', `a_row') with `a_item'
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column > 0
			a_row_positive: a_row > 0
			a_item_not_void: a_item /= Void
		do
			implementation.set_item (a_column, a_row, a_item)
		ensure
			inserted: column (a_column).item (a_row) = a_item
		end

feature -- Removal

	remove_column (a_column: INTEGER) is
			-- Remove column `a_column'.
		require
			not_destroyed: not is_destroyed
			a_column_positive: a_column > 0
			a_column_less_than_column_count: a_column <= column_count
		do
			implementation.remove_column (a_column)
		ensure
			column_count_updated: column_count = old column_count - 1
			old_column_removed: (old column (a_column)).parent = Void
		end
		
	remove_row (a_row: INTEGER) is
			-- Remove row `a_row'.
		require
			not_destroyed: not is_destroyed
			a_row_positive: a_row > 0
			a_row_less_than_row_count: a_row <= row_count
		do
			implementation.remove_row (a_row)
		ensure
			row_count_updated: row_count = old row_count - 1
			old_row_removed: (old row (a_row)).parent = Void
		end

feature -- Measurements

	column_count: INTEGER is
			-- Number of columns in Current
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.column_count
		ensure
			result_positive: Result >= 1
		end
		
	visible_column_count: INTEGER is
			-- Number of visible columns in Current
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.visible_column_count
		ensure
			result_valid: Result >= 0 and Result <= column_count
		end

	row_count: INTEGER is
			-- Number of rows in Current
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.row_count
		ensure
			result_positive: Result >= 1
		end
		
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := not is_horizontal_scrolling_per_item and
				is_vertical_scrolling_per_item and is_header_displayed and
				is_row_height_fixed
		end
			
feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_GRID_I
		-- Responsible for interaction with native graphics toolkit.
	
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_IMP} implementation.make (Current)
		end

invariant
	row_count_non_negative: row_count >= 0
	column_count_non_negative: column_count >= 0

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
