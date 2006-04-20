/*
	description: "Header file for read write lock routine."
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

#ifndef _rt_rw_lock_h_
#define _rt_rw_lock_h_

#include "eif_threads.h"
#include "eif_except.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
	
#ifdef HAS_RWL

#ifdef SOLARIS_THREADS
	/* Read/Write Lock */
#define EIF_RWL_TYPE	rwlock_t
#define EIF_RWL_INIT(rwl,msg) \
	if (rwlock_init(rwl, USYNC_THREAD, NULL)) eraise (msg, EN_EXT)
#define EIF_RWL_CREATE(rwl, msg) \
	rwl = (EIF_RWL_TYPE *) eif_malloc (sizeof(EIF_RWL_TYPE)); \
	if (!rwl) {\
		eraise ("Cannot allocate memory for read/write lock creation.", EN_MEM); \
	} else { \
		EIF_RWL_INIT(rwl,msg); \
	}
#define EIF_RWL_RDLOCK(rwl,msg) if (rw_rdlock(rwl)) eraise (msg, EN_EXT)
#define EIF_RWL_WRLOCK(rwl,msg) if (rw_wrlock(rwl)) eraise (msg, EN_EXT)
#define EIF_RWL_UNLOCK(rwl,msg) if (rw_unlock(rwl)) eraise (msg, EN_EXT)
#define EIF_RWL_DESTROY(rwl, msg) \
	if (rwlock_destroy(rwl)) eraise (msg, EN_EXT); \
	eif_free(rwl)

#endif

#else
/* Platform does not provide Read/Write lock, we provide our own implementation */
typedef struct
{
	EIF_MUTEX_TYPE *m; /* Internal monitor lock. */
	int rwlock; /* >0 = # readers, <0 = writer, 0 = none */ 
	EIF_COND_TYPE *readers_ok; /* Start waiting readers. */
	unsigned int waiting_writers; /* Number of waiting writers. */
	EIF_COND_TYPE *writers_ok; /* Start a waiting writer. */
} EIF_RWL_TYPE;

	/* Read/Write Lock */
#define EIF_RWL_INIT(rwl,msg) eif_rwl_init(rwl)
#define EIF_RWL_CREATE(rwl, msg) \
	rwl = (EIF_RWL_TYPE *) eif_malloc (sizeof(EIF_RWL_TYPE)); \
	if (!rwl) {\
		eraise ("Cannot allocate memory for read/write lock creation.", EN_MEM); \
	} else { \
		EIF_RWL_INIT(rwl,msg); \
	}
#define EIF_RWL_RDLOCK(rwl,msg) eif_rwl_rdlock(rwl)
#define EIF_RWL_WRLOCK(rwl,msg) eif_rwl_wrlock(rwl)
#define EIF_RWL_UNLOCK(rwl,msg) eif_rwl_unlock(rwl)
#define EIF_RWL_DESTROY(rwl, mesg) eif_rwl_destroy(rwl); eif_free (rwl)

extern void eif_rwl_init (EIF_RWL_TYPE *rwlp); /* Initialize Read-Write lock. */
extern void eif_rwl_rdlock (EIF_RWL_TYPE *rwlp); /* Lock in Read mode. */
extern void eif_rwl_wrlock (EIF_RWL_TYPE *rwlp); /* Lock in Write mode. */
extern void eif_rwl_unlock (EIF_RWL_TYPE *rwlp); /* Unlock Read-Write lock. */
extern void eif_rwl_destroy (EIF_RWL_TYPE * rwlp);

#endif /* HAS_RWL */

#endif /* EIF_THREADS */

#ifdef __cplusplus
}
#endif
#endif /* _rt_rw_lock_h_ */

