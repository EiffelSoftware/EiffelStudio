/*

 ######   ####   #    #    ##    #                ####
 #       #    #  #    #   #  #   #               #    #
 #####   #    #  #    #  #    #  #               #
 #       #  # #  #    #  ######  #        ###    #
 #       #   #   #    #  #    #  #        ###    #    #
 ######   ### #   ####   #    #  ######   ###     ####

		Equality C externals
*/

#include "eif_config.h"
#include "eif_eiffel.h"			/* For standard macros */
#include "eif_equal.h"			/* For Eiffel boolean */
#include "eif_struct.h"			/* For skeleton structure */
#include "eif_traverse.h"		/* For traversing objects */
#include "x2c.header"			/* For macro LNGPAD */
#include "eif_tools.h"			/* For `nprime' */
#include "eif_search.h"
#include "eif_plug.h"			/* for econfg */

#define dprintf(n) if (DEBUG & n) printf

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

rt_private struct s_table *table;		/* Search table for deep equal */

/*
 * Routines declarations
 */

rt_private int e_field_equal(register char *target, register char *source, int16 dtype);		/* Field-by-field equality */
rt_private int e_field_iso(register char *target, register char *source, int16 dtype);			/* Field-by-field isomorhphism */
rt_private int rdeepiso(char *target, char *source);				/* Recursive isomorphism */
rt_private int rdeepiter(register char *target, register char *source);			/* Iteration on normal objects */

/*
 * Routine definitions
 */

rt_public int xequal(char *ref1, char *ref2)
{
	/* Expanded equality. */
	char *tmp;

	if (ref1 == (char *) 0 && ref2 == (char *) 0)
		return 1;

	if (ref1 != (char *) 0 && ref2 != (char *) 0) {
		if (econfg(ref2, ref1)) {
			tmp = ref1;
			ref1 = ref2;
			ref2 = tmp;
		}
			/* `eequal' needs second argument to conform to its first one */ 
		return eequal(ref1, ref2);
	}

	return 0;
}

rt_public int eequal(register char *target, register char *source)
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
		if (!(s_flags & EO_COMP))	/* Perform a block comparison */
			return (char) (!bcmp(source, target, Size(s_type)));
		else
			return e_field_equal(target, source, s_type);
	}
	
	/* Field by field comparison */

	return FALSE;
}

rt_public int spequal(register char *target, register char *source)
{
	/* Eiffel standard equality on special objects: type check assumes
	 * the comparison is on areas of the same type (containing the same
	 * thing). Called by the redefinition of feature `equal' of special
	 * class. `source' and/or `target' cannot be NULL.
	 * Return a boolean.
	 */

	uint32 s_size = (HEADER(source)->ov_size) & B_SIZE;
										/* Size of source special */
	uint32 t_size = (HEADER(target)->ov_size) & B_SIZE;
										/* Size of target special */
	register3 char *s_ref;
	register4 char *t_ref;

	/* First condition: same count */
	s_ref = (char *) (source + s_size - LNGPAD_2);
	t_ref = (char *) (target + t_size - LNGPAD_2);
	if (*(long *) s_ref != *(long *) t_ref)
		return FALSE;

	/* Since dynamic type of `source' conforms to dynamic type of
	 * `target', the element size must be the same. No need to test it.
	 */

	/* Second condition: block equality */
	return (char) (!bcmp(source, target, s_size * sizeof(char)));
}

rt_public int eiso(char *target, char *source)
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
		return TRUE;

	s_flags = HEADER(source)->ov_flags;
	t_flags = HEADER(target)->ov_flags;

#ifdef DEBUG
	dprintf(2)("eiso: source = 0x%lx [%s] target = 0x%lx [%s]\n",
		source, System(Deif_bid(s_flags)).cn_generator,
		target, System(Deif_bid(t_flags)).cn_generator);
#endif

	if (s_flags & EO_C)
		return FALSE;

	if (t_flags & EO_C)
		return FALSE;

	/* Check if the dynamic types are the same */
	dtype = Deif_bid(s_flags);
	if (dtype != Deif_bid(t_flags))
		return FALSE;
	else
		/* Check iomorphism */
		return e_field_iso(target, source, dtype);
}
	
