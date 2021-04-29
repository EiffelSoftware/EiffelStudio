note
	description: "[
		Controls how a widget deals with extra space in a single (x or y) dimension.
		Alignment only matters if the widget receives a `too large` allocation, for example if you packed the widget with the `expand` flag 
		inside a GtkBox, then the widget might get extra space. 
		If you have for example a 16x16 icon inside a 32x32 space, the icon could be scaled and stretched, it could be centered, 
		or it could be positioned to one side of the space.
		Note that in horizontal context GTK_ALIGN_START and GTK_ALIGN_END are interpreted relative to text direction.
		GTK_ALIGN_BASELINE support for it is optional for containers and widgets, and it is only supported for vertical alignment. 
		When its not supported by a child or a container it is treated as GTK_ALIGN_FILL .
	]"
	date: "$Date$"
	revision: "$Revision$"
	eis: "name=GtkAlign", "src=https://developer.gnome.org/gtk3/stable/GtkWidget.html#GtkAlign"

class
	GTK_ALIGN

create

feature -- Externals

	gtk_align_fill: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GTK_ALIGN_FILL"
		end

	gtk_align_start: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GTK_ALIGN_START"
		end

	gtk_align_end: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GTK_ALIGN_END"
		end

	gtk_align_center: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GTK_ALIGN_CENTER"
		end

	gtk_align_baseline: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"return GTK_ALIGN_BASELINE"
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
