note
	description: "Summary description for {GLIB}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GLIB

feature -- Debugging purpose

	printf (s: STRING_8)
			-- Use "printf" C function to output `s` to the console.
			-- Note: should be used only for debugging purpose and removed soon.
		local
			l_area: like {STRING_8}.area
		do
			l_area := s.area
			c_printf ($l_area)
		ensure
			instance_free: class
		end

	c_printf (p: POINTER)
		external
			"C inline"
		alias
			"printf((char*) $p)"
		ensure
			instance_free: class
		end

feature -- Memory

	frozen g_free (a_mem: POINTER)
		external
			"C (gpointer) | <ev_gtk.h>"
		end

	frozen g_malloc (a_size: INTEGER_32): POINTER
		external
			"C (gulong): gpointer | <ev_gtk.h>"
		end

	frozen g_realloc (a_mem: POINTER; a_size: INTEGER_32): POINTER
		external
			"C (gpointer, gulong): gpointer | <ev_gtk.h>"
		end

feature -- List

	frozen g_list_append (a_list: POINTER; a_data: POINTER): POINTER
		external
			"C (GList*, gpointer): GList* | <ev_gtk.h>"
		end

	frozen g_list_free (a_list: POINTER)
		external
			"C (GList*) | <ev_gtk.h>"
		end

	frozen g_list_index (a_list: POINTER; a_data: POINTER): INTEGER_32
		external
			"C (GList*, gpointer): gint | <ev_gtk.h>"
		end

	frozen g_list_insert (a_list: POINTER; a_data: POINTER; a_position: INTEGER_32): POINTER
		external
			"C (GList*, gpointer, gint): GList* | <ev_gtk.h>"
		end

	frozen g_list_length (a_list: POINTER): INTEGER_32
		external
			"C (GList*): guint | <ev_gtk.h>"
		end

	frozen g_list_nth (a_list: POINTER; a_n: INTEGER_32): POINTER
		external
			"C (GList*, guint): GList* | <ev_gtk.h>"
		end

	frozen g_list_nth_data (a_list: POINTER; a_n: INTEGER_32): POINTER
		external
			"C (GList*, guint): gpointer | <ev_gtk.h>"
		end

	frozen g_list_remove (a_list: POINTER; a_data: POINTER): POINTER
		external
			"C (GList*, gpointer): GList* | <ev_gtk.h>"
		end

	frozen glist_struct_data (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GList): EIF_POINTER"
		alias
			"data"
		end

	frozen glist_struct_next (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GList): EIF_POINTER"
		alias
			"next"
		end

	frozen glist_struct_prev (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GList): EIF_POINTER"
		alias
			"prev"
		end

feature -- SList

	frozen g_slist_free (a_list: POINTER)
		external
			"C (GSList*) | <ev_gtk.h>"
		end

	frozen g_slist_index (a_list: POINTER; a_data: POINTER): INTEGER_32
		external
			"C (GSList*, gpointer): gint | <ev_gtk.h>"
		end

	frozen g_slist_length (a_list: POINTER): INTEGER_32
		external
			"C (GSList*): guint | <ev_gtk.h>"
		end

	frozen g_slist_nth_data (a_list: POINTER; a_n: INTEGER_32): POINTER
		external
			"C (GSList*, guint): gpointer | <ev_gtk.h>"
		end

	frozen gslist_struct_data (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GSList): EIF_POINTER"
		alias
			"data"
		end

	frozen gslist_struct_next (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GSList): EIF_POINTER"
		alias
			"next"
		end


note
	copyright: "Copyright (c) 1984-2024, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
