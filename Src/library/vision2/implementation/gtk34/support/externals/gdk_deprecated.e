note
	description: "Externals for GDK."
	date: "$Date$"
	revision: "$Revision$"

class
	GDK_DEPRECATED

feature -- Window

	frozen gdk_window_set_debug_updates (a_setting: BOOLEAN)
		obsolete
			"gdk_window_set_debug_updates is deprecated [2021-06-01]"
		external
			"C signature (gboolean) use <ev_gtk.h>"
		end

feature -- Visual

	frozen gdk_visual_get_best_depth: INTEGER
		obsolete
			"gdk_visual_get_best_depth is deprecated [2021-06-01]"
		external
			"C signature (): EIF_INTEGER use <ev_gtk.h>"
		end

feature -- Display

	frozen gdk_flush
		obsolete
			"gdk_flush is deprecated: Use 'gdk_display_flush instead [2021-06-01]"
		external
			"C inline use <ev_gtk.h>"
		alias
			"gdk_flush ();"
		end

	frozen gdk_display_get_screen (a_display: POINTER; a_screen_num: INTEGER): POINTER
		obsolete
			"gdk_display_get_screen is deprecated [2021-06-01]"
		external
			"C inline use <ev_gtk.h>"
		alias
			"return gdk_display_get_screen ((GdkDisplay *)$a_display, (gint)$a_screen_num);"
		end

	frozen gdk_screen_get_monitor_at_point (a_screen: POINTER; a_x, a_y: INTEGER_32): INTEGER_32
		obsolete
			"gdk_screen_get_monitor_at_point is deprecated [2021-06-01]"
		external
			"C signature (GdkScreen*, gint, gint): gint use <ev_gtk.h>"
		end

feature -- Screen

	frozen gdk_screen_get_width_mm (a_screen: POINTER): INTEGER_32
		obsolete
			"gdk_screen_get_width_mm is deprecated [2021-06-01]"
		external
			"C signature (GdkScreen*): gint use <ev_gtk.h>"
		end

	frozen gdk_screen_get_height_mm (a_screen: POINTER): INTEGER_32
		obsolete
			"gdk_screen_get_height_mm is deprecated [2021-06-01]"
		external
			"C signature (GdkScreen*): gint use <ev_gtk.h>"
		end

	frozen gdk_screen_get_n_monitors (a_screen: POINTER): INTEGER_32
		obsolete
			"gdk_screen_get_n_monitors is deprecated: Use 'gdk_display_get_n_monitors' instead [2021-06-01]"
		external
			"C signature (GdkScreen*): gint use <ev_gtk.h>"
		end

	frozen gdk_screen_get_monitor_geometry (a_screen: POINTER; a_monitor_number: INTEGER_32; a_rect: POINTER)
		obsolete
			"gdk_screen_get_monitor_geometry is deprecated: Use 'gdk_monitor_get_geometry' instead [2021-06-01]"
		external
			"C signature (GdkScreen*, gint, GdkRectangle*) use <ev_gtk.h>"
		end

	frozen gdk_screen_get_primary_monitor (a_screen: POINTER): INTEGER_32
		obsolete
			"gdk_screen_get_primary_monitor is deprecated: Use 'gdk_display_get_primary_monitor' instead [2021-06-01]"
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				return gdk_screen_get_primary_monitor ((GdkScreen*)$a_screen);
			]"
		end

	frozen gdk_screen_get_monitor_at_window (a_screen: POINTER; a_window: POINTER): INTEGER_32
		obsolete
			"gdk_screen_get_monitor_at_window is deprecated: Use 'gdk_display_get_monitor_at_window' instead [2021-06-01]"
		external
			"C signature (GdkScreen*, GdkWindow*): gint use <ev_gtk.h>"
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

feature -- Query

	frozen gdk_query_depths (a_depths, a_count: POINTER)
		obsolete
			"gdk_query_depths is deprecated [2021-06-01]"
		external
			"C signature (gint**, gint*) use <ev_gtk.h>"
		end

feature -- RGBA

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

feature -- Cursor		

	frozen gdk_cursor_unref (a_cursor: POINTER)
		obsolete
			"gdk_cursor_unref is deprecated: Use 'g_object_unref' instead [2021-06-01]"
		external
			"C signature (GdkCursor *) use <ev_gtk.h>"
		end

feature -- Beep		

	frozen gdk_beep
		obsolete
			"gdk_beep is deprecated: Use 'gdk_display_beep' instead [2021-06-01]"
		external
			"C () | <ev_gtk.h>"
		end

feature -- Error trap

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
