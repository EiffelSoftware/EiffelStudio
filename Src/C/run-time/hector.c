/*
	description: "HECTOR = Handling Eiffel-C Transfer of Objects to Routines."
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
doc:<file name="hector.c" header="eif_hector.h" version="$Id$" summary="Handling of Eiffel-C transfer of objects to routines.">
*/

#include "eif_portable.h"
#include "eif_globals.h"
#include "rt_malloc.h"
#include "rt_garcol.h"
#include "eif_except.h"
#include "eif_cecil.h"
#include "rt_hector.h"
#include "rt_assert.h"
#include "rt_globals_access.h"
#include "eif_stack.h"

#ifdef ISE_GC
#ifndef EIF_THREADS
/*
doc:	<attribute name="hec_stack" return_type="struct ostack" export="public">
doc:		<summary>Indirection table `hector'. The following stack records the addresses of objects which were given to the C at some time. When Eiffel gives C an indirection pointer, it is an address in the hec_stack structure (type EIF_OBJECT as defined in cecil.h).  The C may obtain the true address of the object by dereferencing this indirection pointer through eif_access.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data and `eif_gc_mutex'.</synchronization>
doc:	</attribute>
*/
rt_public struct ostack hec_stack = {
	NULL,	/* st_head */
	NULL,	/* st_tail */
	NULL	/* st_cur */
};
#endif /* !EIF_THREADS */

/*
doc:	<attribute name="eif_hec_saved" return_type="struct ostack" export="shared">
doc:		<summary>This stack records the saved references. Entries in this stack are obtained either via eif_freeze() or eif_adopt(). Hence the stack structure is not completely appropriate and holes may appear. The `eif_free_hec_stack' stack records those holes.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Under `eif_hec_saved_mutex'.</synchronization>
doc:	</attribute>
*/
rt_shared struct ostack eif_hec_saved = {
	NULL,	/* st_head */
	NULL,	/* st_tail */
	NULL	/* st_cur */
};

/*
doc:	<attribute name="eif_free_hec_stack" return_type="struct oastack" export="private">
doc:		<summary>Due to the way the hector stack is managed, there can be "holes" in it, when an object in the middle of the stack is released by the C. To avoid having an eternal growing bunch (EGB -- an Eternal Golden Braid :-) of chunks, we record free locations in the following stack.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Under `eif_hec_saved_mutex'.</synchronization>
doc:	</attribute>
*/
rt_private struct oastack eif_free_hec_stack = {			/* Entries free in hector */
	NULL,	/* st_head */
	NULL,	/* st_tail */
	NULL	/* st_cur */
};

/*
doc:	<attribute name="eif_weak_references" return_type="struct ostack" export="shared">
doc:		<summary>This stack records the saved references. Entries in this stack are obtained either via eif_freeze() or eif_adopt(). Hence the stack structure is not completely appropriate and holes may appear. The `eif_free_weak_references' stack records those holes.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Under `eif_hec_saved_mutex'.</synchronization>
doc:	</attribute>
*/
rt_shared struct ostack eif_weak_references = {
	NULL,	/* st_head */
	NULL,	/* st_tail */
	NULL	/* st_cur */
};

/*
doc:	<attribute name="eif_free_weak_references" return_type="struct oastack" export="private">
doc:		<summary>Due to the way the hector stack is managed, there can be "holes" in it, when an object in the middle of the stack is released by the C. To avoid having an eternal growing bunch (EGB -- an Eternal Golden Braid :-) of chunks, we record free locations in the following stack.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Under `eif_hec_saved_mutex'.</synchronization>
doc:	</attribute>
*/
rt_private struct oastack eif_free_weak_references = {			/* Entries free in hector */
	NULL,	/* st_head */
	NULL,	/* st_tail */
	NULL	/* st_cur */
};

