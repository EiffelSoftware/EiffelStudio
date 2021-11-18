note
	description: "[
		Represents the orientation of widgets and other objects which can be switched between horizontal and 
		vertical orientation on the fly, like GtkToolbar or GtkGesturePan
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=GtkOrientation", "src=https://developer.gnome.org/gtk3/stable/gtk3-Standard-Enumerations.html#GtkOrientation"

class
	GTK_ORIENTATION

feature -- Externals

	gtk_orientation_horizontal: NATURAL_8
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GTK_ORIENTATION_HORIZONTAL"
		end

	gtk_orientation_vertical: NATURAL_8
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GTK_ORIENTATION_VERTICAL"
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
