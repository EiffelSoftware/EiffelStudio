/*

  ####    ####   #####    #   #           ####
 #    #  #    #  #    #    # #           #    #
 #       #    #  #    #     #            #
 #       #    #  #####      #     ###    #
 #    #  #    #  #          #     ###    #    #
  ####    ####   #          #     ###     ####

	Multiple copy routines.
*/

#include "eif_portable.h"
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
#include "rt_macros.h"
#include "x2c.h"		/* For macro LNGPAD */
#include <string.h>
#include "rt_assert.h"

#define SHALLOW		1		/* Copy first level only */
#define DEEP		2		/* Recursive copy */

/*#define DEBUG 	*/

/* The following hash table is used to keep the maping between cloned objects,
 * so that we know for instance where we put the clone for object X. It takes
 * a pointer and yields an EIF_OBJECT.
 */
rt_private struct hash hclone;			/* Cloning hash table */

/* Function declarations */
rt_private void rdeepclone(EIF_REFERENCE source, EIF_REFERENCE enclosing, int offset);			/* Recursive cloning */
rt_private void expanded_update(EIF_REFERENCE source, EIF_REFERENCE target, int shallow_or_deep);		/* Expanded reference update */
rt_private EIF_REFERENCE duplicate(EIF_REFERENCE source, EIF_REFERENCE enclosing, int offset);			/* Duplication with aging tests */
rt_private EIF_REFERENCE spclone(register EIF_REFERENCE source);/* Clone for special object */
rt_private void spcopy(register EIF_REFERENCE source, register EIF_REFERENCE target);

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

rt_public EIF_REFERENCE eclone(register EIF_REFERENCE source)
{
	/* Clone an of Eiffel object `source'. Might move `source' */

	register uint32 flags = HEADER(source)->ov_flags;

  	REQUIRE ("source not null", source);

	if (flags & EO_SPEC) 
		return spclone (source);
	else if ((int16)(flags & EO_TYPE) == (int16) egc_bit_dtype)
		return b_clone(source);
	else
		return emalloc(flags & EO_TYPE);
}

rt_public void ecopy(register EIF_REFERENCE source, register EIF_REFERENCE target)
{
	/* Copy Eiffel object `source' into Eiffel object `target'.
	 * Problem: updating intra-references on expanded object
	 * because the garbage collector needs to explore those references.
	 */

	register uint32 flags = HEADER(source)->ov_flags;

	REQUIRE ("source_not_null", source);
	REQUIRE ("target_not_null", target);
	REQUIRE ("Same type", Dftype(source) == Dftype(target));

	if (flags & EO_SPEC)
		spcopy(source, target);
	else if ((int16)(flags & EO_TYPE) == (int16) egc_bit_dtype)
		b_copy(source, target);
	else
		eif_std_ref_copy(source, target);

	ENSURE ("equals", eequal (target, source));
}

rt_private EIF_REFERENCE spclone(EIF_REFERENCE source)
{
	/* Clone an of Eiffel object `source'. Assumes that source
	 * is a special object.
	 */
	
	EIF_GET_CONTEXT
	register4 EIF_REFERENCE result;		/* Clone pointer */
	register1 union overhead *zone;		/* Pointer on source header */
	register2 uint32 flags;				/* Source object flags */
	register3 uint32 size;				/* Source object size */
	EIF_REFERENCE s_ref, r_ref;

	if ((EIF_REFERENCE) 0 == source)
		return (EIF_REFERENCE) 0;				/* Void source */

	RT_GC_PROTECT(source);			/* Protection against GC */

	zone = HEADER(source);				/* Allocation of a new object */
	flags = zone->ov_flags;
	size = zone->ov_size & B_SIZE;
	if (!(flags & EO_REF))
		result = spmalloc(size, EIF_TRUE);	/* Special object without references in it */
	else
		result = spmalloc(size, EIF_FALSE);	/* Special object with references */

		/* Keep the reference flag and the composite one and the type */
	HEADER(result)->ov_flags |= flags & (EO_REF | EO_COMP | EO_TYPE);
		/* Keep the count and the element size */
	r_ref = result + size - LNGPAD_2;
	s_ref = source + size - LNGPAD_2;
	*(long *) r_ref = *(long *) s_ref;
	*(long *) (r_ref + sizeof(long)) = *(long *) (s_ref + sizeof(long));

	RT_GC_WEAN(source);				/* Remove GC protection */

	return result;
}

