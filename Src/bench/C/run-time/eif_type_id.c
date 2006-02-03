/*
	description: "Computation of dynamic type corresponding to a written type in a C string."
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

/*
doc:<file name="eif_type_id.c" version="$Id$" summary="Computation of dynamic type corresponding to a written type in a C string">
*/

#include "eif_portable.h"
#include "eif_macros.h"
#include "rt_struct.h"
#include "eif_cecil.h"
#include "rt_gen_types.h"
#include "eif_gen_conf.h"
#include "rt_assert.h"
#include <ctype.h>
#include <string.h>

/*
doc:	<struct name="rt_type">
doc:		<summary>Store a structured description of a dynamic type originally specified in a string.</summary>
doc:	</struct>
*/
struct rt_type {
	char *type_name;
	struct rt_type **generics;
	uint32 count;
	int is_expanded;
	int is_reference;
};

/*
doc:	<struct name="rt_global_data">
doc:		<summary>We could considered this structure as the current object for all the routines that are going to anlayze the `rt_type' structure. It contains the computed `typearr' for generic conformance, as well as its count and the current position for insertion in the `typearr'. It also contains `has_error' which if it is set to `1' will stop any computation and we would return a dynamic type ID of `EIF_NO_TYPE'.</summary>
doc:	</struct>
*/
struct rt_global_data {
	int has_error;
	int16 *typearr;
	uint32 count;
	uint32 position;
};
	
/* Prototypes */
/* String analysis */
rt_private struct rt_type * eif_decompose_type (char *type_string);
rt_private struct rt_type ** eif_decompose_parameters (char *params, uint32 *a_count);
rt_private void eif_free_type_array (struct rt_type *a_type, int free_a_type);
rt_private void eif_remove_surrounding_white_spaces (char *str);
rt_private void set_expanded_or_reference_keyword (struct rt_type *);

/* Dynamic type computation. */
rt_private int is_generic (struct cecil_info *type, struct rt_type *type_entry);
rt_private EIF_TYPE_ID eifcid(struct rt_type *type_entry);
rt_private int32 sk_type (int32 cecil_id);
rt_private EIF_TYPE_ID compute_eif_type_id (struct rt_type *a_type);
rt_private void eif_tuple_type_id (struct rt_type *a_type, struct rt_global_data *data);
rt_private void eif_gen_type_id (struct cecil_info *type, struct rt_type *a_type, struct rt_global_data *data);

/*
doc:	<routine name="eif_type_id" return_type="EIF_TYPE_ID" export="public">
doc:		<summary>Compute dynamic type corresponding to the C string type `type_string'.</summary>
doc:		<param name="type_string" type="char *">Type whose dynamic type we want to find.</param>
doc:		<return>EIF_NO_TYPE if type could not be found, a positive value otherwise.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public EIF_TYPE_ID eif_type_id (char *type_string)
{
	struct rt_type *l_type = NULL;
	EIF_TYPE_ID result;

	if (type_string != NULL) {
			/* Analyze `type_string' and decompose it in type elements. */
		l_type = eif_decompose_type (type_string);

		if (l_type != NULL) {
				/* Decomposition was successful, compute dynamic type. */
			result = compute_eif_type_id (l_type);

				/* Free allocated memory for `l_type'. */
			eif_free_type_array (l_type, 1);
		} else {
			result = EIF_NO_TYPE;
		}
	} else {
			/* Cannot process current string */
		result = EIF_NO_TYPE;
	}
	return result;
}

