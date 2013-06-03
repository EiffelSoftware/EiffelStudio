note
	description:
		"Eiffel Vision table. Implementation interface"
	legal: "See notice at end of class.";
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

	item_at_position (a_column, a_row: INTEGER): detachable EV_WIDGET
			-- Widget at coordinates (`row', `column')
		do
			Result := internal_array.item ((a_row - 1) * columns + a_column)
		end

	item_list: ARRAYED_LIST [EV_WIDGET]
			-- List of items in `Current'.
		local
			i, j: INTEGER
			l_item: detachable EV_WIDGET
		do
			create Result.make (internal_array.count)
			if internal_array.count > 0 then
				from
					i := internal_array.lower
					j := internal_array.upper
				until
					i > j
				loop
					l_item := internal_array.item (i)
					if attached l_item and then not Result.has
						(l_item) then
						Result.extend (l_item)
					end
					i := i + 1
				end
			end
		ensure
			Result_not_void: Result /= Void
		end

	to_array: ARRAY [detachable EV_WIDGET]
			-- A representation of `Current' as ARRAY. Included to
			-- ease transition from inheritance of ARRAY to
			-- inheritance of CHAIN. Contains contents of all cells
			-- from left to right, and top to bottom. You should only
			-- use this if you relied on the inheritence of ARRAY, and
			-- is only temporary to ease this change.
		do
			Result := internal_array.twin
		ensure
			result_not_void: Result /= Void
		end

	has (v: EV_WIDGET): BOOLEAN
			-- Does `Current' contain `v'?
		do
			Result := internal_item_list.has (v)
		end

	item: EV_WIDGET
			-- Item at current position.
		do
			Result := internal_item_list @ index
		end

	full: BOOLEAN
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

	before: BOOLEAN
			-- Is there no valid position to the left of current one?
		do
			Result := index = 0
		end

	after: BOOLEAN
			-- Is there no valid position to the right of current one?
		do
			Result := index = count + 1
		end

feature {EV_ANY, EV_ANY_I} -- Status report

	row_spacing: INTEGER
			-- Spacing between two consecutive rows.
		deferred
		end

	column_spacing: INTEGER
			-- Spacing between two consecutive columns.
		deferred
		end

	border_width: INTEGER
			-- Spacing between edge of `Current' and items.
		deferred
		end

	item_column_position (widget: EV_WIDGET): INTEGER
			-- `Result' is column coordinate of `widget'.
		deferred
		end

	item_row_position (widget: EV_WIDGET): INTEGER
			-- `Result' is row coordinate of `widget'.
		deferred
		end


	item_row_span (widget: EV_WIDGET): INTEGER
			-- `Result' is number of rows taken by `widget'.
		deferred
		end

	item_column_span (widget: EV_WIDGET): INTEGER
			-- `Result' is number of columns taken by `widget'.
		deferred
		end

	columns_resizable_to (a_column: INTEGER): BOOLEAN
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

	rows_resizable_to (a_row: INTEGER): BOOLEAN
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

	column_clear (a_column: INTEGER): BOOLEAN
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

	row_clear (a_row: INTEGER): BOOLEAN
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

	area_clear_excluding_widget (v: EV_WIDGET; a_column, a_row, column_span, row_span: INTEGER): BOOLEAN
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

feature {EV_ANY, EV_ANY_I} -- Status settings

	enable_homogeneous
			-- Set all item's sizes to that of the largest in `Current'.
		deferred
		end

	disable_homogeneous
			-- Allow items to be of varying sizes.
		deferred
		end

	is_homogeneous: BOOLEAN
			-- Are all children restriced to be the same size.
		deferred
		end

	set_row_spacing (a_value: INTEGER)
			-- Spacing between two consecutive rows of `Current'.
		require
			positive_value: a_value >= 0
		deferred
		end

	set_column_spacing (a_value: INTEGER)
			-- Spacing between two consecutive columns of `Current'.
		require
			positive_value: a_value >= 0
		deferred
		end

	set_border_width (a_value: INTEGER)
			-- Assign `a_value' to `border_width'.
		require
			positive_value: a_value >= 0
		deferred
		end

	resize (a_column, a_row: INTEGER)
			-- Resize the table to hold `a_column' by `a_row' widgets.
		require
			a_column_positive: a_column >= 1
			a_row_positive: a_row >= 1
			columns_resizeable: columns_resizable_to (a_column)
			rows_resizeable: rows_resizable_to (a_row)
		local
			new: ARRAY [detachable EV_WIDGET]
			col_index, row_index, column_max, row_max: INTEGER
			l_item: detachable EV_WIDGET
		do
			create new.make_filled (Void, 1, a_column * a_row)
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
					l_item := item_at_position (col_index, row_index)
					new.put (l_item,
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

	set_item_position (v: EV_WIDGET; a_column, a_row: INTEGER)
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

	set_item_span (v: EV_WIDGET; column_span, row_span: INTEGER)
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

	set_item_position_and_span (v: EV_WIDGET; a_column, a_row, column_span, row_span: INTEGER)
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

	put (v: EV_WIDGET; a_column, a_row, column_span, row_span: INTEGER)
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

	remove (v: EV_WIDGET)
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

	extend (v: like item)
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

	wipe_out
			-- Remove all items.
		do
			from
				attached_interface.start
			until
				attached_interface.off
			loop
				attached_interface.prune (item)
			end
		end

	cursor: CURSOR
			-- Current cursor position.
		local
			an_item: detachable like item
		do
			if index > 0 and then index <= count then
				an_item := item
			end
			create {EV_DYNAMIC_LIST_CURSOR [EV_WIDGET]} Result.make (an_item, index <= 0, index > count)
		end

	valid_cursor (p: CURSOR): BOOLEAN
			-- Can the cursor be moved to position `p'?
			-- This is True if `p' conforms to EV_TABLE_CURSOR and
			-- if it points to an item, `Current' must have it.
		local
			dlc: detachable EV_DYNAMIC_LIST_CURSOR [EV_WIDGET]
		do
			dlc ?= p
			Result := dlc /= Void and then
				(dlc.item = Void or else attached dlc.item as l_item and then has (l_item))
		end

	go_to (p: CURSOR)
			-- Move cursor to position `p'.
		local
			dlc: detachable EV_DYNAMIC_LIST_CURSOR [EV_WIDGET]
		do
			dlc ?= p
			check
				dlc_not_void: dlc /= Void then
			end
			if dlc.after then
				index := count + 1
			elseif dlc.before then
				index := 0
			elseif attached dlc.item as l_item then
				index := attached_interface.index_of (l_item, 1)
			end
		end

	index: INTEGER
		-- Current cursor index.

	count: INTEGER
			-- Number of widgets contained in `Current'.
		do
			Result := internal_item_list.count
		end

	forth
			-- Move to next position; if no next position,
			-- ensure that `exhausted' will be true.
		do
			index := index + 1
		end

	back
			-- Move to previous position.
		do
			index := index - 1
		end

	move (i: INTEGER)
			-- Move cursor `i' positions. The cursor
			-- may end up `off' if the absolute value of `i'
			-- is too big.
		local
			counter: INTEGER
		do
			if i > 0 then
				from
				until
					(counter = i) or else after
				loop
					forth
					counter := counter + 1
				end
			elseif i < 0 then
				from
				until
					(counter = i) or else before
				loop
					back
					counter := counter - 1
				end
			end
		end

feature {NONE} -- Implementation

	internal_item_list: ARRAYED_LIST [EV_WIDGET]
		-- An internal version of `item_list' which will only be
		-- rebuilt when an item is added, removed or moved within the table.

	rebuild_internal_item_list
			-- Rebuild `internal_item_list'.
		do
			internal_item_list := item_list.twin
		end

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so notify all children.
		local
			loc_cursor: CURSOR
		do
			from
				loc_cursor := internal_item_list.cursor
				internal_item_list.start
			until
				internal_item_list.after
			loop
				internal_item_list.item.implementation.update_for_pick_and_drop (starting)
				internal_item_list.forth
			end
			internal_item_list.go_to (loc_cursor)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TABLE note option: stable attribute end

feature {EV_ANY_I} -- Implementation

	Default_homogeneous: BOOLEAN = False
		-- `Current' is not homogeneous by default.

	Default_row_spacing: INTEGER = 0
		-- Default row spacing of `Current'.

	Default_column_spacing: INTEGER = 0
		-- Default column spacing of `Current'.

	internal_array: ARRAY [detachable EV_WIDGET]
		-- Array representing `Current'.
		-- All widgets are contained in here, and we manipulate
		-- this as the table is modified.

invariant
	internal_item_list_not_void: internal_item_list /= Void
	internal_item_list_matches_count: internal_item_list.count = count
	internal_array_not_void: internal_array /= Void

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_TABLE_I










