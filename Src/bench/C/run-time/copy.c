/*

  ####    ####   #####    #   #           ####
 #    #  #    #  #    #    # #           #    #
 #       #    #  #    #     #            #
 #       #    #  #####      #     ###    #
 #    #  #    #  #          #     ###    #    #
  ####    ####   #          #     ###     ####

	Multiple copy routines.
*/

#include "eif_config.h"
#include "eif_eiffel.h"
#include "eif_copy.h"
#include "eif_traverse.h"		/* For deep copies */

#if ! defined CUSTOM || defined NEED_HASH_H
#include "eif_hash.h"			/* For deep copies */
#endif

#include "eif_struct.h"
#include "eif_except.h"
#include "eif_local.h"
#include "eif_hector.h"
#include "eif_garcol.h"
#include "x2c.h"		/* For macro LNGPAD */

#define SHALLOW		1		/* Copy first level only */
#define DEEP		2		/* Recursive copy */

/*#define DEBUG 	*/

/* The following hash table is used to keep the maping between cloned objects,
 * so that we know for instance where we put the clone for object X. It takes
 * a pointer and yields an EIF_OBJECT.
 */
rt_private struct hash hclone;			/* Cloning hash table */

/* Function declarations */
rt_private void rdeepclone(char *source, char *enclosing, int offset);			/* Recursive cloning */
rt_private void expanded_update(char *source, char *target, int shallow_or_deep);		/* Expanded reference update */
rt_private char *duplicate(char *source, char *enclosing, int offset);			/* Duplication with aging tests */

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

rt_public char *eclone(register char *source)
{
	/* Clone an of Eiffel object `source'. Assumes that source is not a
	 * special object.
	 */
	
	return emalloc(HEADER(source)->ov_flags & EO_TYPE);
}

rt_public char *spclone(char *source)
{
	/* Clone an of Eiffel object `source'. Assumes that source
	 * is a special object.
	 */
	
	EIF_GET_CONTEXT
	register4 char *result;				/* Clone pointer */
	register1 union overhead *zone;		/* Pointer on source header */
	register2 uint32 flags;				/* Source object flags */
	register3 uint32 size;				/* Source object size */
	char *s_ref, *r_ref;

	if ((char *) 0 == source)
		return (char *) 0;				/* Void source */

	epush(&loc_stack, (char *)(&source));			/* Protection against GC */

	zone = HEADER(source);				/* Allocation of a new object */
	flags = zone->ov_flags;
	size = zone->ov_size & B_SIZE;
	result = spmalloc(size);			/* Special object */

	/* Keep the reference flag and the composite one and the type */
	HEADER(result)->ov_flags |= flags & (EO_REF | EO_COMP | EO_TYPE);
	/* Keep the count and the element size */
	r_ref = result + size - LNGPAD_2;
	s_ref = source + size - LNGPAD_2;
	*(long *) r_ref = *(long *) s_ref;
	*(long *) (r_ref + sizeof(long)) = *(long *) (s_ref + sizeof(long));

	epop(&loc_stack, 1);				/* Remove GC protection */

	return result;
	EIF_END_GET_CONTEXT
}

