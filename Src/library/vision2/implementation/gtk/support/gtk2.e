note
	description: "Gtk Version Dependent Externals"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GTK2

feature -- Externals

	frozen gtk_im_context_simple_new: POINTER
		external
			"C signature (): GtkIMContext* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_im_context_reset (a_context: POINTER)
		external
			"C signature (GtkIMContext*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_im_context_focus_in (a_context: POINTER)
		external
			"C signature (GtkIMContext*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_im_context_focus_out (a_context: POINTER)
		external
			"C signature (GtkIMContext*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_im_context_filter_keypress (a_context, a_event_key: POINTER): BOOLEAN
		external
			"C signature (GtkIMContext*, GdkEventKey*): EIF_BOOLEAN use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_im_context_set_client_window (a_context, a_window: POINTER)
		external
			"C signature (GtkIMContext*, GdkWindow*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_im_context_get_surrounding (a_context: POINTER; a_text_ptr: TYPED_POINTER [POINTER]; a_cursor_index: TYPED_POINTER [INTEGER]): BOOLEAN
		external
			"C signature (GtkIMContext*, gchar**, gint*): EIF_BOOLEAN use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_keyval_to_unicode (a_keyval: NATURAL_32): NATURAL_32
		external
			"C (guint): guint | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_region_intersect (a_region1, a_region2: POINTER)
		external
			"C signature (GdkRegion*, GdkRegion*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_region_union (a_region1, a_region2: POINTER)
		external
			"C signature (GdkRegion*, GdkRegion*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_region_subtract (a_region1, a_region2: POINTER)
		external
			"C signature (GdkRegion*, GdkRegion*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_region_xor (a_region1, a_region2: POINTER)
		external
			"C signature (GdkRegion*, GdkRegion*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_region_copy (a_region: POINTER): POINTER
		external
			"C signature (GdkRegion*): GdkRegion* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_region_rectangle (a_rect: POINTER): POINTER
		external
			"C signature (GdkRectangle*): GdkRegion* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_set_accept_focus (a_window: POINTER; a_focus: BOOLEAN)
		external
			"C signature (GtkWindow*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_display_get_default_cursor_size (a_display: POINTER): INTEGER_32
		external
			"C signature (GdkDisplay*): EIF_INTEGER use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tooltips_struct_tip_label (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkTooltips): EIF_POINTER"
		alias
			"tip_label"
		ensure
			is_class: class
		end

	frozen events_pending: BOOLEAN
		external
			"C macro use <ev_gtk.h>"
		alias
			"g_main_context_pending (NULL)"
		ensure
			is_class: class
		end

	frozen gtk_event_iteration: BOOLEAN
		external
			"C macro use <ev_gtk.h>"
		alias
			"g_main_context_iteration(NULL, FALSE)"
		ensure
			is_class: class
		end

	frozen dispatch_events
		external
			"C macro use <ev_gtk.h>"
		alias
			"g_main_context_dispatch(g_main_context_default())"
		ensure
			is_class: class
		end

	frozen gtk_widget_toplevel (a_widget: POINTER): BOOLEAN
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_WIDGET_TOPLEVEL"
		ensure
			is_class: class
		end

	frozen gtk_fixed_set_has_window (a_fixed: POINTER; has_window: BOOLEAN)
		external
			"C signature (GtkFixed*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_toolbar_set_orientation (a_toolbar: POINTER; a_orientation: INTEGER_32)
		external
			"C signature (GtkToolbar*, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_toolbar_set_style (a_toolbar: POINTER; a_style: INTEGER)
		external
			"C signature (GtkToolbar*, GtkToolbarStyle) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_renderer_draw_layout (a_pango_renderer, a_pango_layout: POINTER; a_x, a_y: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					pango_renderer_draw_layout ((PangoRenderer*) $a_pango_renderer, (PangoLayout*) $a_pango_layout, (gint) $a_x, (gint) $a_y);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pango_renderer_get_default (a_screen: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					return gdk_pango_renderer_get_default ((GdkScreen*) $a_screen);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pango_renderer_set_drawable (a_renderer, a_drawable: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					gdk_pango_renderer_set_drawable ((GdkPangoRenderer*) $a_renderer, (GdkDrawable*) $a_drawable);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_pango_renderer_set_gc (a_renderer, a_gc: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					gdk_pango_renderer_set_gc ((GdkPangoRenderer*) $a_renderer, (GdkGC*) $a_gc);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gtk_label_set_angle (a_label: POINTER; a_angle: REAL_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					gtk_label_set_angle ((GtkLabel*) $a_label, (double) $a_angle);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gtk_label_set_ellipsize (a_label: POINTER; a_mode: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					gtk_label_set_ellipsize ((GtkLabel*) $a_label, (PangoEllipsizeMode) $a_mode);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen pango_matrix_init (a_pango_matrix: TYPED_POINTER [POINTER])
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					PangoMatrix matrix = PANGO_MATRIX_INIT;
					*($a_pango_matrix) = (void*) pango_matrix_copy (&matrix);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen pango_matrix_free (a_pango_matrix: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					pango_matrix_free ((PangoMatrix*) $a_pango_matrix);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen pango_matrix_rotate (a_matrix: POINTER; a_degrees: REAL_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					pango_matrix_rotate ((PangoMatrix*) $a_matrix, (double) $a_degrees);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen pango_matrix_translate (a_matrix: POINTER; a_x, a_y: REAL_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					pango_matrix_translate ((PangoMatrix*) $a_matrix, (double) $a_x, (double) $a_y);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen pango_context_set_matrix (a_context, a_matrix: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					pango_context_set_matrix ((PangoContext*) $a_context, (PangoMatrix*) $a_matrix);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen set_pango_matrix_struct_xx (a_c_struct: POINTER; a_x: REAL_64)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					((PangoMatrix*)$a_c_struct)->xx = (gdouble) $a_x;
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_screen_get_resolution (a_screen: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 10
					return gdk_screen_get_resolution ((GdkScreen*)$a_screen);
				#else
					return 96; // Default Gnome Logical DPI on older systems.
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_screen_get_primary_monitor (a_screen: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 20
					return gdk_screen_get_primary_monitor ((GdkScreen*)$a_screen);
				#else
					return 0; // Default Primary Monitor is the first monitor.
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_screen_get_rgb_colormap (a_screen: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return gdk_screen_get_rgb_colormap ((GdkScreen*)$a_screen);
			]"
		ensure
			is_class: class
		end

	frozen gdk_screen_get_rgb_visual (a_screen: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return gdk_screen_get_rgb_visual ((GdkScreen*)$a_screen);
			]"
		ensure
			is_class: class
		end

	frozen gdk_screen_get_rgba_colormap (a_screen: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 8
					return gdk_screen_get_rgba_colormap ((GdkScreen*)$a_screen);
				#else
					return NULL;
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_screen_get_rgba_visual (a_screen: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 8
					return gdk_screen_get_rgba_visual ((GdkScreen*)$a_screen);
				#else
					return NULL;
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_screen_is_composited (a_screen: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 10
					return gdk_screen_is_composited ((GdkScreen*)$a_screen);
				#else
					return EIF_FALSE;
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_draw_drawable (a_drawable: POINTER; a_gc: POINTER; a_src: POINTER; a_xsrc: INTEGER_32; a_ysrc: INTEGER_32; a_xdest: INTEGER_32; a_ydest: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
		external
			"C (GdkDrawable*, GdkGC*, GdkDrawable*, gint, gint, gint, gint, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_layout_get_context (a_pango_layout: POINTER): POINTER
		external
			"C signature (PangoLayout*): PangoContext* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_mem_set_vtable (mem_vtable: POINTER)
		external
			"C signature (GMemVTable*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_mem_is_system_malloc: BOOLEAN
		external
			"C signature (): GBoolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen glib_mem_profiler_table: POINTER
		external
			"C macro use <ev_gtk.h>"
		alias
			"glib_mem_profiler_table"
		ensure
			is_class: class
		end

	frozen gdk_drawable_copy_to_image (a_drawable, a_image: POINTER; src_x, src_y, dest_x, dest_y, a_width, a_height: INTEGER_32): POINTER
		external
			"C signature (GdkDrawable*, GdkImage*, int, int, int, int, int, int): GdkImage* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_drawable_get_colormap (a_drawable: POINTER): POINTER
		external
			"C signature (GdkDrawable*): GdkColormap* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_drawable_get_image (a_drawable: POINTER; a_x, a_y, a_width, a_height: INTEGER_32): POINTER
		external
			"C signature (GdkDrawable*, gint, gint, gint, gint): GdkImage* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_drawable_get_visible_region (a_drawable: POINTER): POINTER
		external
			"C signature (GdkDrawable*): GdkRegion use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_get_focus (a_window: POINTER): POINTER
		external
			"C signature (GtkWindow*): GtkWidget* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_scrolled_window_set_shadow_type (a_window: POINTER; a_shadow_type: INTEGER_32)
		external
			"C signature (GtkScrolledWindow*, GtkShadowType) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_win_pos_center_on_parent_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_WIN_POS_CENTER_ON_PARENT"
		ensure
			is_class: class
		end

	frozen gtk_label_get_label (a_label: POINTER): POINTER
		external
			"C signature (GtkLabel*): gchar* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_get_position (a_window: POINTER; a_width, a_height: TYPED_POINTER [INTEGER_32])
		external
			"C signature (GtkWindow*, gint*, gint*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_set_decorated (a_window: POINTER; a_decor: BOOLEAN)
		external
			"C signature (GtkWindow*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_move (a_window: POINTER; a_x, a_y: INTEGER_32)
		external
			"C signature (GtkWindow*, gint, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_icon_size_dialog_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_ICON_SIZE_DIALOG"
		ensure
			is_class: class
		end

	frozen g_signal_handler_disconnect (a_instance: POINTER; handler_id: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_signal_handler_disconnect ((gpointer) $a_instance, (gulong) $handler_id)"
		ensure
			is_class: class
		end

	frozen gtk_container_set_focus_chain (a_container: POINTER; a_focus_chain: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_container_set_focus_chain ((GtkContainer*) $a_container, (GList*) $a_focus_chain)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_struct_window (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkTreeViewColumn): GdkWindow*"
		alias
			"window"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_struct_button (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkTreeViewColumn): GtkWidget*"
		alias
			"button"
		ensure
			is_class: class
		end

	frozen gdk_drawable_get_size (a_drawable: POINTER; a_width, a_height: TYPED_POINTER [INTEGER_32])
		external
			"C signature (GdkDrawable*, gint*, gint*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_combo_box_popdown (a_combo: POINTER)
		external
			"C signature (GtkComboBox*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_combo_box_popup (a_combo: POINTER)
		external
			"C signature (GtkComboBox*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_entry_set_has_frame (a_entry: POINTER; has_frame: BOOLEAN)
		external
			"C signature (GtkEntry*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_entry_set_alignment (a_entry: POINTER; a_alignment: REAL_32)
		external
			"C signature (GtkEntry*, gfloat) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_set_current_folder (a_dialog: POINTER; a_folder: POINTER)
		external
			"C signature (GtkFileChooser*, gchar*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen add_g_type_boolean (an_array: POINTER; a_pos: INTEGER_32)
			-- Add G_TYPE_BOOLEAN constant in `an_array' at `a_pos' bytes from beginning
			-- of `an_array'.
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				{
					GType type = G_TYPE_BOOLEAN;
					memcpy ((char *) $an_array + $a_pos, &type, sizeof(GType));
				}
			]"
		ensure
			is_class: class
		end

	frozen add_g_type_string (an_array: POINTER; a_pos: INTEGER_32)
			-- Add G_TYPE_STRING constant in `an_array' at `a_pos' bytes from beginning
			-- of `an_array'.
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				{
					GType type = G_TYPE_STRING;
					memcpy ((char *) $an_array + $a_pos, &type, sizeof(GType));
				}
			]"
		ensure
			is_class: class
		end

	frozen add_gdk_type_pixbuf (an_array: POINTER; a_pos: INTEGER_32)
			-- Add GDK_TYPE_PIXBUF constant in `an_array' at `a_pos' bytes from beginning
			-- of `an_array'.
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				{
					GType type = GDK_TYPE_PIXBUF;
					memcpy ((char *) $an_array + $a_pos, &type, sizeof(GType));
				}
			]"
		ensure
			is_class: class
		end

	frozen sizeof_gtype: INTEGER_32
			-- Size of the `GType' C type
		external
			"C macro use <ev_gtk.h>"
		alias
			"sizeof(GType)"
		ensure
			is_class: class
		end

	frozen gtk_get_current_event_time: NATURAL_32
		external
			"C signature (): guint32 use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_has_toplevel_focus (a_window: POINTER): BOOLEAN
		external
			"C signature (GtkWindow*): gboolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_is_active (a_window: POINTER): BOOLEAN
		external
			"C signature (GtkWindow*): gboolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_resize (a_window: POINTER; a_width: INTEGER_32; a_height: INTEGER_32)
		external
			"C signature (GtkWindow*, gint, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tree_path_list_free_contents (a_list: POINTER)
			-- Free tree path items contained within `a_list'
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_list_foreach ((GList*) $a_list, (GFunc) gtk_tree_path_free, NULL)"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_rgb_fg_color (a_gc: POINTER; a_color: POINTER)
		external
			"C (GdkGC*, GdkColor*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_gc_set_rgb_bg_color (a_gc: POINTER; a_color: POINTER)
		external
			"C (GdkGC*, GdkColor*) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_grow_only_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_TREE_VIEW_COLUMN_GROW_ONLY"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_fixed_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_TREE_VIEW_COLUMN_FIXED"
		ensure
			is_class: class
		end

	frozen pango_tab_array_new (a_initial_size: INTEGER_32; a_position_in_pixels: BOOLEAN): POINTER
		external
			"C signature (gint, gboolean): PangoTabArray* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_tab_array_resize (a_tab_array: POINTER; a_size: INTEGER_32)
		external
			"C signature (PangoTabArray*, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_tab_array_set_tab (a_tab_array: POINTER; a_tab_index, a_tab_alignment, a_location: INTEGER_32)
		external
			"C signature (PangoTabArray*, gint, PangoTabAlign, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_tab_array_free (a_tab_array: POINTER)
		external
			"C signature (PangoTabArray*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_view_set_tabs (a_text_view, a_tab_array: POINTER)
		external
			"C signature (GtkTextView*, PangoTabArray*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_event_window_state_struct_changed_mask (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventWindowState): EIF_INTEGER"
		alias
			"changed_mask"
		ensure
			is_class: class
		end

	frozen gdk_event_window_state_struct_new_window_state (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventWindowState): EIF_INTEGER"
		alias
			"new_window_state"
		ensure
			is_class: class
		end

	frozen gdk_window_state_withdrawn_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_WINDOW_STATE_WITHDRAWN"
		ensure
			is_class: class
		end

	frozen gdk_window_state_iconified_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_WINDOW_STATE_ICONIFIED"
		ensure
			is_class: class
		end

	frozen gdk_window_state_maximized_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_WINDOW_STATE_MAXIMIZED"
		ensure
			is_class: class
		end

	frozen gdk_window_state_sticky_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_WINDOW_STATE_STICKY"
		ensure
			is_class: class
		end

	frozen gdk_window_state_fullscreen_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_WINDOW_STATE_FULLSCREEN"
		ensure
			is_class: class
		end

	frozen gdk_window_state_above_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_WINDOW_STATE_ABOVE"
		ensure
			is_class: class
		end

	frozen gdk_window_state_below_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_WINDOW_STATE_BELOW"
		ensure
			is_class: class
		end

	frozen pango_pixels (a_value: INTEGER_32): INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"PANGO_PIXELS"
		ensure
			is_class: class
		end

	frozen gtk_widget_set_redraw_on_allocate (a_widget: POINTER; redraw_on_allocate: BOOLEAN)
		external
			"C signature (GtkWidget*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_set_double_buffered (a_widget: POINTER; is_buffered: BOOLEAN)
		external
			"C signature (GtkWidget*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_invalidate_rect (a_window, a_rectangle: POINTER; invalidate_children: BOOLEAN)
		external
			"C signature (GdkWindow*, GdkRectangle*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_set_debug_updates (a_setting: BOOLEAN)
		external
			"C signature (gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_set_modal_hint (a_window: POINTER; a_hint: BOOLEAN)
		external
			"C signature (GdkWindow*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_peek_children (a_window: POINTER): POINTER
		external
			"C signature (GdkWindow*): GList use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_process_updates (a_window: POINTER; process_children: BOOLEAN)
		external
			"C signature (GdkWindow*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_event_box_set_visible_window (a_event_box: POINTER; visible_window: BOOLEAN)
		external
			"C signature (GtkEventBox*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_event_box_set_above_child (a_event_box: POINTER; above_child: BOOLEAN)
		external
			"C signature (GtkEventBox*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_scroll_up_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_SCROLL_UP"
		ensure
			is_class: class
		end

	frozen gdk_scroll_down_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_SCROLL_DOWN"
		ensure
			is_class: class
		end

	frozen gdk_window_freeze_updates (a_window: POINTER)
		external
			"C signature (GdkWindow*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_thaw_updates (a_window: POINTER)
		external
			"C signature (GdkWindow*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_set_minimum_size (a_widget: POINTER; a_width, a_height: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_set_size_request ((GtkWidget*) $a_widget, (gint) $a_width, (gint) $a_height)"
		ensure
			is_class: class
		end

	frozen gtk_widget_size_allocate (a_widget: POINTER; a_allocation: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_size_allocate ((GtkWidget*) $a_widget, (GtkAllocation*) $a_allocation)"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_list_filters (a_file_chooser: POINTER): POINTER
		external
			"C signature (GtkFileChooser*): GSList use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen c_pango_rectangle_struct_allocate: POINTER
		external
			"C [macro <ev_gtk.h>]"
		alias
			"calloc (sizeof(PangoRectangle), 1)"
		ensure
			is_class: class
		end

	frozen pango_rectangle_struct_x (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"x"
		ensure
			is_class: class
		end

	frozen pango_rectangle_struct_y (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"y"
		ensure
			is_class: class
		end

	frozen pango_rectangle_struct_width (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"width"
		ensure
			is_class: class
		end

	frozen pango_rectangle_struct_height (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"height"
		ensure
			is_class: class
		end

	frozen pango_layout_get_extents (a_layout: POINTER; ink_rect, logical_rect: POINTER)
		external
			"C signature (PangoLayout*, PangoRectangle*, PangoRectangle*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_layout_get_pixel_extents (a_layout: POINTER; ink_rect, logical_rect: POINTER)
		external
			"C signature (PangoLayout*, PangoRectangle*, PangoRectangle*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_layout_get_size (a_layout: POINTER; a_width, a_height: TYPED_POINTER [INTEGER_32])
		external
			"C signature (PangoLayout*, gint*, gint*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_layout_context_changed (a_layout: POINTER)
		external
			"C signature (PangoLayout*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_event_scroll_struct_scroll_direction (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventScroll): EIF_INTEGER"
		alias
			"direction"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_scroll_to_cell (a_tree_view, a_tree_path, a_tree_column: POINTER; use_align: BOOLEAN; x_align, y_align: REAL_32)
		external
			"C signature (GtkTreeView*, GtkTreePath*, GtkTreeViewColumn*, gboolean, gfloat, gfloat) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_style_get_integer (a_widget, a_property: POINTER; a_int_ptr: TYPED_POINTER [INTEGER_32])
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_style_get ((GtkWidget*) $a_widget, (gchar*) $a_property, (gint*) $a_int_ptr, NULL);"
		ensure
			is_class: class
		end

	frozen gdk_display_get_default: POINTER
		external
			"C signature (): GdkDisplay* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_display_get_name (a_display: POINTER): POINTER
		external
			"C signature (GdkDisplay*): gchar** use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_display_get_default_screen (a_display: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_display_get_default_screen ((GdkDisplay*) $a_display)"
		ensure
			is_class: class
		end

	frozen gdk_display_supports_composite (a_display: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 12
					return gdk_display_supports_composite ((GdkDisplay*) $a_display);
				#endif
			]"
		ensure
			is_class: class
		end

	frozen gdk_display_supports_cursor_alpha (a_display: POINTER): BOOLEAN
		external
			"C signature (GdkDisplay*): gboolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_display_supports_cursor_color (a_display: POINTER): BOOLEAN
		external
			"C signature (GdkDisplay*): gboolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_display_get_pointer (a_display: POINTER; a_screen: TYPED_POINTER [POINTER]; a_win_x, a_win_y: TYPED_POINTER [INTEGER_32]; a_mod_mask: TYPED_POINTER [NATURAL_32])
		external
			"C signature (GdkDisplay*, GdkScreen**, gint*, gint*, GdkModifierType*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_display_get_window_at_pointer (a_display: POINTER; a_win_x, a_win_y: TYPED_POINTER [INTEGER]): POINTER
		external
			"C signature (GdkDisplay*, gint*, gint*): GdkWindow* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_cursor_new_from_pixbuf (a_display, a_pixbuf: POINTER; a_x, a_y: INTEGER_32): POINTER
		external
			"C signature (GdkDisplay*, GdkPixbuf*, gint, gint): GdkCursor* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_cursor_unref (a_cursor: POINTER)
		external
			"C signature (GdkCursor *) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tool_item_set_tooltip (a_tool_item, a_tooltips, a_tip_text, a_tip_private: POINTER)
		external
			"C signature (GtkToolItem*, GtkTooltips*, gchar*, gchar*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_get_expander_column (a_tree_view: POINTER): POINTER
		external
			"C signature (GtkTreeView*): GtkTreeViewColumn* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_add_alpha (a_pixbuf: POINTER; substitute_color: BOOLEAN; r, g, b: NATURAL_8): POINTER
		external
			"C signature (GdkPixbuf*, gboolean, guchar, guchar, guchar): GdkPixbuf* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_pixbuf (a_drawable, a_gc, a_pixbuf: POINTER; src_x, src_y, dest_x, dest_y, a_width, a_height, a_dither, x_dither, y_dither: INTEGER_32)
		external
			"C signature (GdkDrawable*, GdkGC*, GdkPixbuf*, gint, gint, gint, gint, gint , gint, gint, gint, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tree_path_new_from_string (a_string: POINTER): POINTER
		external
			"C signature (gchar*): GtkTreePath* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_separator_tool_item_new: POINTER
		external
			"C signature (): GtkToolItem* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_separator_tool_item_set_draw (a_tool_item: POINTER; a_draw: BOOLEAN)
		external
			"C signature (GtkSeparatorToolItem*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_toolbar_set_show_arrow (a_toolbar: POINTER; show_arrow: BOOLEAN)
		external
			"C signature (GtkToolbar*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tool_item_set_is_important (a_toolitem: POINTER; is_important: BOOLEAN)
		external
			"C signature (GtkToolItem*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_toggle_tool_button_set_active (a_button: POINTER; a_active: BOOLEAN)
		external
			"C signature (GtkToggleToolButton*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_toggle_tool_button_get_active (a_button: POINTER): BOOLEAN
		external
			"C signature (GtkToggleToolButton*): gboolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_toolbar_set_tooltips (a_toolbar: POINTER; a_enable: BOOLEAN)
		external
			"C signature (GtkToolbar*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_toolbar_new: POINTER
		external
			"C signature () use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tool_button_new (icon_widget, a_label_text: POINTER): POINTER
		external
			"C signature (GtkWidget*, gchar*): GtkToolItem* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_radio_tool_button_new (a_radio_group: POINTER): POINTER
		external
			"C signature (GSList*): GtkToolItem* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_radio_tool_button_set_group (a_radio_button, a_radio_group: POINTER)
		external
			"C signature (GtkRadioToolButton*, GSList*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_radio_tool_button_get_group (a_radio_button: POINTER): POINTER
		external
			"C signature (GtkRadioToolButton*): GSList* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_toolbar_icons_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_TOOLBAR_ICONS"
		ensure
			is_class: class
		end

	frozen gtk_toolbar_text_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_TOOLBAR_TEXT"
		ensure
			is_class: class
		end

	frozen gtk_toolbar_both_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_TOOLBAR_BOTH"
		ensure
			is_class: class
		end

	frozen gtk_toolbar_both_horiz_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_TOOLBAR_BOTH_HORIZ"
		ensure
			is_class: class
		end

	frozen gtk_toggle_tool_button_new: POINTER
		external
			"C signature (): GtkToolItem* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tool_button_set_icon_widget (tool_button, icon_widget: POINTER)
		external
			"C signature (GtkToolButton*, GtkWidget*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tool_button_set_label (tool_button, a_text: POINTER)
		external
			"C signature (GtkToolButton*, gchar*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tool_button_get_label (tool_button: POINTER): POINTER
		external
			"C signature (GtkToolButton*): gchar* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_toolbar_insert (a_toolbar, a_toolitem: POINTER; a_pos: INTEGER_32)
		external
			"C signature (GtkToolbar*, GtkToolItem*, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_file_filter_new: POINTER
		external
			"C signature () use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_file_filter_add_pattern (a_filter, a_pattern: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_filter_add_pattern ((GtkFileFilter*) $a_filter, (gchar*) $a_pattern)"
		ensure
			is_class: class
		end

	frozen gtk_file_filter_set_name (a_filter, a_name: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_filter_set_name ((GtkFileFilter*) $a_filter, (gchar*) $a_name)"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_set_filter (a_file_chooser, a_filter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_set_filter ((GtkFileChooser*) $a_file_chooser, (GtkFileFilter*) $a_filter)"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_add_filter (a_file_chooser, a_filter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_add_filter ((GtkFileChooser*) $a_file_chooser, (GtkFileFilter*) $a_filter)"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_remove_filter (a_file_chooser, a_filter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_remove_filter ((GtkFileChooser*) $a_file_chooser, (GtkFileFilter*) $a_filter)"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_action_open_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_FILE_CHOOSER_ACTION_OPEN"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_action_save_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_FILE_CHOOSER_ACTION_SAVE"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_action_select_folder_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_action_create_folder_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_FILE_CHOOSER_ACTION_CREATE_FOLDER"
		ensure
			is_class: class
		end

	frozen gtk_dialog_add_button (a_dialog, a_text: POINTER; a_response_id: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_dialog_add_button ((GtkDialog*) $a_dialog, (gchar*) $a_text, (gint) $a_response_id)"
		ensure
			is_class: class
		end

	frozen gtk_dialog_set_default_response (a_dialog: POINTER; a_response_id: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_dialog_set_default_response ((GtkDialog*) $a_dialog, (gint) $a_response_id)"
		ensure
			is_class: class
		end

	frozen gtk_stock_ok_enum: POINTER
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STOCK_OK"
		ensure
			is_class: class
		end

	frozen gtk_stock_open_enum: POINTER
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STOCK_OPEN"
		ensure
			is_class: class
		end

	frozen gtk_response_accept_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_RESPONSE_ACCEPT"
		ensure
			is_class: class
		end

	frozen gtk_response_cancel_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_RESPONSE_CANCEL"
		ensure
			is_class: class
		end

	frozen gtk_stock_save_enum: POINTER
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STOCK_SAVE"
		ensure
			is_class: class
		end

	frozen gtk_stock_cancel_enum: POINTER
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_STOCK_CANCEL"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_dialog_new (a_title, a_parent: POINTER; a_action: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_dialog_new ((gchar*) $a_title, (GtkWindow*) $a_parent, (GtkFileChooserAction) $a_action, NULL, NULL)"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser (a_dialog: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GTK_FILE_CHOOSER ( $a_dialog )"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_get_filename (a_dialog: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_get_filename ((GtkFileChooser*) $a_dialog)"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_get_filenames (a_dialog: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_get_filenames ((GtkFileChooser*) $a_dialog)"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_set_filename (a_dialog: POINTER; a_filename: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_set_filename ((GtkFileChooser*) $a_dialog, (gchar*) $a_filename)"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_set_current_name (a_dialog: POINTER; a_filename: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_set_current_name ((GtkFileChooser*) $a_dialog, (gchar*) $a_filename)"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_set_local_only (a_dialog: POINTER; a_local_only: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_set_local_only ((GtkFileChooser*) $a_dialog, (gboolean) $a_local_only)"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_set_select_multiple (a_dialog: POINTER; a_multiple: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_file_chooser_set_select_multiple ((GtkFileChooser*) $a_dialog, (gboolean) $a_multiple)"
		ensure
			is_class: class
		end

	frozen gtk_file_chooser_get_filter (a_dialog: POINTER): POINTER
		external
			"C signature (GtkFileChooser*): GtkFileFilter* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_combo_box_get_entry (a_combo: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"GTK_ENTRY (GTK_BIN ( $a_combo )->child)"
		ensure
			is_class: class
		end

	frozen gtk_combo_box_get_active (a_combo: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_combo_box_get_active ((GtkComboBox*) $a_combo)"
		ensure
			is_class: class
		end

	frozen gtk_combo_box_set_active (a_combo: POINTER; a_active: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_combo_box_set_active ((GtkComboBox*) $a_combo, (gint) $a_active)"
		ensure
			is_class: class
		end

	frozen gtk_entry_get_completion (a_entry: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_entry_get_completion ((GtkEntry*) $a_entry)"
		ensure
			is_class: class
		end

	frozen gtk_combo_box_entry_new: POINTER
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_combo_box_new: POINTER
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_combo_box_set_model (a_combo_box, a_model: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_combo_box_set_model ((GtkComboBox*) $a_combo_box, (GtkTreeModel*) $a_model)"
		ensure
			is_class: class
		end

	frozen gtk_combo_box_entry_set_text_column (a_combo_box: POINTER; a_column: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_combo_box_entry_set_text_column ((GtkComboBoxEntry*) $a_combo_box, (gint) $a_column)"
		ensure
			is_class: class
		end

	frozen gtk_cell_layout_pack_start (a_cell_layout, a_cell_renderer: POINTER; a_expand: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_cell_layout_pack_start ((GtkCellLayout*) $a_cell_layout, (GtkCellRenderer*) $a_cell_renderer, (gboolean) $a_expand)"
		ensure
			is_class: class
		end

	frozen gtk_cell_layout_set_attribute (a_cell_layout, a_cell_renderer, a_attribute: POINTER; a_pos: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_cell_layout_set_attributes ((GtkCellLayout*) $a_cell_layout, (GtkCellRenderer*) $a_cell_renderer, (gchar*) $a_attribute, (gint) $a_pos, NULL)"
		ensure
			is_class: class
		end

	frozen gtk_cell_layout_reorder (a_cell_layout, a_cell_renderer: POINTER; a_pos: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_cell_layout_reorder ((GtkCellLayout*) $a_cell_layout, (GtkCellRenderer*) $a_cell_renderer, (gint) $a_pos)"
		ensure
			is_class: class
		end

	frozen gtk_cell_layout_clear (a_cell_layout: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_cell_layout_clear ((GtkCellLayout*) $a_cell_layout)"
		ensure
			is_class: class
		end

	frozen gtk_tree_path_free (a_tree_path: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_path_free ((GtkTreePath*) $a_tree_path)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_get_path_at_pos (a_tree_view: POINTER; a_x, a_y: INTEGER_32; a_tree_path, a_tree_column: POINTER; a_cell_x, a_cell_y: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_get_path_at_pos ((GtkTreeView*) $a_tree_view, (gint) $a_x, (gint) $a_y, (GtkTreePath**) $a_tree_path, (GtkTreeViewColumn**) $a_tree_column, (gint*) $a_cell_x, (gint*) $a_cell_y)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_set_rules_hint (a_tree_view: POINTER; a_hint: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_set_rules_hint ((GtkTreeView*) $a_tree_view, (gboolean) $a_hint)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_get_cell_renderers (a_tree_view_column: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_get_cell_renderers ((GtkTreeViewColumn*) $a_tree_view_column)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_cell_get_size (a_tree_view_column: POINTER; a_cell_area: POINTER; a_x_offset, a_y_offset, a_width, a_height: TYPED_POINTER [INTEGER_32])
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_cell_get_size ((GtkTreeViewColumn*) $a_tree_view_column, (GdkRectangle*) $a_cell_area, (gint*) $a_x_offset, (gint*) $a_y_offset, (gint*) $a_width, (gint*) $a_height)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_columns_autosize (a_tree_view: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_columns_autosize ((GtkTreeView*) $a_tree_view)"
		ensure
			is_class: class
		end

	frozen gtk_tree_store_clear (a_tree_store: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_clear ((GtkTreeStore*) $a_tree_store)"
		ensure
			is_class: class
		end

	frozen gtk_list_store_clear (a_list_store: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_clear ((GtkListStore*) $a_list_store)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_get_headers_visible (a_tree_view: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_get_headers_visible ((GtkTreeView*) $a_tree_view)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_set_headers_visible (a_tree_view: POINTER; a_visible: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_set_headers_visible ((GtkTreeView*) $a_tree_view, (gboolean) $a_visible)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_set_enable_search (a_tree_view: POINTER; enable_search: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_set_enable_search ((GtkTreeView*) $a_tree_view, (gboolean) $enable_search)"
		ensure
			is_class: class
		end

	frozen gtk_tree_path_get_depth (a_tree_path: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_path_get_depth ((GtkTreePath*) $a_tree_path)"
		ensure
			is_class: class
		end

	frozen gtk_tree_path_get_indices (a_tree_path: POINTER): POINTER
		external
			"C signature (GtkTreePath*): gint* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen sizeof_gint: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"sizeof(gint)"
		ensure
			is_class: class
		end

	frozen gtk_tree_path_next (a_tree_path: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_path_next ((GtkTreePath*) $a_tree_path)"
		ensure
			is_class: class
		end

	frozen gtk_tree_path_prev (a_tree_path: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_path_prev ((GtkTreePath*) $a_tree_path)"
		ensure
			is_class: class
		end

	frozen gtk_tree_path_up (a_tree_path: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_path_up ((GtkTreePath*) $a_tree_path)"
		ensure
			is_class: class
		end

	frozen gtk_tree_path_down (a_tree_path: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_path_down ((GtkTreePath*) $a_tree_path)"
		ensure
			is_class: class
		end

	frozen gtk_tree_selection_get_selected_rows (a_tree_selection: POINTER; a_model: TYPED_POINTER [POINTER]): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_get_selected_rows ((GtkTreeSelection*) $a_tree_selection, (GtkTreeModel**) $a_model)"
		ensure
			is_class: class
		end

	frozen gtk_tree_selection_count_selected_rows (a_tree_selection: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_count_selected_rows ((GtkTreeSelection*) $a_tree_selection)"
		ensure
			is_class: class
		end

	frozen gtk_tree_selection_select_iter (a_tree_selection, a_tree_iter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_select_iter ((GtkTreeSelection*) $a_tree_selection, (GtkTreeIter*) $a_tree_iter)"
		ensure
			is_class: class
		end

	frozen gtk_tree_selection_unselect_iter (a_tree_selection, a_tree_iter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_unselect_iter ((GtkTreeSelection*) $a_tree_selection, (GtkTreeIter*) $a_tree_iter)"
		ensure
			is_class: class
		end

	frozen gtk_tree_selection_select_all (a_tree_selection: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_select_all ((GtkTreeSelection*) $a_tree_selection)"
		ensure
			is_class: class
		end

	frozen gtk_tree_selection_unselect_all (a_tree_selection: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_unselect_all ((GtkTreeSelection*) $a_tree_selection)"
		ensure
			is_class: class
		end

	frozen gtk_tree_model_get_n_columns (a_tree_model: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_model_get_n_columns ((GtkTreeModel*) $a_tree_model)"
		ensure
			is_class: class
		end

	frozen gtk_tree_model_get_iter (a_tree_model, a_tree_iter, a_tree_path: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_model_get_iter ((GtkTreeModel*) $a_tree_model, (GtkTreeIter*) $a_tree_iter, (GtkTreePath*) $a_tree_path)"
		ensure
			is_class: class
		end

	frozen gtk_tree_model_get_path (a_tree_model, a_tree_iter: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_model_get_path ((GtkTreeModel*) $a_tree_model, (GtkTreeIter*) $a_tree_iter)"
		ensure
			is_class: class
		end

	frozen gtk_tree_model_get_value (a_tree_model, a_tree_iter: POINTER; a_column: INTEGER_32; a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_model_get_value ((GtkTreeModel*) $a_tree_model, (GtkTreeIter*) $a_tree_iter, (gint) $a_column, (GValue*) $a_value)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_row_expanded (a_tree_view, a_tree_path: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_row_expanded ((GtkTreeView*) $a_tree_view, (GtkTreePath*) $a_tree_path)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_expand_row (a_tree_view, a_tree_path: POINTER; open_all: BOOLEAN): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_expand_row ((GtkTreeView*) $a_tree_view, (GtkTreePath*) $a_tree_path, (gboolean) $open_all)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_expand_to_path (a_tree_view, a_tree_path: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_expand_to_path ((GtkTreeView*) $a_tree_view, (GtkTreePath*) $a_tree_path)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_collapse_row (a_tree_view, a_tree_path: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_collapse_row ((GtkTreeView*) $a_tree_view, (GtkTreePath*) $a_tree_path)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_get_column (a_tree_view: POINTER; a_index: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_get_column ((GtkTreeView*) $a_tree_view, (gint) $a_index)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_get_bin_window (a_tree_view: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_get_bin_window ((GtkTreeView*) $a_tree_view)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_get_columns (a_tree_view: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_get_columns ((GtkTreeView*) $a_tree_view)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_get_selection (a_tree_view: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_get_selection ((GtkTreeView*) $a_tree_view)"
		ensure
			is_class: class
		end

	frozen gtk_tree_selection_set_mode (a_tree_sel: POINTER; a_mode: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_set_mode ((GtkTreeSelection*) $a_tree_sel, (GtkSelectionMode) $a_mode)"
		ensure
			is_class: class
		end

	frozen gtk_tree_selection_get_mode (a_tree_sel: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_selection_get_mode ((GtkTreeSelection*) $a_tree_sel)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_set_alignment (a_tree_view_column: POINTER; a_align: REAL_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_alignment ((GtkTreeViewColumn*) $a_tree_view_column, (gfloat) $a_align)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_set_fixed_width (a_tree_view_column: POINTER; a_width: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_fixed_width ((GtkTreeViewColumn*) $a_tree_view_column, (gint) $a_width)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_get_fixed_width (a_tree_view_column: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_get_fixed_width ((GtkTreeViewColumn*) $a_tree_view_column)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_set_sizing (a_tree_view_column: POINTER; a_size_mode: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_sizing ((GtkTreeViewColumn*) $a_tree_view_column, (GtkTreeViewColumnSizing) $a_size_mode)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_set_resizable (a_tree_view_column: POINTER; a_expand: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_resizable ((GtkTreeViewColumn*) $a_tree_view_column, (gboolean) $a_expand)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_set_clickable (a_tree_view_column: POINTER; a_clickable: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_clickable ((GtkTreeViewColumn*) $a_tree_view_column, (gboolean) $a_clickable)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_set_widget (a_tree_view_column: POINTER; a_widget: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_widget ((GtkTreeViewColumn*) $a_tree_view_column, (GtkWidget*) $a_widget)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_get_widget (a_tree_view_column: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_get_widget ((GtkTreeViewColumn*) $a_tree_view_column)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_get_width (a_tree_view_column: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_get_width ((GtkTreeViewColumn*) $a_tree_view_column)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_set_visible (a_tree_view_column: POINTER; a_visible: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_visible ((GtkTreeViewColumn*) $a_tree_view_column, (gboolean) $a_visible)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_set_min_width (a_tree_view_column: POINTER; a_width: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_min_width ((GtkTreeViewColumn*) $a_tree_view_column, (gint) $a_width)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_set_max_width (a_tree_view_column: POINTER; a_width: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_max_width ((GtkTreeViewColumn*) $a_tree_view_column, (gint) $a_width)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_add_attribute (a_tree_view_column, a_cell_renderer, a_attribute: POINTER; a_column: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_add_attribute ((GtkTreeViewColumn*) $a_tree_view_column, (GtkCellRenderer*) $a_cell_renderer, (gchar*) $a_attribute, (gint) $a_column)"
		ensure
			is_class: class
		end

	frozen gtk_cell_renderer_text_new: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_cell_renderer_text_new()"
		ensure
			is_class: class
		end

	frozen gtk_cell_renderer_pixbuf_new: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_cell_renderer_pixbuf_new()"
		ensure
			is_class: class
		end

	frozen gtk_cell_renderer_get_size (a_cell_renderer, a_widget, a_cell_area, a_x_offset, a_y_offset, a_width, a_height: POINTER)
		external
			"C signature (GtkCellRenderer*, GtkWidget*, GdkRectangle*, gint*, gint*, gint*, gint*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_cell_renderer_get_fixed_size (a_cell_renderer, a_width, a_height: POINTER)
		external
			"C signature (GtkCellRenderer*, gint*, gint*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_cell_renderer_set_fixed_size (a_cell_renderer: POINTER; a_width, a_height: INTEGER_32)
		external
			"C signature (GtkCellRenderer*, gint, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_cell_renderer_toggle_new: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_cell_renderer_toggle_new()"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_insert_column (a_tree_view: POINTER; a_column: POINTER; a_position: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_insert_column ((GtkTreeView*) $a_tree_view, (GtkTreeViewColumn*) $a_column, (gint) $a_position)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_remove_column (a_tree_view: POINTER; a_column: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_remove_column ((GtkTreeView*) $a_tree_view, (GtkTreeViewColumn*) $a_column)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_append_column (a_tree_view: POINTER; a_column: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_append_column ((GtkTreeView*) $a_tree_view, (GtkTreeViewColumn*) $a_column)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_new: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_new()"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_set_title (a_tree_column, a_title: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_set_title((GtkTreeViewColumn*) $a_tree_column, (gchar*) $a_title)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_pack_start (a_tree_column, a_cell_renderer: POINTER; a_expand: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_pack_start ((GtkTreeViewColumn*) $a_tree_column, (GtkCellRenderer*) $a_cell_renderer, (gboolean) $a_expand)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_column_pack_end (a_tree_column, a_cell_renderer: POINTER; a_expand: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_view_column_pack_end ((GtkTreeViewColumn*) $a_tree_column, (GtkCellRenderer*) $a_cell_renderer, (gboolean) $a_expand)"
		ensure
			is_class: class
		end

	frozen gdk_type_pixbuf: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"GDK_TYPE_PIXBUF"
		ensure
			is_class: class
		end

	frozen c_g_value_struct_allocate: POINTER
		external
			"C [macro <ev_gtk.h>]"
		alias
			"calloc (sizeof(GValue), 1)"
		ensure
			is_class: class
		end

	frozen c_gtk_tree_iter_allocate: POINTER
		external
			"C [macro <ev_gtk.h>]"
		alias
			"calloc (sizeof(GtkTreeIter), 1)"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_new: POINTER
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tree_view_set_model (a_view, a_model: POINTER)
		external
			"C signature (GtkTreeView*, GtkTreeModel*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tree_store_newv (n_columns: INTEGER_32; types: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_newv ((gint) $n_columns, (GType*) $types)"
		ensure
			is_class: class
		end

	frozen gtk_list_store_newv (n_columns: INTEGER_32; types: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_newv ((gint) $n_columns, (GType*) $types)"
		ensure
			is_class: class
		end

	frozen gtk_tree_store_append (a_tree_store, a_tree_iter, a_parent_iter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_append ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter, (GtkTreeIter*) $a_parent_iter)"
		ensure
			is_class: class
		end

	frozen gtk_list_store_append (a_list_store, a_tree_iter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_append ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter)"
		ensure
			is_class: class
		end

	frozen gtk_tree_store_insert (a_tree_store, a_tree_iter, a_parent_iter: POINTER; a_index: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_insert ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter, (GtkTreeIter*) $a_parent_iter, (gint) $a_index)"
		ensure
			is_class: class
		end

	frozen gtk_list_store_insert (a_list_store, a_tree_iter: POINTER; a_index: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_insert ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index)"
		ensure
			is_class: class
		end

	frozen gtk_tree_store_remove (a_tree_store, a_tree_iter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_remove ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter)"
		ensure
			is_class: class
		end

	frozen gtk_list_store_remove (a_list_store, a_tree_iter: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_remove ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter)"
		ensure
			is_class: class
		end

	frozen gtk_tree_store_set_value (a_tree_store, a_tree_iter: POINTER; a_index: INTEGER_32; a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_set_value ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index, (GValue*) $a_value)"
		ensure
			is_class: class
		end

	frozen gtk_list_store_set_value (a_list_store, a_tree_iter: POINTER; a_index: INTEGER_32; a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_set_value ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index, (GValue*) $a_value)"
		ensure
			is_class: class
		end

	frozen gtk_tree_store_set_pixbuf (a_tree_store, a_tree_iter: POINTER; a_index: INTEGER_32; a_pixbuf: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_tree_store_set ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index, (GdkPixbuf*) $a_pixbuf, -1)"
		ensure
			is_class: class
		end

	frozen gtk_list_store_set_pixbuf (a_list_store, a_tree_iter: POINTER; a_index: INTEGER_32; a_pixbuf: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_list_store_set ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index, (GdkPixbuf*) $a_pixbuf, -1)"
		ensure
			is_class: class
		end

	frozen pango_underline_none_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"PANGO_UNDERLINE_NONE"
		ensure
			is_class: class
		end

	frozen pango_underline_single_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"PANGO_UNDERLINE_SINGLE"
		ensure
			is_class: class
		end

	frozen pango_underline_double_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"PANGO_UNDERLINE_DOUBLE"
		ensure
			is_class: class
		end

	frozen gdk_screen_get_default: POINTER
		external
			"C signature (): GdkScreen* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_screen_get_root_window (a_screen: POINTER): POINTER
		external
			"C signature (GdkScreen*): GdkWindow* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_screen_get_width_mm (a_screen: POINTER): INTEGER_32
		external
			"C signature (GdkScreen*): gint use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_screen_get_height_mm (a_screen: POINTER): INTEGER_32
		external
			"C signature (GdkScreen*): gint use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_screen_get_n_monitors (a_screen: POINTER): INTEGER_32
		external
			"C signature (GdkScreen*): gint use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_screen_get_monitor_geometry (a_screen: POINTER; a_monitor_number: INTEGER_32; a_rect: POINTER)
		external
			"C signature (GdkScreen*, gint, GdkRectangle*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_screen_get_monitor_at_point (a_screen: POINTER; a_x, a_y: INTEGER_32): INTEGER_32
		external
			"C signature (GdkScreen*, gint, gint): gint use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_screen_get_monitor_at_window (a_screen: POINTER; a_window: POINTER): INTEGER_32
		external
			"C signature (GdkScreen*, GdkWindow*): gint use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_get_frame_extents (a_window, a_rect: POINTER)
		external
			"C signature (GdkWindow*, GdkRectangle*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_get_update_area (a_window: POINTER): POINTER
		external
			"C signature (GdkWindow*): GdkRegion* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_is_viewable (a_window: POINTER): BOOLEAN
		external
			"C signature (GdkWindow*): EIF_BOOLEAN use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_visual_get_best_depth: INTEGER
		external
			"C signature (): EIF_INTEGER use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_query_depths (a_depths, a_count: POINTER)
		external
			"C signature (gint**, gint*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_window_is_visible (a_window: POINTER): BOOLEAN
		external
			"C signature (GdkWindow*): EIF_BOOLEAN use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_entry_set_max_length (a_entry: POINTER; a_max: INTEGER_32)
		external
			"C (GtkEntry*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_entry_set_width_chars (a_entry: POINTER; a_width: INTEGER_32)
		external
			"C (GtkEntry*, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_fixed_get_type: INTEGER_32
		external
			"C (): GtkType | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_fixed_move (a_fixed: POINTER; a_widget: POINTER; a_x: INTEGER_32; a_y: INTEGER_32)
		external
			"C (GtkFixed*, GtkWidget*, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_fixed_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_fixed_put (a_fixed: POINTER; a_widget: POINTER; a_x: INTEGER_32; a_y: INTEGER_32)
		external
			"C (GtkFixed*, GtkWidget*, gint, gint) | <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen set_gdk_rectangle_struct_height (a_c_struct: POINTER; a_height: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkRectangle, gint)"
		alias
			"height"
		ensure
			is_class: class
		end

	frozen set_gdk_rectangle_struct_width (a_c_struct: POINTER; a_width: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkRectangle, gint)"
		alias
			"width"
		ensure
			is_class: class
		end

	frozen set_gdk_rectangle_struct_x (a_c_struct: POINTER; a_x: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkRectangle, gint)"
		alias
			"x"
		ensure
			is_class: class
		end

	frozen set_gdk_rectangle_struct_y (a_c_struct: POINTER; a_y: INTEGER_32)
		external
			"C [struct <ev_gtk.h>] (GdkRectangle, gint)"
		alias
			"y"
		ensure
			is_class: class
		end

	frozen gtk_args_array_i_th (args_array: POINTER; an_index: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"((GValue*)$args_array + (int)($an_index))"
		ensure
			is_class: class
		end

	frozen gtk_color_selection_dialog_struct_color_selection (a_color_selection_dialog: POINTER): POINTER
		external
			"C struct GtkColorSelectionDialog access colorsel use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_color_selection_get_current_color (a_color_selection, a_color: POINTER)
		external
			"C signature (GtkColorSelection*, GdkColor*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_color_selection_set_current_color (a_color_selection, a_color: POINTER)
		external
			"C signature (GtkColorSelection*, GdkColor*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_colormap_query_color (a_color_map: POINTER; a_pixel: INTEGER_32; a_color: POINTER)
		external
			"C signature (GdkColormap*, gulong, GdkColor*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_scale_simple (a_gdkpixbuf: POINTER; a_width, a_height, a_interp_mode: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_pixbuf_scale_simple ((GdkPixbuf*) $a_gdkpixbuf, (int) $a_width, (int) $a_height, (int) $a_interp_mode)"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_scale (src, dest: POINTER; dest_x, dest_y, dest_width, dest_height: INTEGER_32; offset_x, offset_y, scale_x, scale_y: REAL_64; interp_type: INTEGER_32)
		external
			"C signature (GdkPixbuf*, GdkPixbuf*, int, int, int, int, double, double, double, double, GdkInterpType) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_interp_bilinear: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_INTERP_BILINEAR"
		ensure
			is_class: class
		end

	frozen gdk_interp_hyper: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_INTERP_HYPER"
		ensure
			is_class: class
		end

	frozen gdk_interp_nearest: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_INTERP_NEAREST"
		ensure
			is_class: class
		end

	frozen gdk_interp_tiles: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_INTERP_TILES"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_composite (src, dest: POINTER; dest_x, dest_y, dest_width, dest_height: INTEGER_32; offset_x, offset_y, scale_x, scale_y: REAL_64; interp_type, overall_alpha: INTEGER_32)
		external
			"C signature (GdkPixbuf*, GdkPixbuf*, int, int, int, int, double, double, double, double, GdkInterpType, int) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_copy_area (src: POINTER; src_x, src_y, a_width, a_height: INTEGER_32; dest: POINTER; dest_x, dest_y: INTEGER_32)
		external
			"C signature (GdkPixbuf*, int, int, int, int, GdkPixbuf*, int, int) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_render_icon (a_widget, a_stock_id: POINTER; a_icon_size: INTEGER_32; a_detail: POINTER): POINTER
		external
			"C signature (GtkWidget*, gchar*, GtkIconSize, gchar*): GdkPixbuf* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_image_set_from_stock (a_image, a_stock_id: POINTER; a_icon_size: INTEGER_32)
		external
			"C signature (GtkImage*, gchar*, GtkIconSize) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_modify_text (a_widget: POINTER; a_state_type: INTEGER_32; a_color: POINTER)
		external
			"C signature (GtkWidget*, GtkStateType, GdkColor*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_modify_base (a_widget: POINTER; a_state_type: INTEGER_32; a_color: POINTER)
		external
			"C signature (GtkWidget*, GtkStateType, GdkColor*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_image_menu_item_new: POINTER
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_accel_label_new (a_string: POINTER): POINTER
		external
			"C signature (gchar*): GtkWidget* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_tearoff_menu_item_new: POINTER
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_image_menu_item_set_image (a_menu_item, a_image: POINTER)
		external
			"C signature (GtkImageMenuItem*, GtkWidget*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_menu_item_new_with_mnemonic (a_label: POINTER): POINTER
		external
			"C signature (gchar*): GtkWidget* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_label_set_text_with_mnemonic (a_label, a_text: POINTER)
		external
			"C signature (GtkLabel*, gchar*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_accel_groups_activate (a_object: POINTER; a_key, a_modifier_type: INTEGER_32): BOOLEAN
		external
			"C signature (GObject*, guint, GdkModifierType): gboolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_present (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_iconify (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_deiconify (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_stick (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_unstick (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_maximize (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_unmaximize (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_fullscreen (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_window_unfullscreen (a_window: POINTER)
		external
			"C signature (GtkWindow*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_get_formats: POINTER
		external
			"C signature (): GSList* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_get_has_alpha (a_pixbuf: POINTER): BOOLEAN
		external
			"C signature (GdkPixbuf*): gboolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_format_is_writable (a_pixbuf_format: POINTER): BOOLEAN
		external
			"C signature (GdkPixbufFormat*): gboolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_format_get_name (a_pixbuf_format: POINTER): POINTER
		external
			"C signature (GdkPixbufFormat*): gchar* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_save (a_pixbuf, a_file_handle, a_filetype: POINTER; a_error: TYPED_POINTER [POINTER])
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_pixbuf_save ((GdkPixbuf*) $a_pixbuf, (char*) $a_file_handle, (char*) $a_filetype, (GError**) $a_error, NULL)"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_get_from_drawable (a_pixbuf, a_drawable, a_colormap: POINTER; src_x, src_y, dest_x, dest_y, a_width, a_height: INTEGER_32): POINTER
		external
			"C signature (GdkPixbuf*, GdkDrawable*, GdkColormap*, int, int, int, int, int, int): GdkPixbuf use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_pixbuf_get_from_image (a_pixbuf, a_drawable, a_colormap: POINTER; src_x, src_y, dest_x, dest_y, a_width, a_height: INTEGER_32): POINTER
		external
			"C signature (GdkPixbuf*, GdkImage*, GdkColormap*, int, int, int, int, int, int): GdkPixbuf use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_locale_to_utf8 (a_string: POINTER; a_length: INTEGER_32; bytes_read, bytes_written: TYPED_POINTER [INTEGER_32]; gerror: TYPED_POINTER [POINTER]; a_result: TYPED_POINTER [POINTER])
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				{
					gsize temp_bytes_read;
					gsize temp_bytes_written;
					*$a_result = g_locale_to_utf8 ((gchar*) $a_string, (gssize) $a_length, &temp_bytes_read, &temp_bytes_written, (GError**) $gerror);
					*$bytes_read = (EIF_INTEGER) temp_bytes_read;
					*$bytes_written = (EIF_INTEGER) temp_bytes_written;
				}
			]"
		ensure
			is_class: class
		end

	frozen g_filename_to_utf8 (a_string: POINTER; a_length: INTEGER_32; bytes_read, bytes_written: TYPED_POINTER [INTEGER_32]; gerror: TYPED_POINTER [POINTER]; a_result: TYPED_POINTER [POINTER])
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				{
					gsize temp_bytes_read;
					gsize temp_bytes_written;
					*$a_result = g_filename_to_utf8 ((gchar*) $a_string, (gssize) $a_length, &temp_bytes_read, &temp_bytes_written, (GError**) $gerror);
					*$bytes_read = (EIF_INTEGER) temp_bytes_read;
					*$bytes_written = (EIF_INTEGER) temp_bytes_written;
				}
			]"
		ensure
			is_class: class
		end


	frozen gtk_widget_get_pango_context (a_widget: POINTER): POINTER
		external
			"C signature (GtkWidget*): PangoContext* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_layout_set_font_description (a_layout, a_font_desc: POINTER)
		external
			"C signature (PangoLayout*, PangoFontDescription*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_layout_set_width (a_layout: POINTER; a_width: INTEGER_32)
		external
			"C signature (PangoLayout*, int) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_layout_get_pixel_size (a_layout: POINTER; a_width, a_height: TYPED_POINTER [INTEGER_32])
		external
			"C signature (PangoLayout*, gint*, gint*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_layout_get_iter (a_layout: POINTER): POINTER
		external
			"C signature (PangoLayout*): PangoLayoutIter* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_layout_set_text (a_layout: POINTER; a_text: POINTER; a_length: INTEGER_32)
		external
			"C signature (PangoLayout*, char*, int) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_layout_iter_get_baseline (a_iter: POINTER): INTEGER_32
		external
			"C signature (PangoLayoutIter*): gint use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_layout_iter_free (a_iter: POINTER)
		external
			"C signature (PangoLayoutIter*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gdk_draw_layout (a_drawable, a_gc: POINTER; a_x, a_y: INTEGER_32; a_layout: POINTER)
		external
			"C signature (GdkDrawable*, GdkGC*, gint, gint, PangoLayout*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_create_pango_layout (a_widget: POINTER; a_text: POINTER): POINTER
		external
			"C signature (GtkWidget*, gchar*): PangoLayout* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_modify_fg (a_widget: POINTER; a_state_type: INTEGER_32; a_color: POINTER)
		external
			"C signature (GtkWidget*, GtkStateType, GdkColor*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_modify_bg (a_widget: POINTER; a_state_type: INTEGER_32; a_color: POINTER)
		external
			"C signature (GtkWidget*, GtkStateType, GdkColor*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_get_modifier_style (a_widget: POINTER): POINTER
		external
			"C signature (GtkWidget*): GtkRcStyle* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_scale: INTEGER_32
		external
			"C Macro use <ev_gtk.h>"
		alias
			"PANGO_SCALE"
		ensure
			is_class: class
		end

	frozen pango_font_description_new: POINTER
		external
			"C signature (): PangoFontDescription* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_font_description_free (a_pango_description: POINTER)
		external
			"C signature (PangoFontDescription*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_font_description_copy (a_pango_description: POINTER): POINTER
		external
			"C signature (PangoFontDescription*): PangoFontDescription* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_font_description_to_string (a_pango_description: POINTER): POINTER
		external
			"C signature (PangoFontDescription*): char* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_font_description_set_family (a_pango_description: POINTER; a_family: POINTER)
		external
			"C signature (PangoFontDescription*, char*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_font_description_get_family (a_pango_description: POINTER): POINTER
		external
			"C signature (PangoFontDescription*): char* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_font_description_set_style (a_pango_description: POINTER; a_pango_style: INTEGER_32)
		external
			"C signature (PangoFontDescription*, PangoStyle) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_font_description_get_style (a_pango_description: POINTER): INTEGER_32
		external
			"C signature (PangoFontDescription*): PangoStyle use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_font_description_set_weight (a_pango_description: POINTER; a_weight: INTEGER_32)
		external
			"C signature (PangoFontDescription*, PangoWeight) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_font_description_get_weight (a_pango_description: POINTER): INTEGER_32
		external
			"C signature (PangoFontDescription*): PangoWeight use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_font_description_set_size (a_pango_description: POINTER; a_size: INTEGER_32)
		external
			"C signature (PangoFontDescription*, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_font_description_get_size (a_pango_description: POINTER): INTEGER_32
		external
			"C signature (PangoFontDescription*): gint use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen pango_font_description_from_string (a_description: POINTER): POINTER
		external
			"C signature (char*): PangoFontDescription* use <ev_gtk.h>"
		ensure
			is_class: class
		end


	frozen signal_disconnect (a_object: POINTER; a_handler_id: INTEGER_32)
		external
			"C signature (gpointer, gulong) use <ev_gtk.h>"
		alias
			"g_signal_handler_disconnect"
		ensure
			is_class: class
		end

	frozen signal_disconnect_by_data (a_c_object: POINTER; data: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_signal_handlers_disconnect_matched ((gpointer) $a_c_object, G_SIGNAL_MATCH_DATA, 0, 0, NULL, NULL, (gpointer) (rt_int_ptr) $data)"
		ensure
			is_class: class
		end

	frozen gtk_editable_get_selection_bounds (a_editable: POINTER; a_start, a_end: TYPED_POINTER [INTEGER_32]): BOOLEAN
		external
			"C signature (GtkEditable*, gint*, gint*): gboolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_style_get_font (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkStyle*): EIF_POINTER use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_menu_bar_set_shadow_type (a_menu_bar: POINTER; a_type: INTEGER_32)
		external
			"C macro use <ev_gtk.h>"
		alias
			" "
		ensure
			is_class: class
		end

	frozen gtk_editable_get_editable (a_c_struct: POINTER): BOOLEAN
		external
			"C signature (GtkEditable*): EIF_BOOLEAN use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen object_destroy (a_c_object: POINTER)
		external
			"C signature (GtkObject*) use <ev_gtk.h>"
		alias
			"gtk_object_destroy"
		ensure
			is_class: class
		end

	frozen object_ref (a_c_object: POINTER)
		external
			"C signature (gpointer) use <ev_gtk.h>"
		alias
			"g_object_ref"
		ensure
			is_class: class
		end

	frozen object_unref, g_object_unref (a_c_object: POINTER)
		external
			"C signature (gpointer) use <ev_gtk.h>"
		alias
			"g_object_unref"
		ensure
			is_class: class
		end

	frozen gtk_text_view_new: POINTER
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_create_mark (a_text_buffer: POINTER; a_name: POINTER; a_text_iter: POINTER; left_gravity: BOOLEAN): POINTER
		external
			"C signature (GtkTextBuffer*, gchar*, GtkTextIter*, gboolean): GtkTextMark* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_delete_mark (a_text_buffer: POINTER; a_text_mark: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextMark*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_view_get_buffer (a_text_view: POINTER): POINTER
		external
			"C signature (GtkTextView*): GtkTextBuffer* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_view_window_to_buffer_coords (a_text_view: POINTER; a_window_type: NATURAL_8; a_window_x, a_window_y: INTEGER; a_buffer_x, a_buffer_y: TYPED_POINTER [INTEGER])
		external
			"C signature (GtkTextView*, GtkTextWindowType, gint, gint, gint*, gint*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_view_set_buffer (a_text_view: POINTER; a_text_buffer: POINTER)
		external
			"C signature (GtkTextView*, GtkTextBuffer*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_set_text (a_text_buffer: POINTER; a_string: POINTER; a_length: INTEGER_32)
		external
			"C signature (GtkTextBuffer*, gchar *, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_insert (a_text_buffer: POINTER; a_text_iter: POINTER; a_string: POINTER; a_length: INTEGER_32)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, gchar *, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_insert_range (a_text_buffer: POINTER; a_text_iter: POINTER; a_start_iter: POINTER; a_end_iter: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*, GtkTextIter*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_get_start_iter (a_text_buffer: POINTER; a_text_iter: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_get_end_iter (a_text_buffer: POINTER; a_text_iter: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_get_char_count (a_text_buffer: POINTER): INTEGER_32
		external
			"C signature (GtkTextBuffer*): gint use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_get_bounds (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_get_selection_bounds (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER): BOOLEAN
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*): gboolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_get_selection_bound (a_text_buffer: POINTER): POINTER
		external
			"C signature (GtkTextBuffer*): GtkTextMark* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_get_insert (a_text_buffer: POINTER): POINTER
		external
			"C signature (GtkTextBuffer*): GtkTextMark* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_move_mark (a_text_buffer: POINTER; a_text_mark: POINTER; a_text_iter: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextMark*, GtkTextIter*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_get_text (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER; inc_hid_chars: BOOLEAN): POINTER
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*, gboolean): gchar* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_get_line_count (a_text_buffer: POINTER): INTEGER_32
		external
			"C signature (GtkTextBuffer*): gint use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_iter_get_text (a_start_iter: POINTER; a_end_iter: POINTER): POINTER
		external
			"C signature (GtkTextIter*, GtkTextIter*): gchar* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_iter_get_line (a_iter: POINTER): INTEGER_32
		external
			"C signature (GtkTextIter*): gint use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_iter_set_line (a_iter: POINTER; a_line: INTEGER_32)
		external
			"C signature (GtkTextIter*, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_view_set_editable (a_text_view: POINTER; a_setting: BOOLEAN)
		external
			"C signature (GtkTextView*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_view_set_wrap_mode (a_text_view: POINTER; a_wrap_mode: INTEGER_32)
		external
			"C signature (GtkTextView*, GtkWrapMode) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	Gtk_wrap_none_enum: INTEGER_32 = 0

	Gtk_wrap_char_enum: INTEGER_32 = 1

	Gtk_wrap_word_enum: INTEGER_32 = 2

	frozen gtk_text_tag_new (a_name: POINTER): POINTER
		external
			"C signature (gchar*): GtkTextTag* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_new (a_text_tag_table: POINTER): POINTER
		external
			"C signature (GtkTextTagTable*): GtkTextBuffer* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_apply_tag (a_buffer: POINTER; a_tag: POINTER; a_start: POINTER; a_end: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextTag*, GtkTextIter*, GtkTextIter*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_get_tag_table (a_buffer: POINTER): POINTER
		external
			"C signature (GtkTextBuffer*): GtkTextTagTable* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_tag_table_add (a_table: POINTER; a_tag: POINTER)
		external
			"C signature (GtkTextTagTable*, GtkTextTag*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_tag_table_lookup (a_table: POINTER; a_name: POINTER): POINTER
		external
			"C signature (GtkTextTagTable*, gchar*): GtkTextTag* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_get_iter_at_line (a_text_buffer: POINTER; a_text_iter: POINTER; a_line_number: INTEGER_32)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_get_iter_at_mark (a_text_buffer: POINTER; a_text_iter: POINTER; a_text_mark: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextMark*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_get_iter_at_offset (a_text_buffer: POINTER; a_text_iter: POINTER; a_char_offset: INTEGER_32)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_delete_selection (a_text_buffer: POINTER; a_interactive: BOOLEAN; a_default_editable: BOOLEAN)
		external
			"C signature (GtkTextBuffer*, gboolean, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_delete (a_text_buffer: POINTER; a_start_iter: POINTER; a_end_iter: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*, GtkTextIter*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_place_cursor (a_text_buffer: POINTER; a_text_iter: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkTextIter*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_iter_forward_to_line_end (a_text_iter: POINTER)
		external
			"C signature (GtkTextIter *) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_iter_forward_line (a_text_iter: POINTER)
		external
			"C signature (GtkTextIter *) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_iter_backward_line (a_text_iter: POINTER)
		external
			"C signature (GtkTextIter *) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_iter_forward_char (a_text_iter: POINTER)
		external
			"C signature (GtkTextIter *) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_iter_backward_char (a_text_iter: POINTER)
		external
			"C signature (GtkTextIter *) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_view_forward_display_line (a_text_view: POINTER; a_text_iter: POINTER): BOOLEAN
		external
			"C signature (GtkTextView*, GtkTextIter*): gboolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_view_backward_display_line (a_text_view: POINTER; a_text_iter: POINTER): BOOLEAN
		external
			"C signature (GtkTextView*, GtkTextIter*): gboolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_view_forward_display_line_end (a_text_view: POINTER; a_text_iter: POINTER): BOOLEAN
		external
			"C signature (GtkTextView*, GtkTextIter*): gboolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_iter_get_offset (a_text_iter: POINTER): INTEGER_32
		external
			"C signature (GtkTextIter*): gint use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_clipboard_get (a_atom: POINTER): POINTER
		external
			"C signature (GdkAtom): GtkClipboard* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_clipboard_set_text (a_clipboard: POINTER; a_text: POINTER; a_length: INTEGER_32)
		external
			"C signature (GtkClipboard*, gchar*, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_clipboard_wait_for_text (a_clipboard: POINTER): POINTER
		external
			"C signature (GtkClipboard*): gchar* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_clipboard_wait_is_text_available (a_clipboard: POINTER): BOOLEAN
		external
			"C signature (GtkClipboard*): gboolean use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_cut_clipboard (a_text_buffer: POINTER; a_clipboard: POINTER; default_editable: BOOLEAN)
		external
			"C signature (GtkTextBuffer*, GtkClipboard*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_copy_clipboard (a_text_buffer: POINTER; a_clipboard: POINTER)
		external
			"C signature (GtkTextBuffer*, GtkClipboard*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_buffer_paste_clipboard (a_text_buffer: POINTER; a_clipboard: POINTER; a_text_iter: POINTER; default_editable: BOOLEAN)
		external
			"C signature (GtkTextBuffer*, GtkClipboard*, GtkTextIter*, gboolean) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_view_scroll_to_iter (a_text_view: POINTER; a_text_iter: POINTER; within_margin: REAL_64; use_align: BOOLEAN; xalign: REAL_64; yalign: REAL_64)
		external
			"C signature (GtkTextView*, GtkTextIter*, gdouble, gboolean, gdouble, gdouble) use <ev_gtk.h> "
		ensure
			is_class: class
		end

	frozen gtk_text_view_scroll_to_mark (a_text_view: POINTER; a_text_mark: POINTER; within_margin: REAL_64; use_align: BOOLEAN; xalign: REAL_64; yalign: REAL_64)
		external
			"C signature (GtkTextView*, GtkTextMark*, gdouble, gboolean, gdouble, gdouble) use <ev_gtk.h> "
		ensure
			is_class: class
		end

	frozen gtk_text_view_get_iter_location (a_text_view, a_text_iter, a_rectangle: POINTER)
		external
			"C signature (GtkTextView*, GtkTextIter*, GdkRectangle*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_view_get_iter_at_location (a_text_view, a_text_iter: POINTER; a_x, a_y: INTEGER)
		external
			"C signature (GtkTextView*, GtkTextIter*, gint, gint) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_text_iter_copy (a_text_iter: POINTER): POINTER
		external
			"C signature (GtkTextIter*): GtkTextIter* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_image_set_from_pixmap (a_image: POINTER; a_pixmap: POINTER; a_mask: POINTER)
		external
			"C signature (GtkImage*, GdkPixmap*, GdkBitmap*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_image_set_from_pixbuf (a_image: POINTER; a_pixbuf: POINTER)
		external
			"C signature (GtkImage*, GdkPixbuf*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_image_get_pixmap (a_image: POINTER; a_pixmap: POINTER; a_mask: POINTER)
		external
			"C signature (GtkImage*, GdkPixmap**, GdkBitmap**) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_image_get_pixbuf (a_image: POINTER): POINTER
		external
			"C signature (GtkImage*): GdkPixbuf* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_image_new_from_pixmap (a_pixmap: POINTER; a_mask: POINTER): POINTER
		external
			"C signature (GdkPixmap*, GdkBitmap*): GtkImage* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_image_new_from_pixbuf (a_pixbuf: POINTER): POINTER
		external
			"C signature (GdkPixbuf*): GtkImage* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_image_new: POINTER
		external
			"C signature (): GtkImage* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_dialog_new: POINTER
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen gtk_widget_modify_font (a_widget: POINTER; a_font_description: POINTER)
		external
			"C signature (GtkWidget*, PangoFontDescription*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
