note
	description: "Access to current environment configuration."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_ENVIRONMENT

feature -- Access

	writeable_pixbuf_formats: ARRAYED_LIST [STRING_32]
			-- Array of GdkPixbuf formats that Vision2 can save to on the gtk2.4.x platform
		once
			Result := pixbuf_formats (True)
			Result.compare_objects
		end

	readable_pixbuf_formats: ARRAYED_LIST [STRING_32]
			-- Array of GdkPixbuf formats that Vision2 can load to on the gtk2.4.x platform
		once
			Result := pixbuf_formats (False)
			Result.compare_objects
		end

	pixbuf_formats (a_writeable: BOOLEAN): ARRAYED_LIST [STRING_32]
			-- List of the readable formats available with current Gtk 2.0 library
		local
			formats: POINTER
			i,format_count: INTEGER
			format_name: STRING_32
			pixbuf_format: POINTER
			a_cs: EV_GTK_C_STRING
		do
			formats := {GTK2}.gdk_pixbuf_get_formats
			format_count := {GTK}.g_slist_length (formats)
			from
				i := 0
				create Result.make (0)
				create a_cs.set_with_eiffel_string ("")
			until
				i = format_count
			loop
				pixbuf_format := {GTK}.g_slist_nth_data (formats, i)
				a_cs.share_from_pointer ({GTK2}.gdk_pixbuf_format_get_name (pixbuf_format))
				format_name := a_cs.string
				if format_name.is_equal (once {STRING_32} "jpeg") then
					format_name := once {STRING_32} "jpg"
				end
				if a_writeable then
					if {GTK2}.gdk_pixbuf_format_is_writable (pixbuf_format) then
						Result.extend (format_name.as_upper)
					end
				else
					Result.extend (format_name.as_upper)
				end
				i := i + 1
			end
			{GTK}.g_slist_free (formats)
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
