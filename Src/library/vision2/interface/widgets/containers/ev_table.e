--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

	description: 
		"EiffelVision table. Invisible container that allows %
		% unlimited number of other widgets to be packed inside it.%
		% A table controls the children's location and size%
		% automatically."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TABLE

inherit
	EV_INVISIBLE_CONTAINER
		redefine
			implementation
		end

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a table widget with `par' as
			-- parent.
		do
			!EV_TABLE_IMP!implementation.make
			widget_make (par)
		end	

feature -- Status report

	rows: INTEGER is
			-- Number of rows
		require
		do
			Result := implementation.rows
		end

	columns: INTEGER is
			-- Number of columns
		require
		do
			Result := implementation.columns
		end

	row_spacing: INTEGER is
			-- Spacing between two rows
		require
		do
			Result := implementation.row_spacing
		end

	column_spacing: INTEGER is
			-- Spacing between two columns
		require
		do
			Result := implementation.column_spacing
		end

feature -- Status settings

	set_homogeneous (flag: BOOLEAN) is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		require
		do
			implementation.set_homogeneous (flag)
		end
	
	set_row_spacing (value: INTEGER) is
			-- Spacing between two rows of the table
		require
			positive_value: value >= 0
		do
			implementation.set_row_spacing (value)
		end

	set_column_spacing (value: INTEGER) is
			-- Spacing between two columns of the table
		require
			positive_value: value >= 0
		do
			implementation.set_column_spacing (value)
		end

	set_child_position (the_child: EV_WIDGET; top, left, bottom, right: INTEGER) is
			-- Set the position and the size of the given child in
			-- the table. `top', `left', `bottom' and `right' give the
			-- zero-based coordinates of the child in the grid. 
			--
			--     0          1         2
			--   0 +----------+---------+
			--     |          |         |
			--   1 +----------+---------+
			--     |          |         |
			--   2 +----------+---------+
			--
			-- This feature must be called after the create of
			-- the child, otherwise, the child won't appear in
			-- the table.
		require
			the_child_not_void: the_child /= Void
			bottom_larger_than_top: bottom > top
			right_larger_than_left: right > left
		do
			implementation.set_child_position (the_child, top, left, bottom, right)
		end


feature {NONE} -- Implementation
	
	implementation: EV_TABLE_I

end -- class EV_TABLE

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
--| Revision 1.7  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.2  2000/01/27 19:30:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.1  1999/11/24 17:30:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.6.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
