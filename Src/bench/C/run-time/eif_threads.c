/*

 ######    #    ######
 #         #    #
 #####     #    #####
 #         #    #
 #         #    #
 ######    #    #      #######

 #####  #    #  #####   ######    ##    #####    ####           ####
   #    #    #  #    #  #        #  #   #    #  #              #    #
   #    ######  #    #  #####   #    #  #    #   ####          #
   #    #    #  #####   #       ######  #    #       #   ###   #
   #    #    #  #   #   #       #    #  #    #  #    #   ###   #    #
   #    #    #  #    #  ######  #    #  #####    ####    ###    ####

	Thread management routines.

*/

#include "config.h"
#include "eiffel.h"
#include "eif_threads.h"
#include "eif_globals.h"
#include "err_msg.h"
#include "hector.h"      /* for efreeze() and eufreeze() */
#include "sig.h"

#ifdef EIF_THREADS


rt_public void eif_thr_panic(char *);
rt_public void eif_thr_init_root(void);
rt_public void eif_thr_register(void);
rt_public unsigned int eif_thr_is_initialized(void);
rt_public void eif_thr_create(EIF_OBJ, EIF_PROC);
rt_public void eif_thr_create_with_args(EIF_OBJ, EIF_PROC,
										EIF_INTEGER, EIF_INTEGER);
rt_public void eif_thr_exit(void);

rt_public EIF_MUTEX_TYPE *eif_thr_mutex_create(void);
rt_public void eif_thr_mutex_lock(EIF_MUTEX_TYPE *);
rt_public void eif_thr_mutex_unlock(EIF_MUTEX_TYPE *);
rt_public EIF_BOOLEAN eif_thr_mutex_trylock(EIF_MUTEX_TYPE *);

rt_public EIF_POINTER eif_thr_proxy_set(EIF_REFERENCE);
rt_public EIF_REFERENCE eif_thr_proxy_access(EIF_POINTER);
rt_public void eif_thr_proxy_dispose(EIF_POINTER);

rt_private void eif_init_context(eif_global_context_t *);
rt_private EIF_THR_ENTRY_TYPE eif_thr_entry(EIF_THR_ENTRY_ARG_TYPE);

rt_public EIF_TSD_TYPE eif_global_key;
rt_public EIF_MUTEX_TYPE *eif_rmark_mutex;
#ifndef EIF_NO_JOIN_ALL
rt_public EIF_MUTEX_TYPE *eif_children_mutex;
#endif

rt_public void eif_thr_init_root(void) 
{
	/*
	 * This function must be called once and only once at the very beginning
	 * of an Eiffel program (typically from main()) or the first time a thread
	 * initializes the Eiffel run-time if it is part of a Cecil system.
	 * The global key for Thread Specific Data is initialized: this variable
	 * is shared by all the threads, but it allows them to fetch a pointer
	 * to their own context (eif_globals structure).
	 * A mutex "for inter-GC recursive marking" is created: eif_rmark_mutex.
	 * The mutex that protects the access to the variable n_children is also
	 * created except for platforms that don't need our implementation of
	 * `join_all'.
	 * NB: I'm not sure of the utility of eif_rmark_mutex(c)ZS --PCV
	 */

	EIF_TSD_CREATE(eif_global_key,"Couldn't create global key for root thread");
	EIF_MUTEX_CREATE(eif_rmark_mutex,"Couldn't inter-GC mutex");
#ifndef EIF_NO_JOIN_ALL
	EIF_MUTEX_CREATE(eif_children_mutex,"Couldn't create n_children mutex");
#endif
	eif_thr_register();
}

rt_public void eif_thr_register(void)
{
	/*
	 * Allocates memory for the eif_globals structure, initializes it
	 * and makes it part of the Thread Specific Data (TSD).
	 * Allocates memory for non-root threads
	 */

	static once = 0;	/* For initial eif_thread, we don't know how
						 * many once values we have to allocate */

	eif_global_context_t *eif_globals;

	eif_globals = (eif_global_context_t *)malloc(sizeof(eif_global_context_t));
	if (!eif_globals) eif_thr_panic("No more memory for thread context");
	eif_init_context(eif_globals);
	EIF_TSD_SET(eif_global_key,eif_globals,"Couldn't bind context to TSD.");

	if (once) {
	  /*
	   * Allocate room for once values for all threads but the initial 
	   * because we do not have the number of onces yet
	   */

		EIF_once_values = (char **) cmalloc (EIF_once_count * sizeof (char *));
		if (EIF_once_values == (char **) 0) /* Out of memory */
			enomem();
		bzero((char *) EIF_once_values, EIF_once_count * sizeof (char *));
	} else 
		once = 1;
}

