indexing
	description: 
		"Eiffel Vision table. Ms windows implementation";
	note: " This class doesn't inherit from%
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
			child_minwidth_changed,
			child_minheight_changed,
			on_first_display,
			child_added
		end

	EV_WEL_CONTROL_CONTAINER_IMP
		redefine
			make,
			move_and_resize
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
			!! ev_children.make (2)
			!! columns_value.make (1)
			!! fix.make_filled (4)
			columns_value.extend (fix)
			!! rows_value.make (0)
			!! fix.make_filled (4)
			rows_value.extend (fix)
			set_homogeneous (Default_homogeneous)
			set_row_spacing (Default_row_spacing)
			set_column_spacing (Default_column_spacing)
			set_text ("EV_TABLE")
		end	

feature -- Access

	row_spacing: INTEGER is
			-- Spacing between two rows
		do
			Result := rows_value.first @ 3
		end

	column_spacing: INTEGER is
			-- spacing between two columns
		do
			Result := columns_value.first @ 3
		end

	is_homogeneous: BOOLEAN
			-- Does children have the same size ?

feature -- Status report

	rows: INTEGER is
			-- Number of rows
		do
			Result := rows_value.count - 1
		end

	columns: INTEGER is
			-- Number of columns
		do
			Result := columns_value.count - 1
		end

feature -- Status settings

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if
				-- `flag'.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
		do
			if not ev_children.empty then
				list := ev_children
				from
					list.start
				until
					list.after
				loop
					list.item.widget.set_insensitive (flag)
					list.forth
				end
			end
			{EV_CONTAINER_IMP} Precursor (flag)
		end

	set_homogeneous (flag: BOOLEAN) is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			is_homogeneous := flag
			if not ev_children.empty then
				initialize_at_minimum
			end
		end
	
	set_row_spacing (value: INTEGER) is
			-- Make `value' the new `row_spacing'.
		do
			rows_value.first.put_i_th (value, 3)
			if not ev_children.empty then
				initialize_at_minimum
			end
		end

	set_column_spacing (value: INTEGER) is
			-- Make `value' the new `column_spacing'.
		do
			columns_value.first.put_i_th (value, 3)
			if not ev_children.empty then
				initialize_at_minimum
			end
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
			expand_line (columns_value, right, child_imp.expandable)
			expand_line (rows_value, bottom, child_imp.expandable)

			-- Then, we check if the children has already been placed in the table,
			-- if not, we create a table child with the given information.
			table_child := find_widget_child (child_imp)
			if table_child = Void then
				!! table_child.make (child_imp, Current)
				ev_children.extend (table_child)
			end
			-- The list start at one, then we change the attachment
			table_child.set_attachment (top + 1, left + 1, bottom + 1, right + 1)

			-- We show the child and resize the container
			child_imp.show
			update_display
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
			child_minwidth_changed (0, child_imp)
			child_minheight_changed (0, child_imp)
			tchild := find_widget_child (child_imp)
			ev_children.prune_all (tchild)
			update_display
		end

	set_top_level_window_imp (a_window: WEL_WINDOW) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
		do
			top_level_window_imp := a_window
			if not ev_children.empty then
				list := ev_children
				from
					list.start
				until
					list.after
				loop
					list.item.widget.set_top_level_window_imp (a_window)
					list.forth
				end
			end
		end

feature -- Basic operations

	propagate_background_color is
			-- Propagate the current background color of the container
			-- to the children.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
		do
			if not ev_children.empty then
				list := ev_children
				from
					list.start
				until
					list.after
				loop
					list.item.widget.set_background_color (background_color)
					list.forth
				end
			end
		end

	propagate_foreground_color is
			-- Propagate the current foreground color of the container
			-- to the children.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
		do
			if not ev_children.empty then
				list := ev_children
				from
					list.start
				until
					list.after
				loop
					list.item.widget.set_foreground_color (foreground_color)
					list.forth
				end
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

