/*
	Routine objects
*/

#include "eif_portable.h"
#include "rt_macros.h"
#include "eif_struct.h"
#include "eif_interp.h"
#include "eif_project.h"
#include "eif_rout_obj.h"
#include "eif_lmalloc.h"
#include "rt_gen_types.h"

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
		case EIF_DOUBLE_CODE:
			*((EIF_DOUBLE *) resp) = result.darg;
			break;
		case EIF_INTEGER_8_CODE:
			*((EIF_INTEGER_8 *) resp) = result.i8arg;
			break;
		case EIF_INTEGER_16_CODE:
			*((EIF_INTEGER_16 *) resp) = result.i16arg;
			break;
		case EIF_INTEGER_CODE:
			*((EIF_INTEGER *) resp) = result.i32arg;
			break;
		case EIF_INTEGER_64_CODE:
			*((EIF_INTEGER_64 *) resp) = result.i64arg;
			break;
		case EIF_POINTER_CODE:
			*((EIF_POINTER *) resp) = result.parg;
			break;
		case EIF_REAL_CODE:
			*((EIF_REAL *) resp) = result.farg;
			break;
		case EIF_WIDE_CHAR_CODE:
			*((EIF_WIDE_CHAR *) resp) = result.wcarg;
			break;
		default:
			*((EIF_REFERENCE *) resp) = result.rarg;
			RTAS_OPT(result.rarg, 0, resp);
			break;
	}

		/* Remove protection */
	RT_GC_WEAN(res);
}
/*------------------------------------------------------------------*/

#ifdef WORKBENCH

rt_public void rout_obj_call_procedure_dynamic (EIF_INTEGER_32 body_id, EIF_ARG_UNION* args, EIF_REFERENCE types)
{
	EIF_GET_CONTEXT
	void* body_addr;
	void* patt_addr;
	struct item* it;
	int count;
	int i = 0;

	count = strlen ((char*)types);

	RT_GC_PROTECT(types); /* iget() may call GC */

	do {
		it = iget();
		if (i == count-1) {
			i = 0;
		} else {
			i++;
		}
		switch (((char*)types)[i])
		{
			case EIF_BOOLEAN_CODE:
				it->type = SK_BOOL;
				it->itu.itu_char = (args[i]).barg;
				break;
			case EIF_CHARACTER_CODE:
				it->type = SK_CHAR;
				it->itu.itu_char = (args[i]).carg;
				break;
			case EIF_DOUBLE_CODE:
				it->type = SK_DOUBLE;
				it->itu.itu_double = (args[i]).darg;
				break;
			case EIF_INTEGER_8_CODE:
				it->type = SK_INT8;
				it->itu.itu_int8 = (args[i]).i8arg;
				break;
			case EIF_INTEGER_16_CODE:
				it->type = SK_INT16;
				it->itu.itu_int16 = (args[i]).i16arg;
				break;
			case EIF_INTEGER_CODE:
				it->type = SK_INT32;
				it->itu.itu_int32 = (args[i]).i32arg;
				break;
			case EIF_INTEGER_64_CODE:
				it->type = SK_INT64;
				it->itu.itu_int64 = (args[i]).i64arg;
				break;
			case EIF_POINTER_CODE:
				it->type = SK_POINTER;
				it->itu.itu_ptr = (args[i]).parg;
				break;
			case EIF_REAL_CODE:
				it->type = SK_FLOAT;
				it->itu.itu_float = (args[i]).farg;
				break;
			case EIF_WIDE_CHAR_CODE:
				it->type = SK_WCHAR;
				it->itu.itu_wchar = (args[i]).wcarg;
				break;
			default:
				it->type = SK_REF;
				it->itu.itu_ref = (args[i]).rarg;
				break;
		}
	} while (i);

	RT_GC_WEAN(types);

	body_addr = (void *) egc_frozen[body_id];
	if (body_addr == NULL) {    /* feature is melted */
		IC = melt[body_id];
		xinterp (IC);
	} else {                    /* feature is frozen */
  	    patt_addr = (void *) pattern[FPatId (body_id)].toc;
  	    (FUNCTION_CAST (void, (fnptr, int))patt_addr) (
		   	(fnptr) body_addr,
			0 /* not external */
		);
	}
}