rt_public unsigned int eif_thr_is_initialized()
{
	/*
	 * Returns a non null value if the calling thread is initialized for
	 * Eiffel, null otherwise.
	 */

#ifndef VXWORKS
  eif_global_context_t *x;
#endif

#ifdef EIF_WIN32
  /* On windows, GetLastError() yields NO_ERROR if such key was initialized */
  EIF_TSD_GET0 ((eif_global_context_t *),eif_global_key,x);
  return (GetLastError() == NO_ERROR);

#elif defined VXWORKS
  /* On VXWORKS, eif_global_key holds a pointer to eif_globals. If the
	 thread isn't initialized, eif_global_key == 0 */
  return (eif_global_key != (EIF_TSD_TYPE) 0);

#elif defined EIF_POSIX_THREADS
#ifdef EIF_NONPOSIX_TSD
  return (EIF_TSD_GET0((void *),eif_global_key,x) == 0); /* FIXME.. not sure */
#else /* EIF_NONPOSIX_TSD */
  return (EIF_TSD_GET0(0,eif_global_key,x) != 0);
#endif

#elif defined SOLARIS_THREADS
  return (EIF_TSD_GET0((void *),eif_global_key,x) == 0);
#endif
}

rt_private void eif_init_context(eif_global_context_t *eif_globals)
{
	/*
	 * Clears the eif_globals structure and initializes some of its
	 * fields.
	 */

	bzero((char *)eif_globals,sizeof(eif_global_context_t));

		/* except.c */
	exdata.ex_val = 1;
	print_history_table = ~0;

		/* garcol.c */
	tenure = (uint32) TENURE_MAX;
	plsc_per = PLSC_PER;
	th_alloc = TH_ALLOC;

		/* malloc.c */
	gen_scavenge = GS_SET;
}


rt_public void eif_thr_create (EIF_OBJ thr_root_obj, EIF_PROC init_func)
{
	/*
	 * Creates a new Eiffel thread. This function is only called from
	 * Eiffel and is given two arguments: the object (whose class 
	 * inherits from THREAD) a clone of which will become the root object
	 * of the new thread, and the Eiffel routine it will execute.
	 * These two arguments are part of the routine context that will be
	 * passed to the new thread via the low-level platform-dependant
	 * thread-creation function.
	 * This context also contains a pointer to the task-id of the new
	 * thread (both accessible to the parent and the thread) and a
	 * pointer to the parent's children-counter `n_children' that is
	 * used by eif_thr_join_all() and eif_thr_exit()--PCV
	 */

	EIF_GET_CONTEXT

	start_routine_ctxt_t *routine_ctxt;
	EIF_THR_TYPE *tid = (EIF_THR_TYPE *) malloc (sizeof (EIF_THR_TYPE));

	routine_ctxt = (start_routine_ctxt_t *)malloc(sizeof(start_routine_ctxt_t));
	if (!routine_ctxt)
		eif_thr_panic("No more memory to launch new thread\n");
	routine_ctxt->current = eif_adopt(thr_root_obj);
	routine_ctxt->routine = init_func;
	routine_ctxt->tid = tid;
#ifndef EIF_NO_JOIN_ALL
	routine_ctxt->addr_n_children = &n_children;
	eif_thr_mutex_lock(eif_children_mutex);
	n_children ++;	
	eif_thr_mutex_unlock(eif_children_mutex);
#endif
	EIF_THR_CREATE(eif_thr_entry, routine_ctxt, *tid, "Cannot create thread\n");
	last_child = tid;

	EIF_END_GET_CONTEXT
}


rt_public void eif_thr_create_with_args (EIF_OBJ thr_root_obj, 
										 EIF_PROC init_func,
										 EIF_INTEGER priority,
										 EIF_INTEGER policy)
{
	/*
	 * This function is the same as eif_thr_create() but makes it possible
	 * to set the thread priority and scheduling policy (when allowed by
	 * the current architecture) upon creation.--PCV
	 */

	EIF_GET_CONTEXT

	start_routine_ctxt_t *routine_ctxt;
	EIF_THR_TYPE *tid = (EIF_THR_TYPE *) malloc (sizeof (EIF_THR_TYPE));
	EIF_THR_ATTR_TYPE attr;
	routine_ctxt = (start_routine_ctxt_t *)malloc(sizeof(start_routine_ctxt_t));
	if (!routine_ctxt)
		eif_thr_panic("No more memory to launch new thread\n");
	routine_ctxt->tid = tid;
	routine_ctxt->current = eif_adopt(thr_root_obj);
	routine_ctxt->routine = init_func;
#ifndef EIF_NO_JOIN_ALL
	routine_ctxt->addr_n_children = &n_children;
	eif_thr_mutex_lock(eif_children_mutex);
	n_children ++;	
	eif_thr_mutex_unlock(eif_children_mutex);
#endif
	EIF_THR_ATTR_INIT(attr,priority,policy);
	EIF_THR_CREATE_WITH_ATTR(eif_thr_entry, routine_ctxt, *tid, attr,
							 "Cannot create thread\n");
	last_child = tid;

	EIF_END_GET_CONTEXT
}

