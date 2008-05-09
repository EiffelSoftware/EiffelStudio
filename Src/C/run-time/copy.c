/*
	description: "Implementation of copying/cloning routines of ANY."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2007, Eiffel Software."
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
doc:<file name="copy.c" header="eif_copy.h" version="$Id$" summary="Various object copy mechanism">
*/

#include "eif_portable.h"
#include "eif_eiffel.h"
#include "eif_copy.h"
#include "rt_traverse.h"		/* For deep copies */

#if ! defined CUSTOM || defined NEED_HASH_H
#include "rt_hash.h"			/* For deep copies */
#endif

#include "rt_struct.h"
#include "rt_except.h"
#include "eif_local.h"
#include "eif_hector.h"
#include "rt_garcol.h"
#include "rt_macros.h"
#include "rt_gen_types.h"
#include "rt_globals.h"
#include "eif_size.h"		/* For macro LNGPAD */
#include <string.h>
#include "rt_assert.h"

#define SHALLOW		1		/* Copy first level only */
#define DEEP		2		/* Recursive copy */

/*#define DEBUG 	*/


#ifndef EIF_THREADS
/*
doc:	<attribute name="hclone" return_type="struct hash" export="private">
doc:		<summary>The following hash table is used to keep the maping between cloned objects, so that we know for instance where we put the clone for object X. It takes a pointer and yields an EIF_OBJECT.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Private per thread data</synchronization>
doc:		<eiffel_classes>ISE_RUNTIME</eiffel_classes>
doc:	</attribute>
*/
rt_private struct hash hclone;			/* Cloning hash table */
#endif

/* Function declarations */
rt_private void rdeepclone(EIF_REFERENCE source, EIF_REFERENCE enclosing, rt_uint_ptr offset);			/* Recursive cloning */
rt_private void expanded_update(EIF_REFERENCE source, EIF_REFERENCE target, int shallow_or_deep);		/* Expanded reference update */
rt_private EIF_REFERENCE duplicate(EIF_REFERENCE source, EIF_REFERENCE enclosing, rt_uint_ptr offset);			/* Duplication with aging tests */
rt_private EIF_REFERENCE spclone(register EIF_REFERENCE source);/* Clone for special object */
rt_private void spcopy(register EIF_REFERENCE source, register EIF_REFERENCE target);
rt_private void tuple_copy(register EIF_REFERENCE source, register EIF_REFERENCE target);

rt_public EIF_REFERENCE eclone(register EIF_REFERENCE source)
{
	/* Clone an of Eiffel object `source'. Might move `source' */

	register uint16 flags = HEADER(source)->ov_flags;
	EIF_TYPE_INDEX dftype = Dftype(source);

  	REQUIRE ("source not null", source);

	if (flags & EO_SPEC) {
		if (flags & EO_TUPLE) {
				/* We simply create a new instance of the same type */
			return RTLNT(dftype);
		} else {
			return spclone (source);
		}
	} else if (dftype == egc_bit_dtype) {
		return b_clone(source);
	} else {
		return emalloc(dftype);
	}
}

rt_public void ecopy(register EIF_REFERENCE source, register EIF_REFERENCE target)
{
	/* Copy Eiffel object `source' into Eiffel object `target'.
	 * Problem: updating intra-references on expanded object
	 * because the garbage collector needs to explore those references.
	 */

	register uint16 flags = HEADER(source)->ov_flags;

	REQUIRE ("source_not_null", source);
	REQUIRE ("target_not_null", target);
	REQUIRE ("Same type", Dftype(source) == Dftype(target));

	if (flags & EO_SPEC) {
		if (flags & EO_TUPLE) {
			tuple_copy(source, target);
		} else {
			spcopy(source, target);
		}
	} else if (Dftype(source) == egc_bit_dtype) {
		b_copy(source, target);
	} else {
		eif_std_ref_copy(source, target);
	}

	ENSURE ("equals", eequal (target, source));
}

