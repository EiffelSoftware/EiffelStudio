note
	description: "Gtk Version Dependent Externals"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GTK2_DEPRECATED

feature -- Style

	gtk_style_context_state_is_running (context: POINTER; state: INTEGER_8; progress: POINTER)
		obsolete
			"gtk_style_context_state_is_running is deprecated [2021-06-01]"
		external
			"C signature (GtkStyleContext*, GtkStateType, gdouble*) use <ev_gtk.h>"
		end

	gtk_style_context_list_regions (context: POINTER): POINTER
		obsolete
			"gtk_style_context_list_regions is deprecated [2021-06-01]"
		external
			"C signature (GtkStyleContext*): GList* use <ev_gtk.h>"
		end

	gtk_style_context_add_region (context: POINTER; region_name: POINTER; flags: INTEGER_8)
		obsolete
			"gtk_style_context_add_region is deprecated [2021-06-01]"
		external
			"C signature (GtkStyleContext*, gchar*, GtkRegionFlags) use <ev_gtk.h>"
		end

	gtk_style_context_remove_region (context: POINTER; region_name: POINTER)
		obsolete
			"gtk_style_context_remove_region is deprecated [2021-06-01]"
		external
			"C signature (GtkStyleContext*, gchar*) use <ev_gtk.h>"
		end

	gtk_style_context_has_region (context: POINTER; region_name: POINTER; flags_return: POINTER)
		obsolete
			"gtk_style_context_has_region is deprecated [2021-06-01]"
		external
			"C signature (GtkStyleContext*, gchar*, GtkRegionFlags*) use <ev_gtk.h>"
		end

	gtk_style_context_set_direction (context: POINTER; direction: INTEGER_8)
		obsolete
			"gtk_style_context_set_direction is deprecated: Use gtk_style_context_set_state instead [2021-06-01]"
		external
			"C signature (GtkStyleContext*, GtkTextDirection) use <ev_gtk.h>"
		end

	gtk_style_context_get_direction (context: POINTER): INTEGER_8
		obsolete
			"gtk_style_context_get_direction is deprecated: Use gtk_style_context_get_state instead [2021-06-01]"
		external
			"C signature (GtkStyleContext*): GtkTextDirection use <ev_gtk.h>"
		end

	gtk_style_context_notify_state_change (context: POINTER; window: POINTER; region_id: POINTER; state: INTEGER_8; state_value: BOOLEAN)
		obsolete
			"gtk_style_context_notify_state_change is deprecated [2021-06-01]"
		external
			"C signature (GtkStyleContext*, GdkWindow*, gpointer, GtkStateType, gboolean) use <ev_gtk.h>"
		end

	gtk_style_context_cancel_animations (context: POINTER; region_id: POINTER)
		obsolete
			"gtk_style_context_cancel_animations is deprecated [2021-06-01]"
		external
			"C signature (GtkStyleContext*, gpointer) use <ev_gtk.h>"
		end

	gtk_style_context_scroll_animations (context: POINTER; window: POINTER; dx: INTEGER_32 ; dy: INTEGER_32)
		obsolete
			"gtk_style_context_scroll_animations is deprecated [2021-06-01]"
		external
			"C signature (GtkStyleContext*, GdkWindow*, gint, gint) use <ev_gtk.h>"
		end

	gtk_style_context_push_animatable_region (context: POINTER; region_id: POINTER)
		obsolete
			"gtk_style_context_push_animatable_region is deprecated [2021-06-01]"
		external
			"C signature (GtkStyleContext*, gpointer) use <ev_gtk.h>"
		end

	gtk_style_context_pop_animatable_region (context: POINTER)
		obsolete
			"gtk_style_context_pop_animatable_region is deprecated [2021-06-01]"
		external
			"C signature (GtkStyleContext*) use <ev_gtk.h>"
		end

	gtk_style_context_get_font (context: POINTER; state: INTEGER_8): POINTER
		obsolete
			"gtk_style_context_get_font is deprecated: Use 'gtk_style_context_get' instead [2021-06-01]"
		external
			"C signature (GtkStyleContext*, GtkStateFlags): PangoFontDescription* use <ev_gtk.h>"
		end

	gtk_style_context_invalidate (context: POINTER)
		obsolete
			"gtk_style_context_invalidate is deprecated [2021-06-01]"
		external
			"C signature (GtkStyleContext*) use <ev_gtk.h>"
		end

	gtk_style_context_lookup_icon_set (context: POINTER; stock_id: POINTER): POINTER
		obsolete
			"gtk_style_context_lookup_icon_set is deprecated: Use {GTK2}.gtk_icon_theme_lookup_icon instead [2021-06-01]"
		external
			"C signature (GtkStyleContext*, gchar*): GtkIconSet* use <ev_gtk.h>"
		end

	gtk_style_context_set_background (context: POINTER; window: POINTER)
		obsolete
			"gtk_style_context_set_background is deprecated: Use 'gtk_render_background' instead [2021-06-01]"
		external
			"C signature (GtkStyleContext*, GdkWindow*) use <ev_gtk.h>"
		end