/*
doc:	<routine name="eif_decompose_type" return_type="struct rt_type *" export="private">
doc:		<summary>Decompose `type_string' in logical elements to represent a type.</summary>
doc:		<param name="type_string" type="char *">Type we will decompose.</param>
doc:		<return>null if `type_string' is not valid or if there is not enough memory for internal allocation, otherwise the corresponding data.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_private struct rt_type * eif_decompose_type (char *type_string)
{
	char *l_class_type_name, *l_type_name;
	char *lsquare;
	struct rt_type *l_type = NULL;
	size_t l_count;

	REQUIRE("type_string_not_null", type_string);

	l_count = strlen(type_string);
		/* Duplicate `type_string', it will be stored in `type_name' field of the result
		 * upon successful decomposition. */
	l_class_type_name = (char *) eif_malloc (sizeof(char) * (l_count + 1));
	if (l_class_type_name) {
		memcpy (l_class_type_name, type_string, l_count + 1);
		eif_remove_surrounding_white_spaces (l_class_type_name);
		l_count = strlen(l_class_type_name);

		if (l_count == 0) {
				/* This is not a valid type name. Free allocated memory so far. */
			eif_free (l_class_type_name);
		} else {
			lsquare = strchr (l_class_type_name, '[');

			if ((lsquare == NULL) || (lsquare && l_class_type_name [l_count - 1] == ']')) {
				l_type = (struct rt_type *) eif_malloc (sizeof(struct rt_type));
				if (l_type == NULL) {
						/* Could not allocate memory. Free what we have allocated so far. */
					eif_free (l_class_type_name);
				} else {
					if (lsquare) {
							/* A generic class. */
						l_type_name = (char *) eif_malloc (sizeof(char) * (lsquare - l_class_type_name + 1));
						if (l_type_name == NULL) {
							eif_free (l_type);
							l_type = NULL;
						} else {
							memcpy(l_type_name, l_class_type_name, lsquare - l_class_type_name);
							l_type_name [lsquare - l_class_type_name] = (char) 0;
							eif_remove_surrounding_white_spaces (l_type_name);
							if (strlen(l_type_name) == 0) {
									/* Not a valid type name. */
								eif_free (l_type_name);
								eif_free (l_type);
								l_type = NULL;
							} else {
								l_type->type_name = l_type_name;
									/* Remove the last `]' from string passed to `eif_decompose_parameters'. */
								l_class_type_name [l_count - 1] = (char) 0;

									/* Recursive part, we need to decompose the actual generic parameters. */
								l_type->generics = eif_decompose_parameters (lsquare + 1, &(l_type->count));
							}
						}
							/* Free allocated `l_class_type_name' as we don't need it anymore. */
						eif_free (l_class_type_name);
					} else {
							/* A non-generic class. */
						l_type->type_name = l_class_type_name;
						l_type->generics = NULL;
						l_type->count = 0;
					}
					if (l_type) {
						set_expanded_or_reference_keyword (l_type);
					}
				}
			}
		}
	}

	return l_type;
}

