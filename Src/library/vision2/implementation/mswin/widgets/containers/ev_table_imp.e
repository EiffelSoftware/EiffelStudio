indexing
	description: 
		"Eiffel Vision table. Ms windows implementation"
	note: "This class doesn't inherit from%
		% EV_INVISIBLE_CONTAINER_IMP because the children are%
		% of type EV_TABLE_CHILD_IMP and not EV_WIDGET_IMP.%
		% Yet, the implementation of the following features%
		% are the same : set_insensitive, default_style and%
		% background brush."
	note2:" The spacing is put at the end of every cell."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TABLE_IMP

inherit
	EV_TABLE_I

	EV_CONTAINER_IMP
		redefine
			set_insensitive,
			child_added,
			compute_minimum_width, 
			compute_minimum_height,
			compute_minimum_size
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		redefine
			make,
			move_and_resize,
			top_level_window_imp
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create a table widget with `par' as
			-- parent.
		local
			fix: FIXED_LIST [INTEGER]
		do
			{EV_WEL_CONTROL_CONTAINER_IMP} Precursor
			create ev_children.make (2)
			create_columns
			create_rows
			set_text ("EV_TABLE")
		end	

	create_columns is
			-- Initialize all the columns attributes.
		do
			create columns_minimum.make_filled (1)
			column_spacing := Default_column_spacing
			columns_homogeneous := Default_homogeneous
		end

	create_rows is
			-- Initialize all the columns attributes.
		do
			create rows_minimum.make_filled (1)
			row_spacing := Default_row_spacing
			rows_homogeneous := Default_homogeneous
		end

feature -- Access

	is_homogeneous: BOOLEAN is
			-- Does children have the same size ?
			-- On windows, we can set either the rows homogeneous
			-- or the columns_homogeneous flag, but not on gtk,
			-- so it sets everything.
		do
			Result := rows_homogeneous and columns_homogeneous
		end

	rows_homogeneous: BOOLEAN
			-- Do all the rows have the same size.

	columns_homogeneous: BOOLEAN
			-- Do all the columns have the same size.

	border_width: INTEGER
			-- Widgth of the border of the container

	column_spacing: INTEGER
			-- Spacing between two columns.

	row_spacing: INTEGER
			-- Spacing betwwen two rows.

feature -- Status report

	rows: INTEGER is
			-- Number of rows
		do
			Result := rows_minimum.count
		end

	columns: INTEGER is
			-- Number of columns
		do
			Result := columns_minimum.count
		end

	top_level_window_imp: EV_UNTITLED_WINDOW_IMP
			-- Top level window that contains the current widget.

feature -- Status settings

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
				-- `flag'.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			cur: CURSOR
		do
			if not ev_children.empty then
				list := ev_children
				from
					cur := list.cursor
					list.start
				until
					list.after
				loop
					list.item.widget.set_insensitive (flag)
					list.forth
				end
				list.go_to (cur)
			end
			{EV_CONTAINER_IMP} Precursor (flag)
		end

	set_homogeneous (flag: BOOLEAN) is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			rows_homogeneous := flag
			columns_homogeneous := flag
			notify_change (2 + 1)
		end

	set_rows_homogeneous (flag: BOOLEAN) is
			-- Rows_homogenous controls whether each object in
			-- the box has the same height.
		do
			rows_homogeneous := flag
			notify_change (2)
		end

	set_columns_homogeneous (flag: BOOLEAN) is
			-- Columns_homogenous controls whether each object in
			-- the box has the same width.
		do
			columns_homogeneous := flag
			notify_change (1)
		end
	
	set_row_spacing (value: INTEGER) is
			-- Make `value' the new `row_spacing'.
		do
			row_spacing := value
			notify_change (2)
		end

	set_column_spacing (value: INTEGER) is
			-- Make `value' the new `column_spacing'.
		do
			column_spacing := value
			notify_change (1)
		end

	set_child_position (the_child: EV_WIDGET; top, left, bottom, right: INTEGER) is
			-- Set the position and the size of the given child in
			-- the table. `top', `left', `bottom' and `right' give the
			-- zero-based numbers of the line where the child starts and ends.
			-- This feature must be called after the creation of
			-- the child, otherwise, the child won't appear in
			-- the table.
		local
			table_child: EV_TABLE_CHILD_IMP
			child_imp: EV_WIDGET_IMP
		do
			child_imp ?= the_child.implementation
			check
				valid_child: child_imp /= Void
			end

			-- First, we change the number of cells of the table if it is too small.
			if right > columns then
				initialize_columns (right)
			end
			if bottom > rows then
				initialize_rows (bottom)
			end

			-- Then, we check if the children has already been placed in the table,
			-- if not, we create a table child with the given information.
			table_child := find_widget_child (child_imp)
			if table_child = Void then
				!! table_child.make (child_imp, Current)
				ev_children.extend (table_child)
			end
			-- The list start at one, then we change the attachment
			table_child.set_attachment (top, left, bottom, right)

			-- We show the child and resize the container
			child_imp.show
			notify_change (1 + 2)
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
				-- Add a child to the table. the child doesn't appear, it has to be
				-- placed after in the table to be shown.
		do
			child_imp.hide
		end

	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove the given child from the children of
			-- the container.
		local
			tchild: EV_TABLE_CHILD_IMP
		do
			tchild := find_widget_child (child_imp)
			ev_children.prune_all (tchild)
			notify_change (2 + 1)
		end

	set_top_level_window_imp (a_window: EV_UNTITLED_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			cur: CURSOR
		do
			top_level_window_imp := a_window
			if not ev_children.empty then
				list := ev_children
				from
					cur := list.cursor
					list.start
				until
					list.after
				loop
					list.item.widget.set_top_level_window_imp (a_window)
					list.forth
				end
				list.go_to (cur)
			end
		end

feature -- Basic operations

	propagate_background_color is
			-- Propagate the current background color of the container
			-- to the children.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			cur: CURSOR
		do
			if not ev_children.empty then
				list := ev_children
				from
					cur := list.cursor
					list.start
				until
					list.after
				loop
					list.item.widget.set_background_color (background_color)
					list.forth
				end
				list.go_to (cur)
			end
		end

	propagate_foreground_color is
			-- Propagate the current foreground color of the container
			-- to the children.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			cur: CURSOR
		do
			if not ev_children.empty then
				list := ev_children
				from
					cur := list.cursor
					list.start
				until
					list.after
				loop
					list.item.widget.set_foreground_color (foreground_color)
					list.forth
				end
				list.go_to (cur)
			end
		end

feature -- Assertions

	add_child_ok: BOOLEAN is
			-- Used in the precondition of
			-- 'add_child'. True, if it is ok to add a
			-- child to container
		do
			Result := True
		end

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of the container?
		do
			Result := find_widget_child (a_child) /= Void
		end

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Has `a_child' been added properly?
		do
			Result := not a_child.shown
		end

