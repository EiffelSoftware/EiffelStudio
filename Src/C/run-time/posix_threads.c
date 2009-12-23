/*
	description: "Thread management routines."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2009, Eiffel Software."
	license:	"[
		GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)
		ASF license for condition variable code see http://www.apache.org/licenses/LICENSE-2.0
		]"
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
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
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
doc:<file name="eif_posix_threads.c" header="eif_posix_threads.h" version="$Id$" summary="POSIX Thread management routines.">
*/


#include "eif_portable.h"
#include "eif_eiffel.h"
#include "eif_posix_threads.h"
#include "eif_error.h"
#include <string.h>
#include "rt_timer.h"
#include <signal.h>
#include <limits.h>

#ifdef VXWORKS
#include <sysLib.h>
#endif


#ifdef EIF_THREADS

rt_private int eif_pthread_sem_wait_with_timeout (EIF_SEM_TYPE * sem, rt_uint_ptr timeout);

/* Posix drafts compatibility */
#ifdef POSIX_10034A
#define pthread_attr_init				pthread_attr_create
#define pthread_key_creatt				pthread_keycreate
#define pthread_attr_setschedpolicy		pthread_attr_setsched
#define pthread_attr_setschedparam(x,y)	pthread_attr_setprio (x, (*(y)).sched_priority)
#define pthread_attr_destroy(x)			pthread_attr_delete (x)
#endif

/* To avoid code duplication as most Solaris Threads API have almost the
 * same signature as their Posix Threads counterpart. */
#ifdef SOLARIS_THREADS
/* Mutex */
#define pthread_mutex_init(a)			mutex_init(a,USYNC_THREAD | LOCK_RECURSIVE, NULL)
#define pthread_mutex_destroy			mutex_destroy
#define pthread_mutex_lock				mutex_lock
#define pthread_mutex_trylock			mutex_trylock
#define pthread_mutex_unlock			mutex_unlock

/* Condition variable */
#define pthread_cond_init(a,b)			cond_init(a,USYNC_THREAD,b)
#define pthread_cond_destroy			cond_destroy
#define pthread_cond_wait				cond_wait
#define pthread_cond_timedwait			cond_timedwait
#define pthread_cond_signal				cond_signal
#define pthread_cond_broadcast			cond_broadcast

/* Read/wrte lock */
#define pthread_rwlock_init(l,att)		rwlock_init(l,USYNC_THREAD,att)
#define pthread_rwlock_destroy			rwlock_destroy
#define pthread_rwlock_rdlock			rw_rdlock
#define pthread_rwlock_tryrdlock		rw_tryrdlock
#define pthread_rwlock_wrlock			rw_wrlock
#define pthread_rwlock_trywrlock		rw_trywrlock
#define pthread_rwlock_unlock			rw_unlock

#elif defined(EIF_POSIX_THREADS)
#if EIF_OS == EIF_OS_SUNOS
/* Solaris does not define PTHREAD_STACK_MIN by default. */
#define PTHREAD_STACK_MIN	((size_t)_sysconf(_SC_THREAD_STACK_MIN))
#endif

#endif

typedef struct {
	void (* routine) (void *);
	void *argument;
	rt_uint_ptr priority;
} RT_START_STRUCTURE;

#ifdef EIF_WINDOWS
rt_private int mapped_errno (DWORD err) {
	switch (err) {
		case EINVAL: return T_INVALID_ARGUMENT; break;
		default:
			if (err == ERROR_SUCCESS) {
				return T_OK;
			} else {
				return T_UNKNOWN_ERROR;
			}
	}
}
#else
rt_private int mapped_errno (int err) {
	switch (err) {
		case ESRCH: return T_NO_THREAD_WITH_ID; break;
		case EAGAIN: return T_TRY_AGAIN; break;
		case EFAULT: return T_INVALID_POINTER; break;
		case EINVAL: return T_INVALID_ARGUMENT; break;
		case EBUSY: return T_BUSY; break;
		case ENOMEM: return T_NO_MORE_MEMORY; break;
		case ENOTSUP: return T_UNSUPPORTED; break;
		case EPERM: return T_NOT_ENOUGH_PERMISSION; break;
		case EDEADLK: return T_DEADLOCK; break;
		case ETIMEDOUT:
#ifdef SOLARIS_THREADS
		case ETIME:
#endif
			return T_TIMEDOUT; break;
		case ENOSYS: return T_UNSUPPORTED; break;
		
		default:
			if (err) {
				return T_UNKNOWN_ERROR;
			} else {
				return T_OK;
			}
	}
}
#endif


#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)
/*
doc:	<routine name="rt_timeout_to_timespec" return_type="struct timespec" export="private">
doc:		<summary>Given a timeout in milliseconds, computes a timespec structure equivalent.</summary>
doc:		<param name="timeout" type="rt_uint_ptr">Timeout to convert in milliseconds.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

rt_private struct timespec rt_timeout_to_timespec(rt_uint_ptr timeout)
{
	time_t l_seconds = timeout / 1000;	/* `timeout' is in millisecond */
	long l_nano_seconds = (timeout % 1000) * 1000000;	/* Reminder in nanoseconds */
	struct timespec tspec;
	struct timeval now;
	gettime(&now);
	tspec.tv_sec = now.tv_sec + l_seconds;
	l_nano_seconds += (now.tv_usec * 1000);
	tspec.tv_nsec = l_nano_seconds;
		/* If `l_nano_seconds' is greater than 1 second, we need to update `tspec'
		 * accordingly otherwise we may get EINVAL on some platforms. */
	if (l_nano_seconds > 1000000000) {
		tspec.tv_sec++;
		tspec.tv_nsec -= 1000000000;
	}
	return tspec;
}

#endif

/*
doc:	<routine name="rt_thread_routine" export="private">
doc:		<summary>Wrapper routine used to start a thread. The wrapper is currently used to set the priority of a thread when it cannot be set prior to launch of thread. The argument `thread_arg' is allocated by thread creating current thread, and should be free by Current routine.</summary>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

#ifdef EIF_WINDOWS
rt_private unsigned __stdcall rt_thread_routine (void *thread_arg)
#elif defined(VXWORKS)
rt_private void rt_thread_routine(void * thread_arg, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10)
#else
rt_private void *rt_thread_routine (void *thread_arg)
#endif
{
	RT_START_STRUCTURE *l_start = (RT_START_STRUCTURE *) thread_arg;

		/* Extract the arguments. */
	void (* l_thread_routine) (void *) = l_start->routine;
	void *l_arg = l_start->argument;
	rt_uint_ptr l_priority = l_start->priority;
	eif_free (l_start);
	
		/* Let's set map the Eiffel priority to . */
	eif_pthread_set_priority(eif_pthread_self(), l_priority);

		/* Let's start our real thread. */
	if (l_thread_routine) {
		l_thread_routine (l_arg);
	}

#ifdef EIF_WINDOWS
	return 0;
