/*

 #    #  ######   ####    #####   ####   #####            ####
 #    #  #       #    #     #    #    #  #    #          #    #
 ######  #####   #          #    #    #  #    #          #
 #    #  #       #          #    #    #  #####    ###    #
 #    #  #       #    #     #    #    #  #   #    ###    #    #
 #    #  ######   ####      #     ####   #    #   ###     ####

	Handling Eiffel-C Transfer of Objects to Routines.
*/

#include "eif_globals.h"
#include "config.h"
#include "malloc.h"
#include "garcol.h"
#include "except.h"
#include "cecil.h"
#include "hector.h"

#ifndef EIF_THREADS
/* The following stack records the addresses of objects which were given to
 * the C at some time. When Eiffel gives C an indirection pointer, it is an
 * address in the hec_stack structure (type EIF_OBJ as defined in cecil.h).
 * The C may obtain the true address of the object by dereferencing this
 * indirection pointer through eif_access.
 */
rt_public struct stack hec_stack = {			/* Indirection table "hector" */
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(char **) 0,			/* st_top */
	(char **) 0,			/* st_end */
};

/* This stack records the saved references. Entries in this stack are obtained
 * either via eif_freeze() or eif_adopt(). Hence the stack structure is not
 * completely appropriate and holes may appear. The 'free_stack' stack records
 * those holes.
 */
rt_public struct stack hec_saved = {			/* Saved indirection pointers */
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(char **) 0,			/* st_top */
	(char **) 0,			/* st_end */
};

/* Due to the way the hector stack is managed, there can be "holes" in it, when
 * an object in the middle of the stack is released by the C. To avoid having
 * an eternal growing bunch (EGB -- an Eternal Golden Braid :-) of chunks, we
 * record free locations in the following stack.
 */
rt_private struct stack free_stack = {			/* Entries free in hector */
	(struct stchunk *) 0,	/* st_hd */
	(struct stchunk *) 0,	/* st_tl */
	(struct stchunk *) 0,	/* st_cur */
	(char **) 0,			/* st_top */
	(char **) 0,			/* st_end */
};
#endif /* EIF_THREADS */

/* Private function declarations */
rt_private EIF_OBJ hector_addr(char *root);		/* Maps an adress to an hector position */
rt_private char *hpop(void);				/* Pop a free entry off the free stack */

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

/* In the following routines, I've put EIF_OBJ to emphazise the fact that the
 * variable is an indirection pointer in the hector table. Otherwise, a char *
 * refers to a true object's address (for instance the result of efreeze).
 * It is completely forbidden to access an EIF_OBJ directly (it has not real
 * meaning anyway).
 */

rt_public char *efreeze(EIF_OBJ object)
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

	EIF_GET_CONTEXT
	char *root;						/* Object's physical address */
	union overhead *zone;			/* Malloc information zone */
	/* uint32 flags;*/ /* Eiffel flags */ /* %%ss removed */

	/* It is impossible to freeze a special object, for at least two reasons:
	 * the implementation of freezing uses the B_C bit and sprealloc()
	 * explicitely clears that bit. But more importantly, it might need some
	 * reallocation and that could force moving its location...
	 */

	if (HEADER(eif_access(object))->ov_flags & EO_SPEC)
		return (char *) 0;

	/* Insert object in Hector table (saved stack), so that the GC always sees
	 * that object, and keep it alive.
	 */

	object = eadopt(object);		/* Transfer object into saved stack */
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
	if (tenure == TENURE_MAX)			/* Tenure fixed to maximum age ? */
		tenure = TENURE_MAX - 1;		/* Ensure object will be tenured */
	collect();							/* Run a generation scavenging cycle */
	root = eif_access(object);			/* Update that reference too */
	zone = HEADER(root);				/* Get new zone (object has moved) */
	if (!(zone->ov_size & B_BUSY))		/* Object still in generation zone */
		return (char *) 0;				/* Could not tenure, freeze failed */
	zone->ov_size |= B_C;				/* Make it a C block now */

	return root;						/* Freezing succeeded, new location */
	EIF_END_GET_CONTEXT
}