feature -- Icon

	gtk_icon_set_render_icon_pixbuf (icon_set: POINTER; context: POINTER; size: INTEGER_8): POINTER
		obsolete
			"gtk_icon_set_render_icon_pixbuf is deprecated [2021-06-01]"
		external
			"C signature (GtkIconSet*, GtkStyleContext*, GtkIconSize): GdkPixbuf* use <ev_gtk.h>"
		end

feature -- Render

	gtk_render_frame_gap (context: POINTER; cr: POINTER; x: REAL_64 ; y: REAL_64 ; width: REAL_64 ; height: REAL_64 ; gap_side: INTEGER_8; xy0_gap: REAL_64 ; xy1_gap: REAL_64 )
		obsolete
			"gtk_render_frame_gap is deprecated: Use 'gtk_render_frame' instead [2021-06-01]"
		external
			"C signature (GtkStyleContext*, cairo_t*, gdouble, gdouble, gdouble, gdouble, GtkPositionType, gdouble, gdouble) use <ev_gtk.h>"
		end

	gtk_render_icon_pixbuf (context: POINTER; source: POINTER; size: INTEGER_8): POINTER
		obsolete
			"gtk_render_icon_pixbuf is deprecated: Use 'gtk_icon_theme_load_icon' instead [2021-06-01]"
		external
			"C signature (GtkStyleContext*, GtkIconSource*, GtkIconSize): GdkPixbuf* use <ev_gtk.h>"
		end

feature -- Widget

	frozen gtk_widget_modify_font (a_widget: POINTER; a_font_description: POINTER)
		obsolete
			"gtk_widget_modify_font is deprecated: Use 'PangoContext' or 'GtkCssProvider' instead [2021-06-01]"
		external
			"C signature (GtkWidget*, PangoFontDescription*) use <ev_gtk.h>"
		end

	frozen gtk_widget_set_double_buffered (a_widget: POINTER; is_buffered: BOOLEAN)
		obsolete
			"gtk_widget_set_double_buffered is deprecated [2021-06-01]"
		external
			"C signature (GtkWidget*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_widget_override_color (a_widget: POINTER; a_state_flag: INTEGER_32; a_color: POINTER)
		obsolete
			"gtk_widget_override_color is deprecated [2021-06-01]"
		external
			"C signature (GtkWidget*, GtkStateFlags, GdkRGBA*) use <ev_gtk.h>"
		end

	frozen gtk_widget_override_background_color (a_widget: POINTER; a_state_flag: INTEGER_32; a_color: POINTER)
		obsolete
			"gtk_widget_override_background_color is deprecated [2021-06-01]"
		external
			"C signature (GtkWidget*, GtkStateFlags, GdkRGBA*) use <ev_gtk.h>"
		end

	frozen gtk_widget_get_modifier_style (a_widget: POINTER): POINTER
		obsolete
			"gtk_widget_get_modifier_style is deprecated: Use 'GtkStyleContext' instead [2021-06-01]"
		external
			"C signature (GtkWidget*): GtkRcStyle* use <ev_gtk.h>"
		end

	frozen gtk_widget_render_icon (a_widget, a_stock_id: POINTER; a_icon_size: INTEGER_32; a_detail: POINTER): POINTER
		obsolete
			"gtk_widget_render_icon is deprecated: Use 'gtk_icon_theme_load_icon' instead [2021-06-01]"
		external
			"C signature (GtkWidget*, gchar*, GtkIconSize, gchar*): GdkPixbuf* use <ev_gtk.h>"
		end