rt_private EIF_REFERENCE spclone(EIF_REFERENCE source)
{
	/* Clone an of Eiffel object `source'. Assumes that source
	 * is a special object.
	 */
	
	EIF_GET_CONTEXT
	EIF_REFERENCE result;		/* Clone pointer */
	union overhead *zone;		/* Pointer on source header */
	uint16 flags;				/* Source object flags */
	EIF_TYPE_INDEX dtype, dftype;
	EIF_REFERENCE s_ref, r_ref;

	if ((EIF_REFERENCE) 0 == source)
		return (EIF_REFERENCE) 0;				/* Void source */

	RT_GC_PROTECT(source);			/* Protection against GC */

	zone = HEADER(source);				/* Allocation of a new object */
	flags = zone->ov_flags;
	dtype = zone->ov_dtype;
	dftype = zone->ov_dftype;
	result = spmalloc(zone->ov_size & B_SIZE, EIF_TEST(!(flags & EO_REF)));

		/* Keep the reference flag and the composite one and the type */
	HEADER(result)->ov_flags |= flags & (EO_REF | EO_COMP);
	HEADER(result)->ov_dtype = dtype;
	HEADER(result)->ov_dftype = dftype;
		/* Keep the count and the element size */
	r_ref = RT_SPECIAL_INFO(result);
	s_ref = RT_SPECIAL_INFO(source);
	RT_SPECIAL_COUNT_WITH_INFO(r_ref) = RT_SPECIAL_COUNT_WITH_INFO(s_ref);
	RT_SPECIAL_ELEM_SIZE_WITH_INFO(r_ref) = RT_SPECIAL_ELEM_SIZE_WITH_INFO (s_ref);

	RT_GC_WEAN(source);				/* Remove GC protection */

	return result;
}

