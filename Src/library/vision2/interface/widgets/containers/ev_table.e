indexing
	description: 
		"EiffelVision table. Invisible container that allows %N%
		% unlimited number of other widgets to be packed inside it.%N%
		% A table controls the children's location and size%N%
		% automatically."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TABLE

inherit

	EV_CONTAINER
		rename
			item as container_item,
			put as container_put
		export
			{NONE}
				container_item, container_put,
				extend, replace
		redefine
			implementation,
			create_implementation,
			items_unique,
			parent_of_items_is_current
		end

	ARRAY [EV_WIDGET]
		rename
			make as array_make,
			item as array_item,
			put as array_put,
			force as array_force,
			resize as array_resize
		export
			{NONE}
				array_make, array_item, array_force,
				array_resize, wipe_out, bag_put, extend,
				changeable_comparison_criterion,
				compare_references,
				compare_objects,
				object_comparison
			{EV_TABLE}
				array_put;
			{ANY}
				copy, is_equal, area, to_c
		undefine
			copy, is_equal, default_create,
			changeable_comparison_criterion, extend
		redefine
			linear_representation
		select
			bag_put, extend
		end

create
	default_create

feature -- Access

	rows: INTEGER
			-- Number of rows in `Current'.

	columns: INTEGER
			-- Number of columns in `Current'.

	item (a_column, a_row: INTEGER): EV_WIDGET is
			-- Widget at coordinates (`row', `column')
		require
			not_destroyed: not is_destroyed
			valid_row: (1 <= a_row) and (a_row <= rows);
			valid_column: (1 <= a_column) and (a_column <= columns)
		do
			Result := array_item ((a_row - 1) * columns + a_column)
		end;

	item_list: ARRAYED_LIST [EV_WIDGET] is
			-- List of items in `Current'.
		require
			not_destroyed: not is_destroyed
		local
			i, j: INTEGER
		do
			create Result.make (count)
			if count > 0 then
				from
					i := lower
					j := upper
				until
					i > j
				loop
					if array_item (i) /= Void and not Result.has
						(array_item (i)) then
						Result.extend (array_item (i))
					end
					i := i + 1
				end
			end
		end

feature -- Status report

	columns_resizable_to (a_column: INTEGER): BOOLEAN is
			-- May the column count be resized to `a_column'?
		require
			not_destroyed: not is_destroyed
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
			not_destroyed: not is_destroyed
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
			not_destroyed: not is_destroyed
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
				Result := item (a_column, a_row_index) = Void
				a_row_index := a_row_index + 1
			end
		end

	row_clear (a_row: INTEGER): BOOLEAN is
			-- Is row `a_row' free of widgets?
		require
			not_destroyed: not is_destroyed
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
				Result := item (a_column_index, a_row) = Void
				a_column_index := a_column_index + 1
			end
		end

	widget_count: INTEGER is
			-- Number of widgets in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.widget_count
		end

	row_spacing: INTEGER is
			-- Spacing between two consecutive rows, in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.row_spacing
		end

	column_spacing: INTEGER is
			-- Spacing between two consecutive columns, in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.column_spacing
		end

	border_width: INTEGER is
			-- Spacing between edge of `Current' and outside edge items,
			-- in pixels.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.border_width
		end

	area_clear (a_column, a_row, column_span, row_span: INTEGER): BOOLEAN is
			-- Are the cells represented by parameters free of widgets?
		require
			not_destroyed: not is_destroyed
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
					Result := item (a_col_ctr, a_row_ctr) = Void
					a_col_ctr := a_col_ctr + 1
				end
				a_row_ctr := a_row_ctr + 1
			end
		end

	readable: BOOLEAN is True
		-- `Current' is always readable.

	writable: BOOLEAN is True
		-- `Current' is always writeable.

feature -- Status settings

	enable_homogeneous is
			-- Set each item in `Current' to be equal in size
			-- to that of the largest item.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_homogeneous
		end

	disable_homogeneous is
			-- Allow items to have varying sizes.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_homogeneous
		end
	
	set_row_spacing (a_value: INTEGER) is
			-- Assign `a_value' to the spacing in-between rows, in pixels.
		require
			not_destroyed: not is_destroyed
			positive_value: a_value >= 0
		do
			implementation.set_row_spacing (a_value)
		end

	set_column_spacing (a_value: INTEGER) is
			-- Assign `a_value' to the spacing in-between columns, in pixels.
		require
			not_destroyed: not is_destroyed
			positive_value: a_value >= 0
		do
			implementation.set_column_spacing (a_value)
		end

	set_border_width (a_value: INTEGER) is
			-- Assign `a_value' to `border_width'.
		require
			not_destroyed: not is_destroyed
			positive_value: a_value >= 0
		do
			implementation.set_border_width (a_value)
		end

	resize (a_column, a_row: INTEGER) is
			-- Resize the table to hold `a_column' by `a_row' widgets.
		require
			not_destroyed: not is_destroyed
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
					new.put (item (col_index, row_index),
						((row_index - 1) * a_column) + col_index)
					col_index := col_index + 1
				end
				row_index := row_index + 1
			end

			area := new.area
			
			columns := a_column
			rows := a_row
			upper := columns * rows
			implementation.resize (a_column, a_row)
		ensure
			columns_set: columns = a_column
			rows_set: rows = a_row
			upper_updated: upper = rows * columns
			items_untouched: item_list.is_equal (old item_list)
		end

feature -- Element change

	put, add (v: like item; a_column, a_row, column_span, row_span: INTEGER) is
			-- Set the position of the widgets in one-based coordinates. 
			--
			--           1         2
			--     +----------+---------+
			--   1 |xxxxxxxxxxxxxxxxxxxx|
			--     +----------+---------+
			--   2 |          |         |
			--     +----------+---------+
			--
			-- To describe the widget in the table as shown above,
			-- the corresponding coordinates would be (1, 1, 2, 1)
		require
			not_destroyed: not is_destroyed
			v_not_void: v /= Void
			v_not_current: v /= Current
			v_not_contained: not has (v)
			v_parent_void: v.parent = Void
			v_not_parent_of_current: not is_parent_recursive (v)
			a_column_positive: a_column >= 1
			a_row_positive: a_row >= 1
			column_span_positive: column_span >= 1
			row_span_positive: row_span >= 1
			table_wide_enough: a_column + (column_span - 1) <= columns
			table_tall_enough: a_row + (row_span - 1) <= rows
			table_area_clear:
				area_clear (a_column, a_row, column_span, row_span)
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
					array_put (v, a_cell_index)
					a_col_ctr := a_col_ctr + 1
				end
				a_row_ctr := a_row_ctr + 1
			end
			implementation.put (v, a_column, a_row, column_span, row_span)
		ensure
			item_inserted: has (v)
		end

	remove (v: EV_WIDGET) is
			-- Remove `v' from `Current' if present.
		require
			not_destroyed: not is_destroyed
			item_not_void: v /= Void
			item_in_table: has (v)
		local
			a_cell_index: INTEGER
		do
			if v /= Void and then has (v) then
				from
					a_cell_index := 1
				until
					a_cell_index > count
				loop
					if array_item (a_cell_index) = v then
						array_put (Void, a_cell_index)
					end
					a_cell_index := a_cell_index + 1						
				end
				implementation.remove (v)
			end
		ensure
			item_removed: not has (v)
		end

feature -- Conversion

	linear_representation: LINEAR [EV_WIDGET] is
			-- Representation as a linear structure
		do
			check
				not_destroyed: not is_destroyed
			end
			Result := item_list
		end

feature {NONE} -- Contract support

	parent_of_items_is_current: BOOLEAN is
			-- Do all items in `Current' have `Current' as parent?
		local
			temp_list: ARRAYED_LIST [EV_WIDGET]
		do
			Result := True
			temp_list := item_list
			from
				temp_list.start
			until
				not Result or else temp_list.after
			loop
				Result := temp_list.item.parent = Current
				temp_list.forth
			end
		end

	items_unique: BOOLEAN is
			-- Are all items unique?
			-- (ie Are there no duplicates?)
		local
			l: LINEAR [EV_WIDGET]
			ll: LINKED_LIST [EV_WIDGET]

		do
			create ll.make
			Result := True
			l := item_list
			from
				l.start
			until
				l.after or Result = False
			loop
				if ll.has (l.item) then
					Result := False
				end
				ll.extend (l.item)
				l.forth
			end
		end
		
feature {EV_ANY_I} -- Implementation
	
	implementation: EV_TABLE_I
		-- Responsible for interaction with native graphics toolkit.
	
feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TABLE_IMP} implementation.make (Current)
			columns := 2
			rows := 2
			array_make (1, columns * rows)
		end

end -- class EV_TABLE

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
