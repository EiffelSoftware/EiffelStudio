note
	description: "Wrappers around the Pango API."
	date: "$Date$"
	revision: "$Revision$"

class
	PANGO

feature -- C externals

	frozen layout_set_text (a_layout: POINTER; a_text: POINTER; a_length: INTEGER_32)
		external
			"C signature (PangoLayout*, char*, int) use <ev_gtk.h>"
		alias
			"pango_layout_set_text"
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
