note
	description: "Externals for GDK."
	date: "$Date$"
	revision: "$Revision$"

class
	GDK

inherit
	GDK_DEPRECATED

	GDK_X11

feature -- GdkPixBuf

	gdk_is_pixbuf (obj: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"GDK_IS_PIXBUF($obj)"
		end

feature -- Gobject

	g_object_is_floating (obj: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_is_floating((gpointer) $obj)"
		end

	frozen g_object_ref_sink (a_c_object: POINTER): POINTER
			-- Increase the reference count of object , and possibly remove the floating reference, if object has a floating reference.
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_ref_sink((gpointer) $a_c_object)"
		ensure
			same_object: Result = a_c_object
			instance_free: class
		end

	frozen g_object_ref (a_c_object: POINTER): POINTER
			-- Increases the reference count of object .
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_ref((gpointer) $a_c_object)"
		ensure
			same_object: Result = a_c_object
			instance_free: class
		end

	frozen g_object_unref (a_c_object: POINTER)
			-- Decreases the reference count of object . When its reference count drops to 0, the object is finalized (i.e. its memory is freed).
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_unref((gpointer) $a_c_object)"
		end

	frozen g_object_force_floating (a_c_object: POINTER)
			-- This function is intended for GObject implementations to re-enforce a floating object reference.
			-- Doing this is seldom required:
			--		all GInitiallyUnowneds are created with a floating reference
			--		which usually just needs to be sunken by calling g_object_ref_sink().
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_force_floating((GObject *) $a_c_object)"
		end

	frozen g_clear_object (a_c_object_pointer: POINTER)
			-- Clears a reference to a GObject.
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_clear_object((GObject **) $a_c_object_pointer)"
		end

	frozen g_object_run_dispose (a_c_object: POINTER)
			-- Releases all references to other objects. This can be used to break reference cycles.
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_run_dispose((GObject *) $a_c_object)"
		end

feature -- GdkDisplay

	frozen gdk_display_get_default_cursor_size (a_display: POINTER): INTEGER_32
		external
			"C signature (GdkDisplay*): EIF_INTEGER use <ev_gtk.h>"
		end

	frozen gdk_display_get_default: POINTER
		external
			"C signature (): GdkDisplay* use <ev_gtk.h>"
		end

	frozen gdk_display_get_default_seat (a_display: POINTER): POINTER
		external
			"C signature (GdkDisplay *): GdkSeat * use <ev_gtk.h>"
		end

	frozen gdk_display_get_primary_monitor (a_display: POINTER): POINTER
		external
			"C signature (GdkDisplay*):GdkMonitor* use <ev_gtk.h>"
		end

	frozen gdk_display_get_name (a_display: POINTER): POINTER
		external
			"C signature (GdkDisplay*): gchar** use <ev_gtk.h>"
		end

	frozen gdk_display_get_default_screen (a_display: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_display_get_default_screen ((GdkDisplay*) $a_display)"
		end

	frozen gdk_monitor_get_scale_factor (a_monitor: POINTER): INTEGER_32
		note
			eis: "name=gdk_monitor_get_scale_factor", "src=https://developer.gnome.org/gdk3/stable/GdkMonitor.html#gdk-monitor-get-scale-factor"
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_monitor_get_scale_factor ((GdkMonitor*) $a_monitor)"
		end


	frozen gdk_display_get_n_monitors (a_display: POINTER): INTEGER_32
			-- Gets the number of monitors that belong to display.
			-- The returned number is valid until the next emission of the `monitor-added` or `monitor-removed` signal.
		note
			eis: "name=gdk_display_get_n_monitors", "src=https://developer.gnome.org/gdk3/stable/GdkDisplay.html#gdk-display-get-n-monitors"
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_display_get_n_monitors ((GdkDisplay*) $a_display)"
		end

	frozen gdk_display_get_monitor_at_point (a_display: POINTER; a_x, a_y: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_display_get_monitor_at_point ((GdkDisplay*) $a_display, (int) $a_x, (int) $a_y)"
		end

	frozen gdk_display_get_monitor_at_window (a_display: POINTER; a_window: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_display_get_monitor_at_window ((GdkDisplay*) $a_display, (GdkWindow*) $a_window)"
		end

	frozen gdk_display_supports_cursor_alpha (a_display: POINTER): BOOLEAN
		external
			"C signature (GdkDisplay*): gboolean use <ev_gtk.h>"
		end

	frozen gdk_display_supports_cursor_color (a_display: POINTER): BOOLEAN
		external
			"C signature (GdkDisplay*): gboolean use <ev_gtk.h>"
		end

	frozen gdk_display_flush (display: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_display_flush ((GdkDisplay *)$display);"
		end

feature -- GdkMonitor

	frozen gdk_monitor_get_geometry (a_monitor: POINTER; a_geometry: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_monitor_get_geometry ((GdkMonitor*) $a_monitor, (GdkRectangle*) $a_geometry)"
		end

	frozen gdk_monitor_get_workarea (a_monitor: POINTER; a_workarea: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_monitor_get_workarea ((GdkMonitor*) $a_monitor, (GdkRectangle*) $a_workarea)"
		end

	frozen gdk_monitor_get_height_mm (a_monitor: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_monitor_get_height_mm ((GdkMonitor*) $a_monitor);"
		end

	frozen gdk_monitor_get_width_mm (a_monitor: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_monitor_get_width_mm ((GdkMonitor*) $a_monitor);"
		end

feature -- GdkWindow

	frozen gdk_window_get_frame_extents (a_window, a_rect: POINTER)
		external
			"C signature (GdkWindow*, GdkRectangle*) use <ev_gtk.h>"
		end

	frozen gdk_window_get_update_area (a_window: POINTER): POINTER
		external
			"C signature (GdkWindow*): cairo_region_t* use <ev_gtk.h>"
		end

	frozen gdk_window_is_viewable (a_window: POINTER): BOOLEAN
		external
			"C signature (GdkWindow*): EIF_BOOLEAN use <ev_gtk.h>"
		end

	frozen gdk_window_is_visible (a_window: POINTER): BOOLEAN
		external
			"C signature (GdkWindow*): EIF_BOOLEAN use <ev_gtk.h>"
		end

	frozen gdk_window_get_position (a_window: POINTER; a_x, a_y: TYPED_POINTER [INTEGER])
		external
			"C signature (GdkWindow*, gint*, gint*) use <ev_gtk.h>"
		end

	frozen gdk_window_get_device_position (a_window, a_device: POINTER; a_x, a_y: TYPED_POINTER [INTEGER]; a_mask: POINTER): POINTER
		external
			"C (GdkWindow*, GdkDevice *, gint*, gint*, GdkModifierType*): GdkWindow* | <ev_gtk.h>"
		end

	frozen gdk_window_begin_draw_frame (a_window, a_region: POINTER): POINTER
			-- Pointer on a GdkDrawingContext.
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_window_begin_draw_frame ((GdkWindow*) $a_window, (const cairo_region_t *) $a_region);"
		end

	frozen gdk_window_end_draw_frame (a_window, a_context: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_window_end_draw_frame ((GdkWindow*) $a_window, (GdkDrawingContext *) $a_context);"
		end

	frozen gdk_window_process_all_updates
		-- FIXME JV
		note
			eis: "name:gdk_window_process_all_updates", "src=https://developer.gnome.org/gdk3/stable/gdk3-Windows.html#gdk-window-process-all-updates"
		obsolete
			"gdk_window_process_all_updates has been deprecated since version 3.22 and should not be used in newly-written code. [2021-06-01]"
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_window_process_all_updates();"
		end

	frozen gdk_window_get_visible_region(a_window: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_window_get_visible_region ((GdkWindow *) $a_window);"
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

	frozen gdk_window_create_similar_surface (window: POINTER; content, width, height: INTEGER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return gdk_window_create_similar_surface ((GdkWindow *)$window,
                                   (cairo_content_t)$content,
                                   (int)$width,
                                   (int)$height);
              ]"
		end

	frozen gdk_window_create_similar_image_surface (window: POINTER; format, width, height, scale: INTEGER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return gdk_window_create_similar_image_surface ((GdkWindow *)$window,
                                   (cairo_format_t)$format,
                                   (int)$width,
                                   (int)$height,
                                   (int)$scale);
              ]"
		end

	gdk_window_get_width (window: POINTER): INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_window_get_width ((GdkWindow *)$window);"
		end

	gdk_window_get_height (window: POINTER): INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_window_get_height ((GdkWindow *)$window);"
		end

	frozen gdk_window_invalidate_rect (a_window, a_rectangle: POINTER; invalidate_children: BOOLEAN)
		external
			"C signature (GdkWindow*, GdkRectangle*, gboolean) use <ev_gtk.h>"
		end

	frozen gdk_window_set_modal_hint (a_window: POINTER; a_hint: BOOLEAN)
		external
			"C signature (GdkWindow*, gboolean) use <ev_gtk.h>"
		end

	frozen gdk_window_peek_children (a_window: POINTER): POINTER
		external
			"C signature (GdkWindow*): GList use <ev_gtk.h>"
		end

	frozen gdk_window_process_updates (a_window: POINTER; process_children: BOOLEAN)
			-- https://gitlab.gnome.org/GNOME/gtk/-/issues/2792
			-- FIXME JV
		note
			eis: "name=gdk_window_process_updates", "src=https://developer.gnome.org/gdk3/stable/gdk3-Windows.html#gdk-window-process-updates"
		obsolete
			"gdk_window_process_updates has been deprecated since version 3.22 and should not be used in newly-written code. [2021-06-01]"
		external
			"C signature (GdkWindow*, gboolean) use <ev_gtk.h>"
		end

	frozen gdk_window_freeze_updates (a_window: POINTER)
		external
			"C signature (GdkWindow*) use <ev_gtk.h>"
		end

	frozen gdk_window_thaw_updates (a_window: POINTER)
		external
			"C signature (GdkWindow*) use <ev_gtk.h>"
		end


	frozen gdk_window_get_clip_region  (a_window: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_window_get_clip_region ((GdkWindow *)$a_window);"
		end

feature -- GdkDrawing		

	frozen gdk_drawing_context_is_valid (a_context: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_drawing_context_is_valid ((GdkDrawingContext *) $a_context);"
		end

	frozen gdk_drawing_context_get_cairo_context (a_context: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_drawing_context_get_cairo_context ((GdkDrawingContext *) $a_context);"
		end

feature -- GdkSeat

	frozen gdk_seat_get_pointer (a_seat: POINTER): POINTER
		external
			"C signature (GdkSeat *): GdkDevice * use <ev_gtk.h>"
		end

	frozen gdk_seat_grab (seat, window: POINTER; capabilities: INTEGER_32; owner_events: BOOLEAN; cursor, event, func, data: POINTER): INTEGER_32
		external
			"C signature (GdkSeat *, GdkWindow *, GdkSeatCapabilities, gboolean, GdkCursor *, const GdkEvent *, GdkSeatGrabPrepareFunc, gpointer): GdkGrabStatus use <ev_gtk.h>"
		end

	frozen gdk_seat_ungrab (seat: POINTER)
		external
			"C signature (GdkSeat *) use <ev_gtk.h>"
		end

feature -- GdkDevice

	frozen gdk_device_get_position (a_device: POINTER; a_screen: TYPED_POINTER [POINTER]; a_win_x, a_win_y: TYPED_POINTER [INTEGER_32])
		external
			"C signature (GdkDevice *, GdkScreen**, gint*, gint*) use <ev_gtk.h>"
		end

	frozen gdk_device_get_window_at_position (a_device: POINTER; a_win_x, a_win_y: TYPED_POINTER [INTEGER]): POINTER
		external
			"C signature (GdkDevice *,gint *, gint *): GdkWindow * use <ev_gtk.h>"
		end

feature -- GdkVisual

	frozen gdk_visual_get_depth (a_visual: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_visual_get_depth ((GdkVisual*) $a_visual)"
		end

feature -- GdkEvent

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

	frozen set_gdk_event_any_struct_window (a_c_struct: POINTER; a_window: POINTER)
		external
			"C [struct <ev_gtk.h>] (GdkEventAny, GdkWindow*)"
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

	frozen gdk_event_crossing_struct_x (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventCrossing): EIF_DOUBLE"
		alias
			"x"
		end

	frozen gdk_event_crossing_struct_y (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventCrossing): EIF_DOUBLE"
		alias
			"y"
		end

	frozen gdk_event_crossing_struct_x_root (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventCrossing): EIF_DOUBLE"
		alias
			"x_root"
		end

	frozen gdk_event_crossing_struct_y_root (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkEventCrossing): EIF_DOUBLE"
		alias
			"y_root"
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


feature -- Scroll

	frozen gdk_event_scroll_struct_scroll_direction (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkEventScroll): EIF_INTEGER"
		alias
			"direction"
		end

feature -- GdkColor

	frozen color_struct_size: INTEGER_32
		--obsolete "Use GdkRGBA [2021-06-01]"
		--but is still part of GtkTextAppearance
		external
			"C [macro <ev_gtk.h>]"
		alias
			"sizeof(GdkColor)"
		end

	frozen color_struct_blue (a_c_struct: POINTER): INTEGER_32
		--obsolete "Use GdkRGBA [2021-06-01]"
		external
			"C [struct <ev_gtk.h>] (GdkColor): EIF_INTEGER"
		alias
			"blue"
		end

	frozen color_struct_green (a_c_struct: POINTER): INTEGER_32
		--obsolete "Use GdkRGBA [2021-06-01]"
		external
			"C [struct <ev_gtk.h>] (GdkColor): EIF_INTEGER"
		alias
			"green"
		end

	frozen color_struct_pixel (a_c_struct: POINTER): INTEGER_32
		--obsolete "Use GdkRGBA [2021-06-01]"
		external
			"C [struct <ev_gtk.h>] (GdkColor): EIF_INTEGER"
		alias
			"pixel"
		end

	frozen color_struct_red (a_c_struct: POINTER): INTEGER_32
		--obsolete "Use GdkRGBA [2021-06-01]"
		external
			"C [struct <ev_gtk.h>] (GdkColor): EIF_INTEGER"
		alias
			"red"
		end

feature -- GdkRGBA

	frozen c_gdk_rgba_struct_allocate: POINTER
		external
			"C [macro <stdlib.h>]"
		alias
			"calloc (sizeof(GdkRGBA), 1)"
		end

	frozen rgba_free (a_rgba_struct: POINTER)
		external
			"C signature (GdkRGBA*) use <ev_gtk.h>"
		alias
			"gdk_rgba_free"
		end

	frozen rgba_equal (a_rgba_struct, a_rgba_struct2: POINTER): BOOLEAN
		external
			"C signature (GdkRGBA*,GdkRGBA*): gboolean use <ev_gtk.h>"
		alias
			"gdk_rgba_equal"
		end

	frozen set_rgba_struct_with_rgb24 (a_rgba_struct: POINTER; a_rgb24: INTEGER_32)
			-- Set `a_rgba_struct' with `a_rgb24' and alpha of 1.0.
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				GdkRGBA *rgba = (GdkRGBA *) $a_rgba_struct;
				rgba->blue = ($a_rgb24 & 0xFF) / 255.0;
				rgba->green = (($a_rgb24 >> 8) & 0xFF) / 255.0;
				rgba->red = (($a_rgb24 >> 16) & 0xFF) / 255.0;
				rgba->alpha = 1.0;
			]"
		end

	frozen set_rgba_struct_with_bgr24 (a_rgba_struct: POINTER; a_bgr24: INTEGER_32)
			-- Set `a_rgba_struct' with `a_bgr24' and alpha of 1.0.
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				GdkRGBA *rgba = (GdkRGBA *) $a_rgba_struct;
				rgba->red = ($a_bgr24 & 0xFF) / 255.0;
				rgba->green = (($a_bgr24 >> 8) & 0xFF) / 255.0;
				rgba->blue = (($a_bgr24 >> 16) & 0xFF) / 255.0;
				rgba->alpha = 1.0;
			]"
		end

	frozen set_rgba_struct_with_8_bit_rgb (a_rgba_struct: POINTER; r, g, b: INTEGER_32)
			-- Set `a_rgba_struct' with red `r', green `g' and blue `b' and alpha of 1.0.
		require
			r >= 0 and r <= 255
			g >= 0 and g <= 255
			b >= 0 and b <= 255
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				GdkRGBA *rgba = (GdkRGBA *) $a_rgba_struct;
				rgba->red = $r / 255.0;
				rgba->green = $g / 255.0;
				rgba->blue = $b / 255.0;
				rgba->alpha = 1.0;
			]"
		end

	frozen set_rgba_struct_with_16_bit_rgb (a_rgba_struct: POINTER; r, g, b: INTEGER_32)
			-- Set `a_rgba_struct' with red `r', green `g' and blue `b' and alpha of 1.0.
		require
			r >= 0 and r <= 65535
			g >= 0 and g <= 65535
			b >= 0 and b <= 65535
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				GdkRGBA *rgba = (GdkRGBA *) $a_rgba_struct;
				rgba->red = $r / 65535.0;
				rgba->green = $g / 65535.0;
				rgba->blue = $b / 65535.0;
				rgba->alpha = 1.0;
			]"
		end

	frozen set_rgba_struct_with_rgba (a_rgba_struct: POINTER; r, g, b, a: REAL_64)
			-- Set `a_rgba_struct' with red `r', green `g' and blue `b' and alpha of 1.0.
		require
			r >= 0.0 and r <= 1.0
			g >= 0.0 and g <= 1.0
			b >= 0.0 and b <= 1.0
			a >= 0.0 and a <= 1.0
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				GdkRGBA *rgba = (GdkRGBA *) $a_rgba_struct;
				rgba->red = $r;
				rgba->green = $g;
				rgba->blue = $b;
				rgba->alpha = $a;
			]"
		ensure
			instance_free: class
		end

	frozen set_rgba_struct_red (a_c_struct: POINTER; a_red: REAL_64)
		require
			a_red >= 0.0 and a_red <= 1.0
		external
			"C [struct <ev_gtk.h>] (GdkRGBA, gdouble)"
		alias
			"red"
		ensure
			instance_free: class
		end

	frozen set_rgba_struct_green (a_c_struct: POINTER; a_green: REAL_64)
		require
			a_green >= 0.0 and a_green <= 1.0
		external
			"C [struct <ev_gtk.h>] (GdkRGBA, gdouble)"
		alias
			"green"
		ensure
			instance_free: class
		end

	frozen set_rgba_struct_blue (a_c_struct: POINTER; a_blue: REAL_64)
		require
			a_blue >= 0.0 and a_blue <= 1.0
		external
			"C [struct <ev_gtk.h>] (GdkRGBA, gdouble)"
		alias
			"blue"
		ensure
			instance_free: class
		end

	frozen set_rgba_struct_alpha (a_c_struct: POINTER; a_alpha: REAL_64)
		require
			a_alpha >= 0.0 and a_alpha <= 1.0
		external
			"C [struct <ev_gtk.h>] (GdkRGBA, gdouble)"
		alias
			"alpha"
		ensure
			instance_free: class
		end

	frozen rgba_struct_red (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkRGBA): gdouble"
		alias
			"red"
		ensure
			Result >= 0.0 and Result <= 1.0
		end

	frozen rgba_struct_green (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkRGBA): gdouble"
		alias
			"green"
		ensure
			Result >= 0.0 and Result <= 1.0
		end

	frozen rgba_struct_blue (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkRGBA): gdouble"
		alias
			"blue"
		ensure
			Result >= 0.0 and Result <= 1.0
		end

	frozen rgba_struct_alpha (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkRGBA): gdouble"
		alias
			"alpha"
		ensure
			Result >= 0.0 and Result <= 1.0
		end

	frozen gdk_rgba_to_string (a_rgba: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_rgba_to_string ((const GdkRGBA *)$a_rgba);"
		end

	frozen rgba_struct_size: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"sizeof(GdkRGBA)"
		end

	frozen gdk_colorspace_rgb_enum: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GDK_COLORSPACE_RGB;"
		end

feature -- GType

	frozen sizeof_gtype: INTEGER_32
			-- Size of the `GType' C type
		external
			"C macro use <ev_gtk.h>"
		alias
			"sizeof(GType)"
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
		end

feature -- GdkPixbuf

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
		end

	frozen gdk_pixbuf_scale_simple (a_gdkpixbuf: POINTER; a_width, a_height, a_interp_mode: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_pixbuf_scale_simple ((GdkPixbuf*) $a_gdkpixbuf, (int) $a_width, (int) $a_height, (int) $a_interp_mode)"
		end

	frozen gdk_pixbuf_scale (src, dest: POINTER; dest_x, dest_y, dest_width, dest_height: INTEGER_32; offset_x, offset_y, scale_x, scale_y: REAL_64; interp_type: INTEGER_32)
		external
			"C signature (GdkPixbuf*, GdkPixbuf*, int, int, int, int, double, double, double, double, GdkInterpType) use <ev_gtk.h>"
		end


	frozen gdk_pixbuf_composite (src, dest: POINTER; dest_x, dest_y, dest_width, dest_height: INTEGER_32; offset_x, offset_y, scale_x, scale_y: REAL_64; interp_type, overall_alpha: INTEGER_32)
		external
			"C signature (GdkPixbuf*, GdkPixbuf*, int, int, int, int, double, double, double, double, GdkInterpType, int) use <ev_gtk.h>"
		end

	frozen gdk_pixbuf_copy_area (src: POINTER; src_x, src_y, a_width, a_height: INTEGER_32; dest: POINTER; dest_x, dest_y: INTEGER_32)
		external
			"C signature (GdkPixbuf*, int, int, int, int, GdkPixbuf*, int, int) use <ev_gtk.h>"
		end

	frozen gdk_pixbuf_get_formats: POINTER
		external
			"C signature (): GSList* use <ev_gtk.h>"
		end

	frozen gdk_pixbuf_get_has_alpha (a_pixbuf: POINTER): BOOLEAN
		external
			"C signature (GdkPixbuf*): gboolean use <ev_gtk.h>"
		end

	frozen gdk_pixbuf_format_is_writable (a_pixbuf_format: POINTER): BOOLEAN
		external
			"C signature (GdkPixbufFormat*): gboolean use <ev_gtk.h>"
		end

	frozen gdk_pixbuf_format_get_name (a_pixbuf_format: POINTER): POINTER
		external
			"C signature (GdkPixbufFormat*): gchar* use <ev_gtk.h>"
		end

	frozen gdk_pixbuf_save (a_pixbuf, a_file_handle, a_filetype: POINTER; a_error: TYPED_POINTER [POINTER])
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_pixbuf_save ((GdkPixbuf*) $a_pixbuf, (char*) $a_file_handle, (char*) $a_filetype, (GError**) $a_error, NULL)"
		end


	frozen gdk_pixbuf_get_from_surface (a_surface: POINTER; a_x, a_y, a_width, a_height: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_pixbuf_get_from_surface ((cairo_surface_t *) $a_surface, (gint) $a_x, (gint) $a_y, (gint) $a_width, (gint) $a_height);"
		end

	frozen gdk_pixbuf_get_from_window (a_window: POINTER; a_src_x, a_src_y, a_width, a_height: INTEGER): POINTER
			-- Returns a GdkPixbuf*
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_pixbuf_get_from_window ((GdkWindow *) $a_window, (gint) $a_src_x, (gint) $a_src_y, (gint) $a_width, (gint) $a_height);"
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

	frozen gdk_pixbuf_add_alpha (a_pixbuf: POINTER; substitute_color: BOOLEAN; r, g, b: NATURAL_8): POINTER
		external
			"C signature (GdkPixbuf*, gboolean, guchar, guchar, guchar): GdkPixbuf* use <ev_gtk.h>"
		end

feature -- GdkScreen

	frozen gdk_screen_get_resolution (a_screen: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return gdk_screen_get_resolution ((GdkScreen*)$a_screen);
			]"
		end

	frozen gdk_screen_is_composited (a_screen: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return gdk_screen_is_composited ((GdkScreen*)$a_screen);
			]"
		end

	frozen gdk_screen_get_system_visual (a_screen: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_screen_get_system_visual ((GdkScreen*) $a_screen)"
		end

	frozen gdk_screen_get_rgba_visual (a_screen: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return gdk_screen_get_rgba_visual ((GdkScreen*)$a_screen);
			]"
		end

	frozen gdk_screen_list_visuals (a_screen: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return gdk_screen_list_visuals ((GdkScreen*)$a_screen);
			]"
		end

	frozen gdk_screen_get_default: POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_screen_get_default()"
		end

	frozen gdk_set_show_events (a_show_events: BOOLEAN)
		external
			"C (gboolean) | <ev_gtk.h>"
		end

	frozen gdk_screen_get_root_window (a_screen: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_screen_get_root_window ((GdkScreen *)$a_screen);;"
		end

	frozen	gdk_get_default_root_window: POINTER
			-- Obtains the root window (parent all other windows are inside) for the default display and screen.
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_get_default_root_window();"
		end

	frozen gdk_window_destroy (a_window: POINTER)
		external "C inline use <ev_gtk.h>"
		alias
			"gdk_window_destroy ((GdkWindow *)$a_window);"
		end

feature -- Geometry		

	frozen c_gdk_geometry_struct_allocate: POINTER
		external
			"C [macro <stdlib.h>]"
		alias
			"calloc (sizeof(GdkGeometry), 1)"
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

feature -- Point

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

feature -- Rectangle

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

	frozen c_gdk_rectangle_struct_allocate: POINTER
		external
			"C [macro <stdlib.h>]"
		alias
			"calloc (sizeof(GdkRectangle), 1)"
		end

	frozen c_gdk_rectangle_struct_size: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"sizeof(GdkRectangle)"
		end


feature -- Selection, Drag, Drop

	frozen gdk_cursor_new_for_display (a_display: POINTER; a_cursor_type: INTEGER_32): POINTER
		external
			"C (GdkDisplay *, GdkCursorType): GdkCursor* | <ev_gtk.h>"
		end

	frozen gdk_cursor_new_from_pixbuf (a_display, a_pixbuf: POINTER; a_x, a_y: INTEGER_32): POINTER
		external
			"C signature (GdkDisplay*, GdkPixbuf*, gint, gint): GdkCursor* use <ev_gtk.h>"
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

feature -- Beep		

	frozen gdk_display_beep (display: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_display_beep ((GdkDisplay *)$display)"
		end

feature -- Atom		

	frozen gdk_atom_intern (a_atom_name: POINTER; a_only_if_exists: INTEGER_32): POINTER
		external
			"C (gchar*, gint): GdkAtom | <ev_gtk.h>"
		end

	frozen gdk_atom_name (a_atom: POINTER): POINTER
		external
			"C (GdkAtom): gchar* | <ev_gtk.h>"
		end

feature -- Keyval		

	frozen gdk_keyval_to_unicode (a_keyval: NATURAL_32): NATURAL_32
		external
			"C (guint): guint | <ev_gtk.h>"
		end

	frozen gdk_keyval_from_name (a_keyval_name: POINTER): NATURAL_32
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

feature -- MASK, enum	

	frozen GDK_ALL_EVENTS_MASK_ENUM: NATURAL_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_ALL_EVENTS_MASK"
		ensure
			is_class: class
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

	frozen gdk_window_state_withdrawn_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_WINDOW_STATE_WITHDRAWN"
		end

	frozen gdk_window_state_iconified_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_WINDOW_STATE_ICONIFIED"
		end

	frozen gdk_window_state_maximized_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_WINDOW_STATE_MAXIMIZED"
		end

	frozen gdk_window_state_sticky_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_WINDOW_STATE_STICKY"
		end

	frozen gdk_window_state_fullscreen_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_WINDOW_STATE_FULLSCREEN"
		end

	frozen gdk_window_state_above_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_WINDOW_STATE_ABOVE"
		end

	frozen gdk_window_state_below_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_WINDOW_STATE_BELOW"
		end

	frozen gdk_scroll_up_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_SCROLL_UP"
		end

	frozen gdk_scroll_down_enum: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_SCROLL_DOWN"
		end

	frozen gdk_type_pixbuf: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"GDK_TYPE_PIXBUF"
		end

	frozen gdk_interp_bilinear: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_INTERP_BILINEAR"
		end

	frozen gdk_interp_hyper: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_INTERP_HYPER"
		end

	frozen gdk_interp_nearest: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_INTERP_NEAREST"
		end

	frozen gdk_interp_tiles: INTEGER_32
		external
			"C macro use <ev_gtk.h>"
		alias
			"GDK_INTERP_TILES"
		end

feature -- Window

	gdk_window_show (window: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gdk_window_show ((GdkWindow *)$window);
			]"
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
