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
#include "eif_hector.h"

#ifdef ISE_GC
#ifndef EIF_THREADS
/*
doc:	<attribute name="hec_stack" return_type="struct stack" export="public">
doc:		<summary>Indirection table `hector'. The following stack records the addresses of objects which were given to the C at some time. When Eiffel gives C an indirection pointer, it is an address in the hec_stack structure (type EIF_OBJECT as defined in cecil.h).  The C may obtain the true address of the object by dereferencing this indirection pointer through eif_access.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Per thread data and `eif_gc_mutex'.</synchronization>
doc:	</attribute>
*/
rt_public struct stack hec_stack = {
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(EIF_REFERENCE *) 0,	/* st_top */
	(EIF_REFERENCE *) 0,	/* st_end */
};
#endif /* !EIF_THREADS */

/*
doc:	<attribute name="hec_saved" return_type="struct stack" export="shared">
doc:		<summary>This stack records the saved references. Entries in this stack are obtained either via eif_freeze() or eif_adopt(). Hence the stack structure is not completely appropriate and holes may appear. The `free_stack' stack records those holes.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Under `eif_hec_saved_mutex'.</synchronization>
doc:	</attribute>
*/
rt_shared struct stack hec_saved = {
	NULL,	/* st_hd */
	NULL,	/* st_tl */
	NULL,	/* st_cur */
	NULL,			/* st_top */
	NULL,			/* st_end */
};

/*
doc:	<attribute name="free_stack" return_type="struct stack" export="private">
doc:		<summary>Due to the way the hector stack is managed, there can be "holes" in it, when an object in the middle of the stack is released by the C. To avoid having an eternal growing bunch (EGB -- an Eternal Golden Braid :-) of chunks, we record free locations in the following stack.</summary>
doc:		<access>Read/Write</access>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Under `eif_hec_saved_mutex'.</synchronization>
doc:	</attribute>
*/
rt_private struct stack free_stack = {			/* Entries free in hector */
	NULL,	/* st_hd */
	NULL,	/* st_tl */
	NULL,	/* st_cur */
	NULL,	/* st_top */
	NULL,	/* st_end */
};

#ifdef EIF_THREADS
/*
doc:	<attribute name="eif_hec_saved_mutex" return_type="" export="shared">
doc:		<summary>Protect all access to `hec_saved' and `free_stack'.</summary>
doc:		<access>Read</access>
doc:		<thread_safety>Safe</thread_safety>
doc:	</attribute>
*/
rt_shared EIF_LW_MUTEX_TYPE *eif_hec_saved_mutex = NULL;

#define EIFMTX_LOCK \
	EIF_ASYNC_SAFE_LW_MUTEX_LOCK(eif_hec_saved_mutex, "Cannot lock mutex for hec_saved\n");

#define EIFMTX_UNLOCK \
   	EIF_ASYNC_SAFE_LW_MUTEX_UNLOCK(eif_hec_saved_mutex, "Cannot unlock mutex for hec_saved\n"); \

