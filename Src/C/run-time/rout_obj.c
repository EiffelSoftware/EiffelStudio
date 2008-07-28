/*
	description: "Agent creation/deletion."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2007, Eiffel Software."
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
doc:<file name="rout_obj.c" header="eif_rout_obj.h" version="$Id$" summary="Routine objects">
*/

#include "eif_portable.h"
#include "rt_macros.h"
#include "rt_struct.h"
#include "eif_interp.h"
#include "eif_project.h"
#include "eif_rout_obj.h"
#include "rt_lmalloc.h"
#include "rt_garcol.h"
#include "rt_gen_types.h"
#include "rt_interp.h"
#ifdef WORKBENCH
#include <string.h>
#endif

/*------------------------------------------------------------------*/
/* Create a ROUTINE object of type `dftype'. Use the arguements for */
/* the call to `set_rout_disp'.									    */
/*------------------------------------------------------------------*/
rt_public EIF_REFERENCE rout_obj_create2 ( EIF_TYPE_INDEX dftype, EIF_POINTER rout_disp, EIF_POINTER encaps_rout_disp, 
										   EIF_POINTER calc_rout_addr, EIF_INTEGER class_id, EIF_INTEGER feature_id, 
										   EIF_REFERENCE open_map,
										   EIF_BOOLEAN is_precompiled, EIF_BOOLEAN is_basic, EIF_BOOLEAN is_target_closed,
										   EIF_BOOLEAN is_inline_agent, EIF_REFERENCE closed_operands, EIF_INTEGER open_count)
{
	EIF_GET_CONTEXT
	EIF_REFERENCE result = NULL;
	RTLD;

		/* Protect address in case it moves */
 	RTLI(3);
	RTLR (0, result);
	RTLR (1, closed_operands);
	RTLR (2, open_map);

		/* Create ROUTINE object */
	result = emalloc(dftype);
	nstcall = 0;
		/* Call 'set_rout_disp' from ROUTINE */
	(FUNCTION_CAST (void, ( EIF_REFERENCE,
							EIF_POINTER, 
							EIF_POINTER, 
							EIF_POINTER, 
							EIF_INTEGER,
							EIF_INTEGER,
							EIF_REFERENCE,
							EIF_BOOLEAN,
							EIF_BOOLEAN, 
							EIF_BOOLEAN,
							EIF_BOOLEAN,
							EIF_REFERENCE,
							EIF_INTEGER)) egc_routdisp)( result, rout_disp, encaps_rout_disp, calc_rout_addr, 
														 class_id, feature_id, open_map, is_precompiled, is_basic, 
														 is_target_closed, is_inline_agent, closed_operands, open_count);

	RTLE;
	return result;
}