#ifdef EIF_THREADS
/*
doc:	<attribute name="eif_hec_saved_mutex" return_type="" export="shared">
doc:		<summary>Protect all access to `eif_hec_saved' and `eif_free_hec_stack', `eif_weak_references' and `eif_free_weak_references'.</summary>
doc:		<access>Read</access>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/
rt_shared EIF_CS_TYPE *eif_hec_saved_mutex = NULL;

#define EIFMTX_LOCK		EIF_ASYNC_SAFE_CS_LOCK(eif_hec_saved_mutex)
#define EIFMTX_UNLOCK	EIF_ASYNC_SAFE_CS_UNLOCK(eif_hec_saved_mutex)

#else
/* Noop for locks in non-multithreaded mode. */
#define EIFMTX_LOCK
#define EIFMTX_UNLOCK
#endif

/* The following routines are just for backward compatibility.
 * Remove them in 5 years from now (i.e. in 2013/02/15)
 */
extern EIF_REFERENCE ewean (EIF_OBJECT object);
extern EIF_OBJECT eadopt (EIF_OBJECT object);
extern EIF_OBJECT henter (EIF_REFERENCE object);
extern EIF_REFERENCE efreeze (EIF_OBJECT object);
extern void eufreeze (EIF_REFERENCE object);

rt_public EIF_REFERENCE ewean (EIF_OBJECT object) {
	return eif_wean (object);
}
rt_public EIF_OBJECT eadopt (EIF_OBJECT object) {
	return eif_adopt (object);
}
rt_public EIF_OBJECT henter (EIF_REFERENCE object) {
	return eif_protect (object);
}
rt_public EIF_REFERENCE efreeze (EIF_OBJECT object) {
	return eif_freeze (object);
}
rt_public void eufreeze (EIF_REFERENCE object) {
	eif_unfreeze (object);
}

/*
doc:	<routine name="eif_freeze" return_type="EIF_REFERENCE" export="public">
doc:		<summary>Freeze objects in memory by setting the B_C bit.</summary>
doc:		<param name="object" type="EIF_OBJECT">Object to freeze</param>
doc:		<return>Return new address for `object' in case a GC cycle was required to freeze the object. NULL on failure.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Via `eif_hec_saved_mutex'.</synchronization>
doc:	</routine>
*/
rt_public EIF_REFERENCE eif_freeze(EIF_OBJECT object)
{
	/* This is the most costly routine of Hector. Given an object, we want to
	 * release it from GC control and prevent it from moving in memory. This is
	 * dangerous too, as it will spoil the scavenge zones for the partial
	 * scavenging algorithm (and the GC will attempt allocating a new 'to' zone
	 * by requesting more core if it can). The routine costs a lot if the object
	 * to be frozen is located in the scavenge zone, because we have to force
	 * a collection cycle with tenuring of that object.
	 * The function returns the frozen address of the object or a null pointer
	 * if it was not possible to freeze the address (e.g. the object was in
	 * the scavenge zone and it could not be tenured).
	 */
	/* NOTE: be careful when freezing a special object, for at least two reasons:
	 * the implementation of freezing uses the B_C bit and sprealloc()
	 * explicitely clears that bit. But more importantly, it might need some
	 * reallocation and that could force moving its location...
	 */

	EIF_REFERENCE root;				/* Object's physical address */
	union overhead *zone;			/* Malloc information zone */

	/* Insert object in Hector table (saved stack), so that the GC always sees
	 * that object, and keep it alive.
	 */

	root = eif_access(object);		/* Object's address through hector */
	zone = HEADER(root);			/* Point to object's header */
	if (zone->ov_size & B_C)		/* Already frozen if C block */
		return root;				/* Object's location did not change */
	
	/* To test whether the block is in the scavenge zone or not is easy: objects
	 * located there have their B_BUSY flag reset. Thanks malloc :-)--RAM.
	 * If the block has been allocated from the free list, we simply set the
	 * B_C bit, which will indicate to the GC that the object is not to be
	 * moved.
	 */
	
	if (zone->ov_size & B_BUSY) {		/* Block is not in scavenge zone */
		zone->ov_size |= B_C;			/* Make it be a C block */
		return root;					/* Freezing succeded */
	}

	/* Now the lengthy part, with a generation collection cycle... */
	root = eif_tenure_object (root);
	zone = HEADER(root);				/* Get new zone (object has moved) */
	CHECK("Not in generation zone", zone->ov_size & B_BUSY);
	zone->ov_size |= B_C;			/* Make it a C block now */
	return root;					/* Freezing succeeded, new location */
}