/*
doc:	<routine name="eif_decompose_parameters" return_type="struct rt_type **" export="private">
doc:		<summary>Decompose `params' in `*a_count' logical elements to represent a type. `params' might be modified during this operation.</summary>
doc:		<param name="params" type="char *">Type we will decompose.</param>
doc:		<param name="a_count" type="uint32 *">Number of items in returned value.</param>
doc:		<return>null if `params' is not valid or if there is not enough memory for internal allocation, otherwise the corresponding data.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_private struct rt_type ** eif_decompose_parameters (char *params, uint32 *a_count)
{
	int l_nesting = 0;
	size_t i, l_count;
	int l_valid = 1, l_first_pos = 0;
	char c;
	char * l_type_name;
	struct rt_type l_type;
	struct rt_type **l_generics = NULL, **l_old_generics = NULL;

	*a_count = 0;
	l_count = strlen (params);

		/* Simple loop which cuts `params' using `,' as separator. We actually do
		 * not check the validity between `,', we will find later when trying to compute
		 * the dynamic type that it is not valid. */
	for (i = 0; (i < l_count) && (l_valid == 1); i++) {
		c = params [i];
		switch (c) {
			case ',':
				if (l_nesting == 0) {
					l_type_name = (char *) eif_malloc (sizeof(char) * (i - l_first_pos + 1));
					if (l_type_name == NULL) {
						l_valid = 0;
					} else {
						memcpy(l_type_name, params + l_first_pos, i - l_first_pos);
						l_type_name [i - l_first_pos] = (char) 0;
						(*a_count)++;
						l_old_generics = l_generics;
						l_generics = (struct rt_type **) eif_realloc (l_old_generics,
								(*a_count) * sizeof (struct rt_type *));
						if (l_generics == NULL) {
							l_valid = 0;
								/* Restore previous pointer so that it can be freed below. */
							l_generics = l_old_generics;
						} else {
							l_generics [(*a_count) - 1] = eif_decompose_type (l_type_name);
							if (l_generics [(*a_count) - 1] == NULL) {
									/* This was not a valid type. */
								l_valid = 0;
							}
							l_first_pos = i + 1;
						}
						eif_free (l_type_name);
					}
				}
				break;
			case '[':
				l_nesting++;
				break;
			case ']':
				l_nesting--;
				l_valid = (l_nesting >= 0 ? 1 : 0);
				break;
			default:
					/* Nothing to do. */
				break;
		}
	}

	if ((l_valid == 1) && (l_nesting == 0)) {
			/* Let's add the final term of the list. */
		l_type_name = (char *) eif_malloc (sizeof(char) * (i - l_first_pos + 1));
		if (l_type_name == NULL) {
			l_valid = 0;
		} else {
			memcpy(l_type_name, params + l_first_pos, i - l_first_pos);
			l_type_name [i - l_first_pos] = (char) 0;
			(*a_count)++;
			l_old_generics = l_generics;
			l_generics = (struct rt_type **) eif_realloc (l_old_generics,
					(*a_count) * sizeof (struct rt_type *));
			if (l_generics == NULL) {
				l_valid = 0;
					/* Restore previous pointer so that it can be freed below. */
				l_generics = l_old_generics;
			} else {
				l_generics [(*a_count) - 1] = eif_decompose_type (l_type_name);
				if (l_generics [(*a_count) - 1] == NULL) {
						/* This was not a valid type. */
					l_valid = 0;
				}
			}
			eif_free (l_type_name);
		}
	}

	if ((l_valid == 0) || (l_nesting != 0)) {
			/* Free what we have allocated so far. For the caller,
			 * it is as if, there were no generics. */
		memset(&l_type, 0, sizeof(struct rt_type));
		l_type.generics = l_generics;
		eif_free_type_array(&l_type, 0);
		*a_count = 0;
		return NULL;
	} else {
		return l_generics;
	}
}

/*
doc:	<routine name="eif_free_type_array" export="private">
doc:		<summary>Free content of `a_type', and `a_type' itself if `free_a_type' is `1'.</summary>
doc:		<param name="a_type" type="struct rt_type *">Type we will free.</param>
doc:		<param name="free_a_type" type="int">Should we also free `a_type'?</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_private void eif_free_type_array (struct rt_type *a_type, int free_a_type)
{
	int i, nb;

	if (a_type) {
		eif_free (a_type->type_name);
		a_type->type_name = NULL;
		if (a_type->generics) {
			for (i = 0, nb = a_type->count; i < nb; i++) {
				eif_free_type_array (a_type->generics [i], 1);
			}
			eif_free (a_type->generics);
			a_type->generics = NULL;
		}
		a_type->count = 0;
		a_type->is_expanded = 0;
		a_type->is_reference = 0;
		if (free_a_type == 1) {
			eif_free (a_type);
		}
	}
}

/*
doc:	<routine name="eif_remove_surrounding_white_spaces" export="private">
doc:		<summary>Remove leading and trailing white spaces of `str'.</summary>
doc:		<param name="str" type="char *">String that will be modified.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_private void eif_remove_surrounding_white_spaces (char * str)
{
	char *s;
	size_t i, length = strlen(str);

		/* Step 1: we remove trailing white spaces. */

		/* Find first non-space character starting from rightmost end */
	for (s = str + length - 1; s >= str; s--) {
		if (!isspace((int) *s)) {
			break;
		}
	}

	if (s >= str) {
		length = s - str + 1;
	} else {
		length = 0;
	}
	str [length] = (char) 0;

	if (length > 0) {
			/* Step 2: we remove all leading white spaces from `str'. */
		s = str;

			/* Find first non-space character starting from leftmost end */
		for (i = 0; i < length; i++, s++) {
			if (!isspace((int) *s)) {
				break;
			}
		}
		
		length -= i;		/* Remove space characters from length */

			/* Shift remaining of string to the left */
		for (s = str, str += i, i = 0;  i < length; i++) {
			*s++ = *str++;
		}

			/* Set new end of string. */
		s [0] = (char) 0;
	}
}

