note
	description: "Summary description for {GTK_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GTK_WINDOW

feature -- Access

	frozen move (a_window: POINTER; a_x, a_y: INTEGER)
		external
			"C signature (GtkWindow *, gint, gint) use <ev_gtk.h>"
		alias
			"gtk_window_move"
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
