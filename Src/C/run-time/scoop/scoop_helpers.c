/*
	description:	"Helper functions used by the SCOOP runtime."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2010-2015, Eiffel Software.",
				"Copyright (c) 2014 Scott West <scott.gregory.west@gmail.com>"
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
doc:<file name="scoop_helpers.c" header="rt_scoop_helpers.h" version="$Id$" summary="Helper functions used by the SCOOP runtime.">
*/

#include "rt_scoop_helpers.h"
#include "rt_processor_registry.h"

#include "eif_interp.h"
#include "rt_wbench.h"
#include "rt_struct.h"
#include "rt_assert.h"

#include "rt_globals.h"
#include "rt_garcol.h"
#include "rt_macros.h"
#include "rt_except.h"

#include "eif_atomops.h"

#ifdef __cplusplus
extern "C" {
#endif


/* Call logging */

#ifdef WORKBENCH
rt_private void rt_apply_wcall (call_data *data)
{
	EIF_GET_CONTEXT
	uint32            pid = 0; /* Pattern id of the frozen feature */
	EIF_NATURAL_32    i;
	EIF_NATURAL_32    n;
	BODY_INDEX        body_id;
	EIF_TYPED_VALUE * v;

	REQUIRE("has data", data);
	REQUIRE("has target", data->target);

		/* Push arguments to the evaluation stack */
	for (n = data->count, i = 0; i < n; i++) {
		v = eif_opstack_push_empty(&op_stack);
		* v = data->argument [i];
	}
	if (data->routine_id >= 0) {
			/* Regular feature call. */
			/* Push current to the evaluation stack */
		v = eif_opstack_push_empty(&op_stack);
		v->it_r = data->target;
		v->type = SK_REF;
			/* Make a feature call. */
		CBodyId(body_id, data->routine_id,Dtype(data->target));
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
			/* Save result of a call if any. */
		v = data->result;
		if (v) {
			* v = * eif_opstack_pop_address(&op_stack);
		}
	}
	else {
			/* Tuple access. */
		if (n == 0) {
				/* Access to a tuple field. */
			v = data->result;
			eif_tuple_access (data->target, - data->routine_id, v);
		}
		else {
				/* Assignment to a tuple field. */
			v = eif_opstack_pop_address(&op_stack);
			eif_tuple_assign (data->target, - data->routine_id, v);
		}
	}
}
#endif

/*
doc:	<routine name="rt_scoop_try_call" export="shared">
doc:		<summary> Execute the feature in 'call' and do not catch exceptions. </summary>
doc:		<param name="call" type="struct call_data*"> The feature to apply. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None </synchronization>
doc:	</routine>
*/
void rt_scoop_execute_call (call_data* call)
{
#ifdef WORKBENCH
	rt_apply_wcall (call);
#else
	call->pattern (call);
#endif
}

/*
doc:	<routine name="rt_scoop_try_call" return_type="EIF_BOOLEAN" export="shared">
doc:		<summary> Try to apply the feature in 'call', and catch any exceptions that may occur. </summary>
doc:		<param name="call" type="struct call_data*"> The feature to apply. Must not be NULL. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> None </synchronization>
doc:	</routine>
*/
rt_shared EIF_BOOLEAN rt_scoop_try_call (call_data *call)
{
		/* Switch this on to catch exceptions */
		/* This section slows down some benchmarks by 2x. I believe */
		/* this is due to either some locking in the allocation routines (again) */
		/* or reloading the thread local variables often. */
	EIF_GET_CONTEXT
	EIF_BOOLEAN success;
	jmp_buf exenv;
	RTXDR;
#ifdef WORKBENCH
	RTLXD;
	RTLXL;
#endif

		/* TODO: We used to keep track of last_exception in this function,
		 * which caused a call into Eiffel code. Therefore it was necessary
		 * register the call_data struct somewhere for GC traversal.
		 * This is no longer the case now, which means some client code
		 * can be simplified. */

		/* Record pseudo execution vector */
	excatch(&exenv);

	if (!setjmp(exenv)) {
			/* Execute the Eiffel function. */
		rt_scoop_execute_call (call);

		success = EIF_TRUE;

		expop(&eif_stack);
	} else {
#ifdef WORKBENCH
		RTLXE;
#endif
		RTXSC;
		success = EIF_FALSE;
	}

	return success;
}


/*
doc:	<routine name="rt_mark_ref" export="private">
doc:		<summary>Mark and update the reference at 'ref'.</summary>
doc:		<param name="marking" type="MARKER">The marker function. Must not be NULL.</param>
doc:		<param name="ref" type="EIF_REFERENCE*">A pointer to the Eiffel reference. Must not be NULL.</param>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Only call during GC.</synchronization>
doc:	</routine>
*/
rt_private void rt_mark_ref (MARKER marking, EIF_REFERENCE *ref)
{
	REQUIRE("marking_not_null", marking);
	REQUIRE("ref_not_null", ref);
	*ref = marking (ref);
}
/*
doc:	<routine name="rt_mark_call_data" export="shared">
doc:		<summary>Mark all references in the call_data struct 'call'.</summary>
doc:		<param name="marking" type="MARKER">The marker function. Must not be NULL.</param>
doc:		<param name="call" type="struct call_data*">The call_data struct. Must not be NULL.</param>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Only call during GC.</synchronization>
doc:	</routine>
*/
rt_shared void rt_mark_call_data(MARKER marking, struct call_data* call)
{
	size_t i;

	REQUIRE("Cannot mark NULL calls", call);

	rt_mark_ref (marking, &call->target);

	for (i = 0; i < call->count; i++) {
		if (call->argument[i].type == SK_REF) {
			rt_mark_ref (marking, &call->argument[i].it_r);
		}
	}
}


/*
doc:	<routine name="rt_set_processor_id" export="shared">
doc:		<summary>Associate processor of ID `pid' with the current thread.</summary>
doc:		<param name="pid" type="EIF_SCP_PID">ID of the processor.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Not required because called before starting any threads.</synchronization>
doc:	</routine>
*/
rt_shared void rt_set_processor_id (EIF_SCP_PID pid)
{
	RT_GET_CONTEXT
	rt_thr_context * c = rt_globals->eif_thr_context_cx;
	c -> logical_id = pid;
	c -> is_processor = EIF_TRUE;
}

/*
doc:	<routine name="rt_unset_processor_id" export="shared">
doc:		<summary>Dissociate processor from the current thread.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>Not required because changes a single integer value.</synchronization>
doc:	</routine>
*/
rt_shared void rt_unset_processor_id (void)
{
	RT_GET_CONTEXT
		/* We use the EIF_NULL_PROCESSOR to indicate that this thread is
		 * a SCOOP processor that is about to be destroyed.
		 * Otherwise the GC might think that it's dealing with a regular thread. */
	rt_globals -> eif_thr_context_cx -> logical_id = EIF_NULL_PROCESSOR;
}

/*
doc:	<routine name="rt_scoop_gc_request" return_type="void" export="shared">
doc:		<summary> Run a GC cycle when 'fingerprint' has not changed since the last call. </summary>
doc:		<param name="fingerprint" type="int*"> The fingerprint value. </param>
doc:		<thread_safety> Safe. </thread_safety>
doc:		<synchronization> None required, done internally through atomic operations. </synchronization>
doc:	</routine>
*/
rt_shared void rt_scoop_gc_request (int* fingerprint)
{
	static volatile int gc_fingerprint = 0;
	int previous_fingerprint = * fingerprint;
	int current_fingerprint = RTS_ACAS_I32 (&gc_fingerprint, previous_fingerprint + 1, previous_fingerprint);

	if (current_fingerprint == previous_fingerprint) {
			/* The fingerprint is unchanged since last call, no GC was run, do it now. */
			/* Record newly written fingerprint for the next time. */
		* fingerprint = previous_fingerprint + 1;
			/* Run GC. */
		plsc();
	}
	else {
			/* Record current fingerprint for the next time. */
		* fingerprint = current_fingerprint;
	}
}

/*
doc:	<routine name="rt_scoop_setup" return_type="void" export="shared">
doc:		<summary> Initialize the SCOOP subsystem and mark the root thread as a processor with ID 0. </summary>
doc:		<param name="is_scoop_enabled" type="int"> Whether SCOOP was enabled in the project settings. Depending on this value initialization may be partially skipped. </param>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during program startup. </synchronization>
doc:	</routine>
*/
rt_public void rt_scoop_setup (int is_scoop_enabled)
{
		/* Note: We initialize the SCOOP processor_registry in any case,
		 * because of a bug in the interpreter which may sometimes execute RTS_OU
		 * even in non-SCOOP systems. */
	int error = rt_processor_registry_init ();

	if (T_OK == error && is_scoop_enabled) {
			/* Record that the current thread is associated with a processor of a PID 0. */
		rt_set_processor_id (0);
	}

	if (T_OK != error) {
		eif_panic ("Could not initialize SCOOP subsystem.");
	}
}

/*
doc:	<routine name="rt_scoop_reclaim" return_type="void" export="shared">
doc:		<summary> Reclaim all resources in the SCOOP subsystem. </summary>
doc:		<thread_safety> Not safe. </thread_safety>
doc:		<synchronization> Only call during program termination. </synchronization>
doc:	</routine>
*/
rt_public void rt_scoop_reclaim (void)
{
	rt_processor_registry_deinit();
}


#ifdef __cplusplus
}
#endif

/*
doc:</file>
*/
