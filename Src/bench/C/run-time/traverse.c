/*

  #####  #####     ##    #    #  ######  #####    ####   ######           ####
	#    #    #   #  #   #    #  #       #    #  #       #               #    #
	#    #    #  #    #  #    #  #####   #    #   ####   #####           #
	#    #####   ######  #    #  #       #####        #  #        ###    #
	#    #   #   #    #   #  #   #       #   #   #    #  #        ###    #    #
	#    #    #  #    #    ##    ######  #    #   ####   ######   ###     ####

	Traversal of objects. Useful for storing objects and/or
	recursively coying them.
*/


#include "eif_config.h"
#ifdef I_STRING
#include <string.h>				/* For bzero() */
#else
#include <strings.h>
#endif

#include "eif_garcol.h"
#include "eif_malloc.h"
#include "eif_macros.h"
#include "eif_except.h"

#if !defined CUSTOM || defined NEED_STORE_H
#include "eif_store.h"
#endif
#if !defined CUSTOM || defined NEED_HASH_H
#include "eif_hashin.h"
#endif

#include "eif_hector.h"
#include "eif_traverse.h"
#include "eif_memory.h"
#include "x2c.h"		/* For LNGPAD macros... */

/*
 * Declarations
 */
/*#define DEBUG */		/**/

/* The mstack structure has to be an exact copy of the stack structure, but has
 * an added field st_bot at the end. That way, we may safely use the common
 * stack handling structures without any code duplication and still have the
 * added field to make a FIFO stack--RAM.
 */
struct mstack {
	struct stchunk *st_hd;	/* Head of chunk list */
	struct stchunk *st_tl;	/* Tail of chunk list */
	struct stchunk *st_cur;	/* Current chunk in use (where top is) */
	char **st_top;			/* Top in chunk (pointer to next free location) */
	char **st_end;			/* Pointer to first element beyond current chunk */
	char **st_bot;			/* ADDED FIELD for FIFO stack implementation */
};

/* The following stack is used to record the EIF_OBJECT protections of all the
 * objects created during the maping traversal. It is represented as a stack and
 * not as an array to avoid fragmentation when resizing (since we do not know
 * how many objects we will traverse)--RAM.
 */
rt_private struct mstack map_stack;	/* Map table */

/* The following panic message is issued whenever an inconsistency is detected
 * in the manipulation of the maping table stack (e.g. when we ask for an
 * object, there must be one and the stack must be empty at the end of the
 * cloning operation).
 */
rt_private char *botched = "mapping table botched";

rt_shared long obj_nb;				/* Counter of marked objects */

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif


#ifdef DEBUG
rt_shared long nomark(char *);
rt_private long chknomark(char *, struct htable *, long);
#endif

