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

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.10  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.9  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.4.1  2000/05/03 19:09:05  oconnor
--| mergred from HEAD
--|
--| Revision 1.8  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.2  2000/01/27 19:30:01  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.1  1999/11/24 17:30:10  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/04 23:10:41  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.6.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
