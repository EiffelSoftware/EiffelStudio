/*

  #####  #####     ##    #    #  ######  #####    ####   ######          #    #
    #    #    #   #  #   #    #  #       #    #  #       #               #    #
    #    #    #  #    #  #    #  #####   #    #   ####   #####           ######
    #    #####   ######  #    #  #       #####        #  #        ###    #    #
    #    #   #   #    #   #  #   #       #   #   #    #  #        ###    #    #
    #    #    #  #    #    ##    ######  #    #   ####   ######   ###    #    #

	Include file for traversal of objects.
*/

#ifndef _traverse_h_
#define _traverse_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "hector.h"

/* Flags for traversal */
#define TR_PLAIN		0x00		/* No accounting during object traversal */
#define TR_ACCOUNT		0x01		/* Accounting of objects in obj_nb */
#define TR_MAP			0x02		/* Build a maping table in obj_table */
#define INDEPEND_ACCOUNT		0x05		/* Accounting of objects in obj_nb */

extern long obj_nb;					/* Count of marked objects */
extern void traversal();			/* Traversal of objects */

/* Maping table handling */
extern void map_start();			/* Reset LIFO stack into a FIFO one */
extern EIF_OBJ map_next();			/* Get next object as in a FIFO stack */
extern void map_reset();			/* Reset maping table */

#ifdef DEBUG						/* For copy.c */
extern long nomark();
#endif

#ifdef __cplusplus
}
#endif

#endif

