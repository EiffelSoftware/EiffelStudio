/*

 ######   ####   #    #    ##    #                ####
 #       #    #  #    #   #  #   #               #    #
 #####   #    #  #    #  #    #  #               #
 #       #  # #  #    #  ######  #        ###    #
 #       #   #   #    #  #    #  #        ###    #    #
 ######   ### #   ####   #    #  ######   ###     ####

		Equality C externals
*/

#include "eif_portable.h"
#include "eif_eiffel.h"			/* For standard macros */
#include "eif_equal.h"			/* For Eiffel boolean */
#include "eif_struct.h"			/* For skeleton structure */
#include "eif_traverse.h"		/* For traversing objects */
#include "x2c.h"			/* For macro LNGPAD */
#include "eif_tools.h"			/* For `nprime' */
#include "eif_search.h"
#include "eif_plug.h"			/* for econfg */
#include "rt_garcol.h"
#include "rt_wbench.h"
#include "eif_memory.h"
#include <string.h>

#define dprintf(n) if (DEBUG & n) printf

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

rt_private struct s_table *table;		/* Search table for deep equal */

/*
 * Routines declarations
 */

rt_private EIF_BOOLEAN e_field_equal(register EIF_REFERENCE target, register EIF_REFERENCE source, int16 dtype);		/* Field-by-field equality */
rt_private EIF_BOOLEAN e_field_iso(register EIF_REFERENCE target, register EIF_REFERENCE source, int16 dtype);			/* Field-by-field isomorhphism */
rt_private EIF_BOOLEAN rdeepiso(EIF_REFERENCE target, EIF_REFERENCE source);				/* Recursive isomorphism */
rt_private EIF_BOOLEAN rdeepiter(register EIF_REFERENCE target, register EIF_REFERENCE source);			/* Iteration on normal objects */

/*
 * Routine definitions
 */

rt_public EIF_BOOLEAN xequal(EIF_REFERENCE ref1, EIF_REFERENCE ref2)
{
	/* Expanded equality. */
	if (ref1 == (EIF_REFERENCE) 0 && ref2 == (EIF_REFERENCE) 0)
		return EIF_TRUE;

	if (ref1 != (EIF_REFERENCE) 0 && ref2 != (EIF_REFERENCE) 0) {
			/* We don't care anymore about conformance, eequal expect
			 * type to be equal, otherwise it returns False.
			 */
		return eequal(ref1, ref2);
	}

	return EIF_FALSE;
}

rt_public EIF_BOOLEAN eequal(register EIF_REFERENCE target, register EIF_REFERENCE source)
{
	/* Eiffel standard equality: it assumes that dynamic type of Eiffel
	 * object refered by `source' conforms to dynamic type of Eiffel
	 * object refered by `target'. `source' and `target' cannot be NULL
	 * or special objects here.
	 * If both `source' and `target' have the same dynamic type and this
	 * type is not composite, then perform a block comparison; otherwise
	 * perform a field by field comparison.
	 * It is the feature `standard_is_equal' of class ANY.
	 * Return a boolean.
	 */

	uint32 s_flags;							/* Source object flags */
	uint32 t_flags;							/* Target object flags */
	int16 s_type, t_type;					/* Dynaic types */

	s_flags = HEADER(source)->ov_flags;
	t_flags = HEADER(target)->ov_flags;
	s_type = Deif_bid(s_flags);
	t_type = Deif_bid(t_flags);

	if (s_type == t_type) {
		/* Dynamic type are the same: because of the intra-expanded
		 * references, we can perform only a block comparison if
		 * the target (or the source) is a composite object (i.e: it has
		 * expanded attributes): since an attribute keeps expanded or
		 * not expanded all the time, we can test either the source or
		 * the target.
		 */
		if (s_flags & EO_SPEC) {
				/* Eiffel standard equality on special objects: type check assumes
				* the comparison is on areas of the same type (containing the same
				* thing). Called by the redefinition of feature `equal' of special
				* class. `source' and/or `target' cannot be NULL.
				* Return a boolean.
				*/
			register3 EIF_REFERENCE s_ref;
			register4 EIF_REFERENCE t_ref;
			uint32 s_size = (HEADER(source)->ov_size) & B_SIZE; /* Size of source special */
			uint32 t_size = (HEADER(target)->ov_size) & B_SIZE; /* Size of target special */
		
				/* First condition: same count */
			s_ref = (EIF_REFERENCE) (source + s_size - LNGPAD_2);
			t_ref = (EIF_REFERENCE) (target + t_size - LNGPAD_2);
			if (*(EIF_INTEGER *) s_ref != *(EIF_INTEGER *) t_ref)
				return EIF_FALSE;
		
			/* Since dynamic type of `source' conforms to dynamic type of
			* `target', the element size must be the same. No need to test it.
			*/
		
			/* Second condition: block equality */
			return EIF_TEST(!memcmp (source, target, s_size * sizeof(char)));
		} else if ((int16) (s_flags & EO_TYPE) == (int16) egc_bit_dtype) {
				/* Eiffel standard equality on BIT objects */
			return b_equal (source, target);
		} else {
			if (!(s_flags & EO_COMP))	/* Perform a block comparison */
				return EIF_TEST(!memcmp (source, target, EIF_Size(s_type)));
			else
				return e_field_equal(target, source, s_type);
		}
	}
	
	/* Field by field comparison */

	return EIF_FALSE;
}

