note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	GTK_DEPRECATED

feature -- Container

	frozen gtk_container_resize_children (a_container: POINTER)
		obsolete
			"gtk_container_resize_children is deprecated [2021-06-01]"
		external
			"C (GtkContainer*) | <ev_gtk.h>"
		end

feature -- Widgets

	frozen gtk_widget_get_style (a_c_struct: POINTER): POINTER
		obsolete
			"Use 'gtk_widget_get_style_context' instead [2021-06-01]"
			--|Use GtkStyleContext instead
		external
			"C signature (GtkWidget*): GtkStyle* use <ev_gtk.h>"
		end

feature -- Widget Style		

	frozen gtk_style_context_get_background_color (a_context: POINTER; a_state: INTEGER; a_color: POINTER)
		obsolete
			"gtk_style_context_get_background_color’ is deprecated: Use 'gtk_render_background' instead [2021-06-01]"
		external
			"C signature (GtkStyleContext*, GtkStateFlags, GdkRGBA*) use <ev_gtk.h>"
		end

	frozen gtk_style_context_get_border_color (a_context: POINTER; a_state: INTEGER; a_color: POINTER)
		obsolete
			"gtk_style_context_get_border_color is deprecated: Use 'gtk_render_frame' instead [2021-06-01]"
		external
			"C signature (GtkStyleContext*, GtkStateFlags, GdkRGBA*) use <ev_gtk.h>"
		end

feature -- Table

	frozen gtk_table_get_default_row_spacing (a_table_struct: POINTER): INTEGER
		obsolete
			"Deprecated. Use gtk_grid_get_row_spacing() with GtkGrid. [2021-06-01]"
		external
			"C signature (GtkTable*): guint use <ev_gtk.h>"
		end

	frozen gtk_table_get_default_col_spacing (a_table_struct: POINTER): INTEGER
		obsolete
			"Deprecated. Use gtk_grid_get_column_spacing() with GtkGrid. [2021-06-01]"
		external
			"C signature (GtkTable*): guint use <ev_gtk.h>"
		end

	frozen gtk_table_attach_defaults (a_table: POINTER; a_widget: POINTER; a_left_attach: INTEGER_32; a_right_attach: INTEGER_32; a_top_attach: INTEGER_32; a_bottom_attach: INTEGER_32)
		obsolete
			"Deprecated. Use gtk_grid_attach() with GtkGrid. Note that the attach arguments differ between those two functions. [2021-06-01]"
		external
			"C (GtkTable*, GtkWidget*, guint, guint, guint, guint) | <ev_gtk.h>"
		end

	frozen gtk_table_new (a_rows: INTEGER_32; a_columns: INTEGER_32; a_homogeneous: BOOLEAN): POINTER
		obsolete
			"gtk_table_new’ is deprecated: Use 'GtkGrid' instead [2021-06-01]"
		external
			"C (guint, guint, gboolean): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_table_resize (a_table: POINTER; a_rows: INTEGER_32; a_columns: INTEGER_32)
		obsolete
			"gtk_table_resize is deprecated: Use 'GtkGrid' instead, GtkGrid resizes automatically. [2021-06-01]"
		external
			"C (GtkTable*, guint, guint) | <ev_gtk.h>"
		end

	frozen gtk_table_set_col_spacings (a_table: POINTER; a_spacing: INTEGER_32)
		obsolete
			"gtk_table_set_col_spacings’ is deprecated: Use gtk_grid_set_column_spacing() with GtkGrid. [2021-06-01]"
		external
			"C (GtkTable*, guint) | <ev_gtk.h>"
		end

	frozen gtk_table_set_homogeneous (a_table: POINTER; a_homogeneous: BOOLEAN)
		obsolete
			"gtk_table_set_homogeneous is deprecated. Use gtk_grid_set_row_homogeneous() and gtk_grid_set_column_homogeneous() with GtkGrid. [2021-06-01]"
		external
			"C (GtkTable*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_table_set_row_spacings (a_table: POINTER; a_spacing: INTEGER_32)
		obsolete
			"gtk_table_set_row_spacings is deprecated. Use gtk_grid_get_row_spacing() with GtkGrid [2021-06-01]"
		external
			"C (GtkTable*, guint) | <ev_gtk.h>"
		end

feature -- Alignment

	frozen gtk_alignment_new (a_xalign: REAL_32; a_yalign: REAL_32; a_xscale: REAL_32; a_yscale: REAL_32): POINTER
		obsolete
			"gtk_alignment_new is deprecated [2021-06-01]"
		external
			"C (gfloat, gfloat, gfloat, gfloat): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_alignment_set (a_alignment: POINTER; a_xalign: REAL_32; a_yalign: REAL_32; a_xscale: REAL_32; a_yscale: REAL_32)
		obsolete
			"gtk_alignment_set is deprecated [2021-06-01]"
		external
			"C (GtkAlignment*, gfloat, gfloat, gfloat, gfloat) | <ev_gtk.h>"
		end

feature -- Box

	frozen gtk_hbox_new (a_homogeneous: BOOLEAN; a_spacing: INTEGER_32): POINTER
		obsolete
			"gtk_hbox_new is deprecated: Use 'gtk_box_new' instead [2021-06-01]"
		external
			"C (gboolean, gint): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_vbox_new (a_homogeneous: BOOLEAN; a_spacing: INTEGER_32): POINTER
		obsolete
			"gtk_vbox_new is deprecated: Use 'gtk_box_new' instead [2021-06-01]"
		external
			"C (gboolean, gint): GtkWidget* | <ev_gtk.h>"
		end

feature -- Menu

	frozen gtk_menu_popup (a_menu: POINTER; a_parent_menu_shell: POINTER; a_parent_menu_item: POINTER; a_func: POINTER; a_data: POINTER; a_button: INTEGER_32; a_activate_time: INTEGER_32)
		obsolete
			"gtk_menu_popup is deprecated: Use '(gtk_menu_popup_at_widget, gtk_menu_popup_at_pointer, gtk_menu_popup_at_rect)' instead [2021-06-01]"
		external
			"C (GtkMenu*, GtkWidget*, GtkWidget*, GtkMenuPositionFunc, gpointer, guint, guint32) | <ev_gtk.h>"
		end

feature -- Misc

	frozen gtk_misc_set_alignment (a_misc: POINTER; a_xalign: REAL_32; a_yalign: REAL_32)
		obsolete
			"Use GtkWidget's alignment ('halign' and 'valign') and margin properties or GtkLabel's 'xalign' and 'yalign' properties. [2021-06-01]"
		external
			"C (GtkMisc*, gfloat, gfloat) | <ev_gtk.h>"
		end

	frozen gtk_misc_set_padding (a_misc: POINTER; a_xpad: INTEGER_32; a_ypad: INTEGER_32)
		obsolete
			"Use GtkWidget alignment and margin properties. [2021-06-01]"
		external
			"C (GtkMisc*, gint, gint) | <ev_gtk.h>"
		end

feature -- Adjustment

	frozen gtk_adjustment_changed (a_adjustment: POINTER)
		obsolete
			"gtk_adjustment_changed is deprecated [2021-06-01]"
		external
			"C (GtkAdjustment*) | <ev_gtk.h>"
		end

	frozen gtk_adjustment_value_changed (a_adjustment: POINTER)
		obsolete
			"gtk_adjustment_value_changed is deprecated. GTK+ emits “value-changed” itself whenever the value changes. [2021-06-01] "
		external
			"C (GtkAdjustment*) | <ev_gtk.h>"
		end


note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class GTK

