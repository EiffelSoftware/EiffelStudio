note
	description: "Summary description for {GOBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GOBJECT

feature -- Gobject / debugging purpose

	frozen internal_g_object_ref_count (a_c_object: POINTER): NATURAL_32
			-- reference count associated with non null pointer `a_c_object`.
			-- note: this feature is mostly for debugging/logging
			-- do not rely on it for more advanced usage as it is not mentioned in Glib documentation.
		require
			not a_c_object.is_default_pointer
		external
			"C inline use <ev_gtk.h>"
		alias
			"((GObject*)$a_c_object)->ref_count"
		ensure
			instance_free: class
		end

feature -- Gobject Type

	g_type_name (a_type: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_type_name (G_TYPE_FROM_INSTANCE($a_type))"
		end

	frozen g_type_string: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"G_TYPE_STRING"
		end

	frozen g_type_boolean: INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"G_TYPE_BOOLEAN"
		end

feature -- Gobject value		

	frozen g_value_init_int (a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_INT)"
		end

	frozen g_value_init_pointer (a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_POINTER)"
		end

	frozen g_value_init_string (a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_STRING)"
		end

	frozen g_value_init_object (a_value: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_init ((GValue*) $a_value, G_TYPE_OBJECT)"
		end

	frozen g_value_set_int (a_value: POINTER; a_int: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_int ((GValue*) $a_value, (gint) $a_int)"
		end

	frozen g_value_get_int (a_value: POINTER): INTEGER_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_get_int ((GValue*) $a_value)"
		end

	frozen g_value_set_boolean (a_value: POINTER; a_boolean: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_boolean ((GValue*) $a_value, (gboolean) $a_boolean)"
		end

	frozen g_value_get_boolean (a_value: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_get_boolean ((GValue*) $a_value)"
		end

	frozen g_value_set_pointer (a_value: POINTER; a_pointer: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_pointer ((GValue*) $a_value, (gpointer) $a_pointer)"
		end

	frozen g_value_set_object (a_value: POINTER; a_pointer: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_object ((GValue*) $a_value, (gpointer) $a_pointer)"
		end

	frozen g_value_set_string (a_value: POINTER; a_string: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_set_string ((GValue*) $a_value, (gchar*) $a_string)"
		end

	frozen g_value_get_string (a_value: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_get_string ((GValue*) $a_value)"
		end

	frozen g_value_take_string (a_value: POINTER; a_string: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_value_take_string ((GValue*) $a_value, (gchar*) $a_string)"
		end

	frozen g_value_unset (a_value: POINTER)
		external
			"C signature (GValue*) use <ev_gtk.h>"
		end

feature -- Value		

	frozen g_value_pointer (arg: POINTER): POINTER
			-- Pointer to the value of a GtkArg.
		external
			"C signature (GValue*): EIF_POINTER use <ev_gtk.h>"
		alias
			"g_value_peek_pointer"
		end

	frozen g_value_int (arg: POINTER): INTEGER_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_INTEGER use <ev_gtk.h>"
		alias
			"g_value_get_int"
		end

	frozen g_value_uchar (arg: POINTER): INTEGER_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_INTEGER use <ev_gtk.h>"
		alias
			"g_value_get_uchar"
		end

	frozen g_value_enum (arg: POINTER): INTEGER_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_INTEGER use <ev_gtk.h>"
		alias
			"g_value_get_enum"
		end

	frozen g_value_flags (arg: POINTER): INTEGER_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_INTEGER use <ev_gtk.h>"
		alias
			"g_value_get_flags"
		end

	frozen g_value_uint (arg: POINTER): NATURAL_32
			-- Integer value from a GtkArg.
		external
			"C signature (GValue*): EIF_NATURAL use <ev_gtk.h>"
		alias
			"g_value_get_uint"
		end

	frozen g_value_array_i_th (args_array: POINTER; an_index: INTEGER_32): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"((GValue*)$args_array + (int)($an_index - 1))"
		end

feature -- Gobject

	frozen g_object_is_floating (obj: POINTER): BOOLEAN
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_is_floating((gpointer) $obj)"
		end

	frozen g_object_ref_sink (a_c_object: POINTER): POINTER
			-- Increase the reference count of object , and possibly remove the floating reference, if object has a floating reference.
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_ref_sink((gpointer) $a_c_object)"
		ensure
			same_object: Result = a_c_object
			instance_free: class
		end

	frozen g_object_ref (a_c_object: POINTER): POINTER
			-- Increases the reference count of object .
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_ref((gpointer) $a_c_object)"
		ensure
			same_object: Result = a_c_object
			instance_free: class
		end

	frozen g_object_unref (a_c_object: POINTER)
			-- Decreases the reference count of object . When its reference count drops to 0, the object is finalized (i.e. its memory is freed).
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_unref((gpointer) $a_c_object)"
		end

	frozen g_object_force_floating (a_c_object: POINTER)
			-- This function is intended for GObject implementations to re-enforce a floating object reference.
			-- Doing this is seldom required:
			--		all GInitiallyUnowneds are created with a floating reference
			--		which usually just needs to be sunken by calling g_object_ref_sink().
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_force_floating((GObject *) $a_c_object)"
		end

	frozen g_clear_object (a_c_object_pointer: POINTER)
			-- Clears a reference to a GObject.
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_clear_object((GObject **) $a_c_object_pointer)"
		end

	frozen g_object_run_dispose (a_c_object: POINTER)
			-- Releases all references to other objects. This can be used to break reference cycles.
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_run_dispose((GObject *) $a_c_object)"
		end

feature -- GType

	frozen sizeof_gtype: INTEGER_32
			-- Size of the `GType' C type
		external
			"C macro use <ev_gtk.h>"
		alias
			"sizeof(GType)"
		end

	frozen add_g_type_boolean (an_array: POINTER; a_pos: INTEGER_32)
			-- Add G_TYPE_BOOLEAN constant in `an_array' at `a_pos' bytes from beginning
			-- of `an_array'.
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				{
					GType type = G_TYPE_BOOLEAN;
					memcpy ((char *) $an_array + $a_pos, &type, sizeof(GType));
				}
			]"
		end

	frozen add_g_type_string (an_array: POINTER; a_pos: INTEGER_32)
			-- Add G_TYPE_STRING constant in `an_array' at `a_pos' bytes from beginning
			-- of `an_array'.
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				{
					GType type = G_TYPE_STRING;
					memcpy ((char *) $an_array + $a_pos, &type, sizeof(GType));
				}
			]"
		end

feature -- Signal

	frozen signal_list_ids (a_object: POINTER): LIST [NATURAL_32]
		local
			i, nb: INTEGER
			unb: NATURAL_32
			p: POINTER
			mp: MANAGED_POINTER
		do
			p := g_signal_list_ids (a_object, $unb)
			nb := unb.to_integer_32
			if nb > 0 and not p.is_default_pointer then
				create {ARRAYED_LIST [NATURAL_32]} Result.make (nb)
				create mp.share_from_pointer (p, nb * {MANAGED_POINTER}.natural_32_bytes)
				from
					i := 1
				until
					i > nb
				loop
					Result.extend (mp.read_natural_32 ((i - 1) * {MANAGED_POINTER}.natural_32_bytes))
					i := i + 1
				end
			else
				create {ARRAYED_LIST [NATURAL_32]} Result.make (0)
			end
		ensure
			instance_free: class
		end

	frozen g_signal_list_ids (a_object: POINTER; a_count: TYPED_POINTER [NATURAL_32]): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_signal_list_ids (G_OBJECT_TYPE($a_object), (guint *) $a_count)"
		end

	frozen signal_disconnect (a_object: POINTER; a_handler_id: INTEGER_32)
		do
			debug ("gtk_signal")
				print ("signal_disconnect (" + a_object.out + ", " + a_handler_id.out + ")%N")
			end
			c_signal_disconnect (a_object, a_handler_id)
		ensure
			instance_free: class
		end

	frozen c_signal_disconnect (a_object: POINTER; a_handler_id: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_signal_handler_disconnect ((gpointer) $a_object, (gulong) $a_handler_id)"
		end

	frozen signal_disconnect_by_data (a_c_object: POINTER; data: INTEGER_32): NATURAL_32
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_signal_handlers_disconnect_matched ((gpointer) $a_c_object, G_SIGNAL_MATCH_DATA, 0, 0, NULL, NULL, (gpointer) (rt_int_ptr) $data)"
		end

feature -- Get ...

	frozen g_object_get_pointer (a_object: POINTER; a_property: POINTER): POINTER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				EIF_POINTER v;
				g_object_get ((gpointer) $a_object, (const gchar *) $a_property, &v, NULL);
				return (EIF_POINTER) v;
			]"
		end

	frozen g_object_set_pointer (a_object: POINTER; a_property: POINTER; arg1: POINTER)
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
			"return g_object_set ((gpointer) $a_object, (gchar*) $a_property, (gchar*) $string_arg, NULL);"
		ensure
			is_class: class
		end

	frozen g_object_get_string (a_object: POINTER; a_property: POINTER; string_arg: TYPED_POINTER [POINTER])
		external
			"C inline use <ev_gtk.h>"
		alias
			"return g_object_get ((gpointer) $a_object, (gchar*) $a_property, (gchar**) $string_arg, NULL);"
		ensure
			is_class: class
		end

	frozen g_object_get_object_property (a_object: POINTER; a_property: POINTER; obj: POINTER)
		external
			"C inline use <ev_gtk.h>"
		alias
			"return g_object_get ($a_object, $a_property, $obj, NULL);"
		end

	frozen g_object_get_integer (a_object: POINTER; a_property: POINTER): INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				gint v;
				g_object_get ((gpointer) $a_object, (const gchar *) $a_property, &v, NULL);
				return (EIF_INTEGER) v;
			]"
		end

	frozen g_object_set_integer (a_object: POINTER; a_property: POINTER; int_arg: INTEGER_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (const gchar *) $a_property, $int_arg, NULL)"
		end

	frozen g_object_set_real_32 (a_object: POINTER; a_property: POINTER; real_arg: REAL_32)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, (gfloat) $real_arg, NULL)"
		end

	frozen g_object_set_boolean (a_object: POINTER; a_property: POINTER; bool_arg: BOOLEAN)
		external
			"C inline use <ev_gtk.h>"
		alias
			"g_object_set((gpointer) $a_object, (gchar*) $a_property, $bool_arg ? TRUE : FALSE, NULL)"
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
