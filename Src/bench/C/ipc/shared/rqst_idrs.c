/*

 #####    ####    ####    #####             #    #####   #####    ####
 #    #  #    #  #          #               #    #    #  #    #  #
 #    #  #    #   ####      #               #    #    #  #    #   ####
 #####   #  # #       #     #               #    #    #  #####        #   ###
 #   #   #   #   #    #     #               #    #    #  #   #   #    #   ###
 #    #   ### #   ####      #   #######     #    #####   #    #   ####    ###

	Routine for Request Internal Data Representation.
*/

#include "eif_config.h"
#include "eif_portable.h"
#include "request.h"
#include "idrs.h"
#include "rqst_idrs.h"
#include <string.h>

/* We have to declare private routines before the declaration of the union
 * discriminent. Let's declare public routines as well...
 */

/* Initialization routines */

/* Internal (de)serialization */
rt_private bool_t idr_Opaque(IDR *idrs, void *ext);
rt_private bool_t idr_Acknlge(IDR *idrs, void *ext);
rt_private bool_t idr_Where(IDR *idrs, void *ext);
rt_private bool_t idr_Stop(IDR *idrs, void *ext);
rt_private bool_t idr_Dumped(IDR *idrs, void *ext);
rt_private bool_t idr_Item (IDR *idrs, struct item *ext);

/* Main encoding/decoding routine */
rt_public bool_t idr_Request(IDR *idrs, Request *ext);

/* This arrray records each serialization routine depending on the type of
 * the union request (field rq_type). The default arm routine is idr_void,
 * therefore only those requests which carry some other information are
 * listed hereafter.
 */
rt_private struct idr_discrim u_Request[] = {
	{ EIF_OPAQUE, idr_Opaque },
	{ ACKNLGE, idr_Acknlge },
	{ TRANSFER, idr_Opaque },
	{ STOPPED, idr_Stop },
	{ MOVE, idr_Opaque },
	{ BREAK, idr_Opaque },
	{ LOAD, idr_Opaque },
	{ BYTECODE, idr_Opaque },
	{ RESUME, idr_Opaque },
	{ DUMPED, idr_Dumped },
	{ DUMP, idr_Opaque },
	{ INSPECT, idr_Opaque },
	{ ADOPT, idr_Opaque },
	{ ACCESS, idr_Opaque },
	{ WEAN, idr_Opaque },
	{ ONCE, idr_Opaque },
	{ SP_LOWER, idr_Opaque },
	{ METAMORPHOSE, idr_Opaque },
	{ MODIFY_LOCAL, idr_Opaque },
	{ MODIFY_ATTR, idr_Opaque },
	{ DYNAMIC_EVAL, idr_Opaque },
	{ DUMP_VARIABLES, idr_Opaque },
	{ __dontcare__, idr_void },
};

/*
 * Public (de)serializing routine.
 */

rt_public bool_t idr_Request(IDR *idrs, Request *ext)
	{
	return idr_union(idrs, &ext->rq_type, (char *) (&ext->rqu), u_Request, idr_void);
	}

/*
 * Private encoding routines (one for each structure).
 */

rt_private bool_t idr_Opaque(IDR *idrs, void *ext)
	{
	Opaque *opa = (Opaque *) ext;
	return idr_int(idrs, &opa->op_type) &&
			idr_int(idrs, &opa->op_cmd) &&
			idr_u_long(idrs, (long unsigned int *) (&opa->op_size));
	}

rt_private bool_t idr_Acknlge(IDR *idrs, void *ext)
	{
	return idr_int(idrs, &((Acknlge *)ext)->ak_type);
	}

rt_private bool_t idr_Where(IDR *idrs, void *ext)
	{
	/* Arnaud: I've replaced MAX_STRLEN with MAX_FEATURE_NAME to avoid a bug
	 * in the debugger with feature with a 'long' name (>MAX_STRLEN chars)
	 */
	Where *whe = (Where *) ext;
	return idr_string(idrs, &whe->wh_name, -MAX_FEATURE_LEN) &&
			idr_u_long(idrs, (long unsigned int *)(&whe->wh_obj)) &&
			idr_int(idrs, &whe->wh_origin) &&
			idr_int(idrs, &whe->wh_type) &&
			idr_u_long(idrs, (long unsigned int *)(&whe->wh_offset));
	}