rt_public EIF_BOOLEAN eiso(EIF_REFERENCE target, EIF_REFERENCE source)
{
	/* Compare `source ' and `target' in term of their structure:
	 * 1/ direct instances should be equal.
	 * 2/ references should be of the same dynamic type.
	 * It assumes that dynamic types of `source' and `target' are the
	 * same. 
	 * Return a boolean.
	 */

	uint32 s_flags;	/* Source flags */
	uint32 t_flags;	/* Target flags */
	int16 dtype;	/* Dynamic type */

	if (target == source)
		return EIF_TRUE;

	s_flags = HEADER(source)->ov_flags;
	t_flags = HEADER(target)->ov_flags;

#ifdef DEBUG
	dprintf(2)("eiso: source = 0x%lx [%s] target = 0x%lx [%s]\n",
		source, System(Deif_bid(s_flags)).cn_generator,
		target, System(Deif_bid(t_flags)).cn_generator);
#endif

	if (s_flags & EO_C)
		return EIF_FALSE;

	if (t_flags & EO_C)
		return EIF_FALSE;

	/* Check if the dynamic types are the same */
	dtype = Deif_bid(s_flags);
	if (dtype != Deif_bid(t_flags))
		return EIF_FALSE;
	else
		/* Check iomorphism */
		return e_field_iso(target, source, dtype);
}
	
