/*
	description: "C-Eiffel Call-In Library."
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
doc:<file name="cecil.c" header="eif_cecil.h" version="$Id$" summary="C-Eiffel Call-In Library">
*/

#include "eif_portable.h"
#include "rt_malloc.h"
#include "eif_garcol.h"
#include "rt_cecil.h"
#include "eif_hector.h"
#include "rt_struct.h"
#include "rt_tools.h"
#include "eif_eiffel.h"				/* Need string header */
#include "rt_macros.h"
#include "rt_lmalloc.h"
#include "eif_project.h"
#include "rt_except.h"
#include "rt_threads.h"
#include "rt_gen_types.h"
#include "rt_assert.h"
#include <string.h>
#ifdef I_STDARG
#include <stdarg.h>
#else
#ifdef I_VARARGS
#include <varargs.h>
#endif
#endif
#include "rt_globals_access.h"

/*
doc:	<attribute name="eif_visible_is_off" return_type="char" export="public">
doc:		<summary>If set to True, we will not throw an exception if feature cannot be found or is not visible.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe as access is done through `eif_cecil_mutex'.</thread_safety>
doc:		<synchronization>eif_cecil_mutex</synchronization>
doc:	</attribute>
*/
rt_public unsigned char eif_visible_is_off = (unsigned char) 1;

/*
doc:	<attribute name="eif_default_pointer" return_type="void *" export="private">
doc:		<summary>Return value when `eif_field_safe' fails.</summary>
doc:		<access>Read</access>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/
rt_private void *eif_default_pointer = NULL;

/*
 * Cecil mutex in MT mode.
 */
#ifdef EIF_THREADS
/*
doc:	<attribute name="eif_cecil_mutex" return_type="EIF_CS_TYPE *" export="shared">
doc:		<summary>To protect multithreaded access to `eif_visible_is_off'.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/
rt_shared EIF_CS_TYPE *eif_cecil_mutex = (EIF_CS_TYPE *) 0;

rt_shared void eif_cecil_init (void);
#define EIF_CECIL_LOCK		EIF_ASYNC_SAFE_CS_LOCK(eif_cecil_mutex)
#define EIF_CECIL_UNLOCK	EIF_ASYNC_SAFE_CS_UNLOCK(eif_cecil_mutex)

#else	/* EIF_THREADS */

#define EIF_CECIL_LOCK
#define EIF_CECIL_UNLOCK

#endif	/* EIF_THREADS */

/* Function declarations */
rt_private EIF_TYPE_INDEX cid_to_dftype(EIF_TYPE_ID cid);		/* Converts a class ID into a dynamic type */
rt_private int locate(EIF_REFERENCE object, char *name);			/* Locate attribute by name in skeleton */
rt_public int eiflocate (EIF_OBJECT object, char *name);

/*
 * `visible' exception handling
 */

rt_public void eifvisex (void) {
	/* Enable the visible exception */

	RT_GET_CONTEXT
#ifdef EIF_THREADS
	REQUIRE ("Cecil mutex created", eif_cecil_mutex);
#endif
	EIF_CECIL_LOCK;
	eif_visible_is_off = (unsigned char) 0;
	EIF_CECIL_UNLOCK;
}

rt_public void eifuvisex (void) {
	/* Disable visible exception */

	RT_GET_CONTEXT
#ifdef EIF_THREADS
	REQUIRE ("Cecil mutex created", eif_cecil_mutex);
#endif
	EIF_CECIL_LOCK;
	eif_visible_is_off = (unsigned char) 1;
	EIF_CECIL_UNLOCK;
}

/*
 * Type checking
 */