rt_public char *edclone(EIF_CONTEXT char *source)
{
	/* Recursive Eiffel clone. This function recursively clones the source
	 * object and returns a pointer to the top of the new tree.
	 */
	EIF_GET_CONTEXT	
	char *root = (char *) 0;		/* Root of the deep cloned object */
	jmp_buf exenv;					/* Environment saving */
	struct {
		union overhead discard;		/* Pseudo object header */
		char *boot;					/* Anchor point for cloning process */
	} anchor;

#ifdef DEBUG
	int xobjs;
#endif

	/* The deep clone of the source will be attached in the 'boot' entry from
	 * the anchor structure. It all happens as if we were in fact deep cloning
	 * the anchor pseudo-object.
	 */

	bzero(&anchor, sizeof(anchor));	/* Reset header */
	anchor.boot = (char *) &root;	/* To boostrap cloning process */

	if (0 == source)
		return (char *) 0;			/* Void source */

	epush(&loc_stack, (char *) &source);	/* Protect source: allocation will occur */

#ifdef DEBUG
	xobjs = nomark(source);
	printf("Source has %x %d objects\n", source, xobjs);
#endif

	/* Set up an exception trap. If any exception occurs, control will be
	 * transferred back here by the run-time to give us a chance to clean-up
	 * our structures.
	 */

	{
	RTXD;							/* Save stack contexts */
	excatch(MTC (char *) exenv);		/* Record pseudo-execution vector */
	if (setjmp(exenv)) {
		RTXSC;						/* Restore stack contexts */
		map_reset(1);				/* Reset in emergency situation */
		ereturn(MTC_NOARG);					/* And propagate the exception */
	}

	/* Now start the traversal of the source, allocating all the objects as
	 * needed and stuffing them into a FIFO stack for later perusal by the
	 * cloning process.
	 */

	obj_nb = 0;						/* Mark objects */
	traversal(source, TR_MAP);		/* Object traversal, mark with EO_STORE */
	hash_malloc(&hclone, obj_nb);	/* Hash table allocation */
	map_start();					/* Restart at bottom of FIFO stack */

#ifdef DEBUG
	printf("Computed %x %d objects\n\n", source, obj_nb);
#endif

	/* Throughout the deep cloning process, we need to maintain the notion of
	 * enclosing object for GC aging tests. The enclosing object is defined as
	 * being the object to which the currently cloned tree will be attached.
	 *
	 * We need to initialize the cloning process by computing a valid reference
	 * into the root variable. That will be the enclosing object, and of course
	 * it cannot be void, ever, or something really really weird is happening.
	 *
	 * To get rid of code duplication, I am initially calling rdeepclone with
	 * an enclosing object address set to anchor.boot. The anchor structure
	 * represents a pseudo anchor object for the object hierarchy being cloned.
	 */

	rdeepclone(source, (char *) &anchor.boot, 0);	/* Recursive clone */
	hash_free(&hclone);						/* Free hash table */
	map_reset(0);							/* And eif_free maping table */

#ifdef DEBUG
	xobjs= nomark(source);
	printf("Source now has %d objects\n", xobjs);
	xobjs = nomark(anchor.boot);
	printf("Result has %d objects\n", xobjs);
#endif

	epop(&loc_stack, 1);		/* Release GC protection */
	expop(&eif_stack);			/* Remove pseudo execution vector */
	}

	return anchor.boot;			/* The cloned object tree */
	EIF_END_GET_CONTEXT
}

rt_public char *rtclone(char *source)
{
	/* Clone source, copy the source in the clone and return the clone */

	EIF_GET_CONTEXT
	char *result;					/* Address of the cloned object */

	if (source == (char *) 0)
		return (char *) 0;

	epush(&loc_stack, (char *) &source);	/* In case object is going to move */

	if (HEADER(source)->ov_flags & EO_SPEC) {
		result = spclone(source);	/* Special object cloning */
		spcopy(source, result);
	} else {
		result = eclone(source);	/* Usual Eiffel object cloning */
		ecopy(source, result);
	}

	epop(&loc_stack, 1);			/* Remove the source object */

	return result;					/* Pointer to the cloned object */
	EIF_END_GET_CONTEXT
}

