--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

	description:
		"EiffelVision table, gtk implementation";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TABLE_IMP

inherit
	EV_TABLE_I

	EV_INVISIBLE_CONTAINER_IMP
		redefine
			add_child,
			child_added
		end

create
	make

feature {NONE} -- Implementation

	make is
                        -- Create a table widget with `par' as
                        -- parent.
		do
			widget := gtk_table_new (0, 0, Default_homogeneous)
				-- table created with 0 row and 0 column.
		end

feature -- Status report

	rows: INTEGER is
			-- Number of rows
		do
			Result := c_gtk_table_rows (widget)
		end

	columns: INTEGER is
			-- Number of columns
		do
			Result := c_gtk_table_columns (widget)
		end

	row_spacing: INTEGER is
			-- Spacing between two rows
		do
			Result := c_gtk_table_row_spacing (widget)
		end
	
	column_spacing: INTEGER is
			-- Spacing between two columns
		do
			Result := c_gtk_table_column_spacing (widget)
		end

feature -- Status settings

	set_homogeneous (flag: BOOLEAN) is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			gtk_table_set_homogeneous (GTK_TABLE (widget), flag)
		end
	
	set_row_spacing (value: INTEGER) is
			-- Spacing between two rows of the table
		do
			gtk_table_set_row_spacings (GTK_TABLE (widget), value)
		end

	set_column_spacing (value: INTEGER) is
			-- Spacing between two columns of the table
		do
			gtk_table_set_col_spacings (GTK_TABLE (widget), value)
		end

	set_child_position (the_child: EV_WIDGET; top, left, bottom, right: INTEGER) is
			-- Set the position and the size of the given child in
			-- the table. `top', `left', `bottom' and `right' give the
			-- zero-based coordinates of the child in the
			-- grid. 
		local
			child_imp: EV_WIDGET_IMP
		do
			child_imp ?= the_child.implementation
			gtk_table_attach_defaults (GTK_TABLE(widget), child_imp.vbox_widget,
						left, right, top, bottom)

			-- we set the spacings if needed. This function has been create
			-- because of a GTK bug: when adding a new child in the table,
			-- the spacings are not set for it. As soon as the bug is fixed, we
			-- can erase this function.
			c_gtk_table_set_spacing_if_needed (GTK_TABLE (widget))		

			-- Sets the resizing options.
			child_packing_changed (child_imp) 
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite. Several children
			-- possible.
		do
			-- Create `vbox_widget' and `hbox_widget'.
			add_child_packing (child_imp)

			-- As the child is put into the table only
			-- with feature `set_child_position', there
			-- is nothing to do here.
		end

feature -- Assertion test

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Has `a_child' been added properly?
		do
			Result := True
		end

end -- class EV_TABLE_IMP

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
--| Revision 1.10  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.9.6.2  2000/01/27 19:29:43  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.9.6.1  1999/11/24 17:29:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.9.2.3  1999/11/17 01:53:04  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.9.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
