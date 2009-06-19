note
	description: "EiffelVision table, Cocoa implementation"
	author: "Daniel Furrer"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TABLE_IMP

inherit
	EV_TABLE_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface,
			set_item_position,
			set_item_span,
			remove,
			put,
			resize
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			make,
			set_top_level_window_imp
		end

create
	make

feature {NONE} -- Implementation

	make
		local
			box: NS_BOX
		do
			create box.make
			box.set_box_type ({NS_BOX}.box_custom)
			box.set_border_type ({NS_BOX}.no_border)
			cocoa_item := box

			-- Initialize internal values
			rows := 1
			columns := 1
			create ev_children.make (2)
			create internal_array.make (1, 1)
			rebuild_internal_item_list
			initialize

			create_columns
			create_rows
			disable_homogeneous
		end

	create_columns
			-- Initialize columns.
		do
			create columns_minimum.make_filled (1)
			column_spacing := Default_column_spacing
		end

	create_rows
			-- Initialize rows.
		do
			create rows_minimum.make_filled (1)
			row_spacing := Default_row_spacing
		end

feature -- Status report

	is_homogeneous: BOOLEAN
			-- Does Table have homogeneous spacing, no by default.

	row_spacing: INTEGER

	column_spacing: INTEGER

	border_width: INTEGER
			-- Width of border around container in pixels.
		do

		end

	replace (v: like item)
			-- Replace `item' with `v'.	
		do
			check
				to_be_implemented: False
			end
		end

