indexing
	description: "External C functions for accessing gtk.%
		% Those are used by containers.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_GTK_CONTAINERS_EXTERNALS


feature {NONE} -- GTK C functions for general containers

	gtk_container_add (container, widget: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_container_set_border_width (container: POINTER; border_width: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	c_gtk_container_border_width (container: POINTER): INTEGER is
		external "C [macro <gtk_eiffel.h>]"
		end

feature {NONE} -- GTK C functions for windows

	gtk_window_new (opt: INTEGER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_window_set_title (widget: POINTER; t: POINTER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_window_set_policy (w:POINTER; allow_shrink, allow_grow, auto_shrink: BOOLEAN) is
		external "C | <gtk/gtk.h>"
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
		external "C | <gtk/gtk.h>"
		end
	
feature {NONE} -- GTK C functions for dialogs

	gtk_dialog_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for tables

	gtk_table_new (rows, columns: INTEGER; homogenous: BOOLEAN): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_table_set_col_spacings (t: POINTER; n: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_table_set_row_spacings (t: POINTER; n: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_table_set_homogeneous (table: POINTER; homogeneous: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end

	gtk_table_attach (table, widget: POINTER; left, right, top, bottom,
					  x_opt, y_opt, x_pad, y_pad: INTEGER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_table_attach_defaults (table, widget: POINTER; left, right,
					 top, bottom: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	c_gtk_table_rows (table: POINTER): INTEGER is
		external "C | <gtk/gtk.h>"
		end

	c_gtk_table_columns (table: POINTER):INTEGER is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for boxes

	gtk_hbox_new (homegenous: BOOLEAN; spacing: INTEGER): POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_vbox_new (homegenous: BOOLEAN; spacing: INTEGER): POINTER is
		external "C | <gtk/gtk.h>"
		end
		
	gtk_box_pack_start (box, widget: POINTER; e, f: BOOLEAN; p: INTEGER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_box_pack_end (box, widget: POINTER; e, f: BOOLEAN; p: INTEGER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_box_set_homogeneous (box: POINTER; homogeneous: BOOLEAN) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_box_set_spacing (box: POINTER; spacing: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	c_gtk_box_set_child_options (box: POINTER; child: POINTER;
				expand, fill: BOOLEAN) is
		external "C | %"gtk_eiffel.h%""
		end

feature {NONE} -- GTK C functions for notebooks

	gtk_notebook_new: POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_notebook_set_tab_pos (notebook: POINTER; pos: INTEGER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_notebook_append_page (notebook, child, label: POINTER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_notebook_set_page (notebook: POINTER; page: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

	gtk_notebook_get_current_page (notebook: POINTER): INTEGER is
		external "C | <gtk/gtk.h>"
		end

	c_gtk_notebook_count (notebook: POINTER): INTEGER is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for split area

	gtk_hpaned_new: POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_vpaned_new: POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_paned_add1 (paned: POINTER; child: POINTER) is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_paned_add2 (paned: POINTER; child: POINTER) is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for scrollable area

	gtk_scrolled_window_new (hadj, vadj: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end
	
	gtk_scrolled_window_set_policy (w: POINTER; h, v: INTEGER) is
		external "C | <gtk/gtk.h>"
		end

feature {NONE} -- GTK C functions for frames

	gtk_frame_new (l: POINTER): POINTER is
		external "C | <gtk/gtk.h>"
		end

	gtk_frame_set_label (frame: POINTER; txt: POINTER) is
		external "C | <gtk/gtk.h>"
		end

end -- class EV_GTK_CONTAINERS_EXTERNALS

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
