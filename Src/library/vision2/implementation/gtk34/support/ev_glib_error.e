note
	description: "Error reported by GLib-based functions."

class EV_GLIB_ERROR

inherit

	DISPOSABLE

	MEMORY_STRUCTURE
		rename
			make_by_pointer as make_from_pointer
		end

create
	make_from_pointer

feature -- Measurement

	structure_size: like {MEMORY_STRUCTURE}.structure_size
		external "C inline use %"glib.h%""
		alias
			"sizeof (GError)"
		end

feature -- Access

	domain_number: NATURAL_32
			-- Error domain number.
			-- (A number, uniquely identifying a string.)
		require
			exists
		do
			Result := c_domain (item)
		end

	code: INTEGER_32
			-- Error code.
		require
			exists
		do
			Result := c_code (item)
		end

	message: STRING_32
			-- Human-readable informative error message.
		require
			exists
		local
			m: POINTER
		do
			m := c_message (item)
			if not m.is_default_pointer then
				Result := (create {EV_GTK_C_STRING}.share_from_pointer (m)).string
			end
		end

feature -- Removal

	dispose
			-- <Precursor>
		do
			if exists then
				free
			end
		end

	free
			-- Free the error object.
		require
			exists
		do
			c_free (item)
			if shared then
				internal_item := default_pointer
			else
				managed_pointer := Void
			end
		end

feature {NONE} -- Access

	c_domain (p: POINTER): NATURAL_32
			-- Error domain number associated with an error object at address `p`.
			-- (A number, uniquely identifying a string.)
		require
			not p.is_default_pointer
		external "C inline use %"glib.h%""
			alias "return ((GError *) $p) -> domain;"
		end

	c_code (p: POINTER): INTEGER_32
			-- Error code associated with an error object at address `p`.
		require
			not p.is_default_pointer
		external "C inline use %"glib.h%""
			alias "return (EIF_INTEGER_32) (((GError *) $p) -> code);"
		end

	c_message (p: POINTER): POINTER
			-- Human-readable informative error message associated with an error object at address `p`.
		require
			not p.is_default_pointer
		external "C inline use %"glib.h%""
			alias "return (EIF_POINTER) (((GError *) $p) -> message);"
		end

feature {NONE} -- Disposal

	c_free (p: POINTER)
		require
			not p.is_default_pointer
		external "C inline use %"glib.h%""
			alias "g_error_free ((GError *) $p);"
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
