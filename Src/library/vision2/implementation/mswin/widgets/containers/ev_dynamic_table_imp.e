indexing
	description:
		"EiffelVision dynamic table. Mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DYNAMIC_TABLE_IMP

inherit
	EV_DYNAMIC_TABLE_I

	EV_TABLE_IMP
		redefine
			make,
			add_child,
			remove_child,
			child_added,
			set_child_position,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create an empty table.
		do
			{EV_TABLE_IMP} Precursor
			finite_dimension := 1
		end

feature -- Status settings

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

			-- Then, we add the children by creating a table child with
			-- the given information.
			create table_child.make (child_imp, Current)
			ev_children.extend (table_child)

			-- The list start at one, then we change the attachment
			table_child.set_attachment (top, left, bottom, right)

			-- We show the child and resize the container
			notify_change (1 + 2)
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite. Several children
			-- possible.
		local
			wid: EV_WIDGET
		do
			wid ?= child_imp.interface
			set_child_position (wid, row_index, column_index, row_index + 1, column_index + 1)
			if is_row_layout then
				if column_index + 1 >= finite_dimension then
					row_index := row_index + 1
					column_index := 0
				else
					column_index := column_index + 1
				end
			else
				if row_index + 1 >= finite_dimension then
					column_index := column_index + 1
					row_index := 0
				else
					row_index := row_index + 1
				end
			end
		end

	remove_child (child_imp: EV_WIDGET_IMP) is
			-- Remove the given child from the children of
			-- the container.
			-- When we remove a child, we replace the others
		local
			tchild: EV_TABLE_CHILD_IMP
		do
			tchild := find_widget_child (child_imp)
			ev_children.prune_all (tchild)
			notify_change (2 + 1)
		end

feature -- Assertion

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Has `a_child' been added properly?
		do
			Result := find_widget_child (a_child) /= Void
		end

feature {NONE} -- Implementation

	compute_minimum_width is
			-- Recompute the minimum_width of the object.
			-- No need for the second loop.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			minimums: ARRAYED_LIST [INTEGER]
			tchild: EV_TABLE_CHILD_IMP
			right, mw: INTEGER
			cur: CURSOR
		do
			list := ev_children
			columns_minimum.make_filled (columns)

			-- A first loop for the children that takes only one cell
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
			list.go_to (cur)
			internal_set_minimum_width (columns_sum)
		end

	compute_minimum_height is
			-- Recompute the minimum_width of the object.
			-- No need for the second loop.
		local
			list: ARRAYED_LIST [EV_TABLE_CHILD_IMP]
			minimums: ARRAYED_LIST [INTEGER]
			tchild: EV_TABLE_CHILD_IMP
			bottom, mh: INTEGER
			cur: CURSOR
		do
			list := ev_children
			rows_minimum.make_filled (rows)

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
			list.go_to (cur)
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
			list.go_to (cur)
			sum_rows_minimums
			sum_columns_minimums
			internal_set_minimum_size (columns_sum, rows_sum)
		end

end -- class EV_DYNAMIC_TABLE_IMP

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
 

