indexing
	description:
		"EiffelVision dynamic table. Implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DYNAMIC_TABLE_I

inherit
	EV_TABLE_I

feature -- Status report

	is_row_layout: BOOLEAN
			-- Are children laid out in rows?

feature -- Status setting

	set_finite_dimension (a_number: INTEGER) is
			-- Set number of columns if row
			-- layout, or number of row if column
			-- layout.
		require
			exists: not destroyed
			positive_number: a_number > 0
		do
			finite_dimension := a_number
		end

	set_row_layout (flag: BOOLEAN) is
			-- Lay the children out in rows if True,
			-- in colum otherwise.
		require
			exists: not destroyed
		do
			is_row_layout := flag
			set_finite_dimension (finite_dimension.max (1))
		ensure
			layout_set: is_row_layout = flag
		end

feature {EV_DYNAMIC_TABLE} -- Implementation

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite. Several children
			-- possible.
		do
			child := child_imp
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

	row_index:  INTEGER
		-- zero-based coordinate of the cell that will receive the next
		-- child

	column_index: INTEGER
		-- zero-based coordinate of the cell that will receive the next
		-- child

	finite_dimension: INTEGER
		-- The number of columns if is_row_layout,
		-- the number of rows if not is_row_layout.
		-- 1 by default, can be set by the user.

end -- class EV_DYNAMIC_TABLE_I

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
