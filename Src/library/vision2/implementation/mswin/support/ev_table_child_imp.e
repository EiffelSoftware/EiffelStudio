indexing
	description:
		"EiffelVision table child. Used only for windows. This%
		% object is a link between a table and one of its child.%
		% Each child of a table is store in a table_child."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TABLE_CHILD_IMP

creation
	make

feature -- Initialization

	make (a_widget: EV_WIDGET_IMP; parent: EV_TABLE_IMP) is
			-- Create a table child according to a widget and its
			-- attachments in the table
		require
			valid_child: a_widget /= Void
			valid_parent: parent /= Void
		do
			widget := a_widget
			table := parent
 		end

feature -- Access

	table: EV_TABLE_IMP
			-- The table

	widget: EV_WIDGET_IMP
			-- The child of the table

	top_attachment: INTEGER
			-- The top line of the table to which the child is
			-- attach.

	left_attachment: INTEGER
			-- The left line of the table to which the child is
			-- attach.

	bottom_attachment: INTEGER
			-- The bottom line of the table to which the child is
			-- attach.

	right_attachment: INTEGER
			-- The right line of the table to which the child is
			-- attach.

feature -- Element change

	set_attachment (top, left, bottom, right: INTEGER) is
				-- Make `top', `left', `bottom' and `right' the new attachments
				-- of `widget'. 
		require
			good_vertical_dimension: bottom >= top
			good_horizontal_dimension: right >= left
		do
			top_attachment := top
			left_attachment := left
			bottom_attachment := bottom
			right_attachment := right 
		ensure
			dimension_set: top_attachment = top and left_attachment = left
							and bottom_attachment = bottom and right_attachment = right
		end

invariant
	valid_parent: table /= Void
	parent_exists: not table.destroyed
	valid_widget: widget /= Void
	widget_exists: not widget.destroyed
	good_horizontal_order: left_attachment <= right_attachment
	good_vertical_order: top_attachment <= bottom_attachment

end -- class EV_TABLE_CHILD_IMP

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