#elif defined(VXWORKS)
	return;
#else
	return NULL;
#endif
}

/*
doc:	<routine name="eif_pthread_create" return_type="int" export="public">
doc:		<summary>Start a thread and store its ID in `thread_id' using the thread attributes `thread_attr'. When thread starts, it will execute `thread_routine' using `thread_arg' as argument.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="thread_id" type="EIF_THR_TYPE *">Computed thread ID if launch successful.</param>
doc:		<param name="thread_attr" type="EIF_THR_ATTR_TYPE *">Properties of the thread being launched ID.</param>
doc:		<param name="thread_routine" type="void *(*) (void *)">Routine being executed when thread starts.</param>
doc:		<param name="thread_arg" type="void *(*) (void *)">Routine being executed when thread starts.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_create (EIF_THR_TYPE *thread_id, EIF_THR_ATTR_TYPE *thread_attr, void (*thread_routine) (void *), void *thread_arg)
{
	int Result;
	EIF_THR_ATTR_TYPE l_thread_attr;
	RT_START_STRUCTURE *l_start;

		/* No thread attribute was provided, we set our own values. */
	if (thread_attr == NULL) {
		memset (&l_thread_attr, 0, sizeof(EIF_THR_ATTR_TYPE));
		l_thread_attr.priority = EIF_DEFAULT_THR_PRIORITY;
		thread_attr = &l_thread_attr;
	}

	l_start = (RT_START_STRUCTURE *) eif_malloc(sizeof(RT_START_STRUCTURE));
	if (!l_start) {
		Result = 1;
	} else {
		l_start->routine = thread_routine;
		l_start->argument = thread_arg;
		l_start->priority = thread_attr->priority;

#ifdef EIF_POSIX_THREADS
		pthread_attr_t l_attr;
		Result = pthread_attr_init (&l_attr);
		if (Result == 0) {
				/* Initialize the stack size if more than the minimum. */
			if (thread_attr->stack_size >= PTHREAD_STACK_MIN) {
				pthread_attr_setstacksize (&l_attr, thread_attr->stack_size);
			}
			if (thread_attr->priority != EIF_DEFAULT_THR_PRIORITY) {
				struct sched_param l_param;
				memset(&l_param, 0, sizeof(struct sched_param));
				l_param.sched_priority = thread_attr->priority;
				pthread_attr_setschedpolicy(&l_attr, SCHED_OTHER);
				pthread_attr_setschedparam(&l_attr, &l_param);
			}
				/* We always create threads detached. */
			pthread_attr_setdetachstate (&l_attr, PTHREAD_CREATE_DETACHED);

			Result = pthread_create (thread_id, &l_attr, rt_thread_routine, l_start);
			pthread_attr_destroy (&l_attr);
		}
#elif defined(SOLARIS_THREADS)
		Result = thr_create (NULL, thread_attr->stack_size, rt_thread_routine, l_start, THR_NEW_LWP | THR_DETACHED, thread_id);
#elif defined(EIF_WINDOWS)
		*thread_id = (EIF_THR_TYPE) _beginthreadex (NULL, (unsigned int) thread_attr->stack_size, rt_thread_routine, l_start, 0, NULL);
		Result = (!(*thread_id));
#elif defined(VXWORKS)
			/* On VxWorks, the highest priority is 0, the lowest is 255. So we adapt the given value since
			 * the maximum Eiffel value is also 255 (aka EIF_MAX_THR_PRIORITY) . */
		l_start->priority = 255 - thread_attr->priority;
		*thread_id = taskSpawn (NULL, l_start->priority, VX_FP_TASK, thread_attr->stack_size,
			(FUNCPTR) rt_thread_routine, (int) l_start, 0, 0, 0, 0, 0, 0, 0, 0, 0);
		Result = (*thread_id == ERROR);
#else
		Result = T_NOT_IMPLEMENTED;
#endif

		if (Result) {
				/* Thread was not launched, we free the allocated memory for `l_start'. */
			eif_free(l_start);
		}
	}

	if (Result) {
		return T_CANNOT_CREATE_THREAD;
	} else {
		return T_OK;
	}
}

/*
doc:	<routine name="eif_pthread_exit" return_type="int" export="public">
doc:		<summary>Exit the current thread using `value_ptr' content as exit value.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="thread_id" type="EIF_THR_TYPE">Thread Identifier of thread being exited.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_exit (EIF_THR_TYPE thread_id)
{
	int Result;
#ifdef EIF_POSIX_THREADS
	pthread_exit(NULL);
	Result = T_OK;
#elif defined(SOLARIS_THREADS)
	thr_exit(NULL);
	Result = T_OK;
#elif defined(EIF_WINDOWS)
	if (!CloseHandle(thread_id)) {
		Result = mapped_errno(GetLastError());
	} else {
		Result = T_OK;
	}
	_endthreadex(0);
#elif defined(VXWORKS)
	if (taskDelete(thread_id) == ERROR) {
		Result = T_CANNOT_TERMINATE_THREAD;
	} else {
		Result = T_OK;
	}
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_kill" return_type="int" export="public">
doc:		<summary>Kill thread `thread_id'. Be careful as if that thread holds some mutex, they won't be unlocked and you could end up in a dead lock situtation.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="thread_id" type="EIF_THR_TYPE">ID of thread to be killed.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_kill (EIF_THR_TYPE thread_id)
{
	int Result;
#ifdef EIF_POSIX_THREADS
	Result = mapped_errno(pthread_kill (thread_id, 9));
#elif defined(SOLARIS_THREADS)
	Result = mapped_errno (thr_kill (thread_id, 9));
#elif defined(EIF_WINDOWS)
	if (TerminateThread (thread_id, 0)) {
		Result = T_OK;
	} else {
		Result = mapped_errno (GetLastError());
	}
#elif defined(VXWORKDS)
	Result = T_NOT_IMPLEMENTED;
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_join" return_type="int" export="public">
doc:		<summary>Wait for thread `thread_id' to finish its execution.</summary>
doc:		<obsolete>Since by default threads are created detached, one cannot call this routine without changing the attachment status of the thread.</obsolete>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="thread_id" type="EIF_THR_TYPE">ID of thread to be joined.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_join (EIF_THR_TYPE thread_id)
{
	int Result;
#ifdef EIF_POSIX_THREADS
	Result = mapped_errno(pthread_join (thread_id, NULL));
#elif defined(SOLARIS_THREADS)
	Result = mapped_errno (thr_join (thread_id, NULL, NULL));
#elif defined(EIF_WINDOWS)
	DWORD ret;
	ret = WaitForSingleObject (thread_id, INFINITE);
	if (ret == WAIT_FAILED) {
		Result = mapped_errno(GetLastError());
	} else if (ret == WAIT_ABANDONED) {
		Result = T_UNKNOWN_ERROR;
	} else {
		Result = T_OK;
	}
#elif defined(VXWORKDS)
	Result = T_NOT_IMPLEMENTED;
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_yield" return_type="int" export="public">
doc:		<summary>Suspend current thread in favor of other running threads.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_yield (void)
{
	int Result;
#ifdef EIF_POSIX_THREADS
#	ifdef _POSIX_PRIORITY_SCHEDULING
		Result = sched_yield();
#	else
		Result = usleep(1);
#	endif
	if (Result) {
		Result = T_CANNOT_YIELD;
	} else {
		Result = T_OK;
	}
#elif defined(SOLARIS_THREADS)
	thr_yield();
	Result = T_OK;
#elif defined(EIF_WINDOWS)
		/* We ignore whether the current thread execution released its execution to another thread or not. */
	(void) SwitchToThread();
	Result = T_OK;