rt_public EIF_BOOLEAN spiso(register EIF_REFERENCE target, register EIF_REFERENCE source)
{
	/* Compare two special objects in term of their structures. `source'
	 * and `target' are refering two special objects. There is three cases:
	 * 1- either the elements are direct instances: block comparison.
	 * 2- either the elements are references: comparison of referenced
	 *	dynamic type.
	 * 3- or the elements are expanded: call `eiso' (special objects
	 *	cannot be expanded).
	 */

	union overhead *s_zone;				/* Source header */
	union overhead *t_zone;				/* Target header */
	uint32 s_flags;						/* Source flags */
	/*uint32 t_flags;*/					/* Target flags */
	uint32 s_size;						/* Source size */
	uint32 t_size;						/* Target size */
	register3 EIF_REFERENCE s_ref;
	register4 EIF_REFERENCE t_ref;
	register5 long count;				/* Common count */
	register6 long elem_size;			/* Common element size */
	EIF_REFERENCE s_field, t_field;

	if (source == target)
		return EIF_TRUE;

	s_zone = HEADER(source);
	t_zone = HEADER(target);
	s_size = s_zone->ov_size & B_SIZE;
	t_size = t_zone->ov_size & B_SIZE;

	/* First condition: same count */
	s_ref = (EIF_REFERENCE) (source + s_size - LNGPAD_2);
	t_ref = (EIF_REFERENCE) (target + t_size - LNGPAD_2);

#ifdef DEBUG
	dprintf(2)("spiso: source = 0x%lx [%d] target = 0x%lx [%d]\n",
		source, *(long *) s_ref,
		target, *(long *) t_ref);
#endif

	count = *(long *) s_ref;
	if (count != *(long *) t_ref)
		return EIF_FALSE;
   
	/* Second condition: same element size */
	elem_size = *(long *) (s_ref + sizeof(long));
	if (elem_size != *(long *) (t_ref + sizeof(long)))
		return EIF_FALSE;

	s_flags = s_zone->ov_flags;
	if (!(s_flags & EO_REF))
		/* Case 1: specials filled with direct instances: block comparison */
		return EIF_TEST(!memcmp (source, target, s_size * sizeof(char)));

	if (!(s_flags & EO_COMP)) {
		/* Case 2: specials filled with references: we have to check fields
		 * two by two.
		 */
		for(
			s_ref = (EIF_REFERENCE)source, t_ref = (EIF_REFERENCE) target;
			count > 0;
			count --,
				s_ref = (EIF_REFERENCE) ((EIF_REFERENCE *) s_ref + 1),
				t_ref = (EIF_REFERENCE) ((EIF_REFERENCE *) t_ref + 1)
		) {
			/* Evaluation of two references */
			s_field = *(EIF_REFERENCE *) s_ref;
			t_field = *(EIF_REFERENCE *) t_ref;
			if ((0 == s_field) && (0 == t_field))
				/* Two void references */
				continue;
			else if (		(((EIF_REFERENCE) 0) != s_field) &&
							(((EIF_REFERENCE) 0) != t_field) &&
							(Dtype(s_field) == Dtype(t_field))
					)
				/* Two non-void references on objects of same dynamic type */
				continue;
			else
				/* No ismorphism */
				return EIF_FALSE;
		}
		return EIF_TRUE;
	}

	/* Case 3: special objects filled with (non-special) expanded objects.
	 * we call then standard isomorphism test on normal objects.
	 */
	for (
		s_ref = source +OVERHEAD, t_ref = target+OVERHEAD;
		count >0;
		count--, s_ref += elem_size, t_ref += elem_size
	) {
		/* Iteration on expanded elements */
		if (!eiso(t_ref, s_ref))
			return EIF_FALSE;
	}

	return EIF_TRUE;
}

rt_public EIF_BOOLEAN ediso(EIF_REFERENCE target, EIF_REFERENCE source)
{
	/* Compare recursively the structure attached to `target' to the
	 * one attached to `source'. This is the standard Eiffel feature
	 * because it called recursively the standard isomorhic Eiffel
	 * feature.
	 * Return a boolean.
	 */

	EIF_BOOLEAN result;
#ifdef ISE_GC
	char g_status;		/* Save GC status */

	g_status = gc_ison();
	if (g_status)
		gc_stop();						/* Stop GC if enabled*/
#endif

	table = s_create(100);				/* Create search table */	
	result = rdeepiso(target,source);	/* Recursive isomorphism test */

#ifdef ISE_GC
	if (g_status)
		gc_run();						/* Enabled GC it was previously enabled */
#endif

	xfree((EIF_REFERENCE) (table->s_keys));	/* Free search table keys */
	xfree((EIF_REFERENCE) table);				/* Free search table descriptor */
	return result;
}

