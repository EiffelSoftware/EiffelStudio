/*
	description: "Agent creation/deletion."
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
rt_public EIF_REFERENCE rout_obj_create2 ( int16 dftype, EIF_POINTER rout_disp, EIF_POINTER encaps_rout_disp, 
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
rt_public EIF_REFERENCE rout_obj_create_wb ( int16 dftype, EIF_POINTER rout_disp, EIF_POINTER encaps_rout_disp, 
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
							EIF_INTEGER)) egc_routdisp_wb)( result, rout_disp, encaps_rout_disp, calc_rout_addr, 
														    class_id, feature_id, open_map, is_precompiled, is_basic, 
														    is_target_closed, is_inline_agent, closed_operands, open_count);

	RTLE;
	return result;
}
#else
/*------------------------------------------------------------------*/
/* Create a ROUTINE object of type `dftype' in finalized mode.		*/
/* Use the arguements for the call to `set_rout_disp'.				*/
/*------------------------------------------------------------------*/
rt_public EIF_REFERENCE rout_obj_create_fl (int16 dftype, EIF_POINTER rout_disp, EIF_POINTER encaps_rout_disp, EIF_POINTER calc_rout_addr, 
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
		result = (EIF_POINTER) eif_malloc (count * sizeof (EIF_ARG_UNION));
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
	EIF_ARG_UNION result, *ap;
	char gcode, *resp;

		/* Protect address in case it moves */
	RT_GC_PROTECT(res);

	ap = (EIF_ARG_UNION *) args;
	gcode = (FUNCTION_CAST (char,
				(EIF_REFERENCE,
				EIF_ARG_UNION *,
				EIF_ARG_UNION *)) rout) (ap[0].rarg, ap + 1, &result);

	resp = *(EIF_REFERENCE *) res;

	switch (gcode)
	{
		case EIF_BOOLEAN_CODE:
			*((EIF_BOOLEAN *) resp) = result.barg;
			break;
		case EIF_CHARACTER_CODE:
			*((EIF_CHARACTER *) resp) = result.carg;
			break;
		case EIF_REAL_64_CODE:
			*((EIF_REAL_64 *) resp) = result.darg;
			break;
		case EIF_NATURAL_8_CODE:
			*((EIF_NATURAL_8 *) resp) = result.u8arg;
			break;
		case EIF_NATURAL_16_CODE:
			*((EIF_NATURAL_16 *) resp) = result.u16arg;
			break;
		case EIF_NATURAL_32_CODE:
			*((EIF_NATURAL *) resp) = result.u32arg;
			break;
		case EIF_NATURAL_64_CODE:
			*((EIF_NATURAL_64 *) resp) = result.u64arg;
			break;
		case EIF_INTEGER_8_CODE:
			*((EIF_INTEGER_8 *) resp) = result.i8arg;
			break;
		case EIF_INTEGER_16_CODE:
			*((EIF_INTEGER_16 *) resp) = result.i16arg;
			break;
		case EIF_INTEGER_32_CODE:
			*((EIF_INTEGER *) resp) = result.i32arg;
			break;
		case EIF_INTEGER_64_CODE:
			*((EIF_INTEGER_64 *) resp) = result.i64arg;
			break;
		case EIF_POINTER_CODE:
			*((EIF_POINTER *) resp) = result.parg;
			break;
		case EIF_REAL_32_CODE:
			*((EIF_REAL_32 *) resp) = result.farg;
			break;
		case EIF_WIDE_CHAR_CODE:
			*((EIF_WIDE_CHAR *) resp) = result.wcarg;
			break;
		default:
			*((EIF_REFERENCE *) resp) = result.rarg;
			RTAR(resp, result.rarg);
			break;
	}

		/* Remove protection */
	RT_GC_WEAN(res);
}
/*------------------------------------------------------------------*/

#ifdef WORKBENCH

#include "eif_setup.h"
void fill_it (struct item* it, EIF_TYPED_ELEMENT* te);