rt_private char *duplicate(char *source, char *enclosing, int offset)
			 		/* Object to be duplicated */
					/* Object where attachment is made */
		   			/* Offset within enclosing where attachment is made */
{
	/* Duplicate the source object (shallow duplication) and attach the freshly
	 * allocated copy at the address pointed to by receiver, which is protected
	 * against GC movements. Returns the address of the cloned object.
	 */

	union overhead *zone;			/* Malloc info zone */
	uint32 flags;					/* Object's flags */
	uint32 size;					/* Object's size */
	EIF_OBJECT *hash_zone;				/* Hash table entry recording duplication */
	char *clone;					/* Where clone is allocated */

	zone = HEADER(source);			/* Where eif_malloc stores its information */
	flags = zone->ov_flags;			/* Eiffel flags */

	/* If the object is an expanded one, then its size field is in fact an
	 * offset within the enclosing object, and we have to get its size through
	 * its dynamic type.
	 */
	if (flags & EO_EXP)						/* Object is expanded */
		size = Size(Deif_bid(flags));		/* Get its size though skeleton */
	else
		size = zone->ov_size & B_SIZE;		/* Size encoded in header */

	clone = eif_access(map_next());				/* Get next stacked object */
	*(char **) (enclosing + offset) = clone;	/* Attach new object */
	hash_zone = hash_search(&hclone, source);	/* Get an hash table entry */
	bcopy(source, clone, size);					/* Block copy */
	*hash_zone = clone;					/* Fill it in with the clone address */

	/* Once the duplication is done, the receiving object might refer to a new
	 * object (a newly allocated object is always new), and thus aging tests
	 * must be performed, to eventually remember the enclosing object of the
	 * receiver.
	 */

	flags = HEADER(enclosing)->ov_flags;

	if (!(flags & EO_OLD))				/* Receiver is a new object */
		return clone;					/* No aging tests necessary */

	if (flags & EO_REM)					/* Old object is already remembered */
		return clone;					/* No further action necessary */

	if (!(HEADER(clone)->ov_flags & EO_OLD))	/* Copied is a new object */
		erembq(enclosing);				/* Then remember the enclosing object */
	return clone;
}

rt_private void rdeepclone (char *source, char *enclosing, int offset)
			 			/* Source object to be cloned */
						/* Object receiving clone */
		   				/* Offset within enclosing where attachment is made */
{
	/* Recursive deep clone of `source' is attached to `receiver'. Then
	 * enclosing parameter gives us a pointer to where the address of the
	 * currently built object lies, or in other words, it's the object on
	 * which we are currently recurring. That way, we are able to perform aging
	 * tests when the attachment to the receiving reference is done.
	 */

	char *clone, *c_ref, *c_field;
	uint32 flags;
	uint32 size;
	union overhead *zone;
	long count, elem_size;

	zone = HEADER(source);
	flags = zone->ov_flags;

	if (!(flags & EO_STORE)) {		/* Object has already been cloned */

		/* Object is no longer marked: it has already been duplicated and
		 * thus the resulting duplication is in the hash table.
		 */

		clone = *hash_search(&hclone, source);
		*(char **) (enclosing + offset) = clone;
		RTAS(clone, enclosing);
		return;
	}

	/* The object has not already been duplicated */

	flags &= ~EO_STORE;						/* Unmark the object */
	HEADER(source)->ov_flags = flags;		/* Resynchronize object flags */
	clone = duplicate(source, enclosing, offset);	/* Duplicate object */

	/* The object has now been duplicated and entered in the H table */

	if (flags & EO_SPEC) {					/* Special object */
		if (!(flags & EO_REF)){				/* No references */
			return;
		}
		zone = HEADER(clone);
		size = zone->ov_size & B_SIZE;		/* Size of special object */
		c_ref = clone + size - LNGPAD_2;	/* Where count is stored */
		count = *(long *) c_ref;			/* Number of items in special */

		/* If object is filled up with references, loop over it and recursively
		 * deep clone them. If the object has expanded objects, then we need
		 * to update their possible intra expanded fields (in case they
		 * themselves have expanded objects) and also to deep clone them.
		 */

		if (!(flags & EO_COMP))	{	/* Special object filled with references */
			for (offset = 0; count > 0; count--, offset += sizeof(char *)) {
				c_field = *(char **) (clone + offset);
				/* Iteration on non void references and Eiffel references */
				if (0 == c_field || (HEADER(c_field)->ov_flags & EO_C))
					continue;
				rdeepclone(c_field, clone, offset);
			}
		} else {					/* Special filled with expanded objects */
			elem_size = *(long *) (c_ref + sizeof(long));
			for (offset = OVERHEAD; count > 0; count--, offset += elem_size)
				expanded_update(source, clone + offset, DEEP);
		}

	} else
		expanded_update(source, clone, DEEP); /* Update intra expanded refs */
}

