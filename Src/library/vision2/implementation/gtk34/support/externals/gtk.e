note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	GTK

inherit
	GTK3

	GTK_DEPRECATED

feature -- GTK version	

	frozen gtk_maj_ver: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_MAJOR_VERSION"
		end

	frozen gtk_min_ver: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_MINOR_VERSION"
		end

	frozen gtk_mic_ver: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_MICRO_VERSION"
		end

feature -- Module		

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

feature -- Settings

	frozen gtk_settings_get_default: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gtk_settings_get_default();"
		end

feature -- Window		

	frozen gtk_is_window (w: POINTER): BOOLEAN
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_IS_WINDOW"
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

	frozen gtk_window_get_title (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkWindow*): gchar* use <ev_gtk.h>"
		end

	frozen gtk_window_get_transient_for (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkWindow*): GtkWindow* use <ev_gtk.h>"
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

	frozen top_level_active_gtk_window: POINTER
			-- Active top level GtkWindow.
		local
			glist, p: POINTER
			i, n: INTEGER
		do
			glist := gtk_window_list_toplevels
			if not glist.is_default_pointer then
				n := g_list_length (glist)
				from
					i := 1
				until
					i > n or not Result.is_default_pointer
				loop
					p := g_list_nth_data (glist, i - 1)
					if gtk_window_is_active (p) then
						Result := p
					end
					i := i + 1
				end
			end
			{GTK}.g_list_free (glist)
		ensure
			instance_free: class
		end

	frozen gtk_window_list_toplevels: POINTER
			-- GList* containing all top level windows.
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_window_list_toplevels()"
		end

feature -- Container

	frozen gtk_is_container (w: POINTER): BOOLEAN
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_IS_CONTAINER"
		end

	frozen gtk_container_add (a_container: POINTER; a_widget: POINTER)
		external
			"C (GtkContainer*, GtkWidget*) | <ev_gtk.h>"
		end

	frozen gtk_container_check_resize (a_container: POINTER)
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

	frozen gtk_container_get_border_width (a_c_struct: POINTER): INTEGER_32
		external
			"C signature (GtkContainer*): EIF_INTEGER use <ev_gtk.h>"
		end


