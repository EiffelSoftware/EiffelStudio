--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

	description: 
		"EiffelVision table. Invisible container that allows %N%
		% unlimited number of other widgets to be packed inside it.%N%
		% A table controls the children's location and size%N%
		% automatically."
	status: "See notice at end of class"
	id: "$Id$"
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
			make_for_test,
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
				array_resize, wipe_out, bag_put, extend
			{EV_TABLE}
				array_put;
			{ANY}
				copy, is_equal, area, to_c
		undefine
			copy, is_equal, default_create,
			changeable_comparison_criterion, extend
		select
			bag_put, extend
		end

create
	default_create,
	make_for_test

feature {NONE} -- Initialization

	create_implementation is
			-- See `See {EV_ANY}.create_implementation'.
		do
			create {EV_TABLE_IMP} implementation.make (Current)
			columns := 2
			rows := 2
			array_make (1, columns * rows)
		end

feature -- Access

	rows: INTEGER
			-- Number of rows in table.

	columns: INTEGER
			-- Number of columns in table.

	item (a_column, a_row: INTEGER): EV_WIDGET is
			-- Entry at coordinates (`row', `column')
		require
			valid_row: (1 <= a_row) and (a_row <= rows);
			valid_column: (1 <= a_column) and (a_column <= columns)
		do
			Result := array_item ((a_row - 1) * columns + a_column)
		end;

	item_list: ARRAYED_LIST [EV_WIDGET] is
			-- List of items in the table.
		local
			temp_linear: LINEAR [EV_WIDGET]
		do
			create Result.make (0)
			if count > 0 then
				temp_linear := linear_representation
				from
					temp_linear.start
				until
					temp_linear.after
				loop
					--| FIXME IEK Needs a more efficient algorithm.
					if temp_linear.item /= Void and then not Result.has (temp_linear.item) then
						Result.force (temp_linear.item)
					end
					temp_linear.forth
				end
			end
		end

feature -- Status report

	columns_resizable_to (a_column: INTEGER): BOOLEAN is
			-- May the column count be resized to `a_column'.
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
			-- May the row count be resized to `a_row'.
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
				Result := item (a_column, a_row_index) = Void
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
				Result := item (a_column_index, a_row) = Void
				a_column_index := a_column_index + 1
			end
		end

	widget_count: INTEGER is
			-- Number of widgets in table.
		do
			Result := implementation.widget_count
		end

	row_spacing: INTEGER is
			-- Spacing between two rows in pixels.
		do
			Result := implementation.row_spacing
		end

	column_spacing: INTEGER is
			-- Spacing between two columns in pixels.
		do
			Result := implementation.column_spacing
		end

	border_width: INTEGER is
			-- Spacing between edge of `Current' and outside edge items, in pixels.
		do
			Result := implementation.border_width
		end

	area_clear (a_column, a_row, column_span, row_span: INTEGER): BOOLEAN is
			-- Are the cells represented from parameters free of widgets.
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
					Result := item (a_col_ctr, a_row_ctr) = Void
					a_col_ctr := a_col_ctr + 1
				end
				a_row_ctr := a_row_ctr + 1
			end
		end

	readable: BOOLEAN is True
	writable: BOOLEAN is True

feature -- Status settings

	enable_homogeneous is
			-- Set each item in the table to be equal in size
			-- to that of the largest item.
		do
			implementation.enable_homogeneous
		end

	disable_homogeneous is
			-- Allow items to have varying sizes.
		do
			implementation.disable_homogeneous
		end
	
	set_row_spacing (a_value: INTEGER) is
			-- Spacing in-between rows.
		require
			positive_value: a_value >= 0
		do
			implementation.set_row_spacing (a_value)
		end

	set_column_spacing (a_value: INTEGER) is
			-- Spacing in-between columns.
		require
			positive_value: a_value >= 0
		do
			implementation.set_column_spacing (a_value)
		end

	set_border_width (a_value: INTEGER) is
			-- Assign `a_value' to `border_width'.
		require
			positive_value: a_value >= 0
		do
			implementation.set_border_width (a_value)
		end

	resize (a_column, a_row: INTEGER) is
			-- Resize the table to (`a_column' * `a_row').
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
					new.put (item (col_index, row_index), ((row_index - 1) * a_column) + col_index)
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
			-- To describe the widget in the table as shown above
			-- the corresponding coordinates would be (1, 1, 2, 1)
		require
			v_not_void: v /= Void
			v_not_current: v /= Current
			a_column_positive: a_column >= 1
			a_row_positive: a_row >= 1
			column_span_positive: column_span >= 1
			row_span_positive: row_span >= 1
			table_wide_enough: a_column + (column_span - 1) <= columns
			table_tall_enough: a_row + (row_span - 1) <= rows
			table_area_clear: area_clear (a_column, a_row, column_span, row_span)
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
			-- Remove `v' from table if present.
		require
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

feature {NONE} -- Contract support

	parent_of_items_is_current: BOOLEAN is
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

	make_for_test is
		local
			a_x, a_y: INTEGER
			a_but: EV_TOGGLE_BUTTON
		do
			default_create
			resize (5, 5)
			from
				a_y := 1
			until
				a_y > 5
			loop
				from
					a_x := 1
				until
					a_x > 5
				loop
					if ((a_x + a_y) \\ 2 = 0) then
						create a_but.make_with_text (
						"("+a_x.out+","+a_y.out+")"
						)
						a_but.set_background_color (
							create {EV_COLOR}.make_with_rgb (1, 0, 0)
						)
						put (a_but, a_x, a_y, 1, 1)
					end
					a_x := a_x + 1
				end
				a_y := a_y + 1
			end
				
		end


feature {NONE} -- Implementation
	
	implementation: EV_TABLE_I

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.9  2000/06/07 17:28:12  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.6.4.16  2000/06/06 23:42:11  rogers
--| Added border_width and set_border_width. Removed redundent requires.
--|
--| Revision 1.6.4.15  2000/06/06 23:26:06  king
--| Updated make_for_test
--|
--| Revision 1.6.4.14  2000/06/06 19:52:39  king
--| Added postconditions, updated comments
--|
--| Revision 1.6.4.13  2000/06/06 17:50:35  king
--| Correctly setting upper on array resize
--|
--| Revision 1.6.4.12  2000/06/06 17:32:04  king
--| Added resizing code, possible infinite loop if resize is smaller
--|
--| Revision 1.6.4.11  2000/06/06 01:28:16  king
--| Half implemented resize, mapping calculation is incorrect
--|
--| Revision 1.6.4.10  2000/06/06 00:42:18  king
--| Added resize
--|
--| Revision 1.6.4.5  2000/05/31 22:36:33  king
--| Updated make_for_test
--|
--| Revision 1.6.4.1  2000/05/03 19:10:08  oconnor
--| mergred from HEAD
--|
--| Revision 1.8  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.2  2000/01/27 19:30:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.1  1999/11/24 17:30:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.6.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