rt_public void xcopy(char *source, char *target)
{
	/* Copy 'source' into expanded object 'target' if 'source' is not void,
	 * or raise a "Void assigned to expanded" exception.
	 */
	
	if (source == (char *) 0)
		xraise(MTC EN_VEXP);			/* Void assigned to expanded */
	
	ecopy(source, target);
}

rt_public void ecopy(register char *source, register char *target)
{
	/* Copy Eiffel object `source' into Eiffel object `target'.
	 * Problem: updating intra-references on expanded object
	 * because the garbage collector needs to explore those references.
	 * Dynamic type of `source' is supposed to be the same as dynamic type
	 * of `target'. It assumes also that `source' and `target' are not 
	 * references on special objects.
	 */

	register3 uint32 s_flags;			/* Source object flags */
	register4 uint32 t_flags;			/* Source target flags */
	register5 union overhead *s_zone;	/* Source object header */
	register6 union overhead *t_zone;	/* Target object header */
	char *enclosing;					/* Enclosing target object */
	uint32 size;

	s_zone = HEADER(source);
	s_flags = s_zone->ov_flags;
	t_zone = HEADER(target);
	t_flags = t_zone->ov_flags;
	
	/* Precompute the enclosing target object */
	enclosing = target;					/* By default */
	if ((t_flags & EO_EXP) || (s_flags & EO_EXP)) {
		enclosing -= t_zone->ov_size & B_SIZE;
		size = Size(Deif_bid(t_flags));
		}
	else
		size = s_zone->ov_size & B_SIZE;

	if ((s_flags & EO_TYPE) == (t_flags & EO_TYPE)) {

		/* Copy of source object into target object
		 * with same dynamic type. Block copy here, but references on
		 * expanded must be updated and sepcial objects reallocated.
		 */
		safe_bcopy(source, target, size);

		/* Perform aging tests. We need the address of the enclosing object to
		 * update the flags there, in case the target is to be memorized.
		 */

		t_flags = HEADER(enclosing)->ov_flags;

		if (
			t_flags & EO_OLD &&			/* Object is old */
			!(t_flags & EO_REM)	&&		/* Not remembered */
			refers_new_object(target)	/* And copied refers to new objects */
		)
			erembq(enclosing);			/* Then remember the enclosing object */

		if (s_flags & EO_COMP) {
			/* Case of composite object: updating of references on expanded
			 * objects and duplication of special objects.
			 */
			expanded_update(source, target, SHALLOW);
		}
	}
}

rt_public void spcopy(register char *source, register char *target)
{
	/* Copy a special Eiffel object into another one. It assumes that
	 * `source' and `target' are not NULL. Precondition of redefined
	 * feature `copy' of class SPECIAL ensures that the count of
	 * `source' is greater than `target'.
	 */

	uint32 field_size;
	uint32 flags;

	/* Evaluation of the size field to copy */
	field_size = (HEADER(target)->ov_size & B_SIZE) - LNGPAD_2;

	safe_bcopy(source, target, field_size);			/* Block copy */

	/* Ok, normally we would have to perform age tests, by scanning the special
	 * object, looking for new objects. But a special object can be really big,
	 * and can also contain some expanded objects, which should be traversed
	 * to see if they contain any new objects. Ok, that's enough! This is a
	 * GC problem and is normally performed by the GC. So, if the special object
	 * is old and contains some references, I am automatically inserting it
	 * in the remembered set. The GC will remove it from there at the next
	 * cycle, if necessary--RAM.
	 */

	flags = HEADER(target)->ov_flags;
	if ((flags & (EO_REF | EO_OLD | EO_REM)) == (EO_OLD | EO_REF))
		eremb(target);
}

