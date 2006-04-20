/*
	description: "Handling of local variable stack."
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
doc:<file name="local.c" header="eif_local.h" version="$Id$" summary="Handling of local variable stack">
*/

#include "eif_portable.h"
#include "rt_malloc.h"
#include "rt_garcol.h"
#include "eif_except.h"
#include "rt_urgent.h"
#include "eif_local.h"
#include "eif_hector.h"
#include "rt_sig.h"
#ifdef WORKBENCH
#include "rt_debug.h"
#endif
#include "rt_globals.h"
#include "rt_assert.h"

#include <string.h>

#ifdef I_STDARG
#include <stdarg.h>
#else
#ifdef I_VARARGS
#include <varargs.h>
#endif
#endif

#include <stdio.h>

#ifdef EIF_ASSERTIONS
#if defined(EIF_WINDOWS) && defined (_DEBUG)
#include <crtdbg.h>
#endif
#endif

#define dprintf(n)		if (DEBUG & (n)) printf

rt_public void epop(struct stack *stk, rt_uint_ptr nb_items);					/* Pops values off a stack */
rt_private int extend(struct stack *stk, rt_uint_ptr nb_items);				/* Stack extension w/ urgent chunks */

rt_public void epop(struct stack *stk, rt_uint_ptr nb_items)
                            		/* The stack */
                       				/* Number of items to be popped */
{
	/* Removes 'nb_items' from the stack 'stk'. The routine is more general
	 * than needed, but it keeps the spirit of epush().
	 */
	char **top = stk->st_top;		/* Current top of the stack */

	/* Optimization: try to update the top, hoping it will remain in the
	 * same chunk. This avoids pointer manipulation (walking along the stack)
	 * which may induce swapping, who knows?
	 */

	top -= nb_items;				/* Hopefully, we remain in current chunk */
	if (top >= stk->st_cur->sk_arena) {
		stk->st_top = top;			/* Yes! Update top, we are lucky. */
	} else {
		struct stchunk *s;			/* To walk through stack chunks */
		char **arena;					/* Base address of current chunk */

		RT_GET_CONTEXT

		/* Normal case: we have to pop more than the number of elements in the
		 * current chunk. Loop until we popped enough items. This is also where
		 * we have to protect against signals or there is a risk the data structure
		 * be corrupted.
		 */

		SIGBLOCK;			/* Entering critical section */
		
		top = stk->st_top;
		for (s = stk->st_cur; nb_items > 0; /* empty */) {
			arena = s->sk_arena;
			CHECK("top greater than arena", top >= arena);
			if (nb_items <= (rt_uint_ptr) (top - arena)) {	/* We've gone too far? */
				top -= nb_items;				/* Update `top' correctly */
				break;							/* Done */
			} else {
				nb_items -= (top - arena);
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
}


#ifdef ISE_GC
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

	RT_GET_CONTEXT
	EIF_GET_CONTEXT
	char **top = loc_set.st_top;	/* The top of the stack */
	char **saved_top = top;		/* Save current top of stack */
	static EIF_REFERENCE null_object = NULL;
	register int i;

		/* If the stack does not already exist, create one and return the pointer
		 * to the base location of the stack, i.e. the arena.
		 * There is no need to protect agains signals here, since the modification
		 * in the stack structure is rather atomic. And if an exception is to be
		 * raised, we do not have to fear any inconsistency.
		 */
	if (top == NULL) {							/* No stack yet? */
			/* Create one */
		top = st_alloc(&loc_set, (num > eif_stack_chunk ? num : eif_stack_chunk));
		if (top == NULL) {
				/* Cannot allocate stack */
			enomem(MTC_NOARG);						/* Critical exception */
		} else {
			loc_set.st_top += num;				/* Reserve room for variables */
		}
		return top;							/* This is the pointer we want */
	} else {
		SIGBLOCK;			/* Protect against signals */

			/* Fill in the end of the current chunk with valid data (see below) and advance
			 * to the next chunk if there is one. Otherwise, extend the stack. Anyway, make
			 * sure there is enough room (in case we had to get an urgent chunk, this
			 * is likely). In that case however, we do not eif_panic, we raise an "Out of
			 * memory" exception.
			 */

			/* Since `loc_set' is a double indirection stack, we need to fill the
			 * remaining elements of current chunk with valid values (and not with zeros
			 * as we were doing it before (look at version 2.13 and older). We decided to
			 * create `null_object' which is a pointer to a NULL value that will cause
			 * no harm to the run-time and to duplicate `null_object' until the end
			 * of the current chunk.
			 */
		for (i = 0; i < (loc_set.st_end - top) ; i++) {
			*(char **) (top + i) = (char *) (&null_object);
		}

		top = (char **) loc_set.st_cur->sk_next;	/* Pointer to next chunk */

		if (top == NULL) {					/* No next chunk */
			if (-1 == extend(&loc_set, (num > eif_stack_chunk ? num : eif_stack_chunk))) {
					/* Extension failed */
				enomem(MTC_NOARG);						/* "Out of memory" exception */
			} else {
				top = loc_set.st_top;					/* New top of chunk */
			}
			CHECK("Enough room", num <= (loc_set.st_end - top));
			loc_set.st_top += num;						/* Reserve room for variables */
		} else {
			loc_set.st_cur = (struct stchunk *) top;	/* Current = next chunk */
			loc_set.st_end = loc_set.st_cur->sk_end;	/* Update end of chunk */
			top = loc_set.st_cur->sk_arena;				/* Recompute base arena */
			loc_set.st_top = top;						/* Chunk is empty */

			if (num > (loc_set.st_end - top)) {	/* Not enough room in chunk */
					/* Perform a recursive call until we either find a block which
					 * has at least `num' entries, or until we do not find anymore blocks
					 * in which case we will allocate a new one.
					 * No need to clear this block, it will be cleared in the call to `eget'.
					 */
				top = eget (num);
			} else {
				loc_set.st_top += num;				/* Reserve room for variables */
			}
		}

		SIGRESUME;		/* Resume signal handling */

		return top;		/* This is the base area which may be used for locals */
	}
}

rt_public void eback(register char **top)
{
	/* Restore the stack structure pointer to the previous chunk where `top' belongs,
	 * setting the top of the stack to 'top'.
	 */

	RT_GET_CONTEXT
	EIF_GET_CONTEXT

	REQUIRE("Has current chunk", loc_set.st_cur);

	SIGBLOCK;		/* Entering critical section */

	loc_set.st_top = top;						/* Old top */
	while ((top < loc_set.st_cur->sk_arena || top > loc_set.st_cur->sk_end)) {
		CHECK("Not going under", loc_set.st_cur->sk_prev);
		loc_set.st_cur = loc_set.st_cur->sk_prev;	/* Previous chunk */
	}
	loc_set.st_end = loc_set.st_cur->sk_end;	/* Update the end of chunk */

	SIGRESUME;		/* Leaving critical section */

	st_truncate(&loc_set);				/* Free unneeded chunks */
}

#endif

rt_private int extend(struct stack *stk, rt_uint_ptr nb_items)
                            			/* The stack to be extended */
{
	/* The stack 'stk' is extended and the 'stk' structure updated.
	 * 0 is returned in case of success. Otherwise, -1 is returned.
	 * If no chunk can be allocated from the memory, an attempt is
	 * made to get one from the urgent storage.
	 */
	RT_GET_CONTEXT
	char **arena;				/* Address for the arena */
	struct stchunk *chunk;	/* Address of the chunk */
	rt_uint_ptr l_size = nb_items * REFSIZ + sizeof(struct stchunk);

	chunk = (struct stchunk *) eif_rt_xmalloc(l_size, C_T, GC_OFF);
	if (chunk == (struct stchunk *) 0) {
		chunk = (struct stchunk *) uchunk();	/* Attempt with urgent mem */
		if (chunk != (struct stchunk *) 0) {
			l_size = HEADER(chunk)->ov_size & B_SIZE;	/* Size of urgent chunks */
		}
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
	chunk->sk_end = (char **) ((char *) chunk + l_size);	/* First item beyond chunk */
	stk->st_top = arena;					/* New top */
	stk->st_end = chunk->sk_end;			/* End of current chunk */
	stk->st_cur = chunk;					/* New current chunk */
	SIGRESUME;								/* End of critical section */

	return 0;			/* Everything is ok */
}

#ifdef EIF_WINDOWS
#ifdef EIF_ASSERTIONS
	/* This code is commented because it only exists with the latest Microsoft CRT runtime.
	 * Uncomment if you need to catch CRT raised exception when passing incorrect arguments
	 * to CRT routines. */	
/*
void myInvalidParameterHandler(const wchar_t* expression,
   const wchar_t* function, 
   const wchar_t* file, 
   unsigned int line, 
   uintptr_t pReserved)
{
}
*/
#endif
#endif

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
#ifdef ISE_GC
	char **top;
#endif

#ifdef EIF_WINDOWS
#ifdef EIF_ASSERTIONS
	/* This code is commented because it only exists with the latest Microsoft CRT runtime.
	 * Uncomment if you need to catch CRT raised exception when passing incorrect arguments
	 * to CRT routines. */	
/*   _set_invalid_parameter_handler(myInvalidParameterHandler); */
#endif
#endif

#ifdef EIF_ASSERTIONS
#if defined(EIF_WINDOWS) && defined(_DEBUG)
	int tmpDbgFlag = 0;
	_CrtSetReportMode(_CRT_WARN, _CRTDBG_MODE_FILE);
	_CrtSetReportFile(_CRT_WARN, _CRTDBG_FILE_STDOUT);
	_CrtSetReportMode(_CRT_ERROR, _CRTDBG_MODE_FILE);
	_CrtSetReportFile(_CRT_ERROR, _CRTDBG_FILE_STDOUT);
	_CrtSetReportMode(_CRT_ASSERT, _CRTDBG_MODE_FILE);
	_CrtSetReportFile(_CRT_ASSERT, _CRTDBG_FILE_STDOUT);

	tmpDbgFlag = _CrtSetDbgFlag(_CRTDBG_REPORT_FLAG);
	tmpDbgFlag |= _CRTDBG_DELAY_FREE_MEM_DF;
	tmpDbgFlag |= _CRTDBG_LEAK_CHECK_DF;
	tmpDbgFlag |= _CRTDBG_CHECK_ALWAYS_DF;
	_CrtSetDbgFlag(tmpDbgFlag);
#endif
#endif

#ifdef ISE_GC
	top = st_alloc(&loc_set, eif_stack_chunk);
	if (top != (char **) 0)
		top = st_alloc(&hec_stack, eif_stack_chunk);

	if (top == (char **) 0)
		eif_panic(MTC "can't create runtime stacks");
#endif

#ifdef WORKBENCH
	initdb();				/* Initialize debugger stack */
#endif
}

/*
doc:</file>
*/
