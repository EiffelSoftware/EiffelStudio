/*

 ######   ####   #    #    ##    #                ####
 #       #    #  #    #   #  #   #               #    #
 #####   #    #  #    #  #    #  #               #
 #       #  # #  #    #  ######  #        ###    #
 #       #   #   #    #  #    #  #        ###    #    #
 ######   ### #   ####   #    #  ######   ###     ####

		Equality C externals
*/

#include "config.h"
#include "equal.h"			/* For Eiffel boolean */
#include "struct.h"			/* For skeleton structure */
#include "traverse.h"		/* For traversing objects */
#include "macros.h"			/* For macro LNGPAD */
#include "eiffel.h"			/* For standard macros */
#include "tools.h"			/* For `nprime' */
#include "search.h"

#define dprintf(n) if (DEBUG & n) printf

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

rt_private struct s_table *table;		/* Search table for deep equal */

/*
 * Routines declarations
 */

rt_private int e_field_equal();		/* Field-by-field equality */
rt_private int e_field_iso();			/* Field-by-field isomorhphism */
rt_private int rdeepiso();				/* Recursive isomorphism */
rt_private int rdeepiter();			/* Iteration on normal objects */

/*
 * Routine definitions
 */

rt_public int xequal(ref1, ref2)
char *ref1;
char *ref2;
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

rt_public int eequal(target, source)
register1 char *source;
register2 char *target;
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
	s_type = s_flags & EO_TYPE;
	t_type = t_flags & EO_TYPE;

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
			return e_field_equal(target, source, t_flags, s_flags);
	}
	
	/* Field by field comparison */

	return FALSE;
}

rt_public int spequal(target, source)
register1 char *source;
register2 char *target;
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
	s_ref = (char *) (source + s_size - LNGPAD(2));
	t_ref = (char *) (target + t_size - LNGPAD(2));
	if (*(long *) s_ref != *(long *) t_ref)
		return FALSE;

	/* Since dynamic type of `source' conforms to dynamic type of
	 * `target', the element size must be the same. No need to test it.
	 */

	/* Second condition: block equality */
	return (char) (!bcmp(source, target, s_size * sizeof(char)));
}
	
rt_public int eiso(target, source)
char *source;
char *target;
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

	if (target == source)
		return TRUE;

	s_flags = HEADER(source)->ov_flags;
	t_flags = HEADER(target)->ov_flags;

#ifdef DEBUG
	dprintf(2)("eiso: source = 0x%lx [%s] target = 0x%lx [%s]\n",
		source, System(s_flags & EO_TYPE).cn_generator,
		target, System(t_flags & EO_TYPE).cn_generator);
#endif

	if (s_flags & EO_C)
		return FALSE;

	if (t_flags & EO_C)
		return FALSE;

	/* Check if the dynamic types are the same */
	if ((s_flags & EO_TYPE) != (t_flags & EO_TYPE))
		return FALSE;

	/* Check iomorphism */
	return e_field_iso(target, source, t_flags, s_flags);
}

rt_public int spiso(target, source)
register1 char *target;
register2 char *source;
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
	uint32 t_flags;						/* Target flags */
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
	s_ref = (char *) (source + s_size - LNGPAD(2));
	t_ref = (char *) (target + t_size - LNGPAD(2));

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

rt_public int ediso(target, source)
char *source;
char *target;
{
	/* Compare recursively the structure attached to `target' to the
	 * one attached to `source'. This is the standard Eiffel feature
	 * because it called recursively the standard isomorhic Eiffel
	 * feature.
	 * Return a boolean.
	 */
	char g_status = g_data.status;		/* Save GC status */
	int result;

	g_data.status |= GC_STOP;			/* Stop GC */
	table = s_create(100);				/* Create search table */	
	result = rdeepiso(target,source);	/* Recursive isomorphism test */
	g_data.status = g_status;			/* Restore GC status */
	xfree(table->s_keys);				/* Free search table keys */
	xfree(table);						/* Free search table descriptor */
	return result;
}

rt_private int rdeepiso(target, source)
char *source;
char *target;
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
	if (s_put(table, target) == S_CONFLICT)
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
		t_ref = (char *) (target + (zone->ov_size & B_SIZE) - LNGPAD(2));
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
}

rt_private int rdeepiter(target, source)
register1 char *target;
register2 char *source;
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

