indexing
	description: 
		"Eiffel Vision table. Implementation interface";
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TABLE_I

inherit
	EV_CONTAINER_I
		redefine
			interface,
			item
		end

feature -- Access

	rows: INTEGER
			-- Number of rows in `Current'.
			
	columns: INTEGER
			-- Number of columns in `Current'.

	item_at_position (a_column, a_row: INTEGER): EV_WIDGET is
			-- Widget at coordinates (`row', `column')
		do
			Result := internal_array.item ((a_row - 1) * columns + a_column)
		end
		
	item_list: ARRAYED_LIST [EV_WIDGET] is
			-- List of items in `Current'.
		local
			i, j: INTEGER
		do
			create Result.make (internal_array.count)
			if internal_array.count > 0 then
				from
					i := internal_array.lower
					j := internal_array.upper
				until
					i > j
				loop
					if internal_array.item (i) /= Void and not Result.has
						(internal_array.item (i)) then
						Result.extend (internal_array.item (i))
					end
					i := i + 1
				end
			end
		end

	has (v: EV_WIDGET): BOOLEAN is
			-- Does `Current' contain `v'?
		do
			Result := internal_item_list.has (v)
		end
		
	item: EV_WIDGET is
			-- Item at current position.
		do
			Result := internal_item_list @ index
		end
		
	full: BOOLEAN is
			-- Is structure filled to capacity?
		local
			used_cell_count: INTEGER
			widget_cells_used: INTEGER
		do
				-- As items may occupy more than one cell,
				-- we must sum total area taken by contents, and
				-- then compare against the maximum capacity of the table.
			from
				internal_item_list.start
			until
				internal_item_list.off
			loop
				widget_cells_used := item_column_span (internal_item_list.item) *
					item_row_span (internal_item_list.item)
				used_cell_count := used_cell_count + widget_cells_used
				internal_item_list.forth
			end
				-- If the cells used equal the total number of cells,
				-- then the table is full.
			Result := used_cell_count = rows * columns
		end
		
	before: BOOLEAN is
			-- Is there no valid position to the left of current one?
		do
			Result := index = 0
		end
		
	after: BOOLEAN is
			-- Is there no valid position to the right of current one?
		do
			Result := index = count + 1
		end

feature {EV_TABLE, EV_ANY_I} -- Status report

	row_spacing: INTEGER is
			-- Spacing between two consecutive rows.
		deferred
		end
	
	column_spacing: INTEGER is
			-- Spacing between two consecutive columns.
		deferred
		end

	border_width: INTEGER is
			-- Spacing between edge of `Current' and items.
		deferred
		end
		
	item_column_position (widget: EV_WIDGET): INTEGER is
			-- `Result' is column coordinate of `widget'.
		deferred
		end
		
	item_row_position (widget: EV_WIDGET): INTEGER is
			-- `Result' is row coordinate of `widget'.
		deferred
		end
		
		
	item_row_span (widget: EV_WIDGET): INTEGER is
			-- `Result' is number of rows taken by `widget'.
		deferred
		end
		
	item_column_span (widget: EV_WIDGET): INTEGER is
			-- `Result' is number of columns taken by `widget'.
		deferred
		end
		
	columns_resizable_to (a_column: INTEGER): BOOLEAN is
			-- May the column count be resized to `a_column'?
		require
			a_column_positive: a_column >= 1
		local
			a_column_index: INTEGER
		do
			Result := True
			if a_column < columns then
				from
					a_column_index := a_column + 1
					-- Column `a_column' can hold widgets.
				until
					not Result or else a_column_index > columns
				loop
					Result := column_clear (a_column_index)
					a_column_index := a_column_index + 1
				end
			end
		end

	rows_resizable_to (a_row: INTEGER): BOOLEAN is
			-- May the row count be resized to `a_row'?
		require
			a_row_positive: a_row >= 1
		local
			a_row_index: INTEGER
		do
			Result := True
			if a_row < rows then
				from
					a_row_index := a_row + 1
					-- Row `a_row' can hold widgets.
				until
					not Result or else a_row_index > rows
				loop
					Result := row_clear (a_row_index)
					a_row_index := a_row_index + 1
				end
			end
		end
		
	column_clear (a_column: INTEGER): BOOLEAN is
			-- Is column `a_column' free of widgets?
		require
			a_column_positive: a_column >= 1
			a_column_in_table: a_column <= columns
		local
			a_row_index: INTEGER
		do
			Result := True
			from
				a_row_index := 1
			until
				not Result or else a_row_index > rows
			loop
				Result := item_at_position (a_column, a_row_index) = Void
				a_row_index := a_row_index + 1
			end
		end

	row_clear (a_row: INTEGER): BOOLEAN is
			-- Is row `a_row' free of widgets?
		require
			a_row_positive: a_row >= 1
			a_row_in_table: a_row <= rows
		local
			a_column_index: INTEGER
		do
			Result := True
			from
				a_column_index := 1
			until
				not Result or else a_column_index > columns
			loop
				Result := item_at_position (a_column_index, a_row) = Void
				a_column_index := a_column_index + 1
			end
		end
		
	area_clear_excluding_widget (v: EV_WIDGET; a_column, a_row, column_span, row_span: INTEGER): BOOLEAN is
			-- Are the cells represented by parameters free of widgets? Excludes cells
			-- filled by `v'.
		require
			table_wide_enough: a_column + (column_span - 1) <= columns
			table_tall_enough: a_row + (row_span - 1) <= rows
		local
			a_col_ctr, a_row_ctr: INTEGER
		do
			Result := True
			from
				a_row_ctr := a_row
			until
				not Result or else (a_row_ctr = a_row + row_span)
			loop
				from
					a_col_ctr := a_column
				until
					not Result or else (a_col_ctr = a_column + column_span)
				loop
					if item_at_position (a_col_ctr, a_row_ctr) /= v then
						Result := item_at_position (a_col_ctr, a_row_ctr) = Void	
					end
					a_col_ctr := a_col_ctr + 1
				end
				a_row_ctr := a_row_ctr + 1
			end
		end	

feature {EV_TABLE, EV_ANY_I} -- Status settings

	enable_homogeneous is
			-- Set all item's sizes to that of the largest in `Current'.
		deferred
		end

	disable_homogeneous is
			-- Allow items to be of varying sizes.
		deferred
		end
		
	is_homogeneous: BOOLEAN is
			-- Are all children restriced to be the same size.
		deferred
		end
	
	set_row_spacing (a_value: INTEGER) is
			-- Spacing between two consecutive rows of `Current'.
		require
			positive_value: a_value >= 0
		deferred
		end

	set_column_spacing (a_value: INTEGER) is
			-- Spacing between two consecutive columns of `Current'.
		require
			positive_value: a_value >= 0
		deferred
		end

	set_border_width (a_value: INTEGER) is
			-- Assign `a_value' to `border_width'.
		require
			positive_value: a_value >= 0
		deferred
		end

	resize (a_column, a_row: INTEGER) is
			-- Resize the table to hold `a_column' by `a_row' widgets.
		require
			a_column_positive: a_column >= 1
			a_row_positive: a_row >= 1
			columns_resizeable: columns_resizable_to (a_column)
			rows_resizeable: rows_resizable_to (a_row)
		local
			new: ARRAY [EV_WIDGET]
			col_index, row_index, column_max, row_max: INTEGER
		do
			create new.make (1, a_column * a_row)
			column_max := columns.min (a_column)
			row_max := rows.min (a_row)
			
			from
				row_index := 1
			until
				row_index > row_max
			loop
				from
					col_index := 1
				until
					col_index > column_max
				loop
					new.put (item_at_position (col_index, row_index),
						((row_index - 1) * a_column) + col_index)
					col_index := col_index + 1
				end
				row_index := row_index + 1
			end

			internal_array := new
			
			columns := a_column
			rows := a_row
			internal_array.grow (columns * rows)
		ensure
			columns_set: columns = a_column
			rows_set: rows = a_row
			upper_updated: internal_array.upper = rows * columns
			items_untouched: item_list.is_equal (old item_list)
		end
		
	set_item_position (v: EV_WIDGET; a_column, a_row: INTEGER) is
			-- Move `v' to position `a_column', `a_row'.
		local
			a_col_ctr, a_row_ctr, a_cell_index: INTEGER
			original_item_row_span, original_item_column_span: INTEGER
		do
			original_item_row_span := item_row_span (v)
			original_item_column_span := item_column_span (v)
			from
				a_cell_index := 1
			until
				a_cell_index > internal_array.count
			loop
				if internal_array.item (a_cell_index) = v then
					internal_array.put (Void, a_cell_index)
				end
				a_cell_index := a_cell_index + 1						
			end
			from
				a_row_ctr := a_row
			until
				a_row_ctr = a_row + original_item_row_span
			loop
				from
					a_col_ctr := a_column
				until
					a_col_ctr = a_column + original_item_column_span
				loop
					a_cell_index := (a_row_ctr - 1) * columns + a_col_ctr
					internal_array.put (v, a_cell_index)
					a_col_ctr := a_col_ctr + 1
				end
				a_row_ctr := a_row_ctr + 1
			end
				-- Now update out internal representation of `Current'.
			rebuild_internal_item_list
		end
		
	set_item_span (v: EV_WIDGET; column_span, row_span: INTEGER) is
			-- Resize `v' to occupy `column_span' columns and `row_span' rows.
		require
			v_contained: has (v)
			column_span_positive: column_span >= 1
			row_span_positive: row_span >= 1
			table_wide_enough: item_column_position (v) + column_span - 1 <= columns
			table_tall_enough: item_row_position (v) + row_span - 1 <= rows
			table_area_clear:
				area_clear_excluding_widget (v, item_column_position (v), item_row_position (v), column_span, row_span)
			local
				a_col_ctr, a_row_ctr, a_cell_index: INTEGER
				original_item_row_position, original_item_column_position: INTEGER
			do
				original_item_row_position := item_row_position (v)
				original_item_column_position := item_column_position (v)
				from
					a_cell_index := 1
				until
					a_cell_index > internal_array.count
				loop
					if internal_array.item (a_cell_index) = v then
						internal_array.put (Void, a_cell_index)
					end
					a_cell_index := a_cell_index + 1						
				end
				from
					a_row_ctr := original_item_row_position
				until
					a_row_ctr = original_item_row_position + row_span
				loop
					from
						a_col_ctr := original_item_column_position
					until
						a_col_ctr = original_item_column_position + column_span
					loop
						a_cell_index := (a_row_ctr - 1) * columns + a_col_ctr
						internal_array.put (v, a_cell_index)
						a_col_ctr := a_col_ctr + 1
					end
					a_row_ctr := a_row_ctr + 1
				end
					-- Now update out internal representation of `Current'.
				rebuild_internal_item_list
			end
			
	set_item_position_and_span (v: EV_WIDGET; a_column, a_row, column_span, row_span: INTEGER) is
			-- Move `v' to `a_column', `a_row', and resize to occupy `column_span' columns and `row_span' rows.
		require
			v_not_void: v /= Void
			v_contained: has (v)
			a_column_positive: a_column >= 1
			a_row_positive: a_row >= 1
			column_span_positive: column_span >= 1
			row_span_positive: row_span >= 1
			table_wide_enough: a_column + (column_span - 1) <= columns
			table_tall_enough: a_row + (row_span - 1) <= rows
			table_area_clear:
				area_clear_excluding_widget (v, a_column, a_row, column_span, row_span)
			local
				a_col_ctr, a_row_ctr, a_cell_index: INTEGER
			do
				from
					a_cell_index := 1
				until
					a_cell_index > internal_array.count
				loop
					if internal_array.item (a_cell_index) = v then
						internal_array.put (Void, a_cell_index)
					end
					a_cell_index := a_cell_index + 1						
				end
				from
					a_row_ctr := a_row
				until
					a_row_ctr = a_row + row_span
				loop
					from
						a_col_ctr := a_column
					until
						a_col_ctr = a_column + column_span
					loop
						a_cell_index := (a_row_ctr - 1) * columns + a_col_ctr
						internal_array.put (v, a_cell_index)
						a_col_ctr := a_col_ctr + 1
					end
					a_row_ctr := a_row_ctr + 1
				end
				set_item_position (v, a_column, a_row)
				set_item_span (v, column_span, row_span)
			end

feature -- Element change

	put (v: EV_WIDGET; a_column, a_row, column_span, row_span: INTEGER) is
			-- Set `a_widgets' position in the
			-- table to be (x1, y1) (x2, y2)
		require
			v_not_void: v /= Void
			a_column_positive: a_column >= 1
			a_row_positive: a_row >= 1
			column_span_positive: column_span >= 1
			row_span_positive: row_span >= 1		
		local
			a_col_ctr, a_row_ctr, a_cell_index: INTEGER
		do
			from
				a_row_ctr := a_row
			until
				a_row_ctr = a_row + row_span
			loop
				from
					a_col_ctr := a_column
				until
					a_col_ctr = a_column + column_span
				loop
					a_cell_index := (a_row_ctr - 1) * columns + a_col_ctr
					internal_array.put (v, a_cell_index)
					a_col_ctr := a_col_ctr + 1
				end
				a_row_ctr := a_row_ctr + 1
			end
				-- Now update out internal representation of `Current'.
			rebuild_internal_item_list
		end

	remove (v: EV_WIDGET) is
			-- Remove `v' from `Current' if present.
		require
			item_not_void: v /= Void
			item_in_table: has (v)
		local
			a_cell_index: INTEGER
		do
			from
				a_cell_index := 1
			until
				a_cell_index > internal_array.count
			loop
				if internal_array.item (a_cell_index) = v then
					internal_array.put (Void, a_cell_index)
				end
				a_cell_index := a_cell_index + 1						
			end
				-- Now update out internal representation of `Current'.
			rebuild_internal_item_list
		ensure
			item_removed: not has (v)
		end

	extend (v: like item) is
			-- Add a new occurrence of `v'.
		local
			extend_pos: INTEGER
			counter: INTEGER
			x, y: INTEGER
		do
				-- There is no simple way to find the first insertion
				-- position, except to iterate through `internal_array'
				-- and find the first free index.
			from
				counter := 1
			until
				extend_pos /= 0
			loop
				if internal_array.item (counter) = Void then
					extend_pos := counter
				end
				counter := counter + 1
			end
			
				-- Convert `counter' into x and y coordinates.
			y := ((extend_pos - 1) // columns) + 1
			x := extend_pos - ((y - 1) * (columns))
				-- Insert `v' to `Current'.
			put (v, x, y , 1, 1)
		end
		
	wipe_out is
			-- Remove all items.
		do
			from
				interface.start
			until
				interface.off
			loop
				interface.prune (item)
			end
		end
		
	cursor: CURSOR  is
			-- Current cursor position.
		local
			an_item: like item
		do
			if index > 0 and then index <= count then
				an_item := item
			end
			create {EV_DYNAMIC_LIST_CURSOR [EV_WIDGET]} Result.make (an_item, index <= 0, index > count)
		end
		
	valid_cursor (p: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position `p'?
			-- This is True if `p' conforms to EV_TABLE_CURSOR and
			-- if it points to an item, `Current' must have it.
		local
			dlc: EV_DYNAMIC_LIST_CURSOR [EV_WIDGET]
		do
			dlc ?= p
			Result := dlc /= Void and then
				(dlc.item = Void or else has (dlc.item))
		end
		
	go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		local
			dlc: EV_DYNAMIC_LIST_CURSOR [EV_WIDGET]
		do
			dlc ?= p
			check
				dlc_not_void: dlc /= Void
			end
			if dlc.after then
				index := count + 1
			elseif dlc.before then
				index := 0
			else
				index := interface.index_of (dlc.item, 1)
			end
		end
		
	index: INTEGER
		-- Current cursor index.
	
	count: INTEGER is
			-- Number of widgets contained in `Current'.
		do
			Result := internal_item_list.count
		end
		
	forth is
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		do
			index := index + 1
		end
		
	back is
			-- Move to previous position.
		do
			index := index - 1
		end
		
feature {NONE} -- Implementation

	internal_item_list: ARRAYED_LIST [EV_WIDGET]
		-- An internal version of `item_list' which will only be
		-- rebuilt when an item is added, removed or moved within the table.
	
	rebuild_internal_item_list is
			-- Rebuild `internal_item_list'.
		do
			internal_item_list := clone (item_list)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TABLE

	Default_homogeneous: BOOLEAN is False
		-- `Current' is not homogeneous by default.

	Default_row_spacing: INTEGER is 0
		-- Default row spacing of `Current'.

	Default_column_spacing: INTEGER is 0
		-- Default column spacing of `Current'.
		
	internal_array: ARRAY [EV_WIDGET]
		-- Array representing `Current'.
		-- All widgets are contained in here, and we manipulate
		-- this as the table is modified.

invariant
	internal_item_list_not_void: internal_item_list /= Void
	internal_item_list_matches_count: internal_item_list.count = count

end -- class EV_TABLE_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