feature {NONE} -- Implementation attributes

	ev_children: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			-- List of the children of the tab

	columns_value: ARRAYED_LIST [FIXED_LIST [INTEGER]]
			-- Information about the columns from the left to the right
			-- The fixed list keep the three following informations :
			-- 1 -> Difference between the number of expanded and non expanded
			--		children of the column?.
			--		In the first field of the 0 index, there is the number of column
			--		which are expanded.	
			-- 2 -> What is the size of the biggest element in the column number index?
			--      In the second field of the 0 index, there is the homogeneous value
			--      of the columns.
			-- 3 -> Did the current column receive any rest already (0 or 1)?
			--		In the third field of the 0 index, there is the column_spacing
			--		value stored.
			-- 4 -> What is the current width of the column?
			--		In the forth field of the 0 index, there is the value of the border.

	rows_value: ARRAYED_LIST [FIXED_LIST[INTEGER]]
			-- Information about the rows from the top to the bottom.
			-- The fixed list keep the three following informations :
			-- 1 -> Difference between the number of expanded and non expanded
			--		children of the row?
			--		In the first field of the 0 index, there is the number of rows
			--		which are expanded.
			-- 2 -> What is the size of the biggest element in the row number index?
			--      In the second field of the 0 index, there is the homogeneous value
			--      of the rows.
			-- 3 -> Did the current row received any rest already (0 or 1)?
			--		In the thired field of the 0 index, there is the row_spacing
			--		value stored.
			-- 4 -> What is the current height of the row?
			--		In the forth field of the 0 index, there is the value of the border.

