indexing
	description: "Skeleton constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	warning: "When updating this class, do not forget to update the run-time counterpart%N%
			%too (eif_struct.h)"
	date: "$Date$"
	revision: "$Revision$"

class SK_CONST

feature -- Access

	sk_exp: INTEGER = 0x80000000
	sk_exp_string: STRING = "SK_EXP"
			-- Defined in eif_struct.h as SK_EXP

	sk_bool: INTEGER = 0x04000000
	sk_bool_string: STRING = "SK_BOOL"
			-- Defined in eif_struct.h as SK_BOOL

	sk_char: INTEGER = 0x08000000
	sk_char_string: STRING = "SK_CHAR"
			-- Defined in eif_struct.h as SK_CHAR

	sk_uint8: INTEGER = 0x30000000
	sk_uint8_string: STRING = "SK_UINT8"
			-- Define in eif_struct.h as SK_UINT8

	sk_uint16: INTEGER = 0x34000000
	sk_uint16_string: STRING = "SK_UINT16"
			-- Define in eif_struct.h as SK_UINT16

	sk_uint32: INTEGER = 0x38000000
	sk_uint32_string: STRING = "SK_UINT32"
			-- Define in eif_struct.h as SK_UINT32

	sk_uint64: INTEGER = 0x3c000000
	sk_uint64_string: STRING = "SK_UINT64"
			-- Define in eif_struct.h as SK_UINT64

	sk_int8: INTEGER = 0x0c000000
	sk_int8_string: STRING = "SK_INT8"
			-- Defined in eif_struct.h as SK_INT8

	sk_int32: INTEGER = 0x10000000
	sk_int32_string: STRING = "SK_INT32"
			-- Defined in eif_struct.h as SK_INT32

	sk_int16: INTEGER = 0x14000000
	sk_int16_string: STRING = "SK_INT16"
			-- Defined in eif_struct.h as SK_INT16

	sk_real32: INTEGER = 0x18000000
	sk_real32_string: STRING = "SK_REAL32"
			-- Defined in eif_struct.h as SK_REAL32

	sk_wchar: INTEGER = 0x1c000000
	sk_wchar_string: STRING = "SK_WCHAR"
			-- Defined in eif_struct.h as SK_WCHAR

	sk_real64: INTEGER = 0x20000000
	sk_real64_string: STRING = "SK_REAL64"
			-- Defined in eif_struct.h as SK_REAL64

	sk_int64: INTEGER = 0x24000000
	sk_int64_string: STRING = "SK_INT64"
			-- Defined in eif_struct.h as SK_INT64

	sk_bit: INTEGER = 0x28000000
	sk_bit_string: STRING = "SK_BIT"
			-- Defined in eif_struct.h as SK_BIT

	sk_pointer: INTEGER = 0x40000000
	sk_pointer_string: STRING = "SK_POINTER"
			-- Defined in eif_struct.h as SK_POINTER

	sk_ref: INTEGER = 0xf8000000
	sk_ref_string: STRING = "SK_REF"
			-- Defined in eif_struct.h as SK_REF

	sk_void: INTEGER = 0x00000000
	sk_void_string: STRING = "SK_VOID"
			-- Defined in eif_struct.h as SK_VOID

	sk_dtype: INTEGER = 0x0000ffff
	sk_dtype_string: STRING = "SK_DTYPE";
			-- Defined in eif_struct.h as SK_DTYPE

	--| -----------------------------
	--| also defined in eif_struct.h:
	--| SK_BMASK		0x07ffffff
	--| SK_SIMPLE		0x7c000000
	--| SK_HEAD			0xff000000
	--| SK_INVALID		0xffffffff
	--| SK_MASK			0x7fffffff
	--| -----------------------------

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