rt_public int eifattrtype (char *attr_name, EIF_TYPE_ID cid) {
	/* Return type of `routine' defined in class of type `cid' */

	const struct cnode *sk;	/* Skeleton entry in system */
	const char **n;	/* Pointer in cn_names array */
	int nb_attr;	/* Number of attributes */
	int i;
	uint32 field_type;	/* for scanning type */
	int l_result = EIF_NO_TYPE;

	REQUIRE("attr_name not null", attr_name);

	if (cid == EIF_NO_TYPE) {
		eif_panic ("Unknown dynamic type\n");	/* Check if dynamic exists */
	} else {
		sk = &System(To_dtype(cid_to_dftype(cid)));	/* Fetch skeleton entry */
		nb_attr = sk->cn_nbattr;	/* Number of attributes */


		for (i = 0, n = sk->cn_names; i < nb_attr; i++, n++)
			if (0 == strcmp(attr_name, *n))
				break;	/* Attribute was found */

		if (i < nb_attr) {
				/* Attribute found */

			field_type = sk->cn_types[i];
			switch (field_type & SK_HEAD) {
				case SK_REF: l_result = EIF_REFERENCE_TYPE;
				case SK_CHAR8: l_result = EIF_CHARACTER_8_TYPE;
				case SK_CHAR32: l_result = EIF_CHARACTER_32_TYPE;
				case SK_BOOL: l_result = EIF_BOOLEAN_TYPE;
				case SK_UINT8: l_result = EIF_NATURAL_8_TYPE;
				case SK_UINT16: l_result = EIF_NATURAL_16_TYPE;
				case SK_UINT32: l_result = EIF_NATURAL_32_TYPE;
				case SK_UINT64: l_result = EIF_NATURAL_64_TYPE;
				case SK_INT8: l_result = EIF_INTEGER_8_TYPE;
				case SK_INT16: l_result = EIF_INTEGER_16_TYPE;
				case SK_INT32: l_result = EIF_INTEGER_32_TYPE;
				case SK_INT64: l_result = EIF_INTEGER_64_TYPE;
				case SK_REAL32: l_result = EIF_REAL_32_TYPE;
				case SK_REAL64: l_result = EIF_REAL_64_TYPE;
				case SK_EXP: l_result = EIF_EXPANDED_TYPE;
				case SK_POINTER: l_result = EIF_POINTER_TYPE;
			}
		}
	}
	return l_result;
}

/*
doc:	<routine name="eif_dtype_to_sk_type" return_type="uint32" export="shared">
doc:		<summary>Given a cecil ID, returns the corresponding SK_XX abstract type.</summary>
doc:		<param name="dtype" type="EIF_TYPE_INDEX">cecil ID.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_shared uint32 eif_dtype_to_sk_type (EIF_TYPE_INDEX dtype)
{
	if (dtype == egc_char_dtype) {
		return SK_CHAR8;
	} else if (dtype == egc_wchar_dtype) {
		return SK_CHAR32;
	} else if (dtype == egc_bool_dtype) {
		return SK_BOOL;
	} else if (dtype == egc_uint8_dtype) {
		return SK_UINT8;
	} else if (dtype == egc_uint16_dtype) {
		return SK_UINT16;
	} else if (dtype == egc_uint32_dtype) {
		return SK_UINT32;
	} else if (dtype == egc_uint64_dtype) {
		return SK_UINT64;
	} else if (dtype == egc_int8_dtype) {
		return SK_INT8;
	} else if (dtype == egc_int16_dtype) {
		return SK_INT16;
	} else if (dtype == egc_int32_dtype) {
		return SK_INT32;
	} else if (dtype == egc_int64_dtype) {
		return SK_INT64;
	} else if (dtype == egc_real32_dtype) {
		return SK_REAL32;
	} else if (dtype == egc_real64_dtype) {
		return SK_REAL64;
	} else if (dtype == egc_point_dtype) {
		return SK_POINTER;
	} else {
		if (EIF_IS_EXPANDED_TYPE(System(dtype))) {
			return SK_EXP | dtype;
		} else {
			return SK_REF;
		}
	}
}

/*
doc:	<routine name="eif_sk_type_to_dtype" return_type="EIF_TYPE_INDEX" export="shared">
doc:		<summary>Given a SK_XXX abstract type, returns the corresponding CECIL ID.</summary>
doc:		<param name="sk_type" type="uint32">SK_XX type.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_shared EIF_TYPE_INDEX eif_sk_type_to_dtype (uint32 sk_type)
{
	switch (sk_type & SK_HEAD) {
		case SK_CHAR8: return egc_char_dtype;
		case SK_CHAR32: return egc_wchar_dtype;
		case SK_BOOL: return egc_bool_dtype;
		case SK_UINT8: return egc_uint8_dtype;
		case SK_UINT16: return egc_uint16_dtype;
		case SK_UINT32: return egc_uint32_dtype;
		case SK_UINT64: return egc_uint64_dtype;
		case SK_INT8: return egc_int8_dtype;
		case SK_INT16: return egc_int16_dtype;
		case SK_INT32: return egc_int32_dtype;
		case SK_INT64: return egc_int64_dtype;
		case SK_REAL32: return egc_real32_dtype;
		case SK_REAL64: return egc_real64_dtype;
		case SK_POINTER: return egc_point_dtype;
		case SK_REF:
		case SK_EXP:
			return (EIF_TYPE_INDEX) (sk_type & SK_DTYPE);
		default:
			return 0;
	}
}

/*
 * Object creation
 */