rt_public EIF_REFERENCE edclone(EIF_CONTEXT EIF_REFERENCE source)
{
	/* Recursive Eiffel clone. This function recursively clones the source
	 * object and returns a pointer to the top of the new tree.
	 */
	RT_GET_CONTEXT
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

	if (0 == source)
		return (EIF_REFERENCE) 0;			/* Void source */

	/* The deep clone of the source will be attached in the 'boot' entry from
	 * the anchor structure. It all happens as if we were in fact deep cloning
	 * the anchor pseudo-object.
	 */

	memset (&anchor, 0, sizeof(anchor));	/* Reset header */
	anchor.boot = (EIF_REFERENCE)  &root;	/* To boostrap cloning process */

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
	RTYD;							/* Save stack contexts */
	EIF_EO_STORE_LOCK;				/* Because we perform a traversal that marks
									   objects, we need to be sure we are the
									   only one doing it. */
	excatch(&exenv);		/* Record pseudo-execution vector */
	if (setjmp(exenv)) {
		RTXSC;						/* Restore stack contexts */
		map_reset(1);				/* Reset in emergency situation */
		EIF_EO_STORE_UNLOCK;		/* Free marking mutex */
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

	EIF_EO_STORE_UNLOCK;		/* Free marking mutex */

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

rt_private EIF_REFERENCE duplicate(EIF_REFERENCE source, EIF_REFERENCE enclosing, rt_uint_ptr offset)
			 		/* Object to be duplicated */
					/* Object where attachment is made */
		   			/* Offset within enclosing where attachment is made */
{
	/* Duplicate the source object (shallow duplication) and attach the freshly
	 * allocated copy at the address pointed to by receiver, which is protected
	 * against GC movements. Returns the address of the cloned object.
	 */

	RT_GET_CONTEXT
	union overhead *zone;			/* Malloc info zone */
	uint16 flags;					/* Object's flags */
	rt_uint_ptr size;					/* Object's size */
	EIF_REFERENCE *hash_zone;				/* Hash table entry recording duplication */
	EIF_REFERENCE clone;					/* Where clone is allocated */

	REQUIRE("source not null", source);
	REQUIRE("enclosing not null", enclosing);

	zone = HEADER(source);			/* Where eif_malloc stores its information */
	flags = zone->ov_flags;			/* Eiffel flags */

	/* If the object is an expanded one, then its size field is in fact an
	 * offset within the enclosing object, and we have to get its size through
	 * its dynamic type.
	 */
	if (eif_is_nested_expanded(flags))						/* Object is expanded */
		size = EIF_Size(zone->ov_dtype);		/* Get its size though skeleton */
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

	if (flags & EO_REM)					/* Old object is already remembered */
		return clone;					/* No further action necessary */
	else
		erembq(enclosing);				/* Then remember the enclosing object */
		
#endif /* ISE_GC */
	
	return clone;
}

rt_private void rdeepclone (EIF_REFERENCE source, EIF_REFERENCE enclosing, rt_uint_ptr offset)
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

	RT_GET_CONTEXT
	EIF_REFERENCE clone, c_ref, c_field;
	uint16 flags;
	EIF_INTEGER count, elem_size;

	REQUIRE("source not null", source);
	REQUIRE("enclsoing not null", enclosing);

	flags = HEADER(source)->ov_flags;

	if (!(flags & EO_STORE)) {		/* Object has already been cloned */

		/* Object is no longer marked: it has already been duplicated and
		 * thus the resulting duplication is in the hash table.
		 */

		clone = *hash_search(&hclone, source);
		*(EIF_REFERENCE *) (enclosing + offset) = clone;
		CHECK ("Not forwarded", !(HEADER (enclosing)->ov_size & B_FWD));
		RTAR(enclosing, clone);
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
		c_ref = RT_SPECIAL_INFO(clone);
		count = RT_SPECIAL_COUNT_WITH_INFO (c_ref);			/* Number of items in special */

		/* If object is filled up with references, loop over it and recursively
		 * deep clone them. If the object has expanded objects, then we need
		 * to update their possible intra expanded fields (in case they
		 * themselves have expanded objects) and also to deep clone them.
		 */

		if (flags & EO_TUPLE) {
			EIF_TYPED_VALUE * l_target = (EIF_TYPED_VALUE *) clone;
			EIF_TYPED_VALUE * l_source = (EIF_TYPED_VALUE *) source;
				/* Don't forget that first element of TUPLE is the BOOLEAN
				 * `object_comparison' attribute. */
			for (offset = 0; count > 0; count--, l_target++, l_source++, offset +=sizeof(EIF_TYPED_VALUE)) {
				if (eif_is_reference_tuple_item(l_source)) {
					c_field = eif_reference_tuple_item(l_target);
					if (c_field) {
						rdeepclone(c_field, clone, offset);
					}
				}
			}
		} else if (!(flags & EO_COMP))	{	/* Special object filled with references */
			for (offset = 0; count > 0; count--, offset += REFSIZ) {
				c_field = *(EIF_REFERENCE *) (clone + offset);
				/* Iteration on non void references and Eiffel references */
				if (0 == c_field || (HEADER(c_field)->ov_flags & EO_C))
					continue;
				rdeepclone(c_field, clone, offset);
			}
		} else {					/* Special filled with expanded objects */
			elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO (c_ref);
			for (offset = OVERHEAD; count > 0; count--, offset += elem_size)
				expanded_update(source, clone + offset, DEEP);
		}

	} else
		expanded_update(source, clone, DEEP); /* Update intra expanded refs */
}

rt_public void eif_xcopy(EIF_REFERENCE source, EIF_REFERENCE target)
{
	/* Copy 'source' into expanded object 'target' if 'source' is not void,
	 * or raise a "Void assigned to expanded" exception.
	 */
	
	if (source == (EIF_REFERENCE)  0)
		xraise(MTC EN_VEXP);			/* Void assigned to expanded */
	
	eif_std_ref_copy(source, target);
}

/*
doc:	<routine name="eif_std_field_copy" return_type="void" export="private">
doc:		<summary>Copy `source' into `target' field by field. And recurse on expanded field if any.</summary>
doc:		<param name="source" type="EIF_REFERENCE">Object from which fields will be copied onto target.</param>
doc:		<param name="target" type="EIF_REFERENCE">Object on which fields of `source' will be copied into.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None as we only manipulate data of `source' and `target'.</synchronization>
doc:	</routine>
*/

rt_private void eif_std_field_copy (EIF_REFERENCE source, EIF_REFERENCE target)
{
	EIF_TYPE_INDEX dtype = Dtype(target);	/* Doesn't matter to take target or source
											   since they are supposed to be the same type.*/
	struct cnode *skeleton = &System(dtype);
	long index;		/* Target attribute index */
	long offset;
	EIF_REFERENCE t_ref, s_ref;
#ifndef WORKBENCH
	long *offsets = skeleton->cn_offsets;	/* Target attribute offsets. */
#else
	int32 *cn_attr = skeleton->cn_attr;		/* Array of attribute keys for target object */
	int32 attr_key;	/* Attribute key */
#endif

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
		switch (skeleton->cn_types[index] & SK_HEAD) {
		case SK_BOOL:
		case SK_CHAR: *t_ref = *s_ref; break;
		case SK_WCHAR: *(EIF_WIDE_CHAR *) t_ref = *(EIF_WIDE_CHAR *) s_ref; break;
		case SK_UINT8: *(EIF_NATURAL_8 *) t_ref = *(EIF_NATURAL_8 *) s_ref; break;
		case SK_UINT16: *(EIF_NATURAL_16 *) t_ref = *(EIF_NATURAL_16 *) s_ref; break;
		case SK_UINT32: *(EIF_NATURAL_32 *) t_ref = *(EIF_NATURAL_32 *) s_ref; break;
		case SK_UINT64: *(EIF_NATURAL_64 *) t_ref = *(EIF_NATURAL_64 *) s_ref; break;
		case SK_INT8: *(EIF_INTEGER_8 *) t_ref = *(EIF_INTEGER_8 *) s_ref; break;
		case SK_INT16: *(EIF_INTEGER_16 *) t_ref = *(EIF_INTEGER_16 *) s_ref; break;
		case SK_INT32: *(EIF_INTEGER_32 *) t_ref = *(EIF_INTEGER_32 *) s_ref; break;
		case SK_INT64: *(EIF_INTEGER_64 *) t_ref = *(EIF_INTEGER_64 *) s_ref; break;
		case SK_REAL32: *(EIF_REAL_32 *) t_ref = *(EIF_REAL_32 *) s_ref; break;
		case SK_REAL64: *(EIF_REAL_64 *) t_ref = *(EIF_REAL_64 *) s_ref; break;
		case SK_POINTER: *(EIF_POINTER *) t_ref = *(EIF_POINTER *) s_ref; break;
		case SK_EXP: eif_std_ref_copy (s_ref, t_ref); break;
		default:
			*(EIF_REFERENCE *)t_ref = *(EIF_REFERENCE *)s_ref;
			break;
		}
	}
}
rt_public void eif_std_ref_copy(register EIF_REFERENCE source, register EIF_REFERENCE target)
{
	/* Copy Eiffel object `source' into Eiffel object `target'.
	 * Dynamic type of `source' is supposed to be the same as dynamic type
	 * of `target'. It assumes also that `source' and `target' are not 
	 * references on special objects.
	 * Problem: updating intra-references on expanded object
	 * because the garbage collector needs to explore those references.
	 */

	uint16 flags;			/* Source object flags */
	union overhead *s_zone;	/* Source object header */
	union overhead *t_zone;	/* Target object header */
#ifdef ISE_GC
	EIF_REFERENCE enclosing;					/* Enclosing target object */
#endif
	rt_uint_ptr size;

	s_zone = HEADER(source);
	flags = s_zone->ov_flags;
	t_zone = HEADER(target);
	
	if (s_zone->ov_dftype == t_zone->ov_dftype) {

		if (flags & EO_COMP) {
			/* Case of composite object: updating of references on expanded objects. */
			eif_std_field_copy (source, target);
		} else {
			/* Copy of source object into target object with same dynamic type. Block copy here. */
			if (eif_is_expanded(flags)) {
				size = EIF_Size(s_zone->ov_dtype);
			} else {
				size = s_zone->ov_size & B_SIZE;
			}
			memmove(target, source, size);
		}

#ifdef ISE_GC
		/* Precompute the enclosing target object */
		enclosing = target;					/* By default */
		if (eif_is_nested_expanded(t_zone->ov_flags)) {
			enclosing -= t_zone->ov_size & B_SIZE;
		}

		/* Perform aging tests. We need the address of the enclosing object to
		 * update the flags there, in case the target is to be memorized.
		 */
		flags = HEADER(enclosing)->ov_flags;
		CHECK ("Not forwarded", !(HEADER (enclosing)->ov_size & B_FWD));

		if (
			flags & EO_OLD &&			/* Object is old */
			!(flags & EO_REM)	&&		/* Not remembered */
			refers_new_object(target)	/* And copied refers to new objects */
		)
			erembq(enclosing);			/* Then remember the enclosing object */
#endif /* ISE_GC */
	}
}