feature -- Widgets

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

	frozen gtk_widget_is_visible (a_widget: POINTER): BOOLEAN
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

	frozen gtk_widget_get_window (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkWidget*): GdkWindow* use <ev_gtk.h>"
		end

	frozen gtk_widget_get_parent_window (a_c_struct: POINTER): POINTER
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

	frozen gtk_widget_get_state_flags (a_gtk_widget: POINTER): INTEGER_32
		external
			"C signature (GtkWidget*): EIF_INTEGER use <ev_gtk.h>"
		end

	frozen gtk_widget_add_events (a_widget: POINTER; a_events: INTEGER_32)
		external
			"C (GtkWidget*, gint) | <ev_gtk.h>"
		end

	frozen gtk_widget_set_events (a_widget: POINTER; a_events: INTEGER_32)
		external
			"C (GtkWidget*, gint) | <ev_gtk.h>"
		end

	frozen gtk_widget_get_events (a_widget: POINTER): INTEGER_32
		external
			"C (GtkWidget*): gint | <ev_gtk.h>"
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
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_queue_draw ((GtkWidget *)$a_widget)"
		end

	frozen gtk_widget_queue_draw_area (a_widget: POINTER; a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_widget_queue_draw_area ((GtkWidget *) $a_widget, (gint) $a_x, (gint) $a_y, (gint) $a_width, (gint) $a_height)"
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

	frozen gtk_widget_get_name (a_widget: POINTER): POINTER
		external
			"C signature (GtkWidget*): const gchar * use <ev_gtk.h>"
		end

	frozen gtk_widget_set_sensitive (a_widget: POINTER; a_sensitive: BOOLEAN)
		external
			"C (GtkWidget*, gboolean) | <ev_gtk.h>"
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


feature -- Widget Style		

	frozen gtk_style_context_get_color (a_context: POINTER; a_state: INTEGER; a_color: POINTER)
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

feature -- Drawing

	frozen gtk_drawing_area_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

feature -- Source

	frozen g_source_remove (a_source_id: NATURAL_32)
		external
			"C signature (guint) use <ev_gtk.h>"
		end

feature -- CellLayout

	frozen gtk_cell_layout_get_cells (a_gtk_cell_layout: POINTER): POINTER
		external
			"C signature (GtkCellLayout*): GList* use <ev_gtk.h>"
		end

feature -- ProgressBar

	frozen gtk_progress_bar_new: POINTER
		external
			"C signature (): GtkWidget* use <ev_gtk.h>"
		end

	frozen gtk_progress_bar_set_fraction (a_bar: POINTER; a_fraction: REAL_64)
		external
			"C signature (GtkProgressBar*, gdouble) use <ev_gtk.h>"
		end

	frozen gtk_progress_bar_set_inverted (a_bar: POINTER; a_boolean: BOOLEAN)
		external
			"C signature (GtkProgressBar*, gboolean) use <ev_gtk.h>"
		end

feature -- EntryBuffer

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

	frozen gtk_entry_get_max_length (a_c_struct: POINTER): INTEGER_32
		external
			"C signature (GtkEntry*): EIF_INTEGER use <ev_gtk.h>"
		end

feature -- MASK, enum	

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


	frozen gtk_window_toplevel_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_WINDOW_TOPLEVEL"
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

	frozen gtk_win_pos_mouse_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GTK_WIN_POS_MOUSE"
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

feature -- Memory

	frozen g_free (a_mem: POINTER)
		external
			"C (gpointer) | <ev_gtk.h>"
		end

	frozen g_malloc (a_size: INTEGER_32): POINTER
		external
			"C (gulong): gpointer | <ev_gtk.h>"
		end

	frozen g_realloc (a_mem: POINTER; a_size: INTEGER_32): POINTER
		external
			"C (gpointer, gulong): gpointer | <ev_gtk.h>"
		end

feature -- List		

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

feature -- SList

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

feature -- Selection, Drag, Drop

	frozen gtk_drag_finish (a_context: POINTER; a_success: BOOLEAN; del: BOOLEAN; a_time: NATURAL_32)
		external
			"C (GdkDragContext*, gboolean, gboolean, guint32) | <ev_gtk.h>"
		ensure
			is_class: class
		end

feature -- Device

	frozen gtk_get_current_event_device: POINTER
		external
			"C signature (): GtkDevice * use <ev_gtk.h>"
		end

feature -- Box

	frozen gtk_box_get_homogeneous (a_c_struct: POINTER): BOOLEAN
		external
			"C signature (GtkBox*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_box_get_spacing (a_c_struct: POINTER): INTEGER_32
		external
			"C signature (GtkBox*): gint use <ev_gtk.h>"
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

feature -- Separator

	frozen gtk_separator_new (a_orientation: NATURAL_8): POINTER
		external
			"C (GtkOrientation): GtkWidget* | <ev_gtk.h>"
		end

feature -- Button		

	frozen gtk_button_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_check_button_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
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

feature -- Menu

	frozen gtk_is_menu (w: POINTER): BOOLEAN
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_IS_MENU"
		end

	frozen gtk_check_menu_item_new: POINTER
		external
			"C (): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_check_menu_item_get_active (a_c_struct: POINTER): BOOLEAN
		external
			"C signature (GtkCheckMenuItem*): gboolean use <ev_gtk.h>"
		end

	frozen gtk_check_menu_item_set_active (a_check_menu_item: POINTER; a_is_active: BOOLEAN)
		external
			"C (GtkCheckMenuItem*, gboolean) | <ev_gtk.h>"
		end

	frozen gtk_check_menu_item_set_draw_as_radio (a_menu_item: POINTER; a_always: BOOLEAN)
		external
			"C (GtkCheckMenuItem*, gboolean) | <ev_gtk.h>"
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

	frozen gtk_separator_menu_item_new: POINTER
	 	external
			"C inline use <ev_gtk.h>"
		alias
			"return gtk_separator_menu_item_new ();"
		end

feature -- Editable

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

feature -- Entry		

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
			"gtk_entry_set_width_chars ((GtkEntry *)$a_entry, (gint)$n_chars)"
		end

	frozen gtk_entry_set_visibility (a_entry: POINTER; a_visible: BOOLEAN)
		external
			"C (GtkEntry*, gboolean) | <ev_gtk.h>"
		end

feature -- Color

	frozen gtk_color_chooser_dialog_new (a_title, a_parent: POINTER): POINTER
		external
			"C (gchar*, GtkWindow*): GtkWidget* | <ev_gtk.h>"
		end

feature -- Font		

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

feature -- Frame		

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


feature -- Grab

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


feature -- Paned		

	frozen gtk_paned_new (a_orientation: NATURAL_8): POINTER
		external
			"C (GtkOrientation): GtkWidget* | <ev_gtk.h>"
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

feature -- Scrollbar

	frozen gtk_scrollbar_new (a_orientation: NATURAL_8; a_adjustment: POINTER): POINTER
		external
			"C (GtkOrientation, GtkAdjustment*): GtkWidget* | <ev_gtk.h>"
		end

feature -- Label		

	frozen gtk_is_label (w: POINTER): BOOLEAN
		external
			"C [macro <ev_gtk.h>]"
		alias
			"GTK_IS_LABEL"
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

	frozen gtk_label_get_justify (a_c_struct: POINTER): INTEGER_32
		external
			"C signature (GtkLabel*): EIF_INTEGER use <ev_gtk.h>"
		end

	frozen gtk_label_set_attributes (label: POINTER; attrs: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gtk_label_set_attributes ((GtkLabel *)$label, (PangoAttrList *)$attrs);"
		end

feature -- Radio		

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

feature -- Scale

	frozen gtk_scale_new (a_orientation: NATURAL_8; a_adjustment: POINTER): POINTER
		external
			"C (GtkOrientation, GtkAdjustment*): GtkWidget* | <ev_gtk.h>"
		end


	frozen gtk_scale_set_digits (a_scale: POINTER; a_digits: INTEGER_32)
		external
			"C (GtkScale*, gint) | <ev_gtk.h>"
		end

	frozen gtk_scale_set_draw_value (a_scale: POINTER; a_draw_value: BOOLEAN)
		external
			"C (GtkScale*, gboolean) | <ev_gtk.h>"
		end

feature -- Scroll

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

feature -- Spin button		

	frozen gtk_spin_button_new (a_adjustment: POINTER; a_climb_rate: REAL_32; a_digits: INTEGER_32): POINTER
		external
			"C (GtkAdjustment*, gfloat, guint): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_spin_button_update (a_spin_button: POINTER)
		external
			"C (GtkSpinButton*) | <ev_gtk.h>"
		end

feature -- Toggle button

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

feature -- Event

	frozen gtk_get_event_widget (a_event: POINTER): POINTER
		external
			"C (GdkEvent*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_main_do_event (a_event: POINTER)
		external
			"C (GdkEvent*) | <ev_gtk.h>"
		end

	frozen gtk_propagate_event (a_widget: POINTER; a_event: POINTER)
		external
			"C (GtkWidget*, GdkEvent*) | <ev_gtk.h>"
		end

feature -- Allocation		

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

feature -- Bin

	frozen gtk_bin_get_child (a_bin: POINTER): POINTER
		external
			"C signature (GtkBin*): EIF_POINTER use <ev_gtk.h>"
		end

feature -- Notebook

	frozen gtk_notebook_get_tab_pos (a_c_struct: POINTER): INTEGER_32
		external
			"C signature (GtkNotebook*): EIF_INTEGER use <ev_gtk.h>"
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


feature -- Viewport

	frozen gtk_viewport_get_bin_window (a_c_struct: POINTER): POINTER
		external
			"C signature (GtkViewport*): EIF_POINTER use <ev_gtk.h>"
		end

	frozen gtk_viewport_new (a_hadjustment: POINTER; a_vadjustment: POINTER): POINTER
		external
			"C (GtkAdjustment*, GtkAdjustment*): GtkWidget* | <ev_gtk.h>"
		end

	frozen gtk_viewport_set_shadow_type (a_viewport: POINTER; a_type: INTEGER_32)
		external
			"C (GtkViewport*, GtkShadowType) | <ev_gtk.h>"
		end

feature -- Adjustment

	frozen gtk_adjustment_new (a_value: REAL_32; a_lower: REAL_32; a_upper: REAL_32; a_step_increment: REAL_32; a_page_increment: REAL_32; a_page_size: REAL_32): POINTER
		external
			"C (gfloat, gfloat, gfloat, gfloat, gfloat, gfloat): GtkAdjustment* | <ev_gtk.h>"
		end

	frozen gtk_adjustment_set_value (a_adjustment: POINTER; a_value: REAL_32)
		external
			"C (GtkAdjustment*, gfloat) | <ev_gtk.h>"
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

	frozen gtk_range_get_adjustment (a_editable: POINTER): POINTER
		external
			"C (GtkRange*): GtkAdjustment* | <ev_gtk.h>"
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

feature -- Requisition

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

	frozen c_gtk_requisition_struct_size: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"sizeof(GtkRequisition)"
		end

feature -- Object, Data

	frozen g_object_get_data (object: POINTER; key: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return g_object_get_data ((GObject *)$object,
                   (const gchar *)$key);
              ]"
		end

feature -- Color Helper

	rgba_struct_to_style_color_string (a_c_rgba: POINTER): STRING
		local
			r,g,b: INTEGER
			a: REAL_64
			f: FORMAT_DOUBLE
		do
			r := ({GDK}.rgba_struct_red (a_c_rgba) * {EV_COLOR}.max_8_bit).truncated_to_integer
			g := ({GDK}.rgba_struct_green (a_c_rgba) * {EV_COLOR}.max_8_bit).truncated_to_integer
			b := ({GDK}.rgba_struct_blue (a_c_rgba) * {EV_COLOR}.max_8_bit).truncated_to_integer
			a := {GDK}.rgba_struct_alpha (a_c_rgba)
			if a < 1.0 then
				create f.make (1, 7)
				Result := "rgb(" + r.out + "," + g.out + "," + b.out + "," + f.formatted (a) +")"
			else
				Result := "rgb(" + r.out + "," + g.out + "," + b.out + ")"
			end
		ensure
			instance_free: class
		end

	rgba_struct_to_color (a_c_rgba: POINTER): EV_COLOR
		do
			create Result.make_with_rgb (
					{GDK}.rgba_struct_red (a_c_rgba).truncated_to_real,
					{GDK}.rgba_struct_green (a_c_rgba).truncated_to_real,
					{GDK}.rgba_struct_blue (a_c_rgba).truncated_to_real
				)
				-- FIXME: alpha value for now as EV_COLOR does not support it.						
		ensure
			instance_free: class
		end

	rgba_string_style_color (a_style_ctx: POINTER; a_name: READABLE_STRING_8): STRING
		local
			l_gtk_c_string: EV_GTK_C_STRING
			c_rgba: POINTER
		do
			c_rgba := {GTK}.c_gdk_rgba_struct_allocate
			create l_gtk_c_string.set_with_eiffel_string (a_name)
			{GTK2}.gtk_style_context_lookup_color (a_style_ctx, l_gtk_c_string.item, c_rgba)
			Result := rgba_struct_to_style_color_string (c_rgba)
			c_rgba.memory_free
		ensure
			instance_free: class
		end

	rgba_string_default_background_color: STRING
		local
			c_rgba: POINTER
			p: POINTER
			ctx: POINTER
		do
			p := {GTK}.gtk_dialog_new
			if not p.is_default_pointer then
				ctx := 	{GTK}.gtk_widget_get_style_context (p)
				{GTK2}.gtk_style_context_get (
						ctx,
						{GTK}.gtk_state_flag_normal_enum, --{GTK}.gtk_style_context_get_state (ctx),
						{GTK2}.GTK_STYLE_PROPERTY_BACKGROUND_COLOR,
						$c_rgba
					)
				Result := rgba_struct_to_style_color_string (c_rgba)
				{GDK}.rgba_free (c_rgba)
				{GTK}.gtk_widget_destroy (p)
			else
				Result := "rgb(0,0,0)"
			end
		ensure
			instance_free: class
		end

	default_background_color: EV_COLOR
		local
			c_rgba: POINTER
			p: POINTER
			ctx: POINTER
		do
			p := {GTK}.gtk_dialog_new
			if not p.is_default_pointer then
				ctx := 	{GTK}.gtk_widget_get_style_context (p)
				{GTK2}.gtk_style_context_get (
						ctx,
						{GTK}.gtk_state_flag_normal_enum, --{GTK}.gtk_style_context_get_state (ctx),
						{GTK2}.GTK_STYLE_PROPERTY_BACKGROUND_COLOR,
						$c_rgba
					)
				Result := rgba_struct_to_color (c_rgba)
				{GDK}.rgba_free (c_rgba)
				{GTK}.gtk_widget_destroy (p)
			else
				create Result.default_create
			end
		ensure
			instance_free: class
		end

	new_gdk_rgba_string (r,g,b: REAL_64; a: REAL_64; a_reuse_color_object: POINTER): STRING
			-- New color string from `r,g,b,a`
			-- reusing the Gtk struct `a_reuse_color_object`, if it is set
			-- otherwise allocate a new struct.
		require
			valid_red:   r >= 0.0 and r <= 1.0
			valid_green: g >= 0.0 and g <= 1.0
			valid_blue:  b >= 0.0 and b <= 1.0
			valid_alpha: a >= 0.0 and a <= 1.0
		local
			color: POINTER
		do
			if a_reuse_color_object.is_default_pointer then
				color := {GTK}.c_gdk_rgba_struct_allocate
			else
				color := a_reuse_color_object
			end
			{GDK}.set_rgba_struct_red (color, r)
			{GDK}.set_rgba_struct_green (color, g)
			{GDK}.set_rgba_struct_blue (color, b)
			{GDK}.set_rgba_struct_alpha (color, a)
			create Result.make_from_c ({GDK}.gdk_rgba_to_string (color))
			if a_reuse_color_object.is_default_pointer and not color.is_default_pointer then
				color.memory_free
			end
		ensure
			instance_free: class
		end

	gnome_color_names: ITERABLE [STRING_8]
		do
			Result := <<
				"theme_fg_color",
				"theme_text_color",
				"theme_bg_color",
				"theme_base_color",
    				"theme_selected_bg_color",
    				"theme_selected_fg_color",
    				"insensitive_bg_color",
    				"insensitive_fg_color",
    				"insensitive_base_color",
    				"theme_unfocused_fg_color",
    				"theme_unfocused_text_color",
    				"theme_unfocused_bg_color",
    				"theme_unfocused_base_color",
    				"theme_unfocused_selected_bg_color",
    				"theme_unfocused_selected_fg_color",
    				"unfocused_insensitive_color",
    				"borders",
    				"unfocused_borders",
    				"warning_color",
    				"error_color",
    				"success_color"
    			>>
    	ensure
    		instance_free: class
	end


feature -- Gobject Type

	g_type_name (a_type:  POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return g_type_name ((GType)$a_type);"
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

