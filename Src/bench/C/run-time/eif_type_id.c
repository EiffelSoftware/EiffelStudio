/*
doc:<file name="eif_type_id.c" version="$Id$" summary="Computation of dynamic type corresponding to a written type in a C string">
*/

#include "eif_portable.h"
#include "eif_macros.h"
#include "rt_struct.h"
#include "eif_gen_conf.h"
#include "eif_cecil.h"
#include "rt_lmalloc.h"
#include "eif_threads.h"
#include "rt_gen_types.h"
#include "rt_gen_conf.h"
#include "rt_assert.h"
#include <ctype.h>
#include <string.h>


/* Prototypes */
rt_private int is_good (char c);
rt_private int is_type_separator (char c);
rt_private int is_expanded_or_reference_keyword (char *str, int count, struct type_array_element *);
rt_private int is_generic (struct cecil_info *type, struct type_array_element *type_entry);
rt_private EIF_TYPE_ID eifcid(struct type_array_element *type_entry);
rt_private int32 sk_type (int32 cecil_id);
rt_private EIF_TYPE_ID compute_eif_type_id (int n, struct type_array_element *type_array);
rt_private void eif_type_id_ex (int *error, struct cecil_info *type, int gen_number,
		struct type_array_element *type_array, int16* typearr, int pos, int length);

struct type_array_element {
	char *type_name;
	int is_expanded;
	int is_reference;
};

/*------------------------------------------------------------------*/
/* Compute the dynamic type corresponding to the C string type      */
/* `type_string'                                                    */
/*------------------------------------------------------------------*/
rt_public EIF_TYPE_ID eif_type_id (char *type_string)
{
	struct type_array_element *type_array = NULL;
	char *string_type = NULL;
	char c = (char) 0;
	int i = 0;
	int state = 1, substate = 0;
	int n = 0;	/* Number of elements in an the C generated array */
	int l = 0;	/* length of the currently analyzed string */
	EIF_TYPE_ID result; /* Computed `type_id' */

	if (type_string == NULL)
			/* Cannot process current string */
		return EIF_NO_TYPE;

		/* Cut the string and put each part in an array */
	while ((c = type_string [i]) != (char) 0) {
		if (is_good(c)) {
			l++;
			state = 0;
		}
		if (state == 0 && is_type_separator (c)) {
				/* When encountering `expanded' or `reference' we might do a useless reallocation
				 * but that's not too bad. */
			type_array = (struct type_array_element *)
				eif_realloc (type_array, (n + 1) * sizeof (struct type_array_element));
			if (type_array == NULL) {
				enomem();
			}

				/* If we encounter the `expanded' or `reference' prefix then we mark
				 * `type_array [n]' accordingly. We cannot encounter it more than once though.*/
			if
				((substate != 1) &&
				(is_expanded_or_reference_keyword (type_string + i - l, l, &type_array [n])))
			{
					/* We store the expanded/reference info, so we can reset `l' to just analyze
					 * the type. */
				l = 0;
				substate = 1;
			} else {
				state = 1;
				string_type = (char *) eif_malloc ((l + 1) * sizeof (char));
				if (string_type == NULL) {
					enomem();
				}
				string_type = (char *) memcpy (string_type, type_string + i - l, l);
				string_type [l] = (char) 0;
				type_array [n].type_name = string_type;
				n++;
				l = 0;
				substate = 0;
			}
		}
		i++;
	}

	if (type_array == NULL) {
			/* There was only a simple type, not a generic one. */
		type_array = (struct type_array_element *) eif_malloc (sizeof (struct type_array_element));
		if (type_array == NULL) {
			enomem();
		}
		string_type = (char *) eif_malloc ((l + 1) * sizeof (char));
		if (string_type == NULL) {
			enomem();
		}
		string_type = (char *) memcpy (string_type, type_string + i - l, l);
		string_type [l] = (char) 0;
		type_array [0].type_name = string_type;
		n = 1;
	}
	result = compute_eif_type_id (n, type_array);

		/* Free all the allocated memory */
	for (i=0; i <= n - 1; i++) {
		string_type = type_array [i].type_name;
		eif_free (string_type);
	}
	eif_free (type_array);

	return result;
}