rt_public int spiso(register char *target, register char *source)
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
	register3 char *s_ref;
	register4 char *t_ref;
	register5 long count;				/* Common count */
	register6 long elem_size;			/* Common element size */
	char *s_field, *t_field;

	if (source == target)
		return TRUE;

	s_zone = HEADER(source);
	t_zone = HEADER(target);
	s_size = s_zone->ov_size & B_SIZE;
	t_size = t_zone->ov_size & B_SIZE;

	/* First condition: same count */
	s_ref = (char *) (source + s_size - LNGPAD_2);
	t_ref = (char *) (target + t_size - LNGPAD_2);

#ifdef DEBUG
	dprintf(2)("spiso: source = 0x%lx [%d] target = 0x%lx [%d]\n",
		source, *(long *) s_ref,
		target, *(long *) t_ref);
#endif

	count = *(long *) s_ref;
	if (count != *(long *) t_ref)
		return FALSE;
   
	/* Second condition: same element size */
	elem_size = *(long *) (s_ref + sizeof(long));
	if (elem_size != *(long *) (t_ref + sizeof(long)))
		return FALSE;

	s_flags = s_zone->ov_flags;
	if (!(s_flags & EO_REF))
		/* Case 1: specials filled with direct instances: block comparison */
		return (char) (!bcmp(source, target, s_size * sizeof(char)));

	if (!(s_flags & EO_COMP)) {
		/* Case 2: specials filled with references: we have to check fields
		 * two by two.
		 */
		for(
			s_ref = (char *)source, t_ref = (char *) target;
			count > 0;
			count --,
				s_ref = (char *) ((char **) s_ref + 1),
				t_ref = (char *) ((char **) t_ref + 1)
		) {
			/* Evaluation of two references */
			s_field = *(char **) s_ref;
			t_field = *(char **) t_ref;
			if ((0 == s_field) && (0 == t_field))
				/* Two void references */
				continue;
			else if (		(((char *) 0) != s_field) &&
							(((char *) 0) != t_field) &&
							(Dtype(s_field) == Dtype(t_field))
					)
				/* Two non-void references on objects of same dynamic type */
				continue;
			else
				/* No ismorphism */
				return FALSE;
		}
		return TRUE;
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
			return FALSE;
	}

	return TRUE;
}

rt_public int ediso(char *target, char *source)
{
	/* Compare recursively the structure attached to `target' to the
	 * one attached to `source'. This is the standard Eiffel feature
	 * because it called recursively the standard isomorhic Eiffel
	 * feature.
	 * Return a boolean.
	 */

	EIF_GET_CONTEXT
	char g_status = g_data.status;		/* Save GC status */
	int result;

	g_data.status |= GC_STOP;			/* Stop GC */
	table = s_create(100);				/* Create search table */	
	result = rdeepiso(target,source);	/* Recursive isomorphism test */
	g_data.status = g_status;			/* Restore GC status */
	xfree((char *) (table->s_keys));	/* Free search table keys */
	xfree((char *) table);				/* Free search table descriptor */
	return result;
	EIF_END_GET_CONTEXT
}

rt_private int rdeepiso(char *target, char *source)
{
	/* Recursive isomorphism test.
	 * Return a boolean.
	 */

	union overhead *zone = HEADER(target);	/* Target header */
	uint32 flags;							/* Target flags */
	char *s_ref, *t_ref, *t_field, *s_field;
	long count, elem_size;

	flags = zone->ov_flags;

	/* Check if the object has already been inspected */
	if (s_put(table, target) == EIF_SEARCH_CONFLICT)
		return TRUE;

	/* Isomorphism test between `source' and `target'.
	 * Two cases: either a normal object or a special object.
	 */
	if (flags & EO_SPEC) {
		/* Special objects */
		if (!spiso(target, source))
			return FALSE;

		if (!(flags & EO_REF))
			/* No reference to inspect */
			return TRUE;

		/* Evaluation of the count of the target special object */
		t_ref = (char *) (target + (zone->ov_size & B_SIZE) - LNGPAD_2);
		count = *(long *) t_ref;

		/* Traversal of references */
		if (!(flags & EO_COMP)) {
			/* Specials filled with references: we have to iterate on fields
			* two by two.
			*/
			/* Evaluation of the count of the target special object */
			for(
				s_ref = (char *)source, t_ref = (char *) target;
				count > 0;
				count --,
					s_ref = (char *) ((char **) s_ref + 1),
					t_ref = (char *) ((char **) t_ref + 1)
			) {
				/* Evaluation of two references */
				s_field = *(char **) s_ref;
				t_field = *(char **) t_ref;
				if ((((char *) 0) == s_field) && (((char *) 0) == t_field))
					/* Two void references */
					continue;
				else if ((char *) 0 != s_field && (char *) 0 != t_field) {
					/* Recursion on references of the special object */
					if (!rdeepiso(t_field, s_field))
						return FALSE;
				} else
					return FALSE;
			}
			return TRUE;
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
					return FALSE;
			}
		}
	}
	else {
		/* Normal object */
		if (!eiso(target, source))
			return FALSE;

		/* Iteration on references */
		return rdeepiter(target, source);
	}
	/* NOTREACHED */
	return FALSE;
}

