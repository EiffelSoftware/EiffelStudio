/*
	description:	"SCOOP support."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2010-2015, Eiffel Software."
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

#ifndef _eif_scoop_h_
#define _eif_scoop_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define RT_MAX_SCOOP_PROCESSOR_COUNT 1024 /* Maximum number of SCOOP processors, including root. */

#

/* Separate calls */

typedef struct call_data {
	EIF_REFERENCE target;			/* Target of a call */

#ifdef WORKBENCH
	BODY_INDEX body_index;	/* Used by ISE_SCOOP_MANAGER */
	int routine_id;					/* Routine to be called */
	EIF_TYPED_VALUE *result;		/* Address of a result for queries */
#else
	union {
		fnptr address;				/* Routine to be called */
		size_t offset;				/* Offset of an attribute */
	} feature;
	EIF_POINTER result;				/* Address of a result for queries, the result type depends on the called feature */
	void (* pattern) (struct call_data *); /* Stub that is used to perform a call */
#endif /* WORKBENCH */
	EIF_NATURAL_32 count;			/* Number of arguments excluding target object */
	EIF_SCP_PID sync_pid;			/* Indicator of a synchronous call */
	EIF_BOOLEAN is_lock_passing;	/* Indicator of a lock passing call */
	EIF_TYPED_VALUE argument [1];	/* Arguments excluding target object */
} call_data;

RT_LNK void eif_log_call (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid, call_data* data);
#ifdef WORKBENCH
RT_LNK void eif_apply_wcall (call_data *data);
#endif
RT_LNK void eif_call_const (call_data * a);

/* Not used. TODO: remove after removing ISE_SCOOP_MANAGER. */
#define eif_free_call(a)
#define eif_try_call(a)
#define eif_mark_live_pid(x)

/* Request chain stack */

RT_LNK void eif_request_chain_push (EIF_REFERENCE c, struct stack * stk);	/* Push client `c' on the request chain stack `stk' without notifying SCOOP mananger. */
RT_LNK void eif_request_chain_pop (struct stack * stk);	/* Pop one element from the request chain stack `stk' without notifying SCOOP mananger. */
RT_LNK void eif_request_chain_restore (EIF_REFERENCE * t, struct stack * stk); /* Restore request chain stack `stk' to have the top `t' notifying SCOOP manager about all removed request chains. */

/* Scoop Macros */

#define set_boolean_return_value(a_boolean_typed_value,a_boolean) ((EIF_TYPED_VALUE *) a_boolean_typed_value)->item.b = a_boolean;
#define set_integer_32_return_value(a_integer_32_typed_value,a_integer) ((EIF_TYPED_VALUE *) a_integer_32_typed_value)->item.i4 = a_integer;

#define call_data_sync_pid(a_call_data) ((call_data*) a_call_data)->sync_pid
#define call_data_is_lock_passing(a_call_data) ((call_data*) a_call_data)->is_lock_passing

/* Processor properties */
RT_LNK void eif_new_processor(EIF_REFERENCE obj);
RT_LNK int eif_is_uncontrolled (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid);
RT_LNK int eif_is_synced_on (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid);
RT_LNK void eif_wait_for_all_processors(void);

/* Garbage collection */
RT_LNK void eif_set_processor_id (EIF_SCP_PID pid); /* Associate processor of ID `pid' with the current thread. */
RT_LNK void eif_unset_processor_id (void);	/* Dissociate processor from the current thread. */

/* Request chain operations */
RT_LNK void eif_new_scoop_request_group (EIF_SCP_PID client_pid);
RT_LNK void eif_delete_scoop_request_group (EIF_SCP_PID client_pid);
RT_LNK void eif_scoop_wait_request_group (EIF_SCP_PID client_pid);
RT_LNK void eif_scoop_add_supplier_request_group (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid);
RT_LNK void eif_scoop_lock_request_group (EIF_SCP_PID client_pid);

#ifdef __cplusplus
}

#endif

#endif	/* _eif_scoop_h_ */

