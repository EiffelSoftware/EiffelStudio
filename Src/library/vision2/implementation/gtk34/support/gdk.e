note
	description: "Externals for GDK."
	date: "$Date$"
	revision: "$Revision$"

class
	GDK

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

	frozen gdk_display_supports_cursor_alpha (a_display: POINTER): BOOLEAN
		external
			"C signature (GdkDisplay*): gboolean use <ev_gtk.h>"
		end

	frozen gdk_display_supports_cursor_color (a_display: POINTER): BOOLEAN
		external
			"C signature (GdkDisplay*): gboolean use <ev_gtk.h>"
		end

feature -- GdkWindow

	frozen gdk_window_get_device_position (a_window, a_device: POINTER; a_x, a_y: TYPED_POINTER [INTEGER]; a_mask: POINTER): POINTER
		external
			"C (GdkWindow*, GdkDevice *, gint*, gint*, GdkModifierType*): GdkWindow* | <ev_gtk.h>"
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

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