rt_public void rout_obj_call_procedure_dynamic (
	int stype_id, int feature_id, int is_precompiled, int is_basic_type, int is_inline_agent,
	EIF_TYPED_ELEMENT* closed_args, int closed_count, 
	EIF_TYPED_ELEMENT* open_args, int open_count, 
	EIF_REFERENCE open_map)
{
	EIF_GET_CONTEXT
	size_t i = 2;
	size_t args_count = open_count + closed_count;
	int next_open = 0xFFFF;
	int open_idx = 1;
	int closed_idx = 1;
	EIF_TYPED_ELEMENT* first_arg = 0;
	EIF_TYPED_ELEMENT* arg = 0;
	EIF_INTEGER* open_positions = 0;

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
	if (first_arg == 0) {
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
	dynamic_eval (feature_id, stype_id, is_precompiled, is_basic_type, is_inline_agent);
}

void fill_it (struct item* it, EIF_TYPED_ELEMENT* te) 
{
		switch ((*te).type)
		{
			case EIF_BOOLEAN_CODE: it->type = SK_BOOL; it->itu.itu_char = (*te).element.barg; break;
			case EIF_CHARACTER_CODE: it->type = SK_CHAR; it->itu.itu_char = (*te).element.carg; break;
			case EIF_REAL_64_CODE: it->type = SK_REAL64; it->itu.itu_real64 = (*te).element.darg; break;
			case EIF_NATURAL_8_CODE: it->type = SK_UINT8; it->itu.itu_uint8 = (*te).element.u8arg; break;
			case EIF_NATURAL_16_CODE: it->type = SK_UINT16; it->itu.itu_uint16 = (*te).element.u16arg; break;
			case EIF_NATURAL_32_CODE: it->type = SK_UINT32; it->itu.itu_uint32 = (*te).element.u32arg; break;
			case EIF_NATURAL_64_CODE: it->type = SK_UINT64; it->itu.itu_uint64 = (*te).element.u64arg; break;
			case EIF_INTEGER_8_CODE: it->type = SK_INT8; it->itu.itu_int8 = (*te).element.i8arg; break;
			case EIF_INTEGER_16_CODE: it->type = SK_INT16; it->itu.itu_int16 = (*te).element.i16arg; break;
			case EIF_INTEGER_32_CODE: it->type = SK_INT32; it->itu.itu_int32 = (*te).element.i32arg; break;
			case EIF_INTEGER_64_CODE: it->type = SK_INT64; it->itu.itu_int64 = (*te).element.i64arg; break;
			case EIF_POINTER_CODE: it->type = SK_POINTER; it->itu.itu_ptr = (*te).element.parg; break;
			case EIF_REAL_32_CODE: it->type = SK_REAL32; it->itu.itu_real32 = (*te).element.farg; break;
			case EIF_WIDE_CHAR_CODE: it->type = SK_WCHAR; it->itu.itu_wchar = (*te).element.wcarg; break;
			default:
				it->type = SK_REF; it->itu.itu_ref = (*te).element.rarg;
		}
}

rt_public void rout_obj_call_function_dynamic (
	int stype_id, int feature_id, int is_precompiled, int is_basic_type, int is_inline_agent,
	EIF_TYPED_ELEMENT* closed_args, int closed_count, 
	EIF_TYPED_ELEMENT* open_args, int open_count, 
	EIF_REFERENCE open_map, void* res)
{
	EIF_GET_CONTEXT
	struct item* it = 0;

	rout_obj_call_procedure_dynamic (stype_id, feature_id, is_precompiled, is_basic_type, is_inline_agent,
									 closed_args, closed_count, open_args, open_count, open_map);
	
	it = opop();

	switch (it->type)
	{
		case SK_BOOL:
		case SK_CHAR:
			*((EIF_CHARACTER *) res) = it->itu.itu_char; break;
		case SK_REAL64: *((EIF_REAL_64 *)res) = it->itu.itu_real64; break;
		case SK_UINT8: *((EIF_NATURAL_8* )res) = it->itu.itu_uint8; break;
		case SK_UINT16: *((EIF_NATURAL_16 *)res) = it->itu.itu_uint16; break;
		case SK_UINT32: *((EIF_NATURAL_32 *)res) = it->itu.itu_uint32; break;
		case SK_UINT64: *((EIF_NATURAL_64 *)res)= it->itu.itu_uint64; break;
		case SK_INT8: *((EIF_INTEGER_8 *)res) = it->itu.itu_int8; break;
		case SK_INT16: *((EIF_INTEGER_16 *)res) = it->itu.itu_int16; break;
		case SK_INT32: *((EIF_INTEGER_32 *)res) = it->itu.itu_int32; break;
		case SK_INT64: *((EIF_INTEGER_64 *)res) = it->itu.itu_int64; break;
		case SK_POINTER: *((EIF_POINTER *)res) = it->itu.itu_ptr; break;
		case SK_REAL32: *((EIF_REAL_32 *)res) = it->itu.itu_real32; break;
		case SK_WCHAR: *((EIF_WIDE_CHAR* )res) = it->itu.itu_wchar; break;
		default:
			*((EIF_REFERENCE *)res) = it->itu.itu_ref;
	}
}
#endif

/*------------------------------------------------------------------*/

/*
doc:</file>
*/
