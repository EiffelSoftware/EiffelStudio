/*
	eif_type_id.c : Computation of dynamic type corresponding to
					a written type in a C string.

	$Id$
*/

#include "eif_portable.h"
#include "eif_macros.h"
#include "eif_struct.h"
#include "eif_gen_conf.h"
#include "eif_cecil.h"
#include "eif_lmalloc.h"
#include "eif_threads.h"
#include "rt_gen_types.h"
#include <assert.h>
#include <ctype.h>
#include <string.h>


/* Prototypes */
rt_private int is_good (char c);
rt_private int is_type_separator (char c);
rt_private int is_generic (struct gt_info *type, char *class);
rt_private int16 gen_type_id (int32 cecil_id);
rt_private EIF_TYPE_ID compute_eif_type_id (int n, char **type_string_array);
rt_private void eif_type_id_ex (int *error, struct gt_info *type, int gen_number,
		char **type_string_array, int16* typearr, int pos, int length);

/*------------------------------------------------------------------*/
/* Compute the dynamic type corresponding to the C string type      */
/* `type_string'                                                    */
/*------------------------------------------------------------------*/
rt_public EIF_TYPE_ID eif_type_id (char *type_string)
{
	char **type_string_array = (char **) 0;
	char *string_type = (char *) 0;
	char c = (char) 0;
	int i = 0;
	int state = 1;
	int n = 0;	/* Number of elements in an the C generated array */
	int l = 0;	/* length of the currently analyzed string */
	EIF_TYPE_ID result; /* Computed `type_id' */

	if (type_string == (char *) 0)
			/* Cannot process current string */
		return -1;

		/* Cut the string and put each part in an array */
	while ((c = type_string [i]) != (char) 0) {
		if (is_good(c)) {
			l++;
			state = 0;
		}
		if (state == 0 && is_type_separator (c)) {
			state = 1;
			type_string_array = (char **) eif_realloc (type_string_array, (n + 1) * sizeof (char *));
			if (type_string_array == (char **) 0)
				enomem();
			string_type = (char *) eif_malloc ((l + 1) * sizeof (char));
			if (string_type == (char *) 0)
				enomem();
			string_type = (char *) memcpy (string_type, type_string + i - l, l);
			string_type [l] = (char) 0;
			type_string_array [n] = string_type;
			n++;
			l = 0;
		}
		i++;
	}

	if (type_string_array == (char **) 0) {
			/* There was only a simple type, not a generic one. */
		type_string_array = (char **) eif_malloc (sizeof (char *));
		if (type_string_array == (char **) 0)
			enomem();
		string_type = (char *) eif_malloc ((l + 1) * sizeof (char));
		if (string_type == (char *) 0)
			enomem();
		string_type = (char *) memcpy (string_type, type_string + i - l, l);
		string_type [l] = (char) 0;
		type_string_array [0] = string_type;
		n = 1;
	}
	result = compute_eif_type_id (n, type_string_array);

		/* Free all the allocated memory */
	for (i=0; i <= n - 1; i++) {
		string_type = type_string_array [i];
		eif_free (string_type);
	}
	eif_free (type_string_array);

	return result;
}

rt_private int is_good (char c)
{
	return isalpha (c) || isdigit (c) || (c == '_');
}

rt_private int is_type_separator (char c)
{
	return ((c == '[') || (c == ']') || (c == ',') || (c == ' '));
}

rt_private int is_generic (struct gt_info *type, char *class)
{
	struct gt_info *ltype;

	ltype = (struct gt_info *) ct_value (&egc_ce_gtype, class);
	if ((struct gt_info *) 0 == ltype)
			/* We did not find an entry of `class' in the list of generic
			 * classes, so we should return FALSE */
		return EIF_NO_TYPE;
	else {
			/* We found a generic class with name `class' so we fill the give
			 * `type' structures */
		type->gt_param = ltype ->gt_param;
		type->gt_gen = ltype ->gt_gen;
		type->gt_type = ltype ->gt_type;
		return 1;
	}
}

rt_private EIF_TYPE_ID compute_eif_type_id (int n, char **type_string_array)
{
	struct gt_info type;
	EIF_TYPE_ID result = 0;
	int error = 0;

	if (is_generic (&type, type_string_array[0]) > 0) {
		int16 *typearr = (int16 *) 0;

			/* Allocate the typearr structures and do the basic
			 * initialization, the first element is set to `-1' since
			 * there is no static call context, the last one too as a terminator
			 * for other generic conformance routines
			 */
		typearr = (int16 *) eif_malloc ((n + 2) * sizeof (int16));
		if (typearr == (int16 *)0)
			enomem();
		typearr [0] = -1;
		typearr [n + 1] = -1;

			/* There is a generic type, so we need to analyze the generic parameter
			 * before finding out the real type */
		eif_type_id_ex (&error, &type, type.gt_param, type_string_array, typearr, 0, n);
		if (error == 0) {
			result = (EIF_TYPE_ID) eif_compound_id ((int16 *)0, (char *)0,(int16) typearr[1], typearr);
		}
		eif_free (typearr);
	} else
		result = eifcid(type_string_array [0]);

	if (error == 0) {
		return result;
	} else {
		return EIF_NO_TYPE;
	}
}

