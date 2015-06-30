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
#include "rt_globals_access.h"
#include "rt_assert.h"
#include "eif_stack.h"

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

#ifdef ISE_GC
rt_public EIF_REFERENCE **eget(register size_t num)
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
	struct stoachunk *s = loc_set.st_cur;
	struct stoachunk *next;
	EIF_REFERENCE **top;	/* The top of the stack */

	REQUIRE("loc_set allocated", loc_set.st_cur);
	REQUIRE("current is too small", loc_set.st_cur->sk_end < (loc_set.st_cur->sk_top + num));

	next = s->sk_next;	/* Pointer to next chunk */
	if (!next) {					/* No next chunk */
		top = eif_oastack_extend(&loc_set, (num > eif_stack_chunk ? num : eif_stack_chunk));
		if (!top) {
				/* Extension failed */
			enomem(MTC_NOARG);						/* "Out of memory" exception */
		}
		CHECK("Enough room", (top + num) <= loc_set.st_cur->sk_end);
	} else {
		top = next->sk_top = next->sk_arena;	/* Recompute base arena */
		loc_set.st_cur = next;	/* Current = next chunk */

		if (top + num > next->sk_end) {	/* Not enough room in chunk */
				/* Perform a recursive call until we either find a block which
				 * has at least `num' entries, or until we do not find anymore blocks
				 * in which case we will allocate a new one.
				 * No need to clear this block, it will be cleared in the call to `eget'.
				 */
			top = eget (num);
		}
	}

	return top;		/* This is the base area which may be used for locals */
}

rt_public void eback(EIF_REFERENCE **top)
{
	/* Restore the stack structure pointer to the previous chunk where `top' belongs,
	 * setting the top of the stack to 'top'.
	 */
	EIF_GET_CONTEXT
	struct stoachunk *s = loc_set.st_cur;

	REQUIRE("Has current chunk", loc_set.st_cur);

	while ((top < s->sk_arena || top > s->sk_end)) {
		CHECK("Not going under", s->sk_prev);
		s = s->sk_prev;	/* Previous chunk */
	}

		/* Update to new current chunk of stack wher `top' is located. */
	loc_set.st_cur = s;
	eif_oastack_truncate(&loc_set);				/* Free unneeded chunks */
}

#endif

#if defined(EIF_WINDOWS) && defined(_MSC_VER)
	/* This is to catch CRT raised exception when passing incorrect arguments to CRT routines. */
rt_private void __cdecl eif_invalid_paramter_handler(const wchar_t* expression,
   const wchar_t* function, const wchar_t* file, unsigned int line, uintptr_t pReserved)
{
		/* We simply ignore those errors as they are caugth by our runtime and then it raises
		 * an exception in the Eiffel code in normal Eiffel execution. However if _DEBUG is
		 * enabled we can force a failure. */
#ifdef _DEBUG
	failure();
#endif
}
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
	void *top;
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

#if defined(EIF_WINDOWS) && defined(_MSC_VER)
		/* This is to catch CRT raised exception when passing incorrect arguments to CRT routines. */
	_set_invalid_parameter_handler(eif_invalid_paramter_handler);
#endif

#ifdef ISE_GC
	top = eif_oastack_allocate(&loc_set, eif_stack_chunk);
	if (top) {
		top = eif_ostack_allocate(&hec_stack, eif_stack_chunk);
	}

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
