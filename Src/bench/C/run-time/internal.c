/*

 #    #    #   #####  ######  #####   #    #    ##    #                ####
 #    ##   #     #    #       #    #  ##   #   #  #   #               #    #
 #    # #  #     #    #####   #    #  # #  #  #    #  #               #
 #    #  # #     #    #       #####   #  # #  ######  #        ###    #
 #    #   ##     #    #       #   #   #   ##  #    #  #        ###    #    #
 #    #    #     #    ######  #    #  #    #  #    #  ######   ###     ####

	Routines to implement class INTERNAL
*/

#include "eif_portable.h"
#include "eif_internal.h"
#include "eif_cecil.h"
#include "eif_project.h" /* for egc_..._ref_dtype */
#include "rt_wbench.h"
#include "rt_assert.h"

#include <string.h>


rt_public char *ei_field (long i, EIF_REFERENCE object)
{
	/* Returns the object referenced by the i_th field of `object'.
	 * Take care of normal and expanded types.
	 */

	struct cnode *obj_desc;
	int dtype = Dtype(object);
	uint32 field_type;
	EIF_REFERENCE o_ref, new_obj;
#ifdef WORKBENCH
	long offset;
#endif

	obj_desc = &System(dtype);
	field_type = obj_desc->cn_types[i];
#ifndef WORKBENCH
	o_ref = object + obj_desc->cn_offsets[i];
#else
	CAttrOffs(offset,obj_desc->cn_attr[i],dtype);
	o_ref = object + offset;
#endif
	switch (field_type & SK_HEAD) {
	case SK_CHAR:
		{
			EIF_CHARACTER val = *(EIF_CHARACTER *) o_ref;

			new_obj = RTLN(egc_char_ref_dtype);
			*(EIF_CHARACTER *) new_obj = val;
			return new_obj;
		}
	case SK_BOOL:
		{
			EIF_BOOLEAN val = *(EIF_CHARACTER *) o_ref;

			new_obj = RTLN(egc_bool_ref_dtype);
			*(EIF_CHARACTER *) new_obj = val;
			return new_obj;
		}
	case SK_WCHAR:
		{
			EIF_WIDE_CHAR val = *(EIF_WIDE_CHAR *) o_ref;

			new_obj = RTLN(egc_wchar_ref_dtype);
			*(EIF_WIDE_CHAR *) new_obj = val;
			return new_obj;
		}
	case SK_INT8:
		{
			EIF_INTEGER_8 val = *(EIF_INTEGER_8 *) o_ref;

			new_obj = RTLN(egc_int8_ref_dtype);
			*(EIF_INTEGER_8 *) new_obj = val;
			return new_obj;
		}
	case SK_INT16:
		{
			EIF_INTEGER_16 val = *(EIF_INTEGER_16 *) o_ref;

			new_obj = RTLN(egc_int16_ref_dtype);
			*(EIF_INTEGER_16 *) new_obj = val;
			return new_obj;
		}
	case SK_INT32:
		{
			EIF_INTEGER_32 val = *(EIF_INTEGER_32 *) o_ref;

			new_obj = RTLN(egc_int32_ref_dtype);
			*(EIF_INTEGER_32 *) new_obj = val;
			return new_obj;
		}
	case SK_INT64:
		{
			EIF_INTEGER_64 val = *(EIF_INTEGER_64 *) o_ref;

			new_obj = RTLN(egc_int64_ref_dtype);
			*(EIF_INTEGER_64 *) new_obj = val;
			return new_obj;
		}
	case SK_FLOAT:
		{
			EIF_REAL val = *(EIF_REAL *) o_ref;

			new_obj = RTLN(egc_real_ref_dtype);
			*(EIF_REAL *) new_obj = val;
			return new_obj;
		}
	case SK_POINTER:
		{
			EIF_POINTER val = *(EIF_POINTER *) o_ref;

			new_obj = RTLN(egc_point_ref_dtype);
			*(EIF_POINTER *) new_obj = val;
			return new_obj;
		}
	case SK_DOUBLE:
		{
			EIF_DOUBLE val = *(EIF_DOUBLE *) o_ref;

			new_obj = RTLN(egc_doub_ref_dtype);
			*(EIF_DOUBLE *) new_obj = val;
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

rt_public long ei_field_type_of_type(long i, EIF_INTEGER type_id)
{
	/* Returns type of i-th logical field of `object'. */
	/* Look at `eif_cecil.h' for constants definitions */

	uint32 field_type = System(Deif_bid(type_id)).cn_types[i];

	switch (field_type & SK_HEAD) {
	case SK_REF:	return EIF_REFERENCE_TYPE;
	case SK_CHAR:	return EIF_CHARACTER_TYPE;
	case SK_WCHAR:	return EIF_WIDE_CHAR_TYPE;
	case SK_BOOL:	return EIF_BOOLEAN_TYPE;
	case SK_INT8:	return EIF_INTEGER_8_TYPE;
	case SK_INT16:	return EIF_INTEGER_16_TYPE;
	case SK_INT32:	return EIF_INTEGER_32_TYPE;
	case SK_INT64:	return EIF_INTEGER_64_TYPE;
	case SK_FLOAT:	return EIF_REAL_TYPE;
	case SK_DOUBLE:	return EIF_DOUBLE_TYPE;
	case SK_EXP:	return EIF_EXPANDED_TYPE;
	case SK_BIT:	return EIF_BIT_TYPE;
	default:		return EIF_POINTER_TYPE;
	}
}

rt_public char *ei_exp_type(long i, EIF_REFERENCE object)
{
	/* Returns the class name of the i-th expanded field of `object'. */

	int dtype = Deif_bid(HEADER(ei_oref(i,object))->ov_flags);
	char *s;

	s = System(dtype).cn_generator;
	return makestr(s,strlen(s));
}

rt_public long ei_bit_size(long i, EIF_REFERENCE object)
{
	/* Returns the size (in bit) of the i-the bit field of `object'. */

	return (long) (System(Dtype(object)).cn_types[i] - SK_BIT);
}
	
rt_public long ei_size(EIF_REFERENCE object)
{
	/* Returns physical size occupied by `object'. */

	if (HEADER(object)->ov_flags & EO_SPEC)
		return (HEADER(object)->ov_size & B_SIZE) - LNGPAD_2;
	else
		return (long) EIF_Size(Dtype(object));
}

rt_public EIF_BOOLEAN ei_special(EIF_REFERENCE object)
	/* Is `object' a special one ? */
{
	return EIF_TEST((HEADER(object)->ov_flags) & EO_SPEC);
}

rt_public EIF_BOOLEAN eif_special_any_type (EIF_INTEGER dftype)
	/* Does `dtype' represent a SPECIAL [ANY]? */
{
	uint32 dtype = Deif_bid(dftype);
	return EIF_TEST(dtype == (uint32) egc_sp_ref);
}

rt_public EIF_BOOLEAN eif_is_special_type (EIF_INTEGER dftype)
	/* Does `dtype' represent a SPECIAL [XX] where XX can be a basic type
	 * or a reference type? */
{
	uint32 dtype = Deif_bid(dftype);
	return EIF_TEST(
		(dtype == egc_sp_bool) ||
		(dtype == egc_sp_char) ||
		(dtype == egc_sp_wchar) ||
		(dtype == egc_sp_int8) ||
		(dtype == egc_sp_int16) ||
		(dtype == egc_sp_int32) ||
		(dtype == egc_sp_int64) ||
		(dtype == egc_sp_real) ||
		(dtype == egc_sp_double) ||
		(dtype == egc_sp_pointer) ||
		(dtype == egc_sp_ref)
		);
}

rt_public void eif_set_dynamic_type (EIF_REFERENCE object, EIF_INTEGER dtype)
	/* Set object type to be `dtype'. To be used very carefully as one might
	 * mess up object structure.
	 */
{
	uint32 flags;

	REQUIRE ("object not null", object);
	REQUIRE ("dtype valid", dtype > 0);

	flags = HEADER(object)->ov_flags;
	flags = (flags & 0xFFFF0000) | (dtype & 0x0000FFFF);
	HEADER(object)->ov_flags = flags;

	ENSURE ("dtype set", Dftype(object) == dtype);
}

rt_public void * ei_oref(long i, EIF_REFERENCE object)
{
	/* Returns character value of i-th value */

	struct cnode *obj_desc;
	int dtype = Dtype(object);
	void * o_ref;
#ifdef WORKBENCH
	long offset;
#endif

	obj_desc = &System(dtype);
#ifndef WORKBENCH
	o_ref = object + obj_desc->cn_offsets[i];
#else
	CAttrOffs(offset,obj_desc->cn_attr[i],dtype);
	o_ref = object + offset;
#endif
	return o_ref;
}
