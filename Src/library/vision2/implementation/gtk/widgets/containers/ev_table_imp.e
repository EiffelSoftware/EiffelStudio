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
			interface,
			set_item_position,
			set_item_span,
			remove,
			put,
			resize
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
			container_widget := C.gtk_table_new (Default_row_spacing, Default_column_spacing, Default_homogeneous)
				-- table created with 0 row and 0 column.
			C.gtk_widget_show (container_widget)
			C.gtk_container_add (c_object, container_widget)
			
			-- Initialize internal values
			rows := 1
			columns := 1
			create internal_array.make (1, 1)
			rebuild_internal_item_list
		end

	container_widget: POINTER
			-- Pointer to the gtktable widget as c_object is event box.

feature -- Status report

	is_homogeneous: BOOLEAN
			-- Does Table have homogeneous spacing, no by default.

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
			Precursor {EV_TABLE_I} (a_column, a_row)
			C.gtk_table_resize (container_widget, a_row, a_column)
		end

feature -- Status settings

	enable_homogeneous is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			C.gtk_table_set_homogeneous (container_widget, True)
			is_homogeneous := True
		end

	disable_homogeneous is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			C.gtk_table_set_homogeneous (container_widget, False)
			is_homogeneous := False
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

	put (v: EV_WIDGET; a_column, a_row, column_span, row_span: INTEGER) is
			-- Set the position of the `v' in the table.
		local
			item_imp: EV_WIDGET_IMP
		do
			Precursor {EV_TABLE_I} (v, a_column, a_row, column_span, row_span)
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Current)
			C.gtk_table_attach_defaults (
					container_widget,
					item_imp.c_object,
					a_column - 1,
					a_column - 1 + column_span,
					a_row - 1,
					a_row - 1 + row_span
			)
		end

	remove (v: EV_WIDGET) is
			-- Remove `v' from the table if present.
		local
			item_imp: EV_WIDGET_IMP
		do
			Precursor {EV_TABLE_I} (v)
			item_imp ?= v.implementation
			item_imp.set_parent_imp (Void)
			C.gtk_object_ref (item_imp.c_object)
			C.gtk_container_remove (container_widget, item_imp.c_object)
		end
		
	set_item_span (v: EV_WIDGET; column_span, row_span: INTEGER) is
			-- Resize 'v' to occupy column span and row span
		local
			a_column, a_row: INTEGER
		do
			Precursor {EV_TABLE_I} (v, column_span, row_span)
			a_column := item_column_position (v)
			a_row := item_row_position (v)
			remove (v)
			put (v, a_column, a_row, column_span, row_span)
		end
		
	set_item_position (v: EV_WIDGET; a_column, a_row: INTEGER) is
			-- Move `v' to position `a_column', `a_row'.
		local
			column_span, row_span: INTEGER
		do
			Precursor {EV_TABLE_I} (v, a_column, a_row)
			column_span := item_column_span (v)
			row_span := item_row_span (v)
			remove (v)
			put (v, a_column, a_row, column_span, row_span)
		end
		
	item_column_span (widget: EV_WIDGET): INTEGER is
			-- `Result' is number of columns taken by `widget'.
		local
			row_index, column_index: INTEGER
			end_span: BOOLEAN
		do	
			from
				row_index := item_row_position (widget)
				column_index := item_column_position (widget)
			until
				end_span or (column_index - 1) = interface.columns
			loop
				if item_at_position (column_index, row_index) = widget then
					Result := Result + 1
				else
					end_span := True
				end
				column_index := column_index + 1
			end
		end
	
	item_row_span (widget: EV_WIDGET): INTEGER is
			--  `Result' is number of rows taken by `widget'.
		local
			row_index, column_index: INTEGER
			end_span: BOOLEAN
		do	
			from
				row_index := item_row_position (widget)
				column_index := item_column_position (widget)
			until
				end_span or else (row_index - 1) = interface.rows
			loop
				if item_at_position (column_index, row_index) = widget then
					Result := Result + 1
				else
					end_span := True
				end
				row_index := row_index + 1
			end
		end
		
	item_row_position (widget: EV_WIDGET): INTEGER is
			-- Result is row coordinate of 'widget'
		local
			row_cnt, column_cnt: INTEGER
			found: BOOLEAN
		do	
			from
				row_cnt := 1
			until
				row_cnt > interface.rows or found
			loop
				from
					column_cnt := 1
				until
					column_cnt > interface.columns or found					
				loop
					if item_at_position (column_cnt, row_cnt) = widget then
						Result := row_cnt
						found := True
					end
					column_cnt := column_cnt + 1
				end
				row_cnt := row_cnt + 1	
			end
		end
		
	item_column_position (widget: EV_WIDGET): INTEGER is
			-- Result is column coordinate of 'widget'
		local
			row_cnt, column_cnt: INTEGER
			found: BOOLEAN
		do	
			from
				row_cnt := 1
			until
				row_cnt > interface.rows or found
			loop
				from
					column_cnt := 1
				until
					column_cnt > interface.columns or found			
				loop
					if item_at_position (column_cnt, row_cnt) = widget then
						Result := column_cnt
						found := True
					end
					column_cnt := column_cnt + 1
				end
				row_cnt := row_cnt + 1
			end
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

