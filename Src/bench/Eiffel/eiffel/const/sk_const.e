indexing
	description: "Skeleton constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	warning: "When updating this class, do not forget to update the run-time counterpart%N%
			%too (eif_struct.h)"
	date: "$Date$"
	revision: "$Revision$"

class SK_CONST
	
feature {NONE}

	Sk_exp: INTEGER is 0x80000000
			-- Defined in eif_struct.h as SK_EXP

	Sk_bool: INTEGER is 0x04000000
			-- Defined in eif_struct.h as SK_BOOL

	Sk_char: INTEGER is 0x08000000
			-- Defined in eif_struct.h as SK_CHAR

	sk_uint8: INTEGER is 0x30000000
			-- Define in eif_struct.h as SK_UINT8

	sk_uint16: INTEGER is 0x34000000
			-- Define in eif_struct.h as SK_UINT16

	sk_uint32: INTEGER is 0x38000000
			-- Define in eif_struct.h as SK_UINT32

	sk_uint64: INTEGER is 0x3c000000
			-- Define in eif_struct.h as SK_UINT64

	Sk_int8: INTEGER is 0x0c000000
			-- Defined in eif_struct.h as SK_INT8

	Sk_int32: INTEGER is 0x10000000
			-- Defined in eif_struct.h as SK_INT32

	Sk_int16: INTEGER is 0x14000000
			-- Defined in eif_struct.h as SK_INT16

	Sk_real32: INTEGER is 0x18000000
			-- Defined in eif_struct.h as SK_REAL32

	Sk_wchar: INTEGER is 0x1c000000
			-- Defined in eif_struct.h as SK_WCHAR

	Sk_real64: INTEGER is 0x20000000
			-- Defined in eif_struct.h as SK_REAL64

	Sk_int64: INTEGER is 0x24000000
			-- Defined in eif_struct.h as SK_INT64

	Sk_bit: INTEGER is 0x28000000
			-- Defined in eif_struct.h as SK_BIT

	Sk_pointer: INTEGER is 0x40000000
			-- Defined in eif_struct.h as SK_POINTER

	Sk_ref: INTEGER is 0xf8000000
			-- Defined in eif_struct.h as SK_REF

	Sk_void: INTEGER is 0x00000000
			-- Defined in eif_struct.h as SK_VOID

	Sk_dtype: INTEGER is 0x0000ffff;
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
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
