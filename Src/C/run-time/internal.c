/*
	description: "Routines to implement class INTERNAL."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2013, Eiffel Software."
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

/*
doc:<file name="internal.c" header="eif_internal.h" version="$Id$" summary="Externals for INTERNAL class">
*/

#include "eif_portable.h"
#include "eif_internal.h"
#include "eif_cecil.h"
#include "eif_project.h" /* for egc_..._ref_dtype */
#include "rt_gen_types.h"
#include "rt_struct.h"
#include "rt_wbench.h"
#include "rt_assert.h"

#include <string.h>

rt_public char *ei_field_at (long offset, uint32 field_type, EIF_REFERENCE object)
{
	/* Returns the object at `offset' of `object'.
	 * Take care of normal and expanded types.
	 */

	EIF_REFERENCE o_ref, new_obj;

	o_ref = object + offset;
	switch (field_type & SK_HEAD) {
	case SK_CHAR8:
		{
			EIF_CHARACTER_8 val = *(EIF_CHARACTER_8 *) o_ref;

			new_obj = RTLN(egc_char_dtype);
			*(EIF_CHARACTER_8 *) new_obj = val;
			return new_obj;
		}
	case SK_BOOL:
		{
			EIF_BOOLEAN val = *(EIF_BOOLEAN *) o_ref;

			new_obj = RTLN(egc_bool_dtype);
			*(EIF_BOOLEAN *) new_obj = val;
			return new_obj;
		}
	case SK_CHAR32:
		{
			EIF_CHARACTER_32 val = *(EIF_CHARACTER_32 *) o_ref;

			new_obj = RTLN(egc_wchar_dtype);
			*(EIF_CHARACTER_32 *) new_obj = val;
			return new_obj;
		}
	case SK_UINT8:
		{
			EIF_NATURAL_8 val = *(EIF_NATURAL_8 *) o_ref;

			new_obj = RTLN(egc_uint8_dtype);
			*(EIF_NATURAL_8 *) new_obj = val;
			return new_obj;
		}
	case SK_UINT16:
		{
			EIF_NATURAL_16 val = *(EIF_NATURAL_16 *) o_ref;

			new_obj = RTLN(egc_uint16_dtype);
			*(EIF_NATURAL_16 *) new_obj = val;
			return new_obj;
		}
	case SK_UINT32:
		{
			EIF_NATURAL_32 val = *(EIF_NATURAL_32 *) o_ref;

			new_obj = RTLN(egc_uint32_dtype);
			*(EIF_NATURAL_32 *) new_obj = val;
			return new_obj;
		}
	case SK_UINT64:
		{
			EIF_NATURAL_64 val = *(EIF_NATURAL_64 *) o_ref;

			new_obj = RTLN(egc_uint64_dtype);
			*(EIF_NATURAL_64 *) new_obj = val;
			return new_obj;
		}
	case SK_INT8:
		{
			EIF_INTEGER_8 val = *(EIF_INTEGER_8 *) o_ref;

			new_obj = RTLN(egc_int8_dtype);
			*(EIF_INTEGER_8 *) new_obj = val;
			return new_obj;
		}
	case SK_INT16:
		{
			EIF_INTEGER_16 val = *(EIF_INTEGER_16 *) o_ref;

			new_obj = RTLN(egc_int16_dtype);
			*(EIF_INTEGER_16 *) new_obj = val;
			return new_obj;
		}
	case SK_INT32:
		{
			EIF_INTEGER_32 val = *(EIF_INTEGER_32 *) o_ref;

			new_obj = RTLN(egc_int32_dtype);
			*(EIF_INTEGER_32 *) new_obj = val;
			return new_obj;
		}
	case SK_INT64:
		{
			EIF_INTEGER_64 val = *(EIF_INTEGER_64 *) o_ref;

			new_obj = RTLN(egc_int64_dtype);
			*(EIF_INTEGER_64 *) new_obj = val;
			return new_obj;
		}
	case SK_REAL32:
		{
			EIF_REAL_32 val = *(EIF_REAL_32 *) o_ref;

			new_obj = RTLN(egc_real32_dtype);
			*(EIF_REAL_32 *) new_obj = val;
			return new_obj;
		}
	case SK_POINTER:
		{
			EIF_POINTER val = *(EIF_POINTER *) o_ref;

			new_obj = RTLN(egc_point_dtype);
			*(EIF_POINTER *) new_obj = val;
			return new_obj;
		}
	case SK_REAL64:
		{
			EIF_REAL_64 val = *(EIF_REAL_64 *) o_ref;

			new_obj = RTLN(egc_real64_dtype);
			*(EIF_REAL_64 *) new_obj = val;
			return new_obj;
		}
	case SK_REF:
		return *(EIF_REFERENCE *) o_ref;	/* Return reference */
	case SK_EXP:
		return RTCL(o_ref);			/* Return copy of expanded object */
	default:
		return (EIF_REFERENCE) 0;
	}
}