feature {NONE} -- Access features for implementation

	ev_children: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			-- List of the children of the tab.
			-- The children are in the order left -> right and top -> bottom of the
			-- table. An item that takes several cells are several times in the list.
			-- Be carefull to remove everything when needed.

	columns_minimum: ARRAYED_LIST [INTEGER]
			-- Width of the biggest element of the column (includes one spacing per cell).
			-- The last cell represent the total of the items of the list.

	rows_minimum: ARRAYED_LIST [INTEGER]
			-- Minimum value of each row.
			-- The last cell represent the total.

	columns_sum: INTEGER
			-- Sum of the minimums.

	rows_sum: INTEGER
			-- Sum of  the minimum.

feature {NONE} -- Resize Implementation

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER;
			repaint: BOOLEAN) is
			-- Move the window to `a_x', `a_y' position and
			-- resize it with `a_width', `a_height'.
		do
			set_local_size (a_width, a_height)
			move (a_x, a_y)
		end

	set_local_size (new_width, new_height: INTEGER) is
			-- Recalculate the values of both rows and columns. Do not resize the children for
			-- efficiency purposes.
		local
			columns_value, rows_value: ARRAYED_LIST [INTEGER]
		do
			columns_value := compute_values (columns_minimum, new_width, columns_sum, column_spacing, columns_homogeneous)
			rows_value := compute_values (rows_minimum, new_height, rows_sum, row_spacing, rows_homogeneous)
			if columns_value /= Void and rows_value /= Void then
				adjust_children (columns_value, rows_value)
			end
			resize (new_width, new_height)
		end

