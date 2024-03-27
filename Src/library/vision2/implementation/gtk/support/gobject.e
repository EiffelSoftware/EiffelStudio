note
	description: "Summary description for {GOBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GOBJECT

feature  -- References

	frozen object_ref, g_object_ref (a_c_object: POINTER)
		external
			"C signature (gpointer) use <ev_gtk.h>"
		alias
			"g_object_ref"
		ensure
			is_class: class
		end

	frozen object_unref, g_object_unref (a_c_object: POINTER)
		external
			"C signature (gpointer) use <ev_gtk.h>"
		alias
			"g_object_unref"
		ensure
			is_class: class
		end
feature -- Value

	frozen g_value_unset (a_value: POINTER)
		external
			"C signature (GValue*) use <ev_gtk.h>"
		ensure
			is_class: class
		end

	frozen g_value_init_int (a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_INT)"
		ensure
			is_class: class
		end

	frozen g_value_init_pointer (a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_POINTER)"
		ensure
			is_class: class
		end

	frozen g_value_init_string (a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_STRING)"
		ensure
			is_class: class
		end

	frozen g_value_init_object (a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_OBJECT)"
		ensure
			is_class: class
		end

	frozen g_value_set_int (a_value: POINTER; a_int: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_int ((GValue*) $a_value, (gint) $a_int)"
		ensure
			is_class: class
		end

	frozen g_value_set_boolean (a_value: POINTER; a_boolean: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_boolean ((GValue*) $a_value, (gboolean) $a_boolean)"
		ensure
			is_class: class
		end

	frozen g_value_get_boolean (a_value: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_get_boolean ((GValue*) $a_value)"
		ensure
			is_class: class
		end

	frozen g_value_set_pointer (a_value: POINTER; a_pointer: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_pointer ((GValue*) $a_value, (gpointer) $a_pointer)"
		ensure
			is_class: class
		end

	frozen g_value_set_object (a_value: POINTER; a_pointer: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_object ((GValue*) $a_value, (gpointer) $a_pointer)"
		ensure
			is_class: class
		end

	frozen g_value_set_string (a_value: POINTER; a_string: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_string ((GValue*) $a_value, (gchar*) $a_string)"
		ensure
			is_class: class
		end

	frozen g_value_get_string (a_value: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_get_string ((GValue*) $a_value)"
		ensure
			is_class: class
		end

	frozen g_value_take_string (a_value: POINTER; a_string: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_take_string ((GValue*) $a_value, (gchar*) $a_string)"
		ensure
			is_class: class
		end

	frozen g_value_array_i_th (args_array: POINTER; an_index: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"((GValue*)$args_array + (int)($an_index - 1))"
		ensure
			is_class: class
		end

	frozen g_value_pointer (arg: POINTER): POINTER
			-- Pointer to the value of a GtkArg.
		external
			"C signature (GValue*): EIF_POINTER use <ev_gtk.h>"
		alias
			"g_value_peek_pointer"
		ensure
			is_class: class
		end

	frozen g_value_int (arg: POINTER): INTEGER_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_INTEGER use <ev_gtk.h>"
		alias
			"g_value_get_int"
		ensure
			is_class: class
		end

	frozen g_value_uchar (arg: POINTER): INTEGER_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_INTEGER use <ev_gtk.h>"
		alias
			"g_value_get_uchar"
		ensure
			is_class: class
		end

	frozen g_value_enum (arg: POINTER): INTEGER_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_INTEGER use <ev_gtk.h>"
		alias
			"g_value_get_enum"
		ensure
			is_class: class
		end

	frozen gtk_value_flags (arg: POINTER): INTEGER_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_INTEGER use <ev_gtk.h>"
		alias
			"g_value_get_flags"
		ensure
			is_class: class
		end

	frozen g_value_uint (arg: POINTER): NATURAL_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_NATURAL use <ev_gtk.h>"
		alias
			"g_value_get_uint"
		ensure
			is_class: class
		end

feature -- type

	frozen g_type_boolean: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"G_TYPE_BOOLEAN"
		ensure
			is_class: class
		end

	frozen g_type_string: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"G_TYPE_STRING"
		ensure
			is_class: class
		end

feature -- Object

	frozen g_object_set_pointer (a_object: POINTER; a_property: POINTER; arg1: POINTER; arg2: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_set ((gpointer) $a_object, (gchar*) $a_property, (gpointer) $arg1, NULL)"
		ensure
			is_class: class
		end

	frozen g_object_set_string (a_object: POINTER; a_property: POINTER; string_arg: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_set ((gpointer) $a_object, (gchar*) $a_property, (gchar*) $string_arg, NULL)"
		ensure
			is_class: class
		end

	frozen g_object_get_string (a_object: POINTER; a_property: POINTER; string_arg: TYPED_POINTER [POINTER])
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_get ((gpointer) $a_object, (gchar*) $a_property, (gchar**) $string_arg, NULL)"
		ensure
			is_class: class
		end

	frozen g_object_get_integer (a_object: POINTER; a_property: POINTER; int_arg: TYPED_POINTER [INTEGER_32])
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_get ((gpointer) $a_object, (gchar*) $a_property, (gint*) $int_arg, NULL)"
		ensure
			is_class: class
		end

	frozen g_object_set_integer (a_object: POINTER; a_property: POINTER; int_arg: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, $int_arg, NULL)"
		ensure
			is_class: class
		end

	frozen g_object_set_double (a_object: POINTER; a_property: POINTER; double_arg: REAL_64)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, (gfloat) $double_arg, NULL)"
		ensure
			is_class: class
		end

	frozen g_object_set_boolean (a_object: POINTER; a_property: POINTER; bool_arg: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, (gboolean) $bool_arg, NULL)"
		ensure
			is_class: class
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