#ifdef WORKBENCH
/*------------------------------------------------------------------*/
/* Create a ROUTINE object of type `dftype'. Use the arguements for */
/* the call to `set_rout_disp'.									    */
/*------------------------------------------------------------------*/
rt_public EIF_REFERENCE rout_obj_create_wb ( EIF_TYPE_INDEX dftype, EIF_POINTER rout_disp, EIF_POINTER encaps_rout_disp, 
										     EIF_POINTER calc_rout_addr, EIF_INTEGER class_id, EIF_INTEGER feature_id, 
										     EIF_REFERENCE open_map,
										     EIF_BOOLEAN is_precompiled, EIF_BOOLEAN is_basic, EIF_BOOLEAN is_target_closed,
										     EIF_BOOLEAN is_inline_agent, EIF_REFERENCE closed_operands, EIF_INTEGER open_count)
{
	EIF_GET_CONTEXT
	EIF_REFERENCE result = NULL;
	EIF_TYPED_VALUE u_rout_disp;
	EIF_TYPED_VALUE u_encaps_rout_disp;
	EIF_TYPED_VALUE u_calc_rout_addr;
	EIF_TYPED_VALUE u_class_id;
	EIF_TYPED_VALUE u_feature_id;
	EIF_TYPED_VALUE u_open_map;
	EIF_TYPED_VALUE u_is_precompiled;
	EIF_TYPED_VALUE u_is_basic;
	EIF_TYPED_VALUE u_is_target_closed;
	EIF_TYPED_VALUE u_is_inline_agent;
	EIF_TYPED_VALUE u_closed_operands;
	EIF_TYPED_VALUE u_open_count;
	RTLD;

	u_rout_disp.type = SK_POINTER;
	u_rout_disp.it_p = rout_disp;
	u_encaps_rout_disp.type = SK_POINTER;
	u_encaps_rout_disp.it_p = encaps_rout_disp;
	u_calc_rout_addr.type = SK_POINTER;
	u_calc_rout_addr.it_p = calc_rout_addr;
	u_class_id.type = SK_INT32;
	u_class_id.it_i4 = class_id;
	u_feature_id.type = SK_INT32;
	u_feature_id.it_i4 = feature_id;
	u_open_map.type = SK_REF;
	u_open_map.it_r = open_map;
	u_is_precompiled.type = SK_BOOL;
	u_is_precompiled.it_b = is_precompiled;
	u_is_basic.type = SK_BOOL;
	u_is_basic.it_b = is_basic;
	u_is_target_closed.type = SK_BOOL;
	u_is_target_closed.it_b = is_target_closed;
	u_is_inline_agent.type = SK_BOOL;
	u_is_inline_agent.it_b = is_inline_agent;
	u_closed_operands.type = SK_REF;
	u_closed_operands.it_r = closed_operands;
	u_open_count.type = SK_INT32;
	u_open_count.it_i4 = open_count;
		/* Protect address in case it moves */
 	RTLI(5);
	RTLR (0, result);
	RTLR (1, closed_operands);
	RTLR (2, open_map);
	RTLR (3, u_open_map.it_r);
	RTLR (4, u_closed_operands.it_r);

		/* Create ROUTINE object */
	result = emalloc(dftype);
	nstcall = 0;
		/* Call 'set_rout_disp' from ROUTINE */
	(*egc_routdisp_wb)(
		result,
		u_rout_disp,
		u_encaps_rout_disp,
		u_calc_rout_addr,
		u_class_id,
		u_feature_id,
		u_open_map,
		u_is_precompiled,
		u_is_basic,
		u_is_target_closed,
		u_is_inline_agent,
		u_closed_operands,
		u_open_count
	);

	RTLE;
	return result;
}
#else
/*------------------------------------------------------------------*/
/* Create a ROUTINE object of type `dftype' in finalized mode.		*/
/* Use the arguements for the call to `set_rout_disp'.				*/
/*------------------------------------------------------------------*/
rt_public EIF_REFERENCE rout_obj_create_fl (EIF_TYPE_INDEX dftype, EIF_POINTER rout_disp, EIF_POINTER encaps_rout_disp, EIF_POINTER calc_rout_addr, 
											EIF_REFERENCE closed_operands, EIF_BOOLEAN is_target_closed, EIF_INTEGER open_count)
{
	EIF_GET_CONTEXT
	EIF_REFERENCE result = NULL;
	RTLD;

		/* Protect address in case it moves */
 	RTLI(2);
	RTLR (0, result);
	RTLR (1, closed_operands);

		/* Create ROUTINE object */
	result = emalloc(dftype);
	nstcall = 0;
		/* Call 'set_rout_disp' from ROUTINE */
	(FUNCTION_CAST (void, ( EIF_REFERENCE,
							EIF_POINTER, 
							EIF_POINTER, 
							EIF_POINTER, 
							EIF_REFERENCE,
							EIF_BOOLEAN,
							EIF_INTEGER)) egc_routdisp_fl)( result, rout_disp, encaps_rout_disp, calc_rout_addr, 
														    closed_operands, is_target_closed, open_count);

	RTLE;
	return result;
}
#endif

/*------------------------------------------------------------------*/
/* Allocate argument structure for `count' arguments.               */
/*------------------------------------------------------------------*/

rt_public EIF_POINTER rout_obj_new_args (EIF_INTEGER count)

{
	EIF_POINTER result = (EIF_POINTER) 0;

	if (count > 0) {
		result = (EIF_POINTER) eif_malloc (count * sizeof (EIF_VALUE));
		if (result == (EIF_POINTER) 0)
			enomem();
	}

	return result;
}
/*------------------------------------------------------------------*/
/* Free argument structure.                                         */
/*------------------------------------------------------------------*/

rt_public void rout_obj_free_args (EIF_POINTER args)
{
	if (args != (EIF_POINTER) 0)
		eif_free (args);
}
/*------------------------------------------------------------------*/

