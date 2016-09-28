note
	description: "Wrappers around the gdk_cairo_ routines."
	date: "$Date$"
	revision: "$Revision$"

class
	GDK_CAIRO

feature -- Externals

	create_context (a_window: POINTER): POINTER
		external
			"C signature (GdkWindow *): cairo_t * use %"ev_gtk.h%""
		alias
			"gdk_cairo_create"
		end

	set_source_rgba (a_context, a_rgba: POINTER)
		external
			"C signature (cairo_t *, GdkRGBA *) use %"ev_gtk.h%""
		alias
			"gdk_cairo_set_source_rgba"
		end

	set_source_pixbuf (a_context, a_pixbuf: POINTER; a_pixbuf_x, a_pixbuf_y: REAL_64)
		external
			"C signature (cairo_t *, GdkPixbuf *, double, double) use %"ev_gtk.h%""
		alias
			"gdk_cairo_set_source_pixbuf"
		end

	set_source_window (a_context, a_gdkwindow: POINTER; a_x, a_y: REAL_64)
		external
			"C signature (cairo_t *, GdkWindow *, double, double) use %"ev_gtk.h%""
		alias
			"gdk_cairo_set_source_window"
		end

	region (a_context, a_region: POINTER)
		external
			"C signature (cairo_t *, const cairo_region_t *) use %"ev_gtk.h%""
		alias
			"gdk_cairo_region"
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
