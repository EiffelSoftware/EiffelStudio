/*
 #####   #    #  #               #        ####    ####   #    #          #    #
 #    #  #    #  #               #       #    #  #    #  #   #           #    #
 #    #  #    #  #               #       #    #  #       ####            ######
 #####   # ## #  #               #       #    #  #       #  #     ###    #    #
 #   #   ##  ##  #               #       #    #  #    #  #   #    ###    #    #
 #    #  #    #  ###### #######  ######   ####    ####   #    #   ###    #    #

	Header file for read write lock routine.
*/

#ifndef _rt_rw_lock_h_
#define _rt_rw_lock_h_

#include "eif_threads.h"
#include "eif_except.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS

/* Read Write lock structure. 
 * Based on mutex and condition variables. 
 */
typedef struct
{
	EIF_MUTEX_TYPE *m; /* Internal monitor lock. */
	int rwlock; /* >0 = # readers, <0 = writer, 0 = none */ 
	EIF_COND_TYPE *readers_ok; /* Start waiting readers. */
	unsigned int waiting_writers; /* Number of waiting writers. */
	EIF_COND_TYPE *writers_ok; /* Start a waiting writer. */
} eif_rwl_t;

extern void eif_rwl_init (eif_rwl_t *rwlp); /* Initialize Read-Write lock. */
RT_LNK void eif_rwl_rdlock (eif_rwl_t *rwlp); /* Lock in Read mode. */
RT_LNK void eif_rwl_wrlock (eif_rwl_t *rwlp); /* Lock in Write mode. */
RT_LNK void eif_rwl_unlock (eif_rwl_t *rwlp); /* Unlock Read-Write lock. */

#define EIF_RWL_CREATE(rwl, msg) \
	rwl = (eif_rwl_t *) eif_malloc (sizeof (eif_rwl_t)); \
	if (!rwl) eraise (msg, EN_EXT); \
	eif_rwl_init (rwl); 	

#endif /* EIF_THREADS */

#ifdef __cplusplus
}
#endif
#endif /* _rt_rw_lock_h_ */

