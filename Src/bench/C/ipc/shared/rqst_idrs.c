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

/*
 * Public (de)serializing routine.
 */

public bool_t idr_Request(idrs, ext)
IDR *idrs;
Request *ext;
{
	return idr_union(idrs, &ext->rq_type, &ext->rqu, u_Request, idr_void);
}

