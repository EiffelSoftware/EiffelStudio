indexing
	description: "External C functions for accessing gtk.%
		% Those are used by containers.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_GTK_CONTAINERS_EXTERNALS


feature {NONE} -- GTK C functions for general containers

	gtk_container_add (container, widget: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_container_remove (container, widget: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_container_set_border_width (container: POINTER; border_width: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_container_border_width (container: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_container_nb_children (container: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_container_ith_child (container: POINTER; i: INTEGER): POINTER is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_container_has_child (container, child: POINTER): BOOLEAN is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_scrollable_area_add (scroll_area, widget: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	c_gtk_scrollable_area_has_child (container, child: POINTER): BOOLEAN is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_container_set_bg_pixmap (container: POINTER; pixmap: POINTER) is
		external
			"C (GtkWidget *, GtkWidget *) | %"gtk_eiffel.h%""
		end

	c_gtk_container_remove_all_children (container: POINTER) is
		external
			"C (GtkContainer *) | %"gtk_eiffel.h%""
		end

feature {NONE} -- GTK C functions for windows

	c_gtk_window_maximum_height (window: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_window_maximum_width (window: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end

	gdk_window_set_hints (widget: POINTER; x: INTEGER; y: INTEGER; min_width: INTEGER; min_height: INTEGER; max_width: INTEGER; max_height: INTEGER; flags: BOOLEAN) is
		external
			"C | <gdk/gdk.h>"
		end

	gdk_window_set_icon_name (widget: POINTER; name: STRING) is
		external
			"C | <gdk/gdk.h>"
		end

	gtk_window_new (opt: INTEGER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_window_set_policy (w:POINTER; allow_shrink, allow_grow, auto_shrink: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_window_set_transient_for (window: POINTER; parent_window: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_window_set_position (window: POINTER; position: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_window_set_title (widget: POINTER; t: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end
	c_gtk_window_title (window: POINTER): POINTER is

		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_window_x (window: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_window_y (window: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end

feature {NONE} -- GTK C functions for fixed containers

	gtk_fixed_new: POINTER is
		external
			"C | <gtk/gtk.h>"
		end
	
feature {NONE} -- GTK C functions for dialogs

	gtk_dialog_new: POINTER is
		external
			"C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for tables

	gtk_table_new (rows, columns: INTEGER; homogenous: BOOLEAN): POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_table_set_col_spacings (t: POINTER; n: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_table_set_row_spacings (t: POINTER; n: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_table_set_homogeneous (table: POINTER; homogeneous: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_table_attach (table, widget: POINTER; left, right, top, bottom,
					  x_opt, y_opt, x_pad, y_pad: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_table_attach_defaults (table, widget: POINTER; left, right,
					 top, bottom: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_table_rows (table: POINTER): INTEGER is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_table_columns (table: POINTER):INTEGER is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_table_set_spacing_if_needed (table: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_table_row_spacing (table: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_table_column_spacing (table: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

feature {NONE} -- GTK C functions for boxes

	gtk_hbox_new (homegenous: BOOLEAN; spacing: INTEGER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_vbox_new (homegenous: BOOLEAN; spacing: INTEGER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end
		
	gtk_box_pack_start (box, widget: POINTER; e, f: BOOLEAN; p: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_box_pack_end (box, widget: POINTER; e, f: BOOLEAN; p: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_box_set_homogeneous (box: POINTER; homogeneous: BOOLEAN) is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_box_set_spacing (box: POINTER; spacing: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_box_set_child_options (box: POINTER; child: POINTER;
				expand, fill: BOOLEAN) is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_box_is_child_expandable (box: POINTER; child: POINTER): BOOLEAN is
		external
			"C (GtkBox *, GtkWidget *): EIF_BOOLEAN | %"gtk_eiffel.h%""
		end

	c_gtk_box_set_child_expandable (box: POINTER; child: POINTER; flag: BOOLEAN) is
		external
			"C (GtkBox *, GtkWidget *, gint) | %"gtk_eiffel.h%""
		end

	c_gtk_box_homogeneous (box: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_box_spacing (box: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

feature {NONE} -- GTK C functions for notebooks

	gtk_notebook_new: POINTER is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_notebook_set_tab_pos (notebook: POINTER; pos: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_notebook_append_page (notebook, child, label: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_notebook_set_page (notebook: POINTER; page: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_notebook_get_current_page (notebook: POINTER): INTEGER is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_notebook_count (notebook: POINTER): INTEGER is
		external
			"C | %"gtk_eiffel.h%""
		end

	c_gtk_notebook_tab_position (notebook: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

feature {NONE} -- GTK C functions for split area

	gtk_hpaned_new: POINTER is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_vpaned_new: POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_paned_add1 (paned: POINTER; child: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end
	
	gtk_paned_add2 (paned: POINTER; child: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_paned_child1 (paned: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_paned_child2 (paned: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	c_gtk_paned_child1_size (paned: POINTER): INTEGER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

	gtk_paned_set_position (paned: POINTER; pos: INTEGER) is
		external
			"C (GtkPaned *, gint) | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for scrollable area

	gtk_scrolled_window_new (hadj, vadj: POINTER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_scrolled_window_add_with_viewport (scrolled_window, child: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end	

	gtk_scrolled_window_set_policy (w: POINTER; h, v: INTEGER) is
		external
			"C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for frames

	gtk_frame_new (l: POINTER): POINTER is
		external
			"C | <gtk/gtk.h>"
		end

	gtk_frame_set_label (frame: POINTER; txt: POINTER) is
		external
			"C | <gtk/gtk.h>"
		end

	c_gtk_frame_text (frame: POINTER): POINTER is
		external
			"C [macro %"gtk_eiffel.h%"]"
		end

end -- class EV_GTK_CONTAINERS_EXTERNALS

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
