note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	GTK

feature

	frozen null_pointer: POINTER
		external
			"C macro use <glib.h>"
		alias
			"NULL"
		ensure
			is_class: class
		end

	frozen g_module_supported: BOOLEAN
		external
			"C signature (): gboolean use <gmodule.h>"
		ensure
			is_class: class
		end

	frozen g_module_symbol (a_module, a_symbol_name: POINTER; a_symbol: TYPED_POINTER [POINTER]): BOOLEAN
		external
			"C signature (GModule*, gchar*, gpointer*): gboolean use <gmodule.h>"
		ensure
			is_class: class
		end

	frozen g_module_open (a_module_name: POINTER; a_flags: INTEGER_32): POINTER
		external
			"C signature (gchar*, GModuleFlags): GModule* use <gmodule.h>"
		ensure
			is_class: class
		end

	frozen g_module_close (a_module: POINTER): BOOLEAN
		external
			"C signature (GModule*): gboolean use <gmodule.h>"
		ensure
			is_class: class
		end

	frozen gtk_settings_get_default: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					return gtk_settings_get_default();
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gtk_settings_set_string_property (a_settings, a_property, a_value, a_origin: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					gtk_settings_set_string_property ((GtkSettings*) $a_settings, (gchar*) $a_property, (gchar*) $a_value, (gchar*) $a_origin);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_window_process_all_updates
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					gdk_window_process_all_updates();
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gtk_window_set_skip_taskbar_hint (a_window: POINTER; a_setting: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					gtk_window_set_skip_taskbar_hint ((GtkWindow*) $a_window, (gboolean) $a_setting);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gtk_window_set_skip_pager_hint (a_window: POINTER; a_setting: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					gtk_window_set_skip_pager_hint ((GtkWindow*) $a_window, (gboolean) $a_setting);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_colorspace_rgb_enum: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					return GDK_COLORSPACE_RGB;
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_get_pixels (a_pixbuf: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					return gdk_pixbuf_get_pixels ((GdkPixbuf*) $a_pixbuf);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_copy (a_pixbuf: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					return gdk_pixbuf_copy ((GdkPixbuf*)$a_pixbuf);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_get_width (a_pixbuf: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					return gdk_pixbuf_get_width ((GdkPixbuf*)$a_pixbuf);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_get_height (a_pixbuf: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					return gdk_pixbuf_get_height ((GdkPixbuf*)$a_pixbuf);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_get_rowstride (a_pixbuf: POINTER): NATURAL_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					return gdk_pixbuf_get_rowstride ((GdkPixbuf*)$a_pixbuf);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_get_n_channels (a_pixbuf: POINTER): NATURAL_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					return gdk_pixbuf_get_n_channels ((GdkPixbuf*)$a_pixbuf);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_get_bits_per_sample (a_pixbuf: POINTER): NATURAL_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					return gdk_pixbuf_get_bits_per_sample ((GdkPixbuf*)$a_pixbuf);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_new_from_file (a_filename: POINTER; a_error: TYPED_POINTER [POINTER]): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					return gdk_pixbuf_new_from_file ((char*) $a_filename, (GError**) $a_error);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_new_from_stream (a_input_stream: POINTER; a_cancellable: POINTER; a_error: TYPED_POINTER [POINTER]): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1 && GTK_MINOR_VERSION > 13
					return gdk_pixbuf_new_from_stream ((GInputStream *)$a_input_stream, (GCancellable *)$a_cancellable, (GError **)$a_error);
				#endif
			]"
		ensure
			is_class: class
		end
	frozen gdk_pixbuf_new_from_xpm_data (a_data: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					return gdk_pixbuf_new_from_xpm_data ((const char**) $a_data);
				#endif
			]"
		ensure
			is_class: class
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
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_render_pixmap_and_mask (a_pixbuf: POINTER; a_pixmap, a_mask: TYPED_POINTER [POINTER]; alpha_threshold: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					gdk_pixbuf_render_pixmap_and_mask ((GdkPixbuf*) $a_pixbuf, (GdkPixmap**) $a_pixmap, (GdkBitmap**) $a_mask, (int) $alpha_threshold);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_new (a_colorspace: INTEGER_32; a_has_alpha: BOOLEAN; a_bits_per_sample, a_width, a_height: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					return gdk_pixbuf_new ((GdkColorspace) $a_colorspace, (gboolean) $a_has_alpha, (int) $a_bits_per_sample, (int) $a_width, (int) $a_height);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_new_subpixbuf (a_pixbuf: POINTER; src_x, src_y, width, height: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
						return gdk_pixbuf_new_subpixbuf ((GdkPixbuf*)$a_pixbuf, (int) $src_x, (int) $src_y, (int) $width, (int) $height);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_fill (a_pixbuf: POINTER; rgba: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
						gdk_pixbuf_fill ((GdkPixbuf*)$a_pixbuf, (guint32) $rgba);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gtk_fixed_child_struct_x (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkFixedChild): EIF_INTEGER"
		alias
			"x"
		ensure
			is_class: class
		end

	frozen gtk_fixed_child_struct_y (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkFixedChild): EIF_INTEGER"
		alias
			"y"
		ensure
			is_class: class
		end

	frozen set_gtk_fixed_child_struct_x (a_c_struct: POINTER; a_x: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GtkFixedChild, gint)"
		alias
			"x"
		ensure
			is_class: class
		end

	frozen set_gtk_fixed_child_struct_y (a_c_struct: POINTER; a_y: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GtkFixedChild, gint)"
		alias
			"y"
		ensure
			is_class: class
		end

	frozen gtk_win_pos_mouse_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_WIN_POS_MOUSE"
		ensure
			is_class: class
		end

	frozen gtk_maj_ver: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"gtk_major_version"
		ensure
			is_class: class
		end

	frozen gtk_min_ver: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"gtk_minor_version"
		ensure
			is_class: class
		end

	frozen gtk_mic_ver: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"gtk_micro_version"
		ensure
			is_class: class
		end

	frozen gtk_widget_set_flags (a_widget: POINTER; a_flag: INTEGER_32)
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_WIDGET_SET_FLAGS"
		ensure
			is_class: class
		end

	frozen gtk_widget_flags (a_widget: POINTER): INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_WIDGET_FLAGS"
		ensure
			is_class: class
		end

	frozen gtk_widget_unset_flags (a_widget: POINTER; a_flag: INTEGER_32)
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_WIDGET_UNSET_FLAGS"
		ensure
			is_class: class
		end

	frozen gtk_widget_is_sensitive (a_widget: POINTER): BOOLEAN
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_WIDGET_IS_SENSITIVE"
		ensure
			is_class: class
		end

	frozen gtk_widget_no_window (a_wid: POINTER): BOOLEAN
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_WIDGET_NO_WINDOW"
		ensure
			is_class: class
		end

	frozen c_gdk_color_struct_size: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"sizeof(GdkColor)"
		ensure
			is_class: class
		end

	frozen c_gdk_rectangle_struct_size: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"sizeof(GdkRectangle)"
		ensure
			is_class: class
		end

	frozen c_gtk_requisition_struct_size: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"sizeof(GtkRequisition)"
		ensure
			is_class: class
		end

	frozen c_gtk_allocation_struct_size: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"sizeof(GtkAllocation)"
		ensure
			is_class: class
		end

	frozen gtk_is_container (w: POINTER): BOOLEAN
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_IS_CONTAINER"
		ensure
			is_class: class
		end

	frozen gtk_is_window (w: POINTER): BOOLEAN
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_IS_WINDOW"
		ensure
			is_class: class
		end

	frozen gtk_is_menu (w: POINTER): BOOLEAN
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_IS_MENU"
		ensure
			is_class: class
		end

	frozen gdk_control_mask_enum: NATURAL_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_CONTROL_MASK"
		ensure
			is_class: class
		end

	frozen gdk_mod1_mask_enum: NATURAL_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_MOD1_MASK"
		ensure
			is_class: class
		end

	frozen gdk_shift_mask_enum: NATURAL_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_SHIFT_MASK"
		ensure
			is_class: class
		end

	frozen gdk_lock_mask_enum: NATURAL_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_LOCK_MASK"
		ensure
			is_class: class
		end

	frozen gdk_button_press_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON_PRESS"
		ensure
			is_class: class
		end

	frozen gdk_2button_press_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_2BUTTON_PRESS"
		ensure
			is_class: class
		end

	frozen gdk_3button_press_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_3BUTTON_PRESS"
		ensure
			is_class: class
		end

	frozen gdk_button_release_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON_RELEASE"
		ensure
			is_class: class
		end

	frozen gtk_state_normal_enum, gtk_state_flag_normal_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STATE_NORMAL"
		ensure
			is_class: class
		end

	frozen gtk_state_prelight_enum, gtk_state_flag_prelight_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STATE_PRELIGHT"
		ensure
			is_class: class
		end

	frozen gtk_state_selected_enum, gtk_state_flag_selected_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STATE_SELECTED"
		ensure
			is_class: class
		end

	frozen gtk_state_active_enum, gtk_state_flag_active_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STATE_ACTIVE"
		ensure
			is_class: class
		end

	frozen gtk_state_insensitive_enum, gtk_state_flag_insensitive_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STATE_INSENSITIVE"
		ensure
			is_class: class
		end

	frozen gtk_sensitive_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SENSITIVE"
		ensure
			is_class: class
		end

	frozen gtk_mapped_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_MAPPED"
		ensure
			is_class: class
		end

	frozen gdk_invert_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_INVERT"
		ensure
			is_class: class
		end

	frozen gdk_include_inferiors_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_INCLUDE_INFERIORS"
		ensure
			is_class: class
		end

	frozen gtk_justify_center_enum: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"GTK_JUSTIFY_CENTER"
		ensure
			is_class: class
		end

	frozen gtk_justify_left_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_JUSTIFY_LEFT"
		ensure
			is_class: class
		end

	frozen gtk_justify_right_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_JUSTIFY_RIGHT"
		ensure
			is_class: class
		end

	frozen gtk_justify_fill_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_JUSTIFY_FILL"
		ensure
			is_class: class
		end

	frozen gtk_shadow_none_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SHADOW_NONE"
		ensure
			is_class: class
		end

	frozen gtk_shadow_etched_in_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SHADOW_ETCHED_IN"
		ensure
			is_class: class
		end

	frozen gtk_shadow_etched_out_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SHADOW_ETCHED_OUT"
		ensure
			is_class: class
		end

	frozen gtk_shadow_in_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SHADOW_IN"
		ensure
			is_class: class
		end

	frozen gtk_shadow_out_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SHADOW_OUT"
		ensure
			is_class: class
		end

	frozen gdk_exposure_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_EXPOSURE_MASK"
		ensure
			is_class: class
		end

	frozen gdk_pointer_motion_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_POINTER_MOTION_MASK"
		ensure
			is_class: class
		end

	frozen gdk_pointer_motion_hint_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_POINTER_MOTION_HINT_MASK"
		ensure
			is_class: class
		end

	frozen gdk_button1_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON1_MASK"
		ensure
			is_class: class
		end

	frozen gdk_button2_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON2_MASK"
		ensure
			is_class: class
		end

	frozen gdk_button3_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON3_MASK"
		ensure
			is_class: class
		end

	frozen gdk_button_press_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON_PRESS_MASK"
		ensure
			is_class: class
		end

	frozen gdk_button_release_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON_RELEASE_MASK"
		ensure
			is_class: class
		end

	frozen gdk_button_motion_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_BUTTON_MOTION_MASK"
		ensure
			is_class: class
		end

	frozen gdk_key_press_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_KEY_PRESS"
		ensure
			is_class: class
		end

	frozen gdk_key_release_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_KEY_RELEASE"
		ensure
			is_class: class
		end

	frozen gdk_key_press_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_KEY_PRESS_MASK"
		ensure
			is_class: class
		end

	frozen gdk_key_release_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_KEY_RELEASE_MASK"
		ensure
			is_class: class
		end

	frozen gdk_enter_notify_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_ENTER_NOTIFY_MASK"
		ensure
			is_class: class
		end

	frozen gdk_leave_notify_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_LEAVE_NOTIFY_MASK"
		ensure
			is_class: class
		end

	frozen gdk_focus_change_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_FOCUS_CHANGE_MASK"
		ensure
			is_class: class
		end

	frozen gdk_visibility_notify_mask_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_VISIBILITY_NOTIFY_MASK"
		ensure
			is_class: class
		end

	frozen GDK_ALL_EVENTS_MASK_ENUM: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_ALL_EVENTS_MASK"
		ensure
			is_class: class
		end

	frozen gtk_has_focus_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_HAS_FOCUS"
		ensure
			is_class: class
		end

	frozen gtk_has_grab_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_HAS_GRAB"
		ensure
			is_class: class
		end

	frozen gtk_visible_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_VISIBLE"
		ensure
			is_class: class
		end

	frozen gtk_window_toplevel_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_WINDOW_TOPLEVEL"
		ensure
			is_class: class
		end

	frozen gdk_decor_all_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_DECOR_ALL"
		ensure
			is_class: class
		end

	frozen gdk_decor_border_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_DECOR_BORDER"
		ensure
			is_class: class
		end

	frozen gdk_hint_max_size_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_HINT_MAX_SIZE"
		ensure
			is_class: class
		end

	frozen gdk_hint_min_size_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_HINT_MIN_SIZE"
		ensure
			is_class: class
		end

	frozen gtk_win_pos_center_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_WIN_POS_CENTER"
		ensure
			is_class: class
		end

	frozen gtk_win_pos_none_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_WIN_POS_NONE"
		ensure
			is_class: class
		end

	frozen gdk_func_close_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_FUNC_CLOSE"
		ensure
			is_class: class
		end

	frozen gdk_func_move_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_FUNC_MOVE"
		ensure
			is_class: class
		end

	frozen gdk_func_resize_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_FUNC_RESIZE"
		ensure
			is_class: class
		end

	frozen gdk_func_minimize_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_FUNC_MINIMIZE"
		ensure
			is_class: class
		end

	frozen gdk_func_maximize_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_FUNC_MAXIMIZE"
		ensure
			is_class: class
		end

	frozen gdk_func_all_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_FUNC_ALL"
		ensure
			is_class: class
		end

	frozen gtk_can_focus_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_CAN_FOCUS"
		ensure
			is_class: class
		end

	frozen gtk_policy_automatic_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_POLICY_AUTOMATIC"
		ensure
			is_class: class
		end

	frozen gtk_policy_always_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_POLICY_ALWAYS"
		ensure
			is_class: class
		end

	frozen gtk_policy_never_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_POLICY_NEVER"
		ensure
			is_class: class
		end

	frozen gtk_corner_top_left_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_CORNER_TOP_LEFT"
		ensure
			is_class: class
		end

	frozen gtk_selection_browse_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SELECTION_BROWSE"
		ensure
			is_class: class
		end

	frozen gtk_selection_single_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SELECTION_SINGLE"
		ensure
			is_class: class
		end

	frozen gtk_selection_multiple_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SELECTION_MULTIPLE"
		ensure
			is_class: class
		end

	frozen gtk_selection_extended_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_SELECTION_EXTENDED"
		ensure
			is_class: class
		end

	frozen gdk_copy_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_COPY"
		ensure
			is_class: class
		end

	frozen gdk_copy_invert_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_COPY_INVERT"
		ensure
			is_class: class
		end

	frozen gdk_xor_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_XOR"
		ensure
			is_class: class
		end

	frozen gdk_and_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_AND"
		ensure
			is_class: class
		end

	frozen gdk_or_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_OR"
		ensure
			is_class: class
		end

	frozen gdk_line_on_off_dash_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_LINE_ON_OFF_DASH"
		ensure
			is_class: class
		end

	frozen gdk_line_solid_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_LINE_SOLID"
		ensure
			is_class: class
		end

	frozen gdk_tiled_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_TILED"
		ensure
			is_class: class
		end

	frozen gdk_solid_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_SOLID"
		ensure
			is_class: class
		end

	frozen gdk_cap_round_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_CAP_ROUND"
		ensure
			is_class: class
		end

	frozen gdk_join_bevel_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_JOIN_BEVEL"
		ensure
			is_class: class
		end

	frozen g_free (a_mem: POINTER)
		external
			"C (gpointer) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_list_append (a_list: POINTER; a_data: POINTER): POINTER
		external
			"C (GList*, gpointer): GList* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_list_free (a_list: POINTER)
		external
			"C (GList*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_list_index (a_list: POINTER; a_data: POINTER): INTEGER_32
		external
			"C (GList*, gpointer): gint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_list_insert (a_list: POINTER; a_data: POINTER; a_position: INTEGER_32): POINTER
		external
			"C (GList*, gpointer, gint): GList* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_list_length (a_list: POINTER): INTEGER_32
		external
			"C (GList*): guint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_list_nth (a_list: POINTER; a_n: INTEGER_32): POINTER
		external
			"C (GList*, guint): GList* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_list_nth_data (a_list: POINTER; a_n: INTEGER_32): POINTER
		external
			"C (GList*, guint): gpointer | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_list_remove (a_list: POINTER; a_data: POINTER): POINTER
		external
			"C (GList*, gpointer): GList* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_malloc (a_size: INTEGER_32): POINTER
		external
			"C (gulong): gpointer | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_realloc (a_mem: POINTER; a_size: INTEGER_32): POINTER
		external
			"C (gpointer, gulong): gpointer | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_slist_free (a_list: POINTER)
		external
			"C (GSList*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_slist_index (a_list: POINTER; a_data: POINTER): INTEGER_32
		external
			"C (GSList*, gpointer): gint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_slist_length (a_list: POINTER): INTEGER_32
		external
			"C (GSList*): guint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_slist_nth_data (a_list: POINTER; a_n: INTEGER_32): POINTER
		external
			"C (GSList*, guint): gpointer | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_beep
		external
			"C () | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_bitmap_unref (a_pixmap: POINTER)
		external
			"C (GdkBitmap*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_atom_intern (a_atom_name: POINTER; a_only_if_exists: INTEGER_32): POINTER
		external
			"C (gchar*, gint): GdkAtom | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_atom_name (a_atom: POINTER): POINTER
		external
			"C (GdkAtom): gchar* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_colormap_alloc_color (a_colormap: POINTER; a_color: POINTER; a_writeable: BOOLEAN; a_best_match: BOOLEAN): BOOLEAN
		external
			"C (GdkColormap*, GdkColor*, gboolean, gboolean): gboolean | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_colormap_get_visual (a_colormap: POINTER): POINTER
		external
			"C (GdkColormap*): GdkVisual* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_cursor_new (a_cursor_type: INTEGER_32): POINTER
		external
			"C (GdkCursorType): GdkCursor* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_selection_property_get (a_window: POINTER; a_data: TYPED_POINTER [POINTER]; a_target: POINTER; prop_type: TYPED_POINTER [INTEGER_32]): INTEGER_32
		external
			"C signature (GdkWindow*, guchar**, GdkAtom*, gint*): gint use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_drag_get_selection (a_context: POINTER): POINTER
		external
			"C (GdkDragContext*): GdkAtom | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_drag_context_struct_source_window (a_drag_context: POINTER): POINTER
		obsolete
			"Use 'gdk_drag_context_get_source_window' instead. [2020-05-31]"
		external
			"C struct GdkDragContext access source_window use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_drag_context_get_source_window (a_drag_context: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_drag_context_get_source_window ((GdkDragContext *)$a_drag_context);"
		ensure
			is_class: class
		end

	frozen gdk_drag_context_struct_dest_window (a_drag_context: POINTER): POINTER
		external
			"C struct GdkDragContext access dest_window use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_drag_context_struct_targets (a_drag_context: POINTER): POINTER
		obsolete
			"Use 'gdk_drag_context_list_targets' instead. [2020-05-31]"
		external
			"C struct GdkDragContext access targets use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_drag_context_list_targets (a_drag_context: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_drag_context_list_targets ((GdkDragContext *)$a_drag_context);"
		ensure
			is_class: class
		end

	frozen gdk_selection_convert (a_requestor, a_selection, a_target: POINTER; a_time: NATURAL_32)
		external
			"C signature (GdkWindow*, GdkAtom, GdkAtom, guint32) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_arc (a_drawable: POINTER; a_gc: POINTER; a_filled: INTEGER_32; a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32; a_angle1: INTEGER_32; a_angle2: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, gint, gint, gint, gint, gint, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_gray_image (a_drawable: POINTER; a_gc: POINTER; a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32; a_dith: INTEGER_32; a_buf: POINTER; a_rowstride: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, gint, gint, gint, gint, GdkRgbDither, guchar*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_image (a_drawable: POINTER; a_gc: POINTER; a_image: POINTER; a_xsrc: INTEGER_32; a_ysrc: INTEGER_32; a_xdest: INTEGER_32; a_ydest: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, GdkImage*, gint, gint, gint, gint, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_indexed_image (a_drawable: POINTER; a_gc: POINTER; a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32; a_dith: INTEGER_32; a_buf: POINTER; a_rowstride: INTEGER_32; a_cmap: POINTER)
		external
			"C (GdkDrawable*, GdkGC*, gint, gint, gint, gint, GdkRgbDither, guchar*, gint, GdkRgbCmap*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_line (a_drawable: POINTER; a_gc: POINTER; a_x1: INTEGER_32; a_y1: INTEGER_32; a_x2: INTEGER_32; a_y2: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, gint, gint, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_lines (a_drawable: POINTER; a_gc: POINTER; a_points: POINTER; a_npoints: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, GdkPoint*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_pixmap (a_drawable: POINTER; a_gc: POINTER; a_src: POINTER; a_xsrc: INTEGER_32; a_ysrc: INTEGER_32; a_xdest: INTEGER_32; a_ydest: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, GdkDrawable*, gint, gint, gint, gint, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_point (a_drawable: POINTER; a_gc: POINTER; a_x: INTEGER_32; a_y: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_points (a_drawable: POINTER; a_gc: POINTER; a_points: POINTER; a_npoints: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, GdkPoint*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_polygon (a_drawable: POINTER; a_gc: POINTER; a_filled: INTEGER_32; a_points: POINTER; a_npoints: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, gint, GdkPoint*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_rectangle (a_drawable: POINTER; a_gc: POINTER; a_filled: INTEGER_32; a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, gint, gint, gint, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_rgb_32_image (a_drawable: POINTER; a_gc: POINTER; a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32; a_dith: INTEGER_32; a_buf: POINTER; a_rowstride: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, gint, gint, gint, gint, GdkRgbDither, guchar*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_rgb_image (a_drawable: POINTER; a_gc: POINTER; a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32; a_dith: INTEGER_32; a_rgb_buf: POINTER; a_rowstride: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, gint, gint, gint, gint, GdkRgbDither, guchar*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_rgb_image_dithalign (a_drawable: POINTER; a_gc: POINTER; a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32; a_dith: INTEGER_32; a_rgb_buf: POINTER; a_rowstride: INTEGER_32; a_xdith: INTEGER_32; a_ydith: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, gint, gint, gint, gint, GdkRgbDither, guchar*, gint, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_segments (a_drawable: POINTER; a_gc: POINTER; a_segs: POINTER; a_nsegs: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, GdkSegment*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_string (a_drawable: POINTER; a_font: POINTER; a_gc: POINTER; a_x: INTEGER_32; a_y: INTEGER_32; a_string: POINTER)
		external
			"C (GdkDrawable*, GdkFont*, GdkGC*, gint, gint, gchar*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_text (a_drawable: POINTER; a_font: POINTER; a_gc: POINTER; a_x: INTEGER_32; a_y: INTEGER_32; a_text: POINTER; a_text_length: INTEGER_32)
		external
			"C (GdkDrawable*, GdkFont*, GdkGC*, gint, gint, gchar*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_text_wc (a_drawable: POINTER; a_font: POINTER; a_gc: POINTER; a_x: INTEGER_32; a_y: INTEGER_32; a_text: POINTER; a_text_length: INTEGER_32)
		external
			"C (GdkDrawable*, GdkFont*, GdkGC*, gint, gint, GdkWChar*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_drop_finish (a_context: POINTER; a_success: BOOLEAN; a_time: NATURAL_32)
		external
			"C (GdkDragContext*, gboolean, guint32) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_drag_finish (a_context: POINTER; a_success: BOOLEAN; del: BOOLEAN; a_time: NATURAL_32)
		external
			"C (GdkDragContext*, gboolean, gboolean, guint32) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_error_trap_pop: INTEGER_32
		external
			"C (): gint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_error_trap_push
		external
			"C () | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_event_free (a_event: POINTER)
		external
			"C (GdkEvent*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_event_get: POINTER
		external
			"C (): GdkEvent* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_events_pending: BOOLEAN
		external
			"C (): gboolean | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_flush
		external
			"C () | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_font_load (a_font_name: POINTER): POINTER
		external
			"C (gchar*): GdkFont* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_font_unref (a_font: POINTER)
		external
			"C (GdkFont*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_get_values (a_gc: POINTER; a_values: POINTER)
		external
			"C (GdkGC*, GdkGCValues*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_new (a_window: POINTER): POINTER
		external
			"C (GdkWindow*): GdkGC* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_new_with_values (a_window: POINTER; a_values: POINTER; a_values_mask: INTEGER_32): POINTER
		external
			"C (GdkWindow*, GdkGCValues*, GdkGCValuesMask): GdkGC* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_ref (a_gc: POINTER): POINTER
		external
			"C (GdkGC*): GdkGC* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_background (a_gc: POINTER; a_color: POINTER)
		external
			"C (GdkGC*, GdkColor*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_clip_mask (a_gc: POINTER; a_mask: POINTER)
		external
			"C (GdkGC*, GdkBitmap*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_clip_origin (a_gc: POINTER; a_x: INTEGER_32; a_y: INTEGER_32)
		external
			"C (GdkGC*, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_clip_rectangle (a_gc: POINTER; a_rectangle: POINTER)
		external
			"C (GdkGC*, GdkRectangle*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_clip_region (a_gc: POINTER; a_region: POINTER)
		external
			"C (GdkGC*, GdkRegion*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_dashes (a_gc: POINTER; a_dash_offset: INTEGER_32; a_dash_list: POINTER; a_n: INTEGER_32)
		external
			"C (GdkGC*, gint, gint8*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_exposures (a_gc: POINTER; a_exposures: BOOLEAN)
		external
			"C (GdkGC*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_fill (a_gc: POINTER; a_fill: INTEGER_32)
		external
			"C (GdkGC*, GdkFill) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_font (a_gc: POINTER; a_font: POINTER)
		external
			"C (GdkGC*, GdkFont*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_foreground (a_gc: POINTER; a_color: POINTER)
		external
			"C (GdkGC*, GdkColor*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_function (a_gc: POINTER; a_function: INTEGER_32)
		external
			"C (GdkGC*, GdkFunction) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_line_attributes (a_gc: POINTER; a_line_width: INTEGER_32; a_line_style: INTEGER_32; a_cap_style: INTEGER_32; a_join_style: INTEGER_32)
		external
			"C (GdkGC*, gint, GdkLineStyle, GdkCapStyle, GdkJoinStyle) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_stipple (a_gc: POINTER; a_stipple: POINTER)
		external
			"C (GdkGC*, GdkPixmap*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_subwindow (a_gc: POINTER; a_mode: INTEGER_32)
		external
			"C (GdkGC*, GdkSubwindowMode) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_tile (a_gc: POINTER; a_tile: POINTER)
		external
			"C (GdkGC*, GdkPixmap*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_ts_origin (a_gc: POINTER; a_x: INTEGER_32; a_y: INTEGER_32)
		external
			"C (GdkGC*, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_unref (a_gc: POINTER)
		external
			"C (GdkGC*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_image_destroy (a_image: POINTER)
		external
			"C (GdkImage*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_image_get (a_window: POINTER; a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32): POINTER
		external
			"C (GdkWindow*, gint, gint, gint, gint): GdkImage* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_image_get_pixel (a_image: POINTER; a_x: INTEGER_32; a_y: INTEGER_32): INTEGER_32
		external
			"C (GdkImage*, gint, gint): guint32 | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_image_new (a_type: INTEGER_32; a_visual: POINTER; a_width: INTEGER_32; a_height: INTEGER_32): POINTER
		external
			"C (GdkImageType, GdkVisual*, gint, gint): GdkImage* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_keyboard_grab (a_window: POINTER; a_owner_events: BOOLEAN; a_time: INTEGER_32): INTEGER_32
		external
			"C (GdkWindow*, gboolean, guint32): gint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_keyboard_ungrab (a_time: INTEGER_32)
		external
			"C (guint32) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_keyval_from_name (a_keyval_name: POINTER): INTEGER_32
		external
			"C (gchar*): guint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_keyval_is_lower (a_keyval: NATURAL_32): BOOLEAN
		external
			"C (guint): gboolean | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_keyval_is_upper (a_keyval: NATURAL_32): BOOLEAN
		external
			"C (guint): gboolean | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_keyval_name (a_keyval: NATURAL_32): POINTER
		external
			"C (guint): gchar* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_keyval_to_lower (a_keyval: NATURAL_32): NATURAL_32
		external
			"C (guint): guint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_keyval_to_upper (a_keyval: NATURAL_32): NATURAL_32
		external
			"C (guint): guint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pixmap_create_from_xpm_d (a_window: POINTER; a_mask: POINTER; a_transparent_color: POINTER; a_data: POINTER): POINTER
		external
			"C (GdkWindow*, GdkBitmap**, GdkColor*, gchar**): GdkPixmap* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pixmap_new (a_window: POINTER; a_width: INTEGER_32; a_height: INTEGER_32; a_depth: INTEGER_32): POINTER
		external
			"C (GdkWindow*, gint, gint, gint): GdkPixmap* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pixmap_ref (a_pixmap: POINTER): POINTER
		external
			"C (GdkPixmap*): GdkPixmap* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pixmap_unref (a_pixmap: POINTER)
		external
			"C (GdkPixmap*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pointer_grab (a_window: POINTER; a_owner_events: INTEGER_32; a_event_mask: INTEGER_32; a_confine_to: POINTER; a_cursor: POINTER; a_time: INTEGER_32): INTEGER_32
		external
			"C (GdkWindow*, gint, GdkEventMask, GdkWindow*, GdkCursor*, guint32): gint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pointer_ungrab (a_time: INTEGER_32)
		external
			"C (guint32) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_region_destroy (a_region: POINTER)
		external
			"C (GdkRegion*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_region_equal (a_region1: POINTER; a_region2: POINTER): BOOLEAN
		external
			"C (GdkRegion*, GdkRegion*): gboolean | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_region_get_clipbox (a_region: POINTER; a_rectangle: POINTER)
		external
			"C (GdkRegion*, GdkRectangle*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_region_new: POINTER
		external
			"C (): GdkRegion* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_region_offset (a_region: POINTER; a_dx: INTEGER_32; a_dy: INTEGER_32)
		external
			"C (GdkRegion*, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_rgb_get_cmap: POINTER
		external
			"C (): GdkColormap* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_rgb_get_visual: POINTER
		external
			"C (): GdkVisual* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_screen_height: INTEGER_32
		external
			"C (): gint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_screen_width: INTEGER_32
		external
			"C (): gint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_set_show_events (a_show_events: BOOLEAN)
		external
			"C (gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_at_pointer (a_win_x: POINTER; a_win_y: POINTER): POINTER
		external
			"C (gint*, gint*): GdkWindow* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_get_origin (a_window: POINTER; a_x: POINTER; a_y: POINTER): INTEGER_32
		external
			"C (GdkWindow*, gint*, gint*): gint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_get_pointer (a_window: POINTER; a_x: POINTER; a_y: POINTER; a_mask: POINTER): POINTER
		external
			"C (GdkWindow*, gint*, gint*, GdkModifierType*): GdkWindow* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_get_size (a_window: POINTER; a_width: POINTER; a_height: POINTER)
		external
			"C (GdkWindow*, gint*, gint*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_get_user_data (a_window: POINTER; a_data: POINTER)
		external
			"C (GdkWindow*, gpointer*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_hide (a_window: POINTER)
		external
			"C (GdkWindow*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_lower (a_window: POINTER)
		external
			"C (GdkWindow*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_move (a_window: POINTER; a_x: INTEGER_32; a_y: INTEGER_32)
		external
			"C (GdkWindow*, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_new (a_parent: POINTER; a_attributes: POINTER; a_attributes_mask: INTEGER_32): POINTER
		external
			"C (GdkWindow*, GdkWindowAttr*, gint): GdkWindow* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_raise (a_window: POINTER)
		external
			"C (GdkWindow*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_set_cursor (a_window: POINTER; a_cursor: POINTER)
		external
			"C (GdkWindow*, GdkCursor*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_set_decorations (a_window: POINTER; a_decorations: INTEGER_32)
		external
			"C (GdkWindow*, GdkWMDecoration) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_set_events (a_window: POINTER; a_event_mask: INTEGER_32)
		external
			"C (GdkWindow*, GdkEventMask) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_set_functions (a_window: POINTER; a_functions: INTEGER_32)
		external
			"C (GdkWindow*, GdkWMFunction) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_set_geometry_hints (a_window: POINTER; a_geometry: POINTER; a_flags: INTEGER_32)
		external
			"C (GdkWindow*, GdkGeometry*, GdkWindowHints) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_set_icon (a_window: POINTER; a_icon_window: POINTER; a_pixmap: POINTER; a_mask: POINTER)
		external
			"C (GdkWindow*, GdkWindow*, GdkPixmap*, GdkBitmap*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_set_icon_name (a_window: POINTER; a_name: POINTER)
		external
			"C (GdkWindow*, gchar*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_set_override_redirect (a_window: POINTER; a_override_redirect: BOOLEAN)
		external
			"C (GdkWindow*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_set_title (a_window: POINTER; a_title: POINTER)
		external
			"C (GdkWindow*, gchar*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_set_transient_for (a_window: POINTER; a_leader: POINTER)
		external
			"C (GdkWindow*, GdkWindow*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_adjustment_changed (a_adjustment: POINTER)
		external
			"C (GtkAdjustment*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_adjustment_new (a_value: REAL_32; a_lower: REAL_32; a_upper: REAL_32; a_step_increment: REAL_32; a_page_increment: REAL_32; a_page_size: REAL_32): POINTER
		external
			"C (gfloat, gfloat, gfloat, gfloat, gfloat, gfloat): GtkObject* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_adjustment_set_value (a_adjustment: POINTER; a_value: REAL_32)
		external
			"C (GtkAdjustment*, gfloat) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_adjustment_value_changed (a_adjustment: POINTER)
		external
			"C (GtkAdjustment*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_alignment_new (a_xalign: REAL_32; a_yalign: REAL_32; a_xscale: REAL_32; a_yscale: REAL_32): POINTER
		external
			"C (gfloat, gfloat, gfloat, gfloat): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_alignment_set (a_alignment: POINTER; a_xalign: REAL_32; a_yalign: REAL_32; a_xscale: REAL_32; a_yscale: REAL_32)
		external
			"C (GtkAlignment*, gfloat, gfloat, gfloat, gfloat) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_box_pack_end (a_box: POINTER; a_child: POINTER; a_expand: BOOLEAN; a_fill: BOOLEAN; a_padding: INTEGER_32)
		external
			"C (GtkBox*, GtkWidget*, gboolean, gboolean, guint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_box_pack_start (a_box: POINTER; a_child: POINTER; a_expand: BOOLEAN; a_fill: BOOLEAN; a_padding: INTEGER_32)
		external
			"C (GtkBox*, GtkWidget*, gboolean, gboolean, guint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_box_query_child_packing (a_box: POINTER; a_child: POINTER; a_expand: POINTER; a_fill: POINTER; a_padding: POINTER; a_pack_type: POINTER)
		external
			"C (GtkBox*, GtkWidget*, gboolean*, gboolean*, guint*, GtkPackType*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_box_reorder_child (a_box: POINTER; a_child: POINTER; a_position: INTEGER_32)
		external
			"C (GtkBox*, GtkWidget*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_box_set_child_packing (a_box: POINTER; a_child: POINTER; a_expand: BOOLEAN; a_fill: BOOLEAN; a_padding: INTEGER_32; a_pack_type: INTEGER_32)
		external
			"C (GtkBox*, GtkWidget*, gboolean, gboolean, guint, GtkPackType) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_box_set_homogeneous (a_box: POINTER; a_homogeneous: BOOLEAN)
		external
			"C (GtkBox*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_box_set_spacing (a_box: POINTER; a_spacing: INTEGER_32)
		external
			"C (GtkBox*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_button_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_check_button_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_check_menu_item_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_check_menu_item_set_active (a_check_menu_item: POINTER; a_is_active: BOOLEAN)
		external
			"C (GtkCheckMenuItem*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_check_menu_item_set_show_toggle (a_menu_item: POINTER; a_always: BOOLEAN)
		external
			"C (GtkCheckMenuItem*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_color_selection_dialog_new (a_title: POINTER): POINTER
		external
			"C (gchar*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_container_add (a_container: POINTER; a_widget: POINTER)
		external
			"C (GtkContainer*, GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_container_check_resize (a_container: POINTER)
		external
			"C (GtkContainer*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_container_children (a_container: POINTER): POINTER
		external
			"C (GtkContainer*): GList* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_container_remove (a_container: POINTER; a_widget: POINTER)
		external
			"C (GtkContainer*, GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_container_set_border_width (a_container: POINTER; a_border_width: INTEGER_32)
		external
			"C (GtkContainer*, guint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_drawing_area_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_editable_copy_clipboard (a_editable: POINTER)
		external
			"C (GtkEditable*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_editable_cut_clipboard (a_editable: POINTER)
		external
			"C (GtkEditable*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_editable_delete_selection (a_editable: POINTER)
		external
			"C (GtkEditable*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_editable_get_position (a_editable: POINTER): INTEGER_32
		external
			"C (GtkEditable*): gint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_editable_insert_text (a_editable: POINTER; a_new_text: POINTER; a_new_text_length: INTEGER_32; a_position: POINTER)
		external
			"C (GtkEditable*, gchar*, gint, gint*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_editable_select_region (a_editable: POINTER; a_start: INTEGER_32; a_end: INTEGER_32)
		external
			"C (GtkEditable*, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_editable_set_editable (a_editable: POINTER; a_is_editable: BOOLEAN)
		external
			"C (GtkEditable*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_editable_set_position (a_editable: POINTER; a_position: INTEGER_32)
		external
			"C (GtkEditable*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_entry_append_text (a_entry: POINTER; a_text: POINTER)
		external
			"C (GtkEntry*, gchar*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_entry_get_text (a_entry: POINTER): POINTER
		external
			"C (GtkEntry*): gchar* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_entry_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_entry_prepend_text (a_entry: POINTER; a_text: POINTER)
		external
			"C (GtkEntry*, gchar*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_entry_set_text (a_entry: POINTER; a_text: POINTER)
		external
			"C (GtkEntry*, gchar*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_entry_set_visibility (a_entry: POINTER; a_visible: BOOLEAN)
		external
			"C (GtkEntry*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_event_box_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_is_event_box (a_object: POINTER): BOOLEAN
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_IS_EVENT_BOX"
		ensure
			is_class: class
		end

	frozen gtk_font_selection_dialog_get_font_name (a_fsd: POINTER): POINTER
		external
			"C (GtkFontSelectionDialog*): gchar* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_font_selection_dialog_new (a_title: POINTER): POINTER
		external
			"C (gchar*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_font_selection_dialog_set_font_name (a_fsd: POINTER; a_fontname: POINTER): BOOLEAN
		external
			"C (GtkFontSelectionDialog*, gchar*): gboolean | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_frame_new (a_label: POINTER): POINTER
		external
			"C (gchar*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_frame_set_label (a_frame: POINTER; a_label: POINTER)
		external
			"C (GtkFrame*, gchar*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_frame_set_label_align (a_frame: POINTER; a_xalign: REAL_32; a_yalign: REAL_32)
		external
			"C (GtkFrame*, gfloat, gfloat) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_frame_set_shadow_type (a_frame: POINTER; a_type: INTEGER_32)
		external
			"C (GtkFrame*, GtkShadowType) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_get_event_widget (a_event: POINTER): POINTER
		external
			"C (GdkEvent*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_grab_add (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_grab_get_current: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_grab_remove (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_hbox_new (a_homogeneous: BOOLEAN; a_spacing: INTEGER_32): POINTER
		external
			"C (gboolean, gint): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_hpaned_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_hscale_new (a_adjustment: POINTER): POINTER
		external
			"C (GtkAdjustment*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_hscrollbar_new (a_adjustment: POINTER): POINTER
		external
			"C (GtkAdjustment*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_hseparator_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_label_new (a_str: POINTER): POINTER
		external
			"C (gchar*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_label_set_justify (a_label: POINTER; a_jtype: INTEGER_32)
		external
			"C (GtkLabel*, GtkJustification) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_label_set_text (a_label: POINTER; a_str: POINTER)
		external
			"C (GtkLabel*, gchar*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_main_do_event (a_event: POINTER)
		external
			"C (GdkEvent*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_menu_bar_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_menu_item_activate (a_menu_item: POINTER)
		external
			"C (GtkMenuItem*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_menu_item_deselect (a_menu_item: POINTER)
		external
			"C (GtkMenuItem*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_menu_item_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_menu_item_select (a_menu_item: POINTER)
		external
			"C (GtkMenuItem*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_menu_item_set_submenu (a_menu_item: POINTER; a_submenu: POINTER)
		external
			"C (GtkMenuItem*, GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_menu_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_menu_popup (a_menu: POINTER; a_parent_menu_shell: POINTER; a_parent_menu_item: POINTER; a_func: POINTER; a_data: POINTER; a_button: INTEGER_32; a_activate_time: INTEGER_32)
		external
			"C (GtkMenu*, GtkWidget*, GtkWidget*, GtkMenuPositionFunc, gpointer, guint, guint32) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_menu_shell_cancel (a_menu_shell: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MAJOR_VERSION > 1
					gtk_menu_shell_cancel((GtkMenuShell*)$a_menu_shell);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gtk_menu_shell_deactivate (a_menu_shell: POINTER)
		external
			"C (GtkMenuShell*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_menu_shell_deselect (a_menu_shell: POINTER)
		external
			"C (GtkMenuShell*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_menu_shell_insert (a_menu_shell: POINTER; a_child: POINTER; a_position: INTEGER_32)
		external
			"C (GtkMenuShell*, GtkWidget*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_misc_set_alignment (a_misc: POINTER; a_xalign: REAL_32; a_yalign: REAL_32)
		external
			"C (GtkMisc*, gfloat, gfloat) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_misc_set_padding (a_misc: POINTER; a_xpad: INTEGER_32; a_ypad: INTEGER_32)
		external
			"C (GtkMisc*, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_notebook_get_current_page (a_notebook: POINTER): INTEGER_32
		external
			"C (GtkNotebook*): gint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_notebook_get_nth_page (a_notebook: POINTER; a_page_num: INTEGER_32): POINTER
		external
			"C (GtkNotebook*, gint): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_notebook_get_tab_label (a_notebook: POINTER; a_child: POINTER): POINTER
		external
			"C (GtkNotebook*, GtkWidget*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_notebook_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_notebook_page_num (a_notebook: POINTER; a_child: POINTER): INTEGER_32
		external
			"C (GtkNotebook*, GtkWidget*): gint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_notebook_reorder_child (a_notebook: POINTER; a_child: POINTER; a_position: INTEGER_32)
		external
			"C (GtkNotebook*, GtkWidget*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_notebook_set_page (a_notebook: POINTER; a_page_num: INTEGER_32)
		external
			"C (GtkNotebook*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_notebook_set_scrollable (a_notebook: POINTER; a_scrollable: BOOLEAN)
		external
			"C (GtkNotebook*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_notebook_set_show_border (a_notebook: POINTER; a_show_border: BOOLEAN)
		external
			"C (GtkNotebook*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_notebook_set_tab_label (a_notebook: POINTER; a_child: POINTER; a_tab_label: POINTER)
		external
			"C (GtkNotebook*, GtkWidget*, GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_notebook_set_tab_pos (a_notebook: POINTER; a_pos: INTEGER_32)
		external
			"C (GtkNotebook*, GtkPositionType) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_object_get_data (a_object: POINTER; a_key: POINTER): POINTER
		external
			"C (GtkObject*, gchar*): gpointer | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_object_sink (a_object: POINTER)
		external
			"C (GtkObject*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_paned_pack1 (a_paned: POINTER; a_child: POINTER; a_resize: BOOLEAN; a_shrink: BOOLEAN)
		external
			"C (GtkPaned*, GtkWidget*, gboolean, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_paned_pack2 (a_paned: POINTER; a_child: POINTER; a_resize: BOOLEAN; a_shrink: BOOLEAN)
		external
			"C (GtkPaned*, GtkWidget*, gboolean, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_paned_set_position (a_paned: POINTER; a_position: INTEGER_32)
		external
			"C (GtkPaned*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_pixmap_new (a_pixmap: POINTER; a_mask: POINTER): POINTER
		external
			"C (GdkPixmap*, GdkBitmap*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_progress_bar_new_with_adjustment (a_adjustment: POINTER): POINTER
		external
			"C (GtkAdjustment*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_progress_bar_set_bar_style (a_pbar: POINTER; a_style: INTEGER_32)
		external
			"C (GtkProgressBar*, GtkProgressBarStyle) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_progress_bar_set_orientation (a_pbar: POINTER; a_orientation: INTEGER_32)
		external
			"C (GtkProgressBar*, GtkProgressBarOrientation) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_propagate_event (a_widget: POINTER; a_event: POINTER)
		external
			"C (GtkWidget*, GdkEvent*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_radio_button_group (a_radio_button: POINTER): POINTER
		external
			"C (GtkRadioButton*): GSList* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_radio_button_new (a_group: POINTER): POINTER
		external
			"C (GSList*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_radio_button_set_group (a_radio_button: POINTER; a_group: POINTER)
		external
			"C (GtkRadioButton*, GSList*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_radio_menu_item_group (a_radio_menu_item: POINTER): POINTER
		external
			"C (GtkRadioMenuItem*): GSList* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_radio_menu_item_new (a_group: POINTER): POINTER
		external
			"C (GSList*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_radio_menu_item_new_with_label (a_group: POINTER; a_label: POINTER): POINTER
		external
			"C (GSList*, gchar*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_radio_menu_item_set_group (a_radio_menu_item: POINTER; a_group: POINTER)
		external
			"C (GtkRadioMenuItem*, GSList*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_rc_get_style, gtk_widget_get_style_context (a_widget: POINTER): POINTER
		external
			"C (GtkWidget*): GtkStyle* | <ev_gtk.h>"
		alias
			"gtk_rc_get_style"
		ensure
			is_class: class
		end

	frozen gtk_scale_set_digits (a_scale: POINTER; a_digits: INTEGER_32)
		external
			"C (GtkScale*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_scale_set_draw_value (a_scale: POINTER; a_draw_value: BOOLEAN)
		external
			"C (GtkScale*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_scrolled_window_get_hadjustment (a_scrolled_window: POINTER): POINTER
		external
			"C (GtkScrolledWindow*): GtkAdjustment* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_scrolled_window_get_vadjustment (a_scrolled_window: POINTER): POINTER
		external
			"C (GtkScrolledWindow*): GtkAdjustment* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_scrolled_window_new (a_hadjustment: POINTER; a_vadjustment: POINTER): POINTER
		external
			"C (GtkAdjustment*, GtkAdjustment*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_scrolled_window_set_policy (a_scrolled_window: POINTER; a_hscrollbar_policy: INTEGER_32; a_vscrollbar_policy: INTEGER_32)
		external
			"C (GtkScrolledWindow*, GtkPolicyType, GtkPolicyType) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_set_locale: POINTER
		external
			"C (): gchar* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_spin_button_new (a_adjustment: POINTER; a_climb_rate: REAL_32; a_digits: INTEGER_32): POINTER
		external
			"C (GtkAdjustment*, gfloat, guint): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_spin_button_update (a_spin_button: POINTER)
		external
			"C (GtkSpinButton*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_style_copy (a_style: POINTER): POINTER
		external
			"C (GtkStyle*): GtkStyle* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_style_unref (a_style: POINTER)
		external
			"C (GtkStyle*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_table_attach_defaults (a_table: POINTER; a_widget: POINTER; a_left_attach: INTEGER_32; a_right_attach: INTEGER_32; a_top_attach: INTEGER_32; a_bottom_attach: INTEGER_32)
		external
			"C (GtkTable*, GtkWidget*, guint, guint, guint, guint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_table_new (a_rows: INTEGER_32; a_columns: INTEGER_32; a_homogeneous: BOOLEAN): POINTER
		external
			"C (guint, guint, gboolean): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_table_resize (a_table: POINTER; a_rows: INTEGER_32; a_columns: INTEGER_32)
		external
			"C (GtkTable*, guint, guint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_table_set_col_spacings (a_table: POINTER; a_spacing: INTEGER_32)
		external
			"C (GtkTable*, guint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_table_set_homogeneous (a_table: POINTER; a_homogeneous: BOOLEAN)
		external
			"C (GtkTable*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_table_set_row_spacings (a_table: POINTER; a_spacing: INTEGER_32)
		external
			"C (GtkTable*, guint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_timeout_add (a_interval: INTEGER_32; a_function: POINTER; a_data: POINTER): INTEGER_32
		external
			"C (guint32, GtkFunction, gpointer): guint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_timeout_remove (a_timeout_handler_id: INTEGER_32)
		external
			"C (guint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_toggle_button_get_active (a_toggle_button: POINTER): BOOLEAN
		external
			"C (GtkToggleButton*): gboolean | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_toggle_button_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_toggle_button_set_active (a_toggle_button: POINTER; a_is_active: BOOLEAN)
		external
			"C (GtkToggleButton*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tooltips_data_get (a_widget: POINTER): POINTER
		external
			"C (GtkWidget*): GtkTooltipsData* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tooltips_force_window (a_tooltips: POINTER)
		external
			"C (GtkTooltips*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tooltips_new: POINTER
		external
			"C (): GtkTooltips* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tooltips_set_delay (a_tooltips: POINTER; a_delay: INTEGER_32)
		external
			"C (GtkTooltips*, guint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tooltips_set_tip (a_tooltips: POINTER; a_widget: POINTER; a_tip_text: POINTER; a_tip_private: POINTER)
		external
			"C (GtkTooltips*, GtkWidget*, gchar*, gchar*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_vbox_new (a_homogeneous: BOOLEAN; a_spacing: INTEGER_32): POINTER
		external
			"C (gboolean, gint): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_viewport_get_hadjustment (a_viewport: POINTER): POINTER
		external
			"C (GtkViewport*): GtkAdjustment* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_viewport_get_vadjustment (a_viewport: POINTER): POINTER
		external
			"C (GtkViewport*): GtkAdjustment* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_viewport_new (a_hadjustment: POINTER; a_vadjustment: POINTER): POINTER
		external
			"C (GtkAdjustment*, GtkAdjustment*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_viewport_set_shadow_type (a_viewport: POINTER; a_type: INTEGER_32)
		external
			"C (GtkViewport*, GtkShadowType) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_vpaned_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_vscale_new (a_adjustment: POINTER): POINTER
		external
			"C (GtkAdjustment*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_vscrollbar_new (a_adjustment: POINTER): POINTER
		external
			"C (GtkAdjustment*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_vseparator_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_add_events (a_widget: POINTER; a_events: INTEGER_32)
		external
			"C (GtkWidget*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_destroy (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_event (a_widget: POINTER; a_event: POINTER): BOOLEAN
		external
			"C (GtkWidget*, GdkEvent*): gboolean | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_get_toplevel (a_widget: POINTER): POINTER
		external
			"C (GtkWidget*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_grab_default (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_grab_focus (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_is_focus (a_widget: POINTER): BOOLEAN
		external
			"C (GtkWidget*): EIF_BOOLEAN | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_hide (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_queue_draw (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_queue_draw_area (a_widget: POINTER; a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
		external
			"C (GtkWidget*, gint, gint, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_queue_resize (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_realize (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_set_default_colormap (a_colormap: POINTER)
		external
			"C (GdkColormap*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_set_name (a_widget: POINTER; a_name: POINTER)
		external
			"C (GtkWidget*, gchar*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_set_sensitive (a_widget: POINTER; a_sensitive: BOOLEAN)
		external
			"C (GtkWidget*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_set_style (a_widget: POINTER; a_style: POINTER)
		external
			"C (GtkWidget*, GtkStyle*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_set_uposition (a_widget: POINTER; a_x: INTEGER_32; a_y: INTEGER_32)
		external
			"C (GtkWidget*, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_set_usize (a_widget: POINTER; a_width: INTEGER_32; a_height: INTEGER_32)
		external
			"C (GtkWidget*, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_show (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_map (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_unmap (a_widget: POINTER)
		external
			"C (GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_size_request (a_widget: POINTER; a_requisition: POINTER)
		external
			"C (GtkWidget*, GtkRequisition*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_new (a_type: INTEGER_32): POINTER
		external
			"C (GtkWindowType): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_set_default_size (a_window: POINTER; a_width: INTEGER_32; a_height: INTEGER_32)
		external
			"C (GtkWindow*, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_set_resizable (a_window: POINTER; a_resizable: BOOLEAN)
		external
			"C (GtkWindow*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_get_default_size (a_window: POINTER; a_width: POINTER; a_height: POINTER)
		external
			"C (GtkWindow*, EIF_INTEGER_32*, EIF_INTEGER_32*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_set_focus (a_window: POINTER; a_focus: POINTER)
		external
			"C (GtkWindow*, GtkWidget*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_get_focus (a_window: POINTER): POINTER
		external
			"C (GtkWindow*): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_set_geometry_hints (a_window: POINTER; a_geometry_widget: POINTER; a_geometry: POINTER; a_geom_mask: INTEGER_32)
		external
			"C (GtkWindow*, GtkWidget*, GdkGeometry*, GdkWindowHints) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_set_type_hint (a_window: POINTER; a_type_hint: INTEGER_32)
		external
			"C (GtkWindow*, GdkWindowTypeHint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_set_position (a_window: POINTER; a_position: INTEGER_32)
		external
			"C (GtkWindow*, GtkWindowPosition) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_set_title (a_window: POINTER; a_title: POINTER)
		external
			"C (GtkWindow*, gchar*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_set_transient_for (a_window: POINTER; a_parent: POINTER)
		external
			"C (GtkWindow*, GtkWindow*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_set_accept_focus (a_window: POINTER; a_accept: BOOLEAN)
		external
			"C (GtkWindow*, gboolean) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_color_struct_blue (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkColor): EIF_INTEGER"
		alias
			"blue"
		ensure
			is_class: class
		end

	frozen gdk_color_struct_green (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkColor): EIF_INTEGER"
		alias
			"green"
		ensure
			is_class: class
		end

	frozen gdk_color_struct_pixel (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkColor): EIF_INTEGER"
		alias
			"pixel"
		ensure
			is_class: class
		end

	frozen gdk_color_struct_red (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkColor): EIF_INTEGER"
		alias
			"red"
		ensure
			is_class: class
		end

	frozen gdk_event_focus_struct_in (a_c_struct: POINTER): INTEGER_8
		external
			"C [struct <ev_gtk.h>] (GdkEventFocus): EIF_INTEGER_8"
		alias
			"in"
		ensure
			is_class: class
		end

	frozen gdk_event_any_struct_send_event (a_c_struct: POINTER): INTEGER_8
		external
			"C [struct <ev_gtk.h>] (GdkEventAny): EIF_INTEGER_8"
		alias
			"send_event"
		ensure
			is_class: class
		end

	frozen gdk_event_any_struct_window (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GdkEventAny): EIF_POINTER"
		alias
			"window"
		ensure
			is_class: class
		end

	frozen gdk_event_any_struct_type (a_c_struct: POINTER): INTEGER_8
		external
			"C [struct <ev_gtk.h>] (GdkEventAny): EIF_INTEGER_8"
		alias
			"type"
		ensure
			is_class: class
		end

	frozen gdk_event_button_struct_button (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_INTEGER"
		alias
			"button"
		ensure
			is_class: class
		end

	frozen gdk_event_button_struct_window (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_REFERENCE"
		alias
			"window"
		ensure
			is_class: class
		end

	frozen gdk_event_button_struct_state (a_c_struct: POINTER): NATURAL_32
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_NATURAL_32"
		alias
			"state"
		ensure
			is_class: class
		end

	frozen gdk_event_button_struct_type (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_INTEGER"
		alias
			"type"
		ensure
			is_class: class
		end

	frozen gdk_event_button_struct_x (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_DOUBLE"
		alias
			"x"
		ensure
			is_class: class
		end

	frozen gdk_event_button_struct_x_root (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_DOUBLE"
		alias
			"x_root"
		ensure
			is_class: class
		end

	frozen gdk_event_scroll_struct_x_root (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventScroll): EIF_DOUBLE"
		alias
			"x_root"
		ensure
			is_class: class
		end

	frozen gdk_event_button_struct_y (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_DOUBLE"
		alias
			"y"
		ensure
			is_class: class
		end

	frozen gdk_event_button_struct_y_root (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventButton): EIF_DOUBLE"
		alias
			"y_root"
		ensure
			is_class: class
		end

	frozen gdk_event_scroll_struct_y_root (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventScroll): EIF_DOUBLE"
		alias
			"y_root"
		ensure
			is_class: class
		end

	frozen gdk_event_configure_struct_height (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventConfigure): EIF_INTEGER"
		alias
			"height"
		ensure
			is_class: class
		end

	frozen gdk_event_configure_struct_width (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventConfigure): EIF_INTEGER"
		alias
			"width"
		ensure
			is_class: class
		end

	frozen gdk_event_setting_struct_name (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GdkEventSetting): EIF_POINTER"
		alias
			"name"
		ensure
			is_class: class
		end

	frozen gdk_event_configure_struct_x (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventConfigure): EIF_INTEGER"
		alias
			"x"
		ensure
			is_class: class
		end

	frozen gdk_event_configure_struct_y (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventConfigure): EIF_INTEGER"
		alias
			"y"
		ensure
			is_class: class
		end

	frozen gdk_event_crossing_struct_subwindow (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GdkEventCrossing): EIF_POINTER"
		alias
			"subwindow"
		ensure
			is_class: class
		end

	frozen gdk_event_crossing_struct_mode (a_c_struct: POINTER): INTEGER
		external
			"C [struct <ev_gtk.h>] (GdkEventCrossing): EIF_INTEGER"
		alias
			"mode"
		ensure
			is_class: class
		end

	frozen gdk_event_crossing_struct_detail (a_c_struct: POINTER): INTEGER
		external
			"C [struct <ev_gtk.h>] (GdkEventCrossing): EIF_INTEGER"
		alias
			"detail"
		ensure
			is_class: class
		end

	frozen gdk_event_crossing_struct_focus (a_c_struct: POINTER): BOOLEAN
		external
			"C [struct <ev_gtk.h>] (GdkEventCrossing): EIF_BOOLEAN"
		alias
			"focus"
		ensure
			is_class: class
		end

	frozen gdk_event_expose_struct_area (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GdkEventExpose): EIF_POINTER"
		alias
			"&area"
		ensure
			is_class: class
		end

	frozen gdk_event_key_struct_keyval (a_c_struct: POINTER): NATURAL_32
		external
			"C [struct <ev_gtk.h>] (GdkEventKey): guint"
		alias
			"keyval"
		ensure
			is_class: class
		end

	frozen gdk_event_key_struct_state (a_c_struct: POINTER): NATURAL_32
		external
			"C [struct <ev_gtk.h>] (GdkEventKey): EIF_NATURAL_32"
		alias
			"state"
		ensure
			is_class: class
		end

	frozen gdk_event_key_struct_type (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventKey): EIF_INTEGER"
		alias
			"type"
		ensure
			is_class: class
		end

	frozen gdk_event_motion_struct_is_hint (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventMotion): EIF_INTEGER"
		alias
			"is_hint"
		ensure
			is_class: class
		end

	frozen gdk_event_motion_struct_state (a_c_struct: POINTER): NATURAL_32
		external
			"C [struct <ev_gtk.h>] (GdkEventMotion): EIF_NATURAL_32"
		alias
			"state"
		ensure
			is_class: class
		end

	frozen gdk_event_motion_struct_window (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GdkEventMotion): EIF_POINTER"
		alias
			"window"
		ensure
			is_class: class
		end

	frozen gdk_event_motion_struct_x (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventMotion): EIF_DOUBLE"
		alias
			"x"
		ensure
			is_class: class
		end

	frozen gdk_event_motion_struct_x_root (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventMotion): EIF_DOUBLE"
		alias
			"x_root"
		ensure
			is_class: class
		end

	frozen gdk_event_motion_struct_y (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventMotion): EIF_DOUBLE"
		alias
			"y"
		ensure
			is_class: class
		end

	frozen gdk_event_motion_struct_y_root (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventMotion): EIF_DOUBLE"
		alias
			"y_root"
		ensure
			is_class: class
		end

	frozen gdk_event_dnd_struct_context (a_c_struct: POINTER): POINTER
		external
			"C struct GdkEventDND access context use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_event_dnd_struct_time (a_c_struct: POINTER): NATURAL_32
		external
			"C struct GdkEventDND access time use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_font_struct_ascent (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkFont): EIF_INTEGER"
		alias
			"ascent"
		ensure
			is_class: class
		end

	frozen gdk_font_struct_descent (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkFont): EIF_INTEGER"
		alias
			"descent"
		ensure
			is_class: class
		end

	frozen gdk_gcvalues_struct_function (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkGCValues): EIF_INTEGER"
		alias
			"function"
		ensure
			is_class: class
		end

	frozen gdk_gcvalues_struct_line_style (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkGCValues): EIF_INTEGER"
		alias
			"line_style"
		ensure
			is_class: class
		end

	frozen gdk_gcvalues_struct_line_width (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkGCValues): EIF_INTEGER"
		alias
			"line_width"
		ensure
			is_class: class
		end

	frozen gdk_point_struct_x (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkPoint): EIF_INTEGER"
		alias
			"x"
		ensure
			is_class: class
		end

	frozen gdk_point_struct_y (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkPoint): EIF_INTEGER"
		alias
			"y"
		ensure
			is_class: class
		end

	frozen gdk_rectangle_struct_height (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkRectangle): EIF_INTEGER"
		alias
			"height"
		ensure
			is_class: class
		end

	frozen gdk_rectangle_struct_width (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkRectangle): EIF_INTEGER"
		alias
			"width"
		ensure
			is_class: class
		end

	frozen gdk_rectangle_struct_x (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkRectangle): EIF_INTEGER"
		alias
			"x"
		ensure
			is_class: class
		end

	frozen gdk_rectangle_struct_y (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkRectangle): EIF_INTEGER"
		alias
			"y"
		ensure
			is_class: class
		end

	frozen gdk_visual_struct_type (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkVisual): EIF_INTEGER"
		alias
			"type"
		ensure
			is_class: class
		end

	frozen glist_struct_data (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GList): EIF_POINTER"
		alias
			"data"
		ensure
			is_class: class
		end

	frozen glist_struct_next (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GList): EIF_POINTER"
		alias
			"next"
		ensure
			is_class: class
		end

	frozen glist_struct_prev (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GList): EIF_POINTER"
		alias
			"prev"
		ensure
			is_class: class
		end

	frozen gslist_struct_data (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GSList): EIF_POINTER"
		alias
			"data"
		ensure
			is_class: class
		end

	frozen gslist_struct_next (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GSList): EIF_POINTER"
		alias
			"next"
		ensure
			is_class: class
		end

	frozen gtk_adjustment_struct_lower (a_c_struct: POINTER): REAL_32
		external
			"C [struct <ev_gtk.h>] (GtkAdjustment): EIF_REAL"
		alias
			"lower"
		ensure
			is_class: class
		end

	frozen gtk_adjustment_struct_page_increment (a_c_struct: POINTER): REAL_32
		external
			"C [struct <ev_gtk.h>] (GtkAdjustment): EIF_REAL"
		alias
			"page_increment"
		ensure
			is_class: class
		end

	frozen gtk_adjustment_struct_page_size (a_c_struct: POINTER): REAL_32
		external
			"C [struct <ev_gtk.h>] (GtkAdjustment): EIF_REAL"
		alias
			"page_size"
		ensure
			is_class: class
		end

	frozen gtk_adjustment_struct_step_increment (a_c_struct: POINTER): REAL_32
		external
			"C [struct <ev_gtk.h>] (GtkAdjustment): EIF_REAL"
		alias
			"step_increment"
		ensure
			is_class: class
		end

	frozen gtk_adjustment_struct_upper (a_c_struct: POINTER): REAL_32
		external
			"C [struct <ev_gtk.h>] (GtkAdjustment): EIF_REAL"
		alias
			"upper"
		ensure
			is_class: class
		end

	frozen gtk_adjustment_struct_value (a_c_struct: POINTER): REAL_32
		external
			"C [struct <ev_gtk.h>] (GtkAdjustment): EIF_REAL"
		alias
			"value"
		ensure
			is_class: class
		end

	frozen gtk_allocation_struct_height (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkAllocation): EIF_INTEGER"
		alias
			"height"
		ensure
			is_class: class
		end

	frozen gtk_allocation_struct_width (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkAllocation): EIF_INTEGER"
		alias
			"width"
		ensure
			is_class: class
		end

	frozen gtk_allocation_struct_x (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkAllocation): EIF_INTEGER"
		alias
			"x"
		ensure
			is_class: class
		end

	frozen gtk_allocation_struct_y (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkAllocation): EIF_INTEGER"
		alias
			"y"
		ensure
			is_class: class
		end

	frozen set_gtk_allocation_struct_height (a_c_struct: POINTER; a_value: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GtkAllocation, gint)"
		alias
			"height"
		ensure
			is_class: class
		end

	frozen set_gtk_allocation_struct_width (a_c_struct: POINTER; a_value: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GtkAllocation, gint)"
		alias
			"width"
		ensure
			is_class: class
		end

	frozen set_gtk_allocation_struct_x (a_c_struct: POINTER; a_value: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GtkAllocation, gint)"
		alias
			"x"
		ensure
			is_class: class
		end

	frozen set_gtk_allocation_struct_y (a_c_struct: POINTER; a_value: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GtkAllocation, gint)"
		alias
			"y"
		ensure
			is_class: class
		end

	frozen gtk_bin_struct_child (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkBin): EIF_POINTER"
		alias
			"child"
		ensure
			is_class: class
		end

	frozen gtk_box_struct_container (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkBox): EIF_POINTER"
		alias
			"&container"
		ensure
			is_class: class
		end

	frozen gtk_box_struct_homogeneous (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkBox): EIF_INTEGER"
		alias
			"homogeneous"
		ensure
			is_class: class
		end

	frozen gtk_box_struct_spacing (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkBox): EIF_INTEGER"
		alias
			"spacing"
		ensure
			is_class: class
		end

	frozen gtk_check_menu_item_struct_active (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkCheckMenuItem): EIF_INTEGER"
		alias
			"active"
		ensure
			is_class: class
		end

	frozen gtk_color_selection_dialog_struct_help_button (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkColorSelectionDialog): EIF_POINTER"
		alias
			"help_button"
		ensure
			is_class: class
		end

	frozen gtk_container_struct_border_width (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkContainer): EIF_INTEGER"
		alias
			"border_width"
		ensure
			is_class: class
		end

	frozen gtk_entry_struct_text_max_length (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkEntry): EIF_INTEGER"
		alias
			"text_max_length"
		ensure
			is_class: class
		end

	frozen gtk_fixed_struct_children (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkFixed): EIF_POINTER"
		alias
			"children"
		ensure
			is_class: class
		end

	frozen gtk_frame_struct_shadow_type (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkFrame): EIF_INTEGER"
		alias
			"shadow_type"
		ensure
			is_class: class
		end

	frozen gtk_label_struct_jtype (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkLabel): EIF_INTEGER"
		alias
			"jtype"
		ensure
			is_class: class
		end

	frozen gtk_label_struct_label (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkLabel): EIF_POINTER"
		alias
			"label"
		ensure
			is_class: class
		end

	frozen gtk_notebook_struct_tab_pos (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkNotebook): EIF_INTEGER"
		alias
			"tab_pos"
		ensure
			is_class: class
		end

	frozen gtk_object_struct_flags (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkObject): EIF_INTEGER"
		alias
			"flags"
		ensure
			is_class: class
		end

	frozen gtk_paned_struct_child1_size (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkPaned): EIF_INTEGER"
		alias
			"child1_size"
		ensure
			is_class: class
		end

	frozen gtk_progress_bar_struct_bar_style (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkProgressBar): EIF_INTEGER"
		alias
			"bar_style"
		ensure
			is_class: class
		end

	frozen gtk_range_struct_adjustment (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkRange): EIF_POINTER"
		alias
			"adjustment"
		ensure
			is_class: class
		end

	frozen gtk_requisition_struct_height (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkRequisition): EIF_INTEGER"
		alias
			"height"
		ensure
			is_class: class
		end

	frozen gtk_requisition_struct_width (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkRequisition): EIF_INTEGER"
		alias
			"width"
		ensure
			is_class: class
		end

	frozen gtk_scrolled_window_struct_vscrollbar (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkScrolledWindow): EIF_POINTER"
		alias
			"vscrollbar"
		ensure
			is_class: class
		end

	frozen gtk_style_struct_base (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkStyle): EIF_POINTER"
		alias
			"base"
		ensure
			is_class: class
		end

	frozen gtk_style_struct_bg (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkStyle): EIF_POINTER"
		alias
			"bg"
		ensure
			is_class: class
		end

	frozen gtk_style_struct_dark (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkStyle): EIF_POINTER"
		alias
			"dark"
		ensure
			is_class: class
		end

	frozen gtk_style_struct_fg (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkStyle): EIF_POINTER"
		alias
			"fg"
		ensure
			is_class: class
		end

	frozen gtk_style_struct_text (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkStyle): EIF_POINTER"
		alias
			"text"
		ensure
			is_class: class
		end

	frozen gtk_tooltips_data_struct_tip_text (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkTooltipsData): EIF_POINTER"
		alias
			"tip_text"
		ensure
			is_class: class
		end

	frozen gtk_tooltips_struct_tip_window (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkTooltips): EIF_POINTER"
		alias
			"tip_window"
		ensure
			is_class: class
		end

	frozen gtk_viewport_struct_bin_window (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkViewport): EIF_POINTER"
		alias
			"bin_window"
		ensure
			is_class: class
		end

	frozen gtk_widget_aux_info_struct_x (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkWidgetAuxInfo): EIF_INTEGER"
		alias
			"x"
		ensure
			is_class: class
		end

	frozen gtk_widget_aux_info_struct_y (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GtkWidgetAuxInfo): EIF_INTEGER"
		alias
			"y"
		ensure
			is_class: class
		end

	frozen gtk_widget_struct_allocation (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkWidget): EIF_POINTER"
		alias
			"&allocation"
		ensure
			is_class: class
		end

	frozen gtk_widget_struct_parent (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkWidget): EIF_POINTER"
		alias
			"parent"
		ensure
			is_class: class
		end

	frozen gtk_widget_struct_requisition (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkWidget): EIF_POINTER"
		alias
			"&requisition"
		ensure
			is_class: class
		end

	frozen gtk_widget_struct_style (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkWidget): EIF_POINTER"
		alias
			"style"
		ensure
			is_class: class
		end

	frozen gtk_widget_struct_window, gtk_widget_get_window (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkWidget): EIF_POINTER"
		alias
			"window"
		ensure
			is_class: class
		end

	frozen gtk_window_struct_focus_widget (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkWindow): EIF_POINTER"
		alias
			"focus_widget"
		ensure
			is_class: class
		end

	frozen gtk_window_struct_title (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkWindow): EIF_POINTER"
		alias
			"title"
		ensure
			is_class: class
		end

	frozen gtk_window_struct_transient_parent (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkWindow): EIF_POINTER"
		alias
			"transient_parent"
		ensure
			is_class: class
		end

	frozen set_gdk_color_struct_blue (a_c_struct: POINTER; a_blue: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkColor, gushort)"
		alias
			"blue"
		ensure
			is_class: class
		end

	frozen set_gdk_color_struct_green (a_c_struct: POINTER; a_green: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkColor, gushort)"
		alias
			"green"
		ensure
			is_class: class
		end

	frozen set_gdk_color_struct_pixel (a_c_struct: POINTER; a_pixel: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkColor, gulong)"
		alias
			"pixel"
		ensure
			is_class: class
		end

	frozen set_gdk_color_struct_red (a_c_struct: POINTER; a_red: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkColor, gushort)"
		alias
			"red"
		ensure
			is_class: class
		end

	frozen set_gdk_event_any_struct_window (a_c_struct: POINTER; a_window: POINTER)
		external
			"C [struct <ev_gtk.h>] (GdkEventAny, GdkWindow*)"
		alias
			"window"
		ensure
			is_class: class
		end

	frozen set_gdk_geometry_struct_base_height (a_c_struct: POINTER; a_base_height: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"base_height"
		ensure
			is_class: class
		end

	frozen set_gdk_geometry_struct_base_width (a_c_struct: POINTER; a_base_width: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"base_width"
		ensure
			is_class: class
		end

	frozen set_gdk_geometry_struct_height_inc (a_c_struct: POINTER; a_height_inc: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"height_inc"
		ensure
			is_class: class
		end

	frozen set_gdk_geometry_struct_max_aspect (a_c_struct: POINTER; a_max_aspect: REAL_64)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gdouble)"
		alias
			"max_aspect"
		ensure
			is_class: class
		end

	frozen set_gdk_geometry_struct_max_height (a_c_struct: POINTER; a_max_height: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"max_height"
		ensure
			is_class: class
		end

	frozen set_gdk_geometry_struct_max_width (a_c_struct: POINTER; a_max_width: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"max_width"
		ensure
			is_class: class
		end

	frozen set_gdk_geometry_struct_min_aspect (a_c_struct: POINTER; a_min_aspect: REAL_64)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gdouble)"
		alias
			"min_aspect"
		ensure
			is_class: class
		end

	frozen set_gdk_geometry_struct_min_height (a_c_struct: POINTER; a_min_height: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"min_height"
		ensure
			is_class: class
		end

	frozen set_gdk_geometry_struct_min_width (a_c_struct: POINTER; a_min_width: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"min_width"
		ensure
			is_class: class
		end

	frozen set_gdk_geometry_struct_width_inc (a_c_struct: POINTER; a_width_inc: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkGeometry, gint)"
		alias
			"width_inc"
		ensure
			is_class: class
		end

	frozen set_gtk_adjustment_struct_lower (a_c_struct: POINTER; a_lower: REAL_32)
		external
			"C [struct <ev_gtk.h>] (GtkAdjustment, gfloat)"
		alias
			"lower"
		ensure
			is_class: class
		end

	frozen set_gtk_adjustment_struct_page_increment (a_c_struct: POINTER; a_page_increment: REAL_32)
		external
			"C [struct <ev_gtk.h>] (GtkAdjustment, gfloat)"
		alias
			"page_increment"
		ensure
			is_class: class
		end

	frozen set_gtk_adjustment_struct_page_size (a_c_struct: POINTER; a_page_size: REAL_32)
		external
			"C [struct <ev_gtk.h>] (GtkAdjustment, gfloat)"
		alias
			"page_size"
		ensure
			is_class: class
		end

	frozen set_gtk_adjustment_struct_step_increment (a_c_struct: POINTER; a_step_increment: REAL_32)
		external
			"C [struct <ev_gtk.h>] (GtkAdjustment, gfloat)"
		alias
			"step_increment"
		ensure
			is_class: class
		end

	frozen set_gtk_adjustment_struct_upper (a_c_struct: POINTER; a_upper: REAL_32)
		external
			"C [struct <ev_gtk.h>] (GtkAdjustment, gfloat)"
		alias
			"upper"
		ensure
			is_class: class
		end

	frozen set_gtk_adjustment_struct_value (a_c_struct: POINTER; a_value: REAL_32)
		external
			"C [struct <ev_gtk.h>] (GtkAdjustment, gfloat)"
		alias
			"value"
		ensure
			is_class: class
		end

	frozen set_gtk_fixed_struct_children (a_c_struct: POINTER; a_children: POINTER)
		external
			"C [struct <ev_gtk.h>] (GtkFixed, GList*)"
		alias
			"children"
		ensure
			is_class: class
		end

	frozen set_gtk_menu_shell_struct_children (a_c_struct: POINTER; a_children: POINTER)
		external
			"C [struct <ev_gtk.h>] (GtkMenuShell, GList*)"
		alias
			"children"
		ensure
			is_class: class
		end

	frozen set_gtk_paned_struct_child1_resize (a_c_struct: POINTER; a_child1_resize: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GtkPaned, guint)"
		alias
			"child1_resize"
		ensure
			is_class: class
		end

	frozen set_gtk_paned_struct_child2_resize (a_c_struct: POINTER; a_child2_resize: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GtkPaned, guint)"
		alias
			"child2_resize"
		ensure
			is_class: class
		end

	frozen c_gdk_rectangle_struct_allocate: POINTER
		external
			"C [macro <stdlib.h>]"
		alias
			"calloc (sizeof(GdkRectangle), 1)"
		ensure
			is_class: class
		end

	frozen c_gdk_color_struct_allocate: POINTER
		external
			"C [macro <stdlib.h>]"
		alias
			"calloc (sizeof(GdkColor), 1)"
		ensure
			is_class: class
		end

	frozen c_gdk_gcvalues_struct_allocate: POINTER
		external
			"C [macro <stdlib.h>]"
		alias
			"calloc (sizeof(GdkGCValues), 1)"
		ensure
			is_class: class
		end

	frozen c_gdk_geometry_struct_allocate: POINTER
		external
			"C [macro <stdlib.h>]"
		alias
			"calloc (sizeof(GdkGeometry), 1)"
		ensure
			is_class: class
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
