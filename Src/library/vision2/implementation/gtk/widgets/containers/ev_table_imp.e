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
			add_child
		end

creation
	make

feature {NONE} -- Implementation

	make (par: EV_CONTAINER) is
                        -- Create a table widget with `par' as
                        -- parent.
		do
			widget := gtk_table_new (0, 0, Default_homogeneous)
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
			gtk_table_set_homogeneous (widget, flag)
		end
	
	set_row_spacing (value: INTEGER) is
			-- Spacing between two rows of the table
		do
			gtk_table_set_row_spacings (widget, value)
		end

	set_column_spacing (value: INTEGER) is
			-- Spacing between two columns of the table
		do
			gtk_table_set_col_spacings (widget, value)
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
		end

feature {EV_TABLE} -- Implementation

	add_child (child_imp: EV_WIDGET_I) is
			-- Add child into composite. Several children
			-- possible.
		do
			child ?= child_imp
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