rt_private bool_t idr_Stop(IDR *idrs, void *ext)
	{
	Stop *sto = (Stop *) ext;
	return idr_Where(idrs, &sto->st_where) &&
			idr_int(idrs, &sto->st_why) &&
			idr_int(idrs, &sto->st_code) &&
			idr_string(idrs, &sto->st_tag, -MAX_STRLEN);
	}

rt_private bool_t idr_Dumped (IDR *idrs, void *ext)
{
	Dump					*dum	= (Dump *)ext;
	struct debug_ex_vect	*exv;
	struct item				*exi;

	if (!idr_int (idrs, &dum->dmp_type))
		return 0;
	switch (dum -> dmp_type) {
	case DMP_VECT:
	case DMP_MELTED:
		exv = dum -> dmpu.dmpu_vect;
		if (exv == 0){
			exv = (struct debug_ex_vect *) malloc (sizeof (struct debug_ex_vect));
			memset  (exv, 0, sizeof (struct debug_ex_vect));
			dum -> dmpu.dmpu_vect = exv;
		}
		if (exv == 0)
			return 0;		/* lack of memory. Abort */
		if (! (idr_char (idrs, (char *) (&exv->ex_type))
			&& idr_char (idrs, (char *) (&exv->ex_retry))
			&& idr_char (idrs, (char *) (&exv->ex_rescue))))
			return 0;
		switch (exv->ex_type) {
		case EX_RESC:
		case EX_RETY:
		case EX_CALL:
			return idr_u_long (idrs, (long unsigned int *) (&exv->exu.exur.exur_id))
				&& idr_string (idrs, &exv->exu.exur.exur_rout, -MAX_FEATURE_LEN)
				&& idr_int (idrs, &exv -> exu.exur.exur_orig)
				&& idr_int (idrs, &exv->dex_linenum);
		default:
			return idr_string (idrs, &exv->exu.exua.exua_name, -MAX_STRLEN)
				&& idr_string (idrs, &exv->exu.exua.exua_where, -MAX_STRLEN)
				&& idr_int (idrs, &exv->exu.exua.exua_from)
				&& idr_u_long (idrs, (long unsigned int *) (&exv->exu.exua.exua_oid));
		}
	case DMP_ITEM:
		exi = dum -> dmpu.dmpu_item;
		if (exi == 0){
			exi = (struct item *) malloc (sizeof (struct item));
			memset (exi, 0, sizeof (struct item));
			dum -> dmpu.dmpu_item = exi;
		}
		if (exi == 0)
			return 0; /* lack of memory. Abort */
		return idr_Item (idrs, exi);
	case DMP_OBJ:
		return 1;
	case DMP_VOID:
		return 1;
	}
	return 0; /* not a proper dumped */
}


rt_private bool_t idr_Item (IDR *idrs, struct item *ext)
{
	if (! idr_int (idrs, (int *)(&ext->type)))
		return 0;
	switch (ext -> type & SK_HEAD) {
	case SK_POINTER:
		return idr_u_long(idrs, (long unsigned int *) (&ext->it_ptr));
	case SK_BOOL:
	case SK_CHAR:
		return idr_char (idrs, (char *) &ext->it_char);
	case SK_FLOAT:
		return idr_float (idrs, &ext->it_float);
	case SK_DOUBLE:
		return idr_double (idrs, &ext->it_double);
	case SK_BIT:
		return idr_u_long (idrs, (long unsigned int *) (&ext->it_bit));
	case SK_STRING:
		return idr_string (idrs, &ext->it_ref, 0); /* 0 = no limit */
	default:
		return idr_u_long (idrs, (long unsigned int *) (&ext->it_ref));
	}
}