rt_public EIF_OBJ eadopt(EIF_OBJ object)
{
	/* The C wants to keep an Eiffel reference. Very well, simply add an entry
	 * in the remembered hector objects stack 'hec_saved' and return the new
	 * indirection address.
	 */
	
	return henter(eif_access(object));	/* Enter object in saved stack */

}

rt_public EIF_OBJ ewean(EIF_OBJ object)
{
	/* The C wants to get rid of a reference which was previously kept. It may
	 * be only be an adopted one. Anyway, we remove the object from hector
	 * table. If the object is dead, the next GC cycle will collect it. The C
	 * cannot reference the object through its EIF_OBJ handle any more.
	 */
	EIF_GET_CONTEXT
	EIF_OBJ ret;
	
	if (-1 == epush(&free_stack, object)) {	/* Record free entry in the stack */
		plsc();									/* Run GC cycle */
		if (-1 == epush(&free_stack, object))	/* Again, we can't */
			eraise("hector weaning", EN_MEM);	/* No more memory */
	}
	ret = eif_access(object);
	eif_access(object) = (char *) 0;		/* Reset hector's entry */

	return ret;				/* return unprotected address */
	EIF_END_GET_CONTEXT
}

rt_public void eufreeze(char *object)
{
	/* The C wants to get rid of a frozen reference which was previously
	 * obtained through efreeze(). However, the argument is the address of the
	 * object, not an hector indirection pointer. The B_C bit on the object is
	 * cleared and should the object be dead, it will be collected during the
	 * next GC cycle.
	 */
	EIF_GET_CONTEXT
	EIF_OBJ address;					/* Address in hector's stack */
	char *unprotected_ref;

	address = hector_addr(object);		/* Fetch associated address */
	if (-1 == epush(&free_stack, address)) {		/* Record free entry */
		plsc();										/* Run GC cycle */
		if (-1 == epush(&free_stack, address))		/* Again, we can't */
			eraise("hector unfreezing", EN_MEM);	/* No more memory */
	}
	unprotected_ref = eif_access(address);
	HEADER(unprotected_ref)->ov_size &= ~B_C;		/* Back to the Eiffel world */
	eif_access(address) = (char *) 0;				/* Reset hector's entry */
	EIF_END_GET_CONTEXT
}

/*
 * Run-time entries
 */

rt_public EIF_OBJ hrecord(char *object)
{
	/* This routine is called by the generated C code before passing references
	 * to C. It records the object in the hector table and returns the address
	 * in the table (indirection pointer).
	 * If the object cannot be recorded, raise a "No more memory" exception.
	 */
	EIF_GET_CONTEXT
	EIF_OBJ address;					/* Address in hector */

	if (-1 == epush(&hec_stack, object)) {		/* Cannot record object */
		urgent_plsc(&object);					/* Safe GC cycle */
		if (-1 == epush(&hec_stack, object))	/* Cannot really do it */
			eraise("hector recording", EN_MEM);	/* No more memory */
	}
	address = (char *) (hec_stack.st_top - 1);	/* Was allocated here */
	eif_access(address) = object;		/* Record object's physical address */

	return (EIF_OBJ) address;			/* Address in hector stack */
	EIF_END_GET_CONTEXT
}

/*
 * Low-level routines left visible to enable high wizardry--RAM.
 */

rt_public EIF_OBJ henter(char *object)
{
	/* Enter 'object' into the hector indirection table and return its
	 * indirection pointer. I think this run-time call might be useful if
	 * someone wants to create Eiffel objects via emalloc() and let the GC
	 * see them by calling 'henter'--RAM.
	 */
	EIF_GET_CONTEXT
	char *address;						/* Address in hector */

	address = hpop();					/* Check for an already free location */
	if (address == (char *) 0) {		/* No such luck */
		if (-1 == epush(&hec_saved, object)) {		/* Cannot record object */
			eraise("hector remembering", EN_MEM);	/* No more memory */
			return (EIF_OBJ) 0;						/* They ignored it */
		}
		address = (char *) (hec_saved.st_top - 1);	/* Was allocated here */
	}
	eif_access(address) = object;		/* Record object's physical address */

	return (EIF_OBJ) address;			/* Location in Hector table */
	EIF_END_GET_CONTEXT
}