rt_public void rout_obj_call_function (EIF_REFERENCE res, EIF_POINTER rout, EIF_POINTER args)
{
	EIF_GET_CONTEXT
	EIF_VALUE result, *ap;
	char gcode, *resp;

		/* Protect address in case it moves */
	RT_GC_PROTECT(res);

	ap = (EIF_VALUE *) args;
	gcode = (FUNCTION_CAST (char,
				(EIF_REFERENCE,
				EIF_VALUE *,
				EIF_VALUE *)) rout) (ap[0].r, ap + 1, &result);

	resp = *(EIF_REFERENCE *) res;

	switch (gcode)
	{
		case EIF_BOOLEAN_CODE:
			*((EIF_BOOLEAN *) resp) = result.b;
			break;
		case EIF_CHARACTER_CODE:
			*((EIF_CHARACTER *) resp) = result.c1;
			break;
		case EIF_REAL_64_CODE:
			*((EIF_REAL_64 *) resp) = result.r8;
			break;
		case EIF_NATURAL_8_CODE:
			*((EIF_NATURAL_8 *) resp) = result.n1;
			break;
		case EIF_NATURAL_16_CODE:
			*((EIF_NATURAL_16 *) resp) = result.n2;
			break;
		case EIF_NATURAL_32_CODE:
			*((EIF_NATURAL *) resp) = result.n4;
			break;
		case EIF_NATURAL_64_CODE:
			*((EIF_NATURAL_64 *) resp) = result.n8;
			break;
		case EIF_INTEGER_8_CODE:
			*((EIF_INTEGER_8 *) resp) = result.i1;
			break;
		case EIF_INTEGER_16_CODE:
			*((EIF_INTEGER_16 *) resp) = result.i2;
			break;
		case EIF_INTEGER_32_CODE:
			*((EIF_INTEGER *) resp) = result.i4;
			break;
		case EIF_INTEGER_64_CODE:
			*((EIF_INTEGER_64 *) resp) = result.i8;
			break;
		case EIF_POINTER_CODE:
			*((EIF_POINTER *) resp) = result.p;
			break;
		case EIF_REAL_32_CODE:
			*((EIF_REAL_32 *) resp) = result.r4;
			break;
		case EIF_WIDE_CHAR_CODE:
			*((EIF_WIDE_CHAR *) resp) = result.c4;
			break;
		default:
			*((EIF_REFERENCE *) resp) = result.r;
			RTAR(resp, result.r);
			break;
	}

		/* Remove protection */
	RT_GC_WEAN(res);
}
/*------------------------------------------------------------------*/

#ifdef WORKBENCH

#include "eif_setup.h"
void fill_it (EIF_TYPED_VALUE* it, EIF_TYPED_VALUE* te);

rt_public void rout_obj_call_procedure_dynamic (
	int stype_id, int feature_id, int is_precompiled, int is_basic_type, int is_inline_agent,
	EIF_TYPED_VALUE* closed_args, int closed_count, 
	EIF_TYPED_VALUE* open_args, int open_count, 
	EIF_REFERENCE open_map)
{
	EIF_GET_CONTEXT
	int i = 2;
	int args_count = open_count + closed_count;
	int next_open = 0xFFFF;
	int open_idx = 1;
	int closed_idx = 1;
	EIF_TYPED_VALUE* first_arg = NULL;
	EIF_INTEGER* open_positions = NULL;

	if (closed_count > 0) {
		RT_GC_PROTECT(closed_args); /* iget() may call GC */
	}

	if (open_count > 0) {
		open_positions = (EIF_INTEGER*)(*(EIF_REFERENCE*)open_map); 
		RT_GC_PROTECT(open_args);
		RT_GC_PROTECT(open_map);	
		if (open_positions [0] == 1) {
			first_arg = &(open_args [1]);
			RT_GC_PROTECT (first_arg);
			open_idx = 2;
			if (open_count > 1) {
				next_open = open_positions [1];
			} 
		} else  {
			next_open = open_positions [0];
		}
	}
	if (first_arg == NULL) {
		first_arg = &(closed_args [1]);
		RT_GC_PROTECT (first_arg);
		closed_idx = 2;
	}
	while (i <= args_count) {
		if (i == next_open) {
			fill_it (iget(), &(open_args [open_idx]));
			if (open_idx < open_count) {
				next_open = open_positions [open_idx];
				open_idx++;
			} else {
				next_open = 0xFFFF;
			}
		} else {
			fill_it (iget(), &(closed_args [closed_idx]));
			closed_idx++;
		}
		i = i + 1;
	}
	fill_it (iget(), first_arg);
	
	if (closed_count > 0) {
		RT_GC_WEAN(closed_args);
	}
	if (open_count > 0) {
		RT_GC_WEAN(open_args);
		RT_GC_WEAN(open_map);
	}
	RT_GC_WEAN(first_arg);
		/* We are calling a feature through an agent, in this case, we consider all calls
		 * as qualified so that the invariant is checked. */
	nstcall = 1;
		/* We pass `0' for `dtype' in `dynamic_eval' because for an agent call we always have
		 * a target object to get this from. */
	dynamic_eval (feature_id, stype_id, 0, is_precompiled, is_basic_type, 0, is_inline_agent);
}

