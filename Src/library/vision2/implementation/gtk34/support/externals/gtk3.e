note
	description: "Summary description for {GTK3}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GTK3

inherit
	GTK2

feature -- GTK version	

	frozen gtk_get_major_version: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_get_major_version()"
		end

	frozen gtk_get_minor_version: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_get_minor_version()"
		end

	frozen gtk_get_micro_version: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_get_micro_version()"
		end

	frozen gtk_check_version (a_required_major, a_required_minor, a_required_micro: INTEGER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_check_version((guint) $a_required_major, (guint) $a_required_minor, (guint) $a_required_micro)"
		end

feature -- gtkWidget sizing

	frozen gtk_widget_get_preferred_size (a_widget: POINTER; a_minimum_size, a_preferred_size: POINTER)
		external
			"C (GtkWidget*, GtkRequisition*, GtkRequisition*) | <ev_gtk.h>"
		end

	frozen gtk_widget_get_preferred_height_for_width ( widget: POINTER; width: INTEGER; minimum_height, natural_height: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gtk_widget_get_preferred_height_for_width  ((GtkWidget *)$widget,
                                (gint)$width,
                                (gint *)$minimum_height,
                                (gint *)$natural_height)
             ]"
		end

	frozen gtk_widget_get_preferred_width_for_height ( widget: POINTER; height: INTEGER; minimum_width, natural_width: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gtk_widget_get_preferred_width_for_height
                               ((GtkWidget *)$widget,
                                (gint)$height,
                                (gint *)$minimum_width,
                                (gint *)$natural_width);

             ]"
		end

	frozen gtk_widget_get_preferred_width ( widget: POINTER; minimum_width, natural_width: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gtk_widget_get_preferred_width
                               ((GtkWidget *)$widget,
                                (gint *)$minimum_width,
                                (gint *)$natural_width);

             ]"
		end

	frozen gtk_widget_get_preferred_height  ( widget: POINTER; minimum_height, natural_height: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gtk_widget_get_preferred_height 
                               ((GtkWidget *)$widget,
                                (gint *)$minimum_height,
                                (gint *)$natural_height);

             ]"
		end

feature -- GtkWidget Externals

	frozen gtk_widget_get_halign (a_widget: POINTER): INTEGER
			-- Gets the value of the `halign` property.
			-- For backwards compatibility reasons this method will never return GTK_ALIGN_BASELINE,
			-- but instead it will convert it to GTK_ALIGN_FILL. Baselines are not supported for horizontal alignment.
			-- Returns the horizontal alignment of widget
		note
			eis: "name=gtk_widget_get_halign", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gtk-widget-get-halign"
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gtk_widget_get_halign ((GtkWidget *)$a_widget)"
		end

	frozen gtk_widget_set_halign (a_widget: POINTER; align: INTEGER)
			-- Sets the horizontal alignment of widget . See the `halign` property.
		note
			eis: "name=gtk_widget_get_halign", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gtk-widget-get-halign"
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gtk_widget_set_halign ((GtkWidget *)$a_widget, (GtkAlign)$align) "
		end

	frozen gtk_widget_get_valign (a_widget: POINTER): INTEGER
			-- Gets the value of the `valign` property.
			-- For backwards compatibility reasons this method will never return GTK_ALIGN_BASELINE,
			-- but instead it will convert it to GTK_ALIGN_FILL.
			-- If your widget want to support baseline aligned children it must use gtk_widget_get_valign_with_baseline(),
			-- or g_object_get (widget, "valign", &amp;value, NULL), which will also report the true value.
			-- Returns the vertical alignment of widget.
		note
			eis: "name=gtk_widget_get_halign", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gtk-widget-get-valign"
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gtk_widget_get_valign ((GtkWidget *)$a_widget)"
		end

	frozen gtk_widget_get_valign_with_baseline (a_widget: POINTER): INTEGER
			-- Gets the value of the `valign` property, including GTK_ALIGN_BASELINE.
		note
			eis: "name=gtk_widget_get_valign_with_baseline", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gtk-widget-get-valign-with-baseline"
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gtk_widget_get_valign_with_baseline ((GtkWidget *)$a_widget)"
		end

	frozen gtk_widget_set_valign (a_widget: POINTER; align: INTEGER)
			-- Sets the vertical alignment of widget . See the `valign` property.		
		note
			eis: "name=gtk_widget_set_valign", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gt-widget-set-valign"
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gtk_widget_set_valign ((GtkWidget *)$a_widget, (GtkAlign)$align) "
		end

	frozen gtk_widget_get_margin_start (a_widget: POINTER): INTEGER
			-- Gets the value of the `margin-start` property.
			-- The start margin of widget
		note
			eis: "name=gtk_widget_get_margin_start", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gtk-widget-get-margin-start"
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gtk_widget_get_margin_start ((GtkWidget *)$a_widget)"
		end

	frozen gtk_widget_set_margin_start (a_widget: POINTER; margin: INTEGER)
			-- Sets the start margin of widget . See the `margin-start` property.
		note
			eis: "name=gtk_widget_get_margin_start", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gtk-widget-set-margin-start"
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_set_margin_start ((GtkWidget *)$a_widget, (gint)$margin)"
		end

	frozen gtk_widget_get_margin_end (a_widget: POINTER): INTEGER
			-- Gets the value of the `margin-end` property.
			-- The end margin of widget
		note
			eis: "name=gtk_widget_get_margin_end", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gtk-widget-get-margin-end"
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gtk_widget_get_margin_end ((GtkWidget *)$a_widget)"
		end

	frozen gtk_widget_set_margin_end (a_widget: POINTER; margin: INTEGER)
			-- Sets the end margin of widget . See the `margin-end` property.
		note
			eis: "name=gtk_widget_set_margin_end", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gtk-widget-get-margin-end"
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_set_margin_end ((GtkWidget *)$a_widget, (gint)$margin)"
		end

	frozen gtk_widget_get_margin_top (a_widget: POINTER): INTEGER
			-- Gets the value of the `margin-top` property.
			-- The top margin of widget
		note
			eis: "name=gtk_widget_get_margin_top", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gtk-widget-get-margin-top"
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gtk_widget_get_margin_top ((GtkWidget *)$a_widget)"
		end

	frozen gtk_widget_set_margin_top (a_widget: POINTER; margin: INTEGER)
			-- Sets the top margin of widget . See the `margin-top` property.
		note
			eis: "name=gtk_widget_set_margin_top", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gtk-widget-set-margin-top"
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_set_margin_top ((GtkWidget *)$a_widget, (gint)$margin)"
		end

	frozen gtk_widget_get_margin_bottom (a_widget: POINTER): INTEGER
			-- Gets the value of the `margin-bottom` property.
			-- The bottom margin of widget
		note
			eis: "name=gtk_widget_get_margin_bottom", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gtk-widget-get-margin-bottom"
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gtk_widget_get_margin_bottom ((GtkWidget *)$a_widget)"
		end

	frozen gtk_widget_set_margin_bottom (a_widget: POINTER; margin: INTEGER)
			-- Sets the bottom margin of widget . See the `margin-bottom` property.
		note
			eis: "name=gtk_widget_set_margin_bottom", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gtk-widget-set-margin-bottom"
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_set_margin_bottom ((GtkWidget *)$a_widget, (gint)$margin)"
		end

	frozen gtk_widget_set_visual (widget: POINTER; visual: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_set_visual ((GtkWidget *)$widget, (GdkVisual *)$visual)"
		end



feature -- Box		

	frozen gtk_box_new (orientation: NATURAL_8; spacing: INTEGER): POINTER
		note
			eis: "name=gtk_box_new", "src=https://developer.gnome.org/gtk3/stable/GtkBox.html#gtk-box-new", "protocol=uri"
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_box_new ((GtkOrientation)$orientation, (gint)$spacing)"
		end

feature -- GtkPaned

	frozen gtk_paned_set_wide_handle (a_paned: POINTER; a_wide: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_CHECK_VERSION(3,16,0)
				gtk_paned_set_wide_handle ((GtkPaned*) $a_paned, (gboolean) $a_wide)
				#endif
			]"
		ensure
			is_class: class
		end

feature -- GtkGrid Externals

	frozen gtk_grid_set_row_homogeneous (a_grid: POINTER; a_homogeneous: BOOLEAN)
			-- Sets whether all rows of grid will have the same height.
		note
			eis: "name=gtk_grid_set_row_homogeneous", "src=https://developer.gnome.org/gtk3/stable/GtkGrid.html#gtk-grid-set-row-homogeneous"
		external
			"C (GtkGrid*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_grid_set_column_homogeneous (a_grid: POINTER; a_homogeneous: BOOLEAN)
			-- Sets whether all columns of grid will have the same width.
		note
			eis: "name=gtk_grid_set_column_homogeneous", "src=https://developer.gnome.org/gtk3/stable/GtkGrid.html#gtk-grid-set-column-homogeneous"
		external
			"C (GtkGrid*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_grid_get_column_spacing (grid: POINTER): INTEGER
			-- Returns the amount of space between the columns of grid .
		note
			eis: "name=gtk_grid_get_column_spacing", "src=https://developer.gnome.org/gtk3/stable/GtkGrid.html#gtk-grid-get-column-spacing"
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return gtk_grid_get_column_spacing ((GtkGrid *)$grid);
			]"
		end

	frozen gtk_grid_get_row_spacing (grid: POINTER): INTEGER
			-- Returns the amount of space between the rows of grid .
		note
			eis: "name=gtk_grid_get_row_spacing", "src=https://developer.gnome.org/gtk3/stable/GtkGrid.html#gtk-grid-get-row-spacing"
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return gtk_grid_get_row_spacing  ((GtkGrid *)$grid);
			]"
		end

	frozen gtk_grid_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_grid_attach (a_grid: POINTER; a_widget: POINTER; a_left_attach: INTEGER_32; a_right_attach: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
		note
			eis:"name=gtk_grid_attach", "src=https://developer.gnome.org/gtk3/stable/GtkGrid.html#gtk-grid-attach"
		external
			"C (GtkGrid*, GtkWidget*, gint, gint, gint, gint) | <ev_gtk.h>"
		end

	frozen gtk_grid_set_row_spacing (a_grid: POINTER; spacing: INTEGER)
		note
			eis:"name=gtk_grid_set_row_spacing", "src=https://developer.gnome.org/gtk3/stable/GtkGrid.html#gtk-grid-set-row-spacing"
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_grid_set_row_spacing ((GtkGrid *)$a_grid, (guint)$spacing)"
		end

	frozen gtk_grid_set_column_spacing (a_grid: POINTER; spacing: INTEGER)
		note
			eis:"name=gtk_grid_set_column_spacing", "src=https://developer.gnome.org/gtk3/stable/GtkGrid.html#gtk-grid-set-column-spacing"
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_grid_set_column_spacing ((GtkGrid *)$a_grid, (guint)$spacing)"
		end

feature -- Style

	frozen gtk_widget_get_style_context (a_widget: POINTER): POINTER
		note
			eis: "name=gtk_widget_get_style_context", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gtk-widget-get-style-context"
		external
			"C (GtkWidget*): GtkStyleContext* | <ev_gtk.h>"
		end

feature -- GtkMenu externals

	frozen gtk_menu_popup_at_widget (a_menu: POINTER; a_widget: POINTER; a_widget_anchor: INTEGER_32; a_menu_anchor: INTEGER_32; a_trigger_event: POINTER)
		external
			"C (GtkMenu*, GtkWidget*, GdkGravity, GdkGravity, const GdkEvent*) | <ev_gtk.h>"
		end

	frozen gtk_menu_popup_at_pointer (a_menu: POINTER; a_trigger_event: POINTER)
		external
			"C (GtkMenu*, const GdkEvent*) | <ev_gtk.h>"
		end

	frozen gtk_menu_popup_at_rect (a_menu: POINTER; a_window: POINTER; a_rectangle: POINTER; a_rectangle_anchor: INTEGER_32; a_menu_anchor: INTEGER_32; a_trigger_event: POINTER)
		external
			"C (GtkMenu*, GdkWindow*, const GdkRectangle*, GdkGravity, GdkGravity, const GdkEvent*) | <ev_gtk.h>"
		end

feature -- GTK Layout

	frozen gtk_is_layout (w: POINTER): BOOLEAN
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_IS_LAYOUT"
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

end