#elif defined(VXWORKS)
	if (taskDelay(1) == ERROR) {
		Result = T_CANNOT_YIELD;
	} else {
		Result = T_OK;
	}
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}

rt_public EIF_THR_TYPE eif_pthread_self()
{
#ifdef EIF_POSIX_THREADS
	return pthread_self();
#elif defined(SOLARIS_THREADS)
	return thr_self();
#elif defined(EIF_WINDOWS)
	return GetCurrentThread();
#elif defined(VXWORKS)
	return taskIdSelf();
#else
	return NULL;
#endif
}

/*
doc:	<routine name="eif_pthread_set_priority" return_type="int" export="public">
doc:		<summary>Set the thread priority of thread `thread_id'. Priorities are in the range EIF_MIN_THR_PRIORITY to EIF_MAX_THR_PRIORITY.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="thread_id" type="EIF_THR_TYPE">ID of thread which will have its priority changed.</param>
doc:		<param name="priority" type="rt_uint_ptr ">New priority.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_set_priority (EIF_THR_TYPE thread_id, rt_uint_ptr priority)
{
	int Result;
#ifdef EIF_POSIX_THREADS
	struct sched_param l_param;
	memset(&l_param, 0, sizeof(struct sched_param));
	l_param.sched_priority = priority;
	Result = pthread_setschedparam(thread_id, SCHED_OTHER, &l_param);
	Result = mapped_errno (Result);
#elif defined(SOLARIS_THREADS)
		/* On Solaris priority goes from 0 to 127. */
	Result = mapped_errno (thr_setprio(thread_id, (int) (priority / 2)));
#elif defined(EIF_WINDOWS)
	int l_win_priority;
	switch (priority) {
		case EIF_MIN_THR_PRIORITY: l_win_priority = THREAD_PRIORITY_LOWEST; break;
		case EIF_MAX_THR_PRIORITY: l_win_priority = THREAD_PRIORITY_HIGHEST; break;
		default:
			if (priority <= EIF_BELOW_NORMAL_THR_PRIORITY) {
				l_win_priority = THREAD_PRIORITY_BELOW_NORMAL;
			} else if (priority < EIF_ABOVE_NORMAL_THR_PRIORITY) {
				l_win_priority = THREAD_PRIORITY_NORMAL;
			} else {
				l_win_priority = THREAD_PRIORITY_ABOVE_NORMAL;
			}
	}
	if (SetThreadPriority(thread_id, l_win_priority)) {
		Result = T_OK;
	} else {
		Result = mapped_errno (GetLastError());
	}
#elif defined(VXWORKS)
		/* On VxWorks, the highest priority is 0, the lowest is 255. So we adapt the given value since
		 * the maximum Eiffel value is also 255 (aka EIF_MAX_THR_PRIORITY) . */
	if (taskPrioritySet(thread_id, 255 - priority) == ERROR) {
			/* Per man page, it it fails it is because it cannot faind the thread. */
		Result = T_NO_THREAD_WITH_ID;
	} else {
		Result = T_OK;
	}
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_get_priority" return_type="int" export="public">
doc:		<summary>Get the thread priority of thread `thread_id' and store it in `priority'. Priorities are in the range EIF_MIN_THR_PRIORITY to EIF_MAX_THR_PRIORITY.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="thread_id" type="EIF_THR_TYPE">ID of thread which will have its priority changed.</param>
doc:		<param name="priority" type="rt_uint_ptr *">Location for storing priority.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_get_priority (EIF_THR_TYPE thread_id, rt_uint_ptr *priority)
{
	int Result;
#ifdef EIF_POSIX_THREADS
	struct sched_param l_param;
	int l_policy;
	Result = pthread_getschedparam(thread_id, &l_policy, &l_param);
	if (Result) {
		Result = mapped_errno(Result);
	} else {
		if (l_policy == SCHED_OTHER) {
			*priority = l_param.sched_priority;
		} else {
			*priority = EIF_DEFAULT_THR_PRIORITY;
		}
		Result = T_OK;
	}
#elif defined(SOLARIS_THREADS)
	int prio;
	Result = thr_getprio(thread_id, &prio);
	if (!Result) {
			/* On Solaris priority goes from 0 to 127. */
		*priority = (rt_uint_ptr) (2 * prio);
	}
	Result = mapped_errno(Result);
#elif defined(EIF_WINDOWS)
	int prio;
	prio = GetThreadPriority(thread_id);
	if (prio == THREAD_PRIORITY_ERROR_RETURN) {
		Result = mapped_errno(GetLastError());
	} else {
		switch (prio) {
			case THREAD_PRIORITY_LOWEST:
			case THREAD_PRIORITY_IDLE:
				*priority = EIF_MIN_THR_PRIORITY; break;
			case THREAD_PRIORITY_BELOW_NORMAL: *priority = EIF_BELOW_NORMAL_THR_PRIORITY; break;
			case THREAD_PRIORITY_NORMAL: *priority = EIF_DEFAULT_THR_PRIORITY; break;
			case THREAD_PRIORITY_ABOVE_NORMAL: *priority = EIF_ABOVE_NORMAL_THR_PRIORITY; break;
			case THREAD_PRIORITY_HIGHEST:
			case THREAD_PRIORITY_TIME_CRITICAL: *priority = EIF_MAX_THR_PRIORITY; break;
			default:
				*priority = EIF_DEFAULT_THR_PRIORITY;
		}
		Result = T_OK;
	}
#elif defined(VXWORKS)
	int prio;
	if (taskPriorityGet(thread_id, &prio) == OK) {
		*priority = prio;
		Result = T_OK;
	} else {
		Result = T_NO_THREAD_WITH_ID;
	}
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}
/*
doc:	<routine name="eif_pthread_mutex_create" return_type="int" export="public">
doc:		<summary>Create a new mutex and assign it to `mutex'. If the creation is successful, caller is responsible to free the memory using `eif_pthread_mutex_destroy'. Mutex are by default recursive.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="mutex" type="EIF_MUTEX_TYPE **">Location where mutex will be stored if successful. Store NULL otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_mutex_create (EIF_MUTEX_TYPE **mutex)
{
	int Result;
#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)
	*mutex = (EIF_MUTEX_TYPE *) eif_malloc(sizeof(EIF_MUTEX_TYPE));
	if (*mutex) {
#ifdef SOLARIS_THREADS
			/* Solaris threads are recursive by default. */
		Result = mapped_errno(pthread_mutex_init(*mutex));