/*
doc:	<routine name="eif_unfreeze" export="public">
doc:		<summary>The B_C bit on the object is cleared and should the object be dead, it will be collected during the next GC cycle.</summary>
doc:		<param name="object" type="EIF_REFERENCE">Object to unfreeze</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Via `eif_hec_saved_mutex'.</synchronization>
doc:	</routine>
*/
rt_public void eif_unfreeze(EIF_REFERENCE object)
{
	HEADER(object)->ov_size &= ~B_C;		/* Back to the Eiffel world */
}

/*
doc:	<routine name="eif_adopt" return_type="EIF_OBJECT" export="public">
doc:		<summary>The C wants to keep an Eiffel reference. Very well, simply add an entry in the remembered hector objects stack 'eif_hec_saved' and return the new indirection address.</summary>
doc:		<param name="object" type="EIF_OBJECT">Object to protect</param>
doc:		<return>Protected object.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Via `eif_hec_saved_mutex'.</synchronization>
doc:	</routine>
*/
rt_public EIF_OBJECT eif_adopt(EIF_OBJECT object)
{
	REQUIRE("Not on stack", (!eif_access(object)) || ((HEADER(eif_access(object))->ov_flags & EO_STACK) != EO_STACK));

	return eif_protect(eif_access(object));	/* Enter object in saved stack */
}

/*
doc:	<routine name="rt_unsafe_wean" return_type="EIF_REFERENCE" export="private">
doc:		<summary>The C wants to get rid of a reference which was previously kept. It may be only be an adopted one. Anyway, we remove the object from `stack'. If the object is dead, the next GC cycle will collect it. The C cannot reference the object through its EIF_OBJECT handle any more. No checking for double-wean is performed.</summary>
doc:		<param name="object" type="EIF_OBJECT">Object to protect</param>
doc:		<param name="stack" type="struct stack *">Stack where `object' was located</param>
doc:		<param name="free_stack" type="struct stack *">Stack where free location will be stored</param>
doc:		<return>Unprotected object.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Via `eif_hec_saved_mutex'.</synchronization>
doc:	</routine>
*/
rt_private EIF_REFERENCE rt_unsafe_wean(EIF_OBJECT object, struct ostack *stack, struct oastack *free_stack)
{
	RT_GET_CONTEXT
	EIF_REFERENCE ret;

	EIFMTX_LOCK;
		/* We need to ensure that `object' is indeed coming from an object protected via eif_protect.
		 * If this is not the case then we can have some memory corruption later one. */
	REQUIRE("object in stack", eif_ostack_is_address_in_stack (stack, object));
	REQUIRE("Object not in free stack", !eif_oastack_has(free_stack, object));
	if (eif_oastack_push(free_stack, object) != T_OK) {	/* Record free entry in the stack */
		EIFMTX_UNLOCK;
		plsc();									/* Run GC cycle */
		EIFMTX_LOCK;
		if (eif_oastack_push(free_stack, object) != T_OK) {	/* Again, we can't */
			EIFMTX_UNLOCK;
			eraise("hector weaning", EN_MEM);	/* No more memory */
		}
	}
	ret = eif_access(object);
	eif_access(object) = (EIF_REFERENCE) 0;		/* Reset hector's entry */
	EIFMTX_UNLOCK;
	return ret;				/* return unprotected address */
}

