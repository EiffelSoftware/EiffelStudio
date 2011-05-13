/*
	description:	"SCOOP support."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2010, Eiffel Software."
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
			 Telephone /R805-685-1006, Fax 805-685-6869
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

#ifndef EIF_THREADS
#error "SCOOP is currenly supported only in multithreaded mode."
#endif

rt_public EIF_BOOLEAN eif_is_uncontrolled (EIF_SCP_PID c, EIF_SCP_PID s)
{
	EIF_TYPED_VALUE ou; 
	ou.item.b = EIF_FALSE;
	ou.type = SK_BOOL;
	RTS_TCB(scoop_task_check_uncontrolled,c,s,0,&ou,NULL);
	return EIF_TEST (ou.item.b);
}

#ifdef WORKBENCH

rt_public void eif_log_call (int s, int f, EIF_SCP_PID p, call_data * a)
{
	BODY_INDEX body_id;
	EIF_REFERENCE t = eif_access (a -> target);

	CHECK("Target attached", t);
	CBodyId(body_id,Routids(s)[f],Dtype(t));
	a -> body_index = body_id;
	RTS_TCB(scoop_task_add_call,p,RTS_PID(t),body_id,a,NULL);
}
 
rt_public void eif_log_callp (int s, int f, EIF_SCP_PID p, call_data * a)
{
	BODY_INDEX body_id;
	EIF_REFERENCE t = eif_access (a -> target);

	CHECK("Target attached", t);
	body_id = desc_tab[s][Dtype(t)][f].body_index;
	a -> body_index = body_id;
	RTS_TCB(scoop_task_add_call,p,RTS_PID(t),body_id,a,NULL);
}
 
rt_public void eif_try_call (call_data * a)
{
	uint32            pid = 0; /* Pattern id of the frozen feature */
	EIF_NATURAL_32    i;
	EIF_NATURAL_32    n;
	BODY_INDEX        body_id = a -> body_index;
	EIF_TYPED_VALUE * v;

		/* Push arguments to the evaluation stack */
	for (n = a -> count, i = 0; i < n; i++) {
		v = iget ();
		* v = a -> argument [i];
		if ((v -> type & SK_HEAD) == SK_REF) {
			v -> it_r = eif_access (v -> it_r);
		}
	}
		/* Push current to the evaluation stack */
	v = iget ();
	v -> it_r = eif_access (a -> target);
	v -> type = SK_REF;
		/* Make a call */
	if (egc_frozen [body_id]) {		/* We are below zero Celsius, i.e. ice */
		pid = (uint32) FPatId(body_id);
		(pattern[pid].toc)(egc_frozen[body_id]); /* Call pattern */
	} else {
		/* The proper way to start the interpretation of a melted feature is to call `xinterp'
		 * in order to initialize the calling context (which is not done by `interpret').
		 * `tagval' will therefore be set, but we have to resynchronize the registers anyway.
		 */
		xinterp(MTC melt[body_id], 0);
	}
		/* Save result of a call */
	v = a -> result;
	if (v) {
		* v = * opop ();
	}
}

#else

rt_public void eif_log_call (EIF_SCP_PID p, call_data * a)
{
	EIF_REFERENCE t = eif_access (a -> target);

	CHECK("Target attached", t);
	RTS_TCB(scoop_task_add_call,p,RTS_PID(t),0,a,NULL);
}

#endif /* WORKBENCH */

rt_public void eif_free_call (call_data * a)
{
	EIF_NATURAL_32    i;
	EIF_TYPED_VALUE * v;

		/* Unprotect arguments from being garbage-collected. */
	for (i = a -> count; i > 0;) {
		v = &(a -> argument [--i]);
		if ((v -> type & SK_HEAD) == SK_REF) {
			eif_wean ((EIF_OBJECT) v -> it_r);
		}
	}
		/* Unprotect target of a call. */
	eif_wean (a -> target);
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

/*
doc:</file>
*/
