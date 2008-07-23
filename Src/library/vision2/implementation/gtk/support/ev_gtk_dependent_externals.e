indexing
	description: "Gtk Version Dependent Externals"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_DEPENDENT_EXTERNALS

feature -- Externals

	frozen gdk_keyval_to_unicode (a_keyval: NATURAL_32): NATURAL_32 is
		external
			"C (guint): guint | <gtk/gtk.h>"
		end

	frozen gdk_window_set_accept_focus (a_window: POINTER; a_accept: BOOLEAN)
		external
			"C signature (GdkWindow*, gboolean) use <gtk/gtk.h>"
		end

	frozen gdk_window_get_state (a_window: POINTER): INTEGER
		external
			"C signature (GdkWindow*): GdkWindowState use <gtk/gtk.h>"
		end

	frozen gdk_region_intersect (a_region1, a_region2: POINTER) is
		external
			"C signature (GdkRegion*, GdkRegion*) use <gtk/gtk.h>"
		end

	frozen gdk_region_union (a_region1, a_region2: POINTER) is
		external
			"C signature (GdkRegion*, GdkRegion*) use <gtk/gtk.h>"
		end

	frozen gdk_region_subtract (a_region1, a_region2: POINTER) is
		external
			"C signature (GdkRegion*, GdkRegion*) use <gtk/gtk.h>"
		end

	frozen gdk_region_xor (a_region1, a_region2: POINTER) is
		external
			"C signature (GdkRegion*, GdkRegion*) use <gtk/gtk.h>"
		end

	frozen gdk_region_copy (a_region: POINTER): POINTER
		external
			"C signature (GdkRegion*): GdkRegion* use <gtk/gtk.h>"
		end

	frozen gdk_region_rectangle (a_rect: POINTER): POINTER
		external
			"C signature (GdkRectangle*): GdkRegion* use <gtk/gtk.h>"
		end

	frozen gtk_window_set_type_hint (a_window: POINTER; a_hint: INTEGER) is
		external
			"C signature (GtkWindow*, GdkWindowTypeHint) use <gtk/gtk.h>"
		end

	frozen gtk_window_set_accept_focus (a_window: POINTER; a_focus: BOOLEAN) is
		external
			"C signature (GtkWindow*, gboolean) use <gtk/gtk.h>"
		end

	frozen gdk_display_get_default_cursor_size (a_display: POINTER): INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"return (EIF_INTEGER) gdk_display_get_default_cursor_size ((GdkDisplay*) $a_display)"
		end

	frozen gtk_tooltips_struct_tip_label (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkTooltips): EIF_POINTER"
		alias
			"tip_label"
		end

	frozen events_pending: BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_main_context_pending (g_main_context_default())"
		end

	frozen dispatch_events is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_main_context_dispatch(g_main_context_default())"
		end

	frozen new_g_static_rec_mutex: POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"malloc (sizeof(GStaticRecMutex))"
		end

	frozen g_static_rec_mutex_init (a_static_mutex: POINTER) is
		external
			"C signature (GStaticRecMutex*) use <gtk/gtk.h>"
		end

	frozen g_static_rec_mutex_lock (a_static_mutex: POINTER) is
		external
			"C blocking signature (GStaticRecMutex*) use <gtk/gtk.h>"
		end

	frozen g_static_rec_mutex_trylock (a_static_mutex: POINTER): BOOLEAN is
		external
			"C blocking signature (GStaticRecMutex*): gboolean use <gtk/gtk.h>"
		end

	frozen g_static_rec_mutex_unlock (a_static_mutex: POINTER) is
		external
			"C signature (GStaticRecMutex*) use <gtk/gtk.h>"
		end

	frozen g_thread_supported: BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_thread_supported()"
		end

	frozen g_thread_init is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
			{
				#ifdef EIF_THREADS
					g_thread_init (NULL);
				#endif
			}
			]"
		end

	frozen gtk_widget_toplevel (a_widget: POINTER): BOOLEAN is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"GTK_WIDGET_TOPLEVEL"
		end

	frozen gtk_fixed_set_has_window (a_fixed: POINTER; has_window: BOOLEAN) is
		external
			"C signature (GtkFixed*, gboolean) use <gtk/gtk.h>"
		end

	frozen gtk_toolbar_set_orientation (a_toolbar: POINTER; a_orientation: INTEGER) is
		external
			"C signature (GtkToolbar*, gint) use <gtk/gtk.h>"
		end

	frozen g_main_context_default: POINTER is
		external
			"C signature (): GMainContext* use <gtk/gtk.h>"
		end

	frozen g_main_context_pending (a_context: POINTER): BOOLEAN is
		external
			"C signature (GMainContext*): gboolean use <gtk/gtk.h>"
		end

	frozen g_main_context_dispatch (a_context: POINTER) is
		external
			"C signature (GMainContext*) use <gtk/gtk.h>"
		end

	frozen g_main_context_iteration (a_context: POINTER; may_block: BOOLEAN): BOOLEAN is
		external
			"C signature (GMainContext*, gboolean): gboolean use <gtk/gtk.h>"
		end

	frozen gtk_widget_get_screen (a_widget: POINTER): POINTER is
		external
			"C signature (GtkWidget*): GdkScreen* use <gtk/gtk.h>"
		end

	frozen gtk_widget_has_screen (a_widget: POINTER): BOOLEAN is
		external
			"C signature (GtkWidget*): gboolean use <gtk/gtk.h>"
		end

	frozen gdk_pango_context_get_for_screen (a_screen: POINTER): POINTER is
		external
			"C signature (GdkScreen*): PangoContext* use <gtk/gtk.h>"
		end

	frozen pango_layout_new (a_pango_context: POINTER): POINTER is
		external
			"C signature (PangoContext*): PangoLayout* use <gtk/gtk.h>"
		end

-- ***************** Gtk 2.6 only ****************************

	frozen pango_renderer_draw_layout (a_pango_renderer, a_pango_layout: POINTER; a_x, a_y: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					pango_renderer_draw_layout ((PangoRenderer*) $a_pango_renderer, (PangoLayout*) $a_pango_layout, (gint) $a_x, (gint) $a_y);
				#endif
			]"
		end

	frozen gdk_pango_renderer_new (a_screen: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					return gdk_pango_renderer_new ((GdkScreen*) $a_screen);
				#endif
			]"
		end

	frozen gdk_pango_renderer_get_default (a_screen: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					return gdk_pango_renderer_get_default ((GdkScreen*) $a_screen);
				#endif
			]"
		end

	frozen gdk_pango_renderer_set_drawable (a_renderer, a_drawable: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					gdk_pango_renderer_set_drawable ((GdkPangoRenderer*) $a_renderer, (GdkDrawable*) $a_drawable);
				#endif
			]"
		end

	frozen gdk_pango_renderer_set_gc (a_renderer, a_gc: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					gdk_pango_renderer_set_gc ((GdkPangoRenderer*) $a_renderer, (GdkGC*) $a_gc);
				#endif
			]"
		end

	frozen gtk_label_set_angle (a_label: POINTER; a_angle: REAL) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					gtk_label_set_angle ((GtkLabel*) $a_label, (double) $a_angle);
				#endif
			]"
		end

	frozen gtk_label_set_ellipsize (a_label: POINTER; a_mode: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					gtk_label_set_ellipsize ((GtkLabel*) $a_label, (PangoEllipsizeMode) $a_mode);
				#endif
			]"
		end


	frozen pango_matrix_init (a_pango_matrix: TYPED_POINTER [POINTER]) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					PangoMatrix matrix = PANGO_MATRIX_INIT;
					*($a_pango_matrix) = (void*) pango_matrix_copy (&matrix);
				#endif
			]"
		end

	frozen pango_matrix_free (a_pango_matrix: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					pango_matrix_free ((PangoMatrix*) $a_pango_matrix);
				#endif
			]"
		end

	frozen pango_matrix_rotate (a_matrix: POINTER; a_degrees: REAL) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					pango_matrix_rotate ((PangoMatrix*) $a_matrix, (double) $a_degrees);
				#endif
			]"
		end

	frozen pango_matrix_translate (a_matrix: POINTER; a_x, a_y: REAL) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					pango_matrix_translate ((PangoMatrix*) $a_matrix, (double) $a_x, (double) $a_y);
				#endif
			]"
		end

	frozen pango_matrix_scale (a_matrix: POINTER; a_x_scale, a_y_scale: REAL) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					pango_matrix_scale ((PangoMatrix*) $a_matrix, (double) $a_x_scale, (double) $a_y_scale);
				#endif
			]"
		end

	frozen pango_matrix_concat (a_matrix, a_new_matrix: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					pango_matrix_concat ((PangoMatrix*) $a_matrix, (PangoMatrix*) $a_new_matrix);
				#endif
			]"
		end

	frozen pango_context_set_matrix (a_context, a_matrix: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					pango_context_set_matrix ((PangoContext*) $a_context, (PangoMatrix*) $a_matrix);
				#endif
			]"
		end

	frozen pango_layout_set_ellipsize (a_layout: POINTER; a_mode: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					pango_layout_set_ellipsize ((PangoLayout*) $a_layout, (PangoEllipsizeMode) $a_mode);
				#endif
			]"
		end

	frozen set_pango_matrix_struct_xx (a_c_struct: POINTER; a_x: DOUBLE) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					((PangoMatrix*)$a_c_struct)->xx = (gdouble) $a_x;
				#endif
			]"
		end

	frozen set_pango_matrix_struct_xy (a_c_struct: POINTER; a_x: DOUBLE) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					((PangoMatrix*)$a_c_struct)->xy = (gdouble) $a_x;
				#endif
			]"
		end

	frozen set_pango_matrix_struct_yx (a_c_struct: POINTER; a_x: DOUBLE) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					((PangoMatrix*)$a_c_struct)->yx = (gdouble) $a_x;
				#endif
			]"
		end

	frozen set_pango_matrix_struct_yy (a_c_struct: POINTER; a_x: DOUBLE) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					((PangoMatrix*)$a_c_struct)->yy = (gdouble) $a_x;
				#endif
			]"
		end


	frozen set_pango_matrix_struct_x0 (a_c_struct: POINTER; a_x: DOUBLE) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					((PangoMatrix*)$a_c_struct)->x0 = (gdouble) $a_x;
				#endif
			]"
		end

	frozen set_pango_matrix_struct_y0 (a_c_struct: POINTER; a_x: DOUBLE) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				#if GTK_MINOR_VERSION >= 6
					((PangoMatrix*)$a_c_struct)->y0 = (gdouble) $a_x;
				#endif
			]"
		end

