/*

 #        ####    ####     ##    #                ####
 #       #    #  #    #   #  #   #               #    #
 #       #    #  #       #    #  #               #
 #       #    #  #       ######  #        ###    #
 #       #    #  #    #  #    #  #        ###    #    #
 ######   ####    ####   #    #  ######   ###     ####

	Handling of local variable stack.

	If this file is compiled with -DTEST, it will produce a standalone
	executable.
*/

#include <stdio.h>

#include "eif_config.h"
#ifdef I_STRING
#include <string.h>
#else
#include <strings.h>
#endif
#include "eif_malloc.h"
#include "eif_garcol.h"
#include "eif_except.h"
#include "eif_urgent.h"
#include "eif_local.h"
#include "eif_hector.h"
#include "eif_sig.h"
#ifdef WORKBENCH
#include "eif_debug.h"
#endif

#ifdef I_STDARG
#include <stdarg.h>
#else
#ifdef I_VARARGS
#include <varargs.h>
#endif
#endif
#include "eif_main.h" /* for eif_alloc_init() */

#define dprintf(n)		if (DEBUG & (n)) printf

rt_public void epop(register struct stack *stk, register int nb_items);					/* Pops values off a stack */
rt_private int extend(register struct stack *stk);				/* Stack extension w/ urgent chunks */

/* Compiled with -DTEST, we turn on DEBUG if not already done */
#ifdef TEST
#ifndef DEBUG
#define DEBUG	1		/* Highest debug level */
#endif
#endif

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
	EIF_END_GET_CONTEXT
}


/* VARARGS2 */
#ifdef I_STDARG
rt_public void evpush(int count, ...)
#else
rt_public void evpush(va_alist)
#endif
{
	/* Push on the local variable stack the number of values indicated
	 * by the first (int) argument. If all the values cannot successively
	 * be pushed, we attempt to use the secure arena which should have been
	 * pre-allocated for that purpose (we can't really call the GC before all
	 * the locals have been pushed).
	 */

	EIF_GET_CONTEXT
	register1 int n;				/* Number of elements to be pushed */
	register2 char **top;			/* The current top of the stack */
#ifdef EIF_WINDOWS
	va_list ap;			/* The variable argument list */
#else
	register3 va_list ap;			/* The variable argument list */
#endif
	register4 int i;				/* Number of slots until end of chunk */
	register5 struct stack *stk;	/* The local stack pointer */

#ifndef I_STDARG
	va_start(ap);
	n = va_arg(ap, int);
#else
	va_start (ap, count);
	n = count;		/* First argument is the number of items */
#endif

	/* This function is going to be called many many times, so it has to be
	 * as mostly efficient as possible. Hence, the call to epush() which should
	 * take place has been inlined. This also enables us to take advantage of
	 * the secure arena at low costs--RAM.
	 */

	stk = &loc_stack;		/* Load pointer in register for faster access */
	top = stk->st_top;		/* Current top of stack */

	/* Create a new stack if none has been already allocated. If allocation
	 * fails, we don't bother trying with the urgent memory stock: we must be
	 * at the beginning of the process's lifetime and we are already out of
	 * memory--RAM.
	 */

	if (top == (char **) 0) {				/* No stack yet? */
		top = st_alloc(stk, STACK_CHUNK);	/* Create one */
		if (top == (char **) 0)				/* Cannot allocate stack */
			enomem(MTC_NOARG);						/* Critical exception */
	}

	/* Attempt an optimization: if there is enough room until the end of the
	 * current stack chunk, then we're able to do our job very efficiently.
	 */
	
	i = stk->st_end - top;					/* # of slots until the end */
	if (i >= n) {							/* Enough room to do it once?*/
		while (n--)							/* Yes! Do it the fast way */
			*top++ = va_arg(ap, char *);	/* Push local address on stack */
		stk->st_top = top;					/* Update stack's top */
		va_end(ap);					/* End processing of argument list */
		return;						/* All done */
	}

	/* We have to do it manually. Stack extension is done as needed. If it is
	 * not possible to push a value on the stack, a critical "Out of memory"
	 * exception is raised. We also need to protect against signals.
	 */

	SIGBLOCK;		/* Entering critical section */

	while (n > 0) {
		while (i-- > 0 && n-- > 0)			/* Note the double & */
			*top++ = va_arg(ap, char *);	/* Push local address on stack */
		if (n > 0) {						/* Reached end of chunk */
			if (stk->st_cur == stk->st_tl) {	/* Last chunk */
				if (-1 == extend(&loc_stack)) {	/* Cannot extend stack at all */
					va_end(ap);					/* End processing of list */
					enomem(MTC_NOARG);					/* Critical exception */
				}
				top = stk->st_top;				/* Update new top */
			} else {							/* Go to next chunk */
				register5 struct stchunk *c;	/* New current chunk */
				c = stk->st_cur = stk->st_cur->sk_next;
				top = stk->st_top = c->sk_arena;
				stk->st_end = c->sk_end;
			}
			i = stk->st_end - top;				/* # of slots until the end */
		}
	}

	stk->st_top = top;		/* Ensure top is up-to-date */
	va_end(ap);				/* End processing of argument list */

	SIGRESUME;				/* Leaving critical section */
	EIF_END_GET_CONTEXT
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
		top = st_alloc(&loc_set, STACK_CHUNK);	/* Create one */
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

	bzero(top, (loc_set.st_end - top) * sizeof(char *));
												/* Fill in end of chunk */

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
	EIF_END_GET_CONTEXT
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
	EIF_END_GET_CONTEXT
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
	EIF_END_GET_CONTEXT
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

#ifndef EIF_THREADS
	/*
	 * Set the default chunk and scavenge zone size. In multithreaded mode,
	 * eif_alloc_init is called from eif_thr_register.
	 */
	eif_alloc_init();
#endif

	top = st_alloc(&loc_set, STACK_CHUNK);
	if (top != (char **) 0)
		top = st_alloc(&hec_stack, STACK_CHUNK);

	if (top == (char **) 0)
		eif_panic(MTC "can't create runtime stacks");

#ifdef WORKBENCH
	initdb();				/* Initialize debugger stack */
#endif

	EIF_END_GET_CONTEXT
}