rt_private EIF_BOOLEAN rdeepiso(EIF_REFERENCE target,EIF_REFERENCE source)
{
	/* Recursive isomorphism test.
	 * Return a boolean.
	 */

	union overhead *zone = HEADER(target);	/* Target header */
	uint32 flags;							/* Target flags */
	EIF_REFERENCE s_ref, t_ref, t_field, s_field;
	long count, elem_size;

	flags = zone->ov_flags;

	/* Check if the object has already been inspected */
	if (s_put(table, target) == EIF_SEARCH_CONFLICT)
		return EIF_TRUE;

	/* Isomorphism test between `source' and `target'.
	 * Two cases: either a normal object or a special object.
	 */
	if (flags & EO_SPEC) {
		/* Special objects */
		if (!spiso(target, source))
			return EIF_FALSE;

		if (!(flags & EO_REF))
			/* No reference to inspect */
			return EIF_TRUE;

		/* Evaluation of the count of the target special object */
		t_ref = (EIF_REFERENCE) (target + (zone->ov_size & B_SIZE) - LNGPAD_2);
		count = *(long *) t_ref;

		/* Traversal of references */
		if (!(flags & EO_COMP)) {
			/* Specials filled with references: we have to iterate on fields
			* two by two.
			*/
			/* Evaluation of the count of the target special object */
			for(
				s_ref = (EIF_REFERENCE)source, t_ref = (EIF_REFERENCE) target;
				count > 0;
				count --,
					s_ref = (EIF_REFERENCE) ((EIF_REFERENCE *) s_ref + 1),
					t_ref = (EIF_REFERENCE) ((EIF_REFERENCE *) t_ref + 1)
			) {
				/* Evaluation of two references */
				s_field = *(EIF_REFERENCE *) s_ref;
				t_field = *(EIF_REFERENCE *) t_ref;
				if ((((EIF_REFERENCE) 0) == s_field) && (((EIF_REFERENCE) 0) == t_field))
					/* Two void references */
					continue;
				else if ((EIF_REFERENCE) 0 != s_field && (EIF_REFERENCE) 0 != t_field) {
					/* Recursion on references of the special object */
					if (!rdeepiso(t_field, s_field))
						return EIF_FALSE;
				} else
					return EIF_FALSE;
			}
			return EIF_TRUE;
		} else {
			/* Special objects filled with (non-special) expanded objects.
			 * we call then standard isomorphism test on normal objects.
			 */
			elem_size = *(long *) (t_ref + sizeof(long));
			for (
				s_ref = source+OVERHEAD, t_ref = target+OVERHEAD;
				count > 0;
				count--, s_ref += elem_size, t_ref += elem_size
			) {
				/* Iteration on expanded elements which cannot be special
				 * objects
				 */
				if (!(rdeepiter(t_ref, s_ref)))
					return EIF_FALSE;
			}
		}
	}
	else {
		/* Normal object */
		if (!eiso(target, source))
			return EIF_FALSE;

		/* Iteration on references */
		return rdeepiter(target, source);
	}
	/* NOTREACHED */
	return EIF_FALSE;
}

rt_private EIF_BOOLEAN rdeepiter(register EIF_REFERENCE target, register EIF_REFERENCE source)
{
	/* Iterate deep isomorphism on normal objects `target' and `source'.
	 * It assumes that `source' and `target' are not NULL and isomorphic.
	 * Return a boolean.
	 */

	register3 long count;				/* Reference number */
	register4 EIF_REFERENCE s_ref;
	register5 EIF_REFERENCE t_ref;

	/* Evaluation of the number of references: and iteration on it */
	for (
		count = References(Dtype(target));
		count > 0;
		count--,
			source = (EIF_REFERENCE) ((EIF_REFERENCE *)source + 1),
			target = (EIF_REFERENCE) ((EIF_REFERENCE *) target + 1)
	)  {
		s_ref = *(EIF_REFERENCE *)source;
		t_ref = *(EIF_REFERENCE *)target;
		/* One test an a de-reference is only useful since the source and
		 * the target are isomorhic
		 */
		if (s_ref == 0)
			if (t_ref == 0)
				continue;
			else
				return EIF_FALSE;
		else if (t_ref == 0)
			return EIF_FALSE;
		else if (!(rdeepiso(*(EIF_REFERENCE *)target, s_ref)))
			return EIF_FALSE;
	}
	return EIF_TRUE;
}