/*
doc:	<routine name="rt_wean" return_type="EIF_REFERENCE" export="private">
doc:		<summary>The C wants to get rid of a reference which was previously kept. It may be only be an adopted one. Anyway, we remove the object from `stack'. If the object is dead, the next GC cycle will collect it. The C cannot reference the object through its EIF_OBJECT handle any more. If called twice on the same `object', it does nothing if assertions are not enabled so that programs don't crash.</summary>
doc:		<param name="object" type="EIF_OBJECT">Object to protect</param>
doc:		<param name="stack" type="struct stack *">Stack where `object' was located</param>
doc:		<param name="free_stack" type="struct stack *">Stack where free location will be stored</param>
doc:		<return>Unprotected object.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Via `eif_hec_saved_mutex'.</synchronization>
doc:	</routine>
*/
rt_private EIF_REFERENCE rt_wean(EIF_OBJECT object, struct ostack *stack, struct oastack *free_stack)
{
	RT_GET_CONTEXT
	EIF_REFERENCE ret;

	EIFMTX_LOCK;
		/* We need to ensure that `object' is indeed coming from an object protected via eif_protect.
		 * If this is not the case then we can have some memory corruption later one. */
	REQUIRE("object in stack", eif_ostack_is_address_in_stack (stack, object));
	if (!eif_oastack_has(free_stack, object)) {
		if (eif_oastack_push(free_stack, object) != T_OK) {	/* Record free entry in the stack */
			EIFMTX_UNLOCK;
			plsc();									/* Run GC cycle */
			EIFMTX_LOCK;
			if (eif_oastack_push(free_stack, object) != T_OK) {	/* Again, we can't */
				EIFMTX_UNLOCK;
				eraise("hector weaning", EN_MEM);	/* No more memory */
			}
		}
		ret = eif_access(object);
		eif_access(object) = (EIF_REFERENCE) 0;		/* Reset hector's entry */
	} else {
			/* For some reasons, we are in case of double free. OK, I've put a check statement so that
			 * we can easily put a breakpoint if this was to happen. In theory, we should never go there
			 * unless the user calls `rt_wean' twice on the same object, but there are some code around
			 * that might just do that. For example, `rt_wean' is called from `dispose' on an Eiffel
			 * object which is duplicated via `deep_twin', then `dispose' is going to be called twice on
			 * the same address.
			 */
		CHECK("rt_wean double-free", 0);
		ret = NULL;
		CHECK("NULL object inside", ret == eif_access(object));
	}
	EIFMTX_UNLOCK;

	return ret;				/* return unprotected address */
}

/*
doc:	<routine name="eif_wean" return_type="EIF_REFERENCE" export="public">
doc:		<summary>The C wants to get rid of a reference which was previously kept. It may be only be an adopted one. Anyway, we remove the object from hector table. If the object is dead, the next GC cycle will collect it. The C cannot reference the object through its EIF_OBJECT handle any more.</summary>
doc:		<param name="object" type="EIF_OBJECT">Object to protect</param>
doc:		<return>Unprotected object.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Via `eif_hec_saved_mutex'.</synchronization>
doc:	</routine>
*/
rt_public EIF_REFERENCE eif_wean(EIF_OBJECT object)
{
	return rt_wean (object, &eif_hec_saved, &eif_free_hec_stack);
}

/*
doc:	<routine name="eif_free_weak_reference" return_type="EIF_REFERENCE" export="public">
doc:		<summary>The C wants to get rid of a reference which was previously kept. It may be only be an adopted one. Anyway, we remove the object from `eif_free_weak_references' table. If the object is dead, the next GC cycle will collect it. The C cannot reference the object through its EIF_OBJECT handle any more.</summary>
doc:		<param name="object" type="EIF_OBJECT">Object to protect</param>
doc:		<return>Unprotected object.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Via `eif_hec_saved_mutex'.</synchronization>
doc:	</routine>
*/
rt_public EIF_REFERENCE eif_free_weak_reference(EIF_OBJECT object)
{
		/* Because the routine is called from the WEAK_REFERENCE class, we assume
		 * that it will always be properly called. */
	return rt_unsafe_wean (object, &eif_weak_references, &eif_free_weak_references);
}