rt_public EIF_OBJECT eifcreate(EIF_TYPE_ID cid)
{
	/* Create an instance of class 'cid', but does not call any creation
	 * routine. Return the address in the indirection table (access to the
	 * real object done via a macro (objects are moving). Exceptions will
	 * occur if the object cannot be created for some reason.
	 */

	EIF_REFERENCE object;					/* Eiffel object's physical address */
	EIF_TYPE_INDEX dtype;						/* Dynamic type associated with class ID */

	dtype = cid_to_dftype(cid);		/* Convert class ID to dynamic type */
	if (dtype == INVALID_DTYPE)/* Was not a valid reference type */
		return (EIF_OBJECT) 0;			/* No creation, return null pointer */

	object = emalloc(dtype);		/* Create object */

	return eif_protect(object);			/* Return the indirection pointer */
}

/*
 * Function pointers handling
 */

rt_public EIF_REFERENCE_FUNCTION eifref(char *routine, EIF_TYPE_ID cid)
{
	/* Look for the routine named 'routine' in the type 'cid'.
	 * Return a pointer to the routine if found, or the
	 * null pointer if the routine does not exist.
	 */

	EIF_TYPE_INDEX dtype = To_dtype(cid_to_dftype(cid));		/* Compute dynamic type from class ID */
	const struct ctable *ptr_table;			/* H table holding function pointers */
	EIF_REFERENCE_FUNCTION *ref;

	if (cid == EIF_NO_TYPE)	/* No type id */
		return (EIF_REFERENCE_FUNCTION) 0;

	ptr_table = &Cecil(dtype);			/* Get associated H table */

	ref = (EIF_REFERENCE_FUNCTION *) ct_value(ptr_table, routine);	/* Code location */
		/* If function is not found and visible exceptions are enabled, raise an exception. */
	if (!ref) {
		if (!eif_visible_is_off) {
			eraise ("Unknown routine (visible?)", EN_PROG);
		}
		return NULL;
	} else {
		return *ref;	/* Return address of function. */
	}
}

/*
 * Class ID versus dynamic type
 */

rt_public EIF_TYPE_ID eif_type_by_reference (EIF_REFERENCE object)
{
	/* Return type id of the direct reference "object" */
	return Dftype (object);
}

rt_public EIF_TYPE_ID eiftype(EIF_OBJECT object)
{
	/* Obsolete. Use "eif_type_by_reference" instead.
	 * Return the Type id of the specified object.
 	 */

	return Dftype(eif_access(object));
}

rt_public const char *eifname(EIF_TYPE_ID cid)
{
	/* Return the name of the class whose ID is cid. It is a pointer to
	 * static data. For generic types, only the base name of the class
	 * is returned.
	 */


	EIF_TYPE_INDEX dtype = To_dtype(cid_to_dftype(cid));		/* Convert to dynamic type */

	if ((dtype == INVALID_DTYPE) || (cid == EIF_NO_TYPE))						/* Not a reference type */
		return (char *) 0;

	return System(dtype).cn_generator;	/* Pointer to static data */
}

rt_private EIF_TYPE_INDEX cid_to_dftype(EIF_TYPE_ID cid)
{
	/* Converts a class ID to a dynamic type. Returns -1 if the class ID is not
	 * that of a reference type. Expanded types are ignored, of course, for the
	 * purpose of dynamic type computation.
	 */

	if ((uint32) cid & SK_SIMPLE)		/* Type is a simple type */
		return INVALID_DTYPE;						/* No valid dynamic type */

	return (EIF_TYPE_INDEX) (cid & SK_DTYPE);		/* Return the dynamic type part */
}

/*
 * Field access (attributes)
 */


rt_public void *eif_field_safe (EIF_REFERENCE object, char *name, int type_int, int * const ret)
{
	/* Like eif_attribute, but perform a type checking between the type
	 * given by "type_int" and the actual type of the attribute.
	 * Return EIF_WRONG_TYPE, if this fails.
	 * Should be preceded by *(EIF_TYPE*).
	 */

	void *addr;
	int tid;

	addr = eifaddr (object, name, ret);

	if (*ret != EIF_CECIL_OK)	/* Was "eifaddr" successfull? */
		return addr;	/* Return "addr" with error code in "ret". */

	tid = eif_type_by_reference (object);	/* Get type id for "eif_attribute_type" */
	if (tid == EIF_NO_TYPE)	/* No type id? */
		eif_panic ("Object has no type id.");/* Should not happen. */

	if (eif_attribute_type (name, tid) != type_int)	/* Do types match. */
	{
		*ret = EIF_WRONG_TYPE;	/* Wrong type. */
		return &eif_default_pointer;
	}

	return addr;	/* Return "addr" anyway. */


} 	/* eif_field_safe */


