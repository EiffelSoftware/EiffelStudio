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

#ifndef _eif_internal_h_
#define _eif_internal_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Returns the number of logical fields in `object'. */
#define ei_count_field_of_type(enc_ftype)		(System(To_dtype(eif_decoded_type(enc_ftype).id)).cn_nbattr)

/* Returns name of the i_th logical field of `object'. */
#define ei_field_name_of_type(i,enc_ftype)	(System(To_dtype(eif_decoded_type(enc_ftype).id)).cn_names[i])

RT_LNK char *ei_field (long i, EIF_REFERENCE object);
RT_LNK long ei_eif_type(uint32 field_type);
rt_private rt_inline long ei_field_type_of_type(long i, EIF_ENCODED_TYPE enc_ftype)
	/* Returns type of i-th logical field of `object'. */
	/* Look at `eif_cecil.h' for constants definitions */
{
	EIF_TYPE ftype = eif_decoded_type(enc_ftype);
	uint32 field_type = System(To_dtype(ftype.id)).cn_types[i];
	return ei_eif_type (field_type);
}

rt_private rt_inline EIF_TYPE ei_field_static_type_of_type(long i, EIF_ENCODED_TYPE enc_ftype)
	/* Returns type of i-th logical field of `enc_ftype' as
	 * declared in associated class of `enc_ftype'. */
{
	const EIF_TYPE_INDEX *typearr;
	EIF_TYPE ftype = eif_decoded_type(enc_ftype);
	typearr = System(To_dtype(ftype.id)).cn_gtypes[i];
	return eif_compound_id (ftype.id, typearr);
}

#ifdef WORKBENCH
RT_LNK void *ei_oref(long, EIF_REFERENCE);
#else
rt_private rt_inline void * ei_oref(long i, EIF_REFERENCE object)
	/* Returns the memory address of the i-th field of `object'. */
{
	return object + System(Dtype(object)).cn_offsets[i]; 
}
#endif

rt_private rt_inline char *ei_exp_type(long i, EIF_REFERENCE object)
	/* Returns the class name of the i-th expanded field of `object'. */
{
	const char *s;
	s = System(HEADER(ei_oref(i,object))->ov_dtype).cn_generator;
	return makestr(s,strlen(s));
}

rt_private rt_inline rt_uint_ptr ei_size(EIF_REFERENCE object)
{
		/* Returns physical size occupied by `object' including its header. */
	return (OVERHEAD + (HEADER(object)->ov_size & B_SIZE));
}

rt_private rt_inline void eif_set_dynamic_type (EIF_REFERENCE object, EIF_ENCODED_TYPE dftype)
	/* Set object type to be `dftype'. To be used very carefully as one might
	 * mess up object structure.
	 */
{
	EIF_TYPE ftype = eif_decoded_type(dftype);
	Dftype(object)= ftype.id;
	Dtype(object)=To_dtype(ftype.id);
}

rt_private rt_inline EIF_BOOLEAN eif_is_special_type (EIF_INTEGER dftype)
	/* Does `dtype' represent a SPECIAL [XX] where XX can be a basic type
	 * or a reference type? */
{
	EIF_TYPE_INDEX dtype = To_dtype(dftype);
	return EIF_TEST(
		(dtype == egc_sp_bool) ||
		(dtype == egc_sp_char) ||
		(dtype == egc_sp_wchar) ||
		(dtype == egc_sp_uint8) ||
		(dtype == egc_sp_uint16) ||
		(dtype == egc_sp_uint32) ||
		(dtype == egc_sp_uint64) ||
		(dtype == egc_sp_int8) ||
		(dtype == egc_sp_int16) ||
		(dtype == egc_sp_int32) ||
		(dtype == egc_sp_int64) ||
		(dtype == egc_sp_real32) ||
		(dtype == egc_sp_real64) ||
		(dtype == egc_sp_pointer) ||
		(dtype == egc_sp_ref)
		);
}

#define ei_special(obj)	(EIF_TEST((HEADER(obj)->ov_flags & (EO_SPEC | EO_TUPLE)) == EO_SPEC))
#define ei_tuple(obj)	(EIF_TEST((HEADER(obj)->ov_flags & (EO_SPEC | EO_TUPLE)) == (EO_SPEC | EO_TUPLE)))
#define eif_is_tuple_type(dftype) (EIF_TEST(To_dtype(dftype) == egc_tup_dtype))

#define eif_special_any_type(dftype) (EIF_TEST((uint32) To_dtype(dftype) == (uint32) egc_sp_ref))

#ifdef WORKBENCH
#define	ei_offset(i,object)		(EIF_INTEGER) ((EIF_REFERENCE) ei_oref(i, (EIF_REFERENCE) (object)) - (EIF_REFERENCE) (object))
#else
#define	ei_offset(i,object)		(EIF_INTEGER) (System(Dtype(object)).cn_offsets[i])
#endif

#ifdef WORKBENCH
RT_LNK long ei_offset_of_type(long i, EIF_ENCODED_TYPE enc_ftype);
#else
	/* Returns the memory address of the i-th field of objects of type `enc_ftype'. */
#define ei_offset_of_type(i,enc_ftype)	(EIF_INTEGER) (System(To_dtype(eif_decoded_type(enc_ftype).id)).cn_offsets[i - 1])
#endif

/* Attribute access */
#define ei_char_field(i,object)		*(EIF_CHARACTER_8 *) ei_oref(i,(EIF_REFERENCE) (object))
#define ei_char_32_field(i,object)	*(EIF_CHARACTER_32 *) ei_oref(i,(EIF_REFERENCE) (object))
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
#define ei_reference_field(i,object)	*(EIF_REFERENCE *) ei_oref(i,(EIF_REFERENCE) (object))

/* Attribute setting */
#define ei_set_reference_field(i,object,value)	RTAR(object,value); *(EIF_REFERENCE *) ei_oref(i,object) = (EIF_REFERENCE) (value)
#define ei_set_char_field(i,object,value)		*(EIF_CHARACTER_8 *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_CHARACTER_8) (value)
#define ei_set_char_32_field(i,object,value)	*(EIF_CHARACTER_32 *) ei_oref(i,(EIF_REFERENCE)(object)) = (EIF_CHARACTER_32) (value)
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