rt_private void eif_type_id_ex (int *error, struct gt_info *type, int gen_number,
		char **type_string_array, int16* typearr, int pos, int length)
{
	int i = 0;
	struct gt_info ltype;
	int32 cecil_id;
	int32 *gtype;			/* Generic information for current type */
	int32 *itype;			/* Generic information for inspected type */
	int32 *t;				/* To walk through the gt_gen array */
	int16 real_type_id;		/* Computed type id */
	int matched = 0;		/* Did the inspected type matched our entry? */
	int index = (int) 0;	/* Index at which we need to write or read the type */
	
	if ((*error == 1) || ((pos + gen_number) > (length - 1))) {
			/* The number of parameters given to resolve the generic type is
			 * not big enough */
		*error = 1;
		return;
	}

		/* Allocate the gtype array with the corresponding number of generics */
	gtype = (int32 *) eif_malloc (gen_number * sizeof (int32));
	if (gtype == (int32 *) 0)
		enomem();

		/* Allocate the itype array with the corresponding number of generics */
	itype = (int32 *) eif_malloc (gen_number * sizeof (int32));
	if (itype == (int32 *) 0)
		enomem();

	for (i = 1; i <= gen_number; i++) {
		if (is_generic (&ltype, type_string_array [index + pos + i]) > 0) {
			eif_type_id_ex (error, &ltype, ltype.gt_param,
					type_string_array, typearr, index + pos + i, length);
				/* A generic type is always a reference type */
			index = index + ltype.gt_param;
			gtype [i - 1] = SK_DTYPE;
		} else {
			cecil_id = eifcid (type_string_array [index + pos + i]);
			real_type_id  = gen_type_id (cecil_id);
			switch (cecil_id & SK_HEAD)	{
				case SK_BOOL:
				case SK_CHAR:
				case SK_WCHAR:
				case SK_INT8:
				case SK_INT16:
				case SK_INT32:
				case SK_INT64:
				case SK_FLOAT:
				case SK_DOUBLE:
				case SK_POINTER:
					gtype [i - 1] = cecil_id & SK_HEAD;
					typearr [index + pos + i + 1] = real_type_id;
					break;
				default: 
					gtype [i - 1] = SK_DTYPE;
					typearr [index + pos + i + 1] = eif_find_true_type (real_type_id);
					break;
			}
		}
	}

	/* Warning: This code is taken from the file `cecil.c'. At some point we should maybe
	 * share this into a function, so that we do not need to update it too much, however
	 * for now, we need some changes */

	/* At this point, we have built the generic informations of the type in the
	 * gtype array and gen_param holds the number of generic parameters, so that
	 * we know how much information is significant within the array. Now, we
	 * have to start a linear look-up in the gt_gen array. The number of
	 * instances in the system should be small anyway, so it should not cost too
	 * much time.
	 */

	t = type->gt_gen;
	while (*t != SK_INVALID) {
		/* Fetch the generic meta-types which are forthcomming in the itype
		 * array (inspected type).
		 * Then compare the itype built against the gtype we got. If they match,
		 * we found the type and exit the loop. Otherwise, we continue...
		 */

		matched = 1;						/* Assume a perfect match */
		for (i = 0; i < gen_number; i++) {	/* Built itype for comparaison */
			itype[i] = *t++;
			if (itype[i] != gtype[i])		/* Matching done on the fly */
				matched = 0;				/* The types do not match */
		}
		if (matched) {		/* We found the type */
			t -= gen_number;
			break;			/* End of loop processing */
		}
	}

	/* To compute the index in the gt_type array where we can find the type ID,
	 * we have to count how many items we inspected and divide by the number
	 * of generic parameters. The 't' variable points one location after the
	 * match, hence the '-1' in the formula below.
	 * No it doesn't, the instruction  "t -= gen_number" brings it back
	 * exactly where it should be -- FRED
	 */
	
	if (matched == 1) {
		i = (t - type->gt_gen) / gen_number;
		typearr [pos + 1] = eif_find_true_type  (type->gt_type[i]);	/* The requested generic type ID */
	} else {
			/* The type has not been compiled, i.e. not part of the system and there is
			 * not yet a generic derivation */
		*error = 1;
	}

	eif_free (gtype);
	eif_free (itype);
}

rt_private int16 gen_type_id (int32 cecil_id)
{
			/* We need to find out which basic type it is */
	switch (cecil_id & SK_HEAD) {
	  	case SK_CHAR:   return CHARACTER_TYPE;
	  	case SK_WCHAR:   return WIDE_CHAR_TYPE;
		case SK_BOOL:   return BOOLEAN_TYPE;
		case SK_INT8:    return INTEGER_8_TYPE;
		case SK_INT16:    return INTEGER_16_TYPE;
		case SK_INT32:    return INTEGER_TYPE;
		case SK_INT64:    return INTEGER_64_TYPE;
		case SK_FLOAT:  return REAL_TYPE;
		case SK_DOUBLE: return DOUBLE_TYPE;
		case SK_POINTER: return POINTER_TYPE;
		default:	return (int16) ((uint32) cecil_id & SK_DTYPE);
	}
}
