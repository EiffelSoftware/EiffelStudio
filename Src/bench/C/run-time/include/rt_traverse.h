/*

 #####  #####     ##    #    #  ######  #####    ####   ######       #    #
   #    #    #   #  #   #    #  #       #    #  #       #            #    #
   #    #    #  #    #  #    #  #####   #    #   ####   #####        ######
   #    #####   ######  #    #  #       #####        #  #       ###  #    #
   #    #   #   #    #   #  #   #       #   #   #    #  #       ###  #    #
   #    #    #  #    #    ##    ######  #    #   ####   ######  ###  #    #

	Private include file for traversal of objects.
*/

#ifndef _rt_traverse_h_
#define _rt_traverse_h_

#include "eif_traverse.h"
#include "rt_threads.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
extern EIF_LW_MUTEX_TYPE *eif_eo_store_mutex;
#ifdef ISE_GC
#define EIF_EO_STORE_LOCK \
	thread_can_launch_gc = 0; \
	EIF_LW_MUTEX_LOCK(eif_eo_store_mutex, "Cannot lock EO_STORE mutex.")
#define EIF_EO_STORE_UNLOCK \
	thread_can_launch_gc = 1; \
	EIF_LW_MUTEX_UNLOCK(eif_eo_store_mutex, "Cannot lock EO_STORE mutex.");
#else
#define EIF_EO_STORE_LOCK	EIF_LW_MUTEX_LOCK(eif_eo_store_mutex, "Cannot lock EO_STORE mutex.")
#define EIF_EO_STORE_UNLOCK	EIF_LW_MUTEX_UNLOCK(eif_eo_store_mutex, "Cannot lock EO_STORE mutex.");
#endif
#else
#define EIF_EO_STORE_LOCK
#define EIF_EO_STORE_UNLOCK
#endif

extern EIF_INTEGER_32 obj_nb;					/* Count of marked objects */
extern void traversal(EIF_REFERENCE object, int p_accounting); /* Traversal of objects */

/* Maping table handling */
extern void map_start(void);			/* Reset LIFO stack into a FIFO one */
extern EIF_OBJECT map_next(void);			/* Get next object as in a FIFO stack */
extern void map_reset(int emergency);			/* Reset maping table */

#ifdef DEBUG						/* For copy.c */
extern long nomark(char *obj);
#endif

/* The mstack structure has to be an exact copy of the stack structure, but has
 * an added field st_bot at the end. That way, we may safely use the common
 * stack handling structures without any code duplication and still have the
 * added field to make a FIFO stack--RAM.
 */
struct mstack {
	struct stchunk *st_hd;	/* Head of chunk list */
	struct stchunk *st_tl;	/* Tail of chunk list */
	struct stchunk *st_cur;	/* Current chunk in use (where top is) */
	char **st_top;			/* Top in chunk (pointer to next free location) */
	char **st_end;			/* Pointer to first element beyond current chunk */
	char **st_bot;			/* ADDED FIELD for FIFO stack implementation */
};

struct obj_array {
	EIF_REFERENCE *area;	/* Area where objects are stored */
	int count;				/* Number of inserted items */
	int capacity;			/* Capacity of `area' */
	int index;				/* Cursor position */
};

#ifdef __cplusplus
}
#endif

#endif

