/*

 #    #    #   #####  ######  #####   #    #    ##    #                ####
 #    ##   #     #    #       #    #  ##   #   #  #   #               #    #
 #    # #  #     #    #####   #    #  # #  #  #    #  #               #
 #    #  # #     #    #       #####   #  # #  ######  #        ###    #
 #    #   ##     #    #       #   #   #   ##  #    #  #        ###    #    #
 #    #    #     #    ######  #    #  #    #  #    #  ######   ###     ####

	Routines to implement class INTERNAL
*/

#include "eif_project.h" /* for egc_..._ref_dtype */
#include "eif_config.h"
#include "eif_internal.h"

rt_private char *ei_oref(long, char *);		/* Offset in object */

rt_public long ei_dtype (char *object)
{
	/* Returns dynamic type of `object' */

	return (long) Dtype(object);
}

rt_public long ei_count_field (char *object)
{
	/* Returns the number of logical fields in `object'. */

	return System(Dtype(object)).cn_nbattr;
}

rt_public char *ei_field (long i, char *object)
{
	/* Returns the object referenced by the i_th field of `object'.
	 * Take care of normal and expanded types.
	 */

	struct cnode *obj_desc;
	int dtype = Dtype(object);
	uint32 field_type;
	char *o_ref, *new_obj;
#ifdef WORKBENCH
	long offset;
#endif

	obj_desc = &System(dtype);
	field_type = obj_desc->cn_types[i];
#ifndef WORKBENCH
	o_ref = object + (obj_desc->cn_offsets[i])[dtype];
#else
	CAttrOffs(offset,obj_desc->cn_attr[i],dtype);
	o_ref = object + offset;
#endif
	switch (field_type & SK_HEAD) {
	case SK_CHAR:
		{
			char val = *(char *) o_ref;

			new_obj = RTLN(egc_char_ref_dtype);
			*(char *) new_obj = val;
			return new_obj;
		}
	case SK_BOOL:
		{
			char val = *(char *) o_ref;

			new_obj = RTLN(egc_bool_ref_dtype);
			*(char *) new_obj = val;
			return new_obj;
		}
	case SK_INT:
		{
			long val = *(long *) o_ref;

			new_obj = RTLN(egc_int_ref_dtype);
			*(long *) new_obj = val;
			return new_obj;
		}
	case SK_FLOAT:
		{
			float val = *(float *) o_ref;

			new_obj = RTLN(egc_real_ref_dtype);
			*(float *) new_obj = val;
			return new_obj;
		}
	case SK_POINTER:
		{
			fnptr val = *(fnptr *) o_ref;

			new_obj = RTLN(egc_point_ref_dtype);
			*(fnptr *) new_obj = val;
			return new_obj;
		}
	case SK_DOUBLE:
		{
			double val = *(double *) o_ref;

			new_obj = RTLN(egc_doub_ref_dtype);
			*(double *) new_obj = val;
			return new_obj;
		}
	case SK_REF:
		return *(char **) o_ref;	/* Return reference */
	case SK_EXP:
		return RTCL(o_ref);			/* Return copy of expanded object */
	default:
		return (char *) 0;
	}
}

rt_public char *ei_field_name (long i, char *object)
{
	/* Returns name of the i_th logical field of `object'. */

	char *name = System(Dtype(object)).cn_names[i];

	return makestr(name, strlen(name));
}

rt_public long ei_field_type(long i, char *object)
{
	/* Returns type of i-th logical field of `object'. */

	uint32 field_type = System(Dtype(object)).cn_types[i];

	switch (field_type & SK_HEAD) {
	case SK_REF:	return 1L;
	case SK_CHAR:	return 2L;
	case SK_BOOL:	return 3L;
	case SK_INT:	return 4L;
	case SK_FLOAT:	return 5L;
	case SK_DOUBLE:	return 6L;
	case SK_EXP:	return 7L;
	case SK_BIT:	return 8L;
	default:		return 0L;
	}
}

