/*

 #        ####    ####     ##    #                ####
 #       #    #  #    #   #  #   #               #    #
 #       #    #  #       #    #  #               #
 #       #    #  #       ######  #        ###    #
 #       #    #  #    #  #    #  #        ###    #    #
 ######   ####    ####   #    #  ######   ###     ####

	Handling of local variable stack.

*/


#include "eif_portable.h"
#include "rt_malloc.h"
#include "rt_garcol.h"
#include "eif_except.h"
#include "eif_urgent.h"
#include "eif_local.h"
#include "eif_hector.h"
#include "eif_sig.h"
#ifdef WORKBENCH
#include "eif_debug.h"
#endif

#include <string.h>

#ifdef I_STDARG
#include <stdarg.h>
#else
#ifdef I_VARARGS
#include <varargs.h>
#endif
#endif

#include <stdio.h>

#define dprintf(n)		if (DEBUG & (n)) printf

rt_public void epop(register struct stack *stk, register int nb_items);					/* Pops values off a stack */
rt_private int extend(register struct stack *stk);				/* Stack extension w/ urgent chunks */

#ifndef lint
rt_private char *rcsid =
	"$Id$";
#endif

rt_public void epop(register struct stack *stk, register int nb_items)
                            		/* The stack */
                       				/* Number of items to be popped */
{
	/* Removes 'nb_items' from the stack 'stk'. The routine is more general
	 * than needed, but it keeps the spirit of epush().
	 */
	EIF_GET_CONTEXT
	register3 char **top = stk->st_top;		/* Current top of the stack */
	register4 struct stchunk *s;			/* To walk through stack chunks */
	register5 char **arena;					/* Base address of current chunk */

	/* Optimization: try to update the top, hoping it will remain in the
	 * same chunk. This avoids pointer manipulation (walking along the stack)
	 * which may induce swapping, who knows?
	 */

	arena = stk->st_cur->sk_arena;
	top -= nb_items;				/* Hopefully, we remain in current chunk */
	if (top >= arena) {
		stk->st_top = top;			/* Yes! Update top */
		return;						/* Done, we're lucky */
	}

	/* Normal case: we have to pop more than the number of elements in the
	 * current chunk. Loop until we popped enough items. This is also where
	 * we have to protect against signals or there is a risk the data structure
	 * be corrupted.
	 */

	SIGBLOCK;			/* Entering critical section */
	
	top = stk->st_top;
	for (s = stk->st_cur; nb_items > 0; /* empty */) {
		arena = s->sk_arena;
		nb_items -= top - arena;
		if (nb_items <= 0) {		/* We've gone too far? */
			top = arena - nb_items;	/* Reset top correctly */
			break;					/* Done */
		}
		s = s->sk_prev;				/* Look at previous chunk */
		if (s)
			top = s->sk_end;		/* Top at the end of previous chunk */
		else
			break;					/* We reached the bottom of the stack */
	}

#ifdef MAY_PANIC
	/* Now either 's' is NULL and we made a mistake because we asked for
	 * more items than there actually were held in the stack. So eif_panic.
	 * Otherwise 'top' is correctly set and 's' is the new current chunk.
	 */
	if (s == (struct stchunk *) 0)
		eif_panic("run-time stack botched");
#endif

	/* Update stack structure */
	stk->st_cur = s;
	stk->st_top = top;
	stk->st_end = s->sk_end;

	SIGRESUME;			/* Leaving critical section */

	/* There is not much overhead calling st_truncate(), because this is only
	 * done when we are popping at a chunk edge. We have to make sure the
	 * program is running though, as popping done in debugging mode is only
	 * temporary--RAM.
	 */

#ifdef WORKBENCH
	if (d_cxt.pg_status == PG_RUN)	/* Program is running */
		st_truncate(stk);			/* Remove unused chunks */
#else
	st_truncate(stk);				/* Remove unused chunks */
#endif
}


