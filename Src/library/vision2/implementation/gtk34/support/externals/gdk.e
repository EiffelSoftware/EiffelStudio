note
	description: "Externals for GDK."
	date: "$Date$"
	revision: "$Revision$"

class
	GDK

feature -- GdkPixBuf

	gdk_is_pixbuf (obj: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"GDK_IS_PIXBUF($obj)"
		end

feature -- Gobject

	g_object_unref (object: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_unref($object)"
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


	frozen gdk_window_get_visible_region(a_window: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_window_get_visible_region ((GdkWindow *) $a_window);"
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

feature -- GdkSeat

	frozen gdk_seat_get_pointer (a_seat: POINTER): POINTER
		external
			"C signature (GdkSeat *): GdkDevice * use <ev_gtk.h>"
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

	frozen set_rgba_struct_blue (a_c_struct: POINTER; a_blue: REAL_64)
		external
			"C [struct <ev_gtk.h>] (GdkRGBA, gdouble)"
		alias
			"blue"
		end

	frozen set_rgba_struct_green (a_c_struct: POINTER; a_green: REAL_64)
		external
			"C [struct <ev_gtk.h>] (GdkRGBA, gdouble)"
		alias
			"green"
		end

	frozen set_rgba_struct_alpha (a_c_struct: POINTER; a_alpha: REAL_64)
		external
			"C [struct <ev_gtk.h>] (GdkRGBA, gdouble)"
		alias
			"alpha"
		end

	frozen set_rgba_struct_red (a_c_struct: POINTER; a_red: REAL_64)
		external
			"C [struct <ev_gtk.h>] (GdkRGBA, gdouble)"
		alias
			"red"
		end

	frozen rgba_struct_blue (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkRGBA): gdouble"
		alias
			"blue"
		end

	frozen rgba_struct_green (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkRGBA): gdouble"
		alias
			"green"
		end

	frozen rgba_struct_red (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkRGBA): gdouble"
		alias
			"red"
		end

	frozen rgba_struct_alpha (a_c_struct: POINTER): REAL_64
		external
			"C [struct <ev_gtk.h>] (GdkRGBA): gdouble"
		alias
			"red"
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



feature -- GdkPixbuf

	frozen gdk_pixbuf_get_from_surface (a_surface: POINTER; a_x, a_y, a_width, a_height: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_pixbuf_get_from_surface ((cairo_surface_t *) $a_surface, (gint) $a_x, (gint) $a_y, (gint) $a_width, (gint) $a_height);"
		end


feature -- GdkScreen

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

	frozen gdk_display_get_screen (a_display: POINTER; a_screen_num: INTEGER): POINTER
		obsolete
			"gdk_display_get_screen is deprecated [2021-06-01]"
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_display_get_screen ((GdkDisplay *)$a_display, (gint)$a_screen_num);"
		end

	frozen gdk_screen_get_root_window (a_screen: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_screen_get_root_window ((GdkScreen *)$a_screen);;"
		end
		
feature -- XWindows

	frozen gdk_x11_display_error_trap_pop (display: POINTER): INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return gdk_x11_display_error_trap_pop ((GdkDisplay *)$display);
			]"
		end

	frozen gdk_x11_display_error_trap_push (display: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gdk_x11_display_error_trap_push ((GdkDisplay *)$display);
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
