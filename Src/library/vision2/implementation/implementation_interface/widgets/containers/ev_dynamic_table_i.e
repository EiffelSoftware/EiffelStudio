--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
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

	finite_dimension: INTEGER
		-- The number of columns if is_row_layout,
		-- the number of rows if not is_row_layout.
		-- 1 by default, can be set by the user.
	
feature -- Status setting

	set_finite_dimension (a_number: INTEGER) is
			-- Set number of columns if row
			-- layout, or number of row if column
			-- layout.
		require
			positive_number: a_number > 0
		do
			finite_dimension := a_number
		end

	set_row_layout (flag: BOOLEAN) is
			-- Lay the children out in rows if True,
			-- in colum otherwise.
		require
		do
			is_row_layout := flag
			set_finite_dimension (finite_dimension.max (1))
		ensure
			layout_set: is_row_layout = flag
		end

feature {NONE} -- Implementation

	row_index:  INTEGER
		-- zero-based coordinate of the cell that will receive the next
		-- child

	column_index: INTEGER
		-- zero-based coordinate of the cell that will receive the next
		-- child

	
end -- class EV_DYNAMIC_TABLE_I

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