void fill_it (EIF_TYPED_VALUE* it, EIF_TYPED_VALUE* te) 
{
	*it = *te;
}

rt_public void rout_obj_call_function_dynamic (
	int stype_id, int feature_id, int is_precompiled, int is_basic_type, int is_inline_agent,
	EIF_TYPED_VALUE* closed_args, int closed_count, 
	EIF_TYPED_VALUE* open_args, int open_count, 
	EIF_REFERENCE open_map, void* res)
{
	EIF_TYPED_VALUE* it = NULL;

	rout_obj_call_procedure_dynamic (stype_id, feature_id, is_precompiled, is_basic_type, is_inline_agent,
									 closed_args, closed_count, open_args, open_count, open_map);
	
	it = opop();

	switch (it->type)
	{
		case SK_BOOL: *((EIF_CHARACTER *) res) = it->it_bool; break;
		case SK_CHAR: *((EIF_CHARACTER *) res) = it->it_char; break;
		case SK_REAL64: *((EIF_REAL_64 *)res) = it->it_real64; break;
		case SK_UINT8: *((EIF_NATURAL_8* )res) = it->it_uint8; break;
		case SK_UINT16: *((EIF_NATURAL_16 *)res) = it->it_uint16; break;
		case SK_UINT32: *((EIF_NATURAL_32 *)res) = it->it_uint32; break;
		case SK_UINT64: *((EIF_NATURAL_64 *)res)= it->it_uint64; break;
		case SK_INT8: *((EIF_INTEGER_8 *)res) = it->it_int8; break;
		case SK_INT16: *((EIF_INTEGER_16 *)res) = it->it_int16; break;
		case SK_INT32: *((EIF_INTEGER_32 *)res) = it->it_int32; break;
		case SK_INT64: *((EIF_INTEGER_64 *)res) = it->it_int64; break;
		case SK_POINTER: *((EIF_POINTER *)res) = it->it_ptr; break;
		case SK_REAL32: *((EIF_REAL_32 *)res) = it->it_real32; break;
		case SK_WCHAR: *((EIF_WIDE_CHAR* )res) = it->it_wchar; break;
		default:
			*((EIF_REFERENCE *)res) = it->it_ref;
	}
}
#endif

/*------------------------------------------------------------------*/

rt_public char eif_sk_type_to_type_code (uint32 sk_type)
{
	switch (sk_type) {
		case SK_BOOL:    return EIF_BOOLEAN_CODE; break;
		case SK_CHAR:    return EIF_CHARACTER_CODE; break;
		case SK_WCHAR:   return EIF_WIDE_CHAR_CODE; break;
		case SK_INT8:    return EIF_INTEGER_8_CODE; break;
		case SK_INT16:   return EIF_INTEGER_16_CODE; break;
		case SK_INT32:   return EIF_INTEGER_32_CODE; break;
		case SK_INT64:   return EIF_INTEGER_64_CODE; break;
		case SK_UINT8:   return EIF_NATURAL_8_CODE; break;
		case SK_UINT16:  return EIF_NATURAL_16_CODE; break;
		case SK_UINT32:  return EIF_NATURAL_32_CODE; break;
		case SK_UINT64:  return EIF_NATURAL_64_CODE; break;
		case SK_POINTER: return EIF_POINTER_CODE; break;
		case SK_REAL32:  return EIF_REAL_32_CODE; break;
		case SK_REAL64:  return EIF_REAL_64_CODE; break;
		case SK_REF:     return EIF_REFERENCE_CODE; break;
	}
	return EIF_REFERENCE_CODE;
}


/*
doc:</file>
*/
