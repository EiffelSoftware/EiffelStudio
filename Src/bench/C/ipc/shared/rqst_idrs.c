/*

 #####    ####    ####    #####             #    #####   #####    ####
 #    #  #    #  #          #               #    #    #  #    #  #
 #    #  #    #   ####      #               #    #    #  #    #   ####
 #####   #  # #       #     #               #    #    #  #####        #   ###
 #   #   #   #   #    #     #               #    #    #  #   #   #    #   ###
 #    #   ### #   ####      #   #######     #    #####   #    #   ####    ###

	Routine for Request Internal Data Representation.
*/

#include "config.h"
#include "portable.h"
#include "request.h"
#include "idrs.h"
#include "rqst_idrs.h"

/* We have to declare private routines before the declaration of the union
 * discriminent. Let's declare public routines as well...
 */

/* Initialization routines */

/* Internal (de)serialization */
private bool_t idr_Opaque();
private bool_t idr_Acknlge();
private bool_t idr_Where();
private bool_t idr_Stop();
private bool_t idr_Dumped();

/* Main encoding/decoding routine */
public bool_t idr_Request();

/* This arrray records each serialization routine depending on the type of
 * the union request (field rq_type). The default arm routine is idr_void,
 * therefore only those requests which carry some other information are
 * listed hereafter.
 */
 private struct idr_discrim u_Request[] = {
	{ OPAQUE, idr_Opaque },
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
	{ __dontcare__, idr_void },
};

/*
 * Private encoding routines (one for each structure).
 */

private bool_t idr_Opaque(idrs, ext)
IDR *idrs;
Opaque *ext;
{
	return idr_int(idrs, &ext->op_type) &&
			idr_int(idrs, &ext->op_cmd) &&
			idr_long(idrs, &ext->op_size);
}

private bool_t idr_Acknlge(idrs, ext)
IDR *idrs;
Acknlge *ext;
{
	return idr_int(idrs, &ext->ak_type);
}

private bool_t idr_Where(idrs, ext)
IDR *idrs;
Where *ext;
{
	return idr_string(idrs, &ext->wh_name, -MAX_STRLEN) &&
			idr_long(idrs, &ext->wh_obj) &&
			idr_int(idrs, &ext->wh_origin) &&
			idr_int(idrs, &ext->wh_type) &&
			idr_long(idrs, &ext->wh_offset);
}

private bool_t idr_Stop(idrs, ext)
IDR *idrs;
Stop *ext;
{
	return idr_Where(idrs, &ext->st_where) &&
			idr_int(idrs, &ext->st_why) &&
			idr_int(idrs, &ext->st_code) &&
			idr_string(idrs, &ext->st_tag, -MAX_STRLEN);
}

private bool_t idr_Item (idrs, ext)
IDR *idrs;
struct item* ext;
{
	if (! idr_int (idrs, &ext->type))
		return 0;
	switch (ext -> type & SK_HEAD) {
	case SK_POINTER:
		return idr_long(idrs, &ext->it_ptr);
	case SK_BOOL:
	case SK_CHAR:
		return idr_char (idrs, &ext->it_char);
	case SK_FLOAT:
		return idr_float (idrs, &ext->it_float);
	case SK_DOUBLE:
		return idr_double (idrs, &ext->it_double);
	case SK_BIT:
		return idr_long (idrs, &ext->it_bit);
	default:
		return idr_long (idrs, &ext->it_ref);
	}
}


private bool_t idr_Dumped (idrs, ext)
IDR *idrs;
Dump *ext;
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
		if (! (idr_char (idrs, &exv->ex_type)
			&& idr_char (idrs, &exv->ex_retry)
			&& idr_char (idrs, &exv->ex_rescue)))
			return 0;
		switch (exv->ex_type){
		case EX_CALL:
			return idr_long (idrs, &exv->exu.exur.exur_id)
				&& idr_string (idrs, &exv->exu.exur.exur_rout, -MAX_STRLEN)
				&& idr_int (idrs, &exv -> exu.exur.exur_orig);
		default:
			return idr_string (idrs, &exv->exu.exua.exua_name, -MAX_STRLEN)
				&& idr_string (idrs, &exv->exu.exua.exua_where, -MAX_STRLEN)
				&& idr_int (idrs, &exv->exu.exua.exua_from)
				&& idr_long (idrs, &exv->exu.exua.exua_oid);
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
	}
	return 0; /* not a proper dumped */
}

/*
 * Public (de)serializing routine.
 */

public bool_t idr_Request(idrs, ext)
IDR *idrs;
Request *ext;
{
	return idr_union(idrs, &ext->rq_type, &ext->rqu, u_Request, idr_void);
}

