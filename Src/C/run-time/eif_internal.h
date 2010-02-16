/*
	description: "Routines to implement class INTERNAL."
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

#ifndef _eif_internal_h_
#define _eif_internal_h_

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Returns the number of logical fields in `object'. */
#define ei_count_field_of_type(type_id)		(System(To_dtype(type_id)).cn_nbattr)

/* Returns name of the i_th logical field of `object'. */
#define ei_field_name_of_type(i,type_id)	(System(To_dtype(type_id)).cn_names[i])

RT_LNK char *ei_field_at (long offset, uint32 field_type, EIF_REFERENCE object);
RT_LNK char *ei_field (long i, EIF_REFERENCE object);
RT_LNK long ei_eif_type(uint32 field_type);
RT_LNK long ei_field_type_of_type(long i, EIF_INTEGER type_id);
RT_LNK long ei_field_static_type_of_type(long i, EIF_INTEGER type_id);
RT_LNK char *ei_exp_type(long i, EIF_REFERENCE object);
RT_LNK rt_uint_ptr ei_bit_size(long i, EIF_REFERENCE object);
RT_LNK rt_uint_ptr ei_size(EIF_REFERENCE object);
RT_LNK void *ei_oref(long, EIF_REFERENCE);
RT_LNK void eif_set_dynamic_type (EIF_REFERENCE object, EIF_INTEGER dtype);
RT_LNK EIF_BOOLEAN eif_is_special_type (EIF_INTEGER dftype);

#define ei_special(obj)	(EIF_TEST((HEADER(obj)->ov_flags & (EO_SPEC | EO_TUPLE)) == EO_SPEC))
#define ei_tuple(obj)	(EIF_TEST((HEADER(obj)->ov_flags & (EO_SPEC | EO_TUPLE)) == (EO_SPEC | EO_TUPLE)))
#define eif_is_tuple_type(dftype) (EIF_TEST(To_dtype(dftype) == egc_tup_dtype))

#define eif_special_any_type(dftype) (EIF_TEST((uint32) To_dtype(dftype) == (uint32) egc_sp_ref))

#define	ei_offset(i,object)			(EIF_INTEGER) ((EIF_REFERENCE) ei_oref(i, (EIF_REFERENCE) (object)) - (EIF_REFERENCE) (object))

/* Attribute access */
#define ei_char_field(i,object)		*(EIF_CHARACTER *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_char_32_field(i,object)	*(EIF_WIDE_CHAR *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_bool_field(i,object)		*(EIF_BOOLEAN *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_uint_8_field(i,object)	*(EIF_NATURAL_8 *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_uint_16_field(i,object)	*(EIF_NATURAL_16 *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_uint_32_field(i,object)	*(EIF_NATURAL_32 *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_uint_64_field(i,object)	*(EIF_NATURAL_64 *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_int_8_field(i,object)	*(EIF_INTEGER_8 *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_int_16_field(i,object)	*(EIF_INTEGER_16 *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_int_32_field(i,object)	*(EIF_INTEGER_32 *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_int_64_field(i,object)	*(EIF_INTEGER_64 *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_float_field(i,object)	*(EIF_REAL *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_double_field(i,object)	*(EIF_DOUBLE *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_ptr_field(i,object)		*(EIF_POINTER *) ei_oref(i,(EIF_REFERENCE) (object))

/* Attribute setting */
#define ei_set_reference_field(i,object,value)	RTAR(object,value); *(EIF_REFERENCE *) ei_oref(i,object) = (EIF_REFERENCE) (value)
#define ei_set_char_field(i,object,value)		*(EIF_CHARACTER *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_CHARACTER) (value)
#define ei_set_char_32_field(i,object,value)	*(EIF_WIDE_CHAR *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_WIDE_CHAR) (value)
#define ei_set_boolean_field(i,object,value)	*(EIF_BOOLEAN *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_BOOLEAN) (value)
#define ei_set_natural_8_field(i,object,value)	*(EIF_NATURAL_8 *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_NATURAL_8) (value)
#define ei_set_natural_16_field(i,object,value)	*(EIF_NATURAL_16 *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_NATURAL_16) (value)
#define ei_set_natural_32_field(i,object,value)	*(EIF_NATURAL_32 *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_NATURAL_32) (value)
#define ei_set_natural_64_field(i,object,value)	*(EIF_NATURAL_64 *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_NATURAL_64) (value)
#define ei_set_integer_8_field(i,object,value)	*(EIF_INTEGER_8 *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_INTEGER_8) (value)
#define ei_set_integer_16_field(i,object,value)	*(EIF_INTEGER_16 *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_INTEGER_16) (value)
#define ei_set_integer_32_field(i,object,value)	*(EIF_INTEGER_32 *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_INTEGER_32) (value)
#define ei_set_integer_64_field(i,object,value)	*(EIF_INTEGER_64 *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_INTEGER_64) (value)
#define ei_set_float_field(i,object,value)		*(EIF_REAL *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_REAL) (value)
#define ei_set_double_field(i,object,value)		*(EIF_DOUBLE *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_DOUBLE) (value)
#define ei_set_pointer_field(i,object,value)	*(EIF_POINTER *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_POINTER) (value)

/* Marking */
#define ei_mark(obj)		(HEADER(obj)->ov_flags |= EO_STORE)
#define ei_unmark(obj)		(HEADER(obj)->ov_flags &= ~EO_STORE)
#define ei_is_marked(obj)	((HEADER(obj)->ov_flags & EO_STORE) ? EIF_TRUE : EIF_FALSE)

#ifdef __cplusplus
}
#endif

#endif

