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
			Result := row_internal (a_row)
		ensure
			row_not_void: Result /= Void
		end

	column (a_column: INTEGER): EV_GRID_COLUMN is
			-- Column number `a_column'
		require
			a_column_positive: a_column > 0
			a_column_not_greater_than_column_count: a_column <= column_count
		do
			Result := column_internal (a_column)
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
			a_grid_row: EV_GRID_ROW
			grid_row: SPECIAL [EV_GRID_ITEM_I]
			a_item: EV_GRID_ITEM
			a_grid_column_i: EV_GRID_COLUMN_I
			grid_item_i: EV_GRID_ITEM_I
			col_index: INTEGER
		do
			a_grid_row := row_internal (a_row)
			grid_row :=  row_list @ (a_row - 1)
			if a_column > grid_row.count then
				enlarge_row (a_row, a_column)
				grid_row := row_list @ (a_row - 1)
			end
			
			a_grid_column_i := grid_columns @ a_column
			if a_grid_column_i /= Void then
				col_index := a_grid_column_i.physical_index
			else
				col_index := a_column - 1
			end
			
			grid_item_i := grid_row @ (col_index)
			
			if grid_item_i = Void  then
				create a_item
				grid_item_i := a_item.implementation
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

			if a_index > grid_rows.capacity then
				grid_rows.resize (a_index)
			end
			grid_rows.go_i_th (a_index)
			grid_rows.put_left (a_grid_row.implementation)
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

			column_implementation.set_physical_index (physical_column_count)
			physical_column_count := physical_column_count + 1
			
			if a_index > grid_columns.count then
				grid_columns.resize (a_index)
			end
			grid_columns.go_i_th (a_index)
			grid_columns.put_left (column_implementation)

			show_column (a_index)
			
				-- Now add the header for the new item.
				fixme ("[
					Needs to use the actual index of the column taking into account those that are hidden before it.
					Also headers before may be needed to pad it out.
					]")
			header.go_i_th (a_index)
			header.put_left (column_implementation.header_item)
			recompute_horizontal_scroll_bar
		ensure
			column_count_set: (a_index < old column_count implies (column_count = old column_count + 1)) or column_count = a_index
			visible_column_count_set: visible_column_count = old visible_column_count + 1
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
			a_row_data: SPECIAL [EV_GRID_ITEM_I]
		do
			a_item.implementation.set_parent_grid_i (Current)
			
				-- Create the corresponding row and column if not already present
			a_grid_col_i :=  column_internal (a_column).implementation
			a_grid_row_i := row_internal (a_row).implementation

			a_row_data := row_list.item (a_row - 1)
			if a_row_data.count < a_column then
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
		local
			a_col_i: EV_GRID_COLUMN_I
		do
			a_col_i := grid_columns @ a_column
			if a_col_i /= Void and then a_col_i.is_visible then
				visible_column_count := visible_column_count - 1
			end
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
			if	grid_rows /= Void then
				Result := grid_rows.count
			end
		end

feature {EV_GRID_COLUMN_I, EV_GRID_I, EV_GRID_DRAWER_I} -- Implementation

	enlarge_row_list (new_count: INTEGER) is
			-- Enlarge the row list to to count `new_count'
		require
			valid_new_count: new_count > row_list.count
		do
			row_list := row_list.aliased_resized_area (new_count)
		ensure
			count_increased: row_list.count = new_count
		end

	enlarge_row (a_index, new_count: INTEGER) is
			-- Enlarge the row at index `a_index' to `new_count'.
		require
			row_exists: row_list @ (a_index - 1) /= Void
			row_can_expand: (row_list @ (a_index - 1)).count < new_count
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
		-- The actual ordering is queried from `visible_physical_column_indexes'

	visible_physical_column_indexes: SPECIAL [INTEGER] is
			-- Zero-based physical data indexes of the visible columns needed for `row_data' lookup whilst rendering cells
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
			-- Return the index of the previous visible column's index from `a_index'
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
		-- Arrayed list returning the appropriate EV_GRID_ROW from a given index
		
	grid_columns: EV_GRID_ARRAYED_LIST [EV_GRID_COLUMN_I]
		-- Arrayed list returning the appropriate EV_GRID_COLUMN from a given index

	physical_column_count: INTEGER
		-- Number of physical columns stored in `row_list'

feature {EV_GRID_DRAWER_I} -- Implementation

	drawable: EV_DRAWING_AREA
		-- Drawing area for `Current' on which all drawing operations are performed.