rt_private int e_field_equal(target, source, t_flags, s_flags)
register2 char *source;
register1 char *target;
uint32 t_flags;
uint32 s_flags;
{
	/* Eiffel standard field-by-field equality: since source type
	 * conforms to source type, we iterate on target attributes which are
	 * thus necessary present in the source.
	 * Return a boolean.
	 */

	struct cnode *t_skeleton;	/* Target skeleton */
	struct cnode *s_skeleton;	/* Source skeleton */
	uint32 *t_types;            /* Target attribute types */
	uint32 *s_types;            /* Source attribute types */
#ifndef WORKBENCH
	register3 long **t_offsets;	/* Target attribute tables */
	register4 long **s_offsets;	/* Source attribute tables */
	long *attr_table;			/* Attribute table */
#else
	int32 *tcn_attr;     		/* Array of attribute keys for target object */
	int32 *scn_attr;			/* Array of attribute keys for source object */
	int32 attr_key;				/* Attribute key */
	long offset;
#endif
	register5 long t_index;		/* Target attribute index */
	register6 long s_index;		/* Source attribute index */
	int16 s_type, t_type;
	char *t_ref, *s_ref;
	int target_type, source_type;	/* Attribute type in skeleton */

	s_type = s_flags & EO_TYPE;
	t_type = t_flags & EO_TYPE;
	t_skeleton = &System(t_type);
	s_skeleton = &System(s_type);
	t_types = t_skeleton->cn_types;
	s_types = s_skeleton->cn_types;
#ifndef WORKBENCH
	t_offsets = t_skeleton->cn_offsets;
	s_offsets = s_skeleton->cn_offsets;
#else
	tcn_attr = t_skeleton->cn_attr;
	scn_attr = s_skeleton->cn_attr;
#endif

	/* Iteration on the target attributes */
	for (t_index = t_skeleton->cn_nbattr - 1; t_index >= 0; t_index--) {
#ifndef WORKBENCH
		/* Evaluation of the attribute table */


		attr_table = t_offsets[t_index];

		/* Evaluation of the source index */
		for (s_index = 0; s_offsets[s_index] != attr_table;s_index++)
			;

		t_ref = target + attr_table[t_type];
		s_ref = source + attr_table[s_type];
		
#else
		/* Evaluation of the attribute key */
		attr_key = tcn_attr[t_index];

		/* Evaluation of the target attribute offset */
		CAttrOffs(offset,attr_key,t_type);
		t_ref = target + offset;

		/* Evaluation of the source attribute offset */
		CAttrOffs(offset,attr_key,s_type);
		s_ref = source + offset;


		
		for (s_index = 0; scn_attr[s_index] != attr_key; s_index++)
			;
#endif
		target_type = t_types[t_index];
		source_type = s_types[s_index];
		switch (target_type & SK_HEAD) {
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
			break
		default:
			if (*(char **)t_ref != *(char **)s_ref)
				/* Check equality of references */
				return FALSE;
		}
	}
	return TRUE;
}

rt_private int e_field_iso(target, source, t_flags, s_flags)
register2 char *source;
register1 char *target;
uint32 t_flags;
uint32 s_flags;
{
	/* Eiffel standard field-by-field equality: since source type
	 * conforms to source type, we iterate on target attributes which are
	 * thus necessary present in the source.
	 * Return a boolean.
	 */

	struct cnode *t_skeleton;	/* Target skeleton */
	struct cnode *s_skeleton;	/* Source skeleton */
	uint32 *t_types;            /* Target attribute types */
	uint32 *s_types;            /* Source attribute types */
#ifndef WORKBENCH
	register3 long **t_offsets;	/* Target attribute tables */
	register4 long **s_offsets;	/* Source attribute tables */
	long *attr_table;			/* Attribute table */
#else
	int32 *tcn_attr;				/* Array of attribute keys for target object */
	int32 *scn_attr;                /* Array of attribute keys for source object */
	int32 attr_key;				/* Attribute key */
	long offset;
#endif
	register5 long t_index;		/* Target attribute index */
	register6 long s_index;		/* Source attribute index */
	int16 s_type, t_type;
	char *t_ref, *s_ref, *ref1, *ref2;
	int target_type, source_type;		/* Attribute type in skeleton */

	s_type = s_flags & EO_TYPE;
	t_type = t_flags & EO_TYPE;
	t_skeleton = &System(t_type);
	s_skeleton = &System(s_type);
	t_types = t_skeleton->cn_types;
	s_types = s_skeleton->cn_types;
#ifndef WORKBENCH
	t_offsets = t_skeleton->cn_offsets;
	s_offsets = s_skeleton->cn_offsets;
#else
	tcn_attr = t_skeleton->cn_attr;
	scn_attr = s_skeleton->cn_attr;
#endif

	/* Iteration on the target attributes */
	for (t_index = t_skeleton->cn_nbattr - 1; t_index >= 0; t_index--) {
#ifndef WORKBENCH
		/* Evaluation of the attribute table */
		attr_table = t_offsets[t_index];

		/* Evaluation of the source index */
		for (s_index = 0; s_offsets[s_index] != attr_table;s_index++)
			;

		t_ref = target + attr_table[t_type];
		s_ref = source + attr_table[s_type];
		
#else
		/* Evaluation of the attribute key */
		attr_key = tcn_attr[t_index];

		/* Evaluation of the target attribute offset */
		CAttrOffs(offset,attr_key,t_type);
		t_ref = target + offset;

		/* Evaluation of the source attribute offset */
		CAttrOffs(offset,attr_key,s_type);
		s_ref = source + offset;

		for(s_index=0; scn_attr[s_index] != attr_key; s_index++)
			;
#endif
		target_type = t_types[t_index];
		source_type = s_types[s_index];
		switch (target_type & SK_HEAD) {
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
			if ((target_type & SK_HEAD) == SK_BIT) {
				/* BITS attribute */
			} else if ((target_type & SK_HEAD) == SK_EXP) {
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

