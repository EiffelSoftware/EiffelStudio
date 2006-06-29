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
/* Create a ROUTINE object of type `dftype' and put the routine     */
/* dispatch address `rout_disp' into it. Use `args' as arguments,   */
/* `omap' as open map and `cmap' as closed map.                     */
/*------------------------------------------------------------------*/

rt_public EIF_REFERENCE rout_obj_create (int16 dftype, EIF_POINTER rout_disp, EIF_POINTER true_rout_disp, EIF_REFERENCE args, EIF_REFERENCE omap, EIF_REFERENCE cmap)
{
	EIF_GET_CONTEXT
	EIF_REFERENCE result = NULL;
	RTLD;

		/* Protect address in case it moves */
	RTLI(4);
	RTLR (0, result);
	RTLR (1, args);
	RTLR (2, omap);
	RTLR (3, cmap);

		/* Create ROUTINE object */
	result = emalloc(dftype);
	nstcall = 0;
		/* Call 'set_rout_disp' from ROUTINE */
	(FUNCTION_CAST (void, (EIF_REFERENCE,
						   EIF_POINTER,
						   EIF_POINTER,
						   EIF_REFERENCE,
						   EIF_REFERENCE,
						   EIF_REFERENCE))egc_routdisp)(result, rout_disp, true_rout_disp, args, omap, cmap);

	RTLE;
	return result;
}

rt_public EIF_REFERENCE rout_obj_create2 (int16 dftype, EIF_POINTER rout_disp, EIF_POINTER true_rout_disp, EIF_REFERENCE args, EIF_REFERENCE omap)
{
	EIF_GET_CONTEXT
	EIF_REFERENCE result = NULL;
	RTLD;

		/* Protect address in case it moves */
	RTLI(3);
	RTLR (0, result);
	RTLR (1, args);
	RTLR (2, omap);

		/* Create ROUTINE object */
	result = emalloc(dftype);
	nstcall = 0;
		/* Call 'set_rout_disp' from ROUTINE */
	(FUNCTION_CAST (void, (EIF_REFERENCE,
						   EIF_POINTER,
						   EIF_POINTER,
						   EIF_REFERENCE,
						   EIF_REFERENCE))egc_routdisp)(result, rout_disp, true_rout_disp, args, omap);

	RTLE;
	return result;
}

rt_public EIF_REFERENCE rout_obj_create_lazy (int16 dftype, EIF_INTEGER class_id, EIF_INTEGER feature_id, EIF_BOOLEAN is_precompiled, EIF_BOOLEAN is_basic, EIF_REFERENCE args, EIF_REFERENCE omap)
{
	EIF_GET_CONTEXT
	EIF_REFERENCE result = NULL;
	RTLD;

		/* Protect address in case it moves */
	RTLI(3);
	RTLR (0, result);
	RTLR (1, args);
	RTLR (2, omap);

		/* Create ROUTINE object */
	result = emalloc(dftype);
	nstcall = 0;
		/* Call 'set_lazy_rout_disp' from ROUTINE */
	(FUNCTION_CAST (void, (EIF_REFERENCE,
						   EIF_INTEGER,
						   EIF_INTEGER,
						   EIF_BOOLEAN,
						   EIF_BOOLEAN,
						   EIF_REFERENCE,
						   EIF_REFERENCE))egc_lazy_routdisp)(result, class_id, feature_id, is_precompiled, is_basic, args, omap);

	RTLE;
	return result;
}

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
rt_public void rout_obj_call_procedure_dynamic (
	int stype_id, int feature_id, int is_precompiled, int is_basic_type, EIF_TYPED_ELEMENT* args, int arg_count)
{
	EIF_GET_CONTEXT
	struct item* it = 0;
	size_t i = 1;

	RT_GC_PROTECT(args); /* iget() may call GC */

	do {
		it = iget();
		if (i == arg_count) {
			i = 1;
		} else {
			i++;
		}
		switch (args[i].type)
		{
			case EIF_BOOLEAN_CODE: it->type = SK_BOOL; it->itu.itu_char = (args[i]).element.barg; break;
			case EIF_CHARACTER_CODE: it->type = SK_CHAR; it->itu.itu_char = (args[i]).element.carg; break;
			case EIF_REAL_64_CODE: it->type = SK_REAL64; it->itu.itu_real64 = (args[i]).element.darg; break;
			case EIF_NATURAL_8_CODE: it->type = SK_UINT8; it->itu.itu_uint8 = (args[i]).element.u8arg; break;
			case EIF_NATURAL_16_CODE: it->type = SK_UINT16; it->itu.itu_uint16 = (args[i]).element.u16arg; break;
			case EIF_NATURAL_32_CODE: it->type = SK_UINT32; it->itu.itu_uint32 = (args[i]).element.u32arg; break;
			case EIF_NATURAL_64_CODE: it->type = SK_UINT64; it->itu.itu_uint64 = (args[i]).element.u64arg; break;
			case EIF_INTEGER_8_CODE: it->type = SK_INT8; it->itu.itu_int8 = (args[i]).element.i8arg; break;
			case EIF_INTEGER_16_CODE: it->type = SK_INT16; it->itu.itu_int16 = (args[i]).element.i16arg; break;
			case EIF_INTEGER_32_CODE: it->type = SK_INT32; it->itu.itu_int32 = (args[i]).element.i32arg; break;
			case EIF_INTEGER_64_CODE: it->type = SK_INT64; it->itu.itu_int64 = (args[i]).element.i64arg; break;
			case EIF_POINTER_CODE: it->type = SK_POINTER; it->itu.itu_ptr = (args[i]).element.parg; break;
			case EIF_REAL_32_CODE: it->type = SK_REAL32; it->itu.itu_real32 = (args[i]).element.farg; break;
			case EIF_WIDE_CHAR_CODE: it->type = SK_WCHAR; it->itu.itu_wchar = (args[i]).element.wcarg; break;
			default:
				it->type = SK_REF; it->itu.itu_ref = (args[i]).element.rarg;
		}
	} while (i > 1);
	RT_GC_WEAN(args);

	dynamic_eval (feature_id, stype_id, is_precompiled, is_basic_type);
}


