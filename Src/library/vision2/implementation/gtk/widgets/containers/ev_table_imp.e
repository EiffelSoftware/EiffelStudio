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

creation
	make

feature {NONE} -- Implementation

	make is
                        -- Create a table widget with `par' as
                        -- parent.
		do
			widget := gtk_table_new (0, 0, Default_homogeneous)
				-- table created with 0 row and 0 column.
			gtk_object_ref (widget)
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
			gtk_table_attach_defaults (GTK_TABLE(widget), child_imp.widget,
						left, right, top, bottom)

			-- we have to decrement the number of reference which is here 2
			-- (the value had been incremented by the gtk function
			-- 'gtk_table_attach_defaults').
			gtk_object_unref (child_imp.widget)	

			-- we set the spacings if needed. This function has been create
			-- because of a GTK bug: when adding a new child in the table,
			-- the spacings are not set for it. As soon as the bug is fixed, we
			-- can erase this function.
			c_gtk_table_set_spacing_if_needed (GTK_TABLE (widget))		
		end

feature -- Element change

	add_child (child_imp: EV_WIDGET_IMP) is
			-- Add child into composite. Several children
			-- possible.
		do
			-- there is nothing to do here except add a reference
			-- to the child otherwise, the later will be destroyed
			-- after the gtk_object_unref in the set_parent.
			gtk_object_ref (child_imp.widget)
		end

feature -- Assertion test

	child_added (a_child: EV_WIDGET_IMP): BOOLEAN is
			-- Has `a_child' been added properly?
		do
			Result := True
		end

end -- class EV_TABLE_IMP

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
