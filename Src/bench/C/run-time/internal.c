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

#include <string.h>

rt_private char *ei_oref(long, EIF_REFERENCE);		/* Offset in object */

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

rt_public char ei_char_field(long i, EIF_REFERENCE object)
{
	/* Returns character value of i-th value */

	return *(EIF_REFERENCE) ei_oref(i,object);
}

rt_public char ei_bool_field(long i, EIF_REFERENCE object)
{
	/* Returns boolean value of i-th value */

	return *(EIF_REFERENCE) ei_oref(i, object);
}

rt_public long ei_int_field(long i, EIF_REFERENCE object)
{
	/* Returns integer value of i-th value */

	return *(long *) ei_oref(i, object);
}

rt_public EIF_REAL ei_float_field(long i, EIF_REFERENCE object)
{
	/* Returns float value of i-th value */

	return *(EIF_REAL *) ei_oref(i, object);
}

rt_public EIF_POINTER ei_ptr_field(long i, EIF_REFERENCE object)
{
	/* Returns pointer value of i-th value */

	return *(EIF_POINTER *) ei_oref(i,object);
}

rt_public EIF_DOUBLE ei_double_field(long i, EIF_REFERENCE object)
{
	/* Returns double value of i-th value */

	return *(EIF_DOUBLE *) ei_oref(i,object);
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

rt_public char ei_special(EIF_REFERENCE object)
{
	/* Is `object' a special one ? */
	
	return ((HEADER(object)->ov_flags) & EO_SPEC) ? (char) 1 : (char) 0;
}

rt_public long ei_offset(long i, EIF_REFERENCE object)
{
	/* Returns offset of i-th field of `object'. */

	return (long) (ei_oref(i, object) - object);
}

rt_private char *ei_oref(long i, EIF_REFERENCE object)
{
	/* Returns character value of i-th value */

	struct cnode *obj_desc;
	int dtype = Dtype(object);
	EIF_REFERENCE o_ref;
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

rt_public void ei_set_reference_field (EIF_INTEGER i, EIF_REFERENCE object, EIF_REFERENCE value)
{
	RTAR(value,object);
	*(EIF_POINTER *) ei_oref(i,object) = value;
}

rt_public void ei_set_double_field(EIF_INTEGER i, EIF_REFERENCE object, EIF_DOUBLE value)
{
	*(EIF_DOUBLE *) ei_oref(i,object) = value;
}

rt_public void ei_set_char_field(EIF_INTEGER i, EIF_REFERENCE object, EIF_CHARACTER value)
{
	*(EIF_CHARACTER *) ei_oref(i,object) = value;
}

rt_public void ei_set_boolean_field(EIF_INTEGER i, EIF_REFERENCE object, EIF_BOOLEAN value)
{
	*(EIF_BOOLEAN *) ei_oref(i,object) = value;
}

rt_public void ei_set_integer_field(EIF_INTEGER i, EIF_REFERENCE object, EIF_INTEGER value)
{
	*(EIF_INTEGER *) ei_oref(i,object) = value;
}

rt_public void ei_set_float_field(EIF_INTEGER i, EIF_REFERENCE object, EIF_REAL value)
{
	*(EIF_REAL *) ei_oref(i,object) = value;
}

rt_public void ei_set_pointer_field(EIF_INTEGER i, EIF_REFERENCE object, EIF_POINTER value)
{
	*(EIF_POINTER *) ei_oref(i,object) = value;
}

