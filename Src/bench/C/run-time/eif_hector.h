/*

 #    #  ######   ####    #####   ####   #####           #    #
 #    #  #       #    #     #    #    #  #    #          #    #
 ######  #####   #          #    #    #  #    #          ######
 #    #  #       #          #    #    #  #####    ###    #    #
 #    #  #       #    #     #    #    #  #   #    ###    #    #
 #    #  ######   ####      #     ####   #    #   ###    #    #

	Declarations for Hector.
*/

#ifndef _eif_hector_h_
#define _eif_hector_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_cecil.h"
#include "eif_garcol.h"		/* For struct stack */
#include "eif_globals.h"

/* Macros to remap cryptic names to meaningful ones. Note that the
 * interface defined in ETL uses the remaped names. Only this interface
 * is guaranteed.
 */
#define eif_access(_x)	(*(EIF_REFERENCE *) (_x))	/* Access object through hector */
#define eif_freeze		efreeze				/* Freeze memory address */
#define eif_adopt		eadopt				/* The C adopts an object */
#define	eif_protect		henter				/* The C protects an object */
#define eif_wean		ewean				/* The C weans adopted object */
#define eif_unfreeze	eufreeze			/* Forget a frozen memory address */
#define eif_frozen(object)	(HEADER(object)->ov_size & B_C)			/* Is object frozen? */

/* Declarations of exported stacks */
/*extern struct stack hec_stack;*//* %%ss *//* Indirection table "hector" */
/*extern struct stack hec_saved;*//* %%ss *//* Saved indirection pointers */

/* Declaration of hector routines */
#ifdef DEBUG2
extern int stck_nb_items (const struct stack stk);
extern int stck_nb_items_free_stack ();
#endif
RT_LNK EIF_REFERENCE efreeze(EIF_OBJECT object);				/* Freeze object's address (no more move) */
RT_LNK EIF_OBJECT eadopt(EIF_OBJECT object);			/* The C wants to keep the reference */
RT_LNK EIF_REFERENCE ewean(EIF_OBJECT object);				/* Weans a previously adopted reference */
extern void eufreeze(EIF_REFERENCE object);				/* Forget a frozen memory address */
RT_LNK EIF_OBJECT hrecord(EIF_REFERENCE object);			/* Record entry in hector table */
RT_LNK EIF_OBJECT henter(EIF_REFERENCE object);			/* Low-level entry in hector table */
RT_LNK void hfree(EIF_OBJECT address);				/* Low-level release from hector table */
RT_LNK EIF_REFERENCE spfreeze(EIF_REFERENCE object);			/* Freeze special object's address */
RT_LNK void spufreeze(EIF_REFERENCE object);			/* Put frozen spec obj back to GC control */
RT_LNK EIF_OBJECT hector_addr(EIF_REFERENCE root);		/* Maps an adress to an hector position */

#define spfrozen(object)	(HEADER(object)->ov_size & B_C) /* Is special object frozen */

#ifdef __cplusplus
}
#endif

#endif