/*
doc:	<routine name="set_expanded_or_reference_keyword" export="private">
doc:		<summary>Check if `type_entry->type_name' contains `reference' or `expanded'. If it does, then it removes it from `type_entry->type_name' and set `is_reference' or `is_expanded' from `type_entry' accordingly..</summary>
doc:		<param name="type_entry" type="struct rt_type *">Type being analyzed.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_private void set_expanded_or_reference_keyword (struct rt_type *type_entry)
{
	char *l_str;
	size_t l_count;

	REQUIRE("Valid type entry", type_entry);
	REQUIRE("Has type name", type_entry->type_name);

	l_str = type_entry->type_name;
	l_count = strlen(l_str);

	if ((l_count >= 8) &&  (strncmp ("expanded", l_str, 8) == 0)) {
		memset(type_entry->type_name, (int) ' ', 8);
		eif_remove_surrounding_white_spaces (type_entry->type_name);
		type_entry->is_expanded = 1;
		type_entry->is_reference = 0;
	} else if ((l_count >= 9) && (strncmp ("reference", l_str, 9) == 0)) {
		memset(type_entry->type_name, (int) ' ', 9);
		eif_remove_surrounding_white_spaces (type_entry->type_name);
		type_entry->is_reference = 1;
		type_entry->is_expanded = 0;
	} else {
		type_entry->is_reference = 0;
		type_entry->is_expanded = 0;
	}
}

/*
doc:	<routine name="cecil_info_for_entry" return_type="struct cecil_info *" export="private">
doc:		<summary>Given a `type_entry' find out its corresponding `cecil_info' data structure.</summary>
doc:		<param name="type_entry" type="struct rt_type *">Type being analyzed.</param>
doc:		<return>null if could not find any type info, otherwise the corresponding data.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_private struct cecil_info *cecil_info_for_entry (struct rt_type *type_entry)
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

/*
doc:	<routine name="is_tuple" return_type="int" export="private">
doc:		<summary>Given a `type_entry' find out if it is a TUPLE type.</summary>
doc:		<param name="type_entry" type="struct rt_type *">Type being analyzed.</param>
doc:		<return>1 if it is a TUPLE, 0 otherwise.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_private int is_tuple (struct rt_type *type_entry)
{
	char *l_str;
	size_t l_count;
	int result;

	REQUIRE("Valid type entry", type_entry);
	REQUIRE("Has type name", type_entry->type_name);

	l_str = type_entry->type_name;
	l_count = strlen(l_str);

	if ((l_count == 5) &&  (strncmp ("TUPLE", l_str, 5) == 0)) {
		result = 1;
	} else {
		result = 0;
	}

	ENSURE("valid_result", (result == 0) || (result == 1));

	return result;
}

/*
doc:	<routine name="is_generic" return_type="int" export="private">
doc:		<summary>Given a `type_entry' find out if it is a generic type.</summary>
doc:		<param name="cecil_type" type="struct cecil_info *">If successful, computed data is stored in `cecil_type'.</param>
doc:		<param name="type_entry" type="struct rt_type *">Type being analyzed.</param>
doc:		<return>1 if it is a generic type and initializes `cecil_type' with the proper info, 0 otherwise.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_private int is_generic (struct cecil_info *cecil_type, struct rt_type *type_entry)
{
	struct cecil_info *l_cecil_type;
	int result;

	REQUIRE("Valid cecil type entry", cecil_type);
	REQUIRE("Valid type entry", type_entry);
	REQUIRE("Has type name", type_entry->type_name);

	l_cecil_type = cecil_info_for_entry (type_entry);
	if (!l_cecil_type) {
			/* We did not find an entry of `class' in the list of
			 * classes, so we should return EIF_NO_TYPE */
		result = 0;
	} else {
			/* We found a class with name `class' so we fill the give
			 * `cecil_type' structures if it is generic. */
		if (l_cecil_type->nb_param > 0) {
			cecil_type->nb_param = l_cecil_type->nb_param;
			cecil_type->patterns = l_cecil_type->patterns;
			cecil_type->dynamic_types = l_cecil_type->dynamic_types;
			result = 1;
		} else {
			result = 0;
		}
	}

	ENSURE("valid_result", (result == 0) || (result == 1));
	ENSURE("generic_implies_not_tuple", (result == 0) ||
		((result == 1) && (is_tuple (type_entry) == 0)));

	return result;
}