rt_public EIF_REFERENCE edclone(EIF_CONTEXT EIF_REFERENCE source)
{
	/* Recursive Eiffel clone. This function recursively clones the source
	 * object and returns a pointer to the top of the new tree.
	 */
	EIF_GET_CONTEXT	
	EIF_REFERENCE root = (EIF_REFERENCE)  0;		/* Root of the deep cloned object */
	jmp_buf exenv;					/* Environment saving */
	struct {
		union overhead discard;		/* Pseudo object header */
		EIF_REFERENCE boot;					/* Anchor point for cloning process */
	} anchor;

#ifdef DEBUG
	int xobjs;
#endif

	/* The deep clone of the source will be attached in the 'boot' entry from
	 * the anchor structure. It all happens as if we were in fact deep cloning
	 * the anchor pseudo-object.
	 */

	memset (&anchor, 0, sizeof(anchor));	/* Reset header */
	anchor.boot = (EIF_REFERENCE)  &root;	/* To boostrap cloning process */

	if (0 == source)
		return (EIF_REFERENCE) 0;			/* Void source */

	RT_GC_PROTECT(source);	/* Protect source: allocation will occur */

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
	excatch(&exenv);		/* Record pseudo-execution vector */
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

	rdeepclone(source, (EIF_REFERENCE) &anchor.boot, 0);	/* Recursive clone */
	hash_free(&hclone);						/* Free hash table */
	map_reset(0);							/* And eif_free maping table */

#ifdef DEBUG
	xobjs= nomark(source);
	printf("Source now has %d objects\n", xobjs);
	xobjs = nomark(anchor.boot);
	printf("Result has %d objects\n", xobjs);
#endif

	RT_GC_WEAN(source);			/* Release GC protection */
	expop(&eif_stack);			/* Remove pseudo execution vector */
	}

	return anchor.boot;			/* The cloned object tree */
}

rt_public EIF_REFERENCE rtclone(EIF_REFERENCE source)
{
	/* Clone source, copy the source in the clone and return the clone */

	EIF_GET_CONTEXT
	EIF_REFERENCE result = NULL;					/* Address of the cloned object */

	if (source == (EIF_REFERENCE) 0)
		return (EIF_REFERENCE) 0;

		/* Object protections in case of GC cycle */
	RT_GC_PROTECT(source);
	RT_GC_PROTECT(result);

	result = eclone (source);	/* Clone object */
	ecopy (source, result);		/* Performs copy from `source' to `result' */

	RT_GC_WEAN_N(2);				/* Remove protection */

	ENSURE ("result_created", result);
	return result;					/* Pointer to the cloned object */
}

rt_private EIF_REFERENCE duplicate(EIF_REFERENCE source, EIF_REFERENCE enclosing, int offset)
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
	EIF_REFERENCE clone;					/* Where clone is allocated */

	zone = HEADER(source);			/* Where eif_malloc stores its information */
	flags = zone->ov_flags;			/* Eiffel flags */

	/* If the object is an expanded one, then its size field is in fact an
	 * offset within the enclosing object, and we have to get its size through
	 * its dynamic type.
	 */
	if (flags & EO_EXP)						/* Object is expanded */
		size = EIF_Size(Deif_bid(flags));		/* Get its size though skeleton */
	else
		size = zone->ov_size & B_SIZE;		/* Size encoded in header */

	clone = eif_access(map_next());				/* Get next stacked object */
	*(EIF_REFERENCE *)  (enclosing + offset) = clone;	/* Attach new object */
	hash_zone = hash_search(&hclone, source);	/* Get an hash table entry */
	memcpy (clone, source, size);				/* Block copy */
	*hash_zone = clone;					/* Fill it in with the clone address */

