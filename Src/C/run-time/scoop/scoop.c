/*
	description:	"SCOOP support."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2010-2012, Eiffel Software."
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="scoop.c" header="eif_scoop.h" version="$Id$" summary="SCOOP support.">
*/

#include "eif_portable.h"
#include "rt_assert.h"
#include "rt_globals.h"
#include "rt_struct.h"
#include "rt_wbench.h"
#include "rt_malloc.h"
#include "rt_garcol.h"
#include "rt_macros.h"

#ifndef EIF_THREADS
#error "SCOOP is currenly supported only in multithreaded mode."
#endif

void eif_call_const (call_data * a)
{
	/* Constant value is hard-coded in the generated code: nothing to do here. */
	/* Avoid C compiler error about unreferenced parameter. */
	(void) a;
}

rt_public void eif_free_call (call_data * a)
{
	EIF_NATURAL_32    i;
	EIF_TYPED_VALUE * v;

		/* Unprotect arguments from being garbage-collected. */
	for (i = a -> count; i > 0;) {
		v = &(a -> argument [--i]);
		if ((v -> it_r) && (v -> type & SK_HEAD) == SK_REF) {
			eif_unsafe_wean ((EIF_OBJECT) v -> it_r);
		}
	}
		/* Unprotect target of a call. */
	eif_unsafe_wean (a -> target);
		/* Free memory, allocated for `a'. */
	eif_rt_xfree (a);
}

/* Request chain stack */

/* Push client `c' on the request chain stack `stk' without notifying SCOOP mananger. */
rt_public void eif_request_chain_push (EIF_REFERENCE c, struct stack * stk)
{
	epush (stk, c);
}

/* Pop one element from the request chain stack `stk' without notifying SCOOP mananger. */
rt_public void eif_request_chain_pop (struct stack * stk)
{
	EIF_REFERENCE * top = stk->st_top - 1;   /* Start from the current top. */

	if (top >= stk->st_cur->sk_arena) {
		stk->st_top = top;               /* We remain in current chunk. */
	}
	else {
		struct stchunk * s;              /* Top is in the previous chunk. */

		RT_GET_CONTEXT

		SIGBLOCK;                        /* Entering critical section */

		s = stk->st_cur->sk_prev;        /* Look at previous chunk */
		CHECK("sep_stack underflow", s);
		top = s->sk_end - 1;		 /* Top at the end of previous chunk */

		stk->st_cur = s;                 /* Update stack structure */
		stk->st_top = top;
		stk->st_end = s->sk_end;

		SIGRESUME;                       /* Leaving critical section */
#ifdef WORKBENCH
		if (d_cxt.pg_status == PG_RUN)   /* Program is running */
#endif
			st_truncate(stk);        /* Remove unused chunks */
	}
}

/* Restore request chain stack `stk' to have the top `t' notifying SCOOP manager about all removed request chains. */
rt_public void eif_request_chain_restore (EIF_REFERENCE * t, struct stack * stk)
{
	EIF_REFERENCE * top = stk->st_top;
	if (!t) {
		t = stk->st_hd->sk_arena; /* Use the beginning of the stack in case stack was empty. */
	}
	while (top != t) {
		eif_request_chain_pop (stk); /* Pop one element. */
		top = stk->st_top;
		RTS_RD (*top);               /* Notify SCOOP manager about removed item. */
	}
}

/* Processor properties */

/*
doc:	<routine name="eif_set_processor_id" export="public">
doc:		<summary>Associate processor of ID `pid' with the current thread.</summary>
doc:		<param name="pid" type="EIF_SCP_PID">ID of the processor.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Not required because called before starting any threads.</synchronization>
doc:	</routine>
*/
rt_public void eif_set_processor_id (EIF_SCP_PID pid)
{
	RT_GET_CONTEXT
	rt_thr_context * c = rt_globals->eif_thr_context_cx;
	c -> logical_id = pid;
	c -> is_processor = EIF_TRUE;
}

/*
doc:	<routine name="eif_unset_processor_id" export="public">
doc:		<summary>Dissociate processor from the current thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Not required because changes a single integer value.</synchronization>
doc:	</routine>
*/
rt_public void eif_unset_processor_id (void)
{
	RT_GET_CONTEXT
	eif_synchronize_gc (rt_globals);
	rt_globals -> eif_thr_context_cx -> is_processor = EIF_FALSE;
	eif_unsynchronize_gc (rt_globals);
}

/*
doc:</file>
*/
