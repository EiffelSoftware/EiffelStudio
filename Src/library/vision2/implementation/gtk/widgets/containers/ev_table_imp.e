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
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface
		end
create
	make

feature {NONE} -- Implementation

	make (an_interface: like interface) is
                        -- Create a table widget with `par' as
                        -- parent.
		do
			base_make (an_interface)
			set_c_object (C.gtk_table_new (0, 0, Default_homogeneous))
				-- table created with 0 row and 0 column.
		end

feature -- Status report

	widget_count: INTEGER is
		do
			Result := C.g_list_length (C.gtk_container_children (c_object))
		end

	row_spacing: INTEGER is
		do
			Result := c_gtk_table_row_spacing (c_object)
		end

	column_spacing: INTEGER is
		do
			Result := c_gtk_table_column_spacing (c_object)
		end

	resize (a_column, a_row: INTEGER) is
		do
			C.gtk_table_resize (c_object, a_row, a_column)
		end

feature -- Status settings

	enable_homogeneous is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			C.gtk_table_set_homogeneous (c_object, True)
		end

	disable_homogeneous is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do
			C.gtk_table_set_homogeneous (c_object, False)
		end

	set_row_spacing (a_value: INTEGER) is
			-- Spacing between two rows of the table
		do
			C.gtk_table_set_row_spacings (c_object, a_value)
		end

	set_column_spacing (a_value: INTEGER) is
			-- Spacing between two columns of the table
		do
			C.gtk_table_set_col_spacings (c_object, a_value)
		end

	put (v: EV_WIDGET; a_x, a_y, column_span, row_span: INTEGER) is
			-- Set the position of the `v' in the table.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= v.implementation
			C.gtk_table_attach_defaults (
					c_object,
					item_imp.c_object,
					a_x - 1,
					a_x - 1 + column_span,
					a_y - 1,
					a_y - 1 + row_span
			)
		end

feature -- Element change

	remove (v: EV_WIDGET) is
			-- Remove `v' from the table if present.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= v.implementation
			C.gtk_container_remove (c_object, item_imp.c_object)
		end

feature {NONE} -- Externals

	c_gtk_table_rows (a_table_struct: POINTER): INTEGER is
			-- Number of rows
		external
			"C [struct <gtk/gtk.h>] (GtkTable): EIF_INTEGER"
		alias
			"nrows"
		end

	c_gtk_table_columns (a_table_struct: POINTER): INTEGER is
			-- Number of columns
		external
			"C [struct <gtk/gtk.h>] (GtkTable): EIF_INTEGER"
		alias
			"ncols"
		end

	c_gtk_table_row_spacing (a_table_struct: POINTER): INTEGER is
			-- Spacing between two rows
		external
			"C [struct <gtk/gtk.h>] (GtkTable): EIF_INTEGER"
		alias
			"row_spacing"
		end
	
	c_gtk_table_column_spacing (a_table_struct: POINTER): INTEGER is
			-- Spacing between two columns
		external
			"C [struct <gtk/gtk.h>] (GtkTable): EIF_INTEGER"
		alias
			"column_spacing"
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TABLE


end -- class EV_TABLE_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.12  2000/06/07 17:27:38  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.9.4.8  2000/06/06 00:42:15  king
--| Added resize
--|
--| Revision 1.9.4.7  2000/06/05 21:09:48  king
--| Added, remove, widget_count amd corrected put comment.
--|
--| Revision 1.9.4.6  2000/06/02 23:30:55  king
--| Now inheriting from EV_CONTAINER
--|
--| Revision 1.9.4.5  2000/06/02 22:07:13  king
--| New table implementation
--|
--| Revision 1.9.4.4  2000/05/31 22:28:37  king
--| Added add/remove act seq calls
--|
--| Revision 1.9.4.3  2000/05/31 21:55:05  king
--| Added comment to insert_i_th about extend behaviour
--|
--| Revision 1.9.4.2  2000/05/30 22:24:04  king
--| Initial implementation to new structure
--|
--| Revision 1.9.4.1  2000/05/03 19:08:48  oconnor
--| mergred from HEAD
--|
--| Revision 1.11  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
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