feature -- Widget relationships

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_top_level_window_imp (a_window: EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			cur: CURSOR
		do
			top_level_window_imp := a_window
			if not ev_children.is_empty then
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


feature -- Status settings

	enable_homogeneous
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			is_homogeneous := True
		end

	disable_homogeneous
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			is_homogeneous := False
		end

	set_border_width (a_value: INTEGER)
			-- Set the tables border width to `a_value' pixels.
		do

		end

	set_row_spacing (a_value: INTEGER)
			-- Spacing between two rows of the table.
		do

		end

	set_column_spacing (a_value: INTEGER)
			-- Spacing between two columns of the table.
		do

		end

	put (child: EV_WIDGET; a_x, a_y, a_width, a_height: INTEGER)
			--	Add `child' to `Current' at cell position `a_x', `a_y',
			-- with size `a_width', `a_height' in cells.
		local
			table_child: EV_TABLE_CHILD_IMP
			child_imp: EV_WIDGET_IMP
		do
			Precursor {EV_TABLE_I} (child, a_x, a_y, a_width, a_height)
			child.implementation.on_parented
			child_imp ?= child.implementation
			check
				valid_child: child_imp /= Void
			end
			-- Set the parent of `child_imp'.
			child_imp.set_parent_imp (current)

			-- Create `table_child' to hold `child_imp'.
			create table_child.make (child_imp, Current)
			-- Add the table child to `ev_children'.
			ev_children.extend (table_child)
			-- Set the attachment of the table child.
			table_child.set_attachment (a_y - 1, a_x - 1, a_y + a_height - 1, a_x + a_width - 1)
			-- We show the child and resize the container
			child_imp.show
			cocoa_view.add_subview (child_imp.cocoa_view)
			notify_change (Nc_minsize, Current)
			new_item_actions.call ([child])
		end

	remove (v: EV_WIDGET)
			-- Remove `v' from the table if present.
		do

		end

	set_item_position (v: EV_WIDGET; a_column, a_row: INTEGER)
			-- Move `v' to position `a_column', `a_row'.
		do

		end

	item_column_position (widget: EV_WIDGET): INTEGER
			-- `Result' is column coordinate of `widget'.
		local
			widget_imp: EV_WIDGET_IMP
		do
			-- Retrieve implementation of `widget'.
			widget_imp ?= widget.implementation
			check
				implementation_not_void: widget_imp /= Void
			end
			Result := find_widget_child (widget_imp).left_attachment + 1
		end

	item_row_position (widget: EV_WIDGET): INTEGER
			-- `Result' is row coordinate of `widget'.
		local
			widget_imp: EV_WIDGET_IMP
		do
			-- Retrieve implementation of `widget'.
			widget_imp ?= widget.implementation
			check
				implementation_not_void: widget_imp /= Void
			end
			Result := find_widget_child (widget_imp).top_attachment + 1
		end

	item_column_span (widget: EV_WIDGET): INTEGER
			-- `Result' is number of columns taken by `widget'.
		local
			widget_child: EV_TABLE_CHILD_IMP
			widget_imp: EV_WIDGET_IMP
		do
			-- Retrieve implementation of `widget'.
			widget_imp ?= widget.implementation
			check
				implementation_not_void: widget_imp /= Void
			end
			widget_child := find_widget_child (widget_imp)
			Result := widget_child.right_attachment - widget_child.left_attachment
		end

	item_row_span (widget: EV_WIDGET): INTEGER
			-- `Result' is number of rows taken by `widget'.
		local
			widget_child: EV_TABLE_CHILD_IMP
			widget_imp: EV_WIDGET_IMP
		do
			-- Retrieve implementation of `widget'.	
			widget_imp ?= widget.implementation
			check
				implementation_not_void: widget_imp /= Void
			end
			widget_child := find_widget_child (widget_imp)
			Result := widget_child.bottom_attachment - widget_child.top_attachment
		end

feature {EV_ANY_I, EV_ANY} -- Status Settings

	resize (a_column, a_row: INTEGER)
		do
			Precursor {EV_TABLE_I} (a_column, a_row)
--			initialize_columns (a_column)
--			initialize_rows (a_row)
			notify_change (Nc_minsize, Current)
		end

	set_item_span (v: EV_WIDGET; column_span, row_span: INTEGER)
			-- Resize 'v' to occupy column span and row span
		do
		end

feature {NONE} -- Access features for implementation

	ev_children: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			-- List of the children of the tab.
			-- The children are in the order left -> right and top -> bottom of
			-- the table. An item that takes several cells are several times in
			-- the list. Be carefull to remove everything when needed.

	columns_minimum: ARRAYED_LIST [INTEGER]
			-- Width of the biggest element of the column
			-- The last cell represent the total of the items of the list.

	rows_minimum: ARRAYED_LIST [INTEGER]
			-- Minimum value of each row.
			-- The last cell represent the total.

	columns_sum: INTEGER
			-- Sum of the minimum column values.
			-- Used during sizing computations.

	rows_sum: INTEGER
			-- Sum of the minimum row values.
			-- Used during sizing computations.

feature {NONE} -- Basic operations for implementation

	compute_minimum_width
			-- Recompute minimum_width of `Curren'.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			minimums: ARRAYED_LIST [INTEGER]
			tchild: EV_TABLE_CHILD_IMP
			right, mw: INTEGER
			cur: CURSOR
		do
			list := ev_children
			if not list.is_empty then
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
							minimums.put_i_th (mw, right)
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
					if (tchild.right_attachment - tchild.left_attachment > 1)
						then
						second_body_loop (minimums, tchild.widget.minimum_width,
							tchild.left_attachment, tchild.right_attachment,
							column_spacing)
					end
					list.forth
				end
				list.go_to (cur)
				if is_homogeneous then
						-- Note that `sum_rows_minimum' does not correctly sum when homogeneous,
						-- as the values are still the non - homogeneous transformed values.
						-- Therefore, we compute directly.
					internal_set_minimum_width (maximum_value (columns_minimum) * columns_minimum.count +
						border_width * 2 + column_spacing * (columns_minimum.count - 1))
				else
					sum_columns_minimums
					internal_set_minimum_width (columns_sum + border_width * 2)
				end
			else
				internal_set_minimum_width (0)
			end
		end

	compute_minimum_height
			-- Recompute minimum_width of `Current'.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			minimums: ARRAYED_LIST [INTEGER]
			tchild: EV_TABLE_CHILD_IMP
			bottom, mh: INTEGER
			cur: CURSOR
		do
			list := ev_children
			if not list.is_empty then
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
							minimums.put_i_th (mh, bottom)
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
					if (tchild.bottom_attachment - tchild.top_attachment > 1)
						then
						second_body_loop (minimums, tchild.widget.minimum_height,
							tchild.top_attachment, tchild.bottom_attachment,
							row_spacing)
					end
					list.forth
				end
				list.go_to (cur)
				if is_homogeneous then
						-- Note that `sum_rows_minimum' does not correctly sum when homogeneous,
						-- as the values are still the non - homogeneous transformed values.
						-- Therefore, we compute directly.
					internal_set_minimum_height (maximum_value (rows_minimum) * rows_minimum.count +
						border_width * 2 + row_spacing * (rows_minimum.count - 1))
				else
					sum_rows_minimums
					internal_set_minimum_height (rows_sum + border_width * 2)
				end
			else
				internal_set_minimum_height (0)
			end
		end

	compute_minimum_size
			-- Recompute minimum size of `Current'.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			minrow, mincol: ARRAYED_LIST [INTEGER]
			tchild: EV_TABLE_CHILD_IMP
			bottom, mh: INTEGER
			right, mw: INTEGER
			cur: CURSOR
		do
			list := ev_children
			if not list.is_empty then
				initialize_rows (rows)
				initialize_columns (columns)

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
							minrow.put_i_th (mh, bottom)
						end
					end
					if (right - tchild.left_attachment = 1) then
						mw := tchild.widget.minimum_width
						if mw > mincol.i_th (right) then
							mincol.put_i_th (mw, right)
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
					if (tchild.bottom_attachment - tchild.top_attachment > 1)
						then
						second_body_loop (minrow, tchild.widget.minimum_height,
							tchild.top_attachment, tchild.bottom_attachment,
							row_spacing)
					end
					if (tchild.right_attachment - tchild.left_attachment > 1)
						then
						second_body_loop (mincol, tchild.widget.minimum_width,
							tchild.left_attachment, tchild.right_attachment,
							column_spacing)
					end
					list.forth
				end
				list.go_to (cur)
				if is_homogeneous then
						-- Note that `sum_rows_minimum' does not correctly sum when homogeneous,
						-- as the values are still the non - homogeneous transformed values.
						-- Therefore, we compute directly.
					internal_set_minimum_size (maximum_value (columns_minimum) * columns_minimum.count + border_width * 2 + column_spacing * (columns_minimum.count - 1), maximum_value (rows_minimum) * rows_minimum.count + border_width * 2 + row_spacing * (rows_minimum.count - 1))
				else
					sum_rows_minimums
					sum_columns_minimums
					internal_set_minimum_size (columns_sum + border_width * 2, rows_sum + border_width * 2)
				end
			else
				internal_set_minimum_size (border_width * 2, border_width * 2)
			end
		end

feature {NONE} -- Resize Implementation

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width,
					a_height, repaint)
			set_local_size (a_width, a_height, False)
		end

	set_local_size (new_width, new_height: INTEGER; originator: BOOLEAN)
			-- Recalculate the values of both rows and columns.
			-- Do not resize the children for efficiency purposes.
		local
			columns_value, rows_value: ARRAYED_LIST [INTEGER]
		do
				-- If `Current' is homogeneous, then we need to adapt
				-- `columns_minimum' and `rows_minimum' so each of
				-- their values is equal to the greatest of their values
				-- before hand. This provides the necessary information
				-- to draw the widgets correctly when `is_homogeneous'.
				-- We then need to re-sum the minimums.
				-- We only adjust the minimums when homogenous at this
				-- late stage, so we can be sure that we really have correctly
				-- calculated the correct largest child area.
			if is_homogeneous then
				adjust_minimums_homogeneous (columns_minimum)
				adjust_minimums_homogeneous (rows_minimum)
				sum_columns_minimums
				sum_rows_minimums
			end
			columns_value := compute_values (columns_minimum,
							new_width, columns_sum, column_spacing)
			rows_value := compute_values (rows_minimum, new_height,
							rows_sum, row_spacing)
			if columns_value /= Void and rows_value /= Void then
				adjust_children (columns_value, rows_value, originator)
			end
		end

	adjust_minimums_homogeneous (minimums: ARRAYED_LIST [INTEGER])
			-- Adapt `minimums' so all values are equivalent to maximum value
			-- of `minimums'.
		local
			maximum: INTEGER
		do
			maximum := maximum_value (minimums)
			from
				minimums.start
			until
				minimums.off
			loop
				minimums.replace (maximum)
				minimums.forth
			end
		end

feature {NONE} -- Implementation

	compute_values (minimums: ARRAYED_LIST [INTEGER]; new_size, total_sum, spacing: INTEGER): ARRAYED_LIST [INTEGER]
			-- Recalculate values depending on the options and the minimums.
		local
			rate, total_rest, mark: INTEGER
			total_size, count1: INTEGER
		do
			count1 := minimums.count
			if count1 = 1 then
				create Result.make_filled (2)
				Result.put_i_th (border_width, 1)
				Result.put_i_th (new_size - border_width , 2)
			else
				create Result.make_filled (count1 + 1)

				total_size := new_size - border_width * 2
				rate := (total_size - total_sum) // count1
				total_rest := (total_size - total_sum) \\ count1

				-- In both case, homogeneous or not, the first line is after
				-- the border width.
				Result.start
				mark := border_width
				Result.replace (mark)
				Result.forth

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

	initialize_columns (value: INTEGER)
			-- Recreate `columns_minimum'.
		do
			columns_minimum.wipe_out
			columns_minimum.make_filled (value)
		end

	initialize_rows (value: INTEGER)
			-- Recreate `rows_minimum'.
		do
			rows_minimum.wipe_out
			rows_minimum.make_filled (value)
		end

	rest (total_rest: INTEGER): INTEGER
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

	find_widget_child (a_child: EV_WIDGET_IMP): EV_TABLE_CHILD_IMP
			-- `Result' is the table child containing `a_child'.
		require
			valid_child: a_child /= Void
			current_child: a_child.parent_imp = Current
			valie_children: ev_children /= Void
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			cur: CURSOR
		do
			list := ev_children
			if not list.is_empty then
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

	adjust_children	(columns_value, rows_value: ARRAYED_LIST [INTEGER];	originator: BOOLEAN)
			-- Ask the children to move and to resize theirselves
			-- according to the given values :
			-- `columns_value' for the columns, `rows_value' for the rows.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			tchild: EV_TABLE_CHILD_IMP
			cs, rs: INTEGER
			cur: CURSOR
			left, right, bottom, top: INTEGER
			column_spacing_to_add, row_spacing_to_add: INTEGER
		do
				-- Initialize local variables for speed.
			list := ev_children
			if not list.is_empty then
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
						left := tchild.left_attachment + 1
						right := tchild.right_attachment + 1
						bottom := tchild.bottom_attachment + 1
						top := tchild.top_attachment + 1

						if (bottom - top > 1) and (rows_value @ bottom - rows_value @ top + ((bottom - top - 1) * row_spacing) >= tchild.widget.minimum_height) then
							row_spacing_to_add := (bottom - top - 1) * row_spacing
						else
							row_spacing_to_add := 0
						end

						if (right - left > 1) and (columns_value @ right - columns_value @ left + ((right - left - 1) * column_spacing) > tchild.widget.minimum_width) then
							column_spacing_to_add := (right - left - 1) * column_spacing
						else
							column_spacing_to_add := 0
						end

					if originator then
						tchild.widget.set_move_and_size
							(columns_value @ left + ((left -1) * column_spacing),
							rows_value @ top + ((top - 1) * row_spacing),
							columns_value @ right - columns_value @ left + column_spacing_to_add,
							rows_value @ bottom - rows_value @ top + row_spacing_to_add)
					else
						tchild.widget.ev_apply_new_size
							(columns_value @ left + ((left -1) * column_spacing),
							rows_value @ top + ((top - 1) * row_spacing),
							columns_value @ right - columns_value @ left,
							rows_value @ bottom - rows_value @ top + row_spacing_to_add, True)
					end
					list.forth
				end
				list.go_to (cur)
			end
		end

	second_body_loop (minimums: ARRAYED_LIST [INTEGER]; minimum_value, first, last,	spacing: INTEGER)
			-- Adjust `minimums' to take into account widgets that occupy more
			-- than one cell.
			-- `minimum_value' is minimum width of widget at span `first', `last'.
			-- `spacing' is spacing between each table cell.
		local
			length, current_minimums_total, step, total_rest: INTEGER
			cur: CURSOR
			clone_min: ARRAYED_LIST [INTEGER]
		do
			-- Lets see what is the length of the current cells the
			-- widget covers and place it in `current_minimums_total'.
			-- We can then use this to see if the rows need to be enlarged
			-- to fit a multiple spanned widget.
			length := last - first
			cur := minimums.cursor
			from
				minimums.go_i_th (first + 1)
			until
				minimums.index = last + 1
			loop
				current_minimums_total := current_minimums_total + minimums.item
				if not minimums.after then
					minimums.forth
				end
			end

			-- If `current_minimums_total' is bigger than the current minimum size, we distribute the
			-- rest among the other areas.
			if current_minimums_total < minimum_value - (length - 1) * spacing then
					-- Set step to the `width' + `spacing'
				step := (minimum_value - (length - 1) * spacing)
				clone_min := minimums.twin

					-- Reduce step by the total values contained in `minimums'
					-- between the `first' + 1 and `last'.
				from
					clone_min.go_i_th (first + 1)
				until
					clone_min.index = last + 1
				loop
					step := step - clone_min.item
					if not clone_min.after then
						clone_min.forth
					end
				end
				total_rest := step \\ length
				step := step // length
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

	sum_rows_minimums
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
					-- Add row spacing for completely empty rows.
					-- Need to ignore the last one.
				if minimums.index /= 0 and minimums.index /= minimums.count then
					sum := sum + row_spacing
				end
				minimums.forth
			end
			rows_sum := sum
		end

	sum_columns_minimums
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
					-- Add column spacing for completely empty columns.
				if minimums.index /= 0 and minimums.index /= minimums.count then
					sum := sum + column_spacing
				end
				minimums.forth
			end
			columns_sum := sum
		end

	maximum_value (values: ARRAYED_LIST [INTEGER]): INTEGER
			-- `Result' is maximum integer value in `values'.
		do
			from
				values.start
			until
				values.off
			loop
				if values.item > Result then
					Result := values.item
				end
				values.forth
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_TABLE note option: stable attribute end;

end -- class EV_TABLE_IMP
