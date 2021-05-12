note
	description: "Wrappers around the gdk_cairo_ routines."
	date: "$Date$"
	revision: "$Revision$"

class
	GDK_CAIRO_DEPRECATED

feature -- Externals

	create_context (a_window: POINTER): POINTER
		obsolete
			"gdk_cairo_create is deprecated: Use 'gdk_window_begin_draw_frame() and gdk_drawing_context_get_cairo_context()' instead [2021-06-01]"
		external
			"C signature (GdkWindow *): cairo_t * use %"ev_gtk.h%""
		alias
			"gdk_cairo_create"
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