-- ***********************************************************

	frozen gdk_draw_drawable (a_drawable: POINTER; a_gc: POINTER; a_src: POINTER; a_xsrc: INTEGER; a_ysrc: INTEGER; a_xdest: INTEGER; a_ydest: INTEGER; a_width: INTEGER; a_height: INTEGER) is
		external
			"C (GdkDrawable*, GdkGC*, GdkDrawable*, gint, gint, gint, gint, gint, gint) | <gtk/gtk.h>"
		end

	frozen pango_layout_get_context (a_pango_layout: POINTER): POINTER is
		external
			"C signature (PangoLayout*): PangoContext* use <gtk/gtk.h>"
		end

	frozen gdk_window_begin_paint_region (a_window, a_region: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gdk_window_begin_paint_region ((GdkWindow*) $a_window, (GdkRegion*) $a_region)"
		end

	frozen gdk_window_end_paint (a_window: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gdk_window_end_paint ((GdkWindow*) $a_window)"
		end

	frozen g_mem_set_vtable (mem_vtable: POINTER) is
		external
			"C signature (GMemVTable*) use <gtk/gtk.h>"
		end

	frozen g_mem_is_system_malloc: BOOLEAN is
		external
			"C signature (): GBoolean use <gtk/gtk.h>"
		end

	frozen glib_mem_profiler_table: POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"glib_mem_profiler_table"
		end

	frozen gdk_drawable_copy_to_image (a_drawable, a_image: POINTER; src_x, src_y, dest_x, dest_y, a_width, a_height: INTEGER): POINTER is
		external
			"C signature (GdkDrawable*, GdkImage*, int, int, int, int, int, int): GdkImage* use <gtk/gtk.h>"
		end

	frozen gdk_drawable_get_colormap (a_drawable: POINTER): POINTER is
		external
			"C signature (GdkDrawable*): GdkColormap* use <gtk/gtk.h>"
		end

	frozen gdk_drawable_get_image (a_drawable: POINTER; a_x, a_y, a_width, a_height: INTEGER): POINTER is
		external
			"C signature (GdkDrawable*, gint, gint, gint, gint): GdkImage* use <gtk/gtk.h>"
		end

	frozen gdk_drawable_get_visible_region (a_drawable: POINTER): POINTER is
		external
			"C signature (GdkDrawable*): GdkRegion use <gtk/gtk.h>"
		end

	frozen gtk_window_get_focus (a_window: POINTER): POINTER is
		external
			"C signature (GtkWindow*): GtkWidget* use <gtk/gtk.h>"
		end

	frozen gtk_scrolled_window_set_shadow_type (a_window: POINTER; a_shadow_type: INTEGER) is
		external
			"C signature (GtkScrolledWindow*, GtkShadowType) use <gtk/gtk.h>"
		end

	frozen gtk_win_pos_center_on_parent_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_WIN_POS_CENTER_ON_PARENT"
		end

	frozen gtk_label_get_label (a_label: POINTER): POINTER is
		external
			"C signature (GtkLabel*): gchar* use <gtk/gtk.h>"
		end

	frozen gtk_window_get_position (a_window: POINTER; a_width, a_height: TYPED_POINTER [INTEGER]) is
		external
			"C signature (GtkWindow*, gint*, gint*) use <gtk/gtk.h>"
		end

	frozen gtk_window_set_decorated (a_window: POINTER; a_decor: BOOLEAN) is
		external
			"C signature (GtkWindow*, gboolean) use <gtk/gtk.h>"
		end

	frozen gtk_window_move (a_window: POINTER; a_x, a_y: INTEGER) is
		external
			"C signature (GtkWindow*, gint, gint) use <gtk/gtk.h>"
		end

	frozen gdk_threads_init is
		external
			"C use <gtk/gtk.h>"
		end

	frozen gtk_widget_is_focus (a_widget: POINTER): BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_widget_is_focus ((GtkWidget*) $a_widget)"
		end

	frozen gtk_icon_size_dialog_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_ICON_SIZE_DIALOG"
		end

	frozen gtk_stock_lookup (a_stock_id, a_stock_item: POINTER): BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_stock_lookup ((gchar*) $a_stock_id, (GtkStockItem*) $a_stock_item)"
		end

	frozen c_gtk_stock_item_struct_allocate: POINTER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"calloc (sizeof(GtkStockItem), 1)"
		end

	frozen c_gtk_allocation_struct_allocate: POINTER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"calloc (sizeof(GtkAllocation), 1)"
		end

	frozen c_gtk_requisition_struct_allocate: POINTER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"calloc (sizeof(GtkRequisition), 1)"
		end

	frozen g_signal_handler_disconnect (a_instance: POINTER; handler_id: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_signal_handler_disconnect ((gpointer) $a_instance, (gulong) $handler_id)"
		end

	frozen gtk_container_set_focus_chain (a_container: POINTER; a_focus_chain: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_container_set_focus_chain ((GtkContainer*) $a_container, (GList*) $a_focus_chain)"
		end

	frozen gtk_container_get_focus_chain (a_container: POINTER; a_focus_chain: TYPED_POINTER [POINTER]) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_container_get_focus_chain ((GtkContainer*) $a_container, (GList**) $a_focus_chain)"
		end

	frozen g_object_type_name (a_c_struct: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"G_OBJECT_TYPE_NAME ($a_c_struct)"
		end

	frozen gtk_tree_view_column_struct_window (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkTreeViewColumn): GdkWindow*"
		alias
			"window"
		end

	frozen gtk_tree_view_column_struct_button (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkTreeViewColumn): GtkWidget*"
		alias
			"button"
		end

	frozen gtk_tree_view_column_struct_drag_x (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GtkTreeViewColumn): gint"
		alias
			"drag_x"
		end

	frozen gdk_drawable_get_size (a_drawable: POINTER; a_width, a_height: TYPED_POINTER [INTEGER]) is
		external
			"C signature (GdkDrawable*, gint*, gint*) use <gtk/gtk.h>"
		end

	frozen gtk_arrow_new (a_arrow_type, a_shadow_type: INTEGER): POINTER is
		external
			"C signature (GtkArrowType, GtkShadowType): GtkWidget* use <gtk/gtk.h>"
		end

	frozen gtk_combo_box_popup (a_combo: POINTER) is
		external
			"C signature (GtkComboBox*) use <gtk/gtk.h>"
		end

	frozen gtk_combo_box_popdown (a_combo: POINTER) is
		external
			"C signature (GtkComboBox*) use <gtk/gtk.h>"
		end

	frozen gtk_entry_set_has_frame (a_entry: POINTER; has_frame: BOOLEAN) is
		external
			"C signature (GtkEntry*, gboolean) use <gtk/gtk.h>"
		end

	frozen gtk_entry_set_alignment (a_entry: POINTER; a_alignment: REAL_32)
		external
			"C signature (GtkEntry*, gfloat) use <gtk/gtk.h>"
		end

	frozen gtk_file_chooser_set_current_folder (a_dialog: POINTER; a_folder: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_file_chooser_set_current_folder ((GtkFileChooser*) $a_dialog, (gchar*) $a_folder)"
		end

	frozen gtk_icon_theme_get_default: POINTER is
		external
			"C signature (): GtkIconTheme* use <gtk/gtk.h>"
		end

	frozen gtk_icon_theme_has_icon (icon_theme, icon_name: POINTER): BOOLEAN is
		external
			"C signature (GtkIconTheme*, gchar*): gboolean use <gtk/gtk.h>"
		end

	frozen gtk_icon_theme_load_icon (theme, icon_name: POINTER; size, flags: INTEGER; a_error: TYPED_POINTER [POINTER]): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_icon_theme_load_icon ((GtkIconTheme*) $theme, (char*) $icon_name, (gint) $size, (GtkIconLookupFlags) $flags, (GError**) $a_error)"
		end

	frozen gtk_window_group_new: POINTER is
		external
			"C signature (): GtkWindowGroup* use <gtk/gtk.h>"
		end

	frozen gtk_window_group_add_window (a_group, a_window: POINTER) is
		external
			"C signature (GtkWindowGroup*, GtkWindow*) use <gtk/gtk.h>"
		end

	frozen gtk_window_group_remove_window (a_group, a_window: POINTER) is
		external
			"C signature (GtkWindowGroup*, GtkWindow*) use <gtk/gtk.h>"
		end

	frozen gtk_button_set_label (tool_button, a_text: POINTER) is
		external
			"C signature (GtkButton*, gchar*) use <gtk/gtk.h>"
		end

	frozen gtk_button_get_label (tool_button: POINTER): POINTER is
		external
			"C signature (GtkButton*): gchar* use <gtk/gtk.h>"
		end

	frozen add_g_type_boolean (an_array: POINTER; a_pos: INTEGER) is
			-- Add G_TYPE_BOOLEAN constant in `an_array' at `a_pos' bytes from beginning
			-- of `an_array'.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				{
					GType type = G_TYPE_BOOLEAN;
					memcpy ((char *) $an_array + $a_pos, &type, sizeof(GType));
				}
			]"
		end

	frozen add_g_type_string (an_array: POINTER; a_pos: INTEGER) is
			-- Add G_TYPE_STRING constant in `an_array' at `a_pos' bytes from beginning
			-- of `an_array'.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				{
					GType type = G_TYPE_STRING;
					memcpy ((char *) $an_array + $a_pos, &type, sizeof(GType));
				}
			]"
		end

	frozen add_gdk_type_pixbuf (an_array: POINTER; a_pos: INTEGER) is
			-- Add GDK_TYPE_PIXBUF constant in `an_array' at `a_pos' bytes from beginning
			-- of `an_array'.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				{
					GType type = GDK_TYPE_PIXBUF;
					memcpy ((char *) $an_array + $a_pos, &type, sizeof(GType));
				}
			]"
		end

	frozen sizeof_gtype: INTEGER is
			-- Size of the `GType' C type
		external
			"C inline use <gtk/gtk.h>"
		alias
			"sizeof(GType)"
		end

	frozen gtk_get_current_event_time: NATURAL_32 is
		external
			"C signature (): guint32 use <gtk/gtk.h>"
		end

	frozen gtk_window_has_toplevel_focus (a_window: POINTER): BOOLEAN is
		external
			"C signature (GtkWindow*): gboolean use <gtk/gtk.h>"
		end

	frozen gtk_window_is_active (a_window: POINTER): BOOLEAN is
		external
			"C signature (GtkWindow*): gboolean use <gtk/gtk.h>"
		end

	frozen gtk_window_resize (a_window: POINTER; a_width: INTEGER; a_height: INTEGER) is
		external
			"C signature (GtkWindow*, gint, gint) use <gtk/gtk.h>"
		end

	frozen gtk_window_set_resizable (a_window: POINTER; a_resize: BOOLEAN) is
		external
			"C signature (GtkWindow*, gboolean) use <gtk/gtk.h>"
		end

	frozen gtk_window_get_resizable (a_window: POINTER): BOOLEAN is
		external
			"C signature (GtkWindow*): gboolean use <gtk/gtk.h>"
		end

	frozen gtk_tree_path_list_free_contents (a_list: POINTER) is
			-- Free tree path items contained within `a_list'
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_list_foreach ((GList*) $a_list, (GFunc) gtk_tree_path_free, NULL)"
		end

	frozen g_value_unset (a_value: POINTER) is
		external
			"C signature (GValue*) use <gtk/gtk.h>"
		end

	frozen gdk_keymap_lookup_key (a_keymap, a_key: POINTER): NATURAL_32 is
		external
			"C signature (GdkKeymap*, GdkKeymapKey*): guint use <gtk/gtk.h>"
		end

	frozen gdk_keyval_convert_case (a_keyval: NATURAL_32; a_lower, a_upper: TYPED_POINTER [NATURAL_32]) is
		external
			"C signature (guint, guint*, guint*) use <gtk/gtk.h>"
		end

	frozen gdk_keymap_get_entries_for_keyval (a_keymap: POINTER; a_keyval: NATURAL_32; a_keymapkey_array: TYPED_POINTER [POINTER]; n_keys: TYPED_POINTER [INTEGER]): BOOLEAN is
		external
			"C signature (GdkKeymap*, guint, GdkKeymapKey**, gint*): gboolean use <gtk/gtk.h>"
		end

	frozen gdk_keymapkey_struct_keycode (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GdkKeymapKey): EIF_INTEGER"
		alias
			"keycode"
		end

	frozen gdk_keymapkey_struct_group (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GdkKeymapKey): EIF_INTEGER"
		alias
			"group"
		end

	frozen set_gdk_keymapkey_struct_level (a_c_struct: POINTER; a_level: INTEGER) is
		external
			"C [struct <gtk/gtk.h>] (GdkKeymapKey, gint)"
		alias
			"level"
		end

	frozen gdk_keymapkey_struct_level (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GdkKeymapKey): EIF_INTEGER"
		alias
			"level"
		end

	frozen c_gdk_keymapkey_struct_size: INTEGER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"sizeof(GdkKeymapKey)"
		end

	frozen gdk_gc_set_rgb_fg_color (a_gc: POINTER; a_color: POINTER) is
		external
			"C (GdkGC*, GdkColor*) | <gtk/gtk.h>"
		end

	frozen gdk_gc_set_rgb_bg_color (a_gc: POINTER; a_color: POINTER) is
		external
			"C (GdkGC*, GdkColor*) | <gtk/gtk.h>"
		end

	frozen gtk_widget_class_find_style_property (a_widget_class, a_property_name: POINTER): POINTER is
		external
			"C signature (GtkWidgetClass*, gchar*): GParamSpec* use <gtk/gtk.h>"
		end

	frozen gtk_widget_get_class (a_widget: POINTER): POINTER is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"GTK_WIDGET_GET_CLASS"
		end

	frozen gtk_tree_view_column_grow_only_enum: INTEGER is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"GTK_TREE_VIEW_COLUMN_GROW_ONLY"
		end

	frozen gtk_tree_view_column_autosize_enum: INTEGER is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"GTK_TREE_VIEW_COLUMN_AUTOSIZE"
		end

	frozen gtk_tree_view_column_fixed_enum: INTEGER is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"GTK_TREE_VIEW_COLUMN_FIXED"
		end

	frozen pango_tab_array_new (a_initial_size: INTEGER; a_position_in_pixels: BOOLEAN): POINTER is
		external
			"C signature (gint, gboolean): PangoTabArray* use <gtk/gtk.h>"
		end

	frozen pango_tab_array_resize (a_tab_array: POINTER; a_size: INTEGER) is
		external
			"C signature (PangoTabArray*, gint) use <gtk/gtk.h>"
		end

	frozen pango_tab_array_set_tab (a_tab_array: POINTER; a_tab_index, a_tab_alignment, a_location: INTEGER) is
		external
			"C signature (PangoTabArray*, gint, PangoTabAlign, gint) use <gtk/gtk.h>"
		end

	frozen pango_tab_array_free (a_tab_array: POINTER) is
		external
			"C signature (PangoTabArray*) use <gtk/gtk.h>"
		end

	frozen gtk_text_view_set_tabs (a_text_view, a_tab_array: POINTER) is
		external
			"C signature (GtkTextView*, PangoTabArray*) use <gtk/gtk.h>"
		end

	frozen gdk_event_window_state_struct_changed_mask (a_c_struct: POINTER): INTEGER is
			-- (from C_GDK_EVENT_CONFIGURE_STRUCT)
		external
			"C [struct <gtk/gtk.h>] (GdkEventWindowState): EIF_INTEGER"
		alias
			"changed_mask"
		end

	frozen gdk_event_window_state_struct_new_window_state (a_c_struct: POINTER): INTEGER is
			-- (from C_GDK_EVENT_CONFIGURE_STRUCT)
		external
			"C [struct <gtk/gtk.h>] (GdkEventWindowState): EIF_INTEGER"
		alias
			"new_window_state"
		end

	frozen gdk_window_state_withdrawn_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_WINDOW_STATE_WITHDRAWN"
		end

	frozen gdk_window_state_iconified_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_WINDOW_STATE_ICONIFIED"
		end

	frozen gdk_window_state_maximized_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_WINDOW_STATE_MAXIMIZED"
		end

	frozen gdk_window_state_sticky_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_WINDOW_STATE_STICKY"
		end

	frozen gdk_window_state_fullscreen_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_WINDOW_STATE_FULLSCREEN"
		end

	frozen gdk_window_state_above_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_WINDOW_STATE_ABOVE"
		end

	frozen gdk_window_state_below_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_WINDOW_STATE_BELOW"
		end

	frozen pango_pixels (a_value: INTEGER): INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"PANGO_PIXELS ($a_value)"
		end

	frozen gtk_widget_set_redraw_on_allocate (a_widget: POINTER; redraw_on_allocate: BOOLEAN) is
		external
			"C signature (GtkWidget*, gboolean) use <gtk/gtk.h>"
		end

	frozen gtk_widget_set_double_buffered (a_widget: POINTER; is_buffered: BOOLEAN) is
		external
			"C signature (GtkWidget*, gboolean) use <gtk/gtk.h>"
		end

	frozen gdk_window_invalidate_rect (a_window, a_rectangle: POINTER; invalidate_children: BOOLEAN) is
		external
			"C signature (GdkWindow*, GdkRectangle*, gboolean) use <gtk/gtk.h>"
		end

	frozen gdk_window_set_debug_updates (a_setting: BOOLEAN) is
		external
			"C signature (gboolean) use <gtk/gtk.h>"
		end

	frozen gdk_window_set_modal_hint (a_window: POINTER; a_hint: BOOLEAN) is
		external
			"C signature (GdkWindow*, gboolean) use <gtk/gtk.h>"
		end

	frozen gdk_window_peek_children (a_window: POINTER): POINTER is
		external
			"C signature (GdkWindow*): GList use <gtk/gtk.h>"
		end

	frozen gdk_window_process_updates (a_window: POINTER; process_children: BOOLEAN) is
		external
			"C signature (GdkWindow*, gboolean) use <gtk/gtk.h>"
		end

	frozen gtk_event_box_set_visible_window (a_event_box: POINTER; visible_window: BOOLEAN) is
		external
			"C signature (GtkEventBox*, gboolean) use <gtk/gtk.h>"
		end

	frozen gtk_event_box_set_above_child (a_event_box: POINTER; above_child: BOOLEAN) is
		external
			"C signature (GtkEventBox*, gboolean) use <gtk/gtk.h>"
		end

	frozen gdk_scroll_up_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_SCROLL_UP"
		end

	frozen gdk_scroll_down_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_SCROLL_DOWN"
		end

	frozen gdk_window_freeze_updates (a_window: POINTER) is
		external
			"C signature (GdkWindow*) use <gtk/gtk.h>"
		end

	frozen gdk_window_thaw_updates (a_window: POINTER) is
		external
			"C signature (GdkWindow*) use <gtk/gtk.h>"
		end

	frozen gtk_widget_set_minimum_size (a_widget: POINTER; a_width, a_height: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_widget_set_size_request ((GtkWidget*) $a_widget, (gint) $a_width, (gint) $a_height)"
		end

	frozen gtk_file_chooser_list_filters (a_file_chooser: POINTER): POINTER is
		external
			"C signature (GtkFileChooser*): GSList use <gtk/gtk.h>"
		end

	frozen c_pango_rectangle_struct_allocate: POINTER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"calloc (sizeof(PangoRectangle), 1)"
		end

	frozen pango_rectangle_struct_x (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"x"
		end

	frozen pango_rectangle_struct_y (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"y"
		end

	frozen pango_rectangle_struct_width (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"width"
		end

	frozen pango_rectangle_struct_height (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (PangoRectangle): EIF_INTEGER"
		alias
			"height"
		end

	frozen pango_layout_get_extents (a_layout: POINTER; ink_rect, logical_rect: POINTER) is
		external
			"C signature (PangoLayout*, PangoRectangle*, PangoRectangle*) use <gtk/gtk.h>"
		end

	frozen pango_layout_get_pixel_extents (a_layout: POINTER; ink_rect, logical_rect: POINTER) is
		external
			"C signature (PangoLayout*, PangoRectangle*, PangoRectangle*) use <gtk/gtk.h>"
		end

	frozen pango_layout_get_size (a_layout: POINTER; a_width, a_height: TYPED_POINTER [INTEGER]) is
		external
			"C signature (PangoLayout*, gint*, gint*) use <gtk/gtk.h>"
		end

	frozen pango_layout_context_changed (a_layout: POINTER) is
		external
			"C signature (PangoLayout*) use <gtk/gtk.h>"
		end

	frozen gdk_event_scroll_struct_x (a_c_struct: POINTER): DOUBLE is
		external
			"C [struct <gtk/gtk.h>] (GdkEventScroll): EIF_DOUBLE"
		alias
			"x"
		end

	frozen gdk_event_scroll_struct_y (a_c_struct: POINTER): DOUBLE is
		external
			"C [struct <gtk/gtk.h>] (GdkEventScroll): EIF_DOUBLE"
		alias
			"y"
		end

	frozen gdk_event_scroll_struct_scroll_direction (a_c_struct: POINTER): INTEGER is
		external
			"C [struct <gtk/gtk.h>] (GdkEventScroll): EIF_INTEGER"
		alias
			"direction"
		end

	frozen gtk_tree_view_scroll_to_cell (a_tree_view, a_tree_path, a_tree_column: POINTER; use_align: BOOLEAN; x_align, y_align: REAL) is
		external
			"C signature (GtkTreeView*, GtkTreePath*, GtkTreeViewColumn*, gboolean, gfloat, gfloat) use <gtk/gtk.h>"
		end

	frozen gtk_widget_style_get_integer (a_widget, a_property: POINTER; a_int_ptr: TYPED_POINTER [INTEGER]) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_widget_style_get ((GtkWidget*) $a_widget, (gchar*) $a_property, (gint*) $a_int_ptr, NULL)"
		end

	frozen gdk_display_get_default: POINTER is
		external
			"C signature (): GdkDisplay* use <gtk/gtk.h>"
		end

	frozen gdk_display_get_default_screen (a_display: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"return gdk_display_get_default_screen ((GdkDisplay*) $a_display);"
		end

	frozen gdk_display_supports_cursor_alpha (a_display: POINTER): BOOLEAN is
		external
			"C signature (GdkDisplay*): gboolean use <gtk/gtk.h>"
		end

	frozen gdk_display_supports_cursor_color (a_display: POINTER): BOOLEAN is
		external
			"C signature (GdkDisplay*): gboolean use <gtk/gtk.h>"
		end

	frozen gdk_cursor_new_from_pixbuf (a_display, a_pixbuf: POINTER; a_x, a_y: INTEGER): POINTER is
		external
			"C signature (GdkDisplay*, GdkPixbuf*, gint, gint): GdkCursor* use <gtk/gtk.h>"
		end

	frozen gtk_tool_item_set_tooltip (a_tool_item, a_tooltips, a_tip_text, a_tip_private: POINTER) is
		external
			"C signature (GtkToolItem*, GtkTooltips*, gchar*, gchar*) use <gtk/gtk.h>"
		end

	frozen gtk_tree_view_get_expander_column (a_tree_view: POINTER): POINTER is
		external
			"C signature (GtkTreeView*): GtkTreeViewColumn* use <gtk/gtk.h>"
		end

	frozen gdk_pixbuf_add_alpha (a_pixbuf: POINTER; substitute_color: BOOLEAN; r, g, b: NATURAL_8): POINTER is
		external
			"C signature (GdkPixbuf*, gboolean, guchar, guchar, guchar): GdkPixbuf* use <gtk/gtk.h>"
		end

	frozen gdk_draw_pixbuf (a_drawable, a_gc, a_pixbuf: POINTER; src_x, src_y, dest_x, dest_y, a_width, a_height, a_dither, x_dither, y_dither: INTEGER) is
		external
			"C signature (GdkDrawable*, GdkGC*, GdkPixbuf*, gint, gint, gint, gint, gint , gint, gint, gint, gint) use <gtk/gtk.h>"
		end

	frozen gtk_tree_path_new_from_string (a_string: POINTER): POINTER is
		external
			"C signature (gchar*): GtkTreePath* use <gtk/gtk.h>"
		end

	frozen gtk_separator_tool_item_new: POINTER is
		external
			"C signature (): GtkToolItem* use <gtk/gtk.h>"
		end

	frozen gtk_separator_tool_item_set_draw (a_tool_item: POINTER; a_draw: BOOLEAN) is
		external
			"C signature (GtkSeparatorToolItem*, gboolean) use <gtk/gtk.h>"
		end

	frozen gtk_toolbar_set_show_arrow (a_toolbar: POINTER; show_arrow: BOOLEAN) is
		external
			"C signature (GtkToolbar*, gboolean) use <gtk/gtk.h>"
		end

	frozen gtk_tool_item_set_is_important (a_toolitem: POINTER; is_important: BOOLEAN) is
		external
			"C signature (GtkToolItem*, gboolean) use <gtk/gtk.h>"
		end

	frozen gtk_toggle_tool_button_set_active (a_button: POINTER; a_active: BOOLEAN) is
		external
			"C signature (GtkToggleToolButton*, gboolean) use <gtk/gtk.h>"
		end

	frozen gtk_toggle_tool_button_get_active (a_button: POINTER): BOOLEAN is
		external
			"C signature (GtkToggleToolButton*): gboolean use <gtk/gtk.h>"
		end

	frozen gtk_toolbar_set_tooltips (a_toolbar: POINTER; a_enable: BOOLEAN) is
		external
			"C signature (GtkToolbar*, gboolean) use <gtk/gtk.h>"
		end

	frozen gtk_toolbar_set_style (a_toolbar: POINTER; a_style: INTEGER) is
		external
			"C signature (GtkToolbar*, GtkToolbarStyle) use <gtk/gtk.h>"
		end

	frozen gtk_toolbar_get_style (a_toolbar: POINTER): INTEGER is
		external
			"C signature (GtkToolbar*): GtkToolbarStyle use <gtk/gtk.h>"
		end

	frozen gtk_toolbar_unset_style (a_toolbar: POINTER) is
		external
			"C signature (GtkToolbar*) use <gtk/gtk.h>"
		end

	frozen gtk_toolbar_new: POINTER is
		external
			"C signature () use <gtk/gtk.h>"
		end

	frozen gtk_tool_button_new (icon_widget, a_label_text: POINTER): POINTER is
		external
			"C signature (GtkWidget*, gchar*): GtkToolItem* use <gtk/gtk.h>"
		end

	frozen gtk_radio_tool_button_new (a_radio_group: POINTER): POINTER is
		external
			"C signature (GSList*): GtkToolItem* use <gtk/gtk.h>"
		end

	frozen gtk_radio_tool_button_set_group (a_radio_button, a_radio_group: POINTER) is
		external
			"C signature (GtkRadioToolButton*, GSList*) use <gtk/gtk.h>"
		end

	frozen gtk_radio_tool_button_get_group (a_radio_button: POINTER): POINTER is
		external
			"C signature (GtkRadioToolButton*): GSList* use <gtk/gtk.h>"
		end

	frozen gtk_toolbar_icons_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_TOOLBAR_ICONS"
		end

	frozen gtk_toolbar_text_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_TOOLBAR_TEXT"
		end

	frozen gtk_toolbar_both_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_TOOLBAR_BOTH"
		end

	frozen gtk_toolbar_both_horiz_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_TOOLBAR_BOTH_HORIZ"
		end

	frozen gtk_toggle_tool_button_new: POINTER is
		external
			"C signature (): GtkToolItem* use <gtk/gtk.h>"
		end

	frozen gtk_tool_button_set_icon_widget (tool_button, icon_widget: POINTER) is
		external
			"C signature (GtkToolButton*, GtkWidget*) use <gtk/gtk.h>"
		end

	frozen gtk_tool_button_set_label_widget (tool_button, label_widget: POINTER) is
		external
			"C signature (GtkToolButton*, GtkWidget*) use <gtk/gtk.h>"
		end

	frozen gtk_tool_button_set_label (tool_button, a_text: POINTER) is
		external
			"C signature (GtkToolButton*, gchar*) use <gtk/gtk.h>"
		end

	frozen gtk_tool_button_get_label (tool_button: POINTER): POINTER is
		external
			"C signature (GtkToolButton*): gchar* use <gtk/gtk.h>"
		end

	frozen gtk_toolbar_get_nth_item (a_toolbar: POINTER; a_index: INTEGER): POINTER is
		external
			"C signature (GtkToolbar*, gint): GtkToolItem* use <gtk/gtk.h>"
		end

	frozen gtk_toolbar_insert (a_toolbar, a_toolitem: POINTER; a_pos: INTEGER) is
		external
			"C signature (GtkToolbar*, GtkToolItem*, gint) use <gtk/gtk.h>"
		end

	frozen gtk_file_filter_new: POINTER is
		external
			"C signature () use <gtk/gtk.h>"
		end

	frozen gtk_file_filter_add_pattern (a_filter, a_pattern: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_file_filter_add_pattern ((GtkFileFilter*) $a_filter, (gchar*) $a_pattern)"
		end

	frozen gtk_file_filter_set_name (a_filter, a_name: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_file_filter_set_name ((GtkFileFilter*) $a_filter, (gchar*) $a_name)"
		end

	frozen gtk_file_chooser_set_filter (a_file_chooser, a_filter: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_file_chooser_set_filter ((GtkFileChooser*) $a_file_chooser, (GtkFileFilter*) $a_filter)"
		end

	frozen gtk_file_chooser_add_filter (a_file_chooser, a_filter: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_file_chooser_add_filter ((GtkFileChooser*) $a_file_chooser, (GtkFileFilter*) $a_filter)"
		end

	frozen gtk_file_chooser_remove_filter (a_file_chooser, a_filter: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_file_chooser_remove_filter ((GtkFileChooser*) $a_file_chooser, (GtkFileFilter*) $a_filter)"
		end


	frozen gtk_file_chooser_action_open_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_FILE_CHOOSER_ACTION_OPEN"
		end

	frozen gtk_file_chooser_action_save_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_FILE_CHOOSER_ACTION_SAVE"
		end

	frozen gtk_file_chooser_action_select_folder_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER"
		end

	frozen gtk_file_chooser_action_create_folder_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_FILE_CHOOSER_ACTION_CREATE_FOLDER"
		end

	frozen gtk_dialog_add_button (a_dialog, a_text: POINTER; a_response_id: INTEGER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_dialog_add_button ((GtkDialog*) $a_dialog, (gchar*) $a_text, (gint) $a_response_id)"
		end

	frozen gtk_dialog_set_default_response (a_dialog: POINTER a_response_id: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_dialog_set_default_response ((GtkDialog*) $a_dialog, (gint) $a_response_id)"
		end

	frozen gtk_stock_ok_enum: POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_STOCK_OK"
		end

	frozen gtk_stock_open_enum: POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_STOCK_OPEN"
		end

	frozen gtk_response_accept_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_RESPONSE_ACCEPT"
		end

	frozen gtk_response_cancel_enum: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_RESPONSE_CANCEL"
		end


	frozen gtk_stock_save_enum: POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_STOCK_SAVE"
		end

	frozen gtk_stock_cancel_enum: POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_STOCK_CANCEL"
		end

	frozen gtk_file_chooser_dialog_new (a_title, a_parent: POINTER; a_action: INTEGER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_file_chooser_dialog_new ((gchar*) $a_title, (GtkWindow*) $a_parent, (GtkFileChooserAction) $a_action, NULL)"
		end

	frozen gtk_file_chooser (a_dialog: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_FILE_CHOOSER ( $a_dialog )"
		end

	frozen gtk_file_chooser_get_filename (a_dialog: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_file_chooser_get_filename ((GtkFileChooser*) $a_dialog)"
		end

	frozen gtk_file_chooser_get_filenames (a_dialog: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_file_chooser_get_filenames ((GtkFileChooser*) $a_dialog)"
		end

	frozen gtk_file_chooser_set_filename (a_dialog: POINTER; a_filename: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_file_chooser_set_filename ((GtkFileChooser*) $a_dialog, (gchar*) $a_filename)"
		end

	frozen gtk_file_chooser_set_local_only (a_dialog: POINTER; a_local_only: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_file_chooser_set_local_only ((GtkFileChooser*) $a_dialog, (gboolean) $a_local_only)"
		end

	frozen gtk_file_chooser_set_select_multiple (a_dialog: POINTER; a_multiple: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_file_chooser_set_select_multiple ((GtkFileChooser*) $a_dialog, (gboolean) $a_multiple)"
		end

	frozen gtk_file_chooser_get_filter (a_dialog: POINTER): POINTER is
		external
			"C signature (GtkFileChooser*): GtkFileFilter* use <gtk/gtk.h>"
		end

	frozen gtk_combo_box_get_entry (a_combo: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_ENTRY (GTK_BIN ( $a_combo )->child)"
		end

	frozen gtk_combo_box_get_active (a_combo: POINTER): INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_combo_box_get_active ((GtkComboBox*) $a_combo)"
		end

	frozen gtk_combo_box_set_active (a_combo: POINTER; a_active: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_combo_box_set_active ((GtkComboBox*) $a_combo, (gint) $a_active)"
		end

	frozen gtk_entry_get_completion (a_entry: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_entry_get_completion ((GtkEntry*) $a_entry)"
		end

	frozen gtk_combo_box_entry_new: POINTER is
		external
			"C signature (): GtkWidget* use <gtk/gtk.h>"
		end

	frozen gtk_combo_box_new: POINTER is
		external
			"C signature (): GtkWidget* use <gtk/gtk.h>"
		end

	frozen gtk_combo_box_set_model (a_combo_box, a_model: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_combo_box_set_model ((GtkComboBox*) $a_combo_box, (GtkTreeModel*) $a_model)"
		end

	frozen gtk_combo_box_entry_set_text_column (a_combo_box: POINTER; a_column: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_combo_box_entry_set_text_column ((GtkComboBoxEntry*) $a_combo_box, (gint) $a_column)"
		end

	frozen gtk_cell_layout_pack_start (a_cell_layout, a_cell_renderer: POINTER; a_expand: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_cell_layout_pack_start ((GtkCellLayout*) $a_cell_layout, (GtkCellRenderer*) $a_cell_renderer, (gboolean) $a_expand)"
		end

	frozen gtk_cell_layout_set_attribute (a_cell_layout, a_cell_renderer, a_attribute: POINTER; a_pos: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_cell_layout_set_attributes ((GtkCellLayout*) $a_cell_layout, (GtkCellRenderer*) $a_cell_renderer, (gchar*) $a_attribute, (gint) $a_pos, NULL)"
		end

	frozen gtk_cell_layout_reorder (a_cell_layout, a_cell_renderer: POINTER; a_pos: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_cell_layout_reorder ((GtkCellLayout*) $a_cell_layout, (GtkCellRenderer*) $a_cell_renderer, (gint) $a_pos)"
		end

	frozen gtk_cell_layout_clear (a_cell_layout: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_cell_layout_clear ((GtkCellLayout*) $a_cell_layout)"
		end

--	frozen gtk_event_box_set_visible_window (a_event_box: POINTER; a_visible: BOOLEAN) is
--		external
--			"C signature (GtkEventBox*, gboolean) use <gtk/gtk.h>"
--		end

	frozen gtk_tree_path_free (a_tree_path: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_path_free ((GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_view_get_path_at_pos (a_tree_view: POINTER; a_x, a_y: INTEGER; a_tree_path, a_tree_column: POINTER; a_cell_x, a_cell_y: POINTER): BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_get_path_at_pos ((GtkTreeView*) $a_tree_view, (gint) $a_x, (gint) $a_y, (GtkTreePath**) $a_tree_path, (GtkTreeViewColumn**) $a_tree_column, (gint*) $a_cell_x, (gint*) $a_cell_y)"
		end

	frozen gtk_tree_view_set_rules_hint (a_tree_view: POINTER; a_hint: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_set_rules_hint ((GtkTreeView*) $a_tree_view, (gboolean) $a_hint)"
		end

	frozen gtk_tree_view_column_get_cell_renderers (a_tree_view_column: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_get_cell_renderers ((GtkTreeViewColumn*) $a_tree_view_column)"
		end

	frozen gtk_tree_view_column_cell_get_size (a_tree_view_column: POINTER; a_cell_area: POINTER; a_x_offset, a_y_offset, a_width, a_height: TYPED_POINTER [INTEGER]) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_cell_get_size ((GtkTreeViewColumn*) $a_tree_view_column, (GdkRectangle*) $a_cell_area, (gint*) $a_x_offset, (gint*) $a_y_offset, (gint*) $a_width, (gint*) $a_height)"
		end

	frozen gtk_tree_view_columns_autosize (a_tree_view: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_columns_autosize ((GtkTreeView*) $a_tree_view)"
		end

	frozen gtk_tree_store_clear (a_tree_store: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_store_clear ((GtkTreeStore*) $a_tree_store)"
		end

	frozen gtk_list_store_clear (a_list_store: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_list_store_clear ((GtkListStore*) $a_list_store)"
		end

	frozen gtk_tree_view_get_headers_visible (a_tree_view: POINTER): BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_get_headers_visible ((GtkTreeView*) $a_tree_view)"
		end

	frozen gtk_tree_view_set_headers_visible (a_tree_view: POINTER; a_visible: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_set_headers_visible ((GtkTreeView*) $a_tree_view, (gboolean) $a_visible)"
		end

	frozen gtk_tree_view_set_enable_search (a_tree_view: POINTER; enable_search: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_set_enable_search ((GtkTreeView*) $a_tree_view, (gboolean) $enable_search)"
		end

	frozen gtk_tree_path_get_depth (a_tree_path: POINTER): INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_path_get_depth ((GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_path_get_indices (a_tree_path: POINTER): POINTER is
		external
			"C signature (GtkTreePath*): gint* use <gtk/gtk.h>"
		end

	frozen sizeof_gint: INTEGER is
			external
				"C inline use <gtk/gtk.h>"
			alias
				"sizeof(gint)"
			end

	frozen gtk_tree_path_next (a_tree_path: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_path_next ((GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_path_prev (a_tree_path: POINTER): BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_path_prev ((GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_path_up (a_tree_path: POINTER): BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_path_up ((GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_path_down (a_tree_path: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_path_down ((GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_selection_get_selected_rows (a_tree_selection: POINTER; a_model: TYPED_POINTER [POINTER]): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_selection_get_selected_rows ((GtkTreeSelection*) $a_tree_selection, (GtkTreeModel**) $a_model)"
		end

	frozen gtk_tree_selection_count_selected_rows (a_tree_selection: POINTER): INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_selection_count_selected_rows ((GtkTreeSelection*) $a_tree_selection)"
		end

	frozen gtk_tree_selection_select_iter (a_tree_selection, a_tree_iter: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_selection_select_iter ((GtkTreeSelection*) $a_tree_selection, (GtkTreeIter*) $a_tree_iter)"
		end

	frozen gtk_tree_selection_unselect_iter (a_tree_selection, a_tree_iter: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_selection_unselect_iter ((GtkTreeSelection*) $a_tree_selection, (GtkTreeIter*) $a_tree_iter)"
		end

	frozen gtk_tree_selection_select_all (a_tree_selection: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_selection_select_all ((GtkTreeSelection*) $a_tree_selection)"
		end

	frozen gtk_tree_selection_unselect_all (a_tree_selection: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_selection_unselect_all ((GtkTreeSelection*) $a_tree_selection)"
		end

	frozen gtk_tree_model_get_n_columns (a_tree_model: POINTER): INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_model_get_n_columns ((GtkTreeModel*) $a_tree_model)"
		end

	frozen gtk_tree_model_get_iter (a_tree_model, a_tree_iter, a_tree_path: POINTER): BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_model_get_iter ((GtkTreeModel*) $a_tree_model, (GtkTreeIter*) $a_tree_iter, (GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_model_get_path (a_tree_model, a_tree_iter: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_model_get_path ((GtkTreeModel*) $a_tree_model, (GtkTreeIter*) $a_tree_iter)"
		end

	frozen gtk_tree_model_get_value (a_tree_model, a_tree_iter: POINTER; a_column: INTEGER; a_value: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_model_get_value ((GtkTreeModel*) $a_tree_model, (GtkTreeIter*) $a_tree_iter, (gint) $a_column, (GValue*) $a_value)"
		end

	frozen gtk_tree_view_row_expanded (a_tree_view, a_tree_path: POINTER): BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_row_expanded ((GtkTreeView*) $a_tree_view, (GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_view_expand_row (a_tree_view, a_tree_path: POINTER; open_all: BOOLEAN): BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_expand_row ((GtkTreeView*) $a_tree_view, (GtkTreePath*) $a_tree_path, (gboolean) $open_all)"
		end

	frozen gtk_tree_view_expand_to_path (a_tree_view, a_tree_path: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_expand_to_path ((GtkTreeView*) $a_tree_view, (GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_view_collapse_row (a_tree_view, a_tree_path: POINTER): BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_collapse_row ((GtkTreeView*) $a_tree_view, (GtkTreePath*) $a_tree_path)"
		end

	frozen gtk_tree_view_get_column (a_tree_view: POINTER; a_index: INTEGER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_get_column ((GtkTreeView*) $a_tree_view, (gint) $a_index)"
		end

	frozen gtk_tree_view_get_bin_window (a_tree_view: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_get_bin_window ((GtkTreeView*) $a_tree_view)"
		end

	frozen gtk_tree_view_get_columns (a_tree_view: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_get_columns ((GtkTreeView*) $a_tree_view)"
		end

	frozen gtk_tree_view_get_selection (a_tree_view: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_get_selection ((GtkTreeView*) $a_tree_view)"
		end

	frozen gtk_tree_selection_set_mode (a_tree_sel: POINTER; a_mode: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_selection_set_mode ((GtkTreeSelection*) $a_tree_sel, (GtkSelectionMode) $a_mode)"
		end

	frozen gtk_tree_selection_get_mode (a_tree_sel: POINTER): INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_selection_get_mode ((GtkTreeSelection*) $a_tree_sel)"
		end

	frozen gtk_tree_view_column_set_alignment (a_tree_view_column: POINTER; a_align: REAL) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_set_alignment ((GtkTreeViewColumn*) $a_tree_view_column, (gfloat) $a_align)"
		end

	frozen gtk_tree_view_column_set_fixed_width (a_tree_view_column: POINTER; a_width: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_set_fixed_width ((GtkTreeViewColumn*) $a_tree_view_column, (gint) $a_width)"
		end

	frozen gtk_tree_view_column_get_fixed_width (a_tree_view_column: POINTER): INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_get_fixed_width ((GtkTreeViewColumn*) $a_tree_view_column)"
		end

	frozen gtk_tree_view_column_set_sizing (a_tree_view_column: POINTER; a_size_mode: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_set_sizing ((GtkTreeViewColumn*) $a_tree_view_column, (GtkTreeViewColumnSizing) $a_size_mode)"
		end

	frozen gtk_tree_view_column_set_resizable (a_tree_view_column: POINTER; a_expand: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_set_resizable ((GtkTreeViewColumn*) $a_tree_view_column, (gboolean) $a_expand)"
		end

	frozen gtk_tree_view_column_set_clickable (a_tree_view_column: POINTER; a_clickable: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_set_clickable ((GtkTreeViewColumn*) $a_tree_view_column, (gboolean) $a_clickable)"
		end

	frozen gtk_tree_view_column_set_widget (a_tree_view_column: POINTER; a_widget: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_set_widget ((GtkTreeViewColumn*) $a_tree_view_column, (GtkWidget*) $a_widget)"
		end

	frozen gtk_tree_view_column_get_widget (a_tree_view_column: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_get_widget ((GtkTreeViewColumn*) $a_tree_view_column)"
		end

	frozen gtk_tree_view_column_get_width (a_tree_view_column: POINTER): INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_get_width ((GtkTreeViewColumn*) $a_tree_view_column)"
		end

	frozen gtk_tree_view_column_set_visible (a_tree_view_column: POINTER; a_visible: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_set_visible ((GtkTreeViewColumn*) $a_tree_view_column, (gboolean) $a_visible)"
		end

	frozen gtk_tree_view_column_set_min_width (a_tree_view_column: POINTER; a_width: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_set_min_width ((GtkTreeViewColumn*) $a_tree_view_column, (gint) $a_width)"
		end

	frozen gtk_tree_view_column_set_max_width (a_tree_view_column: POINTER; a_width: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_set_max_width ((GtkTreeViewColumn*) $a_tree_view_column, (gint) $a_width)"
		end

	frozen gtk_tree_view_column_add_attribute (a_tree_view_column, a_cell_renderer, a_attribute: POINTER; a_column: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_add_attribute ((GtkTreeViewColumn*) $a_tree_view_column, (GtkCellRenderer*) $a_cell_renderer, (gchar*) $a_attribute, (gint) $a_column)"
		end

	frozen gtk_tree_view_column_new_with_attributes (a_title, a_cell_renderer: POINTER; a_column: INTEGER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_new_with_attributes ((gchar*) $a_title, (GtkCellRenderer*) $a_cell_renderer, %"text%", (int) $a_column)"
		end

	frozen gtk_cell_renderer_text_new: POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_cell_renderer_text_new()"
		end

	frozen gtk_cell_renderer_pixbuf_new: POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_cell_renderer_pixbuf_new()"
		end

	frozen gtk_cell_renderer_get_size (a_cell_renderer, a_widget, a_cell_area, a_x_offset, a_y_offset, a_width, a_height: POINTER) is
		external
			"C signature (GtkCellRenderer*, GtkWidget*, GdkRectangle*, gint*, gint*, gint*, gint*) use <gtk/gtk.h>"
		end

	frozen gtk_cell_renderer_get_fixed_size (a_cell_renderer, a_width, a_height: POINTER) is
		external
			"C signature (GtkCellRenderer*, gint*, gint*) use <gtk/gtk.h>"
		end

	frozen gtk_cell_renderer_set_fixed_size (a_cell_renderer: POINTER; a_width, a_height: INTEGER) is
		external
			"C signature (GtkCellRenderer*, gint, gint) use <gtk/gtk.h>"
		end

	frozen gtk_cell_renderer_toggle_new: POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_cell_renderer_toggle_new()"
		end

	frozen gtk_tree_view_insert_column (a_tree_view: POINTER; a_column: POINTER; a_position: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_insert_column ((GtkTreeView*) $a_tree_view, (GtkTreeViewColumn*) $a_column, (gint) $a_position)"
		end

	frozen gtk_tree_view_remove_column (a_tree_view: POINTER; a_column: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_remove_column ((GtkTreeView*) $a_tree_view, (GtkTreeViewColumn*) $a_column)"
		end

	frozen gtk_tree_view_append_column (a_tree_view: POINTER; a_column: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_append_column ((GtkTreeView*) $a_tree_view, (GtkTreeViewColumn*) $a_column)"
		end

	frozen gtk_tree_view_column_new: POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_new()"
		end

	frozen gtk_tree_view_column_set_title (a_tree_column, a_title: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_set_title((GtkTreeViewColumn*) $a_tree_column, (gchar*) $a_title)"
		end

	frozen gtk_tree_view_column_pack_start (a_tree_column, a_cell_renderer: POINTER; a_expand: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_pack_start ((GtkTreeViewColumn*) $a_tree_column, (GtkCellRenderer*) $a_cell_renderer, (gboolean) $a_expand)"
		end

	frozen gtk_tree_view_column_pack_end (a_tree_column, a_cell_renderer: POINTER; a_expand: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_view_column_pack_end ((GtkTreeViewColumn*) $a_tree_column, (GtkCellRenderer*) $a_cell_renderer, (gboolean) $a_expand)"
		end

	frozen g_type_string: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"G_TYPE_STRING"
		end

	frozen gdk_type_pixbuf: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_TYPE_PIXBUF"
		end

	frozen g_type_boolean: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"G_TYPE_BOOLEAN"
		end

	frozen c_g_value_struct_allocate: POINTER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"calloc (sizeof(GValue), 1)"
		end

	frozen c_gtk_tree_iter_allocate: POINTER is
		external
			"C [macro <gtk/gtk.h>]"
		alias
			"calloc (sizeof(GtkTreeIter), 1)"
		end

	frozen g_value_init_int (a_value: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_INT)"
		end

	frozen g_value_init_pointer (a_value: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_POINTER)"
		end

	frozen g_value_init_string (a_value: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_STRING)"
		end

	frozen g_value_init_object (a_value: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_OBJECT)"
		end

	frozen g_value_set_int (a_value: POINTER; a_int: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_set_int ((GValue*) $a_value, (gint) $a_int)"
		end

	frozen g_value_set_boolean (a_value: POINTER; a_boolean: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_set_boolean ((GValue*) $a_value, (gboolean) $a_boolean)"
		end

	frozen g_value_get_boolean (a_value: POINTER): BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_get_boolean ((GValue*) $a_value)"
		end

	frozen g_value_set_pointer (a_value: POINTER; a_pointer: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_set_pointer ((GValue*) $a_value, (gpointer) $a_pointer)"
		end

	frozen g_value_set_object (a_value: POINTER; a_pointer: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_set_object ((GValue*) $a_value, (gpointer) $a_pointer)"
		end

	frozen g_value_set_string (a_value: POINTER; a_string: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_set_string ((GValue*) $a_value, (gchar*) $a_string)"
		end

	frozen g_value_get_string (a_value: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_get_string ((GValue*) $a_value)"
		end

	frozen g_value_take_string (a_value: POINTER; a_string: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_take_string ((GValue*) $a_value, (gchar*) $a_string)"
		end

	frozen g_value_array_new (a_preallocated: INTEGER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_array_new ((guint) $a_preallocated)"
		end

	frozen g_value_array_free (a_value_array: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_array_free ((GValueArray*) $a_value_array)"
		end

	frozen g_value_array_insert (a_value_array: POINTER; a_index: INTEGER; a_value: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_array_insert ((GValueArray*) $a_value_array, (guint) $a_index, (GValue*) $a_value)"
		end

	frozen gtk_tree_view_new: POINTER is
		external
			"C signature (): GtkWidget* use <gtk/gtk.h>"
		end

	frozen gtk_tree_view_set_model (a_view, a_model: POINTER) is
		external
			"C signature (GtkTreeView*, GtkTreeModel*) use <gtk/gtk.h>"
		end

	frozen gtk_tree_store_newv (n_columns: INTEGER; types: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_store_newv ((gint) $n_columns, (GType*) $types)"
		end

	frozen gtk_list_store_newv (n_columns: INTEGER; types: POINTER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_list_store_newv ((gint) $n_columns, (GType*) $types)"
		end

	frozen gtk_tree_store_append (a_tree_store, a_tree_iter, a_parent_iter: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_store_append ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter, (GtkTreeIter*) $a_parent_iter)"
		end

	frozen gtk_list_store_append (a_list_store, a_tree_iter: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_list_store_append ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter)"
		end

	frozen gtk_tree_store_insert (a_tree_store, a_tree_iter, a_parent_iter: POINTER; a_index: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_store_insert ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter, (GtkTreeIter*) $a_parent_iter, (gint) $a_index)"
		end

	frozen gtk_list_store_insert (a_list_store, a_tree_iter: POINTER; a_index: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_list_store_insert ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index)"
		end

	frozen gtk_tree_store_remove (a_tree_store, a_tree_iter: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_store_remove ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter)"
		end

	frozen gtk_list_store_remove (a_list_store, a_tree_iter: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_list_store_remove ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter)"
		end

	frozen gtk_tree_store_set_value (a_tree_store, a_tree_iter: POINTER; a_index: INTEGER; a_value: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_store_set_value ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index, (GValue*) $a_value)"
		end

	frozen gtk_list_store_set_value (a_list_store, a_tree_iter: POINTER; a_index: INTEGER; a_value: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_list_store_set_value ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index, (GValue*) $a_value)"
		end

	frozen gtk_tree_store_set_pixbuf (a_tree_store, a_tree_iter: POINTER; a_index: INTEGER; a_pixbuf: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_tree_store_set ((GtkTreeStore*) $a_tree_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index, (GdkPixbuf*) $a_pixbuf, -1)"
		end

	frozen gtk_list_store_set_pixbuf (a_list_store, a_tree_iter: POINTER; a_index: INTEGER; a_pixbuf: POINTER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_list_store_set ((GtkListStore*) $a_list_store, (GtkTreeIter*) $a_tree_iter, (gint) $a_index, (GdkPixbuf*) $a_pixbuf, -1)"
		end

	frozen pango_underline_none_enum: INTEGER is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"PANGO_UNDERLINE_NONE"
		end

	frozen pango_underline_single_enum: INTEGER is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"PANGO_UNDERLINE_SINGLE"
		end

	frozen pango_underline_double_enum: INTEGER is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"PANGO_UNDERLINE_DOUBLE"
		end

	frozen gdk_screen_get_default: POINTER is
		external
			"C signature (): GdkScreen* use <gtk/gtk.h>"
		end

	frozen gdk_screen_get_width_mm (a_screen: POINTER): INTEGER is
		external
			"C signature (GdkScreen*): gint use <gtk/gtk.h>"
		end

	frozen gdk_screen_get_height_mm (a_screen: POINTER): INTEGER is
		external
			"C signature (GdkScreen*): gint use <gtk/gtk.h>"
		end


	frozen gdk_window_get_frame_extents (a_window, a_rect: POINTER) is
		external
			"C signature (GdkWindow*, GdkRectangle*) use <gtk/gtk.h>"
		end

	frozen gtk_entry_set_max_length (a_entry: POINTER; a_max: INTEGER) is
		external
			"C (GtkEntry*, gint) | <gtk/gtk.h>"
		end

	frozen gtk_entry_set_width_chars (a_entry: POINTER; a_width: INTEGER) is
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
			"((GValue*)$args_array + (int)($an_index))"
		end

	frozen g_value_array_i_th (args_array: POINTER; an_index: INTEGER): POINTER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"((GValue*)$args_array + (int)($an_index - 1))"
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
			"gdk_pixbuf_scale_simple ((GdkPixbuf*) $a_gdkpixbuf, (int) $a_width, (int) $a_height, (int) $a_interp_mode)"
		end

	frozen gdk_pixbuf_scale (src, dest: POINTER; dest_x, dest_y, dest_width, dest_height: INTEGER; offset_x, offset_y, scale_x, scale_y: DOUBLE; interp_type: INTEGER) is
		external
			"C signature (GdkPixbuf*, GdkPixbuf*, int, int, int, int, double, double, double, double, GdkInterpType) use <gtk/gtk.h>"
		end

	frozen gdk_interp_bilinear: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_INTERP_BILINEAR"
		end

	frozen gdk_interp_hyper: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_INTERP_HYPER"
		end

	frozen gdk_interp_nearest: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_INTERP_NEAREST"
		end

	frozen gdk_interp_tiles: INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GDK_INTERP_TILES"
		end

	frozen gdk_pixbuf_composite (src, dest: POINTER; dest_x, dest_y, dest_width, dest_height: INTEGER; offset_x, offset_y, scale_x, scale_y: DOUBLE; interp_type, overall_alpha: INTEGER) is
		external
			"C signature (GdkPixbuf*, GdkPixbuf*, int, int, int, int, double, double, double, double, GdkInterpType, int) use <gtk/gtk.h>"
		end

	frozen gdk_pixbuf_copy_area (src: POINTER; src_x, src_y, a_width, a_height: INTEGER; dest: POINTER; dest_x, dest_y: INTEGER) is
		external
			"C signature (GdkPixbuf*, int, int, int, int, GdkPixbuf*, int, int) use <gtk/gtk.h>"
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

	frozen gdk_pixbuf_get_has_alpha (a_pixbuf: POINTER): BOOLEAN is
		external
			"C signature (GdkPixbuf*): gboolean use <gtk/gtk.h>"
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

	frozen gdk_pixbuf_get_from_image (a_pixbuf, a_drawable, a_colormap: POINTER; src_x, src_y, dest_x, dest_y, a_width, a_height: INTEGER): POINTER is
		external
			"C signature (GdkPixbuf*, GdkImage*, GdkColormap*, int, int, int, int, int, int): GdkPixbuf use <gtk/gtk.h>"
		end

	frozen g_locale_to_utf8 (a_string: POINTER; a_length: INTEGER; bytes_read, bytes_written: TYPED_POINTER [INTEGER]; gerror: TYPED_POINTER [POINTER]; a_result: TYPED_POINTER [POINTER]) is
		external
			"C inline use <gtk/gtk.h>"
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

		end

	frozen g_filename_to_utf8 (a_string: POINTER; a_length: INTEGER; bytes_read, bytes_written: TYPED_POINTER [INTEGER]; gerror: TYPED_POINTER [POINTER]; a_result: TYPED_POINTER [POINTER]) is
		external
			"C inline use <gtk/gtk.h>"
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

		end

	frozen g_utf8_strlen (a_utf8_string: POINTER; maximum: INTEGER): INTEGER is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_utf8_strlen ((gchar*) $a_utf8_string, (gssize) $maximum)"
		end

	frozen g_utf8_validate (a_utf8_string: POINTER; maximum: INTEGER; a_end: TYPED_POINTER [POINTER]): BOOLEAN is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_utf8_validate ((gchar*) $a_utf8_string, (gssize) $maximum, (const gchar**) $a_end)"
		end

	frozen g_locale_from_utf8 (a_string: POINTER; a_length: INTEGER; bytes_read, bytes_written: TYPED_POINTER [INTEGER]; gerror: TYPED_POINTER [POINTER]; a_result: TYPED_POINTER [POINTER]) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				{
					gsize temp_bytes_read;
					gsize temp_bytes_written;
					*$a_result = g_locale_from_utf8 ((gchar*) $a_string, (gssize) $a_length, &temp_bytes_read, &temp_bytes_written, (GError**) $gerror);
					*$bytes_read = (EIF_INTEGER) temp_bytes_read;
					*$bytes_written = (EIF_INTEGER) temp_bytes_written;
				}
			]"

		end

	frozen g_filename_from_utf8 (a_string: POINTER; a_length: INTEGER; bytes_read, bytes_written: TYPED_POINTER [INTEGER]; gerror: TYPED_POINTER [POINTER]; a_result: TYPED_POINTER [POINTER]) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				{
					gsize temp_bytes_read;
					gsize temp_bytes_written;
					*$a_result = g_filename_from_utf8 ((gchar*) $a_string, (gssize) $a_length, &temp_bytes_read, &temp_bytes_written, (GError**) $gerror);
					*$bytes_read = (EIF_INTEGER) temp_bytes_read;
					*$bytes_written = (EIF_INTEGER) temp_bytes_written;
				}
			]"
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

	frozen gtk_value_uchar (arg: POINTER): INTEGER is
			-- Integer value from a GtkArg.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_get_uchar ((GValue*) $arg)"
		end

	frozen gtk_value_enum (arg: POINTER): INTEGER is
			-- Integer value from a GtkArg.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_get_enum ((GValue*) $arg)"
		end

	frozen gtk_value_flags (arg: POINTER): INTEGER is
			-- Integer value from a GtkArg.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_value_get_flags ((GValue*) $arg)"
		end

	frozen gtk_value_uint (arg: POINTER): NATURAL_32 is
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

	frozen pango_layout_set_width (a_layout: POINTER; a_width: INTEGER) is
		external
			"C signature (PangoLayout*, int) use <gtk/gtk.h>"
		end

	frozen pango_layout_get_pixel_size (a_layout: POINTER; a_width, a_height: TYPED_POINTER [INTEGER]) is
		external
			"C signature (PangoLayout*, gint*, gint*) use <gtk/gtk.h>"
		end

	frozen pango_layout_get_iter (a_layout: POINTER): POINTER is
		external
			"C signature (PangoLayout*): PangoLayoutIter* use <gtk/gtk.h>"
		end

	frozen pango_layout_set_text (a_layout: POINTER; a_text: POINTER; a_length: INTEGER) is
		external
			"C signature (PangoLayout*, char*, int) use <gtk/gtk.h>"
		end

	frozen pango_layout_iter_get_baseline (a_iter: POINTER): INTEGER is
		external
			"C signature (PangoLayoutIter*): gint use <gtk/gtk.h>"
		end

	frozen pango_layout_iter_free (a_iter: POINTER) is
		external
			"C signature (PangoLayoutIter*) use <gtk/gtk.h>"
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

	frozen pango_font_description_to_string (a_pango_description: POINTER): POINTER is
		external
			"C signature (PangoFontDescription*): char* use <gtk/gtk.h>"
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

	frozen pango_font_description_from_string (a_description: POINTER): POINTER is
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
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, (gfloat) $double_arg, NULL)"
		end

	frozen g_object_set_boolean (a_object: POINTER; a_property: POINTER; bool_arg: BOOLEAN) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, (gboolean) $bool_arg, NULL)"
		end

	frozen signal_disconnect (a_object: POINTER; a_handler_id: INTEGER) is
		external
			"C signature (gpointer, gulong) use <gtk/gtk.h>"
		alias
			"g_signal_handler_disconnect"
		end

	frozen signal_disconnect_by_data (a_c_object: POINTER; data: INTEGER) is
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_signal_handlers_disconnect_matched ((gpointer) $a_c_object, G_SIGNAL_MATCH_DATA, 0, 0, NULL, NULL, (gpointer) (rt_int_ptr) $data)"
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

	frozen signal_emit_by_name (a_object: POINTER; a_name: POINTER) is
		external
			"C macro use <gtk/gtk.h>"
		alias
			"gtk_signal_emit_by_name"
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

	frozen gtk_text_iter_starts_line (a_iter: POINTER): BOOLEAN is
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

	frozen gtk_text_tag_table_lookup (a_table: POINTER; a_name: POINTER): POINTER is
		external
			"C signature (GtkTextTagTable*, gchar*): GtkTextTag* use <gtk/gtk.h>"
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

	frozen gtk_clipboard_get (a_atom: POINTER): POINTER is
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

	frozen gtk_text_view_scroll_to_mark (a_text_view: POINTER; a_text_mark: POINTER; within_margin: DOUBLE; use_align: BOOLEAN; xalign: DOUBLE; yalign: DOUBLE) is
		external
			"C signature (GtkTextView*, GtkTextMark*, gdouble, gboolean, gdouble, gdouble) use <gtk/gtk.h> "
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

	frozen gtk_image_set_from_pixbuf (a_image: POINTER; a_pixbuf: POINTER) is
		external
			"C signature (GtkImage*, GdkPixbuf*) use <gtk/gtk.h>"
		end

	frozen gtk_image_get_pixmap (a_image: POINTER; a_pixmap: POINTER; a_mask: POINTER) is
		external
			"C signature (GtkImage*, GdkPixmap**, GdkBitmap**) use <gtk/gtk.h>"
		end

	frozen gtk_image_get_pixbuf (a_image: POINTER): POINTER is
		external
			"C signature (GtkImage*): GdkPixbuf* use <gtk/gtk.h>"
		end

	frozen gtk_image_new_from_pixmap (a_pixmap: POINTER; a_mask: POINTER): POINTER is
		external
			"C signature (GdkPixmap*, GdkBitmap*): GtkImage* use <gtk/gtk.h>"
		end

	frozen gtk_image_new_from_pixbuf (a_pixbuf: POINTER): POINTER is
		external
			"C signature (GdkPixbuf*): GtkImage* use <gtk/gtk.h>"
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