#ifdef TEST

/* This section implements a set of tests for the local variable stack.
 * It should not be regarded as a model of C programming :-).
 * To run this, compile the file with -DTEST.
 */

#undef TEST
#undef DEBUG

#define Size(x)			40
#define References(x)	2
#define Dispose(type)	((void (*)()) 0)	/* No dispose routine */

#define DEBUG 0			/* So that we get debugging routines/tests */
#define lint			/* Avoid definition of rcsid */
#include "eif_malloc.c"
#include "garcol.c"
#include "timer.c"
#include "urgent.c"

rt_private void collect_stats(void);	/* Gives statistics on collector's stack */
rt_private void stack_stats(void);		/* Gives statistics on local stack */

rt_public main(void)
{
	/* Tests for the local variable stack */

	int i;
	char *a1, *a2;

	printf("> Starting tests for local variable stack.\n");

	/* Check the stack */
	printf(">> Checking the stack management routines.\n");
	printf(">>> Pushing one item.\n");
	epush(&loc_stack, (char *) 0);
	stack_stats();
	printf(">>> Poping the stack.\n");
	epop(&loc_stack, 1);
	stack_stats();

	/* With 10000 items */
	printf(">>> Pushing 20000 items.\n");
	for (i = 0; i < 20000; i++)
		evpush(1, &i);
	stack_stats();
	printf(">>> Poping one item.\n");
	epop(&loc_stack, 1);
	stack_stats();
	printf(">>> Poping 9999 items.\n");
	epop(&loc_stack, 9999);
	stack_stats();
	printf(">>> Poping 10000 items (stack should be empty).\n");
	epop(&loc_stack, 10000);
	stack_stats();

	/* Test collection of local vars */
	printf(">> Testing collection of local vars.\n");
	printf(">>> Creating object A (remembered)\n");
	a1 = emalloc(0);
	eremb(a1);
	printf(">>> Creating object B (not remembered)\n");
	a2 = emalloc(0);
	printf(">>> Pushing A and B in local stack.\n");
	evpush(2, &a1, &a2);
	stack_stats();
	collect_stats();
	printf(">>>> Address of A: 0x%lx\n", a1);
	printf(">>>> Address of B: 0x%lx\n", a2);
	printf(">>> Running a full collection.\n");
	plsc();
	stack_stats();
	collect_stats();
	printf(">>>> Address of A: 0x%lx (changed)\n", a1);
	printf(">>>> Address of B: 0x%lx (changed)\n", a2);
	printf(">>> Running a full collection again.\n");
	plsc();
	stack_stats();
	collect_stats();
	printf(">>>> Address of A: 0x%lx (same as first one)\n", a1);
	printf(">>>> Address of B: 0x%lx (same as first one)\n", a2);

	printf("> End of tests.\n");
	exit(0);
}

rt_private void collect_stats(void)
{
	/* Print statistics about other collector stack */

	printf(">>>> Remembered items: %d\n", nb_items(&rem_set));
}

rt_private void stack_stats(void)
{
	/* Print statistics about the local vars stack */

	printf(">>>> Number of items: %d\n", nb_items(&loc_stack));
}

/* Functions not provided here */
rt_public void eif_panic(char *s)
{
	printf("PANIC: %s\n", s);
	exit(1);
}

rt_public void eraise(int val, char *tag)		/* %%zs incoherent with other definitions (see bits.c:964, except.c:132, garcol.c:3901, eif_malloc.c:3495 */
{
	xraise(val);
}

rt_public void enomem(void)
{
	xraise(0);
}

rt_public void xraise(int val)
{
	printf("xraise: exception code %d\n", val);
}

rt_public void exhdlr(Signal_t (*handler)(int), int sig)
{
	(handler)(sig);		/* Call handler */
}

rt_shared int esigblk = 0;				/* By default, signals are not blocked */
rt_shared struct s_stack sig_stk;
rt_shared void esdpch(void)
{
}

#endif
