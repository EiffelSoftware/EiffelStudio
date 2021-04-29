note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	GTK

feature

	gtk_is_widget (obj: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"GTK_IS_WIDGET($obj)"
		end

	gtk_widget_set_hexpand (a_widget: POINTER; a_expand: BOOLEAN)
		external
			"C signature (GtkWidget*, gboolean) use <ev_gtk.h>"
		end

	gtk_widget_set_vexpand (a_widget: POINTER; a_expand: BOOLEAN)
		external
			"C signature (GtkWidget*, gboolean) use <ev_gtk.h>"
		end

	gtk_widget_get_hexpand (a_widget: POINTER): BOOLEAN
		external
			"C signature (GtkWidget*): gboolean use <ev_gtk.h>"
		end

	gtk_widget_get_vexpand (a_widget: POINTER): BOOLEAN
		external
			"C signature (GtkWidget*): gboolean use <ev_gtk.h>"
		end

	gtk_widget_set_hexpand_set (a_widget: POINTER; a_expand: BOOLEAN)
		external
			"C signature (GtkWidget*, gboolean) use <ev_gtk.h>"
		end

	gtk_widget_set_vexpand_set (a_widget: POINTER; a_expand: BOOLEAN)
		external
			"C signature (GtkWidget*, gboolean) use <ev_gtk.h>"
		end

	gtk_widget_get_hexpand_set (a_widget: POINTER): BOOLEAN
		external
			"C signature (GtkWidget*): gboolean use <ev_gtk.h>"
		end

	gtk_widget_get_vexpand_set (a_widget: POINTER): BOOLEAN
		external
			"C signature (GtkWidget*): gboolean use <ev_gtk.h>"
		end

	gtk_widget_compute_expand (a_widget: POINTER; a_orientation: INTEGER): BOOLEAN
		external
			"C signature (GtkWidget*, GtkOrientation): gboolean use <ev_gtk.h>"
		end

	gtk_widget_queue_compute_expand (a_widget: POINTER)
		external
			"C signature (GtkWidget*) use <ev_gtk.h>"
		end

	gtk_widget_get_display (a_widget: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gtk_widget_get_display ((GtkWidget *)$a_widget)"
		end

	gdk_window_create_similar_surface (a_window, a_content: POINTER; a_width, a_height: INTEGER): POINTER
		external
			"C signature (GdkWindow*, cairo_content_t, int, int): cairo_surface_t* use <ev_gtk.h>"
		end

	gtk_layout_new (a_hadjustment, a_vadjustment: POINTER): POINTER
		external
			"C signature (GtkAdjustment*, GtkAdjustment*): GtkWidget* use <ev_gtk.h>"
		end

	gtk_layout_put (a_layout, a_child: POINTER; a_x, a_y: INTEGER)
		external
			"C signature (GtkLayout*, GtkWidget*, gint, gint) use <ev_gtk.h>"
		end

	gtk_layout_move (a_layout, a_child: POINTER; a_x, a_y: INTEGER)
		external
			"C signature (GtkLayout*, GtkWidget*, gint, gint) use <ev_gtk.h>"
		end

	gtk_layout_set_size (a_layout: POINTER; a_x, a_y: NATURAL_32)
		external
			"C signature (GtkLayout*, guint, guint) use <ev_gtk.h>"
		end

	gtk_layout_get_size (a_layout: POINTER; a_x, a_y: TYPED_POINTER [NATURAL_32])
		external
			"C signature (GtkLayout*, guint*, guint*) use <ev_gtk.h>"
		end

	gtk_layout_get_bin_window (a_layout: POINTER): POINTER
		external
			"C signature (GtkLayout*): GdkWindow* use <ev_gtk.h>"
		end


--GtkWidget *         gtk_layout_new                      (GtkAdjustment *hadjustment,
--                                                         GtkAdjustment *vadjustment);
--
--
--
--void                gtk_layout_put                      (GtkLayout *layout,
--                                                         GtkWidget *child_widget,
--                                                         gint x,
--                                                         gint y);
--void                gtk_layout_move                     (GtkLayout *layout,
--                                                         GtkWidget *child_widget,
--                                                         gint x,
--                                                         gint y);
--void                gtk_layout_set_size                 (GtkLayout *layout,
--                                                         guint width,
--                                                         guint height);
--void                gtk_layout_get_size                 (GtkLayout *layout,
--                                                         guint *width,
--                                                         guint *height);
--GtkAdjustment *     gtk_layout_get_hadjustment          (GtkLayout *layout);
--GtkAdjustment *     gtk_layout_get_vadjustment          (GtkLayout *layout);
--void                gtk_layout_set_hadjustment          (GtkLayout *layout,
--                                                         GtkAdjustment *adjustment);
--void                gtk_layout_set_vadjustment          (GtkLayout *layout,
--                                                         GtkAdjustment *adjustment);
--GdkWindow *         gtk_layout_get_bin_window           (GtkLayout *layout);

	frozen gtk_progress_bar_new: POINTER
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		end

	frozen gtk_progress_bar_set_fraction (a_bar: POINTER; a_fraction: REAL_64)
		external
			"C signature (GtkProgressBar*, gdouble) use <ev_gtk.h>"
		end

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

	frozen gtk_cell_layout_get_cells (a_gtk_cell_layout: POINTER): POINTER
		external
			"C signature (GtkCellLayout*): GList* use <ev_gtk.h>"
		end

	frozen gtk_entry_get_buffer (a_entry: POINTER): POINTER
		external
			"C signature (GtkEntry*): GtkEntryBuffer* use <ev_gtk.h>"
		end

	frozen gtk_entry_buffer_get_text (a_entry_buffer: POINTER): POINTER
		external
			"C signature (GtkEntryBuffer*): gchar* use <ev_gtk.h>"
		end

	frozen gtk_entry_buffer_set_text (a_entry_buffer: POINTER; a_text: POINTER; a_num_chars: INTEGER)
		external
			"C signature (GtkEntryBuffer*, gchar*, gint) use <ev_gtk.h>"
		end

	frozen gtk_entry_buffer_insert_text (a_entry_buffer: POINTER; a_position: NATURAL_32; a_text: POINTER; a_num_chars: INTEGER)
		external
			"C signature (GtkEntryBuffer*, guint, gchar*, gint) use <ev_gtk.h>"
		end

	frozen gtk_entry_buffer_delete_text (a_entry_buffer: POINTER; a_position: NATURAL_32; a_num_chars: INTEGER)
		external
			"C signature (GtkEntryBuffer*, guint, gint) use <ev_gtk.h>"
		end

	frozen gtk_widget_set_size_request (a_widget: POINTER; a_width, a_height: INTEGER_32)
		external
			"C signature (GtkWidget*, gint, gint) use <ev_gtk.h>"
		end

	frozen g_source_remove (a_source_id: NATURAL_32)
		external
			"C signature (guint) use <ev_gtk.h>"
		end

	frozen null_pointer: POINTER
		external
			"C macro use <glib.h>"
		alias
			"NULL"
		end

	frozen g_module_supported: BOOLEAN
		external
			"C signature (): gboolean use <gmodule.h>"
		end

	frozen g_module_symbol (a_module, a_symbol_name: POINTER; a_symbol: TYPED_POINTER [POINTER]): BOOLEAN
		external
			"C signature (GModule*, gchar*, gpointer*): gboolean use <gmodule.h>"
		end

	frozen g_module_open (a_module_name: POINTER; a_flags: INTEGER_32): POINTER
		external
			"C signature (gchar*, GModuleFlags): GModule* use <gmodule.h>"
		end

	frozen g_module_close (a_module: POINTER): BOOLEAN
		external
			"C signature (GModule*): gboolean use <gmodule.h>"
		end

	frozen gtk_settings_get_default: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gtk_settings_get_default();"
		end

	frozen gdk_window_process_all_updates
		-- FIXME JV
		note
			eis: "name:gdk_window_process_all_updates", "src=https://developer.gnome.org/gdk3/stable/gdk3-Windows.html#gdk-window-process-all-updates"
		--obsolete
		--	"gdk_window_process_all_updates has been deprecated since version 3.22 and should not be used in newly-written code. [2021-06-01]"
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_window_process_all_updates();"
		end

	frozen gtk_window_set_skip_taskbar_hint (a_window: POINTER; a_setting: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_window_set_skip_taskbar_hint ((GtkWindow*) $a_window, (gboolean) $a_setting);"
		end

	frozen gtk_window_set_skip_pager_hint (a_window: POINTER; a_setting: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_window_set_skip_pager_hint ((GtkWindow*) $a_window, (gboolean) $a_setting);"
		end

	frozen gdk_colorspace_rgb_enum: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GDK_COLORSPACE_RGB;"
		end

	frozen gdk_pixbuf_get_from_window (a_window: POINTER; a_src_x, a_src_y, a_width, a_height: INTEGER): POINTER
		external
			"C signature (GdkWindow*, gint, gint, gint, gint): GdkPixbuf* use <ev_gtk.h>"
		end

	frozen gdk_pixbuf_get_from_surface (a_surface: POINTER; a_src_x, a_src_y, a_width, a_height: INTEGER): POINTER
		external
			"C signature (cairo_surface_t*, gint, gint, gint, gint): GdkPixbuf* use <ev_gtk.h>"
		end

	frozen gdk_pixbuf_get_pixels (a_pixbuf: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_pixbuf_get_pixels ((GdkPixbuf*) $a_pixbuf);"
		end

	frozen gdk_pixbuf_copy (a_pixbuf: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_pixbuf_copy ((GdkPixbuf*)$a_pixbuf);"
		end

	frozen gdk_pixbuf_get_width (a_pixbuf: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_pixbuf_get_width ((GdkPixbuf*)$a_pixbuf);"
		end

	frozen gdk_pixbuf_get_height (a_pixbuf: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_pixbuf_get_height ((GdkPixbuf*)$a_pixbuf);"
		end

	frozen gdk_pixbuf_get_rowstride (a_pixbuf: POINTER): NATURAL_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_pixbuf_get_rowstride ((GdkPixbuf*)$a_pixbuf);"
		end

	frozen gdk_pixbuf_get_n_channels (a_pixbuf: POINTER): NATURAL_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_pixbuf_get_n_channels ((GdkPixbuf*)$a_pixbuf);"
		end

	frozen gdk_pixbuf_get_bits_per_sample (a_pixbuf: POINTER): NATURAL_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_pixbuf_get_bits_per_sample ((GdkPixbuf*)$a_pixbuf);"
		end

	frozen gdk_pixbuf_new_from_file (a_filename: POINTER; a_error: TYPED_POINTER [POINTER]): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_pixbuf_new_from_file ((char*) $a_filename, (GError**) $a_error);"
		end

	frozen gdk_pixbuf_new_from_stream (a_input_stream: POINTER; a_cancellable: POINTER; a_error: TYPED_POINTER [POINTER]): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
					return gdk_pixbuf_new_from_stream ((GInputStream *)$a_input_stream, (GCancellable *)$a_cancellable, (GError **)$a_error);
			]"
		end
	frozen gdk_pixbuf_new_from_xpm_data (a_data: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_pixbuf_new_from_xpm_data ((const char**) $a_data);"
		end

	frozen gdk_pixbuf_save_to_buffer (a_pixbuf: POINTER; a_buffer: TYPED_POINTER[POINTER]; a_buffer_size: TYPED_POINTER[INTEGER]; a_type: POINTER; a_error: TYPED_POINTER [POINTER]): INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return (EIF_INTEGER)gdk_pixbuf_save_to_buffer ((GdkPixbuf *)$a_pixbuf,
                                                         (gchar **)$a_buffer,
                                                         (gsize *)$a_buffer_size,
                                                         (const char *)$a_type,
                                                         (GError **)$a_error,
                                                         NULL);
			]"
		end

	frozen gdk_pixbuf_new (a_colorspace: INTEGER_32; a_has_alpha: BOOLEAN; a_bits_per_sample, a_width, a_height: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_pixbuf_new ((GdkColorspace) $a_colorspace, (gboolean) $a_has_alpha, (int) $a_bits_per_sample, (int) $a_width, (int) $a_height);"
		end

	frozen gdk_pixbuf_new_subpixbuf (a_pixbuf: POINTER; src_x, src_y, width, height: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_pixbuf_new_subpixbuf ((GdkPixbuf*)$a_pixbuf, (int) $src_x, (int) $src_y, (int) $width, (int) $height);"
		end

	frozen gdk_pixbuf_fill (a_pixbuf: POINTER; rgba: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_pixbuf_fill ((GdkPixbuf*)$a_pixbuf, (guint32) $rgba);"
		end

	frozen gtk_win_pos_mouse_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_WIN_POS_MOUSE"
		end

	frozen gtk_maj_ver: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"gtk_major_version"
		end

	frozen gtk_min_ver: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"gtk_minor_version"
		end

	frozen gtk_mic_ver: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"gtk_micro_version"
		end

	frozen gtk_widget_is_sensitive (a_widget: POINTER): BOOLEAN
		external
			"C signature (GtkWidget*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_widget_get_sensitive (a_widget: POINTER): BOOLEAN
		external
			"C signature (GtkWidget*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_widget_get_visible (a_widget: POINTER): BOOLEAN
		external
			"C signature (GtkWidget*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_widget_is_focus (a_widget: POINTER): BOOLEAN
		external
			"C signature (GtkWidget*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_widget_has_focus (a_widget: POINTER): BOOLEAN
		external
			"C signature (GtkWidget*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_widget_get_has_window (a_wid: POINTER): BOOLEAN
		external
			"C signature (GtkWidget*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_widget_set_has_window (a_wid: POINTER; a_value: BOOLEAN)
		external
			"C signature (GtkWidget*, gboolean) use <ev_gtk.h>"
		end

	frozen c_gdk_rectangle_struct_size: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"sizeof(GdkRectangle)"
		end

	frozen c_gtk_requisition_struct_size: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"sizeof(GtkRequisition)"
		end

	frozen c_gtk_allocation_struct_size: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"sizeof(GtkAllocation)"
		end


	frozen c_gtk_allocation_struct_allocate: POINTER
		external
			"C [macro <stdlib.h>]"
		alias
			"calloc (sizeof(GtkAllocation), 1)"
		end

	frozen gtk_is_container (w: POINTER): BOOLEAN
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_IS_CONTAINER"
		end

	frozen gtk_is_window (w: POINTER): BOOLEAN
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_IS_WINDOW"
		end

	frozen gtk_is_menu (w: POINTER): BOOLEAN
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_IS_MENU"
		end

	frozen gdk_control_mask_enum: NATURAL_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_CONTROL_MASK"
		end

	frozen gdk_mod1_mask_enum: NATURAL_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_MOD1_MASK"
		end

	frozen gdk_shift_mask_enum: NATURAL_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_SHIFT_MASK"
		end

	frozen gdk_lock_mask_enum: NATURAL_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_LOCK_MASK"
		end

	frozen gdk_button_press_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON_PRESS"
		end

	frozen gdk_2button_press_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_2BUTTON_PRESS"
		end

	frozen gdk_3button_press_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_3BUTTON_PRESS"
		end

	frozen gdk_button_release_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON_RELEASE"
		end

	frozen gtk_state_flag_normal_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STATE_NORMAL"
		end

	frozen gtk_state_flag_prelight_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STATE_FLAG_PRELIGHT"
		end

	frozen gtk_state_flag_selected_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STATE_FLAG_SELECTED"
		end

	frozen gtk_state_flag_active_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STATE_FLAG_ACTIVE"
		end

	frozen gtk_state_flag_insensitive_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STATE_FLAG_INSENSITIVE"
		end

	frozen gtk_state_flag_inconsistent_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STATE_FLAG_INCONSISTENT"
		end

	frozen gtk_state_flag_focused_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STATE_FLAG_FOCUSED"
		end

	frozen gtk_justify_center_enum: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"GTK_JUSTIFY_CENTER"
		end

	frozen gtk_justify_left_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_JUSTIFY_LEFT"
		end

	frozen gtk_justify_right_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_JUSTIFY_RIGHT"
		end

	frozen gtk_justify_fill_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_JUSTIFY_FILL"
		end

	frozen gtk_shadow_none_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SHADOW_NONE"
		end

	frozen gtk_shadow_etched_in_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SHADOW_ETCHED_IN"
		end

	frozen gtk_shadow_etched_out_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SHADOW_ETCHED_OUT"
		end

	frozen gtk_shadow_in_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SHADOW_IN"
		end

	frozen gtk_shadow_out_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SHADOW_OUT"
		end

	frozen gdk_exposure_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_EXPOSURE_MASK"
		end

	frozen gdk_pointer_motion_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_POINTER_MOTION_MASK"
		end

	frozen gdk_pointer_motion_hint_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_POINTER_MOTION_HINT_MASK"
		end

	frozen gdk_button1_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON1_MASK"
		end

	frozen gdk_button2_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON2_MASK"
		end

	frozen gdk_button3_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON3_MASK"
		end

	frozen gdk_button_press_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON_PRESS_MASK"
		end

	frozen gdk_button_release_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON_RELEASE_MASK"
		end

	frozen gdk_button_motion_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON_MOTION_MASK"
		end

	frozen gdk_button1_motion_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON1_MOTION_MASK"
		end

	frozen gdk_button2_motion_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON2_MOTION_MASK"
		end

	frozen gdk_button3_motion_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON3_MOTION_MASK"
		end


	frozen gdk_key_press_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_KEY_PRESS"
		end

	frozen gdk_key_release_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_KEY_RELEASE"
		end

	frozen gdk_key_press_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_KEY_PRESS_MASK"
		end

	frozen gdk_key_release_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_KEY_RELEASE_MASK"
		end

	frozen gdk_enter_notify_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_ENTER_NOTIFY_MASK"
		end

	frozen gdk_leave_notify_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_LEAVE_NOTIFY_MASK"
		end

	frozen gdk_focus_change_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_FOCUS_CHANGE_MASK"
		end

	frozen gdk_visibility_notify_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_VISIBILITY_NOTIFY_MASK"
		end

	frozen gdk_structure_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_STRUCTURE_MASK"
		end

	frozen gdk_property_change_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_PROPERTY_CHANGE_MASK"
		end

	frozen gdk_proximity_in_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_PROXIMITY_IN_MASK"
		end

	frozen gdk_proximity_out_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_PROXIMITY_OUT_MASK"
		end

	frozen gdk_substructure_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_SUBSTRUCTURE_MASK"
		end

	frozen gdk_scroll_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_SCROLL_MASK"
		end

	frozen gdk_touch_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_TOUCH_MASK"
		end

	frozen gdk_smooth_scroll_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_SMOOTH_SCROLL_MASK"
		end

	frozen gdk_touchpad_gesture_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_TOUCHPAD_GESTURE_MASK"
		end

	frozen gtk_window_toplevel_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_WINDOW_TOPLEVEL"
		end

	frozen gdk_decor_all_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_DECOR_ALL"
		end

	frozen gdk_decor_border_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_DECOR_BORDER"
		end

	frozen gdk_hint_max_size_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_HINT_MAX_SIZE"
		end

	frozen gdk_hint_min_size_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_HINT_MIN_SIZE"
		end

	frozen gtk_win_pos_center_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_WIN_POS_CENTER"
		end

	frozen gtk_win_pos_none_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_WIN_POS_NONE"
		end

	frozen gdk_func_close_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_FUNC_CLOSE"
		end

	frozen gdk_func_move_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_FUNC_MOVE"
		end

	frozen gdk_func_resize_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_FUNC_RESIZE"
		end

	frozen gdk_func_minimize_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_FUNC_MINIMIZE"
		end

	frozen gdk_func_maximize_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_FUNC_MAXIMIZE"
		end

	frozen gdk_func_all_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_FUNC_ALL"
		end

	frozen gtk_policy_automatic_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_POLICY_AUTOMATIC"
		end

	frozen gtk_policy_always_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_POLICY_ALWAYS"
		end

	frozen gtk_policy_never_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_POLICY_NEVER"
		end

	frozen gtk_corner_top_left_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_CORNER_TOP_LEFT"
		end

	frozen gtk_selection_browse_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SELECTION_BROWSE"
		end

	frozen gtk_selection_single_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SELECTION_SINGLE"
		end

	frozen gtk_selection_multiple_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SELECTION_MULTIPLE"
		end

	frozen gdk_ownership_none_enum: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GDK_OWNERSHIP_NONE;"
		end

	frozen gdk_ownership_window_enum: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GDK_OWNERSHIP_WINDOW;"
		end

	frozen gdk_ownership_application_enum: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GDK_OWNERSHIP_APPLICATION;"
		end

	frozen g_free (a_mem: POINTER)
		external
			"C (gpointer) | <ev_gtk.h>"
		end

	frozen g_list_append (a_list: POINTER; a_data: POINTER): POINTER
		external
			"C (GList*, gpointer): GList* | <ev_gtk.h>"
		end

	frozen g_list_free (a_list: POINTER)
		external
			"C (GList*) | <ev_gtk.h>"
		end

	frozen g_list_index (a_list: POINTER; a_data: POINTER): INTEGER_32
		external
			"C (GList*, gpointer): gint | <ev_gtk.h>"
		end

	frozen g_list_insert (a_list: POINTER; a_data: POINTER; a_position: INTEGER_32): POINTER
		external
			"C (GList*, gpointer, gint): GList* | <ev_gtk.h>"
		end

	frozen g_list_length (a_list: POINTER): INTEGER_32
		external
			"C (GList*): guint | <ev_gtk.h>"
		end

	frozen g_list_nth (a_list: POINTER; a_n: INTEGER_32): POINTER
		external
			"C (GList*, guint): GList* | <ev_gtk.h>"
		end

	frozen g_list_nth_data (a_list: POINTER; a_n: INTEGER_32): POINTER
		external
			"C (GList*, guint): gpointer | <ev_gtk.h>"
		end

	frozen g_list_remove (a_list: POINTER; a_data: POINTER): POINTER
		external
			"C (GList*, gpointer): GList* | <ev_gtk.h>"
		end

	frozen g_malloc (a_size: INTEGER_32): POINTER
		external
			"C (gulong): gpointer | <ev_gtk.h>"
		end

	frozen g_realloc (a_mem: POINTER; a_size: INTEGER_32): POINTER
		external
			"C (gpointer, gulong): gpointer | <ev_gtk.h>"
		end

	frozen g_slist_free (a_list: POINTER)
		external
			"C (GSList*) | <ev_gtk.h>"
		end

	frozen g_slist_index (a_list: POINTER; a_data: POINTER): INTEGER_32
		external
			"C (GSList*, gpointer): gint | <ev_gtk.h>"
		end

	frozen g_slist_length (a_list: POINTER): INTEGER_32
		external
			"C (GSList*): guint | <ev_gtk.h>"
		end

	frozen g_slist_nth_data (a_list: POINTER; a_n: INTEGER_32): POINTER
		external
			"C (GSList*, guint): gpointer | <ev_gtk.h>"
		end

	frozen gdk_beep
		obsolete
			"gdk_beep is deprecated: Use 'gdk_display_beep' instead [2021-06-01]"
		external
			"C () | <ev_gtk.h>"
		end

	frozen gdk_display_beep (display: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_display_beep ((GdkDisplay *)$display)"
		end

	frozen gdk_atom_intern (a_atom_name: POINTER; a_only_if_exists: INTEGER_32): POINTER
		external
			"C (gchar*, gint): GdkAtom | <ev_gtk.h>"
		end

	frozen gdk_atom_name (a_atom: POINTER): POINTER
		external
			"C (GdkAtom): gchar* | <ev_gtk.h>"
		end

	frozen gdk_cursor_new_for_display (a_display: POINTER; a_cursor_type: INTEGER_32): POINTER
		external
			"C (GdkDisplay *, GdkCursorType): GdkCursor* | <ev_gtk.h>"
		end

	frozen gdk_selection_property_get (a_window: POINTER; a_data: TYPED_POINTER [POINTER]; a_target: POINTER; prop_type: TYPED_POINTER [INTEGER_32]): INTEGER_32
		external
			"C signature (GdkWindow*, guchar**, GdkAtom*, gint*): gint use <ev_gtk.h>"
		end

	frozen gdk_drag_get_selection (a_context: POINTER): POINTER
		external
			"C (GdkDragContext*): GdkAtom | <ev_gtk.h>"
		end

	frozen gdk_drag_context_get_source_window (a_drag_context: POINTER): POINTER
		external
			"C signature (GdkDragContext*): GdkWindow* use <ev_gtk.h>"
		end

	frozen gdk_drag_context_get_dest_window (a_drag_context: POINTER): POINTER
		external
			"C signature (GdkDragContext*): GdkWindow* use <ev_gtk.h>"
		end

	frozen gdk_drag_context_list_targets (a_drag_context: POINTER): POINTER
		external
			"C signature (GdkDragContext*): GList* use <ev_gtk.h>"
		end

	frozen gdk_selection_convert (a_requestor, a_selection, a_target: POINTER; a_time: NATURAL_32)
		external
			"C signature (GdkWindow*, GdkAtom, GdkAtom, guint32) use <ev_gtk.h>"
		end

	frozen gdk_drop_finish (a_context: POINTER; a_success: BOOLEAN; a_time: NATURAL_32)
		external
			"C (GdkDragContext*, gboolean, guint32) | <ev_gtk.h>"
		end

	frozen gtk_drag_finish (a_context: POINTER; a_success: BOOLEAN; del: BOOLEAN; a_time: NATURAL_32)
		external
			"C (GdkDragContext*, gboolean, gboolean, guint32) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_error_trap_pop: INTEGER_32
		obsolete
			"gdk_error_trap_pop is deprecated: Use 'gdk_x11_display_error_trap_pop' instead [2021-06-01]"
		external
			"C (): gint | <ev_gtk.h>"
		end

	frozen gdk_error_trap_push
		obsolete
			"gdk_error_trap_push is deprecated: Use 'gdk_x11_display_error_trap_push' instead [2021-06-01]"
		external
			"C () | <ev_gtk.h>"
		end

	frozen gdk_event_free (a_event: POINTER)
		external
			"C (GdkEvent*) | <ev_gtk.h>"
		end

	frozen gdk_event_get: POINTER
		external
			"C (): GdkEvent* | <ev_gtk.h>"
		end

	frozen gdk_events_pending: BOOLEAN
		external
			"C (): gboolean | <ev_gtk.h>"
		end

	frozen gdk_flush
		obsolete
			"gdk_flush is deprecated: Use 'gdk_display_flush instead [2021-06-01]"
		external
			"C () | <ev_gtk.h>"
		end

	frozen gtk_get_current_event_device: POINTER
		external
			"C signature (): GtkDevice * use <ev_gtk.h>"
		end

	frozen gdk_seat_grab (seat, window: POINTER; capabilities: INTEGER_32; owner_events: BOOLEAN; cursor, event, func, data: POINTER): INTEGER_32
		external
			"C signature (GdkSeat *, GdkWindow *, GdkSeatCapabilities, gboolean, GdkCursor *, const GdkEvent *, GdkSeatGrabPrepareFunc, gpointer): GdkGrabStatus use <ev_gtk.h>"
		end

	frozen gdk_seat_ungrab (seat: POINTER)
		external
			"C signature (GdkSeat *) use <ev_gtk.h>"
		end

	frozen gdk_keyval_from_name (a_keyval_name: POINTER): INTEGER_32
		external
			"C (gchar*): guint | <ev_gtk.h>"
		end

	frozen gdk_keyval_is_lower (a_keyval: NATURAL_32): BOOLEAN
		external
			"C (guint): gboolean | <ev_gtk.h>"
		end

	frozen gdk_keyval_is_upper (a_keyval: NATURAL_32): BOOLEAN
		external
			"C (guint): gboolean | <ev_gtk.h>"
		end

	frozen gdk_keyval_name (a_keyval: NATURAL_32): POINTER
		external
			"C (guint): gchar* | <ev_gtk.h>"
		end

	frozen gdk_keyval_to_lower (a_keyval: NATURAL_32): NATURAL_32
		external
			"C (guint): guint | <ev_gtk.h>"
		end

	frozen gdk_keyval_to_upper (a_keyval: NATURAL_32): NATURAL_32
		external
			"C (guint): guint | <ev_gtk.h>"
		end

	frozen gdk_screen_height: INTEGER_32
		obsolete
			"gdk_screen_height is deprecated [2021-06-01]"
		external
			"C (): gint | <ev_gtk.h>"
		end

	frozen gdk_screen_width: INTEGER_32
		obsolete
			"gdk_screen_width is deprecated [2021-06-01]"
		external
			"C (): gint | <ev_gtk.h>"
		end

	frozen gdk_set_show_events (a_show_events: BOOLEAN)
		external
			"C (gboolean) | <ev_gtk.h>"
		end

	frozen gdk_window_get_origin (a_window: POINTER; a_x: POINTER; a_y: POINTER): INTEGER_32
		external
			"C (GdkWindow*, gint*, gint*): gint | <ev_gtk.h>"
		end

	frozen gdk_window_get_user_data (a_window: POINTER; a_data: TYPED_POINTER [POINTER])
		external
			"C (GdkWindow*, gpointer*) | <ev_gtk.h>"
		end

	frozen gdk_window_hide (a_window: POINTER)
		external
			"C (GdkWindow*) | <ev_gtk.h>"
		end

	frozen gdk_window_lower (a_window: POINTER)
		external
			"C (GdkWindow*) | <ev_gtk.h>"
		end

	frozen gdk_window_move (a_window: POINTER; a_x: INTEGER_32; a_y: INTEGER_32)
		external
			"C (GdkWindow*, gint, gint) | <ev_gtk.h>"
		end

	frozen gdk_window_new (a_parent: POINTER; a_attributes: POINTER; a_attributes_mask: INTEGER_32): POINTER
		external
			"C (GdkWindow*, GdkWindowAttr*, gint): GdkWindow* | <ev_gtk.h>"
		end

	frozen gdk_window_raise (a_window: POINTER)
		external
			"C (GdkWindow*) | <ev_gtk.h>"
		end

	frozen gdk_window_set_cursor (a_window: POINTER; a_cursor: POINTER)
		external
			"C (GdkWindow*, GdkCursor*) | <ev_gtk.h>"
		end

	frozen gdk_window_set_decorations (a_window: POINTER; a_decorations: INTEGER_32)
		external
			"C (GdkWindow*, GdkWMDecoration) | <ev_gtk.h>"
		end

	frozen gdk_window_set_events (a_window: POINTER; a_event_mask: INTEGER_32)
		external
			"C (GdkWindow*, GdkEventMask) | <ev_gtk.h>"
		end

	frozen gdk_window_set_functions (a_window: POINTER; a_functions: INTEGER_32)
		external
			"C (GdkWindow*, GdkWMFunction) | <ev_gtk.h>"
		end

	frozen gdk_window_set_geometry_hints (a_window: POINTER; a_geometry: POINTER; a_flags: INTEGER_32)
		external
			"C (GdkWindow*, GdkGeometry*, GdkWindowHints) | <ev_gtk.h>"
		end

	frozen gdk_window_set_icon_name (a_window: POINTER; a_name: POINTER)
		external
			"C (GdkWindow*, gchar*) | <ev_gtk.h>"
		end

	frozen gdk_window_set_override_redirect (a_window: POINTER; a_override_redirect: BOOLEAN)
		external
			"C (GdkWindow*, gboolean) | <ev_gtk.h>"
		end

	frozen gdk_window_set_title (a_window: POINTER; a_title: POINTER)
		external
			"C (GdkWindow*, gchar*) | <ev_gtk.h>"
		end

	frozen gdk_window_set_transient_for (a_window: POINTER; a_leader: POINTER)
		external
			"C (GdkWindow*, GdkWindow*) | <ev_gtk.h>"
		end

	frozen gtk_window_set_accept_focus (a_window: POINTER; a_accept: BOOLEAN)
		external
			"C (GtkWindow*, gboolean) | <ev_gtk.h>"
		end



	frozen gtk_adjustment_changed (a_adjustment: POINTER)
		obsolete
			"gtk_adjustment_changed is deprecated [2021-06-01]"
		external
			"C (GtkAdjustment*) | <ev_gtk.h>"
		end

	frozen gtk_adjustment_new (a_value: REAL_32; a_lower: REAL_32; a_upper: REAL_32; a_step_increment: REAL_32; a_page_increment: REAL_32; a_page_size: REAL_32): POINTER
		external
			"C (gfloat, gfloat, gfloat, gfloat, gfloat, gfloat): GtkAdjustment* | <ev_gtk.h>"
		end

	frozen gtk_adjustment_set_value (a_adjustment: POINTER; a_value: REAL_32)
		external
			"C (GtkAdjustment*, gfloat) | <ev_gtk.h>"
		end

	frozen gtk_adjustment_value_changed (a_adjustment: POINTER)
		obsolete
			"gtk_adjustment_value_changed is deprecated. GTK+ emits “value-changed” itself whenever the value changes. [2021-06-01] "
		external
			"C (GtkAdjustment*) | <ev_gtk.h>"
		end

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

	frozen gtk_box_pack_end (a_box: POINTER; a_child: POINTER; a_expand: BOOLEAN; a_fill: BOOLEAN; a_padding: INTEGER_32)
		external
			"C (GtkBox*, GtkWidget*, gboolean, gboolean, guint) | <ev_gtk.h>"
		end

	frozen gtk_box_pack_start (a_box: POINTER; a_child: POINTER; a_expand: BOOLEAN; a_fill: BOOLEAN; a_padding: INTEGER_32)
		external
			"C (GtkBox*, GtkWidget*, gboolean, gboolean, guint) | <ev_gtk.h>"
		end

	frozen gtk_box_query_child_packing (a_box: POINTER; a_child: POINTER; a_expand: POINTER; a_fill: POINTER; a_padding: POINTER; a_pack_type: POINTER)
		external
			"C (GtkBox*, GtkWidget*, gboolean*, gboolean*, guint*, GtkPackType*) | <ev_gtk.h>"
		end

	frozen gtk_box_reorder_child (a_box: POINTER; a_child: POINTER; a_position: INTEGER_32)
		external
			"C (GtkBox*, GtkWidget*, gint) | <ev_gtk.h>"
		end

	frozen gtk_box_set_child_packing (a_box: POINTER; a_child: POINTER; a_expand: BOOLEAN; a_fill: BOOLEAN; a_padding: INTEGER_32; a_pack_type: INTEGER_32)
		external
			"C (GtkBox*, GtkWidget*, gboolean, gboolean, guint, GtkPackType) | <ev_gtk.h>"
		end

	frozen gtk_box_set_homogeneous (a_box: POINTER; a_homogeneous: BOOLEAN)
		external
			"C (GtkBox*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_box_set_spacing (a_box: POINTER; a_spacing: INTEGER_32)
		external
			"C (GtkBox*, gint) | <ev_gtk.h>"
		end

	frozen gtk_button_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_check_button_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_check_menu_item_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_check_menu_item_set_active (a_check_menu_item: POINTER; a_is_active: BOOLEAN)
		external
			"C (GtkCheckMenuItem*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_check_menu_item_set_draw_as_radio (a_menu_item: POINTER; a_always: BOOLEAN)
		external
			"C (GtkCheckMenuItem*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_color_chooser_dialog_new (a_title, a_parent: POINTER): POINTER
		external
			"C (gchar*, GtkWindow*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_container_add (a_container: POINTER; a_widget: POINTER)
		external
			"C (GtkContainer*, GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_container_check_resize (a_container: POINTER)
		external
			"C (GtkContainer*) | <ev_gtk.h>"
		end

	frozen gtk_container_resize_children (a_container: POINTER)
		obsolete
			"gtk_container_resize_children is deprecated [2021-06-01]"
		external
			"C (GtkContainer*) | <ev_gtk.h>"
		end

	frozen gtk_container_get_children (a_container: POINTER): POINTER
		external
			"C (GtkContainer*): GList* | <ev_gtk.h>"
		end

	frozen gtk_container_remove (a_container: POINTER; a_widget: POINTER)
		external
			"C (GtkContainer*, GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_container_set_border_width (a_container: POINTER; a_border_width: INTEGER_32)
		external
			"C (GtkContainer*, guint) | <ev_gtk.h>"
		end

	frozen gtk_drawing_area_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_editable_copy_clipboard (a_editable: POINTER)
		external
			"C (GtkEditable*) | <ev_gtk.h>"
		end

	frozen gtk_editable_cut_clipboard (a_editable: POINTER)
		external
			"C (GtkEditable*) | <ev_gtk.h>"
		end

	frozen gtk_editable_delete_selection (a_editable: POINTER)
		external
			"C (GtkEditable*) | <ev_gtk.h>"
		end

	frozen gtk_editable_get_position (a_editable: POINTER): INTEGER_32
		external
			"C (GtkEditable*): gint | <ev_gtk.h>"
		end

	frozen gtk_range_get_adjustment (a_editable: POINTER): POINTER
		external
			"C (GtkRange*): GtkAdjustment* | <ev_gtk.h>"
		end

	frozen gtk_editable_insert_text (a_editable: POINTER; a_new_text: POINTER; a_new_text_length: INTEGER_32; a_position: POINTER)
		external
			"C (GtkEditable*, gchar*, gint, gint*) | <ev_gtk.h>"
		end

	frozen gtk_editable_select_region (a_editable: POINTER; a_start: INTEGER_32; a_end: INTEGER_32)
		external
			"C (GtkEditable*, gint, gint) | <ev_gtk.h>"
		end

	frozen gtk_editable_set_editable (a_editable: POINTER; a_is_editable: BOOLEAN)
		external
			"C (GtkEditable*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_editable_set_position (a_editable: POINTER; a_position: INTEGER_32)
		external
			"C (GtkEditable*, gint) | <ev_gtk.h>"
		end


	frozen gtk_entry_get_text (a_entry: POINTER): POINTER
		external
			"C (GtkEntry*): gchar* | <ev_gtk.h>"
		end

	frozen gtk_entry_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_entry_set_text (a_entry: POINTER; a_text: POINTER)
		external
			"C (GtkEntry*, gchar*) | <ev_gtk.h>"
		end

	frozen gtk_entry_set_width_chars (a_entry: POINTER; n_chars: INTEGER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gtk_entry_set_width_chars ((GtkEntry *)$a_entry,
			                           (gint)$n_chars);

			]"
		end


	frozen gtk_entry_set_visibility (a_entry: POINTER; a_visible: BOOLEAN)
		external
			"C (GtkEntry*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_event_box_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_is_event_box (a_object: POINTER): BOOLEAN
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_IS_EVENT_BOX"
		end

	frozen gtk_font_chooser_get_font_desc (a_fc: POINTER): POINTER
		external
			"C (GtkFontChooser*): PangoFontDescription* | <ev_gtk.h>"
		end

	frozen gtk_font_chooser_dialog_new (a_title, a_parent: POINTER): POINTER
		external
			"C (gchar*, GtkWindow*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_font_chooser_set_font_desc (a_fc: POINTER; a_fontdesc: POINTER)
		external
			"C (GtkFontChooser*, PangoFontDescription*) | <ev_gtk.h>"
		end

	frozen gtk_font_chooser_get_font (a_fc: POINTER): POINTER
		external
			"C (GtkFontChooser*): gchar* | <ev_gtk.h>"
		end

	frozen gtk_frame_new (a_label: POINTER): POINTER
		external
			"C (gchar*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_frame_set_label (a_frame: POINTER; a_label: POINTER)
		external
			"C (GtkFrame*, gchar*) | <ev_gtk.h>"
		end

	frozen gtk_frame_set_label_align (a_frame: POINTER; a_xalign: REAL_32; a_yalign: REAL_32)
		external
			"C (GtkFrame*, gfloat, gfloat) | <ev_gtk.h>"
		end

	frozen gtk_frame_set_shadow_type (a_frame: POINTER; a_type: INTEGER_32)
		external
			"C (GtkFrame*, GtkShadowType) | <ev_gtk.h>"
		end

	frozen gtk_frame_get_shadow_type (a_frame: POINTER): INTEGER_32
		external
			"C (GtkFrame*): GtkShadowType) | <ev_gtk.h>"
		end

	frozen gtk_get_event_widget (a_event: POINTER): POINTER
		external
			"C (GdkEvent*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_grab_add (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_grab_get_current: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_grab_remove (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_hbox_new (a_homogeneous: BOOLEAN; a_spacing: INTEGER_32): POINTER
		obsolete
			"gtk_hbox_new’ is deprecated: Use 'gtk_box_new' instead [2021-06-01]"
		external
			"C (gboolean, gint): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_box_new (a_orientation: INTEGER; a_spacing: INTEGER_32): POINTER
		external
			"C (GtkOrientation, gint): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_paned_new (a_orientation: NATURAL_8): POINTER
		external
			"C (GtkOrientation): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_scrollbar_new (a_orientation: NATURAL_8; a_adjustment: POINTER): POINTER
		external
			"C (GtkOrientation, GtkAdjustment*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_label_new (a_str: POINTER): POINTER
		external
			"C (gchar*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_label_set_justify (a_label: POINTER; a_jtype: INTEGER_32)
		external
			"C (GtkLabel*, GtkJustification) | <ev_gtk.h>"
		end

	frozen gtk_label_set_text (a_label: POINTER; a_str: POINTER)
		external
			"C (GtkLabel*, gchar*) | <ev_gtk.h>"
		end

	frozen gtk_label_set_xalign (a_label: POINTER; a_real: REAL_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_label_set_xalign ((GtkLabel*) $a_label, (gfloat) $a_real)"
		end

	frozen gtk_label_set_yalign (a_label: POINTER; a_real: REAL_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_label_set_yalign ((GtkLabel*) $a_label, (gfloat) $a_real)"
		end

	frozen gtk_main_do_event (a_event: POINTER)
		external
			"C (GdkEvent*) | <ev_gtk.h>"
		end

	frozen gtk_menu_bar_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_menu_item_activate (a_menu_item: POINTER)
		external
			"C (GtkMenuItem*) | <ev_gtk.h>"
		end

	frozen gtk_menu_item_deselect (a_menu_item: POINTER)
		external
			"C (GtkMenuItem*) | <ev_gtk.h>"
		end

	frozen gtk_menu_item_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_menu_item_select (a_menu_item: POINTER)
		external
			"C (GtkMenuItem*) | <ev_gtk.h>"
		end

	frozen gtk_menu_item_set_submenu (a_menu_item: POINTER; a_submenu: POINTER)
		external
			"C (GtkMenuItem*, GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_menu_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_menu_popup (a_menu: POINTER; a_parent_menu_shell: POINTER; a_parent_menu_item: POINTER; a_func: POINTER; a_data: POINTER; a_button: INTEGER_32; a_activate_time: INTEGER_32)
		obsolete
			"gtk_menu_popup’ is deprecated: Use '(gtk_menu_popup_at_widget, gtk_menu_popup_at_pointer, gtk_menu_popup_at_rect)' instead [2021-06-01]"
		external
			"C (GtkMenu*, GtkWidget*, GtkWidget*, GtkMenuPositionFunc, gpointer, guint, guint32) | <ev_gtk.h>"
		end

	frozen gtk_menu_shell_cancel (a_menu_shell: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_menu_shell_cancel((GtkMenuShell*)$a_menu_shell);"
		end

	frozen gtk_menu_shell_deactivate (a_menu_shell: POINTER)
		external
			"C (GtkMenuShell*) | <ev_gtk.h>"
		end

	frozen gtk_menu_shell_deselect (a_menu_shell: POINTER)
		external
			"C (GtkMenuShell*) | <ev_gtk.h>"
		end

	frozen gtk_menu_shell_insert (a_menu_shell: POINTER; a_child: POINTER; a_position: INTEGER_32)
		external
			"C (GtkMenuShell*, GtkWidget*, gint) | <ev_gtk.h>"
		end

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

	frozen gtk_notebook_get_current_page (a_notebook: POINTER): INTEGER_32
		external
			"C (GtkNotebook*): gint | <ev_gtk.h>"
		end

	frozen gtk_notebook_get_nth_page (a_notebook: POINTER; a_page_num: INTEGER_32): POINTER
		external
			"C (GtkNotebook*, gint): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_notebook_get_tab_label (a_notebook: POINTER; a_child: POINTER): POINTER
		external
			"C (GtkNotebook*, GtkWidget*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_notebook_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_notebook_page_num (a_notebook: POINTER; a_child: POINTER): INTEGER_32
		external
			"C (GtkNotebook*, GtkWidget*): gint | <ev_gtk.h>"
		end

	frozen gtk_notebook_reorder_child (a_notebook: POINTER; a_child: POINTER; a_position: INTEGER_32)
		external
			"C (GtkNotebook*, GtkWidget*, gint) | <ev_gtk.h>"
		end

	frozen gtk_notebook_set_current_page (a_notebook: POINTER; a_page_num: INTEGER_32)
		external
			"C (GtkNotebook*, gint) | <ev_gtk.h>"
		end

	frozen gtk_notebook_set_scrollable (a_notebook: POINTER; a_scrollable: BOOLEAN)
		external
			"C (GtkNotebook*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_notebook_set_show_border (a_notebook: POINTER; a_show_border: BOOLEAN)
		external
			"C (GtkNotebook*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_notebook_set_tab_label (a_notebook: POINTER; a_child: POINTER; a_tab_label: POINTER)
		external
			"C (GtkNotebook*, GtkWidget*, GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_notebook_set_tab_pos (a_notebook: POINTER; a_pos: INTEGER_32)
		external
			"C (GtkNotebook*, GtkPositionType) | <ev_gtk.h>"
		end

	frozen g_object_ref_sink (a_object: POINTER): POINTER
		external
			"C (gpointer): gpointer | <ev_gtk.h>"
		end

	frozen gtk_paned_pack1 (a_paned: POINTER; a_child: POINTER; a_resize: BOOLEAN; a_shrink: BOOLEAN)
		external
			"C (GtkPaned*, GtkWidget*, gboolean, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_paned_pack2 (a_paned: POINTER; a_child: POINTER; a_resize: BOOLEAN; a_shrink: BOOLEAN)
		external
			"C (GtkPaned*, GtkWidget*, gboolean, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_paned_set_position (a_paned: POINTER; a_position: INTEGER_32)
		external
			"C (GtkPaned*, gint) | <ev_gtk.h>"
		end

	frozen gtk_paned_get_position (a_paned: POINTER): INTEGER_32
		external
			"C (GtkPaned*): gint | <ev_gtk.h>"
		end

	frozen gtk_propagate_event (a_widget: POINTER; a_event: POINTER)
		external
			"C (GtkWidget*, GdkEvent*) | <ev_gtk.h>"
		end

	frozen gtk_radio_button_get_group (a_radio_button: POINTER): POINTER
		external
			"C (GtkRadioButton*): GSList* | <ev_gtk.h>"
		end

	frozen gtk_radio_button_new (a_group: POINTER): POINTER
		external
			"C (GSList*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_radio_button_set_group (a_radio_button: POINTER; a_group: POINTER)
		external
			"C (GtkRadioButton*, GSList*) | <ev_gtk.h>"
		end

	frozen gtk_radio_menu_item_get_group (a_radio_menu_item: POINTER): POINTER
		external
			"C (GtkRadioMenuItem*): GSList* | <ev_gtk.h>"
		end

	frozen gtk_radio_menu_item_new (a_group: POINTER): POINTER
		external
			"C (GSList*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_radio_menu_item_new_with_label (a_group: POINTER; a_label: POINTER): POINTER
		external
			"C (GSList*, gchar*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_radio_menu_item_set_group (a_radio_menu_item: POINTER; a_group: POINTER)
		external
			"C (GtkRadioMenuItem*, GSList*) | <ev_gtk.h>"
		end

	frozen gtk_widget_get_style_context (a_widget: POINTER): POINTER
		external
			"C (GtkWidget*): GtkStyleContext* | <ev_gtk.h>"
		end

	frozen gtk_style_context_get_color (a_context: POINTER; a_state: INTEGER; a_color: POINTER)
		external
			"C signature (GtkStyleContext*, GtkStateFlags, GdkRGBA*) use <ev_gtk.h>"
		end

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

	frozen gtk_style_context_save (a_context: POINTER)
		external
			"C signature (GtkStyleContext*) use <ev_gtk.h>"
		end

	frozen gtk_style_context_restore (a_context: POINTER)
		external
			"C signature (GtkStyleContext*) use <ev_gtk.h>"
		end

	frozen gtk_style_context_set_state (a_context: POINTER; a_state: INTEGER)
		external
			"C signature (GtkStyleContext*, GtkStateFlags) use <ev_gtk.h>"
		end

	frozen gtk_style_context_get_state (a_context: POINTER): INTEGER
		external
			"C signature (GtkStyleContext*): GtkStateFlags use <ev_gtk.h>"
		end


	frozen gtk_scale_set_digits (a_scale: POINTER; a_digits: INTEGER_32)
		external
			"C (GtkScale*, gint) | <ev_gtk.h>"
		end

	frozen gtk_scale_set_draw_value (a_scale: POINTER; a_draw_value: BOOLEAN)
		external
			"C (GtkScale*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_scrollable_get_hadjustment (a_scrollable: POINTER): POINTER
		external
			"C (GtkScrollable*): GtkAdjustment* | <ev_gtk.h>"
		end

	frozen gtk_scrollable_get_vadjustment (a_scrollable: POINTER): POINTER
		external
			"C (GtkScrollable*): GtkAdjustment* | <ev_gtk.h>"
		end

	frozen gtk_scrolled_window_get_hadjustment (a_scrolled_window: POINTER): POINTER
		external
			"C (GtkScrolledWindow*): GtkAdjustment* | <ev_gtk.h>"
		end

	frozen gtk_scrolled_window_get_vadjustment (a_scrolled_window: POINTER): POINTER
		external
			"C (GtkScrolledWindow*): GtkAdjustment* | <ev_gtk.h>"
		end

	frozen gtk_scrolled_window_new (a_hadjustment: POINTER; a_vadjustment: POINTER): POINTER
		external
			"C (GtkAdjustment*, GtkAdjustment*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_scrolled_window_set_policy (a_scrolled_window: POINTER; a_hscrollbar_policy: INTEGER_32; a_vscrollbar_policy: INTEGER_32)
		external
			"C (GtkScrolledWindow*, GtkPolicyType, GtkPolicyType) | <ev_gtk.h>"
		end

	frozen gtk_spin_button_new (a_adjustment: POINTER; a_climb_rate: REAL_32; a_digits: INTEGER_32): POINTER
		external
			"C (GtkAdjustment*, gfloat, guint): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_spin_button_update (a_spin_button: POINTER)
		external
			"C (GtkSpinButton*) | <ev_gtk.h>"
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

	frozen gtk_toggle_button_get_active (a_toggle_button: POINTER): BOOLEAN
		external
			"C (GtkToggleButton*): gboolean | <ev_gtk.h>"
		end

	frozen gtk_toggle_button_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_toggle_button_set_active (a_toggle_button: POINTER; a_is_active: BOOLEAN)
		external
			"C (GtkToggleButton*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_vbox_new (a_homogeneous: BOOLEAN; a_spacing: INTEGER_32): POINTER
		external
			"C (gboolean, gint): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_viewport_new (a_hadjustment: POINTER; a_vadjustment: POINTER): POINTER
		external
			"C (GtkAdjustment*, GtkAdjustment*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_viewport_set_shadow_type (a_viewport: POINTER; a_type: INTEGER_32)
		external
			"C (GtkViewport*, GtkShadowType) | <ev_gtk.h>"
		end

	frozen gtk_scale_new (a_orientation: NATURAL_8; a_adjustment: POINTER): POINTER
		external
			"C (GtkOrientation, GtkAdjustment*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_separator_new (a_orientation: NATURAL_8): POINTER
		external
			"C (GtkOrientation): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_widget_add_events (a_widget: POINTER; a_events: INTEGER_32)
		external
			"C (GtkWidget*, gint) | <ev_gtk.h>"
		end

	frozen gtk_widget_destroy (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_widget_event (a_widget: POINTER; a_event: POINTER): BOOLEAN
		external
			"C (GtkWidget*, GdkEvent*): gboolean | <ev_gtk.h>"
		end

	frozen gtk_widget_get_toplevel (a_widget: POINTER): POINTER
		external
			"C (GtkWidget*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_widget_grab_default (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_widget_grab_focus (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_widget_hide (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_widget_queue_draw (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_widget_queue_draw_area (a_widget: POINTER; a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
		external
			"C (GtkWidget*, gint, gint, gint, gint) | <ev_gtk.h>"
		end

	frozen gtk_widget_queue_resize (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_widget_realize (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_widget_set_name (a_widget: POINTER; a_name: POINTER)
		external
			"C (GtkWidget*, gchar*) | <ev_gtk.h>"
		end

	frozen gtk_widget_set_sensitive (a_widget: POINTER; a_sensitive: BOOLEAN)
		external
			"C (GtkWidget*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_widget_set_style (a_widget: POINTER; a_style: POINTER)
		obsolete
			"gtk_widget_set_style is deprecated [2021-06-01]"
		external
			"C (GtkWidget*, GtkStyle*) | <ev_gtk.h>"
		end

	frozen gtk_widget_set_can_focus (a_widget: POINTER; a_sensitive: BOOLEAN)
		external
			"C signature (GtkWidget*, gboolean) use <ev_gtk.h>"
		end

	frozen gtk_widget_get_can_focus (a_widget: POINTER): BOOLEAN
		external
			"C signature (GtkWidget*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_widget_show (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_widget_map (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_widget_unmap (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		end

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

	frozen gtk_window_new (a_type: INTEGER_32): POINTER
		external
			"C (GtkWindowType): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_window_set_default_size (a_window: POINTER; a_width: INTEGER_32; a_height: INTEGER_32)
		external
			"C (GtkWindow*, gint, gint) | <ev_gtk.h>"
		end

	frozen gtk_window_set_resizable (a_window: POINTER; a_resizable: BOOLEAN)
		external
			"C (GtkWindow*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_window_get_default_size (a_window: POINTER; a_width: POINTER; a_height: POINTER)
		external
			"C (GtkWindow*, EIF_INTEGER_32*, EIF_INTEGER_32*) | <ev_gtk.h>"
		end

	frozen gtk_window_set_focus (a_window: POINTER; a_focus: POINTER)
		external
			"C (GtkWindow*, GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_window_set_geometry_hints (a_window: POINTER; a_geometry_widget: POINTER; a_geometry: POINTER; a_geom_mask: INTEGER_32)
		external
			"C (GtkWindow*, GtkWidget*, GdkGeometry*, GdkWindowHints) | <ev_gtk.h>"
		end

	frozen gtk_window_set_type_hint (a_window: POINTER; a_type_hint: INTEGER_32)
		external
			"C (GtkWindow*, GdkWindowTypeHint) | <ev_gtk.h>"
		end

	frozen gtk_window_set_position (a_window: POINTER; a_position: INTEGER_32)
		external
			"C (GtkWindow*, GtkWindowPosition) | <ev_gtk.h>"
		end

	frozen gtk_window_set_title (a_window: POINTER; a_title: POINTER)
		external
			"C (GtkWindow*, gchar*) | <ev_gtk.h>"
		end

	frozen gtk_window_set_transient_for (a_window: POINTER; a_parent: POINTER)
		external
			"C (GtkWindow*, GtkWindow*) | <ev_gtk.h>"
		end

	frozen gdk_event_focus_struct_in (a_c_struct: POINTER): INTEGER_8
		external
			"C [struct <ev_gtk.h>] (GdkEventFocus): EIF_INTEGER_8"
		alias
			"in"
		end

	frozen gdk_event_any_struct_send_event (a_c_struct: POINTER): INTEGER_8
		external
			"C [struct <ev_gtk.h>] (GdkEventAny): EIF_INTEGER_8"
		alias
			"send_event"
		end

	frozen gdk_event_any_struct_window (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GdkEventAny): EIF_POINTER"
		alias
			"window"
		end

	frozen gdk_event_any_struct_type (a_c_struct: POINTER): INTEGER_8
		external
			"C [struct <ev_gtk.h>] (GdkEventAny): EIF_INTEGER_8"
		alias
			"type"
		end

	frozen gdk_event_button_struct_button (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_INTEGER"
		alias
			"button"
		end

	frozen gdk_event_button_struct_window (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_REFERENCE"
		alias
			"window"
		end

	frozen gdk_event_button_struct_state (a_c_struct: POINTER): NATURAL_32
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_NATURAL_32"
		alias
			"state"
		end

	frozen gdk_event_button_struct_type (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_INTEGER"
		alias
			"type"
		end

	frozen gdk_event_button_struct_x (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_DOUBLE"
		alias
			"x"
		end

	frozen gdk_event_button_struct_x_root (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_DOUBLE"
		alias
			"x_root"
		end

	frozen gdk_event_scroll_struct_x_root (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventScroll): EIF_DOUBLE"
		alias
			"x_root"
		end

	frozen gdk_event_button_struct_y (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_DOUBLE"
		alias
			"y"
		end

	frozen gdk_event_button_struct_y_root (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_DOUBLE"
		alias
			"y_root"
		end

	frozen gdk_event_scroll_struct_y_root (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventScroll): EIF_DOUBLE"
		alias
			"y_root"
		end

	frozen gdk_event_configure_struct_height (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventConfigure): EIF_INTEGER"
		alias
			"height"
		end

	frozen gdk_event_configure_struct_width (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventConfigure): EIF_INTEGER"
		alias
			"width"
		end

	frozen gdk_event_setting_struct_name (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GdkEventSetting): EIF_POINTER"
		alias
			"name"
		end

	frozen gdk_event_configure_struct_x (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventConfigure): EIF_INTEGER"
		alias
			"x"
		end

	frozen gdk_event_configure_struct_y (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventConfigure): EIF_INTEGER"
		alias
			"y"
		end

	frozen gdk_event_crossing_struct_subwindow (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GdkEventCrossing): EIF_POINTER"
		alias
			"subwindow"
		end

	frozen gdk_event_crossing_struct_mode (a_c_struct: POINTER): INTEGER
		external
			"C [struct <ev_gtk.h>] (GdkEventCrossing): EIF_INTEGER"
		alias
			"mode"
		end

	frozen gdk_event_crossing_struct_detail (a_c_struct: POINTER): INTEGER
		external
			"C [struct <ev_gtk.h>] (GdkEventCrossing): EIF_INTEGER"
		alias
			"detail"
		end

	frozen gdk_event_crossing_struct_focus (a_c_struct: POINTER): BOOLEAN
		external
			"C [struct <ev_gtk.h>] (GdkEventCrossing): EIF_BOOLEAN"
		alias
			"focus"
		end

	frozen gdk_event_expose_struct_area (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GdkEventExpose): EIF_POINTER"
		alias
			"&area"
		end

	frozen gdk_event_key_struct_keyval (a_c_struct: POINTER): NATURAL_32
		external
			"C [struct <ev_gtk.h>] (GdkEventKey): guint"
		alias
			"keyval"
		end

	frozen gdk_event_key_struct_state (a_c_struct: POINTER): NATURAL_32
		external
			"C [struct <ev_gtk.h>] (GdkEventKey): EIF_NATURAL_32"
		alias
			"state"
		end

	frozen gdk_event_key_struct_type (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventKey): EIF_INTEGER"
		alias
			"type"
		end

	frozen gdk_event_motion_struct_is_hint (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventMotion): EIF_INTEGER"
		alias
			"is_hint"
		end

	frozen gdk_event_motion_struct_state (a_c_struct: POINTER): NATURAL_32
		external
			"C [struct <ev_gtk.h>] (GdkEventMotion): EIF_NATURAL_32"
		alias
			"state"
		end

	frozen gdk_event_motion_struct_window (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GdkEventMotion): EIF_POINTER"
		alias
			"window"
		end

	frozen gdk_event_motion_struct_x (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventMotion): EIF_DOUBLE"
		alias
			"x"
		end

	frozen gdk_event_motion_struct_x_root (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventMotion): EIF_DOUBLE"
		alias
			"x_root"
		end

	frozen gdk_event_motion_struct_y (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventMotion): EIF_DOUBLE"
		alias
			"y"
		end

	frozen gdk_event_motion_struct_y_root (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventMotion): EIF_DOUBLE"
		alias
			"y_root"
		end

	frozen gdk_event_dnd_struct_context (a_c_struct: POINTER): POINTER
		external
			"C struct GdkEventDND access context use <ev_gtk.h>"
		end

	frozen gdk_event_dnd_struct_time (a_c_struct: POINTER): NATURAL_32
		external
			"C struct GdkEventDND access time use <ev_gtk.h>"
		end

	frozen gdk_point_struct_x (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkPoint): EIF_INTEGER"
		alias
			"x"
		end

	frozen gdk_point_struct_y (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkPoint): EIF_INTEGER"
		alias
			"y"
		end

	frozen gdk_rectangle_struct_height (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkRectangle): EIF_INTEGER"
		alias
			"height"
		end

	frozen gdk_rectangle_struct_width (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkRectangle): EIF_INTEGER"
		alias
			"width"
		end

	frozen gdk_rectangle_struct_x (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkRectangle): EIF_INTEGER"
		alias
			"x"
		end

	frozen gdk_rectangle_struct_y (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkRectangle): EIF_INTEGER"
		alias
			"y"
		end

	frozen glist_struct_data (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GList): EIF_POINTER"
		alias
			"data"
		end

	frozen glist_struct_next (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GList): EIF_POINTER"
		alias
			"next"
		end

	frozen glist_struct_prev (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GList): EIF_POINTER"
		alias
			"prev"
		end

	frozen gslist_struct_data (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GSList): EIF_POINTER"
		alias
			"data"
		end

	frozen gslist_struct_next (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GSList): EIF_POINTER"
		alias
			"next"
		end

	frozen gtk_adjustment_get_lower (a_c_struct: POINTER): REAL_32
		external
			"C signature (GtkAdjustment*): gdouble use <ev_gtk.h>"
		end

	frozen gtk_adjustment_get_page_increment (a_c_struct: POINTER): REAL_32
		external
			"C signature (GtkAdjustment*): gdouble use <ev_gtk.h>"
		end

	frozen gtk_adjustment_get_page_size (a_c_struct: POINTER): REAL_32
		external
			"C signature (GtkAdjustment*): gdouble use <ev_gtk.h>"
		end

	frozen gtk_adjustment_get_step_increment (a_c_struct: POINTER): REAL_32
		external
			"C signature (GtkAdjustment*): gdouble use <ev_gtk.h>"
		end

	frozen gtk_adjustment_get_upper (a_c_struct: POINTER): REAL_32
		external
			"C signature (GtkAdjustment*): gdouble use <ev_gtk.h>"
		end

	frozen gtk_adjustment_get_value (a_c_struct: POINTER): REAL_32
		external
			"C signature (GtkAdjustment*): gdouble use <ev_gtk.h>"
		end

	frozen gtk_allocation_struct_height (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkAllocation): EIF_INTEGER"
		alias
			"height"
		end

	frozen gtk_allocation_struct_width (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkAllocation): EIF_INTEGER"
		alias
			"width"
		end

	frozen gtk_allocation_struct_x (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkAllocation): EIF_INTEGER"
		alias
			"x"
		end

	frozen gtk_allocation_struct_y (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkAllocation): EIF_INTEGER"
		alias
			"y"
		end

	frozen set_gtk_allocation_struct_height (a_c_struct: POINTER; a_value: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GtkAllocation, gint)"
		alias
			"height"
		end

	frozen set_gtk_allocation_struct_width (a_c_struct: POINTER; a_value: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GtkAllocation, gint)"
		alias
			"width"
		end

	frozen set_gtk_allocation_struct_x (a_c_struct: POINTER; a_value: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GtkAllocation, gint)"
		alias
			"x"
		end

	frozen set_gtk_allocation_struct_y (a_c_struct: POINTER; a_value: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GtkAllocation, gint)"
		alias
			"y"
		end

	frozen gtk_bin_get_child (a_bin: POINTER): POINTER
		external
			"C signature (GtkBin*): EIF_POINTER use <ev_gtk.h>"
		end

	frozen gtk_box_get_homogeneous (a_c_struct: POINTER): BOOLEAN
		external
			"C signature (GtkBox*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_box_get_spacing (a_c_struct: POINTER): INTEGER_32
		external
			"C signature (GtkBox*): gint use <ev_gtk.h>"
		end

	frozen gtk_check_menu_item_get_active (a_c_struct: POINTER): BOOLEAN
		external
			"C signature (GtkCheckMenuItem*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_container_get_border_width (a_c_struct: POINTER): INTEGER_32
		external
			"C signature (GtkContainer*): EIF_INTEGER use <ev_gtk.h>"
		end

	frozen gtk_entry_get_max_length (a_c_struct: POINTER): INTEGER_32
		external
			"C signature (GtkEntry*): EIF_INTEGER use <ev_gtk.h>"
		end

	frozen gtk_label_get_justify (a_c_struct: POINTER): INTEGER_32
		external
			"C signature (GtkLabel*): EIF_INTEGER use <ev_gtk.h>"
		end

	frozen gtk_label_get_label (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkLabel*): EIF_POINTER use <ev_gtk.h>"
		end

	frozen gtk_notebook_get_tab_pos (a_c_struct: POINTER): INTEGER_32
		external
			"C signature (GtkNotebook*): EIF_INTEGER use <ev_gtk.h>"
		end

	frozen gtk_widget_get_state_flags (a_gtk_widget: POINTER): INTEGER_32
		external
			"C signature (GtkWidget*): EIF_INTEGER use <ev_gtk.h>"
		end

	frozen gtk_requisition_struct_height (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkRequisition): EIF_INTEGER"
		alias
			"height"
		end

	frozen gtk_requisition_struct_width (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkRequisition): EIF_INTEGER"
		alias
			"width"
		end

	frozen gtk_style_struct_base (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkStyle): EIF_POINTER"
		alias
			"base"
		end

	frozen gtk_style_struct_bg (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkStyle): EIF_POINTER"
		alias
			"bg"
		end

	frozen gtk_style_struct_dark (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkStyle): EIF_POINTER"
		alias
			"dark"
		end

	frozen gtk_style_struct_fg (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkStyle): EIF_POINTER"
		alias
			"fg"
		end

	frozen gtk_style_struct_text (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkStyle): EIF_POINTER"
		alias
			"text"
		end

	frozen gtk_viewport_get_bin_window (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkViewport*): EIF_POINTER use <ev_gtk.h>"
		end

	frozen gtk_widget_get_allocation (a_c_struct, a_allocation: POINTER)
		external
			"C signature (GtkWidget*, GtkAllocation*) use <ev_gtk.h>"
		end

	frozen  gtk_widget_get_allocated_size (a_widget: POINTER; allocation: POINTER; baseline: INTEGER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			gtk_widget_get_allocated_size ((GtkWidget *)$a_widget,
                               (GtkAllocation *)$allocation,
                               (int *)$baseline);

			]"
		end

	frozen gtk_widget_get_allocated_width (a_c_struct: POINTER): INTEGER_32
		external
			"C signature (GtkWidget*): int use <ev_gtk.h>"
		end

	frozen gtk_widget_get_allocated_height (a_c_struct: POINTER): INTEGER_32
		external
			"C signature (GtkWidget*): int use <ev_gtk.h>"
		end

	frozen gtk_widget_get_parent (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkWidget*): EIF_POINTER use <ev_gtk.h>"
		end

	frozen gtk_widget_get_style (a_c_struct: POINTER): POINTER
		obsolete
			"Use 'gtk_widget_get_style_context' instead [2021-06-01]"
			--|Use GtkStyleContext instead
		external
			"C signature (GtkWidget*): GtkStyle* use <ev_gtk.h>"
		end

	frozen gtk_widget_get_window (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkWidget*): GdkWindow* use <ev_gtk.h>"
		end


	frozen gtk_widget_show_all (widget: POINTER)
		note
			eis:"name=gtk_widget_show_all","src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#gtk-widget-show-all"
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_show_all ((GtkWidget *)$widget)"
		end


	frozen gtk_window_get_focus (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkWindow*): GtkWidget* use <ev_gtk.h>"
		end

	frozen gtk_window_get_title (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkWindow*): gchar* use <ev_gtk.h>"
		end

	frozen gtk_window_get_transient_for (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkWindow*): GtkWindow* use <ev_gtk.h>"
		end

	frozen set_gdk_event_any_struct_window (a_c_struct: POINTER; a_window: POINTER)
		external
			"C [struct <ev_gtk.h>] (GdkEventAny, GdkWindow*)"
		alias
			"window"
		end

	frozen set_gdk_geometry_struct_base_height (a_c_struct: POINTER; a_base_height: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"base_height"
		end

	frozen set_gdk_geometry_struct_base_width (a_c_struct: POINTER; a_base_width: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"base_width"
		end

	frozen set_gdk_geometry_struct_height_inc (a_c_struct: POINTER; a_height_inc: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"height_inc"
		end

	frozen set_gdk_geometry_struct_max_aspect (a_c_struct: POINTER; a_max_aspect: REAL_64)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gdouble)"
		alias
			"max_aspect"
		end

	frozen set_gdk_geometry_struct_max_height (a_c_struct: POINTER; a_max_height: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"max_height"
		end

	frozen set_gdk_geometry_struct_max_width (a_c_struct: POINTER; a_max_width: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"max_width"
		end

	frozen set_gdk_geometry_struct_min_aspect (a_c_struct: POINTER; a_min_aspect: REAL_64)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gdouble)"
		alias
			"min_aspect"
		end

	frozen set_gdk_geometry_struct_min_height (a_c_struct: POINTER; a_min_height: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"min_height"
		end

	frozen set_gdk_geometry_struct_min_width (a_c_struct: POINTER; a_min_width: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"min_width"
		end

	frozen set_gdk_geometry_struct_width_inc (a_c_struct: POINTER; a_width_inc: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"width_inc"
		end

	frozen gtk_adjustment_set_lower (a_c_struct: POINTER; a_lower: REAL_32)
		external
			"C signature (GtkAdjustment*, gdouble) use <ev_gtk.h>"
		end

	frozen gtk_adjustment_set_page_increment (a_c_struct: POINTER; a_page_increment: REAL_32)
		external
			"C signature (GtkAdjustment*, gdouble) use <ev_gtk.h>"
		end

	frozen gtk_adjustment_set_page_size (a_c_struct: POINTER; a_page_size: REAL_32)
		external
			"C signature (GtkAdjustment*, gdouble) use <ev_gtk.h>"
		end

	frozen gtk_adjustment_set_step_increment (a_c_struct: POINTER; a_step_increment: REAL_32)
		external
			"C signature (GtkAdjustment*, gdouble) use <ev_gtk.h>"
		end

	frozen gtk_adjustment_set_upper (a_c_struct: POINTER; a_upper: REAL_32)
		external
			"C signature (GtkAdjustment*, gdouble) use <ev_gtk.h>"
		end

	frozen c_gdk_rectangle_struct_allocate: POINTER
		external
			"C [macro <stdlib.h>]"
		alias
			"calloc (sizeof(GdkRectangle), 1)"
		end

	frozen c_gdk_rgba_struct_allocate: POINTER
		external
			"C [macro <stdlib.h>]"
		alias
			"calloc (sizeof(GdkRGBA), 1)"
		end

	frozen c_gdk_geometry_struct_allocate: POINTER
		external
			"C [macro <stdlib.h>]"
		alias
			"calloc (sizeof(GdkGeometry), 1)"
		end

feature --GdkColor

	frozen set_gdk_color_struct_blue (a_c_struct: POINTER; a_blue: INTEGER_32)
		obsolete "Use GdkRGBA"
		external
			"C [struct <ev_gtk.h>] (GdkColor, gushort)"
		alias
			"blue"
		ensure
			is_class: class
		end

	frozen set_gdk_color_struct_green (a_c_struct: POINTER; a_green: INTEGER_32)
		obsolete "Use GdkRGBA"
		external
			"C [struct <ev_gtk.h>] (GdkColor, gushort)"
		alias
			"green"
		ensure
			is_class: class
		end

	frozen set_gdk_color_struct_pixel (a_c_struct: POINTER; a_pixel: INTEGER_32)
		obsolete "Use GdkRGBA"
		external
			"C [struct <ev_gtk.h>] (GdkColor, gulong)"
		alias
			"pixel"
		ensure
			is_class: class
		end

	frozen set_gdk_color_struct_red (a_c_struct: POINTER; a_red: INTEGER_32)
		obsolete "Use GdkRGBA"
		external
			"C [struct <ev_gtk.h>] (GdkColor, gushort)"
		alias
			"red"
		ensure
			is_class: class
		end


	frozen g_object_get_data (object: POINTER; key: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return g_object_get_data ((GObject *)$object,
                   (const gchar *)$key);
              ]"
		end



	frozen GDK_ALL_EVENTS_MASK_ENUM: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_ALL_EVENTS_MASK"
		ensure
			is_class: class
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