rt_private EIF_BOOLEAN e_field_equal(register EIF_REFERENCE target, register EIF_REFERENCE source, int16 dtype)
{
	/* Eiffel standard field-by-field equality:
	 * Since target and source have the same dynamic type `dtype' we iterate
	 * on the attributes of target.
	 * Return a boolean.
	 */

	struct cnode *skeleton;	/* Target skeleton */
	uint32 *types;            /* Target attribute types */
#ifndef WORKBENCH
	register3 long *offsets;	/* Target attribute tables */
#else
	int32 *cn_attr;     		/* Array of attribute keys for target object */
	int32 attr_key;				/* Attribute key */
#endif
	long offset;
	register5 long index;		/* Target attribute index */
	EIF_REFERENCE t_ref, s_ref;
	int attribute_type;	/* Attribute type in skeleton */

	skeleton = &System(dtype);
	types = skeleton->cn_types;
#ifndef WORKBENCH
	offsets = skeleton->cn_offsets;
#else
	cn_attr = skeleton->cn_attr;
#endif

	/* Iteration on the target attributes */
	for (index = skeleton->cn_nbattr - 1; index >= 0; index--) {
#ifndef WORKBENCH
		offset = offsets[index];
		t_ref = target + offset;
		s_ref = source + offset;
#else
		/* Evaluation of the attribute key */
		attr_key = cn_attr[index];

		/* Evaluation of the target attribute offset */
		CAttrOffs(offset,attr_key,dtype);
		t_ref = target + offset;

		/* Evaluation of the source attribute offset */
		/* It is the same as the target, since they have the same dynamic type */
		s_ref = source + offset;
#endif
		attribute_type = types[index];
		switch (attribute_type & SK_HEAD) {
		case SK_BOOL:
		case SK_CHAR:
			if (*t_ref != *s_ref)
				return EIF_FALSE;
			break;
		case SK_WCHAR:
			if (*(EIF_WIDE_CHAR *) t_ref != *(EIF_WIDE_CHAR *) s_ref)
				return EIF_FALSE;
			break;
		case SK_INT8:
			if (*(EIF_INTEGER_8 *) t_ref != *(EIF_INTEGER_8 *) s_ref)
				return EIF_FALSE;
			break;
		case SK_INT16:
			if (*(EIF_INTEGER_16 *) t_ref != *(EIF_INTEGER_16 *) s_ref)
				return EIF_FALSE;
			break;
		case SK_INT32:
			if (*(EIF_INTEGER_32 *) t_ref != *(EIF_INTEGER_32 *) s_ref)
				return EIF_FALSE;
			break;
		case SK_INT64:
			if (*(EIF_INTEGER_64 *) t_ref != *(EIF_INTEGER_64 *) s_ref)
				return EIF_FALSE;
			break;
		case SK_FLOAT:
			if (*(EIF_REAL *) t_ref != *(EIF_REAL *) s_ref)
				return EIF_FALSE;
			break;
		case SK_DOUBLE:
			if (*(EIF_DOUBLE *) t_ref != *(EIF_DOUBLE *) s_ref)
				return EIF_FALSE;
			break;
		case SK_POINTER:
			if (*(fnptr *) t_ref != *(fnptr *) s_ref)
				return EIF_FALSE;
			break;
		case SK_BIT:
				/* BITS attribute */
				/* All we have to do here is call the routine for bit comparison
				 * as we have the references for the source and the target
				 * -- Fabrice */
			if (!b_equal(s_ref, t_ref))
				return EIF_FALSE;
			break;
		case SK_EXP:
				/* Source and target attribute are expanded of the same type.
				 * Block comparison if the attribute type is not composite
				 * itself else field-by-field comparison.
				 */
			if (!eequal(t_ref, s_ref))
				return EIF_FALSE;
			break;
		default:
			if (*(EIF_REFERENCE *)t_ref != *(EIF_REFERENCE *)s_ref)
				/* Check equality of references */
				return EIF_FALSE;
		}
	}
	return EIF_TRUE;
}

