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
			set_child_position,
			child_minwidth_changed,
			child_minheight_changed
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
			expand_line (columns_value, right, True)
			expand_line (rows_value, bottom, True)

			-- Then, we add the children by creating a table child with
			-- the given information.
			!! table_child.make (child_imp, Current)
			ev_children.extend (table_child)
			-- The list start at one, then we change the attachment
			table_child.set_attachment (top + 1, left + 1, bottom + 1, right + 1)

			-- If it was already_displayed, we need to propagate the change
			if already_displayed then
				child_minwidth_changed (child_imp.minimum_width, child_imp)
				child_minheight_changed (child_imp.minimum_height, child_imp)
			end
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite. Several children
			-- possible.
		do
			set_child_position (child_imp.interface, row_index, column_index, row_index + 1, column_index + 1)
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

feature {NONE} -- Implementation

	child_minheight_changed (min: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the current minimum_height because the child did.
			-- The second loop is not necessary.
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
			end
		end
	
	child_minwidth_changed (min: INTEGER; the_child: EV_WIDGET_IMP) is
			-- Change the current minimum_width because the child did.
			-- The second loop is not necessary.
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
			end	
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
 

