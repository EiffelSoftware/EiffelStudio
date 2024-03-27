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
