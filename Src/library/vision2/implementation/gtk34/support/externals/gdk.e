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

feature -- GdkColor

	frozen color_struct_size: INTEGER_32
		external
			"C [macro <ev_gtk.h>]"
		alias
			"sizeof(GdkColor)"
		end

	frozen color_struct_blue (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkColor): EIF_INTEGER"
		alias
			"blue"
		end

	frozen color_struct_green (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkColor): EIF_INTEGER"
		alias
			"green"
		end

	frozen color_struct_pixel (a_c_struct: POINTER): INTEGER_32
		external
			"C [struct <ev_gtk.h>] (GdkColor): EIF_INTEGER"
		alias
			"pixel"
		end

	frozen color_struct_red (a_c_struct: POINTER): INTEGER_32
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