rt_public void hfree(EIF_OBJ address)
{
	/* This routine frees an hector indirection pointer obtained through henter.
	 * The indirection pointer is reset to a null pointer and its location
	 * within the hector stack hec_saved is remembered in free_stack for later
	 * reuse. Again, only guys wearing white hats should use this routine--RAM.
	 */
	EIF_GET_CONTEXT
	eif_access(address) = (char *) 0;				/* Reset hector's entry */
	if (-1 == epush(&free_stack, address)) {		/* Record free entry */
		plsc();										/* Run GC cycle */
		(void) epush(&free_stack, address);			/* Retry, discard errors */
	}
	EIF_END_GET_CONTEXT
}

rt_public char *spfreeze(char *object)
             		/* Physical address */
{
	/* Given an special object, we want to release it from GC control and 
	 * prevent it from moving in memory. This is dangerous as we will have
	 * to be sure that the object will not be reallocated (through array
	 * resizing). Otherwise sprealloc() might move that object anyway
	 * and will clear the B_C bit used to mark frozen objects.
	 * The object should also be kept alive during the time it is frozen.
	 * Beside that, the frozen object will not spoil the scavenge zones
	 * because special objects are allocated outside of them.
	 */

	union overhead *zone;			/* Malloc information zone */

	zone = HEADER(object);			/* Point to object's header */
	zone->ov_size |= B_C;			/* Make it be a C block */
	return object;					/* Object's location did not change */
}

rt_public void spufreeze(char *object)
             		/* Physical address */
{
	/* We want to put back under GC control a frozen object previously
	 * obtain through spfreeze(). The B_C bit on the object is cleared.
	 */

	HEADER(object)->ov_size &= ~B_C;	/* Back to the Eiffel world */
}

/*
 * Stack handling
 */

rt_private char *hpop(void)
{
	/* Pop an address of the free_stack. If the stack is empty, return a
	 * null pointer. Otherwise the address points directly to a free entry
	 * in hector's table.
	 */
	EIF_GET_CONTEXT
	char **top = free_stack.st_top;
	struct stchunk *s;

	if (top == (char **) 0)					/* Free stack is empty */
		return (char *) 0;

	/* Optimization: try to update the top first, hoping that it will remain
	 * in the same chunk (this should be true more than 99% of the time).
	 */

	if (--top >= free_stack.st_cur->sk_arena) {
		free_stack.st_top = top;			/* We remained in the same chunk */
		return *top;
	}

	/* Unusual case: top is just in the first place of next chunk */

	s = free_stack.st_cur->sk_prev;			/* Backup one chunk */
	if (s == (struct stchunk *) 0)			/* Was already at first chunk */
		return (char *) 0;					/* Stack is empty */
	free_stack.st_cur = s;					/* Update current chunk */
	top = free_stack.st_end = s->sk_end;	/* The end of the chunk */
	free_stack.st_top = --top;				/* Backup one location */

	return *top;
	EIF_END_GET_CONTEXT
}

rt_private EIF_OBJ hector_addr(char *root)
{
	/* Given an object's address, look in the stack and find the hector address
	 * associated with the physical address and return it. This is a linear
	 * search, but the size of this stack should remain small.
	 */
	EIF_GET_CONTEXT
	register1 int nb_items;			/* Number of items in arena */
	register2 struct stchunk *s;	/* To walk through each stack's chunk */
	register3 char **arena;			/* Current arena in chunk */
	int done = 0;					/* Top of stack not reached yet */

	for (s = hec_saved.st_hd; s && !done; s = s->sk_next) {
		arena = s->sk_arena;				/* Start of stack */
		if (s != hec_saved.st_cur)			/* Before current position? */
			nb_items = s->sk_end - arena;	/* Take the whole chunk */
		else {
			nb_items = hec_saved.st_top - arena;	/* Stop at the top */
			done = 1;								/* Reached end of stack */
		}
		for (; nb_items > 0; nb_items--, arena++)
			if (*arena == root)						/* Found indirection */
				return (EIF_OBJ) arena;				/* Return indirection ptr */
	}

	panic(MTC "hector stack inconsistency");		/* We must have found it */
	EIF_END_GET_CONTEXT
}

