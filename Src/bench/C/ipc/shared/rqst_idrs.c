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

/* We have to declare private routines before the declaration of the union
 * discriminent. Let's declare public routines as well...
 */

/* Initialization routines */

/* Internal (de)serialization */
rt_private bool_t idr_Opaque(IDR *idrs, Opaque *ext);
rt_private bool_t idr_Acknlge(IDR *idrs, Acknlge *ext);
rt_private bool_t idr_Where(IDR *idrs, Where *ext);
rt_private bool_t idr_Stop(IDR *idrs, Stop *ext);
rt_private bool_t idr_Dumped(IDR *idrs, Dump *ext);

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
	{ SP_UPPER, idr_Opaque },
	{ __dontcare__, idr_void },
};

/*
 * Private encoding routines (one for each structure).
 */

rt_private bool_t idr_Opaque(IDR *idrs, Opaque *ext)
{
	return idr_int(idrs, &ext->op_type) &&
			idr_int(idrs, &ext->op_cmd) &&
			idr_u_long(idrs, (long unsigned int *) (&ext->op_size));
}

rt_private bool_t idr_Acknlge(IDR *idrs, Acknlge *ext)
{
	return idr_int(idrs, &ext->ak_type);
}

rt_private bool_t idr_Where(IDR *idrs, Where *ext)
{
	return idr_string(idrs, &ext->wh_name, -MAX_STRLEN) &&
			idr_u_long(idrs, (long unsigned int *)(&ext->wh_obj)) &&
			idr_int(idrs, &ext->wh_origin) &&
			idr_int(idrs, &ext->wh_type) &&
			idr_u_long(idrs, (long unsigned int *)(&ext->wh_offset));
}

rt_private bool_t idr_Stop(IDR *idrs, Stop *ext)
{
	return idr_Where(idrs, &ext->st_where) &&
			idr_int(idrs, &ext->st_why) &&
			idr_int(idrs, &ext->st_code) &&
			idr_string(idrs, &ext->st_tag, -MAX_STRLEN);
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
		return idr_char (idrs, &ext->it_char);
	case SK_FLOAT:
		return idr_float (idrs, &ext->it_float);
	case SK_DOUBLE:
		return idr_double (idrs, &ext->it_double);
	case SK_BIT:
		return idr_u_long (idrs, (long unsigned int *) (&ext->it_bit));
	default:
		return idr_u_long (idrs, (long unsigned int *) (&ext->it_ref));
	}
}


rt_private bool_t idr_Dumped (IDR *idrs, Dump *ext)
{
struct ex_vect *exv;
struct item *exi;

	if (!idr_int (idrs, &ext->dmp_type))
		return 0;
	switch (ext -> dmp_type) {
	case DMP_VECT:
	case DMP_MELTED:
		exv = ext -> dmpu.dmpu_vect;
		if (exv == 0) {
			exv = (struct ex_vect *) malloc (sizeof (struct ex_vect));
			bzero (exv, sizeof (struct ex_vect));
			ext -> dmpu.dmpu_vect = exv;
		}
		if (exv == 0)
			return 0;		/* lack of memory. Abort */
		if (! (idr_char (idrs, (char *) (&exv->ex_type))
			&& idr_char (idrs, (char *) (&exv->ex_retry))
			&& idr_char (idrs, (char *) (&exv->ex_rescue))))
			return 0;
		switch (exv->ex_type){
		case EX_RESC:
		case EX_RETY:
		case EX_CALL:
			return idr_u_long (idrs, (long unsigned int *) (&exv->exu.exur.exur_id))
				&& idr_string (idrs, &exv->exu.exur.exur_rout, -MAX_STRLEN)
				&& idr_int (idrs, &exv -> exu.exur.exur_orig);
		default:
			return idr_string (idrs, &exv->exu.exua.exua_name, -MAX_STRLEN)
				&& idr_string (idrs, &exv->exu.exua.exua_where, -MAX_STRLEN)
				&& idr_int (idrs, &exv->exu.exua.exua_from)
				&& idr_u_long (idrs, (long unsigned int *) (&exv->exu.exua.exua_oid));
		}
	case DMP_ITEM:
		exi = ext -> dmpu.dmpu_item;
		if (exi == 0){
			exi = (struct item *) malloc (sizeof (struct item));
			bzero (exi, sizeof (struct item));
			ext -> dmpu.dmpu_item = exi;
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

/*
 * Public (de)serializing routine.
 */

rt_public bool_t idr_Request(IDR *idrs, Request *ext)
{
	return idr_union(idrs, &ext->rq_type, (char *) (&ext->rqu), u_Request, idr_void);
}