rt_private int is_good (char c)
{
	return isalpha ((int) c) || isdigit ((int) c) || (c == '_');
}

rt_private int is_type_separator (char c)
{
	return ((c == '[') || (c == ']') || (c == ',') || (c == ' '));
}

rt_private int is_expanded_or_reference_keyword (char *str, int count, struct type_array_element *entry)
{
	int result;

	if ((count == 8) &&  (strncmp ("expanded", str, count) == 0)) {
		entry->is_expanded = 1;
		entry->is_reference = 0;
		result = 1;
	} else if ((count == 9) && (strncmp ("reference", str, count) == 0)) {
		entry->is_reference = 1;
		entry->is_expanded = 0;
		result = 1;
	} else {
		entry->is_reference = 0;
		entry->is_expanded = 0;
		result = 0;
	}

	return result;
}

rt_private struct cecil_info *cecil_info_for_entry (struct type_array_element *type_entry)
{
	struct cecil_info *result = NULL;

	REQUIRE("Valid type entry", type_entry);
	REQUIRE("Has type name", type_entry->type_name);

	if (type_entry->is_expanded) {
			/* Lookup in CECIL expanded table. */
		result = (struct cecil_info *) ct_value (&egc_ce_exp_type, type_entry->type_name);
	} else if (type_entry->is_reference) {
			/* Lookup in CECIL non-expanded table. */
		result = (struct cecil_info *) ct_value (&egc_ce_type, type_entry->type_name);
	} else {
			/* Lookup first in CECIL non-expanded table. */
		result = (struct cecil_info *) ct_value(&egc_ce_type, type_entry->type_name);
		if (!result) {
				/* It was not found in the non-expanded table, hopefully it is in
				 * the expanded table. */
			result = (struct cecil_info *) ct_value (&egc_ce_exp_type, type_entry->type_name);
		} else {
				/* We found the type in the non-expanded classes table. Let's check
				 * that indeed it is not declared as an expanded class. */
			if (EIF_IS_TYPE_DECLARED_AS_EXPANDED(System(result->dynamic_type))) {
					/* The class is an expanded class therefore we need to look into the
					 * expanded table to find what we are looking for. */
				result = (struct cecil_info *) ct_value (&egc_ce_exp_type, type_entry->type_name);
			}
		}
	}
	return result;
}

rt_private int is_generic (struct cecil_info *type, struct type_array_element *type_entry)
{
	struct cecil_info *ltype;

	REQUIRE("Valid type entry", type_entry);
	REQUIRE("Has type name", type_entry->type_name);

	ltype = cecil_info_for_entry (type_entry);
	if (!ltype) {
			/* We did not find an entry of `class' in the list of
			 * classes, so we should return EIF_NO_TYPE */
		return EIF_NO_TYPE;
	} else {
			/* We found a class with name `class' so we fill the give
			 * `type' structures if it is generic. */
		if (ltype->nb_param > 0) {
			type->nb_param = ltype->nb_param;
			type->patterns = ltype->patterns;
			type->dynamic_types = ltype->dynamic_types;
			return 1;
		} else {
			return EIF_NO_TYPE;
		}
	}
}

rt_private EIF_TYPE_ID eifcid(struct type_array_element *type_entry)
{
	/* Return class ID of `type_entry'. If the class id is not available or
	 * the associated type is generic, then EIF_NO_TYPE is returned.
	 */
	
	struct cecil_info *value;			/* Pointer to value stored in H table */

	REQUIRE("Valid type entry", type_entry);
	REQUIRE("Has type name", type_entry->type_name);

	value = cecil_info_for_entry (type_entry);
	if ((!value) || (value->nb_param > 0)) {
			/* Type not found or generic type. */
		return EIF_NO_TYPE;
	} else {
			/* The associated type ID */
		return value->dynamic_type;
	}
}