#else
/* Noop for locks in non-multithreaded mode. */
#define EIFMTX_LOCK
#define EIFMTX_UNLOCK
#endif

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

	/* Now the lengthy part, with a generation collection cycle... We change
	 * artificially the age of the object to the maximum possible age, then
	 * we make sure the tenure limit is low enough to ensure the tenuring of
	 * the object.
	 */

	zone->ov_flags |= EO_AGE;			/* Maximum reachable age */
	if (tenure == eif_tenure_max) {		/* Tenure fixed to maximum age ? */ 
		tenure = eif_tenure_max - 1;	/* Ensure object will be tenured */
	}
	collect();							/* Run a generation scavenging cycle */
	root = eif_access(object);			/* Update that reference too */
	zone = HEADER(root);				/* Get new zone (object has moved) */
	if (!(zone->ov_size & B_BUSY)) {	/* Object still in generation zone */
		return NULL;					/* Could not tenure, freeze failed */
	} else {
		zone->ov_size |= B_C;			/* Make it a C block now */
		return root;					/* Freezing succeeded, new location */
	}
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
doc:		<summary>The C wants to keep an Eiffel reference. Very well, simply add an entry in the remembered hector objects stack 'hec_saved' and return the new indirection address.</summary>
doc:		<param name="object" type="EIF_OBJECT">Object to protect</param>
doc:		<return>Protected object.</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Via `eif_hec_saved_mutex'.</synchronization>
doc:	</routine>
*/
rt_public EIF_OBJECT eif_adopt(EIF_OBJECT object)
{
	return eif_protect(eif_access(object));	/* Enter object in saved stack */
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
	RT_GET_CONTEXT
	EIF_REFERENCE ret;

	EIFMTX_LOCK
	if (-1 == epush(&free_stack, object)) {	/* Record free entry in the stack */
		EIFMTX_UNLOCK
		plsc();									/* Run GC cycle */
		EIFMTX_LOCK
		if (-1 == epush(&free_stack, object)) {	/* Again, we can't */
			EIFMTX_UNLOCK
			eraise("hector weaning", EN_MEM);	/* No more memory */
		}
	}
	ret = eif_access(object);
	eif_access(object) = (EIF_REFERENCE) 0;		/* Reset hector's entry */
	EIFMTX_UNLOCK

	return ret;				/* return unprotected address */
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

	if (-1 == epush(&hec_stack, object)) {		/* Cannot record object */
		urgent_plsc(&object);					/* Safe GC cycle */
		if (-1 == epush(&hec_stack, object))	/* Cannot really do it */
			eraise("hector recording", EN_MEM);	/* No more memory */
	}
	address = (EIF_OBJECT) (hec_stack.st_top - 1);	/* Was allocated here */
	eif_access(address) = object;		/* Record object's physical address */

	return address;			/* Address in hector stack */
}

/*
doc:	<routine name="hpop" return_type="EIF_OBJECT" export="private">
doc:		<summary>Pop an address of the free_stack. If the stack is empty, return a null pointer. Otherwise the address points directly to a free entry in hector's table.</summary>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Only if caller holds the `eif_hec_saved_mutex'.</synchronization>
doc:	</routine>
*/
rt_private EIF_OBJECT hpop(void)
{
	EIF_REFERENCE *top;
	EIF_REFERENCE result = NULL;
	struct stchunk *s;

	top = free_stack.st_top;
	if (top) {
			/* Optimization: try to update the top first, hoping that it will remain
			 * in the same chunk (this should be true more than 99% of the time). */
		if (--top >= free_stack.st_cur->sk_arena) {
			free_stack.st_top = top;			/* We remained in the same chunk */
			result = *top;
		} else {
				/* Unusual case: top is just in the first place of next chunk */
			s = free_stack.st_cur->sk_prev;			/* Backup one chunk */
			if (s) {								/* Was already at first chunk */
				free_stack.st_cur = s;				/* Update current chunk */
				top = free_stack.st_end = s->sk_end;/* The end of the chunk */
				free_stack.st_top = --top;			/* Backup one location */
				result = *top;
			}
		}
	}
	return (EIF_OBJECT) result;
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

	EIFMTX_LOCK
	address = hpop();					/* Check for an already free location */
	if (!address) {									/* No such luck */
		if (-1 == epush(&hec_saved, object)) {		/* Cannot record object */
			EIFMTX_UNLOCK
			eraise("hector remembering", EN_MEM);	/* No more memory */
			return NULL;							/* They ignored it */
		}
		address = (EIF_OBJECT) (hec_saved.st_top - 1);	/* Was allocated here */
	}
	eif_access(address) = object;		/* Record object's physical address */

	EIFMTX_UNLOCK
	return address;			/* Location in Hector table */
}


#endif
/*
doc:</file>
*/