feature {NONE} -- Basic operations for implementation

	compute_minimum_width is
			-- Recompute the minimum_width of the object.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			minimums: ARRAYED_LIST [INTEGER]
			tchild: EV_TABLE_CHILD_IMP
			right, mw: INTEGER
			cur: CURSOR
		do
			list := ev_children
			initialize_columns (columns)

			-- A first loop for the children that take only one cell
			from
				cur := list.cursor
				minimums := columns_minimum
				list.start
			until
				list.after
			loop
				tchild := list.item
				right := tchild.right_attachment
				if (right - tchild.left_attachment = 1) then
					mw := tchild.widget.minimum_width
					if mw > minimums.i_th (right) then
						minimums.put_i_th (mw + column_spacing, right)
					end	
				end
				list.forth
			end

			-- Then, a second loop for the children that take more than one
			-- cell
			from
				list.start
			until
				list.after
			loop
				tchild := list.item
				if (tchild.right_attachment - tchild.left_attachment > 1) then
					second_body_loop (minimums, tchild.widget.minimum_width, tchild.left_attachment,
										tchild.right_attachment, column_spacing)
				end
				list.forth
			end
			list.go_to (cur)
			sum_columns_minimums
			internal_set_minimum_width (columns_sum)
		end

	compute_minimum_height is
			-- Recompute the minimum_width of the object.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			minimums: ARRAYED_LIST [INTEGER]
			tchild: EV_TABLE_CHILD_IMP
			bottom, mh: INTEGER
			cur: CURSOR
		do
			list := ev_children
			initialize_rows (rows)

			-- A first loop for the children that take only one cell
			from
				cur := list.cursor
				minimums := rows_minimum
				list.start
			until
				list.after
			loop
				tchild := list.item
				bottom := tchild.bottom_attachment
				if (bottom - tchild.top_attachment = 1) then
					mh := tchild.widget.minimum_height
					if mh > minimums.i_th (bottom) then
						minimums.put_i_th (mh + row_spacing, bottom)
					end	
				end
				list.forth
			end

			-- Then, a second loop for the children that take more than one
			-- cell
			from
				list.start
			until
				list.after
			loop
				tchild := list.item
				if (tchild.bottom_attachment - tchild.top_attachment > 1) then
					second_body_loop (minimums, tchild.widget.minimum_height, tchild.top_attachment,
										tchild.bottom_attachment, row_spacing)
				end
				list.forth
			end
			list.go_to (cur)
			sum_rows_minimums
			internal_set_minimum_height (rows_sum)
		end

	compute_minimum_size is
			-- Recompute the minimum size of the object.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			minrow, mincol: ARRAYED_LIST [INTEGER]
			tchild: EV_TABLE_CHILD_IMP
			bottom, mh: INTEGER
			right, mw: INTEGER
			cur: CURSOR
		do
			list := ev_children
			initialize_rows (rows)

			-- A first loop for the children that take only one cell
			from
				cur := list.cursor
				minrow := rows_minimum
				mincol := columns_minimum
				list.start
			until
				list.after
			loop
				tchild := list.item
				bottom := tchild.bottom_attachment
				right := tchild.right_attachment
				if (bottom - tchild.top_attachment = 1) then
					mh := tchild.widget.minimum_height
					if mh > minrow.i_th (bottom) then
						minrow.put_i_th (mh + row_spacing, bottom)
					end	
				end
				if (right - tchild.left_attachment = 1) then
					mw := tchild.widget.minimum_width
					if mw > mincol.i_th (right) then
						mincol.put_i_th (mw + column_spacing, right)
					end	
				end
				list.forth
			end

			-- Then, a second loop for the children that take more than one
			-- cell
			from
				list.start
			until
				list.after
			loop
				tchild := list.item
				if (tchild.bottom_attachment - tchild.top_attachment > 1) then
					second_body_loop (minrow, tchild.widget.minimum_height, tchild.top_attachment,
										tchild.bottom_attachment, row_spacing)
				end
				if (tchild.right_attachment - tchild.left_attachment > 1) then
					second_body_loop (mincol, tchild.widget.minimum_width, tchild.left_attachment,
										tchild.right_attachment, column_spacing)
				end
				list.forth
			end
			list.go_to (cur)
			sum_rows_minimums
			sum_columns_minimums
			internal_set_minimum_size (columns_sum, rows_sum)
		end