rt_shared void traversal(char *object, int p_accounting)
{
	/* First pass of the store mechanism consisting in marking objects. */

	EIF_GET_CONTEXT
	char *object_ref, *reference;
	long count, elem_size;
	union overhead *zone;		/* Object header */
	uint32 flags;				/* Object flags */
	char *new;					/* Mapped object */
	EIF_OBJECT mapped;				/* Mapped object protection */
	int mapped_object = 0;		/* True if maping occured */
	int i;						/* To iterate over the references */

	zone = HEADER(object);
	flags = zone->ov_flags;

	if (flags & EO_C)				/* Stop on C objects */
		return;

	if (flags & EO_STORE)			/* Object is already marked? */
		return;						/* Then we already dealt with it */

	if (!(flags & EO_EXP)) {		/* Mark the object if not expanded */

		/* If a maping table is to be built, create a new object and insert it
		 * in the map table. The reference is protected by requesting insertion
		 * in the hector stack. There is no need to check for a null pointer
		 * upon return from spmalloc, emalloc or hrecord since those calls will
		 * raise an exception if there is not enough memory to perform the
		 * operation.
		 */

		if (p_accounting & TR_MAP) {
			epush(&loc_stack, (char *) &object);		/* Protection against GC */
			if (flags & EO_SPEC)
				new = spclone(object);
			else
				new = emalloc(flags & EO_TYPE);
			mapped = hrecord(new);
			if (-1 == epush((struct stack *) &map_stack, (char *) mapped))
				eraise("map table recording", EN_MEM);
			zone = HEADER(object);			/* Object may have moved */
			flags = zone->ov_flags;			/* Flags may have changed */
			mapped_object = 1;				/* Maping occured */
		}

		/* It is important to count the objects only once they have been
		 * recorded in the mapping stack (eventually), since the emergency
		 * release of the stack relies on an accurate object count.
		 */

		flags |= EO_STORE;			/* Object marked as traversed */
		obj_nb++; 					/* Count the number of objects traversed */
	}
#if !defined CUSTOM || defined NEED_STORE_H
	if (p_accounting & TR_ACCOUNT)	/* Possible accounting */
	{
		int16  *cidarr, dtype, i;
		uint32 dftype;

		dftype = flags & EO_TYPE;   /* Full type info */
		account[Deif_bid(dftype)] = (char) 1;	/* This type is present */

		/* Now insert generics */

		cidarr = eif_gen_cid ((int16) dftype);
		i = *(cidarr++); /* count */

		while (i--)
		{
			dtype = *(cidarr++);

			if (dtype <= -256)
				dtype = -256-dtype; /* expanded parameter */

			if (dtype >= 0)
			{
				account [dtype] = (char) 1;
			}
		}
	}
#endif
	zone->ov_flags = flags;			/* Mark the object */

	/* Evaluation of the number of references of the object. It is really
	 * important that we traverse the objects in the same way a deep clone
	 * would, or the maping operation would not match the object graph
	 * topology--RAM.
	 */

	if (flags & EO_SPEC) {			/* Special object */
		if (!(flags & EO_REF)) {	/* Object does not have any reference */
			if (mapped_object)
				epop(&loc_stack, 1);
			return;
		}

		/* Evaluation of the number of items in the special object */
		object_ref = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD_2);
		count = *(long *) object_ref;

		if (!(flags & EO_COMP))
			/* Special object filled with references */
			for (i = 0; i < count; i++) {
				reference = *((char **) object + i);
				if (0 != reference)		/* Non void reference */
					traversal(reference, p_accounting);
			}
		else {
			/* Special object filled with expanded objects which are
			 * necessary not special objects.
			 */
			int offset = OVERHEAD;
			elem_size = *(long *) (object_ref + sizeof(long));
			for (i = 0; i < count; i++, offset += elem_size)
				traversal(object + offset, p_accounting);
		}
	} else {
		/* Normal object */
		count = Deif_bid(flags);
		count = References(count);

		/* Traversal of references of `object' */
		for (i = 0; i < count; i++) {
			reference = *((char **) object + i);
			if ((char *) 0 != reference)
				traversal(reference, p_accounting);
		}
	}

	if (mapped_object)
		epop(&loc_stack, 1);
	EIF_END_GET_CONTEXT
}

/*
 * Indirection table handling.
 */

rt_shared void map_start(void)
{
	/* Restart the maping table at the beginning. Note that we are using the
	 * extra st_bot field which is added after all the fields from the stack
	 * structure.
	 */

	map_stack.st_bot = map_stack.st_hd->sk_arena;	/* First item */
	map_stack.st_cur = map_stack.st_hd;
	map_stack.st_end = map_stack.st_cur->sk_end;
}

rt_shared EIF_OBJECT map_next(void)
{
	/* Return next object in the map table, via its indirection pointer. Note
	 * that the stack structure is physically destroyed in the process, being
	 * mangled from the bottom.
	 */

	register1 EIF_OBJECT *item;		/* Item we shall return */
	register2 struct stchunk *cur;	/* New current chunk */

#ifdef MAY_PANIC
	/* If we already reached the end of the stack, panic immediately */
	if (map_stack.st_bot == map_stack.st_top)
		eif_panic(botched);
#endif
	
	item = (EIF_OBJECT *) map_stack.st_bot++;		/* Make a guess */
	if (item >= (EIF_OBJECT *) map_stack.st_end) {	/* Bad guess (beyond chunk) */
		cur = map_stack.st_cur->sk_next;		/* Advance one chunk */

#ifdef MAY_PANIC
		if (cur == (struct stchunk *) 0)		/* There has to be one */
			eif_panic(botched);
#endif

		map_stack.st_end = cur->sk_end;			/* Precompute end of chunk */
		map_stack.st_bot = cur->sk_arena;		/* This is the new bottom */
		item = (EIF_OBJECT *) map_stack.st_bot++;	/* Next item in stack */
		xfree((char *) (map_stack.st_cur));				/* Free previous chunk */
		map_stack.st_cur = cur;					/* It's the new first chunk */
		map_stack.st_hd = cur;					/* In case of emergency */
	}

#ifdef MAY_PANIC
	if (item == (EIF_OBJECT *) map_stack.st_top)	/* Reached the end of stack */
		eif_panic(botched);
#endif
	
	return *item;
}

