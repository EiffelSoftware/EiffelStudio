/*

 #####  #####     ##    #    #  ######  #####    ####   ######       #    #
   #    #    #   #  #   #    #  #       #    #  #       #            #    #
   #    #    #  #    #  #    #  #####   #    #   ####   #####        ######
   #    #####   ######  #    #  #       #####        #  #       ###  #    #
   #    #   #   #    #   #  #   #       #   #   #    #  #       ###  #    #
   #    #    #  #    #    ##    ######  #    #   ####   ######  ###  #    #

	Include file for traversal of objects.
*/

#ifndef _eif_traverse_h_
#define _eif_traverse_h_

#include "eif_hector.h"
#include "eif_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Flags for traversal */
#define TR_PLAIN		0x00		/* No accounting during object traversal */
#define TR_ACCOUNT		0x01		/* Accounting of objects in obj_nb */
#define TR_MAP			0x02		/* Build a maping table in obj_table */
#define INDEPEND_ACCOUNT		0x05		/* Accounting of objects in obj_nb */

extern EIF_INTEGER_32 obj_nb;					/* Count of marked objects */
extern void traversal(char *object, int p_accounting); /* Traversal of objects */

RT_LNK void find_referers (EIF_REFERENCE target, EIF_REFERENCE result, int result_size);

/* Maping table handling */
extern void map_start(void);			/* Reset LIFO stack into a FIFO one */
extern EIF_OBJECT map_next(void);			/* Get next object as in a FIFO stack */
extern void map_reset(int emergency);			/* Reset maping table */

#ifdef DEBUG						/* For copy.c */
extern long nomark(char *obj);
#endif

#ifdef __cplusplus
}
#endif

#endif