rt_private void spcopy(register EIF_REFERENCE source, register EIF_REFERENCE target)
{
	/* Copy a special Eiffel object into another one. It assumes that
	 * `source' and `target' are not NULL and that count of `target' is greater
	 * than count of `source'.
	 */

	rt_uint_ptr field_size;
#ifdef ISE_GC
	uint16 flags;
#endif

	REQUIRE ("source not null", source);
	REQUIRE ("target not null", target);
	REQUIRE ("source is special", HEADER(source)->ov_flags & EO_SPEC);
	REQUIRE ("target is special", HEADER(source)->ov_flags & EO_SPEC);
	REQUIRE ("target_count_greater", RT_SPECIAL_COUNT(target) >= RT_SPECIAL_COUNT(source));

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
	if ((flags & (EO_REF | EO_OLD | EO_REM)) == (EO_OLD | EO_REF))
			/* May it hold new references? */
			eremb(target);	/* Remember it, even if not needed, to fasten
								copying process. */
#endif /* ISE_GC */
}

rt_private void tuple_copy(register EIF_REFERENCE source, register EIF_REFERENCE target)
{
	/* Copy a tuple Eiffel object into another one. It assumes that
	 * `source' and `target' are not NULL and that count of `target' is the same
	 * as count of `source'.
	 */

	rt_uint_ptr field_size;
#ifdef ISE_GC
	uint16 flags;
#endif

	REQUIRE ("source not null", source);
	REQUIRE ("target not null", target);
	REQUIRE ("source is tuple", HEADER(source)->ov_flags & EO_SPEC);
	REQUIRE ("target is tuple", HEADER(source)->ov_flags & EO_SPEC);
	REQUIRE ("same count", RT_SPECIAL_COUNT(target) == RT_SPECIAL_COUNT(source));

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
	if ((flags & (EO_REF | EO_OLD | EO_REM)) == (EO_OLD | EO_REF))
			/* May it hold new references? */
			eremb(target);	/* Remember it, even if not needed, to fasten
								copying process. */
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

	union overhead *zone;			/* Target Object header */
	long nb_ref;					/* Number of references */
	uint16 flags;					/* Target flags */
	EIF_REFERENCE t_reference;			/* Target reference */
	EIF_REFERENCE s_reference;			/* Source reference */
	EIF_REFERENCE t_enclosing;						/* Enclosing object */
	EIF_REFERENCE s_enclosing;						/* Enclosing object */
	rt_uint_ptr t_offset = 0;						/* Offset within target */
	rt_uint_ptr s_offset = 0;						/* Offset within target */
	rt_uint_ptr temp_offset = 0;					/* Offset within target */
	rt_uint_ptr s_sub_offset = 0;					/* Subobject offset */
	rt_uint_ptr offset1 = 0;						/* Offset within target */
	rt_uint_ptr offset2 = 0;						/* Offset within target */
	EIF_REFERENCE t_expanded;
	EIF_REFERENCE s_expanded;

	/* Compute the enclosing object (i.e. the object which contains the target).
	 * Normally this is the object itself, unless the target is expanded.
	 */

	t_enclosing = target;					/* Default enclosing object is itself */
	s_enclosing = source;					/* Default enclosing object is itself */
	zone = HEADER(target);					/* Malloc info zone */
	flags = zone->ov_flags;					/* Eiffel object flags */
	if (eif_is_nested_expanded(flags)) {
		offset2 = zone->ov_size & B_SIZE;
		t_offset = zone->ov_size & B_SIZE;	/* Target expanded offset within object */
		t_enclosing = target - t_offset;	/* Address of target enclosing object */
	}
	zone = HEADER(source);
	flags = zone->ov_flags;					/* Source eiffel object flags */
	if (eif_is_nested_expanded(flags)) {
		offset1 = zone->ov_size & B_SIZE;
		s_offset = zone->ov_size & B_SIZE;	/* Expanded offset within object */
		s_enclosing = source - s_offset;		/* Address of enclosing object */
	}

	nb_ref = References(zone->ov_dtype);	/* References in target */

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

		if (eif_is_nested_expanded(flags)) {		/* Object is expanded */

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

rt_public void sp_copy_data (EIF_REFERENCE Current, EIF_REFERENCE source, EIF_INTEGER source_index, EIF_INTEGER destination_index, EIF_INTEGER n)
{
	/* Copy `n' elements of `source' starting at index `source_index' to `Current'
	 * starting at index `destination_index'.
	 * Indexes are assumed to start from 0 and we assume that
	 * memory has been properly allocated beforehand.
	 */

	EIF_INTEGER elem_size;

	REQUIRE ("Current not null", Current);
	REQUIRE ("source not null", source);
	REQUIRE ("Special object", HEADER (source)->ov_flags & EO_SPEC);
	REQUIRE ("Special object", HEADER (Current)->ov_flags & EO_SPEC);
	REQUIRE ("Not tuple object", !(HEADER (source)->ov_flags & EO_TUPLE));
	REQUIRE ("Not tuple object", !(HEADER (Current)->ov_flags & EO_TUPLE));
	REQUIRE ("Not a special of expanded", !(HEADER(Current)->ov_flags & EO_COMP));
	REQUIRE ("source_index non_negative", source_index >= 0);
	REQUIRE ("destination_index non_negative", destination_index >= 0);
	REQUIRE ("n non_negative", n >= 0);
	REQUIRE ("source_index_valid", source_index + n <= RT_SPECIAL_COUNT(source));
	REQUIRE ("source_index valid for destination", destination_index + n <= RT_SPECIAL_COUNT(Current));

	elem_size = RT_SPECIAL_ELEM_SIZE(source);
	memmove(Current + (destination_index * elem_size), source + (source_index * elem_size), n * elem_size);

#ifdef ISE_GC
	/* Ok, normally we would have to perform age tests, by scanning the special
	 * object, looking for new objects. But a special object can be really big,
	 * and can also contain some expanded objects, which should be traversed
	 * to see if they contain any new objects. Ok, that's enough! This is a
	 * GC problem and is normally performed by the GC. So, if the special object
	 * is old and contains some references, I am automatically inserting it
	 * in the remembered set. The GC will remove it from there at the next
	 * cycle, if necessary--RAM.
	 * Of course we only do that when `source' and `Current' represents different objects. -- Manu
	 */
	if
		((Current != source) &&
		((HEADER(Current)->ov_flags & (EO_REF | EO_OLD | EO_REM)) == (EO_OLD | EO_REF)))
	{
			/* May it hold new references? */
		eremb(Current);	/* Remember it, even if not needed, to fasten
								copying process. */
	}
#endif
}

rt_public void spclearall (EIF_REFERENCE spobj)
{
	/* Reset all elements of `spobj' to default value. Call
	 * creation procedure of expanded objects if `spobj' is
	 * composite.
	 */

	union overhead *zone;			/* Malloc information zone */
	EIF_INTEGER count, elem_size;
	EIF_REFERENCE ref;

	zone = HEADER(spobj);
	ref = RT_SPECIAL_INFO_WITH_ZONE(spobj, zone);
	count = RT_SPECIAL_COUNT_WITH_INFO(ref);
	elem_size = RT_SPECIAL_ELEM_SIZE_WITH_INFO(ref);

		/* Reset all memory to zero. */
	memset (spobj, 0, count * elem_size);
	if (zone->ov_flags & EO_COMP) {
			/* case of a special object of expanded structures */
			/* Initialize new expanded elements, if any */
		sp_init (spobj, eif_gen_param_id (INVALID_DTYPE, Dftype(spobj), 1), 0, count - 1);
	}
}

/*
doc:</file>
*/