#ifdef ISE_GC
	/* Once the duplication is done, the receiving object might refer to a new
	 * object (a newly allocated object is always new), and thus aging tests
	 * must be performed, to eventually remember the enclosing object of the
	 * receiver.
	 */

	flags = HEADER(enclosing)->ov_flags;

	if (!(flags & EO_OLD))				/* Receiver is a new object */
		return clone;					/* No aging tests necessary */

	if (HEADER (clone)->ov_flags & EO_OLD)		/* Old object with old reference.*/
		return clone;					/* No further action necessary */

	CHECK ("Object is old and has reference to new one",
		   (flags & EO_OLD) && !(HEADER (clone)->ov_flags & EO_OLD));

#ifdef EIF_REM_SET_OPTIMIZATION
	if ((flags & (EO_SPEC | EO_REF)) == (EO_SPEC | EO_REF))
		/* In this special case, we have to remember 
		 * the couple (special<->item index)
		 * in the special_rem_table.	-- ET
		 */
	{
		special_erembq (enclosing, offset >> EIF_REFERENCE_BITS);
		CHECK ("clone is referenced from enclosing", *(EIF_REFERENCE *) (enclosing + offset) == clone);
	}
	else if (flags & EO_REM)			/* Old object is already remembered */
			return clone;				/* No further action necessary */
	else
		erembq(enclosing);				/* Then remember the enclosing object */
#else	/* EIF_REM_SET_OPTIMIZATION */
	if (flags & EO_REM)					/* Old object is already remembered */
			return clone;					/* No further action necessary */
	else
		erembq(enclosing);				/* Then remember the enclosing object */
		
#endif	/* EIF_REM_SET_OPTIMIZATION */
#endif /* ISE_GC */
	
	return clone;
}

rt_private void rdeepclone (EIF_REFERENCE source, EIF_REFERENCE enclosing, int offset)
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

	EIF_REFERENCE clone, c_ref, c_field;
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
		*(EIF_REFERENCE *) (enclosing + offset) = clone;
		CHECK ("Not forwarded", !(HEADER (enclosing)->ov_size & B_FWD));
#ifdef ISE_GC
#ifdef EIF_REM_SET_OPTIMIZATION
		if ((HEADER (enclosing)->ov_flags & (EO_REF | EO_SPEC)) == (EO_REF | EO_SPEC)) {
			RTAS_OPT (clone, offset >> EIF_REFERENCE_BITS, enclosing);
		} else {
			RTAS(clone, enclosing);
		}
#else	/* EIF_REM_SET_OPTIMIZATION */
		RTAS(clone, enclosing);