/*
doc:	<routine name="eifcid" return_type="EIF_TYPE_ID" export="private">
doc:		<summary>Given a `type_entry' find out its cecil ID.</summary>
doc:		<param name="type_entry" type="struct rt_type *">Type being analyzed.</param>
doc:		<return>Return class ID of `type_entry'. If the class id is not available or the associated type is generic, then EIF_NO_TYPE is returned.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_private EIF_TYPE_ID eifcid(struct rt_type *type_entry)
{
	
	struct cecil_info *value;			/* Pointer to value stored in H table */

	REQUIRE("Valid type entry", type_entry);
	REQUIRE("Has type name", type_entry->type_name);

	value = cecil_info_for_entry (type_entry);
	if (!value) {
			/* Type not found or possibly NONE. */
		if (strcmp(type_entry->type_name, "NONE") == 0) {
			return NONE_TYPE;
		} else {
			return EIF_NO_TYPE;
		}
	} else if (value->nb_param > 0) {
			/* Generic type when we expected a non-generic one. */
		return EIF_NO_TYPE;
	} else {
			/* The associated type ID */
		return value->dynamic_type;
	}
}

/*
doc:	<routine name="compute_eif_type_id" return_type="EIF_TYPE_ID" export="private">
doc:		<summary>Given a `type_entry' find out its associated dynamic type ID.</summary>
doc:		<param name="type_entry" type="struct rt_type *">Type being analyzed.</param>
doc:		<return>If `a_type' is valid and exists in universe, returns its dynamic type id, otherwise EIF_NO_TYPE.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_private EIF_TYPE_ID compute_eif_type_id (struct rt_type *a_type)
{
	struct cecil_info l_cecil_type;
	EIF_TYPE_ID result = 0, l_cecil_id;
	struct rt_global_data sdata, *data;

	REQUIRE("valid type", a_type);

		/* Reset `data'. */
	data = &sdata;
	memset (data, 0, sizeof (struct rt_global_data));

	if (is_generic (&l_cecil_type, a_type) == 1) {
			/* Initial count for `typearr'. */
		sdata.count = 2 + l_cecil_type.nb_param + 1;

			/* Allocate the typearr structures and do the basic
			 * initialization, the first element is set to `-1' since
			 * there is no static call context, the last one too as a terminator
			 * for other generic conformance routines
			 */
		sdata.typearr = (int16 *) eif_malloc (sdata.count * sizeof (int16));
		if (sdata.typearr) {
			sdata.typearr [0] = -1;
			sdata.typearr [sdata.count - 1] = -1;
			sdata.position = 1;

				/* There is a generic type, so we need to analyze the generic parameter
				 * before finding out the real type */
			eif_gen_type_id (&l_cecil_type, a_type, data);
			if (sdata.has_error == 0) {
				result = (EIF_TYPE_ID) eif_compound_id (NULL, (int16) 0,(int16) sdata.typearr[1], sdata.typearr);
			}
			eif_free (sdata.typearr);
		}
	} else if (is_tuple (a_type)) {
			/* Initial count for `typearr'. */
		sdata.count = 2 + TUPLE_OFFSET + a_type->count + 1;

		l_cecil_id = eifcid(a_type);
		if (l_cecil_id == EIF_NO_TYPE) {
				/* Could not find `a_type' in system. Trigger the error. */
			sdata.has_error = 1;	
		} else {
				/* Allocate the typearr structures and do the basic
				 * initialization, the first element is set to `-1' since
				 * there is no static call context, the last one too as a terminator
				 * for other generic conformance routines
				 */
			sdata.typearr = (int16 *) eif_malloc (sdata.count * sizeof (int16));
			if (sdata.typearr) {
				sdata.typearr [0] = -1;
				sdata.typearr [1] = TUPLE_TYPE;
				sdata.typearr [2] = a_type->count;
				sdata.typearr [3] = eif_id_for_typarr ((int16) l_cecil_id);
				sdata.typearr [sdata.count - 1] = -1;
				sdata.position =  1 + TUPLE_OFFSET + 1;

					/* Analyze TUPLE type before finding its real type. */
				eif_tuple_type_id (a_type, data);
				if (sdata.has_error == 0) {
					result = (EIF_TYPE_ID) eif_compound_id (NULL, (int16) 0,(int16) sdata.typearr[1], sdata.typearr);
				}
				eif_free (sdata.typearr);
			}
		}
	} else {
		result = eifcid(a_type);
	}

	if (sdata.has_error == 0) {
		return result;
	} else {
		return EIF_NO_TYPE;
	}
}

