indexing

	description:
		"EiffelVision table, gtk implementation";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TABLE_IMP

inherit
	EV_TABLE_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			container_widget
		end
create
	make

feature {NONE} -- Implementation

	make (an_interface: like interface) is
                        -- Create a table widget with `par' as
                        -- parent.
		do
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)
			container_widget := C.gtk_table_new (0, 0, Default_homogeneous)
				-- table created with 0 row and 0 column.
			C.gtk_widget_show (container_widget)
			C.gtk_container_add (c_object, container_widget)
		end

	container_widget: POINTER
			-- Pointer to the gtktable widget as c_object is event box.

feature -- Status report

	widget_count: INTEGER is
		local
			a_child_list: POINTER
		do
			a_child_list := C.gtk_container_children (container_widget)
			Result := C.g_list_length (a_child_list)
			C.g_list_free (a_child_list)
		end

	row_spacing: INTEGER is
		do
			Result := c_gtk_table_row_spacing (container_widget)
		end

	column_spacing: INTEGER is
		do
			Result := c_gtk_table_column_spacing (container_widget)
		end

	border_width: INTEGER is
			-- Width of border around container in pixels.
		do
			Result := C.gtk_container_struct_border_width (
					C.gtk_box_struct_container (container_widget)
				)
		end

	resize (a_column, a_row: INTEGER) is
		do
			C.gtk_table_resize (container_widget, a_row, a_column)
		end

feature -- Status settings

	enable_homogeneous is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			C.gtk_table_set_homogeneous (container_widget, True)
		end

	disable_homogeneous is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			C.gtk_table_set_homogeneous (container_widget, False)
		end

	set_border_width (a_value: INTEGER) is
			-- Set the tables border width to `a_value' pixels.
		do
			C.gtk_container_set_border_width (container_widget, a_value)
		end

	set_row_spacing (a_value: INTEGER) is
			-- Spacing between two rows of the table.
		do
			C.gtk_table_set_row_spacings (container_widget, a_value)
		end

	set_column_spacing (a_value: INTEGER) is
			-- Spacing between two columns of the table.
		do
			C.gtk_table_set_col_spacings (container_widget, a_value)
		end

	put (v: EV_WIDGET; a_x, a_y, column_span, row_span: INTEGER) is
			-- Set the position of the `v' in the table.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= v.implementation
			C.gtk_table_attach_defaults (
					container_widget,
					item_imp.c_object,
					a_x - 1,
					a_x - 1 + column_span,
					a_y - 1,
					a_y - 1 + row_span
			)
		end

	remove (v: EV_WIDGET) is
			-- Remove `v' from the table if present.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= v.implementation
			C.gtk_object_ref (item_imp.c_object)
			C.gtk_container_remove (container_widget, item_imp.c_object)
			C.gtk_object_unref (item_imp.c_object)
		end

feature {NONE} -- Externals

	c_gtk_table_rows (a_table_struct: POINTER): INTEGER is
			-- Number of rows.
		external
			"C [struct <gtk/gtk.h>] (GtkTable): EIF_INTEGER"
		alias
			"nrows"
		end

	c_gtk_table_columns (a_table_struct: POINTER): INTEGER is
			-- Number of columns.
		external
			"C [struct <gtk/gtk.h>] (GtkTable): EIF_INTEGER"
		alias
			"ncols"
		end

	c_gtk_table_row_spacing (a_table_struct: POINTER): INTEGER is
			-- Spacing between two rows.
		external
			"C [struct <gtk/gtk.h>] (GtkTable): EIF_INTEGER"
		alias
			"row_spacing"
		end
	
	c_gtk_table_column_spacing (a_table_struct: POINTER): INTEGER is
			-- Spacing between two columns.
		external
			"C [struct <gtk/gtk.h>] (GtkTable): EIF_INTEGER"
		alias
			"column_spacing"
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TABLE


end -- class EV_TABLE_IMP

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

