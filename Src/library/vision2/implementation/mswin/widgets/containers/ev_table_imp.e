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
		redefine
			interface
		end
		
	EV_CONTAINER_IMP
		redefine
			disable_sensitive,
			enable_sensitive,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size,
			interface,
			initialize,
			on_size
		end
		
	EV_WEL_CONTROL_CONTAINER_IMP
		rename
			make as ev_wel_control_container_make
		redefine
			top_level_window_imp
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with `an_interface'.
		do
			base_make (an_interface)
			ev_wel_control_container_make
			create ev_children.make (2)
		end	

	initialize is
			-- Initialize `Current'. Precusor and create new_item_actions.
		do
			create_columns
			create_rows
			Precursor {EV_CONTAINER_IMP}
			disable_homogeneous
		end

	create_columns is
			-- Initialize columns.
		do
			create columns_minimum.make_filled (1)
			column_spacing := Default_column_spacing
		end

	create_rows is
			-- Initialize rows.
		do
			create rows_minimum.make_filled (1)
			row_spacing := Default_row_spacing
		end

feature {EV_TABLE_I} -- Access

	count: INTEGER is
			-- Number of widgets contained in `Current'.
		do
			Result := ev_children.count
		end

	is_homogeneous: BOOLEAN
			-- Are all the cells equal in size ?
			--| Gtk does not allow you to set the homogenuity of the
			--| Columns seperately from that of the rows.
			--| We provide the same behaviour for this implementation.

	border_width: INTEGER
			-- Widgth of the border of the container in pixels.

	column_spacing: INTEGER
			-- Spacing between two columns in pixels.

	row_spacing: INTEGER
			-- Spacing betwwen two rows in pixels.

feature {EV_TABLE_I} -- Status report

	rows: INTEGER is
			-- Number of rows in `Current'
		do
			Result := rows_minimum.count
		end

	columns: INTEGER is
			-- Number of columns in `Current'
		do
			Result := columns_minimum.count
		end

	widget_count: INTEGER is
			-- Number of widgets in `Current'.
		do
			check
				to_be_implemented: False
			end
		end

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	is_control_in_window (hwnd_control: POINTER): BOOLEAN is
			-- Is the control of handle `hwnd_control'
			-- located inside `Current'?
		local	
			loc_cursor: CURSOR
		do
			if hwnd_control = wel_item then
				Result := True
			else
				loc_cursor := ev_children.cursor
				from
					ev_children.start
				until
					Result or ev_children.after
				loop
					Result := ev_children.item.widget.
						is_control_in_window (hwnd_control)
					ev_children.forth
				end
				ev_children.go_to (loc_cursor)
			end
		end


feature -- Status settings

	disable_sensitive is
			-- Set `Current' insensitive.
		do
			set_insensitive (True)
			Precursor
		end

	enable_sensitive is
			-- Set `Current' sensitive.
		do
			set_insensitive (False)
			Precursor
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set `Current' sensitive if `sensitive'.
			-- Set `Current' insensitive if not `sensitive'.
			--| As it is a container, all children's sensitivity
			--| is updated to the same as `Current'.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			widget_imp: EV_WIDGET_IMP
			cur: CURSOR
		do
			if not ev_children.is_empty then
				list := ev_children
				from
					cur := list.cursor
					list.start
				until
					list.after
				loop
					widget_imp := list.item.widget
					if flag then
						widget_imp.disable_sensitive
					else
						if not widget_imp.internal_non_sensitive then
							list.item.widget.enable_sensitive
						end
					end
					list.forth
				end
				list.go_to (cur)
			end
		ensure
			cursor_not_moved: old ev_children.index = ev_children.index
		end

	enable_homogeneous is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			is_homogeneous := True
			notify_change (2 + 1, Current)
		end

	disable_homogeneous is
			-- Disable homogeneous. Allow controls to take different sizes.
		do
			is_homogeneous := False
		end
	
	set_row_spacing (value: INTEGER) is
			-- Make `value' the new `row_spacing'.
		do
			row_spacing := value
			notify_change (2, Current)
		end

	set_column_spacing (value: INTEGER) is
			-- Make `value' the new `column_spacing'.
		do
			column_spacing := value
			notify_change (1, Current)
		end

	set_border_width (a_value: INTEGER) is
			-- Spacing between edge of `Current' and items.
		do
			border_width := a_value
			notify_change (2 + 1, Current)
		end

		replace (v: like item) is
			-- Replace `item' with `v'.
			do
				check
					to_be_implemented: False
				end
			end

	put, set_position_by_widget
		(the_child: EV_WIDGET; a_x, a_y, a_width, a_height: INTEGER) is
			--	Add a child to `Current' at cell position `a_x', `a_y',
			-- with size `a_width', `a_height' in cells.
		local
			table_child: EV_TABLE_CHILD_IMP
			child_imp: EV_WIDGET_IMP
		do
			child_imp ?= the_child.implementation
			check
				valid_child: child_imp /= Void
			end
				-- Set the parent of `child_imp'.
			child_imp.set_parent (Current.interface)
				-- Create `table_child' to hold `child_imp'.
			create table_child.make (child_imp, Current)
				-- Add the table child to `ev_children'.
			ev_children.extend (table_child)
				-- Set the attachment of the table child.
			table_child.set_attachment
				(a_y - 1, a_x - 1, a_y + a_height - 1, a_x + a_width - 1)
		

			-- We show the child and resize the container
			child_imp.show
			notify_change (1 + 2, Current)
		end

	resize (a_column, a_row: INTEGER) is
			-- Resize the table to `a_column', `a_row'.
		do
				initialize_columns (a_column)
				initialize_rows (a_row)
		end

	
	remove (v: EV_WIDGET) is
			-- Remove `v' from `Current' if present.
		local
			widget_imp: EV_WIDGET_IMP
			tchild: EV_TABLE_CHILD_IMP
		do
				-- Retrieve implementation of `v'.
			widget_imp ?= v.implementation
			check
				implementation_not_void: widget_imp /= Void
			end
				-- Call `remove_item_actions' for `Current'.
			remove_item_actions.call ([widget_imp.interface])
				-- Retrieve the table child for `tchild'.
			tchild := find_widget_child (widget_imp)
				-- Remove the table child from `ev_children'.
			ev_children.prune_all (tchild)
				-- Update changes.
			notify_change (2 + 1, Current)
				-- Update the parent of `child_imp'.
			widget_imp.set_parent (Void)
				-- Call on_orphaned.
			widget_imp.on_orphaned
		end


feature -- Element change

	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
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

feature {NONE} -- Assertions

	is_child (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Is `a_child' a child of `Current'?
		do
			Result := find_widget_child (a_child) /= Void
		end