/*
doc:	<routine name="eif_tuple_type_id" export="private">
doc:		<summary>Given a `type_entry' corresponding to a TUPLE type, initializes its corresponding typearr in `data'.</summary>
doc:		<param name="type_entry" type="struct rt_type *">Type being analyzed.</param>
doc:		<param name="data" type="struct rt_global_data *">Data to store results of processing.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_private void eif_tuple_type_id (struct rt_type *a_type, struct rt_global_data *data)
{
	int l_generic_count;
	struct cecil_info l_cecil_type;
	struct rt_type *l_type;
	EIF_TYPE_ID l_cecil_id;
	int i;

	REQUIRE("valid type entry", a_type);
	REQUIRE("valid data", data);
	REQUIRE("is_tuple", is_tuple (a_type));
	REQUIRE("typearr big enough", data->position + a_type->count < data->count);

	if (data->has_error == 0) {
		l_generic_count = a_type->count;

		for (i = 0; (i < l_generic_count) && (data->has_error == 0); i++) {
			l_type = a_type->generics [i];

			if (is_generic (&l_cecil_type, l_type) == 1) {
				data->count += l_type->count;
				data->typearr = (int16 *) eif_realloc (data->typearr, data->count * sizeof(int16));
				if (data->typearr == NULL) {
					data->has_error = 1;
				} else {
					data->typearr [data->count - 1] = -1;
					eif_gen_type_id (&l_cecil_type, l_type, data);
				}
			} else if (is_tuple (l_type)) {
				data->count += TUPLE_OFFSET + l_type->count;
				l_cecil_id = eifcid(l_type);
				if (l_cecil_id == EIF_NO_TYPE) {
						/* Could not find type. This is an error. */
					data->has_error = 1;
				} else {
					data->typearr = (int16 *) eif_realloc (data->typearr, data->count * sizeof(int16));
					if (data->typearr == NULL) {
						data->has_error = 1;
					} else {
						data->typearr [data->position] = TUPLE_TYPE;
						data->typearr [data->position + 1] = l_type->count;
						data->typearr [data->position + 2] = eif_id_for_typarr ((int16) l_cecil_id);
						data->typearr [data->count - 1] = -1;
						data->position = data->position + TUPLE_OFFSET + 1;
						eif_tuple_type_id (l_type, data);
					}
				}
			} else {
				l_cecil_id = eifcid(l_type);
				if (l_cecil_id == EIF_NO_TYPE) {
						/* Could not find type. This is an error. */
					data->has_error = 1;
				} else {
					data->typearr [data->position] = eif_id_for_typarr ((int16) l_cecil_id);
					data->position++;
				}
			}
		}
	}
}