feature {NONE} -- Implementation

	compute_values (minimums: ARRAYED_LIST [INTEGER]; new_size, total_sum, spacing: INTEGER; homogeneous: BOOLEAN): ARRAYED_LIST [INTEGER] is
			-- Recalculate values depending on the options and the minimums. 
		local
			rate, total_rest, mark: INTEGER
			total_size, count: INTEGER
		do
			count := minimums.count
			if count = 1 then
				create Result.make_filled (2)
				Result.put_i_th (border_width, 1)
				Result.put_i_th (minimums.first + spacing, 2)
			else
				create Result.make_filled (count + 1)
				total_size := new_size + spacing - 2 * border_width

				-- In both case, homogeneous or not, the first line is after
				-- the border width.
				Result.start
				mark := border_width
				Result.replace (mark)
				Result.forth

				-- Homogeneous : All the cells have the same size.
				if homogeneous then
					rate := total_size // count
					total_rest := total_size \\ count
					from
					until
						Result.after
					loop
						-- We calculate the position of the new line.
						mark := mark + rate + rest (total_rest)
						total_rest := (total_rest - 1).max (0)

						-- We set it in the list.
						Result.replace (mark)

						-- We go one step furher
						Result.forth
					end

				-- Non homogeneous : we have to be carefull to the non expanded
				-- children too.
				else
					rate := (total_size - total_sum) // count
					total_rest := (total_size - total_sum) \\ count
					from
						minimums.start
					until
						minimums.after
					loop
						-- We calculate the position of the new line.
						mark := mark + minimums.item + rate + rest (total_rest)
						if total_rest > 0 then
							total_rest := total_rest - 1
						elseif total_rest < 0 then
							total_rest := total_rest + 1
						end

						-- We set it in the list.
						Result.replace (mark)

						-- We go one step furher
						Result.forth
						minimums.forth
					end
				end
			end
		end

	initialize_columns (value: INTEGER) is
			-- Recreate the columns_minimum list to have it empty.
		do
			columns_minimum.wipe_out
			columns_minimum.make_filled (value)
		end

	initialize_rows (value: INTEGER) is
			-- Recreate the rows_minimum list to have it empty.
		do
			rows_minimum.wipe_out
			rows_minimum.make_filled (value)
		end

	rest (total_rest: INTEGER): INTEGER is
				-- Give the rest we must add to the current child of
				-- ev_children when the size of the parent is not a 
				-- multiple of the number of children.
		do
			if total_rest > 0 then
				Result := 1
			elseif total_rest < 0 then
				Result := -1
			else
				Result := 0
			end
		end

	find_widget_child (a_child: EV_WIDGET_IMP): EV_TABLE_CHILD_IMP is
				-- Find the table child corresponding to a given widget
				-- child.
		require
			valid_child: a_child /= Void
			current_child: a_child.parent_imp = Current
			valie_children: ev_children /= Void
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			cur: CURSOR
		do
			list := ev_children
			if not list.empty then
				from
					cur := list.cursor
					list.start
				until
					list.after or Result /= Void
				loop
					if list.item.widget = a_child then
						Result := list.item
					end
					list.forth
				end
				list.go_to (cur)
			else
				Result := Void
			end
		end

	adjust_children (columns_value, rows_value: ARRAYED_LIST [INTEGER]) is
			-- Ask the children to move and to resize therself according to the given values :
			-- `columns_value' for the columns, `rows_value' for the rows.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			tchild: EV_TABLE_CHILD_IMP
			cs, rs: INTEGER
			cur: CURSOR
		do
			-- Initialize some local variables to be faster.
			list := ev_children
			if not list.empty then
				cs := column_spacing
				rs := row_spacing

				-- Then resize the children.
				from
					cur := list.cursor
					list.start
				until
					list.after
				loop
					tchild := list.item
					tchild.widget.set_move_and_size
						(columns_value @ (tchild.left_attachment + 1), rows_value @ (tchild.top_attachment + 1),
   						 columns_value @ (tchild.right_attachment + 1) - columns_value @ (tchild.left_attachment + 1) - cs,
   						 rows_value @ (tchild.bottom_attachment + 1 )- rows_value @ (tchild.top_attachment + 1) - rs)
					list.forth
				end
				list.go_to (cur)
			end
		end

	second_body_loop (minimums: ARRAYED_LIST [INTEGER]; value, first, last, spacing: INTEGER) is
			-- Loop on the several-cells widget to check their minimum parameter.
			-- We check than the current size is bigger than the actual lenght of the
			-- cells the widget wants to cover. Then, if it is bigger indeed, we
			-- distribute this value to the covered cells.
			-- And we set the atttributes of the line if it is necessary.
		local
			length, test, step, total_rest: INTEGER
			cur: CURSOR
		do
			-- Lets see what is the length of the current cells the
			-- widget covers.
			length := last - first
			cur := minimums.cursor
			from
				minimums.go_i_th (first + 1)
				test := 0
			until
				minimums.index = last + 1
			loop
				test := test + minimums.item + spacing
				if not minimums.after then
					minimums.forth
				end
			end

			-- If it is bigger than the current minimum size, we distribute the
			-- rest among the columns.
			if test < value + spacing then
				step := (value + spacing) // length
				total_rest := (value + spacing) \\ length
				from
					minimums.go_i_th (first + 1)
				until
					minimums.index = last + 1
				loop
					if total_rest > 0 then 
						minimums.replace (minimums.item + step + 1)
						total_rest := total_rest - 1
					else
						minimums.replace (minimums.item + step)
					end
					if not minimums.after then
						minimums.forth
					end
				end
			end
			minimums.go_to (cur)
		end

	sum_rows_minimums is
			-- Sum the elements of the given list and store it in the last item.
		local
			cur: CURSOR
			sum: INTEGER
			minimums: ARRAYED_LIST [INTEGER]
		do
			from
				minimums := rows_minimum
				cur := minimums.cursor
				minimums.start
				sum := 0
			until
				minimums.after
			loop
				sum := sum + minimums.item
				minimums.forth
			end
			rows_sum := sum
		end

	sum_columns_minimums is
			-- Sum the elements of the given list and store it in the last item.
		local
			cur: CURSOR
			sum: INTEGER
			minimums: ARRAYED_LIST [INTEGER]
		do
			from
				minimums := columns_minimum
				cur := minimums.cursor
				minimums.start
				sum := 0
			until
				minimums.after
			loop
				sum := sum + minimums.item
				minimums.forth
			end
			columns_sum := sum
		end

invariant

--	ev_children_not_void: ev_children /= Void
--	columns_exists: columns_value /= Void
--	rows_exists: rows_value /= Void

end -- class EV_TABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
