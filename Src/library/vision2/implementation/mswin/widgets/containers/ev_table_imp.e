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
		undefine
			add_child_ok
		redefine
			add_child,
			set_insensitive,
			parent_ask_resize,
			set_width,
			set_height,
			child_minwidth_changed,
			child_minheight_changed,
			on_first_display
		end

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			destroy as wel_destroy
		undefine
			set_width,
			set_height,
			remove_command,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_char,
			on_key_up,
			on_draw_item
		redefine
			default_style,
			background_brush
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a table widget with `par' as
			-- parent.
		local
			par_imp: WEL_WINDOW
			fix: FIXED_LIST [INTEGER]
		do
			par_imp ?= par.implementation
			check
				valid_parent: par_imp /= Void
			end
			make_with_coordinates (par_imp, "Table", 0, 0, 0, 0)
			-- We create the implementation variables.
			!! ev_children.make (1)
			!! columns_value.make (1)
			!! fix.make_filled (4)
			columns_value.extend (fix)
			!! rows_value.make (0)
			!! fix.make_filled (4)
			rows_value.extend (fix)
			-- We initialise the default state of the table
			set_homogeneous (Default_homogeneous)
			set_row_spacing (Default_row_spacing)
			set_column_spacing (Default_column_spacing)
		end	

feature -- Access

	row_spacing: INTEGER is
			-- Spacing between two rows
		do
			Result := rows_value.first.first
		end

	column_spacing: INTEGER is
			-- spacing between two columns
		do
			Result := columns_value.first.first
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
		do
			if not ev_children.empty then
				from
					ev_children.start
				until
					ev_children.after
				loop
					ev_children.item.widget.set_insensitive (flag)
					ev_children.forth
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
			rows_value.first.put_i_th (value, 1)
			if not ev_children.empty then
				initialize_at_minimum
			end			
		end

	set_column_spacing (value: INTEGER) is
			-- Make `value' the new `column_spacing'.
		do
			columns_value.first.put_i_th (value, 1)
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
			fix: FIXED_LIST [INTEGER]
			index: INTEGER
		do
			-- First, we change the number of cells of the table if it is too small.
			if right >= columns_value.count then
				from
					index := columns_value.count
				until
					index = right + 1
				loop
					!! fix.make_filled (4)
					if the_child.expandable then
						fix.put_i_th (1, 1)
					else
						fix.put_i_th (0, 1)
					end
					columns_value.extend (fix)
					index := index + 1
				end
			end
			if bottom >= rows_value.count then
				from
					index := rows_value.count
				until
					index = bottom + 1
				loop
					!! fix.make_filled (4)
					if the_child.expandable then
						fix.put_i_th (1, 1)
					else
						fix.put_i_th (0, 1)
					end
					rows_value.extend (fix)
					index := index + 1
				end
			end

			-- Then, we check if the children has already been placed in the table,
			-- if not, we create a table child with the given information.
			child_imp ?= the_child.implementation
			check
				valid_child: child_imp /= Void
			end
			table_child := find_widget_child (child_imp)
			if table_child = Void then
				!! table_child.make (child_imp, Current)
				ev_children.extend (table_child)
			end
			-- The list start at one, then we change the attachment
			table_child.set_attachment (top + 1, left + 1, bottom + 1, right + 1)

			-- We show the child and resize the container
			child_imp.show
			child_minwidth_changed (child_imp.minimum_width, child_imp)
			child_minheight_changed (child_imp.minimum_height, child_imp)
			initialize_at_minimum
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
				-- Add a child to the table. the child doesn't appear, it has to be
				-- placed after in the table to be shown.
		do
			child := child_imp
			child.hide
		end

feature -- Measurement

	set_width (value:INTEGER) is
			-- Make `value' the new width and notify the parent
			-- of the change.
		do
			child_cell.set_width (value.max (minimum_width))
			set_local_size (child_cell.width, child_cell.height)
		end
		
	set_height (value: INTEGER) is
			-- Make `value' the new `height' and notify the
			-- parent of the change.
		do
			child_cell.set_height (value.max (minimum_height))
			set_local_size (child_cell.width, child_cell.height)
		end

