/*
	Routine objects
*/

#include "eif_struct.h"
#include "eif_macros.h"
#include "eif_rout_obj.h"

/*------------------------------------------------------------------*/
/* Create a ROUTINE object of type `dftype' and put the routine     */
/* dispatch address `rout_disp' into it.                            */
/*------------------------------------------------------------------*/

rt_public char *rout_obj_create (int16 dftype, char *rout_disp)

{
	EIF_GET_CONTEXT
	char *result;

	/* Create ROUTINE object */
	result = emalloc(dftype);
	/* Protect address in case it moves */
	epush(&loc_stack, (char *) &result); 
	nstcall = 0;
	/* Call 'set_rout_disp' from ROUTINE */
	(egc_routdisp)(result, rout_disp);
	/* Remove protection */
	epop(&loc_stack, 1);

	return result;

	EIF_END_GET_CONTEXT
}
/*------------------------------------------------------------------*/
/* Allocate argument structure for `count' arguments.               */
/*------------------------------------------------------------------*/

rt_public char  *rout_obj_new_args (int count)

{
	EIF_GET_CONTEXT
	char *result;

	result = (char *) 0;

	if (count > 0)
	{
		result = cmalloc (count * sizeof (EIF_ARG_UNION));

		if (result == (char *) 0)
			enomem();
	}

	return result;

	EIF_END_GET_CONTEXT
}
/*------------------------------------------------------------------*/
/* Free argument structure.                                         */
/*------------------------------------------------------------------*/

rt_public void  rout_obj_free_args (char *args)

{
	EIF_GET_CONTEXT

	if (args != (char *) 0)
	{
		xfree (args);
	}

	EIF_END_GET_CONTEXT
}
/*------------------------------------------------------------------*/
/* Routines to fill argument structure.                             */
/*------------------------------------------------------------------*/

rt_public void rout_obj_putb (char *args, int idx, EIF_BOOLEAN b)

{
	((EIF_ARG_UNION *)args)[idx].barg = b;
}
/*------------------------------------------------------------------*/

rt_public void rout_obj_putc (char *args, int idx, EIF_CHARACTER c)

{
	((EIF_ARG_UNION *)args)[idx].carg = c;
}
/*------------------------------------------------------------------*/

rt_public void rout_obj_putd (char *args, int idx, EIF_DOUBLE d)

{
	((EIF_ARG_UNION *)args)[idx].darg = d;
}
/*------------------------------------------------------------------*/

rt_public void rout_obj_puti (char *args, int idx, EIF_INTEGER i)

{
	((EIF_ARG_UNION *)args)[idx].iarg = i;
}
/*------------------------------------------------------------------*/

rt_public void rout_obj_putp (char *args, int idx, EIF_POINTER p)

{
	((EIF_ARG_UNION *)args)[idx].parg = p;
}
/*------------------------------------------------------------------*/

rt_public void rout_obj_putf (char *args, int idx, EIF_REAL f)

{
	((EIF_ARG_UNION *)args)[idx].farg = f;
}
/*------------------------------------------------------------------*/

rt_public void rout_obj_putr (char *args, int idx, EIF_REFERENCE r)

{
	((EIF_ARG_UNION *)args)[idx].rarg = r;
}
/*------------------------------------------------------------------*/

rt_public void rout_obj_call_procedure (char *rout, char *tgt, char *args)

{
	EIF_ARG_UNION   result;

	((void(*)(char *, char *, EIF_ARG_UNION *))rout)(tgt, args, &result);
}
/*------------------------------------------------------------------*/

rt_public void rout_obj_call_function (char *cur, char *res, char *rout, char *tgt, char *args)

{
	EIF_ARG_UNION   result;
	char gcode, *resp;

	gcode = ((char(*)(char *, char *, EIF_ARG_UNION *))rout)(tgt, args, &result);

	resp = *(char **)res;

	switch (gcode)
	{
		case 'b': *((EIF_BOOLEAN*)resp) = result.barg;
				  break;
		case 'c': *((EIF_CHARACTER*)resp) = result.carg;
				  break;
		case 'd': *((EIF_DOUBLE*)resp) = result.darg;
				  break;
		case 'i': *((EIF_INTEGER*)resp) = result.iarg;
				  break;
		case 'p': *((EIF_POINTER*)resp) = result.parg;
				  break;
		case 'f': *((EIF_REAL*)resp) = result.farg;
				  break;
		default : *((EIF_REFERENCE*)resp) = result.rarg;
				  break;
	}
}
/*------------------------------------------------------------------*/