rt_public char **eget(register int num)
{
	/* Get 'num' entries in the 'loc_set' stack to hold Eiffel local reference
	 * variables in the current feature. Usually, the generated C code takes
	 * care of the trivial task when there is enough room at the end of the
	 * chunk. We return the base location of the 'num' entries.
	 * NB: I did not bother optimizing this routine, as it will only be called
	 * when we are at the junction of two local chunks. If the calls happen
	 * to be in a loop, that's too bad--RAM.
	 */

	EIF_GET_CONTEXT
	register2 char **top = loc_set.st_top;	/* The top of the stack */
	register3 char **saved_top = top;		/* Save current top of stack */
	static EIF_REFERENCE null_object = NULL;
	register int i;

#ifdef DEBUG
	dprintf(1)("eget: top = 0x%lx, current = 0x%lx, end = 0x%lx, num = %d\n",
			top, loc_set.st_cur, loc_set.st_end, num);
#endif

	/* If the stack does not already exist, create one and return the pointer
	 * to the base location of the stack, i.e. the arena.
	 * There is no need to protect agains signals here, since the modification
	 * in the stack structure is rather atomic. And if an exception is to be
	 * raised, we do not have to fear any inconsistency.
	 */
	if (top == (char **) 0) {					/* No stack yet? */
		top = st_alloc(&loc_set, eif_stack_chunk);	/* Create one */
		if (top == (char **) 0)					/* Cannot allocate stack */
			enomem(MTC_NOARG);							/* Critical exception */

		if (num > (loc_set.st_end - top))	/* Not enough room in chunk */
			eif_panic(MTC "out of locals");			/* Panic, that's all we can do */

		loc_set.st_top += num;				/* Reserve room for variables */

#ifdef DEBUG
		dprintf(2)("eget: %d slot%s from 0x%lx to 0x%lx (excluded)\n",
				num, num == 1 ? "" : "s", top, loc_set.st_top);
#endif

		return top;							/* This is the pointer we want */
	}

#ifdef DEBUG
	dprintf(4)("eget: chunk ending at 0x%lx is followed by current = 0x%lx\n",
		loc_set.st_end, loc_set.st_cur->sk_next);
#endif

	/* Fill in the end of the current chunk with zeros and advance to the the
	 * next chunk if there is one. Otherwise, extend the stack. Anyway, make
	 * sure there is enough room (in case we had to get an urgent chunk, this
	 * is likely). In that case however, we do not eif_panic, we raise an "Out of
	 * memory" exception.
	 */

	SIGBLOCK;			/* Protect against signals */

		/* Since `loc_set' is a double indirection stack, we need to fill the
		 * remaining elements of current chunk with valid values (and not with zeros
		 * as we were doing it before (look at version 2.13 and older). We decided to
		 * create `null_object' which is a pointer to a NULL value that will cause
		 * no harm to the run-time and to duplicate `null_object' until the end
		 * of the current chunk.
		 */
	for (i = 0; i < (loc_set.st_end - top) ; i++)
		*(char **) (top + i) = (char *) (&null_object);

	top = (char **) loc_set.st_cur->sk_next;	/* Pointer to next chunk */

	if (top == (char **) 0) {					/* No next chunk */
		if (-1 == extend(&loc_set))				/* Extension failed */
			enomem(MTC_NOARG);							/* "Out of memory" exception */
		top = loc_set.st_top;					/* New top of chunk */
	} else {
		loc_set.st_cur = (struct stchunk *) top;	/* Current = next chunk */
		loc_set.st_end = loc_set.st_cur->sk_end;	/* Update end of chunk */
		top = loc_set.st_cur->sk_arena;				/* Recompute base arena */
		loc_set.st_top = top;						/* Chunk is empty */
	}

#ifdef DEBUG
	dprintf(4)("eget: top = 0x%lx, current = 0x%lx, end = 0x%lx, slots = %d\n",
			top, loc_set.st_cur, loc_set.st_end, loc_set.st_end - top);
#endif

	if (num > (loc_set.st_end - top)) {	/* Not enough room in chunk */
		if (num > STACK_CHUNK)			/* Too many locals requested */
			eif_panic(MTC "out of locals");		/* Panic, that's all we can do */
		else {							/* The chunk is too small */
			eback(saved_top);			/* Restore original stack context */
			enomem(MTC_NOARG);					/* This is an exception */
		}
	}

	loc_set.st_top += num;				/* Reserve room for variables */

#ifdef DEBUG
	dprintf(2)("eget: %d slot%s from 0x%lx to 0x%lx (excluded)\n",
			num, num == 1 ? "" : "s", top, loc_set.st_top);
#endif

	SIGRESUME;		/* Resume signal handling */

	return top;		/* This is the base area which may be used for locals */
}