feature {NONE} -- Implementation attributes

	already_displayed: BOOLEAN
			-- Did the container was displayed already?

	ev_children: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			-- List of the children of the tab

	columns_value: ARRAYED_LIST [FIXED_LIST [INTEGER]]
			-- Information about the columns from the left to the right
			-- The fixed list keep the three following informations :
			-- 1 -> Is the column expanded (0 or 1)?.
			--		In the first field of the 0 index, there is the column_spacing 
			--		value stored.	
			-- 2 -> What is the size of the biggest element in the column number index?
			--      In the second field of the 0 index, there is the homogeneous value
			--      of the columns.
			-- 3 -> Did the current column receive any rest already (0 or 1)?
			-- 4 -> What is the current width of the column?

	rows_value: ARRAYED_LIST [FIXED_LIST[INTEGER]]
			-- Information about the rows from the top to the bottom.
			-- The fixed list keep the three following informations :
			-- 1 -> Is the row expanded (0 or 1)?
			--		In the first field of the 0 index, there is the row_spacing
			--		value stored.
			-- 2 -> What is the size of the biggest element in the row number index?
			--      In the second field of the 0 index, there is the homogeneous value
			--      of the rows.
			-- 3 -> Did the current row received any rest already (0 or 1)?
			-- 4 -> What is the current height of the row?

feature {NONE} -- Basic operation

	find_widget_child (a_child: EV_WIDGET_IMP): EV_TABLE_CHILD_IMP is
				-- Find the table child corresponding to a given widget
				-- child.
		require
			valid_child: a_child /= Void
			current_child: a_child.parent_imp = Current
		local
			clist: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
		do
			clist := ev_children
			if not clist.empty then
				from
					clist.start
				until
					clist.after or Result /= Void
				loop
					if clist.item.widget = a_child then
						Result := clist.item
					end
					clist.forth
				end
			else
				Result := Void
			end
		end

	clear_line (line: ARRAYED_LIST [FIXED_LIST [INTEGER]]) is
			-- Clear the 2nd, 3rd and 4th element of all the items of
			-- the line to refill them after with new values.
		local
			fix: FIXED_LIST [INTEGER]
		do
			from
				line.start
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
		local
			index: INTEGER
		do
			from
				index := 1
			until
				index = line.count
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

