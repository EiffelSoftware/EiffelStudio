indexing
	description: "Gtk Version Dependent Externals"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_DEPENDENT_EXTERNALS

feature -- Externals

--	frozen gtk_combo_box_entry_new: POINTER is
--		external
--			"C signature (): GtkWidget* use <gtk/gtk.h>"
--		end

--	frozen gtk_event_box_set_visible_window (a_event_box: POINTER; a_visible: BOOLEAN) is
--		external
--			"C signature (GtkEventBox*, gboolean) use <gtk/gtk.h>"
--		end

	frozen gdk_window_get_frame_extents (a_window, a_rect: POINTER) is
		external
			"C signature (GdkWindow*, GdkRectangle*) use <gtk/gtk.h>"
		end

	frozen gtk_entry_set_max_length (a_entry: POINTER; a_max: INTEGER) is
		external
			"C (GtkEntry*, gint) | <gtk/gtk.h>"
		end

	frozen gtk_fixed_get_type: INTEGER is
		external
			"C (): GtkType | <gtk/gtk.h>"
		end

	frozen gtk_fixed_move (a_fixed: POINTER; a_widget: POINTER; a_x: INTEGER; a_y: INTEGER) is
		external
			"C (GtkFixed*, GtkWidget*, gint, gint) | <gtk/gtk.h>"
		end

	frozen gtk_fixed_new: POINTER is
		external
			"C (): GtkWidget* | <gtk/gtk.h>"
		end

	frozen gtk_fixed_put (a_fixed: POINTER; a_widget: POINTER; a_x: INTEGER; a_y: INTEGER) is
		external
			"C (GtkFixed*, GtkWidget*, gint, gint) | <gtk/gtk.h>"
		end

	frozen set_gdk_rectangle_struct_height (a_c_struct: POINTER; a_height: INTEGER) is
		external
			"C [struct <gtk/gtk.h>] (GdkRectangle, gint)"
		alias
			"height"
		end

	frozen set_gdk_rectangle_struct_width (a_c_struct: POINTER; a_width: INTEGER) is
		external
			"C [struct <gtk/gtk.h>] (GdkRectangle, gint)"
		alias
			"width"
		end

	frozen set_gdk_rectangle_struct_x (a_c_struct: POINTER; a_x: INTEGER) is
		external
			"C [struct <gtk/gtk.h>] (GdkRectangle, gint)"
		alias
			"x"
		end

	frozen set_gdk_rectangle_struct_y (a_c_struct: POINTER; a_y: INTEGER) is
		external
			"C [struct <gtk/gtk.h>] (GdkRectangle, gint)"
		alias
			"y"
		end

	frozen gtk_args_array_i_th (args_array: POINTER; an_index: INTEGER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"(GValue*)$args_array + (int)($an_index)"
		end

	frozen g_value_array_i_th (args_array: POINTER; an_index: INTEGER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"(GValue*)$args_array + (int)($an_index - 1)"
		end

	frozen g_value_array_get_nth (a_value_array: POINTER; n_th: INTEGER): POINTER is
		external
			"C signature (GValueArray*, guint): GValue* use <gtk/gtk.h>"
		end

	frozen gtk_color_selection_dialog_struct_color_selection (a_color_selection_dialog: POINTER): POINTER is
		external
			"C struct GtkColorSelectionDialog access colorsel use <gtk/gtk.h>"
		end

	frozen gtk_color_selection_get_current_color (a_color_selection, a_color: POINTER) is
		external
			"C signature (GtkColorSelection*, GdkColor*) use <gtk/gtk.h>"
		end

	frozen gtk_color_selection_set_current_color (a_color_selection, a_color: POINTER) is
		external
			"C signature (GtkColorSelection*, GdkColor*) use <gtk/gtk.h>"
		end

	frozen gdk_colormap_query_color (a_color_map: POINTER; a_pixel: INTEGER; a_color: POINTER) is
		external
			"C signature (GdkColormap*, gulong, GdkColor*) use <gtk/gtk.h>"
		end

	frozen gdk_pixbuf_scale_simple (a_gdkpixbuf: POINTER; a_width, a_height, a_interp_mode: INTEGER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gdk_pixbuf_scale_simple ((GdkPixbuf*) $a_gdkpixbuf, (int) $a_width, (int) $a_width, (int) $a_interp_mode)"
		end

	frozen gdk_interp_bilinear: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_INTERP_BILINEAR"
		end

	frozen gdk_pixbuf_composite (src, dest: POINTER; dest_x, dest_y, dest_width, dest_height: INTEGER; offset_x, offset_y, scale_x, scale_y: DOUBLE; interp_type, overall_alpha: INTEGER) is
		external
			"C signature (GdkPixbuf*, GdkPixbuf*, int, int, int, int, double, double, double, double, GdkInterpType, int) use <gtk/gtk.h>"
		end

	frozen gtk_widget_render_icon (a_widget, a_stock_id: POINTER; a_icon_size: INTEGER; a_detail: POINTER): POINTER is
		external
			"C signature (GtkWidget*, gchar*, GtkIconSize, gchar*): GdkPixbuf* use <gtk/gtk.h>"
		end

	frozen gtk_image_set_from_stock (a_image, a_stock_id: POINTER; a_icon_size: INTEGER) is
		external
			"C signature (GtkImage*, gchar*, GtkIconSize) use <gtk/gtk.h>"
		end

	frozen gtk_widget_modify_text (a_widget: POINTER; a_state_type: INTEGER; a_color: POINTER) is
		external
			"C signature (GtkWidget*, GtkStateType, GdkColor*) use <gtk/gtk.h>"
		end

	frozen gtk_widget_modify_base (a_widget: POINTER; a_state_type: INTEGER; a_color: POINTER) is
		external
			"C signature (GtkWidget*, GtkStateType, GdkColor*) use <gtk/gtk.h>"
		end

	frozen gtk_image_menu_item_new: POINTER is
		external
			"C signature (): GtkWidget* use <gtk/gtk.h>"
		end

	frozen gtk_accel_label_new (a_string: POINTER): POINTER is
		external
			"C signature (gchar*): GtkWidget* use <gtk/gtk.h>"
		end

	frozen gtk_tearoff_menu_item_new: POINTER is
		external
			"C signature (): GtkWidget* use <gtk/gtk.h>"
		end

	frozen gtk_image_menu_item_set_image (a_menu_item, a_image: POINTER) is
		external
			"C signature (GtkImageMenuItem*, GtkWidget*) use <gtk/gtk.h>"
		end

	frozen gtk_menu_item_new_with_mnemonic (a_label: POINTER): POINTER is
		external
			"C signature (gchar*): GtkWidget* use <gtk/gtk.h>"
		end
		
	frozen gtk_label_set_text_with_mnemonic (a_label, a_text: POINTER) is
		external
			"C signature (GtkLabel*, gchar*) use <gtk/gtk.h>"
		end

	frozen gtk_accel_groups_activate (a_object: POINTER; a_key, a_modifier_type: INTEGER): BOOLEAN is
		external
			"C signature (GObject*, guint, GdkModifierType): gboolean use <gtk/gtk.h>"
		end

	frozen gtk_window_present (a_window: POINTER) is
		external
			"C signature (GtkWindow*) use <gtk/gtk.h>"
		end

	frozen gtk_window_iconify (a_window: POINTER) is
		external
			"C signature (GtkWindow*) use <gtk/gtk.h>"
		end

	frozen gtk_window_deiconify (a_window: POINTER) is
		external
			"C signature (GtkWindow*) use <gtk/gtk.h>"
		end

	frozen gtk_window_stick (a_window: POINTER) is
		external
			"C signature (GtkWindow*) use <gtk/gtk.h>"
		end

	frozen gtk_window_unstick (a_window: POINTER) is
		external
			"C signature (GtkWindow*) use <gtk/gtk.h>"
		end

	frozen gtk_window_maximize (a_window: POINTER) is
		external
			"C signature (GtkWindow*) use <gtk/gtk.h>"
		end

	frozen gtk_window_unmaximize (a_window: POINTER) is
		external
			"C signature (GtkWindow*) use <gtk/gtk.h>"
		end

	frozen gtk_window_fullscreen (a_window: POINTER) is
		external
			"C signature (GtkWindow*) use <gtk/gtk.h>"
		end

	frozen gtk_window_unfullscreen (a_window: POINTER) is
		external
			"C signature (GtkWindow*) use <gtk/gtk.h>"
		end

	frozen gdk_pixbuf_get_formats: POINTER is
		external
			"C signature (): GSList* use <gtk/gtk.h>"
		end

	frozen gdk_pixbuf_format_is_writable (a_pixbuf_format: POINTER): BOOLEAN is
		external
			"C signature (GdkPixbufFormat*): gboolean use <gtk/gtk.h>"
		end

	frozen gdk_pixbuf_format_get_name (a_pixbuf_format: POINTER): POINTER is
		external
			"C signature (GdkPixbufFormat*): gchar* use <gtk/gtk.h>"
		end

	frozen gdk_pixbuf_save (a_pixbuf, a_file_handle, a_filetype: POINTER; a_error: TYPED_POINTER [POINTER]) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gdk_pixbuf_save ((GdkPixbuf*) $a_pixbuf, (char*) $a_file_handle, (char*) $a_filetype, (GError**) $a_error, NULL)"
		end

	frozen gdk_pixbuf_get_from_drawable (a_pixbuf, a_drawable, a_colormap: POINTER; src_x, src_y, dest_x, dest_y, a_width, a_height: INTEGER): POINTER is
		external
			"C signature (GdkPixbuf*, GdkDrawable*, GdkColormap*, int, int, int, int, int, int): GdkPixbuf use <gtk/gtk.h>"
		end

	frozen gdk_pixbuf_render_pixmap_and_mask (a_pixbuf: POINTER; a_pixmap, a_mask: TYPED_POINTER [POINTER]; alpha_threshold: INTEGER) is
		external
			"C signature (GdkPixbuf*, GdkPixmap**, GdkBitmap**, int) use <gtk/gtk.h>"
		end

	frozen gdk_pixbuf_new_from_file (a_filename: POINTER; a_error: TYPED_POINTER [POINTER]): POINTER is
		external
			"C signature (char*, GError**): GdkPixbuf* use <gtk/gtk.h>"
		end

	frozen g_locale_to_utf8 (a_string: POINTER; a_length: INTEGER; byte_read, bytes_written, gerror: TYPED_POINTER [INTEGER]): POINTER is
		external
			"C signature (gchar*, gssize, gsize*, gsize*, GError**): gchar* use <gtk/gtk.h> "
		end
	
	frozen g_utf8_strlen (a_utf8_string: POINTER; maximum: INTEGER): INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_utf8_strlen ((gchar*) $a_utf8_string, (gssize) $maximum)"
		end

	frozen g_locale_from_utf8 (a_string: POINTER; a_length: INTEGER; byte_read, bytes_written, gerror: TYPED_POINTER [INTEGER]): POINTER is
		external
			"C signature (gchar*, gssize, gsize*, gsize*, GError**): gchar* use <gtk/gtk.h> "
		end

	frozen gtk_settings_get_default: POINTER is
		external
			"C signature (): GtkSettings* use <gtk/gtk.h>"
		end

	frozen gtk_value_pointer (arg: POINTER): POINTER is
			-- Pointer to the value of a GtkArg.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_peek_pointer ((GValue*) $arg)"
		end
		
	frozen gtk_value_int (arg: POINTER): INTEGER is
			-- Integer value from a GtkArg.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_get_int ((GValue*) $arg)"
		end

	frozen gtk_value_uint (arg: POINTER): INTEGER is
			-- Integer value from a GtkArg.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_get_uint ((GValue*) $arg)"
		end

	frozen gtk_widget_get_pango_context (a_widget: POINTER): POINTER is
		external
			"C signature (GtkWidget*): PangoContext* use <gtk/gtk.h>"
		end
		
	frozen pango_layout_set_font_description (a_layout, a_font_desc: POINTER) is
		external
			"C signature (PangoLayout*, PangoFontDescription*) use <gtk/gtk.h>"
		end

	frozen pango_layout_get_pixel_size (a_layout: POINTER; a_width, a_height: TYPED_POINTER [INTEGER]) is
		external
			"C signature (PangoLayout*, gint*, gint*) use <gtk/gtk.h>"
		end
		
	frozen pango_layout_get_iter (a_layout: POINTER): POINTER is
		external
			"C signature (PangoLayout*): PangoLayoutIter* use <gtk/gtk.h>"
		end
		
	frozen pango_layout_iter_get_baseline (a_iter: POINTER): INTEGER is
		external
			"C signature (PangoLayoutIter*): gint use <gtk/gtk.h>"
		end

	frozen gdk_draw_layout (a_drawable, a_gc: POINTER; a_x, a_y: INTEGER; a_layout: POINTER) is
		external
			"C signature (GdkDrawable*, GdkGC*, gint, gint, PangoLayout*) use <gtk/gtk.h>"
		end

	frozen gtk_widget_create_pango_layout (a_widget: POINTER; a_text: POINTER): POINTER is
		external
			"C signature (GtkWidget*, gchar*): PangoLayout* use <gtk/gtk.h>"
		end

	frozen gtk_widget_modify_fg (a_widget: POINTER; a_state_type: INTEGER; a_color: POINTER) is
		external
			"C signature (GtkWidget*, GtkStateType, GdkColor*) use <gtk/gtk.h>"
		end

	frozen gtk_widget_modify_bg (a_widget: POINTER; a_state_type: INTEGER; a_color: POINTER) is
		external
			"C signature (GtkWidget*, GtkStateType, GdkColor*) use <gtk/gtk.h>"
		end

	frozen gtk_widget_get_modifier_style (a_widget: POINTER): POINTER is
		external
			"C signature (GtkWidget*): GtkRcStyle* use <gtk/gtk.h>"
		end	

	frozen pango_scale: INTEGER is
		external
			"C Macro use <gtk/gtk.h>"
		alias
			"PANGO_SCALE"
		end

	frozen pango_font_description_new: POINTER is
		external
			"C signature (): PangoFontDescription* use <gtk/gtk.h>"
		end

	frozen pango_font_description_free (a_pango_description: POINTER) is
		external
			"C signature (PangoFontDescription*) use <gtk/gtk.h>"
		end
		
	frozen pango_font_description_copy (a_pango_description: POINTER): POINTER is
		external
			"C signature (PangoFontDescription*): PangoFontDescription* use <gtk/gtk.h>"
		end

	frozen pango_font_description_set_family (a_pango_description: POINTER; a_family: POINTER) is
		external
			"C signature (PangoFontDescription*, char*) use <gtk/gtk.h>"
		end

	frozen pango_font_description_get_family (a_pango_description: POINTER): POINTER is
		external
			"C signature (PangoFontDescription*): char* use <gtk/gtk.h>"
		end

	frozen pango_font_description_set_style (a_pango_description: POINTER; a_pango_style: INTEGER) is
		external
			"C signature (PangoFontDescription*, PangoStyle) use <gtk/gtk.h>"
		end
		
	frozen pango_font_description_get_style (a_pango_description: POINTER): INTEGER is
		external
			"C signature (PangoFontDescription*): PangoStyle use <gtk/gtk.h>"
		end

	frozen pango_font_description_set_weight (a_pango_description: POINTER; a_weight: INTEGER) is
		external
			"C signature (PangoFontDescription*, PangoWeight) use <gtk/gtk.h>"
		end
		
	frozen pango_font_description_get_weight (a_pango_description: POINTER): INTEGER is
		external
			"C signature (PangoFontDescription*): PangoWeight use <gtk/gtk.h>"
		end

	frozen pango_font_description_set_size (a_pango_description: POINTER; a_size: INTEGER) is
		external
			"C signature (PangoFontDescription*, gint) use <gtk/gtk.h>"
		end
		
	frozen pango_font_description_get_size (a_pango_description: POINTER): INTEGER is
		external
			"C signature (PangoFontDescription*): gint use <gtk/gtk.h>"
		end

	frozen pango_font_description_from_string (a_description: STRING): POINTER is
		external
			"C signature (char*): PangoFontDescription* use <gtk/gtk.h>"
		end

	frozen g_object_set_pointer (a_object: POINTER; a_property: POINTER; arg1: POINTER; arg2: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_object_set ((gpointer) $a_object, (gchar*) $a_property, (gpointer) $arg1, NULL)"
		end
		
	frozen g_object_set_string (a_object: POINTER; a_property: POINTER; string_arg: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_object_set ((gpointer) $a_object, (gchar*) $a_property, (gchar*) $string_arg, NULL)"
		end

	frozen g_object_get_string (a_object: POINTER; a_property: POINTER; string_arg: TYPED_POINTER [POINTER]) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_object_get ((gpointer) $a_object, (gchar*) $a_property, (gchar**) $string_arg, NULL)"
		end

	frozen g_object_get_integer (a_object: POINTER; a_property: POINTER; int_arg: TYPED_POINTER [INTEGER]) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_object_get ((gpointer) $a_object, (gchar*) $a_property, (gint*) $int_arg, NULL)"
		end

	frozen g_object_set_integer (a_object: POINTER; a_property: POINTER; int_arg: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, $int_arg, NULL)"
		end

	frozen g_object_set_double (a_object: POINTER; a_property: POINTER; double_arg: DOUBLE) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, $double_arg, NULL)"
		end
		
	frozen g_object_set_boolean (a_object: POINTER; a_property: POINTER; bool_arg: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, $bool_arg, NULL)"
		end

	frozen signal_disconnect (a_object: POINTER; a_handler_id: INTEGER) is
		external
			"C signature (gpointer, gulong) use <gtk/gtk.h>"
		alias
			"g_signal_handler_disconnect"
		end
		
	frozen signal_disconnect_by_data (a_c_object: POINTER; data: INTEGER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"gtk_signal_disconnect_by_data"
		end

	frozen signal_handler_block (a_object: POINTER; a_handler_id: INTEGER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"gtk_signal_handler_block"
		end

	frozen signal_handler_unblock (a_object: POINTER; a_handler_id: INTEGER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"gtk_signal_handler_unblock"
		end

	frozen signal_emit_stop_by_name (a_object: POINTER; a_name: POINTER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"gtk_signal_emit_stop_by_name"
		end

	frozen gtk_editable_get_selection_bounds (a_editable: POINTER; a_start, a_end: TYPED_POINTER [INTEGER]): BOOLEAN is
		external
			"C signature (GtkEditable*, gint*, gint*): gboolean use <gtk/gtk.h>"
		end

	frozen gtk_style_set_font (a_c_struct: POINTER; a_font: POINTER) is
		external
			"C signature (GtkStyle*, GdkFont*) use <gtk/gtk.h>"
		end

	frozen gtk_style_get_font (a_c_struct: POINTER): POINTER is
		external
			"C signature (GtkStyle*): EIF_POINTER use <gtk/gtk.h>"
		end

	frozen gtk_paned_set_gutter_size (a_paned: POINTER; a_size: INTEGER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			" "
		end

	frozen gtk_paned_set_handle_size (a_paned: POINTER; a_size: INTEGER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			" "
		end

	frozen gtk_menu_bar_set_shadow_type (a_menu_bar: POINTER; a_type: INTEGER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			" "
		end

	frozen gtk_editable_get_editable (a_c_struct: POINTER): BOOLEAN is
		external
			"C signature (GtkEditable*): EIF_BOOLEAN use <gtk/gtk.h>"
		end
		
	frozen gtk_widget_set_default_visual (a_visual: POINTER) is
		external
			"C macro use <gtk/gtk.h>"
		end
	
	frozen object_destroy (a_c_object: POINTER) is
		external
			"C signature (GtkObject*) use <gtk/gtk.h>"
		alias
			"gtk_object_destroy"
		end

	frozen object_ref (a_c_object: POINTER) is
		external
			"C signature (gpointer) use <gtk/gtk.h>"
		alias
			"g_object_ref"
		end
		
	frozen object_unref (a_c_object: POINTER) is
		external
			"C signature (gpointer) use <gtk/gtk.h>"
		alias
			"g_object_unref"
		end

	frozen gtk_text_view_new: POINTER is
		external
			"C signature (): GtkWidget* use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_create_mark (a_text_buffer: POINTER; a_name: POINTER; a_text_iter: POINTER; left_gravity: BOOLEAN): POINTER is
		external
			"C signature (GtkTextBuffer*, gchar*, GtkTextIter*, gboolean): GtkTextMark* use <gtk/gtk.h>"
		end
	
	frozen gtk_text_buffer_delete_mark (a_text_buffer: POINTER; a_text_mark: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextMark*) use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_begin_user_action (a_text_buffer: POINTER) is
		external
			"C signature (GtkTextBuffer*) use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_end_user_action (a_text_buffer: POINTER) is
		external
			"C signature (GtkTextBuffer*) use <gtk/gtk.h>"
		end

	frozen gtk_text_view_get_buffer (a_text_view: POINTER): POINTER is
		external
			"C signature (GtkTextView*): GtkTextBuffer* use <gtk/gtk.h>"
		end

	frozen gtk_text_view_set_buffer (a_text_view: POINTER; a_text_buffer: POINTER) is
		external
			"C signature (GtkTextView*, GtkTextBuffer*) use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_set_text (a_text_buffer: POINTER; a_string: POINTER; a_length: INTEGER) is
		external
			"C signature (GtkTextBuffer*, gchar *, gint) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_insert_at_cursor (a_text_buffer: POINTER; a_string: POINTER; a_length: INTEGER) is
		external
			"C signature (GtkTextBuffer*, gchar *, gint) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_insert (a_text_buffer: POINTER; a_text_iter: POINTER; a_string: POINTER; a_length: INTEGER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, gchar *, gint) use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_insert_range (a_text_buffer: POINTER; a_text_iter: POINTER; a_start_iter: POINTER; a_end_iter: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*, GtkTextIter*) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_start_iter (a_text_buffer: POINTER; a_text_iter: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_end_iter (a_text_buffer: POINTER; a_text_iter: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*) use <gtk/gtk.h>"
		end
	
	frozen gtk_text_buffer_get_char_count (a_text_buffer: POINTER): INTEGER is
		external
			"C signature (GtkTextBuffer*): gint use <gtk/gtk.h>"
		end	
		
	frozen gtk_text_buffer_get_bounds (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*) use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_get_selection_bounds (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER): BOOLEAN is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*): gboolean use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_selection_bound (a_text_buffer: POINTER): POINTER is
		external
			"C signature (GtkTextBuffer*): GtkTextMark* use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_insert (a_text_buffer: POINTER): POINTER is
		external
			"C signature (GtkTextBuffer*): GtkTextMark* use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_move_mark (a_text_buffer: POINTER; a_text_mark: POINTER; a_text_iter: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextMark*, GtkTextIter*) use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_get_text (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER; inc_hid_chars: BOOLEAN): POINTER is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*, gboolean): gchar* use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_line_count (a_text_buffer: POINTER): INTEGER is
		external
			"C signature (GtkTextBuffer*): gint use <gtk/gtk.h>"
		end	
		
	frozen gtk_text_iter_get_text (a_start_iter: POINTER; a_end_iter: POINTER): POINTER is
		external
			"C signature (GtkTextIter*, GtkTextIter*): gchar* use <gtk/gtk.h>"
		end

	frozen gtk_text_iter_get_line (a_iter: POINTER): INTEGER is
		external
			"C signature (GtkTextIter*): gint use <gtk/gtk.h>"
		end

	frozen gtk_text_iter_ends_line (a_iter: POINTER): BOOLEAN is
		external
			"C signature (GtkTextIter*): gboolean use <gtk/gtk.h>"
		end

	frozen gtk_text_iter_set_line (a_iter: POINTER; a_line: INTEGER)is
		external
			"C signature (GtkTextIter*, gint) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_view_set_editable (a_text_view: POINTER; a_setting: BOOLEAN) is
		external
			"C signature (GtkTextView*, gboolean) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_view_get_editable (a_text_view: POINTER): BOOLEAN is
		external
			"C signature (GtkTextView*): gboolean use <gtk/gtk.h>"
		end

	frozen gtk_text_view_get_line_yrange (a_text_view: POINTER; a_text_iter: POINTER; a_y: POINTER; a_height: POINTER) is
		external
			"C signature (GtkTextView*, GtkTextIter*, gint*, gint*) use <gtk/gtk.h>"
		end	
		
	frozen gtk_text_view_set_wrap_mode (a_text_view: POINTER; a_wrap_mode: INTEGER) is
		external
			"C signature (GtkTextView*, GtkWrapMode) use <gtk/gtk.h>"
		end
	
	Gtk_wrap_none_enum: INTEGER is 0
	Gtk_wrap_char_enum: INTEGER is 1
	Gtk_wrap_word_enum: INTEGER is 2
	
	frozen gtk_text_tag_new (a_name: POINTER): POINTER is
		external
			"C signature (gchar*): GtkTextTag* use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_new (a_text_tag_table: POINTER): POINTER is
		external
			"C signature (GtkTextTagTable*): GtkTextBuffer* use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_apply_tag (a_buffer: POINTER; a_tag: POINTER; a_start: POINTER; a_end: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextTag*, GtkTextIter*, GtkTextIter*) use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_get_tag_table (a_buffer: POINTER): POINTER is
		external
			"C signature (GtkTextBuffer*): GtkTextTagTable* use <gtk/gtk.h>"
		end
		
	frozen gtk_text_tag_table_add (a_table: POINTER; a_tag: POINTER) is
		external
			"C signature (GtkTextTagTable*, GtkTextTag*) use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_remove_all_tags (a_buffer: POINTER; a_start: POINTER; a_end: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*) use <gtk/gtk.h>"
		end

	frozen gtk_text_buffer_get_iter_at_line (a_text_buffer: POINTER; a_text_iter: POINTER; a_line_number: INTEGER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, gint) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_iter_at_mark (a_text_buffer: POINTER; a_text_iter: POINTER; a_text_mark: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextMark*) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_get_iter_at_offset (a_text_buffer: POINTER; a_text_iter: POINTER; a_char_offset: INTEGER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, gint) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_delete_selection (a_text_buffer: POINTER; a_interactive: BOOLEAN; a_default_editable: BOOLEAN) is
		external
			"C signature (GtkTextBuffer*, gboolean, gboolean) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_delete (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*) use <gtk/gtk.h>"
		end
	
	frozen gtk_text_buffer_place_cursor (a_text_buffer: POINTER; a_text_iter: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkTextIter*) use <gtk/gtk.h>"
		end		
	
	frozen gtk_text_iter_forward_to_line_end (a_text_iter: POINTER) is
		external
			"C signature (GtkTextIter *) use <gtk/gtk.h>"
		end

	frozen gtk_text_iter_forward_line (a_text_iter: POINTER) is
		external
			"C signature (GtkTextIter *) use <gtk/gtk.h>"
		end

	frozen gtk_text_iter_backward_line (a_text_iter: POINTER) is
		external
			"C signature (GtkTextIter *) use <gtk/gtk.h>"
		end

	frozen gtk_text_iter_forward_char (a_text_iter: POINTER) is
		external
			"C signature (GtkTextIter *) use <gtk/gtk.h>"
		end

	frozen gtk_text_iter_backward_char (a_text_iter: POINTER) is
		external
			"C signature (GtkTextIter *) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_view_forward_display_line (a_text_view: POINTER; a_text_iter: POINTER): BOOLEAN is
		external
			"C signature (GtkTextView*, GtkTextIter*): gboolean use <gtk/gtk.h>"
		end

	frozen gtk_text_view_backward_display_line (a_text_view: POINTER; a_text_iter: POINTER): BOOLEAN is
		external
			"C signature (GtkTextView*, GtkTextIter*): gboolean use <gtk/gtk.h>"
		end
		
	frozen gtk_text_view_forward_display_line_end (a_text_view: POINTER; a_text_iter: POINTER): BOOLEAN is
		external
			"C signature (GtkTextView*, GtkTextIter*): gboolean use <gtk/gtk.h>"
		end
		
	frozen gtk_text_iter_get_offset (a_text_iter: POINTER): INTEGER is
		external
			"C signature (GtkTextIter*): gint use <gtk/gtk.h>"
		end
		
	frozen gtk_clipboard_get (a_atom: INTEGER): POINTER is
		external
			"C signature (GdkAtom): GtkClipboard* use <gtk/gtk.h>"
		end
		
	frozen gtk_clipboard_set_text (a_clipboard: POINTER; a_text: POINTER; a_length: INTEGER) is
		external
			"C signature (GtkClipboard*, gchar*, gint) use <gtk/gtk.h>"
		end
		
	frozen gtk_clipboard_wait_for_text (a_clipboard: POINTER): POINTER is
		external
			"C signature (GtkClipboard*): gchar* use <gtk/gtk.h>"
		end
		
	frozen gtk_clipboard_wait_is_text_available (a_clipboard: POINTER): BOOLEAN is
		external
			"C signature (GtkClipboard*): gboolean use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_cut_clipboard (a_text_buffer: POINTER; a_clipboard: POINTER; default_editable: BOOLEAN) is
		external
			"C signature (GtkTextBuffer*, GtkClipboard*, gboolean) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_copy_clipboard (a_text_buffer: POINTER; a_clipboard: POINTER) is
		external
			"C signature (GtkTextBuffer*, GtkClipboard*) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_buffer_paste_clipboard (a_text_buffer: POINTER; a_clipboard: POINTER; a_text_iter: POINTER; default_editable: BOOLEAN) is
		external
			"C signature (GtkTextBuffer*, GtkClipboard*, GtkTextIter*, gboolean) use <gtk/gtk.h>"
		end
		
	frozen gtk_text_view_scroll_to_iter (a_text_view: POINTER; a_text_iter: POINTER; within_margin: DOUBLE; use_align: BOOLEAN; xalign: DOUBLE; yalign: DOUBLE) is
		external
			"C signature (GtkTextView*, GtkTextIter*, gdouble, gboolean, gdouble, gdouble) use <gtk/gtk.h> "
		end
		
	frozen gtk_text_view_get_iter_location (a_text_view, a_text_iter, a_rectangle: POINTER) is
		external
			"C signature (GtkTextView*, GtkTextIter*, GdkRectangle*) use <gtk/gtk.h>"
		end

	frozen gtk_text_iter_copy (a_text_iter: POINTER): POINTER is
		external
			"C signature (GtkTextIter*): GtkTextIter* use <gtk/gtk.h>"
		end

	frozen gtk_image_set_from_pixmap (a_image: POINTER; a_pixmap: POINTER; a_mask: POINTER) is
		external
			"C signature (GtkImage*, GdkPixmap*, GdkBitmap*) use <gtk/gtk.h>"
		end
		
	frozen gtk_image_get_pixmap (a_image: POINTER; a_pixmap: POINTER; a_mask: POINTER) is
		external
			"C signature (GtkImage*, GdkPixmap**, GdkBitmap**) use <gtk/gtk.h>"
		end
		
	frozen gtk_image_new_from_pixmap (a_pixmap: POINTER; a_mask: POINTER): POINTER is
		external
			"C signature (GdkPixmap*, GdkBitmap*): GtkImage* use <gtk/gtk.h>"
		end

	frozen gtk_image_new: POINTER is
		external
			"C signature (): GtkImage* use <gtk/gtk.h>"
		end
		
	frozen gtk_dialog_new: POINTER is
		external	
			"C signature (): GtkWidget* use <gtk/gtk.h>"
		end
		
	frozen gtk_dialog_set_has_separator (a_dialog: POINTER; a_setting: BOOLEAN) is
		external
			"C signature (GtkDialog*, gboolean) use <gtk/gtk.h>"
		end
	
	frozen gtk_widget_modify_font (a_widget: POINTER; a_font_description: POINTER) is
		external
			"C signature (GtkWidget*, PangoFontDescription*) use <gtk/gtk.h>"
		end
		
end

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