rt_public EIF_INTEGER eifaddr_offset(EIF_REFERENCE object, char *name, int * const ret)
{
	/*
	 * Returns the physical address of the attribute named 'name' in the given
	 * object (note that the address of the object is expected -- we do not
	 * want an Hector indirection pointer).
	 * If it fails, "*ret" is EIF_NO_ATTRIBUTE, EIF_CECIL_OK, otherwise.
	 * (was necessary was getting value of basic types failed).
	 */
	int i;							/* Index in skeleton */
#ifdef WORKBENCH
	int32 rout_id;					/* Attribute routine id */
	EIF_TYPE_INDEX dtype;			/* Object dynamic type */
	long offset;
#endif

	i = locate(object, name);		/* Locate attribute in skeleton */
	if (i == EIF_NO_ATTRIBUTE) {					/* Attribute not found */
		if (!eif_visible_is_off)
			eraise ("Unknown attribute", EN_PROG);
		if (ret != NULL)
			*ret = EIF_NO_ATTRIBUTE;	/* Set "*ret" */
		return -1;
	}

	if (ret != NULL)
		*ret = EIF_CECIL_OK; 	/* Set "*ret" for successfull return. */
#ifndef WORKBENCH
	return (System(Dtype(object)).cn_offsets[i]);
#else
	dtype = Dtype(object);
	rout_id = System(dtype).cn_attr[i];
	CAttrOffs(offset,rout_id,dtype);

	return offset;
#endif
}

rt_public int eiflocate (EIF_OBJECT object, char *name) {
	/* Return the index of attribute `name' in EIF_OBJECT `object' */

	return locate (eif_access (object), name);
}

rt_private int locate(EIF_REFERENCE object, char *name)
{
	/* Locate the attribute 'name' in the specified object and return the index
	 * in the cn_offsets array, or EIF_NO_ATTRIBUTE if there is no such attribute.
	 */

	const struct cnode *sk;				/* Skeleton entry in system */
	const char **n;						/* Pointer in cn_names array */
	int nb_attr;					/* Number of attributes */
	int i;

	if (object == (char *) 0)		/* Null pointer */
		return EIF_NO_ATTRIBUTE;					/* Differ the bus error */

	sk = &System(Dtype(object));	/* Fetch skeleton entry */
	nb_attr = sk->cn_nbattr;		/* Number of attributes */

	/* The lookup to find the attribute is done in a linear way. This makes the
	 * access to an attribute slower, by comparaison with a routine call. It is
	 * however possible to bypass Cecil if the object location does not move,
	 * by calling eifaddr() directly and storing the address somewhere. Then
	 * use the C de-referencing mechanism (non-portable accross Eiffel compilers
	 * of course, as ETL does not mention eifaddr)--RAM.
	 */

	for (i = 0, n = sk->cn_names; i < nb_attr; i++, n++)
		if (0 == strcmp(name, *n))
			break;					/* Attribute was found */

	if (i == nb_attr)				/* Attribute not found */
		return EIF_NO_ATTRIBUTE;					/* Will certainly raise a bus error */

	return i;			/* Index in the attribute array */
}

	/* Obsolete */

rt_public void *old_eifaddr(EIF_REFERENCE object, char *name)
{
	/* Old "eif_addr" with previous signature. This function has been
	 * added for compatibility purpose.
	 */

	int ret;
	return eifaddr (object, name, &ret);
}	/* old_eifaddr */

/*
 * Hash table handling
 */

rt_shared char *ct_value(const struct ctable *ct, const char *key)
{
	/* Look for item associated with given key and returns a pointer to its
	 * location in the value array. Return a null pointer if item is not found.
	 */

	long pos;		/* Position in H table */
	int32 hsize;		/* Size of H table */
	char **hkeys;		/* Array of keys */

	int32 tryv = (int32) 0;	/* Count number of attempts */
	long inc;		/* Loop increment */

	/* Initializations */
	hsize = ct->h_size;
	hkeys = ct->h_keys;

	if (hsize == 0)
		return (char *) 0;			/* Item was not found */

	/* Jump from one hashed position to another until we find the value or
	 * go to an empty entry or reached the end of the table.
	 */
	inc = hashcode(key, (long) strlen(key));
	for (
		pos = inc % hsize, inc = 1 + (inc % (hsize - 1));
		tryv < hsize;
		tryv++, pos = (pos + inc) % hsize
	) {
		if (hkeys[pos] == (char *) 0)
			break;
		else if (0 == strcmp(hkeys[pos], key))
			return ct->h_values + (pos * ct->h_sval);
	}

	return (char *) 0;			/* Item was not found */
}

/*
doc:</file>
*/