#endif	/* EIF_REM_SET_OPTIMIZATION */
#endif /* ISE_GC */
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
			for (offset = 0; count > 0; count--, offset += REFSIZ) {
				c_field = *(EIF_REFERENCE *) (clone + offset);
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

rt_public void xcopy(EIF_REFERENCE source, EIF_REFERENCE target)
{
	/* Copy 'source' into expanded object 'target' if 'source' is not void,
	 * or raise a "Void assigned to expanded" exception.
	 */
	
	if (source == (EIF_REFERENCE)  0)
		xraise(MTC EN_VEXP);			/* Void assigned to expanded */
	
	eif_std_ref_copy(source, target);
}

rt_public void eif_std_ref_copy(register EIF_REFERENCE source, register EIF_REFERENCE target)
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
	EIF_REFERENCE enclosing;					/* Enclosing target object */
	uint32 size;

	s_zone = HEADER(source);
	s_flags = s_zone->ov_flags;
	t_zone = HEADER(target);
	t_flags = t_zone->ov_flags;
	
	/* Precompute the enclosing target object */
	enclosing = target;					/* By default */
	if ((t_flags & EO_EXP) || (s_flags & EO_EXP)) {
		enclosing -= t_zone->ov_size & B_SIZE;
		size = EIF_Size(Deif_bid(t_flags));
		}
	else
		size = s_zone->ov_size & B_SIZE;

	if ((s_flags & EO_TYPE) == (t_flags & EO_TYPE)) {

		/* Copy of source object into target object
		 * with same dynamic type. Block copy here, but references on
		 * expanded must be updated and special objects reallocated.
		 */
		memmove(target, source, size);

#ifdef ISE_GC
		/* Perform aging tests. We need the address of the enclosing object to
		 * update the flags there, in case the target is to be memorized.
		 */
		t_flags = HEADER(enclosing)->ov_flags;
		CHECK ("Not forwarded", !(HEADER (enclosing)->ov_size & B_FWD));

#ifdef EIF_REM_SET_OPTIMIZATION
		if (
			(t_flags & EO_OLD) &&			/* Object is old */
			refers_new_object(target)	/* And copied refers to new objects */
		)
		{
			if ((t_flags & (EO_SPEC | EO_REF)) == (EO_SPEC | EO_REF)) {
					/* Only remember the couple (special<->new object index). */
				if (-2 == eif_promote_special (enclosing))
					eif_panic ("There must be a young reference.");
			} else if (!(t_flags & EO_REM))	/* normal object not remembered. */
				erembq(enclosing);		/* Then remember the enclosing object */
		}
#else	/* EIF_REM_SET_OPTIMIZATION */
		if (
			t_flags & EO_OLD &&			/* Object is old */
			!(t_flags & EO_REM)	&&		/* Not remembered */
			refers_new_object(target)	/* And copied refers to new objects */
		)
			erembq(enclosing);			/* Then remember the enclosing object */
#endif	/* EIF_REM_SET_OPTIMIZATION */
#endif /* ISE_GC */

		if (s_flags & EO_COMP) {
			/* Case of composite object: updating of references on expanded
			 * objects and duplication of special objects.
			 */
			expanded_update(source, target, SHALLOW);
		}
	}
}

rt_private void spcopy(register EIF_REFERENCE source, register EIF_REFERENCE target)
{
	/* Copy a special Eiffel object into another one. It assumes that
	 * `source' and `target' are not NULL. Precondition of redefined
	 * feature `copy' of class SPECIAL ensures that the count of
	 * `source' is greater than `target'.
	 */

	uint32 field_size;
	uint32 flags;

	REQUIRE ("source not null", source);
	REQUIRE ("target not null", target);

	/* Evaluation of the size field to copy */
	field_size = (HEADER(target)->ov_size & B_SIZE) - LNGPAD_2;

	memmove(target, source, field_size);			/* Block copy */

#ifdef ISE_GC
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
	CHECK ("Not forwarded", !(HEADER (target)->ov_flags & B_FWD));
#ifdef EIF_REM_SET_OPTIMIZATION
	if ((flags & (EO_REF | EO_OLD )) == (EO_OLD | EO_REF)) 
			/* Do we need to check if it holds young references? */
		eif_promote_special (target);	/* Promote it, if necessary. */
#else	/* EIF_REM_SET_OPTIMIZATION */
	if ((flags & (EO_REF | EO_OLD | EO_REM)) == (EO_OLD | EO_REF))
			/* May it hold new references? */
			eremb(target);	/* Remember it, even if not needed, to fasten
								copying process. */
#endif	/* EIF_REM_SET_OPTIMIZATION */
#endif /* ISE_GC */
}

rt_private void expanded_update(EIF_REFERENCE source, EIF_REFERENCE target, int shallow_or_deep)
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
	register1 EIF_REFERENCE t_reference;			/* Target reference */
	register5 EIF_REFERENCE s_reference;			/* Source reference */
	EIF_REFERENCE t_enclosing;						/* Enclosing object */
	EIF_REFERENCE s_enclosing;						/* Enclosing object */
	int t_offset = 0;						/* Offset within target */
	int s_offset = 0;						/* Offset within target */
	int temp_offset = 0;					/* Offset within target */
	int s_sub_offset = 0;					/* Subobject offset */
	int offset1 = 0;						/* Offset within target */
	int offset2 = 0;						/* Offset within target */
	EIF_REFERENCE t_expanded;
	EIF_REFERENCE s_expanded;

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
		nb_ref--, t_offset += REFSIZ, s_offset += REFSIZ 
	) {
		t_reference = *(EIF_REFERENCE *) (t_enclosing + t_offset);
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

			s_reference = *(EIF_REFERENCE *) (s_enclosing + s_offset);
			s_sub_offset = HEADER(s_reference)->ov_size & B_SIZE;
									/* Get offset from source expanded */
			temp_offset = s_sub_offset - offset1;

									/* Corresponding expanded in target object */
			t_expanded = t_enclosing + offset2 + temp_offset;
									/* Update reference point to sub-object */ 
			*(EIF_REFERENCE *) (t_enclosing + t_offset) = t_expanded;
			t_reference = *(EIF_REFERENCE *) (t_enclosing + t_offset);
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

	temp = (EIF_BOOLEAN) ((in_assertion != (int) 0)? 0: 1);
	in_assertion = ((b != (EIF_BOOLEAN) 0)?0:~0);

	return ((EIF_BOOLEAN) temp);
}