rt_private EIF_THR_ENTRY_TYPE eif_thr_entry (EIF_THR_ENTRY_ARG_TYPE arg)
{
	/*
	 * This function is a wrapper to the Eiffel routine that will be
	 * executed by the new thread. It is directly called upon creation
	 * of the thread, and initializes the Eiffel run-time.
	 */

	start_routine_ctxt_t *routine_ctxt = (start_routine_ctxt_t *)arg;
	eif_thr_register();
	{
		EIF_GET_CONTEXT

		struct ex_vect *exvect;
		jmp_buf exenv;

		eif_thr_context = routine_ctxt;
		eif_thr_mutex_lock(eif_rmark_mutex);

		initsig();
		initstk();
		exvect = exset((char *) 0, 0, (char *) 0);
		exvect->ex_jbuf = (char *) exenv;
		if ((echval = setjmp(exenv)))
			failure();

#ifdef WORKBENCH
		xinitint();
#endif
		root_obj = edclone(eif_access(routine_ctxt->current));

		/*
		  root_obj = eclone(eif_access(routine_ctxt->current)); 
		  root_obj = RTLN(eiftype(&(routine_ctxt->current)));
		  ecopy(routine_ctxt->current, root_obj);
		  */
		eif_thr_mutex_unlock(eif_rmark_mutex);

		/* (routine_ctxt->routine)(eif_access (routine_ctxt->current));  */
#ifndef EIF_NO_JOIN_ALL
		n_brothers = routine_ctxt->addr_n_children;
#endif
 		(routine_ctxt->routine)(root_obj);
		root_obj = (char *)0;
		EIF_END_GET_CONTEXT
	}
	eif_thr_exit ();
}


rt_public void eif_thr_exit(void)
{
	/*
	 * Function called to terminate a thread launched by Eiffel with
	 * eif_thr_create() or eif_thr_create_with_attr().
	 * All the memory allocated with malloc() for the thread context is freed
	 */

	EIF_GET_CONTEXT

#ifndef EIF_NO_JOIN_ALL
	if (n_brothers) {
	  eif_thr_mutex_lock(eif_children_mutex);
	  /* We decrement the number of child threads of the parent, for join_all */
	  *(n_brothers) -= 1;	
	  eif_thr_mutex_unlock(eif_children_mutex);
	}
#endif

	free (eif_thr_context->tid);	/* Task id of the current thread */
	free (eif_thr_context);			/* Thread context passed by parent */
	reclaim ();						/* Free all allocated memory chunks */

	EIF_THR_EXIT(0);
	EIF_END_GET_CONTEXT
}

rt_public void eif_thr_yield(void)
{
	/*
	 * Yields execution to other threads. Platform dependant.
	 */

	EIF_THR_YIELD;
}


#ifdef EIF_NO_JOIN_ALL
rt_public void eif_thr_join_all(void)
{
	/*
	 * With Solaris threads, it is possible to wait for the termination of the
	 * first thread, so we can implement a simpler join_all mechanism 
	 */

    EIF_THR_JOIN_ALL;
}
#else
rt_public void eif_thr_join_all(void)
{
	/*
	 * Our implementation of join_all: the parent thread keeps a record of the
	 * number of threads it has launched, and the children have a pointer to
	 * this variable (n_children). So they decrement it upon termination. This
	 * variable is protected by the mutex eif_children_mutex.
	 * This function loops until the value of n_children is equal to zero. In
	 * order not to use all the CPU, we yield the execution to other threads
	 * if there are still more children.
	 * NB: this function might be very costly in CPU if the yield function
	 * doesn't work. --PCV
	 */

	EIF_GET_CONTEXT

	int end = 0;
	EIF_THR_YIELD;
	while (!end) {
		eif_thr_mutex_lock(eif_children_mutex);
		if (n_children) {
			eif_thr_mutex_unlock(eif_children_mutex);
			EIF_THR_YIELD;
		} else {
			end = 1;
			eif_thr_mutex_unlock(eif_children_mutex);
		}
	}
	EIF_END_GET_CONTEXT
}
#endif