feature {NONE} -- Basic operation

	expand_line (line: ARRAYED_LIST [FIXED_LIST [INTEGER]]; last: INTEGER; childexpand: BOOLEAN) is
				-- Expand a list to have `last' number of items in it.
		local
			index: INTEGER
			fix: FIXED_LIST [INTEGER]
		do
			if last >= line.count then
				from
					index := line.count
				until
					index = last + 1
				loop
					!! fix.make_filled (4)
					if childexpand then
						fix.put_i_th (1, 1)
						line.first.put_i_th (line.first.first + 1, 1)
					else
						fix.put_i_th (0, 1)
					end
					line.extend (fix)
					index := index + 1
				end
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
		do
			list := ev_children
			if not list.empty then
				from
					list.start
				until
					list.after or Result /= Void
				loop
					if list.item.widget = a_child then
						Result := list.item
					end
					list.forth
				end
			else
				Result := Void
			end
		end

	clear_line (line: ARRAYED_LIST [FIXED_LIST [INTEGER]]) is
			-- Clear the 2nd, 3rd and 4th element of all the items of
			-- the line to refill them after with new values.
		require
			valid_line: line /= Void and then not line.empty
		local
			fix: FIXED_LIST [INTEGER]
		do
			from
				line.go_i_th (2)
			until
				line.after
			loop
				fix := line.item
				fix.put_i_th (0, 2)
				fix.put_i_th (0, 3)
				fix.put_i_th (0, 4)
				line.forth
			end
		end

	initialize_rest (line: ARRAYED_LIST [FIXED_LIST [INTEGER]]; value: INTEGER) is 
			-- Put the rest of all the lines to `value' which depends of the
			-- sign of the rest. Do not use `start', `after' and `force'
			-- because it is already called in a feature that use the index.
		require
			valid_line: line /= Void and then not line.empty
			valid_value: value = 0 or value = 1
		local
			index: INTEGER
		do
			from
				index := 2
			until
				index = line.count + 1
			loop
				(line @ index).put_i_th (value, 3)
				index := index + 1
			end
		end

	adjust_children is
			-- Ask the children to move and to resize therself according to their options.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			tchild: EV_TABLE_CHILD_IMP
			cm: ARRAYED_LIST [FIXED_LIST [INTEGER]]
			rw: ARRAYED_LIST [FIXED_LIST [INTEGER]]
		do
			-- Initialize some local variables to be faster.
			list := ev_children
			if not list.empty then
				cm := columns_value
				rw := rows_value
				-- Then resize the children.
				from
					list.start
				until
					list.after
				loop
					tchild := list.item
					tchild.widget.set_move_and_size
						((cm @ (tchild.left_attachment)).last,
   						(rw @ (tchild.top_attachment)).last,
   						(cm @ (tchild.right_attachment)).last - (cm @ (tchild.left_attachment)).last - column_spacing,
   						(rw @ (tchild.bottom_attachment)).last - (rw @ (tchild.top_attachment)).last - row_spacing)
					list.forth
				end
			end
		end

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
			-- Make `new_width' and `new_height' the new size of the table.
		local
			temp_value: INTEGER
		do
			-- For the width first.
			if new_width /= width then
				temp_value := new_width - width
				if columns_value.first.first /= 0 then
					size_loop_body (columns_value, temp_value // columns_value.first.first, temp_value \\ columns_value.first.first)
				end
			end
			-- Then, the height :
			if new_height /= height then
				temp_value := new_height - height
				if rows_value.first.first /= 0 then
					size_loop_body (rows_value, temp_value // rows_value.first.first, temp_value \\ rows_value.first.first)
				end
			end
			-- We resize the children
			resize (columns_value.last.last - column_spacing, rows_value.last.last - row_spacing)
			adjust_children
		end

	size_loop_body (line: ARRAYED_LIST [FIXED_LIST [INTEGER]]; step, a_rest: INTEGER) is
			-- Body of the loop used in the `set_local_size' feature.
			-- We add the given step to all the line and a rest only
			-- if they didn't get one already.
			-- Then, if there is some rest remaining, it means that
			-- all the lines have the same size, then, we initialize
			-- the rest of all lines to zero and we add the remaining
			-- rest to the first lines.
			-- We start at 2 because the first line has different meaning,
			-- It always stays at the border value.
		local
			rest: INTEGER
			last: INTEGER
		do
			-- We do something only if is necessary
			rest := a_rest
			if (step > 0) or (rest > 0) then
				from
					line.go_i_th (2)
					last := 0
				until
					line.after
				loop
					-- If the line is expanded
					if line.item.first > 0 then
						if rest > 0 and (line.item @ 3) = 0 then
							line.item.put_i_th (1, 3)
							last := last + step + 1
							rest := rest - 1
						else
							last := last + step
						end
					end
					line.item.put_i_th ((line.item @ 4) + last, 4)
					line.forth
				end
				-- If there is still some rest, it means that all
				-- the expanded lines have the same size.
				if rest /= 0 then
					check
						valid_rest: rest.abs < line.first.first
					end	
					initialize_rest (line, 0)
					from
						line.go_i_th (2)
						last := 0
					until
						line.after
					loop
						if rest > last and (line.item @ 3) = 0 then
							line.item.put_i_th (1, 3)
							last := last + 1
						end
						line.item.put_i_th ((line.item @ 4) + last, 4)
						line.forth
					end	
				end
			elseif (rest < 0) or (step < 0) then
				from
					line.go_i_th (2)
					last := 0
				until
					line.after
				loop
					-- If the line is expanded
					if line.item.first > 0 then
						if rest < 0 and (line.item @ 3) = 1 then
							line.item.put_i_th (0, 3)
							last := last + step - 1
							rest := rest + 1
						else
							last := last + step
						end
					end
					line.item.put_i_th ((line.item @ 4) + last, 4)
					line.forth
				end
				-- If there is still some rest, it means that all
				-- the expanded lines have the same size.
				if rest /= 0 then
					check
						valid_rest: rest.abs < line.first.first
					end	
					initialize_rest (line, 1)
					from
						line.go_i_th (2)
						last := 0
					until
						line.after
					loop
						if rest < last and (line.item @ 3) = 1 then
							line.item.put_i_th (0, 3)
							last := last - 1
						end
						line.item.put_i_th ((line.item @ 4) + last, 4)
						line.forth
					end
				end
			end
		end

feature {NONE} -- Implementation to resize the table when it comes from the bottom.

	first_body_loop (line: ARRAYED_LIST [FIXED_LIST [INTEGER]]; value, last: INTEGER) is
			-- Loop on the one-cell widget, to check their minimum parameter.
			-- If `value' is bigger than the biggest element of the current line (`last'),
			-- we set this new value for the line. Then, if it is bigger than the homogeneous
			-- value, we set a new homogeneous value.
		do
			if value > (line @ last) @ 2 then
				(line @ last).put_i_th (value, 2)
				if value > line.first @ 2 then
					line.first.put_i_th (value, 2)
				end
			end
		end

	second_body_loop (line: ARRAYED_LIST [FIXED_LIST [INTEGER]]; value, first, last, spacing: INTEGER) is
			-- Loop on the several-cells widget to check their minimum parameter.
			-- We check than the current size is bigger than the actual lenght of the
			-- cells the widget wants to cover. Then, if it is bigger indeed, we
			-- distribute this value to the covered cells.
			-- And we set the atttributes of the line if it is necessary.
		local
			length: INTEGER
			test: INTEGER
			step: INTEGER
			rest: INTEGER
		do
			-- Lets see what is the length of the current cells the
			-- widget covers.
			length := last - first
			from
				line.go_i_th (first + 1)
				test := line.item @ 2
				line.forth
			until
				line.index = last + 1
			loop
				test := test + line.item @ 2 + spacing
				line.forth
			end
			if test < value then 
				-- We need to distribute the extra-space among
				-- the cells.
				step := (value - test) // length
				rest := (value - test) \\ length
				from
					line.go_i_th (first + 1)
				until
					line.index = last + 1
				loop
					if rest > 0 and (line.item @ 3) = 0 then
						line.item.put_i_th (1, 3)
						line.item.put_i_th ((line.item @ 2) + step + 1, 2)
						rest := rest - 1
					else
						line.item.put_i_th ((line.item @ 2) + step, 2)
					end
					if line.item @ 2 > line.first @ 2 then
						line.first.put_i_th (line.item @ 2, 2)
					end
					line.forth
				end
				-- If there is still some rest, we need to distribute
				-- it to the the following lines.
				if rest > 0 then
					from
						if line.index > line.count then
							line.go_i_th (2)
						end
					until
						rest = 0
					loop
						if (line.item @ 3) = 0 then
							line.item.put_i_th (1, 3)
							line.item.put_i_th ((line.item @ 2) + 1, 2)
							rest := rest - 1
							if line.item @ 2 > line.first @ 2 then
								line.first.put_i_th (line.item @ 2, 2)
							end
						end
						-- Are we back at the beginning = All the cells
						-- have the same size?
						if line.index = first then
							initialize_rest (line, 0)
						end
						-- Are we at the end of the list?
						if line.after then
							-- First line has a different meaning
							line.go_i_th (2)
						else
							line.forth
						end
					end
				end
			end
		end

 	child_minheight_changed (min: INTEGER; the_child: EV_WIDGET_IMP) is
 			-- Change the current minimum_height because the child did.
 		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			tchild: EV_TABLE_CHILD_IMP
		do
			if already_displayed then
				list := ev_children
				clear_line (rows_value)
				-- A first loop for the children that take only one cell
				from
					list.start
				until
					list.after
				loop
					tchild := list.item
					if (tchild.bottom_attachment - tchild.top_attachment = 1) then
						first_body_loop (rows_value, tchild.widget.minimum_height, tchild.bottom_attachment)
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
						second_body_loop (rows_value, tchild.widget.minimum_height, tchild.top_attachment,
											tchild.bottom_attachment, row_spacing)
					end
					list.forth
				end	
			end
		end
	
	child_minwidth_changed (min: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the current minimum_width because the child did.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			tchild: EV_TABLE_CHILD_IMP
		do
			if already_displayed then
				list := ev_children
				clear_line (columns_value)
				-- A first loop for the children that take only one cell
				from
					list.start
				until
					list.after
				loop
					tchild := list.item
					if (tchild.right_attachment - tchild.left_attachment = 1) then
						first_body_loop (columns_value, tchild.widget.minimum_width, tchild.right_attachment)	
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
						second_body_loop (columns_value, tchild.widget.minimum_width, tchild.left_attachment,
											tchild.right_attachment, column_spacing)
					end
					list.forth
				end
			end	
		end

	initialize_at_minimum is
			-- Initialize the width and the height of the table at the
			-- minimum. Like for the boxes, after, all the calculus will
			-- be done in comparison to the current size of the widgets.
		local
			last: INTEGER
			cm: ARRAYED_LIST [FIXED_LIST [INTEGER]]
			rw: ARRAYED_LIST [FIXED_LIST [INTEGER]]
			homogeneous_value: INTEGER
			cspace, rspace: INTEGER
		do
			-- We use local variables to gain some speed
			cm := columns_value
			rw := rows_value
			cspace := column_spacing
			rspace := row_spacing

			-- When the table is homogeneous, we don't care about the `expand'
			-- parameter of the rows and columns.
			if is_homogeneous then
				-- We prepare the columns :
				from
					cm.start
					homogeneous_value := cm.first @ 2 + cspace
				until
					cm.after
				loop
					cm.item.put_i_th (homogeneous_value * (cm.index - 1), 4)
					cm.forth
				end
				-- the rows :
				from
					rw.start
					homogeneous_value := rw.first @ 2 + rspace
				until
					rw.after
				loop
					rw.item.put_i_th (homogeneous_value * (rw.index - 1), 4)
					rw.forth
				end
			-- In the non-homogeneous mode, the `expand' attribute has his
			-- importance.
			else
				-- We prepare the columns.
				-- The first column has a particular behavior : take the border value.
				from
					cm.go_i_th (2)
--					last := Value of the border
					last := 0
				until
					cm.after
				loop
					last := last + cm.item @ 2 + cspace 
					cm.item.put_i_th (last, 4)
					cm.forth
				end
				-- We prepare the rows.
				-- The first row has a particular behavior : take the border value.
				from
					rw.go_i_th (2)
--					last := value of the border
					last := 0
				until
					rw.after
				loop
					last := last + rw.item @ 2 + rspace
					rw.item.put_i_th (last, 4)
					rw.forth
				end
			end

			-- We initialize the rest to 0 to be sure the proportion won't change
			initialize_rest (cm, 0)
			initialize_rest (rw, 0)

			-- We resize the window and the children
			set_minimum_width (cm.last.last - column_spacing)
			set_minimum_height (rw.last.last - row_spacing)
			resize (minimum_width, minimum_height)
			adjust_children
		end
	
feature {NONE} -- EiffelVision implementation

   	on_first_display is
		local
			i: INTEGER
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
  		do
			if not ev_children.empty then
				list := ev_children
				from
					i := 1
				until
					i = list.count + 1
				loop
					(list @ i).widget.on_first_display
					i := i + 1
				end
			end
			already_displayed := True
			child_minwidth_changed (0, Void)
			child_minheight_changed (0, Void)
			initialize_at_minimum
			parent_ask_resize (child_cell.width, child_cell.height)
  		end

	update_display is
			-- Feature that update the actual container.
			-- It check the size of the child and resize
			-- the child or the container itself depending
			-- on the case.
		do
			if already_displayed then
				child_minwidth_changed (0, Void)
				child_minheight_changed (0, Void)
				initialize_at_minimum
				parent_ask_resize (child_cell.width, child_cell.height)
			end
		end

invariant

	ev_children_not_void: ev_children /= Void
	columns_exists: columns_value /= Void
	rows_exists: rows_value /= Void

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
