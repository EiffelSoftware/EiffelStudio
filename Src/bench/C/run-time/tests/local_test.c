#include "local.c"

/* Compiled with -DTEST, we turn on DEBUG if not already done */
#ifdef TEST
#ifndef DEBUG
#define DEBUG	1		/* Highest debug level */
#endif
#endif

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