feature -- Mem

	frozen g_mem_set_vtable (mem_vtable: POINTER)
		obsolete
			"g_mem_set_vtable is deprecated [2021-06-01]"
		external
			"C signature (GMemVTable*) use <ev_gtk.h>"
		end

	frozen g_mem_is_system_malloc: BOOLEAN
		obsolete
			"g_mem_is_system_malloc is deprecated [2021-06-01]"
		external
			"C signature (): GBoolean use <ev_gtk.h>"
		end

feature -- Enum

	frozen gtk_container_set_focus_chain (a_container: POINTER; a_focus_chain: POINTER)
		obsolete
			"gtk_container_set_focus_chain is deprecated. For overriding focus behavior, use the GtkWidgetClass::focus signal. [2021-06-01] "
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_container_set_focus_chain ((GtkContainer*) $a_container, (GList*) $a_focus_chain)"
		end

	frozen gtk_stock_ok_enum: POINTER
		obsolete
			"use gtk_ok_enum_label. [2021-06-01]"
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STOCK_OK"
		end

	frozen gtk_stock_open_enum: POINTER
		obsolete
			"use gtk_cancel_open_label. [2021-06-01]"
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STOCK_OPEN"
		end

	frozen gtk_stock_save_enum: POINTER
		obsolete
			"use gtk_save_enum_label [2021-06-01]."
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STOCK_SAVE"
		end

	frozen gtk_stock_cancel_enum: POINTER
		obsolete
			"use gtk_cancel_enum_label. [2021-06-01]"
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STOCK_CANCEL"
		end

feature -- Tree

	frozen gtk_tree_view_set_rules_hint (a_tree_view: POINTER; a_hint: BOOLEAN)
		obsolete
			"gtk_tree_view_set_rules_hint has been deprecated since version 3.14 [2021-06-01]"
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_set_rules_hint ((GtkTreeView*) $a_tree_view, (gboolean) $a_hint)"
		end

feature -- Cell

	frozen gtk_cell_renderer_get_size (a_cell_renderer, a_widget, a_cell_area, a_x_offset, a_y_offset, a_width, a_height: POINTER)
		obsolete
			"gtk_cell_renderer_get_size is deprecated: Use 'gtk_cell_renderer_get_preferred_size' instead [2021-06-01]"
		external
			"C signature (GtkCellRenderer*, GtkWidget*, GdkRectangle*, gint*, gint*, gint*, gint*) use <ev_gtk.h>"
		end

feature -- Colors

	frozen gtk_color_selection_dialog_get_color_selection (a_color_selection_dialog: POINTER): POINTER
		obsolete
			"gtk_color_selection_dialog_get_color_selection is deprecated: Use 'GtkColorChooser' instead [2021-06-01]"
		external
			"C signature (GtkColorSelectionDialog*): GtkWidget* use <ev_gtk.h>"
		end

feature -- Tearoff		

	frozen gtk_tearoff_menu_item_new: POINTER
		obsolete
			"gtk_tearoff_menu_item_new is deprecated [2021-06-01]"
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		end

feature -- Image

	frozen gtk_image_menu_item_set_image (a_menu_item, a_image: POINTER)
		obsolete
			"gtk_image_menu_item_set_image is deprecated [2021-06-01]"
		external
			"C signature (GtkImageMenuItem*, GtkWidget*) use <ev_gtk.h>"
		end

	frozen gtk_image_set_from_stock (a_image, a_stock_id: POINTER; a_icon_size: INTEGER_32)
		obsolete
			"gtk_image_set_from_stock is deprecated: Use 'gtk_image_set_from_icon_name' instead [2021-06-01]"
		external
			"C signature (GtkImage*, gchar*, GtkIconSize) use <ev_gtk.h>"
		end

	frozen gtk_image_menu_item_new: POINTER
		obsolete
			"gtk_image_menu_item_new is deprecated: Use 'gtk_menu_item_new' instead [2021-06-01]"
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
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