/*
 * These three functions are used from Eiffel: they return the default,
 * minimum and maximum priority values for the current platform --PCV
 */

rt_public EIF_INTEGER eif_thr_default_priority(void) {
	return EIF_DEFAULT_PRIORITY;
}

rt_public EIF_INTEGER eif_thr_min_priority(void) {
	return EIF_MIN_PRIORITY;
}

rt_public EIF_INTEGER eif_thr_max_priority(void) {
	return EIF_MAX_PRIORITY;
}

/*
 * These two functions each return a pointer to respectively the task-id
 * of the current thread and the task-id of the last created thread.
 * They are used from the class THREAD.--PCV
 */

rt_public EIF_POINTER eif_thr_task_id(void) {
	EIF_GET_CONTEXT
	return (EIF_POINTER) eif_thr_context->tid;
	EIF_END_GET_CONTEXT
}

rt_public EIF_POINTER eif_thr_last_thread(void) {
	EIF_GET_CONTEXT
	return (EIF_POINTER) last_child;
	EIF_END_GET_CONTEXT
}


/*
 * Functions for mutex management:
 *   - creation, locking, unlocking, non-blocking locking and destruction
 */
 
rt_public EIF_MUTEX_TYPE *eif_thr_mutex_create(void) {
	EIF_MUTEX_TYPE *a_mutex_pointer;

	EIF_MUTEX_CREATE(a_mutex_pointer, "cannot create mutex\n");
	return a_mutex_pointer;
}

rt_public void eif_thr_mutex_lock(EIF_MUTEX_TYPE *a_mutex_pointer) {
	if (a_mutex_pointer != (EIF_MUTEX_TYPE *) 0) {
		EIF_MUTEX_LOCK(a_mutex_pointer, "cannot lock mutex\n");
		/* Don't remove curly braces, macro could be several lines */
	} else 
		eraise("Trying to lock a NULL mutex", EN_EXT);
}

rt_public void eif_thr_mutex_unlock(EIF_MUTEX_TYPE *a_mutex_pointer) {
	if (a_mutex_pointer != (EIF_MUTEX_TYPE *) 0) {
		EIF_MUTEX_UNLOCK(a_mutex_pointer, "cannot unlock mutex\n");
		/* Don't remove curly braces, macro could be several lines */
	} else
		eraise("Trying to unlock a NULL mutex", EN_EXT);
}

rt_public EIF_BOOLEAN eif_thr_mutex_trylock(EIF_MUTEX_TYPE *a_mutex_pointer) {
  int status;
	if (a_mutex_pointer != (EIF_MUTEX_TYPE *) 0) {
		EIF_MUTEX_TRYLOCK(a_mutex_pointer, status, "cannot lock mutex\n");
		/* Don't remove curly braces, macro could be several lines */
	} else
		eraise("Trying to lock a NULL mutex", EN_EXT);
	return ((EIF_BOOLEAN)(!status));
}

#endif /* EIF_THREADS */

rt_public void eif_thr_panic(char *msg) {
	print_err_msg(stderr,"Thread panic! Following information may be completely incoherent\n");
	panic(msg);
	exit(0);
}


rt_public void eif_thr_freeze(EIF_OBJ object) {
	if (!efreeze(object)) {
		if (!spfreeze(eif_access(object)))
			eif_thr_panic("cannot freeze\n");
	}
}


/*
 * class PROXY externals
 */

rt_public EIF_POINTER eif_thr_proxy_set(EIF_REFERENCE object) {
/* With automatic freezing (to be tested)
	EIF_OBJ frozen_obj,temp_obj;

	temp_obj = eif_adopt(object);
	frozen_obj = efreeze(eif_access(temp_obj));
	if (!frozen_obj) eif_thr_panic ("can not attach proxy to object\n");
	return eif_access((EIF_OBJ)temp_obj);
*/
	return eif_adopt((EIF_OBJ)object);
}

rt_public EIF_REFERENCE eif_thr_proxy_access(EIF_POINTER proxy) {
	return eif_access(proxy);
}

rt_public void eif_thr_proxy_dispose(EIF_POINTER proxy) {
	EIF_OBJ dummy;
	dummy = eif_wean((EIF_OBJ)proxy);
}