feature {NONE} -- Implementation to resize the table when it comes from the parent

	parent_ask_resize (new_width, new_height: INTEGER) is
			-- When the parent asks the resize, it's not 
			-- necessary to send him back the information
		local
			cc: EV_CHILD_CELL_IMP
		do
 			cc := child_cell
 			cc.resize (minimum_width.max(new_width), minimum_height.max (new_height))
 			if resize_type = 3 then
 				set_local_size (cc.width, cc.height)
 				move (cc.x, cc.y)
 			elseif resize_type = 2 then
 				move ((cc.width - width)//2 + cc.x, cc.y)
 				set_local_size (minimum_width, cc.height)
 			elseif resize_type = 1 then
 				move (cc.x, (cc.height - height)//2 + cc.y)
 				set_local_size (cc.width, minimum_height)
 			else
 				move ((cc.width - width)//2 + cc.x, (cc.height - height)//2 + cc.y)
 				set_local_size (minimum_width, minimum_height)
 			end
		end

	set_local_size (new_width, new_height: INTEGER) is
			-- Make `new_width' and `new_height' the new size of the table.
		local
			temp_value: INTEGER
		do
			-- For the width first.
			if new_width /= width then
				temp_value := new_width - width
				size_loop_body (columns_value, temp_value // columns, temp_value \\ columns)
			end
			-- Then, the height :
			if new_height /= height then
				temp_value := new_height - height
				size_loop_body (rows_value, temp_value // rows, temp_value \\ rows)
			end
			-- We resize the children
			resize (columns_value.last.last, rows_value.last.last)
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
			if (step /= 0) or (a_rest /= 0) then
				rest := a_rest
				from
					line.go_i_th (2)
					last := 0
				until
					line.after or (step = 0 and then rest = 0)
				loop
					if rest > 0 and (line.item @ 3) = 0 then
						line.item.put_i_th (1, 3)
						last := last + step + 1
						rest := rest - 1
					elseif rest < 0 and (line.item @ 3) = 1 then
						line.item.put_i_th (0, 3)
						last := last + step - 1
						rest := rest + 1
					else
						last := last + step
					end
					line.item.put_i_th ((line.item @ 4) + last, 4)
					line.forth
				end
				-- If there is still some rest, it means that all
				-- the lines have the same size.
				if rest /= 0 then
					check
						valid_rest: rest < line.count
					end	
					if rest > 0 then
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
					elseif rest < 0 then
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
		end

feature {NONE} -- Implementation to resize the table when it comes from the bottom.

	first_body_loop (line: ARRAYED_LIST [FIXED_LIST [INTEGER]]; value, last: INTEGER) is
			-- Loop on the one-cell widget, to check there minimum parameter.
		do
			if value > (line @ last) @ 2 then
				(line @ last).put_i_th (value, 2)
				(line @ last).put_i_th (0, 3)
				if value > line.first @ 2 then
					line.first.put_i_th (value, 2)
				end
			end
		end

	second_body_loop (line: ARRAYED_LIST [FIXED_LIST [INTEGER]]; value, first, last, spacing: INTEGER) is
			-- Loop on the several-cells widget to check their minimum parameter.
		local
			length: INTEGER
			test: INTEGER
			step: INTEGER
			rest: INTEGER
		do
			length := last - first
			if length > 1 then
				-- Lets see what is the length of the current cells the
				-- widget covers.
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
						if rest > 0 and (line.item @ 3) = 0 then
							line.item.put_i_th (1, 3)
							line.item.put_i_th ((line.item @ 2) + spacing + step + 1, 2)
							rest := rest - 1
						else
							line.item.put_i_th ((line.item @ 2) + spacing + step, 2)
						end
						if line.item @ 2 > line.first @ 2 then
							line.first.put_i_th (line.item @ 2, 2)
						end
						line.forth
					until
						line.index = last
					loop
						if rest > 0 and (line.item @ 3) = 0 then
							line.item.put_i_th (1, 3)
							line.item.put_i_th ((line.item @ 2) + spacing + step + 1, 2)
							rest := rest - 1
						else
							line.item.put_i_th ((line.item @ 2) + spacing + step, 2)
						end
						if line.item @ 2 > line.first @ 2 then
							line.first.put_i_th (line.item @ 2, 2)
						end
						line.forth
					end
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
					-- If there is still some rest, we need to distribute
					-- it to the the following lines.
					if rest > 0 then
						from
							line.forth
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
					second_body_loop (rows_value, tchild.widget.minimum_height, tchild.top_attachment,
											tchild.bottom_attachment, row_spacing)
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
					second_body_loop (columns_value, tchild.widget.minimum_width, tchild.left_attachment,
											tchild.right_attachment, column_spacing)		
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
		do
			-- We use local variables to gain some speed
			cm := columns_value
			rw := rows_value

			-- When the table is homogeneous, we don't care about the `expand'
			-- parameter of the rows and columns.
			if is_homogeneous then
				-- We prepare the columns :
				from
					cm.start
				until
					cm.after
				loop
					cm.item.put_i_th ((cm.first @ 2 + column_spacing) * (cm.index - 1), 4)
					cm.forth
				end
				-- the rows :
				from
					rw.start
				until
					rw.after
				loop
					rw.item.put_i_th ((rw.first @ 2 + row_spacing) * (rw.index - 1), 4)
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
					-- Be carefull, in some cases, the spacing is already counted.
					if cm.item @ 3 <= 1 then
						last := last + cm.item @ 2 + column_spacing 
					else
						last := last + cm.item @ 2
					end
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
					-- Be carefull, in some cases, the spacing is already counted.
					if rw.item @ 3 <= 1 then
						last := last + rw.item @ 2 + row_spacing
					else
						last := last + rw.item @ 2
					end
					rw.item.put_i_th (last, 4)
					rw.forth
				end
			end
			-- We resize the window and the children
			set_minimum_width (cm.last.last - column_spacing)
			set_minimum_height (rw.last.last - row_spacing)
			resize (minimum_width, minimum_height)
			adjust_children
		end
	
feature {NONE} -- EiffelVision implementation

   	on_first_display is
   			-- (from EV_CONTAINER_IMP)
   			-- (export status {EV_WIDGET_IMP})
   		do
			already_displayed := True
			child_minwidth_changed (0, child)
			child_minheight_changed (0, child)
			initialize_at_minimum
   		end

feature {NONE} -- Implementation of WEL functions

	default_style: INTEGER is
		once
			Result := Ws_child + Ws_visible + Ws_clipchildren 
						+ Ws_clipsiblings
		end

	background_brush: WEL_BRUSH is
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
			-- By default there is no background
		do
			if background_color /= Void then
				!! Result.make_solid (background_color)
				disable_default_processing
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