rt_public char ei_char_field(long i, char *object)
{
	/* Returns character value of i-th value */

	return *(char *) ei_oref(i,object);
}

rt_public char ei_bool_field(long i, char *object)
{
	/* Returns boolean value of i-th value */

	return *(char *) ei_oref(i, object);
}

rt_public long ei_int_field(long i, char *object)
{
	/* Returns integer value of i-th value */

	return *(long *) ei_oref(i, object);
}

rt_public float ei_float_field(long i, char *object)
{
	/* Returns float value of i-th value */

	return *(float *) ei_oref(i, object);
}

rt_public fnptr ei_ptr_field(long i, char *object)
{
	/* Returns pointer value of i-th value */

	return *(fnptr *) ei_oref(i,object);
}

rt_public double ei_double_field(long i, char *object)
{
	/* Returns double value of i-th value */

	return *(double *) ei_oref(i,object);
}

rt_public char *ei_exp_type(long i, char *object)
{
	/* Returns the class name of the i-th expanded field of `object'. */

	int dtype = (HEADER(ei_oref(i,object))->ov_flags) & EO_TYPE;
	char *s;

	s = System(dtype).cn_generator;
	return makestr(s,strlen(s));
}

rt_public long ei_bit_size(long i, char *object)
{
	/* Returns the size (in bit) of the i-the bit field of `object'. */

	return (long) (System(Dtype(object)).cn_types[i] - SK_BIT);
}
	
rt_public long ei_size(char *object)
{
	/* Returns physical size occupied by `object'. */

	if (HEADER(object)->ov_flags & EO_SPEC)
		return (HEADER(object)->ov_size & B_SIZE) - LNGPAD_2;
	else
		return (long) Size(Dtype(object));
}

rt_public char ei_special(char *object)
{
	/* Is `object' a special one ? */
	
	return ((HEADER(object)->ov_flags) & EO_SPEC) ? (char) 1 : (char) 0;
}

rt_public long ei_offset(long i, char *object)
{
	/* Returns offset of i-th field of `object'. */

	return (long) (ei_oref(i, object) - object);
}

rt_private char *ei_oref(long i, char *object)
{
	/* Returns character value of i-th value */

	struct cnode *obj_desc;
	int dtype = Dtype(object);
	char *o_ref;
#ifdef WORKBENCH
	long offset;
#endif

	obj_desc = &System(dtype);
#ifndef WORKBENCH
	o_ref = object + (obj_desc->cn_offsets[i])[dtype];
#else
	CAttrOffs(offset,obj_desc->cn_attr[i],dtype);
	o_ref = object + offset;
#endif
	return o_ref;
}

rt_public void ei_set_reference_field(EIF_INTEGER i, EIF_POINTER object, EIF_POINTER value)
{
	RTAR(value,object);
	*(EIF_POINTER *) ei_oref(i,object) = value;
}

rt_public void ei_set_double_field(EIF_INTEGER i, EIF_POINTER object, EIF_DOUBLE value)
{
	*(EIF_DOUBLE *) ei_oref(i,object) = value;
}

rt_public void ei_set_char_field(EIF_INTEGER i, EIF_POINTER object, EIF_CHARACTER value)
{
	*(EIF_CHARACTER *) ei_oref(i,object) = value;
}

rt_public void ei_set_boolean_field(EIF_INTEGER i, EIF_POINTER object, EIF_BOOLEAN value)
{
	*(EIF_BOOLEAN *) ei_oref(i,object) = value;
}

rt_public void ei_set_integer_field(EIF_INTEGER i, EIF_POINTER object, EIF_INTEGER value)
{
	*(EIF_INTEGER *) ei_oref(i,object) = value;
}

rt_public void ei_set_float_field(EIF_INTEGER i, EIF_POINTER object, EIF_REAL value)
{
	*(EIF_REAL *) ei_oref(i,object) = value;
}

rt_public void ei_set_pointer_field(EIF_INTEGER i, EIF_POINTER object, EIF_POINTER value)
{
	*(EIF_POINTER *) ei_oref(i,object) = value;
}

