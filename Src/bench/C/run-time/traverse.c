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

#include "garcol.h"
#include "malloc.h"
#include "macros.h"
#include "except.h"
#include "store.h"
#include "hashin.h"
#include "hector.h"
#include "traverse.h"

/*
 * Declarations
 */
/*#define DEBUG		/**/

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

/* The following stack is used to record the EIF_OBJ protections of all the
 * objects created during the maping traversal. It is represented as a stack and
 * not as an array to avoid fragmentation when resizing (since we do not know
 * how many objects we will traverse)--RAM.
 */
private struct mstack map_stack;	/* Map table */

/* The following panic message is issued whenever an inconsistency is detected
 * in the manipulation of the maping table stack (e.g. when we ask for an
 * object, there must be one and the stack must be empty at the end of the
 * cloning operation).
 */
private char *botched = "mapping table botched";

shared long obj_nb;				/* Counter of marked objects */

#ifndef lint
private char *rcsid =
	"$Id$";
#endif

#ifdef DEBUG
shared long nomark();
private long chknomark();
#endif

shared void traversal(object, accounting)
char *object;
int accounting;
{
	/* First pass of the store mechanism consisting in marking objects. */

	char *object_ref, *reference;
	long count, elem_size;
	union overhead *zone;		/* Object header */
	uint32 flags;				/* Object flags */
	char *new;					/* Mapped object */
	EIF_OBJ mapped;				/* Mapped object protection */
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

		if (accounting & TR_MAP) {
			epush(&loc_stack, &object);		/* Protection against GC */
			if (flags & EO_SPEC)
				new = spclone(object);
			else
				new = emalloc(flags & EO_TYPE);
			mapped = hrecord(new);
			if (-1 == epush(&map_stack, (char *) mapped))
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

	if (accounting & TR_ACCOUNT)	/* Possible accounting */
		account[flags & EO_TYPE] = (char) 1;	/* This type is present */

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
		object_ref = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD(2));
		count = *(long *) object_ref;

        if (!(flags & EO_COMP))
			/* Special object filled with references */
			for (i = 0; i < count; i++) {
				reference = *((char **) object + i);
				if (0 != reference)		/* Non void reference */
					traversal(reference, accounting);
			}
		else {
			/* Special object filled with expanded objects which are
			 * necessary not special objects.
			 */
			int offset = OVERHEAD;
			elem_size = *(long *) (object_ref + sizeof(long));
			for (i = 0; i < count; i++, offset += elem_size)
				traversal(object + offset, accounting);
		}
    } else {
		/* Normal object */
        count = References(flags & EO_TYPE);

		/* Traversal of references of `object' */
		for (i = 0; i < count; i++) {
			reference = *((char **) object + i);
			if ((char *) 0 != reference)
				traversal(reference, accounting);
		}
	}

	if (mapped_object)
		epop(&loc_stack, 1);
}

/*
 * Indirection table handling.
 */

shared void map_start()
{
	/* Restart the maping table at the beginning. Note that we are using the
	 * extra st_bot field which is added after all the fields from the stack
	 * structure.
	 */

	map_stack.st_bot = map_stack.st_hd->sk_arena;	/* First item */
	map_stack.st_cur = map_stack.st_hd;
	map_stack.st_end = map_stack.st_cur->sk_end;
}

shared EIF_OBJ map_next()
{
	/* Return next object in the map table, via its indirection pointer. Note
	 * that the stack structure is physically destroyed in the process, being
	 * mangled from the bottom.
	 */

	register1 EIF_OBJ *item;		/* Item we shall return */
	register2 struct stchunk *cur;	/* New current chunk */

#ifdef MAY_PANIC
	/* If we already reached the end of the stack, panic immediately */
	if (map_stack.st_bot == map_stack.st_top)
		panic(botched);
#endif
	
	item = (EIF_OBJ *) map_stack.st_bot++;		/* Make a guess */
	if (item >= (EIF_OBJ *) map_stack.st_end) {	/* Bad guess (beyond chunk) */
		cur = map_stack.st_cur->sk_next;		/* Advance one chunk */

#ifdef MAY_PANIC
		if (cur == (struct stchunk *) 0)		/* There has to be one */
			panic(botched);
#endif

		map_stack.st_end = cur->sk_end;			/* Precompute end of chunk */
		map_stack.st_bot = cur->sk_arena;		/* This is the new bottom */
		item = (EIF_OBJ *) map_stack.st_bot++;	/* Next item in stack */
		xfree(map_stack.st_cur);				/* Free previous chunk */
		map_stack.st_cur = cur;					/* It's the new first chunk */
		map_stack.st_hd = cur;					/* In case of emergency */
	}

#ifdef MAY_PANIC
	if (item == (EIF_OBJ *) map_stack.st_top)	/* Reached the end of stack */
		panic(botched);
#endif
	
	return *item;
}

shared void map_reset(emergency)
int emergency;		/* Need to reset due to emergency (exception) */
{
	/* At the end of a cloning operation, the stack is reset (i.e. emptied)
	 * and a consistency check is made to ensure it is really empty.
	 */

	struct stchunk *next;	/* Next chunk in stack list */
	struct stchunk *cur;	/* Current chunk in stack list */

#ifdef MAY_PANIC
	if (!emergency && map_stack.st_bot != map_stack.st_top)
		panic(botched);
#endif
	
	/* If we get here because of an emergency, we free all the chunks held
	 * in the stack until the end. Otherwise, we only need to free the current
	 * (and last) chunk.
	 */

	if (emergency) {
		for (next = map_stack.st_hd; next != 0; /*empty */) {
			cur = next;						/* Current chunk to be freed */
			next = next->sk_next;			/* Compute next chunk... */
			xfree(cur);						/* ...before freeing it */
		}
	} else
		xfree(map_stack.st_cur);				/* Free last chunk in stack */

	bzero(&map_stack, sizeof(map_stack));	/* Reset an empty stack */

	/* Release all the hector pointers asked for during the map table
	 * construction (obj_nb exactly, even if we were interrupted by an
	 * exception in the middle of the traversal...
	 */

	epop(&hec_stack, obj_nb);		/* Remove stacked EIF_OBJ pointers */
}

#ifdef DEBUG

shared long nomark(obj)
char *obj;
{
	/* Check if there is no object marked EO_STORE under `obj'. */
	struct htable *tbl;
	long result;

	gc_stop();

	tbl = (struct htable *) cmalloc(sizeof(struct htable));
	if (tbl == (struct htable *) 0)
		enomem();
	if (ht_create(tbl, 1000, sizeof(char *)) != 0)
		enomem();
	result = chknomark(obj,tbl,0);
	ht_free(tbl);
	gc_run();
	return result;
}

private long chknomark(object,tbl,object_count)
char *object;
struct htable *tbl;
long object_count;
{
	/* First pass of the store mechanism consisting in marking objects. */

	char *object_ref, *reference;
	long count, elem_size;
	union overhead *zone = HEADER(object);		/* Object header */
	uint32 flags;								/* Object flags */
	int32 key = ((int32) object) - 1;

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
				panic("insertion trouble");
		}
		object_count++;
	}

	/* Check if no mark */
	if (flags & EO_STORE)
		panic("object still marked");

	/* Evaluation of the number of references of the object */
    if (flags & EO_SPEC) {
		/* Special object */
		if (!(flags & EO_REF))
			/* Special object filled with direct instances */
			return object_count;

		/* Evaluation of the number of items in the special object */
		object_ref = (char *) (object + (zone->ov_size & B_SIZE) - LNGPAD(2));
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
        count = References(flags & EO_TYPE);

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