rt_public void rout_obj_call_function_dynamic (
	int stype_id, int feature_id, int is_precompiled, int is_basic_type, EIF_TYPED_ELEMENT* args, int arg_count, void* res)
{
	EIF_GET_CONTEXT
	struct item* it = 0;
	size_t i = 1;

	RT_GC_PROTECT(args); /* iget() may call GC */
	RT_GC_PROTECT(res);

	do {
		it = iget();
		if (i == arg_count) {
			i = 1;
		} else {
			i++;
		}
		switch (args[i].type)
		{
			case EIF_BOOLEAN_CODE: it->type = SK_BOOL; it->itu.itu_char = (args[i]).element.barg; break;
			case EIF_CHARACTER_CODE: it->type = SK_CHAR; it->itu.itu_char = (args[i]).element.carg; break;
			case EIF_REAL_64_CODE: it->type = SK_REAL64; it->itu.itu_real64 = (args[i]).element.darg; break;
			case EIF_NATURAL_8_CODE: it->type = SK_UINT8; it->itu.itu_uint8 = (args[i]).element.u8arg; break;
			case EIF_NATURAL_16_CODE: it->type = SK_UINT16; it->itu.itu_uint16 = (args[i]).element.u16arg; break;
			case EIF_NATURAL_32_CODE: it->type = SK_UINT32; it->itu.itu_uint32 = (args[i]).element.u32arg; break;
			case EIF_NATURAL_64_CODE: it->type = SK_UINT64; it->itu.itu_uint64 = (args[i]).element.u64arg; break;
			case EIF_INTEGER_8_CODE: it->type = SK_INT8; it->itu.itu_int8 = (args[i]).element.i8arg; break;
			case EIF_INTEGER_16_CODE: it->type = SK_INT16; it->itu.itu_int16 = (args[i]).element.i16arg; break;
			case EIF_INTEGER_32_CODE: it->type = SK_INT32; it->itu.itu_int32 = (args[i]).element.i32arg; break;
			case EIF_INTEGER_64_CODE: it->type = SK_INT64; it->itu.itu_int64 = (args[i]).element.i64arg; break;
			case EIF_POINTER_CODE: it->type = SK_POINTER; it->itu.itu_ptr = (args[i]).element.parg; break;
			case EIF_REAL_32_CODE: it->type = SK_REAL32; it->itu.itu_real32 = (args[i]).element.farg; break;
			case EIF_WIDE_CHAR_CODE: it->type = SK_WCHAR; it->itu.itu_wchar = (args[i]).element.wcarg; break;
			default:
				it->type = SK_REF; it->itu.itu_ref = (args[i]).element.rarg;
		}
	} while (i > 1);
	RT_GC_WEAN(args);

	dynamic_eval (feature_id, stype_id, is_precompiled, is_basic_type);
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
	RT_GC_WEAN(res);
}
#endif

/*------------------------------------------------------------------*/

/*
doc:</file>
*/