/*
doc:	<routine name="eif_gen_type_id" export="private">
doc:		<summary>Given a `type_entry' corresponding to a generic type, initializes its corresponding typearr in `data'.</summary>
doc:		<param name="type_entry" type="struct rt_type *">Type being analyzed.</param>
doc:		<param name="data" type="struct rt_global_data *">Data to store results of processing.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_private void eif_gen_type_id (struct cecil_info *type, struct rt_type *a_type, struct rt_global_data *data)
{
	uint32 i = 0, l_generic_count;
	struct cecil_info l_cecil_type;
	struct rt_type *l_type;
	int32 l_cecil_id;
	int32 *gtype;			/* Generic information for current type */
	int32 *itype;			/* Generic information for inspected type */
	int32 *t;				/* To walk through the patterns array */
	int matched = 0;		/* Did the inspected type matched our entry? */
	int l_original_pos, l_previous_pos;

	REQUIRE("valid cecil type", type);
	REQUIRE("valid type entry", a_type);
	REQUIRE("valid data", data);
	REQUIRE("typearr big enough", data->position + a_type->count < data->count);
	REQUIRE("Not a tuple", is_tuple (a_type) == 0);

	l_generic_count = a_type->count;

	if ((data->has_error == 1) || (type->nb_param != l_generic_count)) {
		/* We already had an error, or requested number of generics is
		 * different from found number of generics. This is a fatal error. */
		data->has_error = 1;
	} else {
			/* Allocate the `gtype' and `itype' array with the corresponding number of generics */
		gtype = (int32 *) eif_malloc (l_generic_count * sizeof (int32));
		itype = (int32 *) eif_malloc (l_generic_count * sizeof (int32));
		if ((gtype == NULL) || (itype == NULL)) {
			data->has_error = 1;
		} else {
			l_original_pos = data->position;
			data->position++;
			for (i = 0; (i < l_generic_count) && (data->has_error == 0); i++) {
				l_type = a_type->generics [i];
				if ((is_generic (&l_cecil_type, l_type) == 1)) {
					data->count += l_type->count;
					data->typearr = (int16 *) eif_realloc (data->typearr, data->count * sizeof(int16));
					if (data->typearr == NULL) {
						data->has_error = 1;
					} else {
						data->typearr [data->count - 1] = -1;
						l_previous_pos = data->position;
						eif_gen_type_id (&l_cecil_type, l_type, data);
							/* Extract from computed type, the associated `SK_xx' value.
							 * We need to do `RTUD' because it is a typarr ID. */
						gtype [i] = sk_type (RTUD(data->typearr [l_previous_pos]));
					}
				} else if (is_tuple (l_type)) {
					data->count += TUPLE_OFFSET + l_type->count;
					data->typearr = (int16 *) eif_realloc (data->typearr, data->count * sizeof(int16));
					if (data->typearr == NULL) {
						data->has_error = 1;
					} else {
						l_cecil_id = eifcid (l_type);
						if (l_cecil_id == EIF_NO_TYPE) {
								/* Could not find type. This is an error. */
							data->has_error = 1;
						} else {
							gtype [i] = sk_type (l_cecil_id);
							CHECK("valid type id", (l_cecil_id & SK_DTYPE) == l_cecil_id);

							data->typearr [data->position] = TUPLE_TYPE;
							data->typearr [data->position + 1] = l_type->count;
							data->typearr [data->position + 2] = eif_id_for_typarr ((int16) l_cecil_id);
							data->typearr [data->count - 1] = -1;
							data->position = data->position + TUPLE_OFFSET + 1;
							eif_tuple_type_id (l_type, data);
						}
					}
				} else {
					l_cecil_id = eifcid (l_type);
					if (l_cecil_id == EIF_NO_TYPE) {
							/* Could not find type. This is an error. */
						data->has_error = 1;
					} else {
						gtype [i]  = sk_type (l_cecil_id);
						CHECK("valid type id", (l_cecil_id & SK_DTYPE) == l_cecil_id);
						data->typearr [data->position] = eif_id_for_typarr ((int16) l_cecil_id);
						data->position++;
					}
				}
			}

			if (data->has_error == 0) {
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
					for (i = 0; i < l_generic_count; i++) {	/* Built itype for comparaison */
						itype[i] = *t++;
						if (itype[i] != gtype[i])		/* Matching done on the fly */
							matched = 0;				/* The types do not match */
					}
					if (matched) {		/* We found the type */
						t -= l_generic_count;
						break;			/* End of loop processing */
					}
				}

				/* To compute the index in the dynamic_types array where we can find the type ID,
				 * we have to count how many items we inspected and divide by the number
				 * of generic parameters. The 't' variable points one location after the
				 * match, hence the '-1' in the formula below.
				 * No it doesn't, the instruction  "t -= l_generic_count" brings it back
				 * exactly where it should be -- FRED
				 */
				
				if (matched == 1) {
					CHECK("not too big", (t - type->patterns) <= 0x7FFFFFFF);
					i = (uint32) (t - type->patterns) / l_generic_count;
						/* The requested generic type ID */
					data->typearr [l_original_pos] = eif_id_for_typarr (type->dynamic_types[i]);
				} else {
						/* The type has not been compiled, i.e. not part of the system and there is
						 * not yet a generic derivation */
					data->has_error = 1;
				}
			}

			eif_free (gtype);
			eif_free (itype);
		}
	}
}