/*
doc:	<routine name="hrecord" return_type="EIF_OBJECT" export="public">
doc:		<summary>This routine is called by the generated C code before passing references to C. It records the object in the hector table and returns the address in the table (indirection pointer). If the object cannot be recorded, raise a "No more memory" exception.</summary>
doc:		<param name="object" type="EIF_REFERENCE">Object to protect</param>
doc:		<return>Protected object.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public EIF_OBJECT hrecord(EIF_REFERENCE object)
{
	EIF_GET_CONTEXT
	EIF_OBJECT address;					/* Address in hector */

	if (eif_ostack_push(&hec_stack, object) != T_OK) {		/* Cannot record object */
		urgent_plsc(&object);					/* Safe GC cycle */
		if (eif_ostack_push(&hec_stack, object) != T_OK)	/* Cannot really do it */
			eraise("hector recording", EN_MEM);	/* No more memory */
	}
	address = (EIF_OBJECT) (hec_stack.st_cur->sk_top - 1);	/* Was allocated here */
	eif_access(address) = object;		/* Record object's physical address */

	return address;			/* Address in hector stack */
}


/*
doc:	<routine name="eif_protect" return_type="EIF_OBJECT" export="public">
doc:		<summary>Enter 'object' into the hector indirection table and return its indirection pointer. I think this run-time call might be useful if someone wants to create Eiffel objects via emalloc() and let the GC see them by calling 'eif_protect'.</summary>
doc:		<param name="object" type="EIF_REFERENCE">Object to protect</param>
doc:		<return>Protected object.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Via `eif_hec_saved_mutex'.</synchronization>
doc:	</routine>
*/
rt_public EIF_OBJECT eif_protect(EIF_REFERENCE object)
{
	RT_GET_CONTEXT
		EIF_OBJECT address;						/* Address in hector */

	REQUIRE("Not on stack", !object || ((HEADER(object)->ov_flags & EO_STACK) != EO_STACK));

	EIFMTX_LOCK;
	if (!eif_oastack_is_empty(&eif_free_hec_stack)) {
		address = eif_oastack_pop(&eif_free_hec_stack);					/* Check for an already free location */
	} else {
		if (eif_ostack_push(&eif_hec_saved, object) != T_OK) {		/* Cannot record object */
			EIFMTX_UNLOCK;
			eraise("hector remembering", EN_MEM);	/* No more memory */
			return NULL;							/* They ignored it */
		}
		address = eif_hec_saved.st_cur->sk_top - 1;	/* Was allocated here */
	}
	eif_access(address) = object;		/* Record object's physical address */

	EIFMTX_UNLOCK;
	return address;			/* Location in Hector table */
}

/*
doc:	<routine name="eif_create_weak_reference" return_type="EIF_OBJECT" export="public">
doc:		<summary>Enter 'object' into the weak reference indirection table and return its indirection pointer.</summary>
doc:		<param name="object" type="EIF_REFERENCE">Object to protect</param>
doc:		<return>Protected object.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Via `eif_hec_saved_mutex'.</synchronization>
doc:	</routine>
*/
rt_public EIF_OBJECT eif_create_weak_reference(EIF_REFERENCE object)
{
	RT_GET_CONTEXT
	EIF_OBJECT address;						/* Address in hector */

	EIFMTX_LOCK;
	if (!eif_oastack_is_empty(&eif_free_weak_references)) {
		address = eif_oastack_pop(&eif_free_weak_references);		/* Check for an already free location */
	} else {
		if (eif_ostack_push(&eif_weak_references, object) != T_OK) {		/* Cannot record object */
			EIFMTX_UNLOCK;
			eraise("weak reference remembering", EN_MEM);	/* No more memory */
			return NULL;							/* They ignored it */
		}
		address = eif_weak_references.st_cur->sk_top - 1;	/* Was allocated here */
	}
	eif_access(address) = object;		/* Record object's physical address */

	EIFMTX_UNLOCK;
	return address;			/* Location in Hector table */
}


#endif
/*
doc:</file>
*/
