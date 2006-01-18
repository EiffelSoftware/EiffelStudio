/*
	description: "An implementation of multiple readers, single writer lock."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="eif_rw_lock.c" header="rt_rw_lock.h" version="$Id$" summary="Multiple readers, single writer lock for platforms that does not support it natively.">
*/

#include "eif_portable.h"
#include "rt_rw_lock.h"
#include "rt_threads.h"
#include "rt_lmalloc.h"
#include "rt_assert.h"

#if defined EIF_THREADS && !defined HAS_RWL

rt_shared void eif_rwl_init(EIF_RWL_TYPE *rwlp); /* Only called with EIF_RWL_CREATE. */
rt_shared void eif_rwl_rdlock (EIF_RWL_TYPE *rwlp); /* Lock in read mode. */
rt_shared void eif_rwl_wrlock (EIF_RWL_TYPE *rwlp); /* Lock in write mode. */
rt_shared void eif_rwl_unlock (EIF_RWL_TYPE *rwlp); /* Unlock read write lock. */
rt_shared void eif_rwl_destroy (EIF_RWL_TYPE * rwlp);


/*
doc:	<routine name="eif_rwl_init" export="shared">
doc:		<summary>Initialize a read-write lock.</summary>
doc:		<param name="rwlp" type="EIF_RWL_TYPE *">Pointer to read/write lock structure to be initalized.</param>
doc:		<exception>EN_EXT when it fails</exception>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe if called with a different value for `rwlp'.</synchronization>
doc:	</routine>
*/

rt_shared void eif_rwl_init(EIF_RWL_TYPE *rwlp)
{
	EIF_MUTEX_TYPE *m;
	EIF_COND_TYPE *readers_ok, *writers_ok;

	REQUIRE ("rwlp not null", rwlp);

	EIF_MUTEX_CREATE (m, "Couldn't create rwlp->m\n");
	EIF_COND_CREATE (readers_ok, "Couldn't create rwlp->readers_ok\n"); 
	EIF_COND_CREATE (writers_ok, "Couldn't create rwlp->writers_ok\n"); 

	rwlp->m = m;
	rwlp->readers_ok = readers_ok;
	rwlp->writers_ok = writers_ok;
	rwlp->rwlock = 0; 
	rwlp->waiting_writers = 0; 
} 

/*
doc:	<routine name="eif_rwl_rdlock" export="shared">
doc:		<summary>Acquire a read lock. Multiple readers can go if there are no writer.</summary>
doc:		<param name="rwlp" type="EIF_RWL_TYPE *">Pointer to read/write lock structure to be locked.</param>
doc:		<exception>EN_EXT when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_shared void eif_rwl_rdlock (EIF_RWL_TYPE *rwlp)
{
	REQUIRE ("rwlp not null", rwlp);
	EIF_MUTEX_LOCK (rwlp->m, "Couldn't lock rwlp->m\n");
	while (rwlp->rwlock < 0 || rwlp->waiting_writers) {
		EIF_COND_WAIT (rwlp->readers_ok, rwlp->m, 
				"Couldn't wait for condition rwlp->readers_ok\n");
	}
	rwlp->rwlock++;
	EIF_MUTEX_UNLOCK (rwlp->m, "Couldn't unlock rwlp->m\n");
}

/*
doc:	<routine name="eif_rwl_wrlock" export="shared">
doc:		<summary>Acquire a write lock. Only a single write can proceed.</summary>
doc:		<param name="rwlp" type="EIF_RWL_TYPE *">Pointer to read/write lock structure to be locked.</param>
doc:		<exception>EN_EXT when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_shared void eif_rwl_wrlock (EIF_RWL_TYPE *rwlp)
{
	REQUIRE ("rwlp not null", rwlp);
	EIF_MUTEX_LOCK (rwlp->m,"Couldn't lock rwlp->m\n" );
	while (rwlp->rwlock != 0) {
		rwlp->waiting_writers++;
		EIF_COND_WAIT (rwlp->writers_ok, rwlp->m, 
				"Couldn't wait for condition rwlp->writers_ok\n");
		rwlp->waiting_writers--;
	}
	rwlp->rwlock = -1;
	EIF_MUTEX_UNLOCK (rwlp->m, "Couldn't unlock rwlp->m\n");
}

/*
doc:	<routine name="eif_rwl_unlock" export="shared">
doc:		<summary>Unlock a read or write lock.</summary>
doc:		<param name="rwlp" type="EIF_RWL_TYPE *">Pointer to read/write lock structure to be unlocked.</param>
doc:		<exception>EN_EXT when it fails</exception>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None required</synchronization>
doc:	</routine>
*/

rt_shared void eif_rwl_unlock (EIF_RWL_TYPE *rwlp)
{
	int ww, wr;

	REQUIRE ("rwlp not null", rwlp);
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

/*
doc:	<routine name="eif_rwl_destroy" export="shared">
doc:		<summary>Destroy a read/write lock.</summary>
doc:		<param name="rwlp" type="EIF_RWL_TYPE *">Pointer to read/write lock structure to be destroyed.</param>
doc:		<exception>EN_EXT when it fails</exception>
doc:		<thread_safety>Not safe</thread_safety>
doc:		<synchronization>Safe if called with a different value for `rwlp'.</synchronization>
doc:	</routine>
*/

rt_shared void eif_rwl_destroy (EIF_RWL_TYPE *rwlp)
{
	REQUIRE ("rwlp not null", rwlp);
	EIF_MUTEX_DESTROY(rwlp->m, "Cannot destroy mutex");
	EIF_COND_DESTROY(rwlp->readers_ok, "Cannot destroy condition variable");
	EIF_COND_DESTROY(rwlp->writers_ok, "Cannot destroy condition variable");

	rwlp->m = NULL;
	rwlp->readers_ok = NULL;
	rwlp->writers_ok = NULL;
	rwlp->rwlock = 0; 
	rwlp->waiting_writers = 0; 
}

#endif /* EIF_THREADS */

/*
doc:</file>
*/
