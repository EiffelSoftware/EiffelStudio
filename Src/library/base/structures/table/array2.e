indexing

	description:
		"Two-dimensional arrays";

	status: "See notice at end of class";
	names: array2, matrix, table;
	representation: array;
	access: index, row_and_column, membership;
	size: resizable;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

class ARRAY2 [G] inherit

	ANY
		undefine
			consistent, setup, is_equal, copy
		end;

	ARRAY [G]
		rename
			make as array_make,
			item as array_item,
			put as array_put,
			force as array_force,
			wipe_out as array_wipe_out,
			resize as array_resize
		export
			{NONE}
				all;
			{ARRAY2}
				array_put;
			{ANY}
				area
		end;

	ARRAY [G]
		rename
			make as array_make,
			item as array_item,
			put as array_put,
			force as array_force,
			resize as array_resize
		export
			{NONE}
				all;
			{ARRAY2}
				array_put;
			{ANY}
				area
		redefine
			wipe_out
		select
			wipe_out
		end

creation

	make

feature -- Initialization

	make (nb_rows, nb_columns: INTEGER) is
			-- Create a two dimensional array which has `nb_rows'
			-- rows and `nb_columns' columns,
			-- with lower bounds starting at 1.
		require
			not_flat: nb_rows > 0;
			not_thin: nb_columns > 0
		do
			height := nb_rows;
			width := nb_columns;
			array_make (1, height * width)
		ensure
			new_count: count = height * width
		end;


	initialize (v: G) is
			-- Make each entry have value `v'.
		local
			row, column: INTEGER
		do
			from
				row := 1
			until
				row > height
			loop
				from
					column := 1;
				until
					column > width
				loop
					put (v, row, column);
					column := column + 1
				end;
				row := row + 1
			end
		end;

feature -- Access

	item (row, column: INTEGER): G is
			-- Entry at coordinates (`row', `column')
		require
			valid_row: (1 <= row) and (row <= height);
			valid_column: (1 <= column) and (column <= width)
		do
			Result := array_item ((row - 1) * width + column)
		end;

feature -- Measurement

	height: INTEGER;
			-- Number of rows

	width: INTEGER;
			-- Number of columns

feature -- Element change

	put (v: like item; row, column: INTEGER) is
			-- Assign item `v' at coordinates (`row', `column').
		require
			valid_row: 1 <= row and row <= height;
			valid_column: 1 <= column and column <= width
		do
			array_put (v, (row - 1) * width + column)
		end;

	force (v: like item; row, column: INTEGER) is
			-- Assign item `v' at coordinates (`row', `column').
			-- Resize if necessary.
		require
			row_large_enough: 1 <= row;
			column_large_enough: 1 <= column
		do
			resize (row, column);
			put (v, row, column)
		end;

feature -- Removal

	wipe_out is
			-- Remove all items.
		do
			height := 0;
			width := 0;
			array_wipe_out
		end;

feature -- Resizing

	resize (nb_rows, nb_columns: INTEGER) is
			-- Rearrange array so that it can accommodate
			-- `nb_rows' rows and `nb_columns' columns,
			-- without losing any previously
			-- entered items, nor changing their coordinates;
			-- do nothing if not possible.
		require
			valid_row: nb_rows >= 1;
			valid_column: nb_columns >= 1
		local
			i, new_height: INTEGER;
			in_new, in_old: INTEGER;
			new: like Current
		do
			if nb_rows > height then
				new_height := nb_rows
			else
				new_height := height
			end;
			if nb_columns > width then
				!! new.make (new_height, nb_columns);
				from
					in_old := 1;
					in_new := 1
				until
					i = height
				loop
					i := i + 1;
					transfer (new, in_old, in_new, width);
					in_new := in_new + nb_columns;
					in_old := in_old + width
				end;
				width := nb_columns;
				height := new_height;
				upper := width * height;
				area := new.area;
			elseif new_height > height then
				!! new.make (new_height, width);
				transfer (new, 1, 1, width * height);
				height := new_height;
				upper := width * height;
				area := new.area
			end
		end;

feature {NONE} -- Implementation

	transfer (new: like Current; in_old, in_new, nb: INTEGER) is
			-- Copy `nb' items, starting from `in_old',
			-- to `new', starting from `in_new'.
			-- Do not copy out_of_bounds items.
		local
			i, j: INTEGER
		do
			from
				i := in_old;
				j := in_new
			until
				i = in_old + nb
			loop
				new.array_put (array_item (i), j);
				i := i + 1;
				j := j + 1
			end
		end;

invariant

	items_number: count = width * height

end -- class ARRAY2


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