rt_private int rdeepiter(register char *target, register char *source)
{
	/* Iterate deep isomorphism on normal objects `target' and `source'.
	 * It assumes that `source' and `target' are not NULL and isomorphic.
	 * Return a boolean.
	 */

	register3 long count;				/* Reference number */
	register4 char *s_ref;
	register5 char *t_ref;

	/* Evaluation of the number of references: and iteration on it */
	for (
		count = References(Dtype(target));
		count > 0;
		count--,
			source = (char *) ((char **)source + 1),
			target = (char *) ((char **) target + 1)
	)  {
		s_ref = *(char **)source;
		t_ref = *(char **)target;
		/* One test an a de-reference is only useful since the source and
		 * the target are isomorhic
		 */
		if (s_ref == 0)
			if (t_ref == 0)
				continue;
			else
				return FALSE;
		else if (t_ref == 0)
			return FALSE;
		else if (!(rdeepiso(*(char **)target, s_ref)))
			return FALSE;
	}
	return TRUE;
}

rt_private int e_field_equal(register char *target, register char *source, int16 dtype)
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
	char *t_ref, *s_ref;
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
				return FALSE;
			break;
		case SK_INT:
			if (*(long *) t_ref != *(long *) s_ref)
				return FALSE;
			break;
		case SK_FLOAT:
			if (*(float *) t_ref != *(float *) s_ref)
				return FALSE;
			break;
		case SK_DOUBLE:
			if (*(double *) t_ref != *(double *) s_ref)
				return FALSE;
			break;
		case SK_POINTER:
			if (*(fnptr *) t_ref != *(fnptr *) s_ref)
				return FALSE;
			break;
		case SK_BIT:
				/* BITS attribute */
				/* All we have to do here is call the routine for bit comparison
				 * as we have the references for the source and the target
				 * -- Fabrice */
			if (!b_equal(s_ref, t_ref))
				return FALSE;
			break;
		case SK_EXP:
				/* Source and target attribute are expanded of the same type.
				 * Block comparison if the attribute type is not composite
				 * itself else field-by-field comparison.
				 */
			if (!eequal(t_ref, s_ref))
				return FALSE;
			break;
		default:
			if (*(char **)t_ref != *(char **)s_ref)
				/* Check equality of references */
				return FALSE;
		}
	}
	return TRUE;
}

rt_private int e_field_iso(register char *target, register char *source, int16 dtype)
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
	char *t_ref, *s_ref, *ref1, *ref2;
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
				return FALSE;
			break;
		case SK_INT:
			if (*(long *) t_ref != *(long *) s_ref)
				return FALSE;
			break;
		case SK_FLOAT:
				if (*(float *) t_ref != *(float *) s_ref)
					return FALSE;
			break;
		case SK_DOUBLE:
			if (*(double *) t_ref != *(double *) s_ref)
				return FALSE;
			break;
		case SK_POINTER:
			if (*(fnptr *) t_ref != *(fnptr *) s_ref)
				return FALSE;
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
					return FALSE;
			} else { 
				/* Check isomorphism of references: either the two
				* references are Void or they refer object of the.
				* same dynamic type.
				*/
				ref1 = *(char **)t_ref;
				ref2 = *(char **)s_ref;
				if (((char *)0 == ref1) && ((char *)0 == ref2))
					/* Void reference */
					continue;
				if (	(0 != ref1) &&
						(0 != ref2) &&
						(Dtype(ref1) == Dtype(ref2)))
					continue;
				return FALSE;
			}
		}
	}
	return TRUE;
}
