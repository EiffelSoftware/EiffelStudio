/*
	Routine objects
*/

#include "eif_macros.h"
#include "eif_struct.h"
#include "eif_rout_obj.h"
#include "eif_lmalloc.h"

/*------------------------------------------------------------------*/
/* Create a ROUTINE object of type `dftype' and put the routine     */
/* dispatch address `rout_disp' into it. Use `args' as arguments,   */
/* `omap' as open map and `cmap' as closed map.                     */
/*------------------------------------------------------------------*/

rt_public EIF_REFERENCE rout_obj_create (int16 dftype, EIF_POINTER rout_disp, EIF_REFERENCE args, EIF_REFERENCE omap, EIF_REFERENCE cmap)
{
	EIF_GET_CONTEXT
	EIF_REFERENCE result;

		/* Protect address in case it moves */
	epush(&loc_stack, (EIF_REFERENCE) (&args));
	epush(&loc_stack, (EIF_REFERENCE) (&omap));
	epush(&loc_stack, (EIF_REFERENCE) (&cmap));

		/* Create ROUTINE object */
	result = emalloc(dftype);
		/* Protect address in case it moves */
	epush(&loc_stack, (EIF_REFERENCE) (&result));
	nstcall = 0;
		/* Call 'set_rout_disp' from ROUTINE */
	(FUNCTION_CAST (void, (EIF_REFERENCE,
						   EIF_POINTER,
						   EIF_REFERENCE,
						   EIF_REFERENCE,
						   EIF_REFERENCE))egc_routdisp)(result, rout_disp, args, omap, cmap);

		/* Remove protection */
	epop(&loc_stack, 4);

	return result;
}
/*------------------------------------------------------------------*/
/* Allocate argument structure for `count' arguments.               */
/*------------------------------------------------------------------*/

rt_public EIF_POINTER rout_obj_new_args (EIF_INTEGER count)

{
	EIF_GET_CONTEXT
	EIF_POINTER result = (EIF_POINTER) 0;

	if (count > 0) {
		result = (EIF_POINTER) eif_malloc (count * sizeof (EIF_ARG_UNION));
		if (result == (EIF_POINTER) 0)
			enomem();
	}

	return result;

	EIF_END_GET_CONTEXT
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

rt_public void rout_obj_call_function (EIF_REFERENCE cur, EIF_REFERENCE res, EIF_POINTER rout, EIF_POINTER args)
{
	EIF_GET_CONTEXT
	EIF_ARG_UNION result, *ap;
	char gcode, *resp;

		/* Protect address in case it moves */
	epush(&loc_stack, (EIF_REFERENCE) (&res));

	ap = (EIF_ARG_UNION *) args;
	gcode = (FUNCTION_CAST (char,
				(EIF_REFERENCE,
				EIF_ARG_UNION *,
				EIF_ARG_UNION *)) rout) (ap[0].rarg, ap + 1, &result);

	resp = *(EIF_REFERENCE *) res;

	switch (gcode)
	{
		case 'b':
			*((EIF_BOOLEAN *) resp) = result.barg;
			break;
		case 'c':
			*((EIF_CHARACTER *) resp) = result.carg;
			break;
		case 'd':
			*((EIF_DOUBLE *) resp) = result.darg;
			break;
		case 'i':
			*((EIF_INTEGER *) resp) = result.iarg;
			break;
		case 'p':
			*((EIF_POINTER *) resp) = result.parg;
			break;
		case 'f':
			*((EIF_REAL *) resp) = result.farg;
			break;
		default:
			*((EIF_REFERENCE *) resp) = result.rarg;
			break;
	}

		/* Remove protection */
	epop(&loc_stack, 1);
}
/*------------------------------------------------------------------*/