feature {NONE} -- Drawing implementation

	initialize_grid is
			-- Initialize `Current'. To be called during `initialize' of
			-- the implementation classes.
		local
			vertical_box, l_vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
		do
			set_minimum_size (default_minimum_size, default_minimum_size)
			create row_list.make (5)
			create grid_columns.make (0)
			create grid_rows.make (0)
			
			create drawer.make_with_grid (Current)
			create drawable
			create vertical_scroll_bar
			create horizontal_scroll_bar
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
			
			header.set_minimum_height (default_header_height)
			vertical_box.extend (header)
			vertical_box.disable_item_expand (header)
			create drawable
			vertical_box.extend (drawable)
			viewport.extend (vertical_box)
			extend (horizontal_box)
			viewport.resize_actions.extend (agent viewport_resized)
			drawable.resize_actions.force_extend (agent drawer.partial_redraw)
			update_scroll_bar_spacer
		end
		
	header_item_resizing (header_item: EV_HEADER_ITEM) is
			-- Respond to `header_item' being resized.
		require
			header_item_not_void: header_item /= Void
		local
			l_total_header_width: INTEGER
			l_client_width: INTEGER
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
					-- `l_total_header_width' and `l_client_width'.
				horizontal_scroll_bar.value_range.adapt (create {INTEGER_INTERVAL}.make (1, l_total_header_width - l_client_width))
				horizontal_scroll_bar.set_leap (width)
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
				horizontal_scroll_bar.change_actions.resume
			end
			
			if is_resizing_divider_enabled then
					-- Draw a resizing line if enabled.
				draw_resizing_line (header.item_x_offset (header_item) + header_item.width)
			end
		end
		
	total_header_width: INTEGER is
			-- `Result' is total width of all header items contained within `header'.
		do
			Result := header.item_x_offset (header.last) + header.last.width
		ensure
			result_non_negative: Result >= 0
		end
		
	header_item_resize_ended (header_item: EV_HEADER_ITEM) is
			-- Resizing has completed on `header_item'.
		require
			header_item_not_void: header_item /= Void
		local
			l_total_header_width: INTEGER
		do
			if is_resizing_divider_enabled then
				remove_resizing_line
			end
			
			l_total_header_width := total_header_width
				-- Ensure that the total width of `header' and `drawable' are equal
				-- to the width of all headers combined or the client area of `viewport'.
			if l_total_header_width.max (viewport.width) > viewport.item.width then
				viewport.set_item_width (l_total_header_width.max (viewport.width))
			end
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
				screen.draw_segment (drawable.screen_x + position, drawable.screen_y + resizing_line_border, drawable.screen_x + position, drawable.screen_y + drawable.height - resizing_line_border)
				if last_dashed_line_position > 0 then
					screen.draw_segment (last_dashed_line_position, drawable.screen_y + resizing_line_border, last_dashed_line_position, drawable.screen_y + drawable.height - resizing_line_border)
				end
				last_dashed_line_position := drawable.screen_x + position
			end
		end
		
	remove_resizing_line is
			-- Remove resizing line drawn on `drawable'.
		do
				-- Remove line representing position in current divider style.
			if is_resizing_divider_solid then
				screen.disable_dashed_line_style
			else
				screen.enable_dashed_line_style
			end
			screen.set_invert_mode
			screen.draw_segment (last_dashed_line_position, drawable.screen_y + resizing_line_border, last_dashed_line_position, drawable.screen_y + drawable.height - resizing_line_border)
			last_dashed_line_position := - 1
		ensure
			last_position_negative: last_dashed_line_position = -1
		end
		
	last_dashed_line_position: INTEGER
		-- Last horizontal coordinate of dashed line drawn when slider is moved.

	recompute_horizontal_scroll_bar is
			-- Recompute horizontal scroll bar positioning.
		do
			header_item_resizing (header.last)
			header_item_resize_ended (header.last)
		end

	horizontal_scroll_bar_changed (a_value: INTEGER) is
			-- Respond to a change in value from `horizontal_scroll_bar'.
		require
			a_value_non_negative: a_value >= 0
		do
			viewport.set_x_offset (a_value)
		ensure
			viewport_offset_set: viewport.x_offset = a_value
		end

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
		local
			new_width, new_height: INTEGER
		do
				-- If the width of the item contained in `viewport' is smaller than the width of the viewport,
				-- enlarge it to the viewport's width.
			if viewport.item.width < viewport.width then
				new_width := viewport.width
			else
				new_width := viewport.item.width
			end
				-- Ensure that the height of the viewport's item always matches that of the viewport.
			if viewport.item.height /= viewport.height then
				new_height := viewport.height
			end
				-- Now actually perform size setting.
			viewport.set_item_size (new_width, new_height)

			if not header.is_empty then
					-- Update horizontal scroll bar settings.
				header_item_resizing (header.last)
			end
		ensure
			viewport_item_at_least_as_big_as_viewport: viewport.item.width >= viewport.width and
				viewport.item.height >= viewport.height
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
		
	resizing_line_border: INTEGER is 4
		-- Distance that resizing line is displayed from top and bottom edges of `drawable'.

feature {EV_ANY_I, EV_GRID_ROW, EV_GRID_COLUMN, EV_GRID} -- Implementation

	column_internal (a_column: INTEGER): EV_GRID_COLUMN is
			-- Column number `a_column', returns a new column if it doesn't exist
		require
			a_column_positive: a_column > 0
		local
			a_col_i: EV_GRID_COLUMN_I
		do
			if grid_columns.valid_index (a_column) then
				a_col_i := grid_columns @ a_column
			end
			if a_col_i = Void then
				insert_new_column (a_column)
				a_col_i := grid_columns @ a_column
			end
			Result := a_col_i.interface
		ensure
			column_not_void: Result /= Void
		end

	row_internal (a_row: INTEGER): EV_GRID_ROW is
			-- Row `a_row',  creates a new one if it doesn't exist
		require
			a_row_positive: a_row > 0
		local
			a_row_i: EV_GRID_ROW_I
		do
			if grid_rows.valid_index (a_row) then
				a_row_i := grid_rows @ a_row
			end
			if a_row_i = Void then
				insert_new_row (a_row)
				a_row_i := grid_rows @ a_row
			end
			Result := a_row_i.interface
		ensure
			row_not_void: Result /= Void
		end

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