rt_public void eback(register char **top)
{
	/* Restore the stack structure pointer to the previous chunk, setting the
	 * top of the stack to 'top'. Make sure there is no inconsistency in the
	 * stack by checking the range of the pointers.
	 */

	EIF_GET_CONTEXT
#ifdef DEBUG
	dprintf(1)("eback: top = 0x%lx, arena = 0x%lx, end = 0x%lx\n",
			top, loc_set.st_cur->sk_arena, loc_set.st_end);
#endif

	SIGBLOCK;		/* Entering critical section */

	loc_set.st_top = top;						/* Old top */
	loc_set.st_cur = loc_set.st_cur->sk_prev;	/* Previous chunk */

#ifdef MAY_PANIC
	if (loc_set.st_cur == (struct stchunk *) 0)	/* No previous chunk ? */
		eif_panic("local stack underflow");			/* That's a critical event */
#endif

	loc_set.st_end = loc_set.st_cur->sk_end;	/* Update the end of chunk */

#ifdef MAY_PANIC
	if (top < loc_set.st_cur->sk_arena || top > loc_set.st_end)
		eif_panic("local stack inconsistency");
#endif

	SIGRESUME;		/* Leaving critical section */

	st_truncate(&loc_set);				/* Free unneeded chunks */
}

rt_private int extend(register struct stack *stk)
                            			/* The stack to be extended */
{
	/* The stack 'stk' is extended and the 'stk' structure updated.
	 * 0 is returned in case of success. Otherwise, -1 is returned.
	 * If no chunk can be allocated from the memory, an attempt is
	 * made to get one from the urgent storage.
	 */
	EIF_GET_CONTEXT
	register2 int size = STACK_CHUNK;	/* Size of new chunk to be added */
	register3 char **arena;				/* Address for the arena */
	register4 struct stchunk *chunk;	/* Address of the chunk */

	chunk = (struct stchunk *) xmalloc(size * sizeof(char *), C_T, GC_OFF);
	if (chunk == (struct stchunk *) 0) {
		chunk = (struct stchunk *) uchunk();	/* Attempt with urgent mem */
		if (chunk != (struct stchunk *) 0)
			size = HEADER(chunk)->ov_size & B_SIZE;	/* Size of urgent chunks */
	}
	if (chunk == (struct stchunk *) 0)
		return -1;		/* Malloc failed for some reason */

	SIGBLOCK;								/* Critical section */
	arena = (char **) (chunk + 1);			/* Header of chunk */
	chunk->sk_next = (struct stchunk *) 0;	/* Last chunk in list */
	chunk->sk_prev = stk->st_tl;			/* Preceded by the old tail */
	stk->st_tl->sk_next = chunk;			/* Maintain link w/previous */
	stk->st_tl = chunk;						/* New tail */
	chunk->sk_arena = arena;				/* Where items are stored */
	chunk->sk_end = (char **) chunk + size;	/* First item beyond chunk */
	stk->st_top = arena;					/* New top */
	stk->st_end = chunk->sk_end;			/* End of current chunk */
	stk->st_cur = chunk;					/* New current chunk */
	SIGRESUME;								/* End of critical section */

	return 0;			/* Everything is ok */
}

/*
 * Main local stack initialization.
 */

rt_shared void initstk(void)
{
	/* Initialize both the local stack and the hector stack. Those two stacks
	 * may have their context saved and restored in an Eiffel routine, so they
	 * need to be correctly initialized.
	 * In workbench mode, the debugger stack is also created here.
	 */

	EIF_GET_CONTEXT
	char **top;

	top = st_alloc(&loc_set, STACK_CHUNK);
	if (top != (char **) 0)
		top = st_alloc(&hec_stack, STACK_CHUNK);

	if (top == (char **) 0)
		eif_panic(MTC "can't create runtime stacks");

#ifdef WORKBENCH
	initdb();				/* Initialize debugger stack */
#endif
}