rt_private EIF_BOOLEAN e_field_iso(register EIF_REFERENCE target, 
								register EIF_REFERENCE source, 
								int16 dtype)
{
	/* Eiffel standard field-by-field equality: since source type
	 * conforms to source type, we iterate on target attributes which are
	 * thus necessary present in the source.
	 * Return a boolean.
	 */

	struct cnode *skeleton;	/* Target skeleton */
	uint32 *types;            /* Target attribute types */
#ifndef WORKBENCH
	register3 long *offsets;	/* Target attribute tables */
#else
	int32 *cn_attr;                /* Array of attribute keys for source object */
	int32 attr_key;				/* Attribute key */
#endif
	long offset;
	register5 long index;		/* Target attribute index */
	EIF_REFERENCE t_ref, s_ref, ref1, ref2;
	int attribute_type;

	skeleton = &System(dtype);
	types = skeleton->cn_types;
#ifndef WORKBENCH
	offsets = skeleton->cn_offsets;
#else
	cn_attr = skeleton->cn_attr;
#endif

	/* Iteration on the target attributes */
	for (index = skeleton->cn_nbattr - 1; index >= 0; index--) {
#ifndef WORKBENCH
		/* Evaluation of the attribute table */
		offset = offsets[index];

		t_ref = target + offset;
		s_ref = source + offset;
#else
		/* Evaluation of the attribute key */
		attr_key = cn_attr[index];

		/* Evaluation of the target attribute offset */
		CAttrOffs(offset,attr_key,dtype);
		t_ref = target + offset;

		/* Evaluation of the source attribute offset */
		/* It is the same as the target, since they have the same dynamic type */
		s_ref = source + offset;
#endif
		attribute_type = types[index];
		switch (attribute_type & SK_HEAD) {
		case SK_BOOL:
		case SK_CHAR:
			if (*t_ref != *s_ref)
				return EIF_FALSE;
			break;
		case SK_WCHAR:
			if (*(EIF_WIDE_CHAR *) t_ref != *(EIF_WIDE_CHAR *) s_ref)
				return EIF_FALSE;
			break;
		case SK_INT8:
			if (*(EIF_INTEGER_8 *) t_ref != *(EIF_INTEGER_8 *) s_ref)
				return EIF_FALSE;
			break;
		case SK_INT16:
			if (*(EIF_INTEGER_16 *) t_ref != *(EIF_INTEGER_16 *) s_ref)
				return EIF_FALSE;
			break;
		case SK_INT32:
			if (*(EIF_INTEGER_32 *) t_ref != *(EIF_INTEGER_32 *) s_ref)
				return EIF_FALSE;
			break;
		case SK_INT64:
			if (*(EIF_INTEGER_64 *) t_ref != *(EIF_INTEGER_64 *) s_ref)
				return EIF_FALSE;
			break;
		case SK_FLOAT:
			if (*(EIF_REAL *) t_ref != *(EIF_REAL *) s_ref)
				return EIF_FALSE;
			break;
		case SK_DOUBLE:
			if (*(EIF_DOUBLE *) t_ref != *(EIF_DOUBLE *) s_ref)
				return EIF_FALSE;
			break;
		case SK_POINTER:
			if (*(fnptr *) t_ref != *(fnptr *) s_ref)
				return EIF_FALSE;
			break;
		default:
			if ((attribute_type & SK_HEAD) == SK_BIT) {
		/* BITS attribute */
			} else if ((attribute_type & SK_HEAD) == SK_EXP) {
				/* Source and target attribute are expanded of the same type.
				 * Block comparison if the attribute type is not composite
				 * itself else field-by-field comparison.
				 */
				if (!eiso(t_ref, s_ref))
					return EIF_FALSE;
			} else { 
				/* Check isomorphism of references: either the two
				* references are Void or they refer object of the.
				* same dynamic type.
				*/
				ref1 = *(EIF_REFERENCE *)t_ref;
				ref2 = *(EIF_REFERENCE *)s_ref;
				if (((EIF_REFERENCE) 0 == ref1) && ((EIF_REFERENCE)0 == ref2))
					/* Void reference */
					continue;
				if (	(0 != ref1) &&
						(0 != ref2) &&
						(Dtype(ref1) == Dtype(ref2)))
					continue;
				return EIF_FALSE;
			}
		}
	}
	return EIF_TRUE;
}
