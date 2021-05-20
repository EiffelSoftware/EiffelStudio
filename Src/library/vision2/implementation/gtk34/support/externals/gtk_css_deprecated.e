note
	description: "All deprecated GTK externals related to handling of CSS styles."
	date: "$Date$"
	revision: "$Revision$"

class
	GTK_CSS_DEPRECATED

feature -- GtkCsProvider

	frozen gtk_css_provider_get_default: POINTER
		obsolete
			"gtk_css_provider_get_default is deprecated: Use 'gtk_css_provider_new' [2021-06-01]"
		external
			"C signature (): GtkCssProvider * use <ev_gtk.h>"
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
