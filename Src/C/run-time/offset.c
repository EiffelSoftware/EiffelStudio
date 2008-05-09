/*
	description: "[
			Compiler helper routines to compute the offset of attributes in workbench
			mode. This definitely makes the workbench generated code and melted code
			non-portable.
			]"
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#include "eif_size.h"
#include "eif_offset.h"

/* Macros used to compute padded size for fields in the object */
#define REMAINDER(x)		(((x) % EIF_ALIGN)?(EIF_ALIGN-((x)%EIF_ALIGN)):0)
#define PADD(x,y)			(REMAINDER(x)%(y))

/*
 * Functions definitions
 */

/* Offset of first EIF_CHARACTER. */
rt_public size_t eif_chroff(size_t nb_ref)
{
	size_t to_add = REFACS(nb_ref);
	return to_add + PADD(to_add, CHRSIZ);
}

/* Offset of first EIF_INTEGER_16. */
rt_public size_t eif_i16off(size_t nb_ref, size_t nb_char)
{
	size_t to_add = eif_chroff(nb_ref) + CHRACS(nb_char);
	return to_add + PADD(to_add, I16SIZ);
}

/* Offset of first EIF_INTEGER_32. */
rt_public size_t eif_lngoff(size_t nb_ref, size_t nb_char, size_t nb_int16)
{
	size_t to_add = eif_i16off(nb_ref, nb_char) + I16ACS(nb_int16);
	return to_add + PADD(to_add, LNGSIZ);
}

/* Offset of first EIF_REAL_32. */
rt_public size_t eif_r32off(size_t nb_ref, size_t nb_char, size_t nb_int16, size_t nb_int32)
{
	size_t to_add = eif_lngoff(nb_ref,nb_char, nb_int16) + LNGACS(nb_int32);
	return to_add + PADD(to_add, R32SIZ);
}

/* Offset of first EIF_POINTER. */
rt_public size_t eif_ptroff(size_t nb_ref, size_t nb_char, size_t nb_int16, size_t nb_int32, size_t nb_r32)
{
	size_t to_add = eif_r32off(nb_ref,nb_char, nb_int16,nb_int32) + R32ACS(nb_r32);
	return to_add + PADD(to_add, PTRSIZ);
}

/* Offset of first EIF_INTEGER_64. */
rt_public size_t eif_i64off(size_t nb_ref, size_t nb_char, size_t nb_int16, size_t nb_int32, size_t nb_r32, size_t nb_ptr)
{
	size_t to_add = eif_ptroff(nb_ref,nb_char, nb_int16,nb_int32,nb_r32) + PTRACS(nb_ptr);
	return to_add + PADD(to_add, I64SIZ);
}

/* Offset of first EIF_REAL_64. */
rt_public size_t eif_r64off(size_t nb_ref, size_t nb_char, size_t nb_int16, size_t nb_int32, size_t nb_r32, size_t nb_ptr, size_t nb_int64)
{
	size_t to_add = eif_i64off(nb_ref,nb_char, nb_int16,nb_int32,nb_r32, nb_ptr) + I64ACS(nb_int64);
	return to_add + PADD(to_add, R64SIZ);
}

/* Size of a simple object. */
rt_public size_t eif_objsiz(size_t nb_ref, size_t nb_char, size_t nb_int16, size_t nb_int32, size_t nb_r32, size_t nb_ptr, size_t nb_int64, size_t nb_r64)
{
	size_t to_add = eif_r64off(nb_ref,nb_char, nb_int16,nb_int32,nb_r32,nb_ptr, nb_int64) + R64ACS(nb_r64);
	return to_add + REMAINDER(to_add);
}