/*
doc:	<routine name="sk_type" return_type="int" export="private">
doc:		<summary>Given a cecil ID, returns the corresponding SK_XX abstract type.</summary>
doc:		<param name="cecil_id" type="int32">cecil ID.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_private int32 sk_type (int32 cecil_id)
{
	if (cecil_id == egc_char_dtype) {
		return SK_CHAR;
	} else if (cecil_id == egc_wchar_dtype) {
		return SK_WCHAR;
	} else if (cecil_id == egc_bool_dtype) {
		return SK_BOOL;
	} else if (cecil_id == egc_uint8_dtype) {
		return SK_UINT8;
	} else if (cecil_id == egc_uint16_dtype) {
		return SK_UINT16;
	} else if (cecil_id == egc_uint32_dtype) {
		return SK_UINT32;
	} else if (cecil_id == egc_uint64_dtype) {
		return SK_UINT64;
	} else if (cecil_id == egc_int8_dtype) {
		return SK_INT8;
	} else if (cecil_id == egc_int16_dtype) {
		return SK_INT16;
	} else if (cecil_id == egc_int32_dtype) {
		return SK_INT32;
	} else if (cecil_id == egc_int64_dtype) {
		return SK_INT64;
	} else if (cecil_id == egc_real32_dtype) {
		return SK_REAL32;
	} else if (cecil_id == egc_real64_dtype) {
		return SK_REAL64;
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
