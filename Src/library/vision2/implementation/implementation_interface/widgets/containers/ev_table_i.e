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
			exists: not destroyed
		deferred
		end

	columns: INTEGER is
			-- Number of columns
		require
			exists: not destroyed
		deferred
		end

feature -- Status settings

	set_homogeneous (flag: BOOLEAN) is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		require
			exist: not destroyed
		deferred
		end
	
	set_row_spacing (value: INTEGER) is
			-- Spacing between two rows of the table
		require
			exist: not destroyed
			positive_value: value >= 0
		deferred
		end

	set_column_spacing (value: INTEGER) is
			-- Spacing between two columns of the table
		require
			exist: not destroyed
			positive_value: value >= 0
		deferred
		end

	set_child_position (the_child: EV_WIDGET; top, left, bottom, right: INTEGER) is
			-- Set the position and the size of the given child in
			-- the table. `top', `left', `bottom' and `right' give the
			-- one-based numbers of the cells covered by the child 
			-- This feature must be called after the creation of
			-- the child, otherwise, the child won't appear in
			-- the table.
		require
			exists: not destroyed
			the_child_not_void: the_child /= Void
			good_child: the_child.parent = interface
			bottom_larger_than_top: bottom > top
			right_larger_than_left: right > left
		deferred
		end

end -- class EV_TABLE_I

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
