/*

 #    #  ######   ####    #####   ####   #####           #    #
 #    #  #       #    #     #    #    #  #    #          #    #
 ######  #####   #          #    #    #  #    #          ######
 #    #  #       #          #    #    #  #####    ###    #    #
 #    #  #       #    #     #    #    #  #   #    ###    #    #
 #    #  ######   ####      #     ####   #    #   ###    #    #

	Declarations for Hector.
*/

#ifndef _hector_h_
#define _hector_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "cecil.h"
#include "garcol.h"		/* For struct stack */

/* Macros to remap cryptic names to meaningful ones. Note that the
 * interface defined in ETL uses the remaped names. Only this interface
 * is guaranteed.
 */
#define eif_access(_x)	(*(char **) (_x))	/* Access object through hector */
#define eif_freeze		efreeze				/* Freeze memory address */
#define eif_adopt		eadopt				/* The C adopts an object */
#define eif_wean		ewean				/* The C weans adopted object */
#define eif_unfreeze	eufreeze			/* Forget a frozen memory address */
#define eif_frozen(object)	(HEADER(object)->ov_size & B_C)			/* Is object frozen? */

/* Declarations of exported stacks */
extern struct stack hec_stack;		/* Indirection table "hector" */
extern struct stack hec_saved;		/* Saved indirection pointers */

/* Declaration of hector routines */
extern char *efreeze();				/* Freeze object's address (no more move) */
extern EIF_OBJ eadopt();			/* The C wants to keep the reference */
extern EIF_OBJ ewean();				/* Weans a previously adopted reference */
extern void eufreeze();				/* Forget a frozen memory address */
extern EIF_OBJ hrecord();			/* Record entry in hector table */
extern EIF_OBJ henter();			/* Low-level entry in hector table */
extern void hfree();				/* Low-level release from hector table */
extern char *spfreeze();			/* Freeze special object's address */
extern void spufreeze();			/* Put frozen spec obj back to GC control */

#define spfrozen(object)	(HEADER(object)->ov_size & B_C) /* Is special object frozen */

#ifdef __cplusplus
}
#endif

#endif