rt_public void rout_obj_call_function_dynamic (EIF_INTEGER_32 body_id, EIF_ARG_UNION* args, EIF_REFERENCE types, EIF_REFERENCE res)
{
	EIF_GET_CONTEXT
	void* body_addr;
	void* patt_addr;
	void* resp;
	struct item* it;
	int count;
	int i = 0;

	count = strlen ((char*)types);
	resp = *(EIF_REFERENCE *) res;

	RT_GC_PROTECT(types); /* iget() may call GC */
	RT_GC_PROTECT(res);

	do {
		it = iget();
		if (i == count - 1) {
			i = 0;
		} else {
			i++;
		}
		switch (((char*)types)[i])
		{
			case EIF_BOOLEAN_CODE:
				it->type = SK_BOOL;
				it->itu.itu_char = (args[i]).barg;
				break;
			case EIF_CHARACTER_CODE:
				it->type = SK_CHAR;
				it->itu.itu_char = (args[i]).carg;
				break;
			case EIF_DOUBLE_CODE:
				it->type = SK_DOUBLE;
				it->itu.itu_double = (args[i]).darg;
				break;
			case EIF_INTEGER_8_CODE:
				it->type = SK_INT8;
				it->itu.itu_int8 = (args[i]).i8arg;
				break;
			case EIF_INTEGER_16_CODE:
				it->type = SK_INT16;
				it->itu.itu_int16 = (args[i]).i16arg;
				break;
			case EIF_INTEGER_CODE:
				it->type = SK_INT32;
				it->itu.itu_int32 = (args[i]).i32arg;
				break;
			case EIF_INTEGER_64_CODE:
				it->type = SK_INT64;
				it->itu.itu_int64 = (args[i]).i64arg;
				break;
			case EIF_POINTER_CODE:
				it->type = SK_POINTER;
				it->itu.itu_ptr = (args[i]).parg;
				break;
			case EIF_REAL_CODE:
				it->type = SK_FLOAT;
				it->itu.itu_float = (args[i]).farg;
				break;
			case EIF_WIDE_CHAR_CODE:
				it->type = SK_WCHAR;
				it->itu.itu_wchar = (args[i]).wcarg;
				break;
			default:
				it->type = SK_REF;
				it->itu.itu_ref = (args[i]).rarg;
				break;
		}
	} while (i);
	RT_GC_WEAN(types);

	body_addr = (void *) egc_frozen[body_id];
	if (body_addr == NULL) {    /* feature is melted */
		IC = melt[body_id];
		xinterp (IC);
	} else {                    /* feature is frozen */
  	    patt_addr =(void *) pattern[FPatId (body_id)].toc;
  	    (FUNCTION_CAST (void, (fnptr, int))patt_addr) (
		   	(fnptr) body_addr,
			0 /* not external */
		);
	}
	it = opop();

	switch (it->type)
	{
		case SK_BOOL:
		case SK_CHAR:
			*((EIF_CHARACTER *) resp) = it->itu.itu_char;
			break;
		case SK_DOUBLE:
			*((EIF_DOUBLE *) resp) = it->itu.itu_double;
			break;
		case SK_INT8:
			*((EIF_INTEGER_8 *) resp) = it->itu.itu_int8;
			break;
		case SK_INT16:
			*((EIF_INTEGER_16 *) resp) = it->itu.itu_int16;
			break;
		case SK_INT32:
			*((EIF_INTEGER *) resp) = it->itu.itu_int32;
			break;
		case SK_INT64:
			*((EIF_INTEGER_64 *) resp) = it->itu.itu_int64;
			break;
		case SK_POINTER:
			*((EIF_POINTER *) resp) = it->itu.itu_ptr;
			break;
		case SK_FLOAT:
			*((EIF_REAL *) resp) = it->itu.itu_float;
			break;
		case SK_WCHAR:
			*((EIF_WIDE_CHAR *) resp) = it->itu.itu_wchar;
			break;
		default:
			*((EIF_REFERENCE *) resp) = it->itu.itu_ref;
			RTAS_OPT(it->itu.itu_ref, 0, resp);
			break;
	}
	RT_GC_WEAN(res);
}
#endif

/*------------------------------------------------------------------*/