rt_private void expanded_update(char *source, char *target, int shallow_or_deep)
{
	/*
	 * Update recursively:
	 *		1. expanded references for target `target'.
	 *		2. offsets within subobjects since `source' and `target' may
	 *	come from different containers.
	 * (This is done since copying the source to the target caused the
	 * target's subobjects to have the same offsets and reference points to
	 * its subobjects as the `source').
	 * It assumes that `target' is not a special object and that it
	 * is a composite object.
	 */

	register4 union overhead *zone;			/* Target Object header */
	register2 long nb_ref;					/* Number of references */
	register3 uint32 flags;					/* Target flags */
	register1 char *t_reference;			/* Target reference */
	register5 char *s_reference;			/* Source reference */
	char *t_enclosing;						/* Enclosing object */
	char *s_enclosing;						/* Enclosing object */
	int t_offset = 0;						/* Offset within target */
	int s_offset = 0;						/* Offset within target */
	int temp_offset = 0;					/* Offset within target */
	int s_sub_offset = 0;					/* Subobject offset */
	int offset1 = 0;						/* Offset within target */
	int offset2 = 0;						/* Offset within target */
	char *t_expanded;
	char *s_expanded;

	/* Compute the enclosing object (i.e. the object which contains the target).
	 * Normally this is the object itself, unless the target is expanded.
	 */

	t_enclosing = target;					/* Default enclosing object is itself */
	s_enclosing = source;					/* Default enclosing object is itself */
	zone = HEADER(target);					/* Malloc info zone */
	flags = zone->ov_flags;					/* Eiffel object flags */
	if (flags & EO_EXP) {
		offset2 = zone->ov_size & B_SIZE;
		t_offset = zone->ov_size & B_SIZE;	/* Target expanded offset within object */
		t_enclosing = target - t_offset;	/* Address of target enclosing object */
	}
	zone = HEADER(source);
	flags = zone->ov_flags;					/* Source eiffel object flags */
	if (flags & EO_EXP) {
		offset1 = zone->ov_size & B_SIZE;
		s_offset = zone->ov_size & B_SIZE;	/* Expanded offset within object */
		s_enclosing = source - s_offset;		/* Address of enclosing object */
	}

	nb_ref = References(Deif_bid(flags));		/* References in target */

	/* Iteration on the references of the object */
	for (
		/* empty */;
		nb_ref > 0;
		nb_ref--, t_offset += sizeof(char *), s_offset += sizeof(char *)
	) {
		t_reference = *(char **) (t_enclosing + t_offset);
		if (0 == t_reference)
			continue;		/* Void reference */

		zone = HEADER(t_reference);
		flags = zone->ov_flags;

		if (flags & EO_EXP) {		/* Object is expanded */

			/* We reached an intra reference on an expanded object. There are
			 * two points to consider:
			 *   1/ updating intra reference for garbage collection
			 *   2/ possible recursion on the expanded object itself
			 * The size indicated via the zone header is the offset of the
			 * expanded object within its enclosing father.
			 */

			s_reference = *(char **) (s_enclosing + s_offset);
			s_sub_offset = HEADER(s_reference)->ov_size & B_SIZE;
									/* Get offset from source expanded */
			temp_offset = s_sub_offset - offset1;

									/* Corresponding expanded in target object */
			t_expanded = t_enclosing + offset2 + temp_offset;
									/* Update reference point to sub-object */ 
			*(char **) (t_enclosing + t_offset) = t_expanded;
			t_reference = *(char **) (t_enclosing + t_offset);
									/* Update offset in header */ 
			zone = HEADER(t_reference);
			zone->ov_size = offset2 + temp_offset;

			s_expanded = s_enclosing + s_sub_offset;
			/* Recursive updating is needed if we are in a DEEP clone or if
			 * the object is composite, i.e. contains expanded objects.
			 */

			if (flags & EO_COMP || shallow_or_deep == DEEP)
				expanded_update(s_expanded, t_expanded, shallow_or_deep);

		} else if (shallow_or_deep == DEEP) {	/* Not expanded */

			/* Run rdeepclone recursively only if the reference is not a C
			 * pointer, i.e. does not refer to a eif_malloc'ed C object which
			 * happens to have been attached to an Eiffel reference.
			 */
			if (!(flags & EO_C)) {
				rdeepclone(t_reference, t_enclosing, t_offset);
			}
		}
	}
}