feature {NONE} -- Access features for implementation

	ev_children: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			-- List of the children of the tab.
			-- The children are in the order left -> right and top -> bottom of
			-- the table. An item that takes several cells are several times in
			-- the list. Be carefull to remove everything when needed.

	columns_minimum: ARRAYED_LIST [INTEGER]
			-- Width of the biggest element of the column
			-- (includes one spacing per cell).
			-- The last cell represent the total of the items of the list.

	rows_minimum: ARRAYED_LIST [INTEGER]
			-- Minimum value of each row.
			-- The last cell represent the total.

	columns_sum: INTEGER
			-- Sum of the minimums.

	rows_sum: INTEGER
			-- Sum of  the minimum.

feature {NONE} -- Resize Implementation

	on_size (size_type, a_width, a_height: INTEGER) is
			-- `Current' has been resized.
		do
			Precursor {EV_CONTAINER_IMP} (size_type, a_width, a_height)
			set_local_size (a_width, a_height, True)
		end

	ev_apply_new_size (a_x_position, a_y_position,
				a_width, a_height: INTEGER; repaint: BOOLEAN) is
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width,
					a_height, repaint)
			set_local_size (a_width, a_height, False)
		end

	set_local_size (new_width, new_height: INTEGER; originator: BOOLEAN) is
			-- Recalculate the values of both rows and columns.
			-- Do not resize the children for efficiency purposes.
		local
			columns_value, rows_value: ARRAYED_LIST [INTEGER]
		do
			columns_value := compute_values (columns_minimum,
							new_width, columns_sum, column_spacing)
			rows_value := compute_values (rows_minimum, new_height,
							rows_sum, row_spacing)
			if columns_value /= Void and rows_value /= Void then
				adjust_children (columns_value, rows_value, originator)
			end
		end

feature {NONE} -- Basic operations for implementation

	compute_minimum_width is
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
					if (tchild.right_attachment - tchild.left_attachment > 1)
						then
						second_body_loop (minimums, tchild.widget.minimum_width,
							tchild.left_attachment, tchild.right_attachment,
							column_spacing)
					end
					list.forth
				end
				list.go_to (cur)
				sum_columns_minimums
				ev_set_minimum_width (columns_sum)
			else
				ev_set_minimum_width (0)
			end
		end

	compute_minimum_height is
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
					if (tchild.bottom_attachment - tchild.top_attachment > 1)
						then
						second_body_loop (minimums,tchild.widget.minimum_height,
							tchild.top_attachment, tchild.bottom_attachment,
							row_spacing)
					end
					list.forth
				end
				list.go_to (cur)
				sum_rows_minimums
				ev_set_minimum_height (rows_sum)
			else
				ev_set_minimum_height (0)
			end
		end

	compute_minimum_size is
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
				sum_rows_minimums
				sum_columns_minimums
				ev_set_minimum_size (columns_sum, rows_sum)
			else
				ev_set_minimum_size (0, 0)
			end
		end

feature {NONE} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN) is
			-- Pick and drop status has changed so notify children.
		do
			--| FIXME Propagate to  children.
		end
		

	compute_values
		(minimums: ARRAYED_LIST [INTEGER]; new_size, total_sum, spacing: INTEGER
		): ARRAYED_LIST [INTEGER] is
			-- Recalculate values depending on the options and the minimums. 
		local
			rate, total_rest, mark: INTEGER
			total_size, count1: INTEGER
		do
			count1 := minimums.count
			if count1 = 1 then
				create Result.make_filled (2)
				Result.put_i_th (border_width, 1)
				Result.put_i_th (minimums.first + spacing, 2)
			else
				create Result.make_filled (count1 + 1)

				total_size := new_size + spacing - 2 * border_width
				-- In both case, homogeneous or not, the first line is after
				-- the border width.
				Result.start
				mark := border_width
				Result.replace (mark)
				Result.forth

					-- Homogeneous : All the cells have the same size.
				if is_homogeneous then
					count1 := Result.count - 1
					rate := total_size // count1
					total_rest := total_size \\ count1
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

					-- Non homogeneous : we have to be carefull to the non
					-- expanded children too.
				else
					rate := (total_size - total_sum) // count1
					total_rest := (total_size - total_sum) \\ count1
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
			-- Recreate `columns_minimum'.
		do
			columns_minimum.wipe_out
			columns_minimum.make_filled (value)
		end

	initialize_rows (value: INTEGER) is
			-- Recreate `rows_minimum'.
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

	adjust_children
		(columns_value, rows_value: ARRAYED_LIST [INTEGER];
		originator: BOOLEAN) is
			-- Ask the children to move and to resize theirselves
			-- according to the given values :
			-- `columns_value' for the columns, `rows_value' for the rows.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			tchild: EV_TABLE_CHILD_IMP
			cs, rs: INTEGER
			cur: CURSOR
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
					if originator then
						tchild.widget.set_move_and_size
							(columns_value @ (tchild.left_attachment + 1),
							rows_value @ (tchild.top_attachment + 1),
							columns_value @ (tchild.right_attachment + 1) -
							columns_value @ (tchild.left_attachment + 1) - cs,
							rows_value @ (tchild.bottom_attachment + 1 )-
							rows_value @ (tchild.top_attachment + 1) - rs)
					else
						tchild.widget.ev_apply_new_size
							(columns_value @ (tchild.left_attachment + 1),
							rows_value @ (tchild.top_attachment + 1),
							columns_value @ (tchild.right_attachment + 1) -
							columns_value @ (tchild.left_attachment + 1) - cs,
							rows_value @ (tchild.bottom_attachment + 1 )-
							rows_value @ (tchild.top_attachment + 1) - rs, True)
					end
					list.forth
				end
				list.go_to (cur)
			end
		end

	second_body_loop
		(minimums: ARRAYED_LIST [INTEGER]; value, first, last,
		spacing: INTEGER) is
			-- Adjust `minimums' to take into account widgets that occupy more
			-- than one cell.
			-- `value' is minimum width of widget at span `first', `last'.
			-- `spacing' is spacing between each table cell.
		local
			length, current_minimums_total, step, total_rest: INTEGER
			cur: CURSOR
			clone_min: ARRAYED_LIST [INTEGER]
		do
			-- Lets see what is the length of the current cells the
			-- widget covers.
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

			-- If it is bigger than the current minimum size, we distribute the
			-- rest among the columns.
			if current_minimums_total < value + spacing then
					-- Set step to the `width' + `spacing'
				step := (value + spacing)
				clone_min := clone (minimums)

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
					-- Add row spacing for completely empty rows.
				if minimums.item = 0 and row_spacing /= 0 then
					sum := sum + row_spacing
				end
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
					-- Add column spacing for completely empty columns.
				if minimums.item = 0 and column_spacing /= 0 then
					sum := sum + column_spacing
				end
				minimums.forth
			end
			columns_sum := sum
		end
		
	adjust_tab_ordering (ordered_widgets: ARRAYED_LIST [WEL_WINDOW]; widget_depths: ARRAYED_LIST [INTEGER]; depth: INTEGER) is
			-- Adjust tab ordering of children in `Current'.
			-- used when `Current' is a child of an EV_DIALOG_IMP_MODAL
			-- or an EV_DIALOG_IMP_MODELESS. When 
		do
			--| FIXME implement.
		end

feature -- Implementation

	interface: EV_TABLE

invariant

	ev_children_not_void: ev_children /= Void

end -- class EV_TABLE_IMP

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