rt_shared void map_reset(int emergency)
			  		/* Need to reset due to emergency (exception) */
{
	/* At the end of a cloning operation, the stack is reset (i.e. emptied)
	 * and a consistency check is made to ensure it is really empty.
	 */
	EIF_GET_CONTEXT
	struct stchunk *next;	/* Next chunk in stack list */
	struct stchunk *cur;	/* Current chunk in stack list */

#ifdef MAY_PANIC
	if (!emergency && map_stack.st_bot != map_stack.st_top)
		eif_panic(botched);
#endif
	
	/* If we get here because of an emergency, we free all the chunks held
	 * in the stack until the end. Otherwise, we only need to free the current
	 * (and last) chunk.
	 */

	if (emergency) {
		for (next = map_stack.st_hd; next != 0; /*empty */) {
			cur = next;						/* Current chunk to be freed */
			next = next->sk_next;			/* Compute next chunk... */
			xfree((char *) cur);			/* ...before freeing it */
		}
	} else
		xfree((char *) (map_stack.st_cur));	/* Free last chunk in stack */

	bzero(&map_stack, sizeof(map_stack));	/* Reset an empty stack */

	/* Release all the hector pointers asked for during the map table
	 * construction (obj_nb exactly, even if we were interrupted by an
	 * exception in the middle of the traversal...
	 */

	epop(&hec_stack, obj_nb);		/* Remove stacked EIF_OBJECT pointers */
	EIF_END_GET_CONTEXT
}

#ifdef DEBUG

rt_shared long nomark(char *obj)
{
	/* Check if there is no object marked EO_STORE under `obj'. */
	struct htable *tbl;
	long result;
	char gc_stopped;

	gc_stopped = !gc_ison();
	gc_stop();

	tbl = (struct htable *) cmalloc(sizeof(struct htable));
	if (tbl == (struct htable *) 0)
		enomem();
	if (ht_create(tbl, 1000, sizeof(char *)) != 0)
		enomem();
	result = chknomark(obj,tbl,0);
	ht_free(tbl);
	if (!gc_stopped) gc_run();
	return result;
}

rt_private long chknomark(char *object, struct htable *tbl, long object_count)
{
	/* First pass of the store mechanism consisting in marking objects. */

	char *object_ref, *reference;
	long count, elem_size;
	union overhead *zone = HEADER(object);		/* Object header */
	uint32 flags;								/* Object flags */
	unsigned long key = ((unsigned long) object) - 1;

	flags = zone->ov_flags;

	/* Stop on C objects */
	if (flags & EO_C)
		return object_count;

	/* Check if the object is already checked */
	if (ht_value(tbl,key) != (char *) 0)
		return object_count;

	/* Mark the object if not expanded */
	if (!(flags & EO_EXP)) {
		if (ht_put(tbl,key,object) == (char *) 0) {
			ht_xtend(tbl);
			if (ht_put(tbl,key,object) == (char *) 0)
				eif_panic("insertion trouble");
		}
		object_count++;
	}

	/* Check if no mark */
	if (flags & EO_STORE)
		eif_panic("object still marked");

	/* Evaluation of the number of references of the object */
	if (flags & EO_SPEC) {
		/* Special object */
		if (!(flags & EO_REF))
			/* Special object filled with direct instances */
			return object_count;

		/* Evaluation of the number of items in the special object */
		object_ref = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD_2);
		count = *(long *) object_ref;

		if (!(flags & EO_COMP))
			/* Special object filled with references */
			for (; count > 0; count--,
					object = (char *) ((char **) object + 1)) {
				reference = *(char **)object;
				if (0 != reference)
					/* Non void reference */
					object_count = chknomark(reference,tbl,object_count);					
			}
		else {
			/* Special object filled with expanded objects which are
			 * necessary not special objects.
			 */
			elem_size = *(long *) (object_ref + sizeof(long));
			for (object += OVERHEAD; count > 0;
					count --, object += elem_size)
				object_count = chknomark(object,tbl,object_count);
		}
	} else {
		/* Normal object */
		count = References(Deif_bid(flags));

		/* Traversal of references of `object' */
		for (;  count > 0;
				count--, object = (char *) (((char **) object) +1)) {
			reference = *(char **)object;
			if (((char *) 0) != reference)
				object_count = chknomark(reference,tbl,object_count);
		}
	}
	return object_count;
}
#endif

