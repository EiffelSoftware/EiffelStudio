/* 
#######   ###   #######
#          #    #
#          #    #
#####      #    #####
#          #    #
#          #    #
#######   ###   #       #######

######  #     # #               #       #######  #####  #    #           #####
#     # #  #  # #               #       #     # #     # #   #           #     #
#     # #  #  # #               #       #     # #       #  #            #
######  #  #  # #               #       #     # #       ###             #
#   #   #  #  # #               #       #     # #       #  #      ###   #
#    #  #  #  # #               #       #     # #     # #   #     ###   #     #
#     #  ## ##  ####### ####### ####### #######  #####  #    #    ###    #####

 An implementation of multiple readers, single writer lock */

#include "eif_portable.h"
#include "rt_rw_lock.h"
#include "rt_threads.h"
#include "eif_lmalloc.h"

#ifdef EIF_THREADS /* Only in MT mode */


rt_shared void eif_rwl_init(eif_rwl_t *rwlp); /* Only called with EIF_RWL_CREATE. */
rt_public void eif_rwl_rdlock (eif_rwl_t *rwlp); /* Lock in read mode. */
rt_public void eif_rwl_wrlock (eif_rwl_t *rwlp); /* Lock in write mode. */
rt_public void eif_rwl_unlock (eif_rwl_t *rwlp); /* Unlock read write lock. */

rt_public void eif_rwl_init(eif_rwl_t *rwlp)
{
	/* Initialize Read-Write lock. */	

	EIF_MUTEX_TYPE *m;
	EIF_COND_TYPE *readers_ok, *writers_ok;

	EIF_MUTEX_CREATE (m, "Couldn't create rwlp->m\n");
	EIF_COND_CREATE (readers_ok, "Couldn't create rwlp->readers_ok\n"); 
	EIF_COND_CREATE (writers_ok, "Couldn't create rwlp->writers_ok\n"); 

	rwlp->m = m;
	rwlp->readers_ok = readers_ok;
	rwlp->writers_ok = writers_ok;
	rwlp->rwlock = 0; 
	rwlp->waiting_writers = 0; 
} 

rt_public void eif_rwl_rdlock (eif_rwl_t *rwlp)
{
	/* Acquire a Read lock. Multiple readers can go
	 * if there are no writer. 
	 */

	EIF_MUTEX_LOCK (rwlp->m, "Couldn't lock rwlp->m\n");
	while (rwlp->rwlock < 0 || rwlp->waiting_writers) {
		EIF_COND_WAIT (rwlp->readers_ok, rwlp->m, 
				"Couldn't wait for condition rwlp->readers_ok\n");
	}
	rwlp->rwlock++;
	EIF_MUTEX_UNLOCK (rwlp->m, "Couldn't unlock rwlp->m\n");
}

rt_public void eif_rwl_wrlock (eif_rwl_t *rwlp)
{
	/* Acquire a write lock. 
	 * Only a single writer can proceed.
	 */

	EIF_MUTEX_LOCK (rwlp->m,"Couldn't lock rwlp->m\n" );
	while (rwlp->rwlock != 0) 
	{
		rwlp->waiting_writers++;
		EIF_COND_WAIT (rwlp->writers_ok, rwlp->m, 
				"Couldn't wait for condition rwlp->writers_ok\n");
		rwlp->waiting_writers--;
	}
	rwlp->rwlock = -1;
	EIF_MUTEX_UNLOCK (rwlp->m, "Couldn't unlock rwlp->m\n");
}


rt_public void eif_rwl_unlock (eif_rwl_t *rwlp)
{
	/* Unlock Read-Write lock. */
	
	int ww, wr;

	EIF_MUTEX_LOCK (rwlp->m, "Couldn't lock rwlp->m\n");
	if (rwlp->rwlock < 0) /* rwlock < 0 iflocked for writing */
		rwlp->rwlock = 0;
	else
		rwlp->rwlock--;

	/* Keep flags that show if there are waiting readers or writers
	 * so that we can wake them up outside the mocitor lock.
	 */

	ww = (rwlp->waiting_writers && rwlp->rwlock == 0);
	wr = (rwlp->waiting_writers == 0);
	EIF_MUTEX_UNLOCK (rwlp->m, "Couldn't unlock rwlp->n\n");

	/* Wake up a waiting writer first. Otherwise wake up all readers. */

	if (ww) { 
		EIF_COND_SIGNAL (rwlp->writers_ok, 
				"Couldn't signal condition rwlp->writers_ok\n");
	}
	else if (wr) { 
		EIF_COND_BROADCAST (rwlp->readers_ok, 
				"Couldn't broadcast condition rwlp->readers_ok\n");
		}
}
#endif /* EIF_THREADS */
