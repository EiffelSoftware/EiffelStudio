--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

	description: 
		"Eiffel Vision table. Implementation interface";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TABLE_I

inherit
	EV_INVISIBLE_CONTAINER_I

feature -- Access

	Default_homogeneous: BOOLEAN is True
	Default_row_spacing: INTEGER is 0
	Default_column_spacing: INTEGER is 0

feature -- Status report

	rows: INTEGER is
			-- Number of rows
		require
		deferred
		end

	columns: INTEGER is
			-- Number of columns
		require
		deferred
		end

	row_spacing: INTEGER is
			-- Spacing between two rows
		require
		deferred
		end
	
	column_spacing: INTEGER is
			-- Spacing between two columns
		require
		deferred
		end

feature -- Status settings

	set_homogeneous (flag: BOOLEAN) is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		require
		deferred
		end
	
	set_row_spacing (value: INTEGER) is
			-- Spacing between two rows of the table
		require
			positive_value: value >= 0
		deferred
		end

	set_column_spacing (value: INTEGER) is
			-- Spacing between two columns of the table
		require
			positive_value: value >= 0
		deferred
		end

	set_child_position (the_child: EV_WIDGET; top, left, bottom, right: INTEGER) is
			-- Set the position and the size of the given child in
			-- the table. `top', `left', `bottom' and `right' give the
			-- one-based numbers of the cells covered by the child 
			-- This feature must be called after the create of
			-- the child, otherwise, the child won't appear in
			-- the table.
		require
			the_child_not_void: the_child /= Void
			good_child: the_child.parent = interface
			bottom_larger_than_top: bottom > top
			right_larger_than_left: right > left
		deferred
		end

end -- class EV_TABLE_I

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.2  2000/01/27 19:30:02  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.1  1999/11/24 17:30:10  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/04 23:10:42  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.3.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
