indexing
	description:
		"EiffelVision table child. Used only on windows implementation. This%
		% object is a link between a table and one of its child.%
		% Each child of a table is store in a table_child."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TABLE_CHILD_IMP

create
	make

feature -- Initialization

	make (a_widget: EV_WIDGET_IMP; parent: EV_TABLE_IMP) is
			-- Create `Current' with `a_widget' and parent as `parent'.
		require
			valid_child: a_widget /= Void
			valid_parent: parent /= Void
		do
			widget := a_widget
			table := parent
 		end

feature -- Access

	table: EV_TABLE_IMP
			-- The table to which `Current' is linked.

	widget: EV_WIDGET_IMP
			-- The widget_contained.

	top_attachment: INTEGER
			-- The top attatchment of `widget' in the 1 based table
			-- coordinates.

	left_attachment: INTEGER
			-- The left attatchment of `widget' in the 1 based table
			-- coordinates.

	bottom_attachment: INTEGER
			-- The bottom attatchment of `widget' in the 1 based table
			-- coordinates.

	right_attachment: INTEGER
			-- The right attatchment of `widget' in the 1 based table
			-- coordinates.
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TABLE_CHILD_IMP

