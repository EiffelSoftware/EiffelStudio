note
	description: "VARIANT struct."
	date: "$Date$"
	revision: "$Revision$"

class
	COM_VARIANT

inherit
	MANAGED_POINTER
		rename
			make as managed_pointer_make
		end

create
	make,
	make_from_string,
	make_from_integer_32,
	make_from_boolean

feature {NONE} -- Initialization

	make
			-- Create
		do
			managed_pointer_make (structure_size)
			ole_variant_init (item)
		end

	make_from_string (a_str: READABLE_STRING_GENERAL)
			-- Create from a string
		local
			l_bstr: COM_BSTR_STRING
		do
			make
			create l_bstr.make_from_string (a_str)
			bstr_string := l_bstr

			c_variant_set_vt (item, vt_bstr)
			c_variant_set_bstrVal (item, l_bstr.item)
		end

	make_from_integer_32 (a_integer_32: INTEGER_32)
			-- Create from a integer
		do
			make
			c_variant_set_vt (item, vt_i4)
			c_variant_set_lval (item, a_integer_32)
		end

	make_from_boolean (a_boolean: BOOLEAN)
			-- Create from a boolean
		do
			if a_boolean then
				make_from_integer_32 (1)
			else
				make_from_integer_32 (0)
			end
		end

feature -- Access

	idispatch: POINTER
			-- IDispatch from VARIANT
		do
			if item /= default_pointer then
				Result := c_variant_get_pdispval (item)
			end
		end

	string: detachable STRING_32
			-- String from VARIANT
		local
			l_s: WEL_STRING
		do
			if c_variant_vt (item) = vt_bstr then
				create l_s.make_by_pointer (c_variant_bstrVal (item))
				Result := l_s.string
			end
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size of the structure.
		external
			"C++ macro use <OleAuto.h>"
		alias
			"sizeof(VARIANT)"
		end

feature {NONE} -- Externals

	ole_variant_init (a_variant: POINTER)
			-- Init VARIANT struct
		external
			"C inline use <OleAuto.h>"
		alias
			"VariantInit ((VARIANTARG *)$a_variant)"
		end

	c_variant_get_pdispval (ptr: POINTER): POINTER
		external
			"C [struct <OleAuto.h>] (VARIANT): EIF_POINTER"
		alias
			"pdispVal"
		end

	c_variant_vt (ptr: POINTER): INTEGER
			-- (export status {NONE})
		external
			"C [struct <OleAuto.h>] (VARIANT): EIF_INTEGER"
		alias
			"vt"
		end

	c_variant_set_vt (ptr: POINTER; value: INTEGER)
		external
			"C [struct <OleAuto.h>] (VARIANT, VARTYPE)"
		alias
			"vt"
		end

	c_variant_bstrVal (ptr: POINTER): POINTER
		external
			"C [struct <OleAuto.h>] (VARIANT): EIF_POINTER"
		alias
			"bstrVal"
		end

	c_variant_set_bstrVal (ptr: POINTER; value: POINTER)
		external
			"C [struct <OleAuto.h>] (VARIANT, BSTR)"
		alias
			"bstrVal"
		end

	c_variant_set_lVal (ptr: POINTER; value: INTEGER_32)
		external
			"C [struct <OleAuto.h>] (VARIANT, LONG)"
		alias
			"lVal"
		end

	c_variant_set_intVal (ptr: POINTER; value: INTEGER_32)
		external
			"C [struct <OleAuto.h>] (VARIANT, INT)"
		alias
			"intVal"
		end

	c_variant_set_llVal (ptr: POINTER; value: INTEGER_64)
		external
			"C [struct <OleAuto.h>] (VARIANT, LONGLONG)"
		alias
			"llVal"
		end

	vt_bstr: INTEGER
		external
			"C [macro <OleAuto.h>]"
		alias
			"VT_BSTR"
		end

	vt_i4: INTEGER
		external
			"C [macro <OleAuto.h>]"
		alias
			"VT_I4"
		end

	vt_i8: INTEGER
		external
			"C [macro <OleAuto.h>]"
		alias
			"VT_I8"
		end

	vt_int: INTEGER
		external
			"C [macro <OleAuto.h>]"
		alias
			"VT_INT"
		end

	c_variant_pcVal (ptr: POINTER): POINTER
		external
			"C [struct <OleAuto.h>] (VARIANT): EIF_POINTER"
		alias
			"pcVal"
		end

	c_variant_set_pcVal (ptr: POINTER; value: POINTER)
		external
			"C [struct <OleAuto.h>] (VARIANT, CHAR*)"
		alias
			"pcVal"
		end

feature {NONE} -- Implementation

	bstr_string: detachable COM_BSTR_STRING

;note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