rt_private EIF_TYPE_ID compute_eif_type_id (int n, struct type_array_element *type_array)
{
	struct cecil_info type;
	EIF_TYPE_ID result = 0;
	int error = 0;

	if (is_generic (&type, &type_array[0]) > 0) {
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
		eif_type_id_ex (&error, &type, type.nb_param, type_array, typearr, 0, n);
		if (error == 0) {
			result = (EIF_TYPE_ID) eif_compound_id ((int16 *)0, (int16) 0,(int16) typearr[1], typearr);
		}
		eif_free (typearr);
	} else
		result = eifcid(&type_array [0]);

	if (error == 0) {
		return result;
	} else {
		return EIF_NO_TYPE;
	}
}

rt_private void eif_type_id_ex (int *error, struct cecil_info *type, int gen_number,
		struct type_array_element *type_array, int16* typearr, int pos, int length)
{
	int i = 0;
	struct cecil_info ltype;
	int32 cecil_id;
	int32 *gtype;			/* Generic information for current type */
	int32 *itype;			/* Generic information for inspected type */
	int32 *t;				/* To walk through the patterns array */
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
		if (is_generic (&ltype, &type_array [index + pos + i]) > 0) {
			eif_type_id_ex (error, &ltype, ltype.nb_param,
					type_array, typearr, index + pos + i, length);
				/* Extract from computed type, the associated `SK_xx' value.
				 * We need to do `RTUD' because it is a typarr ID. */
			gtype [i - 1] = sk_type (RTUD(typearr [index + pos + i + 1]));
			index = index + ltype.nb_param;
		} else {
			cecil_id = eifcid (&type_array [index + pos + i]);
			gtype [i - 1]  = sk_type (cecil_id);
			CHECK("valid type id", (cecil_id & SK_DTYPE) == cecil_id);
			typearr [index + pos + i + 1] = eif_id_for_typarr ((int16) cecil_id);
		}
	}

	/* Warning: This code is taken from the file `cecil.c'. At some point we should maybe
	 * share this into a function, so that we do not need to update it too much, however
	 * for now, we need some changes */

	/* At this point, we have built the generic informations of the type in the
	 * gtype array and gen_param holds the number of generic parameters, so that
	 * we know how much information is significant within the array. Now, we
	 * have to start a linear look-up in the patterns array. The number of
	 * instances in the system should be small anyway, so it should not cost too
	 * much time.
	 */

	t = type->patterns;
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

	/* To compute the index in the dynamic_types array where we can find the type ID,
	 * we have to count how many items we inspected and divide by the number
	 * of generic parameters. The 't' variable points one location after the
	 * match, hence the '-1' in the formula below.
	 * No it doesn't, the instruction  "t -= gen_number" brings it back
	 * exactly where it should be -- FRED
	 */
	
	if (matched == 1) {
		i = (t - type->patterns) / gen_number;
		typearr [pos + 1] = eif_id_for_typarr (type->dynamic_types[i]);	/* The requested generic type ID */
	} else {
			/* The type has not been compiled, i.e. not part of the system and there is
			 * not yet a generic derivation */
		*error = 1;
	}

	eif_free (gtype);
	eif_free (itype);
}

rt_private int32 sk_type (int32 cecil_id)
{
	if (cecil_id == egc_char_dtype) {
		return SK_CHAR;
	} else if (cecil_id == egc_wchar_dtype) {
		return SK_WCHAR;
	} else if (cecil_id == egc_bool_dtype) {
		return SK_BOOL;
	} else if (cecil_id == egc_int8_dtype) {
		return SK_INT8;
	} else if (cecil_id == egc_int16_dtype) {
		return SK_INT16;
	} else if (cecil_id == egc_int32_dtype) {
		return SK_INT32;
	} else if (cecil_id == egc_int64_dtype) {
		return SK_INT64;
	} else if (cecil_id == egc_real_dtype) {
		return SK_FLOAT;
	} else if (cecil_id == egc_doub_dtype) {
		return SK_DOUBLE;
	} else if (cecil_id == egc_point_dtype) {
		return SK_POINTER;
	} else {
		if (EIF_IS_EXPANDED_TYPE(System(cecil_id))) {
			return SK_EXP | cecil_id;
		} else {
			return SK_REF;
		}
	}
}

/*
doc:</file>
*/
