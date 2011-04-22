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
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _eif_scoop_h_
#define _eif_scoop_h_

#ifdef __cplusplus
extern "C" {
#endif

/* Separate calls */

typedef struct call_data {
	EIF_OBJECT        target;          /* Target of a call */
#ifdef WORKBENCH
	BODY_INDEX        body_index;      /* Routine to be called */
	EIF_TYPED_VALUE * result;          /* Address of a result for queries */
#else
	union {
		fnptr             address;         /* Routine to be called */
		size_t            offset;          /* Offset of an attribute */
	} feature;
	void *            result;          /* Address of a result for queries, the result type depends on the called feature */
	void           (* pattern) (struct call_data *); /* Stub that is used to perform a call */
#endif /* WORKBENCH */
	EIF_NATURAL_32    count;           /* Number of arguments excluding target object */
	EIF_SCP_PID       sync_pid;        /* Indicator of a synchronous call */
	EIF_BOOLEAN       is_lock_passing; /* Indicator of a lock passing call */
	EIF_TYPED_VALUE   argument [1];    /* Arguments excluding target object */
} call_data;

#ifdef WORKBENCH
rt_public void eif_log_call (int static_type_id, int feature_id, EIF_SCP_PID current_pid, call_data * data);
rt_public void eif_log_callp (int origin, int offset, EIF_SCP_PID current_pid, call_data * data);
#else
rt_public void eif_log_call (EIF_SCP_PID p, call_data * a);
#endif

rt_public void eif_try_call (call_data * a);
rt_public void eif_free_call (call_data * a);
rt_public EIF_BOOLEAN eif_is_uncontrolled (EIF_SCP_PID c, EIF_SCP_PID s);

/* Request chain stack */

rt_public void eif_request_chain_push (EIF_REFERENCE c, struct stack * stk);      /* Push client `c' on the request chain stack `stk' without notifying SCOOP mananger. */
rt_public void eif_request_chain_pop (struct stack * stk);                        /* Pop one element from the request chain stack `stk' without notifying SCOOP mananger. */
rt_public void eif_request_chain_restore (EIF_REFERENCE * t, struct stack * stk); /* Restore request chain stack `stk' to have the top `t' notifying SCOOP manager about all removed request chains. */

#ifdef __cplusplus
}

#endif

#endif	/* _eif_scoop_h_ */

