/*
	description:	"Main functions of the SCOOP runtime."
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

#include "eif_portable.h"
#include "eif_atomops.h" /* for EIF_HAS_ATOMIC */
#include "eif_types.h" /* for EIF_TYPED_VALUE */
#include "eif_struct.h" /* for fnptr */

/* TODO: This definition is only used in eif_build_in.h. Should it be moved there? */
#if defined EIF_HAS_ATOMIC
#	define EIF_IS_SCOOP_CAPABLE 1
#else
#	define EIF_IS_SCOOP_CAPABLE 0
#endif

/* A reserved, invalid SCOOP processor identifier. */
#define EIF_NULL_PROCESSOR ((EIF_SCP_PID) -1)

#ifdef __cplusplus
extern "C" {
#endif

/* Separate calls */

typedef struct call_data {
	EIF_REFERENCE target;			/* Target of a call */

#ifdef WORKBENCH
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
	EIF_BOOLEAN is_synchronous;		/* Indicator of a synchronous call */
	EIF_TYPED_VALUE argument [1];	/* Arguments excluding target object */
} call_data;

RT_LNK void eif_log_call (EIF_SCP_PID client_processor_id, EIF_SCP_PID client_region_id, call_data* data);
RT_LNK void eif_call_const (call_data * a);

/* Scoop Macros
 * TODO: Are these macros still in use somewhere? */
#define set_boolean_return_value(a_boolean_typed_value,a_boolean) ((EIF_TYPED_VALUE *) a_boolean_typed_value)->item.b = a_boolean;
#define set_integer_32_return_value(a_integer_32_typed_value,a_integer) ((EIF_TYPED_VALUE *) a_integer_32_typed_value)->item.i4 = a_integer;

/* Processor properties */
RT_LNK void eif_new_processor(EIF_REFERENCE obj, EIF_BOOLEAN is_passive);
RT_LNK int eif_is_uncontrolled (EIF_SCP_PID client_processor_id, EIF_SCP_PID client_region_id, EIF_SCP_PID supplier_region_id);
RT_LNK int eif_is_synced_on (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid);
RT_LNK void eif_wait_for_all_processors(void);

/* Request chain operations */
RT_LNK void eif_new_scoop_request_group (EIF_SCP_PID client_pid);
RT_LNK void eif_delete_scoop_request_group (EIF_SCP_PID client_pid, size_t count);
RT_LNK size_t eif_scoop_request_group_stack_count (EIF_SCP_PID client_pid);
RT_LNK void eif_scoop_wait_request_group (EIF_SCP_PID client_pid);
RT_LNK void eif_scoop_add_supplier_request_group (EIF_SCP_PID client_pid, EIF_SCP_PID supplier_pid);
RT_LNK void eif_scoop_lock_request_group (EIF_SCP_PID client_pid);

/* Lock stack management */
RT_LNK size_t eif_scoop_lock_stack_count (EIF_SCP_PID processor_id);
RT_LNK void eif_scoop_lock_stack_impersonated_push (EIF_SCP_PID client_processor_id, EIF_SCP_PID supplier_region_id);
RT_LNK void eif_scoop_lock_stack_impersonated_pop (EIF_SCP_PID client_processor_id, size_t count);

/* Debugger extensions. */
RT_LNK EIF_SCP_PID eif_scoop_client_of (EIF_SCP_PID supplier);

/* Externals to EiffelBase */
#if defined EIF_THREADS
RT_LNK void eif_scoop_set_is_impersonation_allowed (EIF_SCP_PID pid, EIF_BOOLEAN status);
#else
#define eif_scoop_set_is_impersonation_allowed(pid,status)
#endif

#ifdef __cplusplus
}
#endif

#endif	/* _eif_scoop_h_ */