rt_public char *ei_field (long i, EIF_REFERENCE object)
{
	/* Returns the object referenced by the i_th field of `object'.
	 * Take care of normal and expanded types.
	 */

	const struct cnode *obj_desc;
	EIF_TYPE_INDEX dtype = Dtype(object);
	uint32 field_type;
	long offset;

	obj_desc = &System(dtype);
	field_type = obj_desc->cn_types[i];
#ifndef WORKBENCH
	offset = obj_desc->cn_offsets[i];
#else
	offset = wattr(obj_desc->cn_attr[i], dtype);
#endif

	return ei_field_at (offset, field_type, object);
}

#ifdef WORKBENCH
rt_public void * ei_oref(long i, EIF_REFERENCE object)
	/* Returns the memory address of the i-th field of `object'. */
{
	EIF_TYPE_INDEX dtype = Dtype(object);
	uint32 offset;
	offset = wattr(System(dtype).cn_attr[i], dtype);
	return object + offset;
}

rt_public long ei_offset_of_type(long i, EIF_ENCODED_TYPE enc_ftype)
	/* Returns the memory address of the i-th field of objects of type `enc_ftype'. */
{
	EIF_TYPE_INDEX dtype = To_dtype(eif_decoded_type(enc_ftype).id);
	uint32 offset;
	offset = wattr(System(dtype).cn_attr[i - 1], dtype);
	return offset;
}
#endif

rt_public long ei_eif_type(uint32 field_type)
{
	/* Returns Eiffel type of field type `field_type'. */
	/* Look at `eif_cecil.h' for constants definitions */

	switch (field_type & SK_HEAD) {
	case SK_REF:	return EIF_REFERENCE_TYPE;
	case SK_CHAR8:	return EIF_CHARACTER_8_TYPE;
	case SK_CHAR32:	return EIF_CHARACTER_32_TYPE;
	case SK_BOOL:	return EIF_BOOLEAN_TYPE;
	case SK_UINT8:	return EIF_NATURAL_8_TYPE;
	case SK_UINT16:	return EIF_NATURAL_16_TYPE;
	case SK_UINT32:	return EIF_NATURAL_32_TYPE;
	case SK_UINT64:	return EIF_NATURAL_64_TYPE;
	case SK_INT8:	return EIF_INTEGER_8_TYPE;
	case SK_INT16:	return EIF_INTEGER_16_TYPE;
	case SK_INT32:	return EIF_INTEGER_32_TYPE;
	case SK_INT64:	return EIF_INTEGER_64_TYPE;
	case SK_REAL32:	return EIF_REAL_32_TYPE;
	case SK_REAL64:	return EIF_REAL_64_TYPE;
	case SK_EXP:	return EIF_EXPANDED_TYPE;
	default:	return EIF_POINTER_TYPE;
	}
}

/*
doc:</file>
*/