#else
			/* Make the mutex recursive by default. */
		pthread_mutexattr_t attr;
		pthread_mutexattr_init(&attr);
		pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
		Result = mapped_errno(pthread_mutex_init(*mutex,&attr));
		pthread_mutexattr_destroy(&attr);
#endif
		if (Result != T_OK) {
			eif_free(*mutex);
			*mutex = NULL;
		}
	} else {
		Result = T_CANNOT_CREATE_MUTEX;
	}
#elif defined(EIF_WINDOWS)
	Result = eif_pthread_cs_create(mutex, 4000);
#elif defined(VXWORKDS)
	*mutex = semMCreate(SEM_Q_FIFO);
	if (*mutex == NULL) {
		Result = T_CANNOT_CREATE_MUTEX;
	} else {
		Result = T_OK;
	}
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_mutex_destroy" return_type="int" export="public">
doc:		<summary>Destroy and free all resources used by `mutex'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="mutex" type="EIF_MUTEX_TYPE *">Mutex.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_mutex_destroy (EIF_MUTEX_TYPE *mutex)
{
	int Result;
	if (mutex) {
#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)
		Result = mapped_errno(pthread_mutex_destroy (mutex));
		eif_free (mutex);
#elif defined(EIF_WINDOWS)
		Result = eif_pthread_cs_destroy(mutex);
#elif defined(VXWORKS)
		if (semDelete(mutex) != OK) {
			Result = T_CANNOT_DESTROY_MUTEX;
		} else {
			Result = T_OK;
		}
#else
		Result = T_NOT_IMPLEMENTED;
#endif
	} else {
		Result = T_INVALID_ARGUMENT;
	}
	return Result;
}

/*
doc:	<routine name="eif_pthread_mutex_lock" return_type="int" export="public">
doc:		<summary>Lock `mutex'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="mutex" type="EIF_MUTEX_TYPE *">Mutex.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_mutex_lock (EIF_MUTEX_TYPE *mutex)
{
	int Result;
#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)
	Result = mapped_errno(pthread_mutex_lock (mutex));
#elif defined(EIF_WINDOWS)
	Result = eif_pthread_cs_lock(mutex);
#elif defined(VXWORKS)
	if (semTake(mutex, WAIT_FOREVER) == OK) {
		Result = T_OK;
	} else {
		Result = T_UNKNOWN_ERROR;
	}
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_mutex_trylock" return_type="int" export="public">
doc:		<summary>Lock `mutex'.</summary>
doc:		<return>T_OK on success, T_BUSY when already locked, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="mutex" type="EIF_MUTEX_TYPE *">Mutex.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_mutex_trylock (EIF_MUTEX_TYPE *mutex)
{
	int Result;
#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)
	Result = mapped_errno(pthread_mutex_trylock (mutex));
#elif defined(EIF_WINDOWS)
	Result = eif_pthread_cs_trylock(mutex);
#elif defined(VXWORKS)
	Result = semTake(mutex, NO_WAIT);
	if (Result == OK) {
		Result = T_OK;
	} else if (errno == S_objLib_OBJ_TIMEOUT) {
		Result = T_BUSY;
	} else {
		Result = T_UNKNOWN_ERROR;
	}
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_mutex_unlock" return_type="int" export="public">
doc:		<summary>Unlock `mutex'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="mutex" type="EIF_MUTEX_TYPE *">Mutex.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_mutex_unlock (EIF_MUTEX_TYPE *mutex)
{
	int Result;
#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)
	Result = mapped_errno(pthread_mutex_unlock (mutex));
#elif defined(EIF_WINDOWS)
	Result = eif_pthread_cs_unlock(mutex);
#elif defined(VXWORKS)
	Result = semGive(mutex);
	if (Result == OK) {
		Result = T_OK;
	} else {
		Result = T_UNKNOWN_ERROR;
	}
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_sem_create" return_type="int" export="public">
doc:		<summary>Create a new semaphore with a starting value of `count'. If `shared' is non-zero, the semaphore is shared between processes. If the creation is successful, caller is responsible to free the memory using `eif_pthread_sem_destroy'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="sem" type="EIF_SEM_TYPE **">Location where semaphore will be stored if successful. Store NULL otherwise.</param>
doc:		<param name="shared" type="int">Is `sem' to be shared between processes?</param>
doc:		<param name="count" type="unsigned int">Initial count of semaphore.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_sem_create (EIF_SEM_TYPE **sem, int shared, unsigned int count)
{
	int Result;
#ifdef EIF_POSIX_THREADS
	*sem = (EIF_SEM_TYPE *) eif_malloc (sizeof(EIF_SEM_TYPE));
	if (*sem) {
		Result = sem_init(*sem, shared, count);
		if (Result) {
			Result = mapped_errno(errno);
			eif_free(*sem);
			*sem = NULL;
		}
	} else {
		Result = T_CANNOT_CREATE_SEMAPHORE;
	}
#elif defined(SOLARIS_THREADS)
	*sem = (EIF_SEM_TYPE *) eif_malloc (sizeof(EIF_SEM_TYPE));
	if (*sem) {
		if (shared) {
			Result = mapped_errno(sema_init(*sem,count,USYNC_PROCESS, NULL));
		} else {
			Result = mapped_errno(sema_init(*sem,count,USYNC_THREAD, NULL));
		}
		if (Result != T_OK) {
			eif_free(*sem);
			*sem = NULL;
		}
	} else {
		Result = T_CANNOT_CREATE_SEMAPHORE;
	}
#elif defined(EIF_WINDOWS)
	if (shared) {
		Result = T_UNSUPPORTED;
	} else {
		*sem = CreateSemaphore(NULL, (LONG) count, (LONG) 0x7fffffff, NULL);
		if (*sem) {
			Result = T_OK;
		} else {
			Result = mapped_errno(GetLastError());
		}
	}
#elif defined(VXWORKS)
	if (shared) {
		Result = T_UNSUPPORTED;
	} else {
		*sem = semCCreate (SEM_Q_FIFO, count);
		if (*sem) {
			Result = T_OK;
		} else {
			Result = T_CANNOT_CREATE_SEMAPHORE;
		}
	}
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_sem_destroy" return_type="int" export="public">
doc:		<summary>Destroy and free all resources used by `sem'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="sem" type="EIF_SEM_TYPE *">Mutex.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_sem_destroy (EIF_SEM_TYPE *sem)
{
	int Result;
	if (sem) {
#ifdef EIF_POSIX_THREADS
		if (sem_destroy (sem)) {
			Result = mapped_errno(errno);
		} else {
			Result = T_OK;
		}
		eif_free (sem);
#elif defined(SOLARIS_THREADS)
		Result = mapped_errno(sema_destroy(sem));
#elif defined(EIF_WINDOWS)
		if (!CloseHandle(sem)) {
			Result = mapped_errno(GetLastError());
		} else {
			Result = T_OK;
		}
#elif defined(VXWORKS)
		if (semDelete(sem) != OK) {
			Result = T_CANNOT_DESTROY_SEMAPHORE;
		} else {
			Result = T_OK;
		}
#else
		Result = T_NOT_IMPLEMENTED;
#endif
	} else {
		Result = T_INVALID_ARGUMENT;
	}
	return Result;
}

/*
doc:	<routine name="eif_pthread_sem_post" return_type="int" export="public">
doc:		<summary>Increments (unlocks) the semaphore count pointed to by `sem'. If the semaphore's value becomes greater than zero, then another process or thread blocked in a `eif_pthread_sem_wait' call will be woken up and proceed to lock the semaphore. If the creation is successful, caller is responsible to free the memory using `eif_pthread_sem_destroy'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="sem" type="EIF_SEM_TYPE **">Location where semaphore will be stored if successful. Store NULL otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_sem_post (EIF_SEM_TYPE *sem)
{
	int Result;
#ifdef EIF_POSIX_THREADS
	if (sem_post(sem)) {
		Result = mapped_errno(errno);
	} else {
		Result = T_OK;
	}
#elif defined(SOLARIS_THREADS)
	Result = mapped_errno(sema_post(sem));
#elif defined(EIF_WINDOWS)
	if (!ReleaseSemaphore(sem, 1, NULL)) {
		Result = mapped_errno(GetLastError());
	} else {
		Result = T_OK;
	}
#elif defined(VXWORKS)
	if (semGive(sem) == OK) {
		Result = T_OK;
	} else {
		Result = T_UNKNOWN_ERROR;
	}
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_sem_wait" return_type="int" export="public">
doc:		<summary>Increments (unlocks) the semaphore count pointed to by `sem'. If the semaphore's value becomes greater than zero, then another process or thread blocked in a `eif_pthread_sem_wait' call will be woken up and proceed to lock the semaphore. If the creation is successful, caller is responsible to free the memory using `eif_pthread_sem_destroy'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="sem" type="EIF_SEM_TYPE **">Location where semaphore will be stored if successful. Store NULL otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_sem_wait (EIF_SEM_TYPE *sem)
{
	int Result;
#ifdef EIF_POSIX_THREADS
	if (sem_wait(sem)) {
		Result = mapped_errno(errno);
	} else {
		Result = T_OK;
	}
#elif defined(SOLARIS_THREADS)
	Result = mapped_errno(sema_wait(sem));
#elif defined(EIF_WINDOWS)
	DWORD ret;
	ret = WaitForSingleObject(sem, INFINITE);
	if (ret == WAIT_FAILED) {
		Result = mapped_errno(GetLastError());
	} else if (ret == WAIT_ABANDONED) {
		Result = T_UNKNOWN_ERROR;
	} else {
		Result = T_OK;
	}
#elif defined(VXWORKS)
	if (semTake(sem, WAIT_FOREVER) == OK) {
		Result = T_OK;
	} else {
		Result = T_UNKNOWN_ERROR;
	}
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_sem_wait_with_timeout" return_type="int" export="rt_private">
doc:		<summary>Increments (unlocks) the semaphore count pointed to by `sem'. If the semaphore's value becomes greater than zero, then another process or thread blocked in a `eif_pthread_sem_wait' call will be woken up and proceed to lock the semaphore. If the creation is successful, caller is responsible to free the memory using `eif_pthread_sem_destroy'. This external is currently private because not all our platforms support it (e.g. Solaris 9 or older) and it is only for implementing condition variable and it turns out that those have this implemented.</summary>
doc:		<return>T_OK on success, T_TIMEDOUT when `timeout' is reached, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="sem" type="EIF_SEM_TYPE **">Location where semaphore will be stored if successful. Store NULL otherwise.</param>
doc:		<param name="timeout" type="rt_uint_ptr">Timeout in milliseconds.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_private int eif_pthread_sem_wait_with_timeout (EIF_SEM_TYPE *sem, rt_uint_ptr timeout)
{
	int Result;
#ifdef EIF_POSIX_THREADS
#if defined(__SunOS_5_8) || defined (__SunOS_5_9)
	Result = T_NOT_IMPLEMENTED;
#else
	struct timespec tspec = rt_timeout_to_timespec(timeout);
	if (sem_timedwait(sem, &tspec)) {
		Result = mapped_errno(errno);
	} else {
		 Result = T_OK;
	}
#endif
#elif defined(SOLARIS_THREADS)
#if defined(__SunOS_5_8) || defined (__SunOS_5_9)
	Result = T_NOT_IMPLEMENTED;
#else
	struct timespec tspec = rt_timeout_to_timespec(timeout);
	Result = mapped_errno(sema_timedwait(sem, &tspec));
#endif
#elif defined(EIF_WINDOWS)
	DWORD ret;
	ret = WaitForSingleObject(sem, (DWORD) timeout);
	if (ret == WAIT_FAILED) {
		Result = mapped_errno(GetLastError());
	} else if (ret == WAIT_ABANDONED) {
		Result = T_UNKNOWN_ERROR;
	} else if (ret == WAIT_TIMEOUT) {
		Result = T_TIMEDOUT;
	} else {
		Result = T_OK;
	}
#elif defined(VXWORKS)
	int nb_ticks = (int) (((EIF_NATURAL_64) timeout * (EIF_NATURAL_64) sysClkRateGet())/1000);
	Result = semTake(sem, nb_ticks);
	if (Result == OK) {
		Result = T_OK;
	} else if (errno == S_objLib_OBJ_TIMEOUT) {
		Result = T_TIMEDOUT;
	} else {
		Result = T_UNKNOWN_ERROR;
	}
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}


/*
doc:	<routine name="eif_pthread_sem_trywait" return_type="int" export="public">
doc:		<summary>Increments (unlocks) the semaphore count pointed to by `sem'. If the semaphore's value becomes greater than zero, then another process or thread blocked in a `eif_pthread_sem_wait' call will be woken up and proceed to lock the semaphore. If the creation is successful, caller is responsible to free the memory using `eif_pthread_sem_destroy'.</summary>
doc:		<return>T_OK on success, T_BUSY if semaphore has a 0 count, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="sem" type="EIF_SEM_TYPE **">Location where semaphore will be stored if successful. Store NULL otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_sem_trywait (EIF_SEM_TYPE *sem)
{
	int Result;
#ifdef EIF_POSIX_THREADS
	if (sem_trywait(sem)) {
		Result = mapped_errno(errno);
		if (Result == T_TRY_AGAIN) {
			Result = T_BUSY;
		}
	} else {
		Result = T_OK;
	}
#elif defined(SOLARIS_THREADS)
	Result = mapped_errno(sema_trywait(sem));
#elif defined(EIF_WINDOWS)
	DWORD ret;
	ret = WaitForSingleObject(sem, 0);
	if (ret == WAIT_FAILED) {
		Result = mapped_errno(GetLastError());
	} else if (ret == WAIT_ABANDONED) {
		Result = T_UNKNOWN_ERROR;
	} else if (ret == WAIT_TIMEOUT) {
		Result = T_BUSY;
	} else {
		Result = T_OK;
	}
#elif defined(VXWORKS)
	Result = semTake(sem, NO_WAIT);
	if (Result == OK) {
		Result = T_OK;
	} else if (errno == S_objLib_OBJ_TIMEOUT) {
		Result = T_BUSY;
	} else {
		Result = T_UNKNOWN_ERROR;
	}
#else
	Result = T_NOT_IMPLEMENTED;
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_cond_create" return_type="int" export="public">
doc:		<summary>Create a new condition variable and set `condvar' to the newly created condition variable. If the creation is successful, caller is responsible to free the memory using `eif_pthread_cond_destroy'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="condvar" type="EIF_COND_TYPE **">Location where condition variable will be stored if successful. Store NULL otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_cond_create (EIF_COND_TYPE ** condvar)
{
	int Result;
	*condvar = (EIF_COND_TYPE *) eif_malloc (sizeof(EIF_COND_TYPE));
	if (*condvar) {
#ifdef EIF_NO_NATIVE_COND
		memset(*condvar, 0, sizeof(EIF_COND_TYPE));
		Result = eif_pthread_sem_create(&((*condvar)->semaphore), 0, 0);
		if (Result == T_OK) {
			Result = eif_pthread_cs_create(&((*condvar)->csection), 100);
			if (Result != T_OK) {
				Result = eif_pthread_sem_destroy((*condvar)->semaphore);
				Result = T_CANNOT_CREATE_CONDVAR;
			}
		}
#else
		Result = pthread_cond_init (*condvar, NULL);
#endif
		if (Result) {
			eif_free(*condvar);
			*condvar = NULL;
			Result = mapped_errno (Result);
		} else {
			Result = T_OK;
		}
	} else {
		Result = T_CANNOT_CREATE_CONDVAR;
	}
	return Result;
}

/*
doc:	<routine name="eif_pthread_cond_destroy" return_type="int" export="public">
doc:		<summary>Destroy and free all resources used by `condvar'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="condvar" type="EIF_COND_TYPE *">Condition variable.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_cond_destroy (EIF_COND_TYPE *condvar)
{
	int Result;
	if (condvar) {
#ifdef EIF_NO_NATIVE_COND
		Result = eif_pthread_sem_destroy(condvar->semaphore);
		if (Result == T_OK) {
			Result = eif_pthread_cs_destroy(condvar->csection);
		}
		memset(condvar, 0, sizeof(EIF_COND_TYPE));
#else
		Result = mapped_errno (pthread_cond_destroy (condvar));
#endif
		eif_free (condvar);
	} else {
		Result = T_INVALID_ARGUMENT;
	}
	return Result;
}

/*
doc:	<routine name="eif_pthread_cond_wait" return_type="int" export="public">
doc:		<summary>Block current thread on the `condvar' condition variable. `mutex' has to be locked otherwise undefined behavior will result.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="condvar" type="EIF_COND_TYPE *">Condition variable.</param>
doc:		<param name="mutex" type="EIF_MUTEX_TYPE *">Associated mutex.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_cond_wait (EIF_COND_TYPE *condvar, EIF_MUTEX_TYPE *mutex)
{
	int Result;
#ifdef EIF_NO_NATIVE_COND
#ifdef VXWORKS
	Result = eif_pthread_cond_wait_with_timeout(condvar, mutex, WAIT_FOREVER);
#elif defined(EIF_WINDOWS)
	Result = eif_pthread_cond_wait_with_timeout(condvar, mutex, INFINITE);
#else
	Result = T_NOT_IMPLEMENTED;
#endif
#else
	Result = mapped_errno (pthread_cond_wait (condvar, mutex));
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_cond_wait_with_timeout" return_type="int" export="public">
doc:		<summary>Block current thread on the `condvar' condition variable for at most `timeout' milliseconds. `mutex' has to be locked otherwise undefined behavior will result.</summary>
doc:		<return>T_OK on success, T_TIMEDOUT after waiting `timeout' milliseconds, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="condvar" type="EIF_COND_TYPE *">Condition variable.</param>
doc:		<param name="mutex" type="EIF_MUTEX_TYPE *">Associated mutex.</param>
doc:		<param name="timeout" type="rt_uint_ptr">Timeout in milliseconds.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_cond_wait_with_timeout (EIF_COND_TYPE *condvar, EIF_MUTEX_TYPE *mutex, rt_uint_ptr timeout)
{
	int Result;
#ifdef EIF_NO_NATIVE_COND
	unsigned int wake = 0;
	unsigned long generation;

		/* Avoid race conditions. */
	(void) eif_pthread_cs_lock(condvar->csection);
	condvar->num_waiting++;
	generation = condvar->generation;
	(void) eif_pthread_cs_unlock(condvar->csection);

	Result = T_UNKNOWN_ERROR;
	eif_pthread_mutex_unlock(mutex);

	for (;;) {
		Result = eif_pthread_sem_wait_with_timeout(condvar->semaphore, timeout);	

		(void) eif_pthread_cs_lock(condvar->csection);

		if (condvar->num_wake) {
			if (condvar->generation != generation) {
				condvar->num_wake--;
				condvar->num_waiting--;
				Result = T_OK;
				break;
			} else {
				wake = 1;
			}
		} else if (Result == T_TIMEDOUT) {
			condvar->num_waiting--;
			break;
		}

		(void) eif_pthread_cs_unlock(condvar->csection);

		if (wake) {
			wake = 0;
			eif_pthread_sem_post(condvar->semaphore);
		}
	}

	(void) eif_pthread_cs_unlock(condvar->csection);
	eif_pthread_mutex_lock(mutex);
#else
	struct timespec tspec = rt_timeout_to_timespec(timeout);
	Result = mapped_errno (pthread_cond_timedwait (condvar, mutex, &tspec));
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_cond_signal" return_type="int" export="public">
doc:		<summary>Unblocks at least one of the threads currently blocked on the specified condition variable `condvar'. If more than one thread is blocked on a condition variable, the scheduling policy determines the order in which threads are unblocked.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="condvar" type="EIF_COND_TYPE *">Condition variable.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_cond_signal (EIF_COND_TYPE *condvar)
{
	int Result;
#ifdef EIF_NO_NATIVE_COND
	unsigned int wake = 0;
	Result = eif_pthread_cs_lock(condvar->csection);
	if (Result == T_OK) {
			/* Do nothing if they are more signaled ones than awaiting threads. */
		if (condvar->num_waiting > condvar->num_wake) {
			wake = 1;
			condvar->num_wake++;
			condvar->generation++;
		}
		Result = eif_pthread_cs_unlock(condvar->csection);
		if ((Result == T_OK) && wake) {
			Result = eif_pthread_sem_post(condvar->semaphore);
		}
	}
#else
	Result = mapped_errno (pthread_cond_signal (condvar));
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_cond_broadcast" return_type="int" export="public">
doc:		<summary>Unblocks all threads currently blocked on the specified condition variable `condvar'. If more than one thread is blocked on a condition variable, the scheduling policy determines the order in which threads are unblocked.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="condvar" type="EIF_COND_TYPE *">Condition variable.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_cond_broadcast (EIF_COND_TYPE *condvar)
{
	int Result;
#ifdef EIF_NO_NATIVE_COND
	unsigned long num_wake = 0;

	Result = eif_pthread_cs_lock(condvar->csection);
	if (Result == T_OK) {
		if (condvar->num_waiting > condvar->num_wake) {
			num_wake = condvar->num_waiting - condvar->num_wake;
			condvar->num_wake = condvar->num_waiting;
			condvar->generation++;
		}
		Result = eif_pthread_cs_unlock(condvar->csection);
		while ((Result == T_OK) && num_wake) {
			Result = eif_pthread_sem_post(condvar->semaphore);
			num_wake--;
		}
	}
#else
	Result = mapped_errno (pthread_cond_broadcast (condvar));
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_rwlock_create" return_type="int" export="public">
doc:		<summary>Create a new Read/Write lock and assign it to `rwlp'. If the creation is successful, caller is responsible to free the memory using `eif_pthread_rwlock_destroy'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="rwlp" type="EIF_RWL_TYPE **">Pointer to read/write lock structure to be initalized.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

rt_public int eif_pthread_rwlock_create(EIF_RWL_TYPE **rwlp)
{
	int Result;
	*rwlp = (EIF_RWL_TYPE *) eif_malloc (sizeof(EIF_RWL_TYPE));
	if (*rwlp) {
#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)
		Result = mapped_errno(pthread_rwlock_init(*rwlp, NULL));
#else
		EIF_MUTEX_TYPE *m;
		EIF_COND_TYPE *readers_ok, *writers_ok;

		if (eif_pthread_mutex_create(&m) == T_OK) {
			if (eif_pthread_cond_create(&readers_ok) == T_OK) {
				if (eif_pthread_cond_create(&writers_ok) == T_OK) {
					(*rwlp)->m = m;
					(*rwlp)->readers_ok = readers_ok;
					(*rwlp)->writers_ok = writers_ok;
					(*rwlp)->rwlock = 0; 
					(*rwlp)->waiting_writers = 0; 
					Result = T_OK;
				} else {
					RT_TRACE(eif_pthread_cond_destroy(readers_ok));
					RT_TRACE(eif_pthread_mutex_destroy(m));
					Result = T_CANNOT_CREATE_RWLOCK;
				}
			} else {
				RT_TRACE(eif_pthread_mutex_destroy(m));
				Result = T_CANNOT_CREATE_RWLOCK;
			}
		} else {
			Result = T_CANNOT_CREATE_RWLOCK;
		}
		if (Result) {
			eif_free(*rwlp);
			*rwlp = NULL;
		}
#endif
	} else {
		Result = T_CANNOT_CREATE_RWLOCK;
	}
	return Result;
} 

/*
doc:	<routine name="eif_pthread_rwlock_destroy" return_type="int" export="public">
doc:		<summary>Destroy a read/write lock.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="rwlp" type="EIF_RWL_TYPE *">Pointer to read/write lock structure to be destroyed.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

rt_public int eif_pthread_rwlock_destroy (EIF_RWL_TYPE *rwlp)
{
	int Result;
	if (rwlp) {
#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)
		Result = mapped_errno(pthread_rwlock_destroy(rwlp));
#else
		if (eif_pthread_mutex_destroy(rwlp->m) == T_OK) {
			if (eif_pthread_cond_destroy(rwlp->readers_ok) == T_OK) {
				Result = eif_pthread_cond_destroy(rwlp->writers_ok);
			} else {
				Result = T_CANNOT_DESTROY_RWLOCK;
			}
		} else {
			Result = T_CANNOT_DESTROY_RWLOCK;
		}
		memset(rwlp, 0, sizeof(EIF_RWL_TYPE));
#endif
		eif_free(rwlp);
	} else {
		Result = T_INVALID_ARGUMENT;
	}
	return Result;
}

/*
doc:	<routine name="eif_pthread_rwlock_rdlock" return_type="int" export="public">
doc:		<summary>Acquire a read lock. Multiple readers can go if there are no writer.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="rwlp" type="EIF_RWL_TYPE *">Pointer to read/write lock structure to be locked.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

rt_public int eif_pthread_rwlock_rdlock (EIF_RWL_TYPE *rwlp)
{
	int Result;
#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)
	Result = mapped_errno(pthread_rwlock_rdlock(rwlp));
#else
	Result = eif_pthread_mutex_lock(rwlp->m);
	if (Result == T_OK) {
		while ((rwlp->rwlock < 0 || rwlp->waiting_writers) && (Result == T_OK)) {
			Result = eif_pthread_cond_wait(rwlp->readers_ok, rwlp->m);
		}
		if (Result == T_OK) {
			rwlp->rwlock++;
		}
		Result = eif_pthread_mutex_unlock(rwlp->m);
	}
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_rwlock_tryrdlock" return_type="int" export="public">
doc:		<summary>Try to acquire a read lock. Multiple readers can go if there are no writer.</summary>
doc:		<return>T_OK on success, T_BUSY when lock failed and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="rwlp" type="EIF_RWL_TYPE *">Pointer to read/write lock structure to be locked.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

rt_public int eif_pthread_rwlock_tryrdlock (EIF_RWL_TYPE *rwlp)
{
	int Result;
#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)
	Result = mapped_errno(pthread_rwlock_tryrdlock(rwlp));
#else
	int other_result;
	Result = eif_pthread_mutex_lock(rwlp->m);
	if (Result == T_OK) {
		while ((rwlp->rwlock < 0 || rwlp->waiting_writers) && (Result == T_OK)) {
			Result = eif_pthread_cond_wait_with_timeout(rwlp->readers_ok, rwlp->m, 0);
		}
		if (Result == T_OK) {
			rwlp->rwlock++;
		}
		other_result = eif_pthread_mutex_unlock(rwlp->m);
		if (other_result != T_OK) {
			Result = other_result;
		} else if (Result == T_TIMEDOUT) {
			Result = T_BUSY;
		}
	}
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_rwlock_wrlock" return_type="int" export="public">
doc:		<summary>Acquire a write lock. Only a single write can proceed.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="rwlp" type="EIF_RWL_TYPE *">Pointer to read/write lock structure to be locked.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

rt_public int eif_pthread_rwlock_wrlock (EIF_RWL_TYPE *rwlp)
{
	int Result;
#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)
	Result = mapped_errno(pthread_rwlock_wrlock(rwlp));
#else
	Result = eif_pthread_mutex_lock(rwlp->m);
	if (Result == T_OK) {
		while ((rwlp->rwlock != 0) && (Result == T_OK)) {
			rwlp->waiting_writers++;
			Result = eif_pthread_cond_wait(rwlp->writers_ok, rwlp->m);
			rwlp->waiting_writers--;
		}
		if (Result == T_OK) {
			rwlp->rwlock = -1;
		}
		Result = eif_pthread_mutex_unlock(rwlp->m);
	}
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_rwlock_trywrlock" return_type="int" export="public">
doc:		<summary>Acquire a write lock. Only a single write can proceed.</summary>
doc:		<return>T_OK on success, T_BUSY when lock failed, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="rwlp" type="EIF_RWL_TYPE *">Pointer to read/write lock structure to be locked.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

rt_public int eif_pthread_rwlock_trywrlock (EIF_RWL_TYPE *rwlp)
{
	int Result;
#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)
	Result = mapped_errno(pthread_rwlock_trywrlock(rwlp));
#else
	int other_result;
	Result = eif_pthread_mutex_lock(rwlp->m);
	if (Result == T_OK) {
		while ((rwlp->rwlock != 0) && (Result == T_OK)) {
			rwlp->waiting_writers++;
			Result = eif_pthread_cond_wait_with_timeout(rwlp->writers_ok, rwlp->m, 0);
			rwlp->waiting_writers--;
		}
		if (Result == T_OK) {
			rwlp->rwlock = -1;
		}
		other_result = eif_pthread_mutex_unlock(rwlp->m);
		if (other_result != T_OK) {
			Result = other_result;
		} else if (Result == T_TIMEDOUT) {
			Result = T_BUSY;
		}
	}
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_rwlock_unlock" return_type="int" export="public">
doc:		<summary>Unlock a read or write lock.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="rwlp" type="EIF_RWL_TYPE *">Pointer to read/write lock structure to be unlocked.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/

rt_public int eif_pthread_rwlock_unlock (EIF_RWL_TYPE *rwlp)
{
	int Result;
#if defined(EIF_POSIX_THREADS) || defined(SOLARIS_THREADS)
	Result = mapped_errno(pthread_rwlock_unlock(rwlp));
#else
	int ww, wr;

	Result = eif_pthread_mutex_lock(rwlp->m);
	if (Result == T_OK) {
			/* rwlock < 0 iflocked for writing */
		if (rwlp->rwlock < 0) {
			rwlp->rwlock = 0;
		} else {
			rwlp->rwlock--;
		}

			/* Keep flags that show if there are waiting readers or writers
			 * so that we can wake them up outside the mocitor lock. */
		ww = (rwlp->waiting_writers && rwlp->rwlock == 0);
		wr = (rwlp->waiting_writers == 0);

		Result = eif_pthread_mutex_unlock(rwlp->m);
		if (Result == T_OK) {
				/* Wake up a waiting writer first. Otherwise wake up all readers. */
			if (ww) { 
				Result = eif_pthread_cond_signal(rwlp->writers_ok);
			} else if (wr) { 
				Result = eif_pthread_cond_broadcast(rwlp->readers_ok);
			}
		}
	}
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_cs_create" return_type="int" export="public">
doc:		<summary>Create a new critical section and assign it to `section' using `spin_count' has number of times to spin before performing a slow synchronization. If the creation is successful, caller is responsible to free the memory using `eif_pthread_cs_destroy'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="section" type="EIF_CS_TYPE **">Location where section will be stored if successful. Store NULL otherwise.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_cs_create (EIF_CS_TYPE **section, rt_uint_ptr spin_count)
{
	int Result;
#if defined(SOLARIS_THREADS) || defined(EIF_WINDOWS)
	*section = (EIF_CS_TYPE *) eif_malloc(sizeof(EIF_CS_TYPE));
	if (*section) {
#ifdef EIF_SOLARIS
		memset(*section, 0, sizeof(EIF_CS_TYPE));
#elif defined(EIF_WINDOWS)
		InitializeCriticalSectionAndSpinCount(*section, (DWORD) spin_count);
#endif
		Result = T_OK;
	} else {
		Result = T_CANNOT_CREATE_CRITICAL_SECTION;
	}
#else
	Result = eif_pthread_mutex_create(section);
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_cs_destroy" return_type="int" export="public">
doc:		<summary>Destroy and free all resources used by `section'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="section" type="EIF_CS_TYPE *">Mutex.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_cs_destroy (EIF_CS_TYPE *section)
{
	int Result;
#if defined(SOLARIS_THREADS) || defined(EIF_WINDOWS)
	if (section) {
#ifdef EIF_WINDOWS 
		DeleteCriticalSection(section);
#endif
		eif_free (section);
		Result = T_OK;
	} else {
		Result = T_INVALID_ARGUMENT;
	}
#else
	Result = eif_pthread_mutex_destroy(section);	
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_cs_lock" return_type="int" export="public">
doc:		<summary>Lock `section'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="section" type="EIF_CS_TYPE *">Mutex.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_cs_lock (EIF_CS_TYPE *section)
{
	int Result;
#ifdef SOLARIS_THREADS
	Result = mapped_errno(_lwp_mutex_lock(section));
#elif defined(EIF_WINDOWS)
	EnterCriticalSection(section);
	Result = T_OK;
#else
	Result = eif_pthread_mutex_lock(section);	
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_cs_trylock" return_type="int" export="public">
doc:		<summary>Lock `section'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="section" type="EIF_CS_TYPE *">Mutex.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_cs_trylock (EIF_CS_TYPE *section)
{
	int Result;
#ifdef SOLARIS_THREADS
	Result = mapped_errno(_lwp_mutex_trylock(section));
#elif defined(EIF_WINDOWS)
	if (TryEnterCriticalSection(section)) {
		Result = T_OK; 
	} else {
		Result = T_BUSY;
	}
#else
	Result = eif_pthread_mutex_trylock(section);	
#endif
	return Result;
}

/*
doc:	<routine name="eif_pthread_cs_unlock" return_type="int" export="public">
doc:		<summary>Unock `section'.</summary>
doc:		<return>T_OK on success, and specific error otherwise (see eif_error.h for details).</return>
doc:		<param name="section" type="EIF_CS_TYPE *">Mutex.</param>
doc:		<thread_safety>Safe</thread_safety>
doc:		<synchronization>None</synchronization>
doc:	</routine>
*/
rt_public int eif_pthread_cs_unlock (EIF_CS_TYPE *section)
{
	int Result;
#ifdef SOLARIS_THREADS
	Result = mapped_errno(_lwp_mutex_unlock(section));
#elif defined(EIF_WINDOWS)
	LeaveCriticalSection(section);
	Result = T_OK;
#else
	Result = eif_pthread_mutex_unlock(section);	
#endif
	return Result;
}

#endif

/*
doc:</file>
*/
