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

/*
doc:	<struct name="eif_scoop_call_data", export="public">
doc:		<summary> A container used to describe a SCOOP separate call (i.e. a closure). Holds information about the target, the arguments, and the result pointer. </summary>
doc:		<field name="target", type="EIF_REFERENCE"> The target of the call. Must not be NULL. </field>
doc:		<field name="routine_id", type="int"> Workbench only: The ID of the routine to be called. Must be a valid ID. </field>
doc:		<field name="result", type="EIF_TYPED_VALUE*"> Workbench only: A pointer to store the result of a query. May be NULL.</field>
doc:		<field name="address", type="fnptr"> Finalized only: The address of the function to be executed. May be NULL. </field>
doc:		<field name="result", type="EIF_POINTER"> Finalized only: A pointer to store the result of a query. The result type depends on the called feature and is hard-coded in the pattern. May be NULL.</field>
doc:		<field name="pattern", type="void(*)(struct eif_scoop_call_data*)"> Finalized only: The stub to invoke the function at 'address' or to get an attribute. Must not be NULL. </field>
doc:		<field name="count", type="EIF_NATURAL_16"> The number of arguments, excluding the target object. </field>
doc:		<field name="offset", type="EIF_NATURAL_16"> The offset to an attribute. May be invalid for regular feature calls. Not used for workbench. </field>
doc:		<field name="is_synchronous", type="EIF_BOOLEAN"> Indicates a synchronous call. </field>
doc:		<field name="argument", type="EIF_TYPED_VALUE[]"> The arguments to the call, excluding target object. NOTE: This array has variable length. </field>
doc:	</struct>
 */
typedef struct eif_scoop_call_data {
	EIF_REFERENCE target;

#ifdef WORKBENCH
	int routine_id;
	EIF_TYPED_VALUE *result;
#else
	fnptr address;
	EIF_POINTER result;
	void (* pattern) (struct eif_scoop_call_data *);
#endif
	EIF_NATURAL_16 count;
	EIF_INTEGER_16 offset;
	EIF_BOOLEAN is_synchronous;
	EIF_TYPED_VALUE argument [1];
} call_data;


RT_LNK EIF_BOOLEAN eif_scoop_can_impersonate (EIF_SCP_PID client_processor_id, EIF_SCP_PID supplier_region_id, EIF_BOOLEAN is_synchronous);
RT_LNK void eif_scoop_log_call (EIF_SCP_PID client_processor_id, EIF_SCP_PID client_region_id, struct eif_scoop_call_data* data);
RT_LNK void eif_call_const (struct eif_scoop_call_data * a);

#ifdef EIF_THREADS
struct tag_eif_globals; /* Forward declaration. That way we don't need to include basically all header files in eif_scoop.h" */
RT_LNK void eif_scoop_impersonate (struct tag_eif_globals* eif_globals, EIF_SCP_PID region_id);
#endif

/* Processor properties */
RT_LNK EIF_SCP_PID eif_scoop_new_processor(EIF_BOOLEAN is_passive);
RT_LNK EIF_BOOLEAN eif_scoop_is_uncontrolled (EIF_SCP_PID client_processor_id, EIF_SCP_PID client_region_id, EIF_SCP_PID supplier_region_id);
RT_LNK void eif_scoop_wait_for_all_processors(void);

/* Request chain operations */
RT_LNK void eif_scoop_new_request_group (EIF_SCP_PID client_pid);
RT_LNK void eif_scoop_delete_request_group (EIF_SCP_PID client_pid, size_t count);
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