rt_public EIF_BOOLEAN c_check_assert (EIF_BOOLEAN b)
{

	/*
	 * Set `in_assertion' to `b', and return the previous value 
	 * of `in_assertion' (needed for the `clone feature in class
	 * GENERAL to turn assertion checking of before the call to
	 * `setup'
	 */

	EIF_GET_CONTEXT
	EIF_BOOLEAN temp;

	temp = ((in_assertion != (int) 0)?(EIF_BOOLEAN)0:(EIF_BOOLEAN)1);
	in_assertion = ((b != (EIF_BOOLEAN) 0)?0:~0);

	return ((EIF_BOOLEAN) temp);
	EIF_END_GET_CONTEXT
}

rt_public void spsubcopy (EIF_POINTER source, EIF_POINTER target, EIF_INTEGER start, EIF_INTEGER end, EIF_INTEGER strchr)
{
	/* Copy elements of `source' within bounds `start'..`end'
	 * to `target' starting at index `index'.
	 * Indexes are assumed to start from 0 and we assume that
	 * memory has been properly allocated beforehand.
	 */

	EIF_INTEGER esize, count; /* %%ss removed , i; */
	char *ref; /* %%ss removed , *src_ref; */
	uint32 flags;

	count = end - start + 1;
	ref = source + (HEADER(source)->ov_size & B_SIZE) - LNGPAD_2;
	esize = *(long *) (ref + sizeof(long));
	safe_bcopy(source+start*esize, target+index*esize, count*esize);

	/* Ok, normally we would have to perform age tests, by scanning the special
	 * object, looking for new objects. But a special object can be really big,
	 * and can also contain some expanded objects, which should be traversed
	 * to see if they contain any new objects. Ok, that's enough! This is a
	 * GC problem and is normally performed by the GC. So, if the special object
	 * is old and contains some references, I am automatically inserting it
	 * in the remembered set. The GC will remove it from there at the next
	 * cycle, if necessary--RAM.
	 */

	flags = HEADER(target)->ov_flags;
	if ((flags & (EO_REF | EO_OLD | EO_REM)) == (EO_OLD | EO_REF))
		eremb(target);
}

rt_public void spclearall (EIF_POINTER spobj)
{
	/* Reset all elements of `spobj' to default value. Call
	 * creation procedure of expanded objects if `spobj' is
	 * composite.
	 */

	union overhead *zone;			/* Malloc information zone */
	char  *(*init)(char *);				/* Initialization routine to be called */
	long i, count, elem_size;
	int dtype, dftype;
	char *ref;

	zone = HEADER(spobj);
	ref = spobj + (zone->ov_size & B_SIZE) - LNGPAD_2;
	count = *(long *) ref;
	elem_size = *(long *) (ref + sizeof(long));

	if (zone->ov_flags & EO_COMP) {
			/* case of a special object of expanded structures */
		ref = spobj + OVERHEAD;
		dftype = HEADER(ref)->ov_flags & EO_TYPE;
		dtype = Deif_bid(dftype);
		bzero(spobj, count * elem_size);
			/* Initialize new expanded elements, if any */
		init = (char *(*)(char *)) (XCreate(dtype)); /* %%ss cast? added */
#ifdef MAY_PANIC
		if ((char *(*)(char *)) 0 == init)		/* There MUST be a routine */
			eif_panic("Init routine lost");
#endif
		for (i = 0; i < count; i++, ref += elem_size) {
			zone = HEADER(ref);
			zone->ov_size = ref - spobj;	/* For GC */
			zone->ov_flags = dftype;			/* Expanded type */
			(init)(ref);					/* Call initialization routine */
		}
	} else
		bzero(spobj, count * elem_size);
}
