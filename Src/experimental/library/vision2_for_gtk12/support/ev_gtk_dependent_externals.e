note
	description: "Gtk Version Dependent Externals"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_DEPENDENT_EXTERNALS

feature -- Externals

	frozen gtk_widget_toplevel (a_widget: POINTER): BOOLEAN
		external
			"C macro use <gtk/gtk.h>"
		alias
			"GTK_WIDGET_TOPLEVEL"
		end

	frozen gtk_window_get_focus (a_window: POINTER): POINTER
		external
			"C [struct <gtk/gtk.h>] (GtkWindow): EIF_POINTER"
		alias
			"focus_widget"
		end

	frozen gtk_window_set_accept_focus (a_window: POINTER; a_focus: BOOLEAN)
		external
			"C inline"
		alias
			" "
		end

	frozen gtk_window_present (a_window: POINTER)
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_widget_show ((GtkWidget*) $a_window)"
		end

	frozen gtk_tooltips_struct_tip_label (a_c_struct: POINTER): POINTER
		external
			"C inline"
		alias
			"return NULL;"
		end

	frozen events_pending: BOOLEAN
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_main_pending()"
		end

	frozen dispatch_events
		external
			"C inline use <gtk/gtk.h>"
		alias
			"g_main_iteration(FALSE)"
		end

	frozen new_g_static_rec_mutex: POINTER
		external
			"C inline use <gtk/gtk.h>"
		alias
			"return NULL;"
		end

	frozen g_static_rec_mutex_init (a_static_mutex: POINTER)
		external
			"C inline use <gtk/gtk.h>"
		alias
			" "
		end

	frozen g_static_rec_mutex_lock (a_static_mutex: POINTER)
		external
			"C inline use <gtk/gtk.h>"
		alias
			" "
		end

	frozen g_static_rec_mutex_trylock (a_static_mutex: POINTER): BOOLEAN
		external
			"C inline use <gtk/gtk.h>"
		alias
			"return (EIF_BOOLEAN)1;"
		end

	frozen g_static_rec_mutex_unlock (a_static_mutex: POINTER)
		external
			"C inline use <gtk/gtk.h>"
		alias
			" "
		end

	frozen g_thread_supported: BOOLEAN
		external
			"C inline use <gtk/gtk.h>"
		alias
			"return NULL;"
		end

	frozen g_thread_init
		external
			"C inline use <gtk/gtk.h>"
		alias
			" "
		end

	frozen gdk_window_invalidate_rect (a_drawable, a_rectangle: POINTER; a_children: BOOLEAN)
		external
			"C inline use <gtk/gtk.h>"
		alias
			" "
		end

	frozen gtk_widget_set_double_buffered (a_widget: POINTER; a_double_buffer: BOOLEAN)
		external
			"C inline use <gtk/gtk.h>"
		alias
			" "
		end

	frozen gtk_widget_set_redraw_on_allocate (a_widget: POINTER; a_allocate: BOOLEAN)
		external
			"C inline use <gtk/gtk.h>"
		alias
			" "
		end

	frozen gtk_window_move (a_window: POINTER; a_x, a_y: INTEGER)
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gdk_window_move (((GtkWidget*)$a_window)->window, (gint) $a_x, (gint) $a_y)"
		end

	frozen gtk_fixed_set_has_window (a_fixed: POINTER; has_window: BOOLEAN)
		external
			"C inline use <gtk/gtk.h>"
		alias
			" "
		end

	frozen gtk_window_is_active (a_window: POINTER): BOOLEAN
		external
			"C inline use <gtk/gtk.h>"
		alias
			"((GtkObject*) $a_window)->flags & GTK_HAS_FOCUS"
		end

	frozen gdk_window_process_updates (a_window: POINTER; process_children: BOOLEAN)
		external
			"C inline use <gtk/gtk.h>"
		alias
			" "
		end

	frozen gtk_scrolled_window_set_shadow_type (a_window: POINTER; a_shadow_type: INTEGER)
		external
			"C inline use <gtk/gtk.h>"
		alias
			" "
		end

	frozen gtk_event_box_set_visible_window (c_object: POINTER; a_visible: BOOLEAN)
		external
			"C inline use <gtk/gtk.h>"
		alias
			" "
		end

	frozen gdk_selection_owner_get (a_selection: INTEGER): POINTER
			-- GdkWindow* gdk_selection_owner_get (GdkAtom	  selection);
			-- (from C_GDK)
		external
			"C (GdkAtom): GdkWindow* | <gtk/gtk.h>"
		end

	frozen gdk_selection_owner_set (a_owner: POINTER; a_selection: INTEGER; a_time: INTEGER; a_send_event: INTEGER): BOOLEAN
			-- gboolean   gdk_selection_owner_set (GdkWindow	 *owner,
			-- 				    GdkAtom	  selection,
			-- 				    guint32	  time,
			-- 				    gint	  send_event);
			-- (from C_GDK)
		external
			"C (GdkWindow*, GdkAtom, guint32, gint): gboolean | <gtk/gtk.h>"
		end

	frozen gdk_selection_send_notify (a_requestor: INTEGER; a_selection: INTEGER; a_target: INTEGER; a_property: INTEGER; a_time: INTEGER)
			-- void	   gdk_selection_send_notify (guint32	    requestor,
			-- 				      GdkAtom	    selection,
			-- 				      GdkAtom	    target,
			-- 				      GdkAtom	    property,
			-- 				      guint32	    time);
			-- (from C_GDK)
		external
			"C (guint32, GdkAtom, GdkAtom, GdkAtom, guint32) | <gtk/gtk.h>"
		end

	frozen gtk_widget_set_minimum_size (a_widget: POINTER; a_width, a_height: INTEGER)
		external
			"C inline use <gtk/gtk.h>"
		alias
			"gtk_widget_set_usize ((GtkWidget*) $a_widget, (gint) $a_width, (gint) $a_height)"
		end

	frozen gtk_window_dialog_enum: INTEGER
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_WINDOW_DIALOG"
		end

	frozen gtk_entry_set_max_length (a_entry: POINTER; a_max: INTEGER)
			-- void       gtk_entry_set_max_length 		(GtkEntry      *entry,
			-- 						 guint16        max);
			-- (from C_GTK_ENTRY)
		external
			"C (GtkEntry*, guint16) | <gtk/gtk.h>"
		end

	frozen gtk_fixed_get_type: INTEGER
			-- GtkType    gtk_fixed_get_type          (void);
			-- (from C_GTK_FIXED)
		external
			"C (): GtkType | <gtk/gtk.h>"
		end

	frozen gtk_fixed_move (a_fixed: POINTER; a_widget: POINTER; a_x: INTEGER; a_y: INTEGER)
			-- void       gtk_fixed_move              (GtkFixed       *fixed,
			--                                         GtkWidget      *widget,
			--                                         gint16         x,
			--                                         gint16         y);
			-- (from C_GTK_FIXED)
		external
			"C (GtkFixed*, GtkWidget*, gint16, gint16) | <gtk/gtk.h>"
		end

	frozen gtk_fixed_new: POINTER
			-- GtkWidget* gtk_fixed_new               (void);
			-- (from C_GTK_FIXED)
		external
			"C (): GtkWidget* | <gtk/gtk.h>"
		end

	frozen gtk_fixed_put (a_fixed: POINTER; a_widget: POINTER; a_x: INTEGER; a_y: INTEGER)
			-- void       gtk_fixed_put               (GtkFixed       *fixed,
			--                                         GtkWidget      *widget,
			--                                         gint16         x,
			--                                         gint16         y);
			-- (from C_GTK_FIXED)
		external
			"C (GtkFixed*, GtkWidget*, gint16, gint16) | <gtk/gtk.h>"
		end

	frozen set_gdk_rectangle_struct_height (a_c_struct: POINTER; a_height: INTEGER)
			-- (from C_GDK_RECTANGLE_STRUCT)
		external
			"C [struct <gtk/gtk.h>] (GdkRectangle, guint16)"
		alias
			"height"
		end

	frozen set_gdk_rectangle_struct_width (a_c_struct: POINTER; a_width: INTEGER)
			-- (from C_GDK_RECTANGLE_STRUCT)
		external
			"C [struct <gtk/gtk.h>] (GdkRectangle, guint16)"
		alias
			"width"
		end

	frozen set_gdk_rectangle_struct_x (a_c_struct: POINTER; a_x: INTEGER)
			-- (from C_GDK_RECTANGLE_STRUCT)
		external
			"C [struct <gtk/gtk.h>] (GdkRectangle, gint16)"
		alias
			"x"
		end

	frozen set_gdk_rectangle_struct_y (a_c_struct: POINTER; a_y: INTEGER)
			-- (from C_GDK_RECTANGLE_STRUCT)
		external
			"C [struct <gtk/gtk.h>] (GdkRectangle, gint16)"
		alias
			"y"
		end

	frozen gtk_args_array_i_th (args_array: POINTER; an_index: INTEGER): POINTER
			-- GtkArg* gtk_args_array_i_th (GtkArg** args_array, int index) {
			--	return (GtkArg*)(args_array + index);
			-- }
		external
			"C | %"ev_c_util.h%""
		end

	frozen c_gtk_menu_popup (menu: POINTER; x, y: INTEGER)
			-- Show `menu' on (`x', `y').
			-- (from EV_C_GTK)
		external
			"C | %"ev_menu_imp.h%""
		end

	frozen c_gdk_colormap_query_color (a_colormap: POINTER; a_pixel: INTEGER; a_gdkcolor_result: POINTER)
			-- Retrieve `a_gdkcolor_result' values from `a_pixel' using `a_colormap'.
			-- (from EV_C_GTK)
		external
			" C (GdkColormap *, gulong, GdkColor *)| %"gtk_eiffel.h%""
		end

	frozen c_gdk_window_deiconify (a_window: POINTER)
			-- (from EV_C_GTK)
		external
			"C (GdkWindow *) | %"ev_titled_window_imp.h%""
		end

	frozen c_gdk_window_iconify (a_window: POINTER)
			-- (from EV_C_GTK)
		external
			"C (GdkWindow *) | %"ev_titled_window_imp.h%""
		end

	frozen c_gdk_window_is_iconified (a_window: POINTER): BOOLEAN
			-- (from EV_C_GTK)
		external
			"C (GdkWindow *): gboolean | %"ev_titled_window_imp.h%""
		end

	frozen gtk_value_pointer (arg: POINTER): POINTER
			-- Pointer to the value of a GtkArg.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_VALUE_POINTER (*(GtkArg*) $arg )"
		end

	frozen gtk_value_int (arg: POINTER): INTEGER
			-- Integer value from a GtkArg.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_VALUE_INT (*(GtkArg*) $arg )"
		end

	frozen gtk_value_uint (arg: POINTER): NATURAL_32
			-- Integer value from a GtkArg.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_VALUE_UINT (*(GtkArg*) $arg )"
		end

	frozen gtk_value_flags (arg: POINTER): INTEGER
			-- Integer value from a GtkArg.
		external
			"C inline use <gtk/gtk.h>"
		alias
			"GTK_VALUE_FLAGS (*(GtkArg*) $arg )"
		end

	frozen signal_disconnect (a_object: POINTER; a_handler_id: INTEGER)
		external
			"C (GtkObject*, guint) | <gtk/gtk.h>"
		alias
			"gtk_signal_disconnect"
		end

	frozen signal_disconnect_by_data (a_c_object: POINTER; data: INTEGER)
		external
			"C (GtkObject*, gpointer) | <gtk/gtk.h>"
		alias
			"gtk_signal_disconnect_by_data"
		end

	frozen signal_handler_block (a_object: POINTER; a_handler_id: INTEGER)
			-- void   gtk_signal_handler_block (GtkObject *object, guint handler_id);)
		external
			"C (GtkObject*, guint) | <gtk/gtk.h>"
		alias
			"gtk_signal_handler_block"
		end

	frozen signal_handler_unblock (a_object: POINTER; a_handler_id: INTEGER)
			-- void   gtk_signal_handler_unblock      (GtkObject           *object,
			--                                         guint                handler_id);
		external
			"C (GtkObject*, guint) | <gtk/gtk.h>"
		alias
			"gtk_signal_handler_unblock"
		end

	frozen signal_emit_stop_by_name (a_object: POINTER; a_name: POINTER)
			-- void   gtk_signal_emit_stop_by_name    (GtkObject           *object,
			--                                         const gchar         *name);
		external
			"C (GtkObject*, gchar*) | <gtk/gtk.h>"
		alias
			"gtk_signal_emit_stop_by_name"
		end

	frozen gtk_editable_struct_selection_start (a_c_struct: POINTER): INTEGER
		external
			"C [struct <gtk/gtk.h>] (GtkEditable): EIF_INTEGER"
		alias
			"selection_start_pos"
		end

	frozen gtk_editable_struct_selection_end (a_c_struct: POINTER): INTEGER
		external
			"C [struct <gtk/gtk.h>] (GtkEditable): EIF_INTEGER"
		alias
			"selection_end_pos"
		end

	frozen gtk_style_set_font (a_c_struct: POINTER; a_font: POINTER)
		external
			"C [struct <gtk/gtk.h>] (GtkStyle, GdkFont*)"
		alias
			"font"
		end

	frozen gtk_style_get_font (a_c_struct: POINTER): POINTER
			-- (from C_GTK_STYLE_STRUCT)
		external
			"C [struct <gtk/gtk.h>] (GtkStyle): EIF_POINTER"
		alias
			"font"
		end

	frozen gtk_paned_set_gutter_size (a_paned: POINTER; a_size: INTEGER)
		external
			"C (GtkPaned*, guint16) | <gtk/gtk.h>"
		end

	frozen gtk_paned_set_handle_size (a_paned: POINTER; a_size: INTEGER)
		external
			"C (GtkPaned*, guint16) | <gtk/gtk.h>"
		end

	frozen gtk_menu_bar_set_shadow_type (a_menu_bar: POINTER; a_type: INTEGER)
		external
			"C (GtkMenuBar*, GtkShadowType) | <gtk/gtk.h>"
		end

	frozen gtk_editable_get_editable (a_c_struct: POINTER): BOOLEAN
		do
			Result := gtk_editable_struct_editable (a_c_struct) /= 0
		end

	frozen gtk_widget_set_default_visual (a_visual: POINTER)
			-- void	     gtk_widget_set_default_visual   (GdkVisual	  *visual);
			-- (from C_GTK_WIDGET)
		external
			"C (GdkVisual*) | <gtk/gtk.h>"
		end

	frozen object_destroy (a_c_object: POINTER)
			-- Only for use in dispose.
			-- (Dispose cannot call C.gtk_object_destroy)
		external
			"C (GtkObject*) | <gtk/gtk.h>"
		alias
			"gtk_object_destroy"
		end

	frozen object_ref (a_c_object: POINTER)
		external
			"C (GtkObject*) | <gtk/gtk.h>"
		alias
			"gtk_object_ref"
		end

	frozen object_unref (a_c_object: POINTER)
		external
			"C (GtkObject*) | <gtk/gtk.h>"
		alias
			"gtk_object_unref"
		end

feature {NONE} -- Implementation

	frozen gtk_editable_struct_editable (a_c_struct: POINTER): INTEGER
			-- (from C_GTK_EDITABLE_STRUCT)
		external
			"C [struct <gtk/gtk.h>] (GtkEditable): EIF_INTEGER"
		alias
			"editable"
		end

note
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