rt_public void spsubcopy (EIF_REFERENCE source, EIF_REFERENCE target, EIF_INTEGER start, EIF_INTEGER end, EIF_INTEGER strchr)
{
	/* Copy elements of `source' within bounds `start'..`end'
	 * to `target' starting at index `index'.
	 * Indexes are assumed to start from 0 and we assume that
	 * memory has been properly allocated beforehand.
	 */

	EIF_INTEGER esize, count; /* %%ss removed , i; */
	EIF_REFERENCE ref; /* %%ss removed , *src_ref; */
	uint32 flags;

	REQUIRE ("Special object", HEADER (source)->ov_flags & EO_SPEC);

	count = end - start + 1;
	ref = source + (HEADER(source)->ov_size & B_SIZE) - LNGPAD_2;
	esize = *(long *) (ref + sizeof(long));
	memmove(target+index*esize,source+start*esize, count*esize);

#ifdef ISE_GC
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
#ifdef EIF_REM_SET_OPTIMIZATION
	if ((flags & (EO_REF | EO_OLD )) == (EO_OLD | EO_REF)) 
			/* Do we need to check if it holds young references? */
		eif_promote_special (target);	/* Promote it, if necessary. */
#else	/* EIF_REM_SET_OPTIMIZATION */
	if ((flags & (EO_REF | EO_OLD | EO_REM)) == (EO_OLD | EO_REF))
			/* May it hold new references? */
			eremb(target);	/* Remember it, even if not needed, to fasten
								copying process. */
#endif	/* EIF_REM_SET_OPTIMIZATION */
#endif /* ISE_GC */

}	/* spsubcopy () */

rt_public void spclearall (EIF_REFERENCE spobj)
{
	/* Reset all elements of `spobj' to default value. Call
	 * creation procedure of expanded objects if `spobj' is
	 * composite.
	 */

	EIF_GET_CONTEXT

	union overhead *zone;			/* Malloc information zone */
	void  *(*init)(EIF_REFERENCE, EIF_REFERENCE);	/* Initialization routine to be called */
	long i, count, elem_size;
	int dtype, dftype;
	EIF_REFERENCE ref;

	zone = HEADER(spobj);
	ref = spobj + (zone->ov_size & B_SIZE) - LNGPAD_2;
	count = *(long *) ref;
	elem_size = *(long *) (ref + sizeof(long));

	if (zone->ov_flags & EO_COMP) {
			/* case of a special object of expanded structures */
		ref = spobj + OVERHEAD;
		dftype = HEADER(ref)->ov_flags & EO_TYPE;
		dtype = Deif_bid(dftype);
		memset (spobj, 0, count * elem_size);
			/* Initialize new expanded elements, if any */
		init = (void *(*)(EIF_REFERENCE, EIF_REFERENCE)) (XCreate(dtype));
		for (i = 0; i < count; i++, ref += elem_size) {
			zone = HEADER(ref);
			zone->ov_size = ref - spobj;	/* For GC */
			zone->ov_flags = dftype;		/* Expanded type */
			if (init) {
				RT_GC_PROTECT(ref);
				(init)(ref, ref);			/* Call initialization routine if any */
				RT_GC_WEAN(ref);
			}
		}
	} else
		memset (spobj, 0, count * elem_size);
}
