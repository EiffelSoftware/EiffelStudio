note
	description: "All GTK externals related to handling of CSS styles."
	date: "$Date$"
	revision: "$Revision$"

class
	GTK_CSS

feature -- GtkCsProvider

	frozen gtk_css_provider_new: POINTER
		external
			"C signature (): GtkCssProvidr * use <ev_gtk.h>"
		end

	frozen gtk_css_provider_load_from_data (css_provider, data: POINTER; length: INTEGER; error: TYPED_POINTER [POINTER]): BOOLEAN
		external
			"C signature (GtkCssProvider *, const gchar *, gssize , GError **): gboolean use <ev_gtk.h>"
		end


	frozen gtk_css_provider_load_from_path  (css_provider, path: POINTER; error: TYPED_POINTER [POINTER]): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
			   return gtk_css_provider_load_from_path ((GtkCssProvider *)$css_provider,
                                 (const gchar *)$path,
                                 (GError **)$error);
                                ]"
		end

	frozen gtk_css_provider_to_string (provider: POINTER): POINTER
		external
			"C signature (GtkCssProvider *): char * use <ev_gtk.h>"
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
