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
rt_public void eif_thr_exit(void);

rt_public EIF_MUTEX_TYPE eif_thr_mutex_create(void);
rt_public void eif_thr_mutex_lock(EIF_MUTEX_TYPE);
rt_public void eif_thr_mutex_unlock(EIF_MUTEX_TYPE);
rt_public EIF_BOOLEAN eif_thr_mutex_trylock(EIF_MUTEX_TYPE);

rt_public EIF_POINTER eif_thr_proxy_set(EIF_REFERENCE);
rt_public EIF_REFERENCE eif_thr_proxy_access(EIF_POINTER);
rt_public void eif_thr_proxy_dispose(EIF_POINTER);

rt_private void eif_init_context(eif_global_context_t *);
rt_private EIF_THR_ENTRY_TYPE eif_thr_entry(EIF_THR_ENTRY_ARG_TYPE);

rt_public EIF_TSD_TYPE eif_global_key;
rt_public EIF_MUTEX_TYPE eif_rmark_mutex;

#ifdef THREAD_DEVEL
rt_public EIF_MUTEX_TYPE eif_children_mutex;
#endif

rt_public void eif_thr_init_root(void) {
	EIF_TSD_CREATE(eif_global_key, "could not create global key for initial thread");
	EIF_MUTEX_CREATE(eif_rmark_mutex,"could not create mutex for inter-GC recursing marking");
#ifdef THREAD_DEVEL
	EIF_MUTEX_CREATE(eif_children_mutex,"could not create mutex for counting threads");
#endif
	eif_thr_register();

rt_public void eif_thr_register(void) {
	static once = 0;	/* For initial eif_thread, we don't know how
						 * many once values we have to allocate */

	eif_global_context_t *eif_globals;

	eif_globals = (eif_global_context_t *) malloc (sizeof(eif_global_context_t));
	if (!eif_globals)
		eif_thr_panic("No more memory for thread context");

	eif_init_context(eif_globals);
	EIF_TSD_SET(eif_global_key,eif_globals,"could not bind a context to a thread");

	if (once) {
		/* Allocate room for once values for all threads but the initial */
		/* because we do not have the number of onces yet */
		EIF_once_values = (char **) cmalloc ( EIF_once_count * sizeof (char *) );
		if (EIF_once_values == (char **) 0)
			/* Out of memory */
			enomem();

		bzero((char *)EIF_once_values, EIF_once_count * sizeof (char *));
	} else 
		once = 1;
}

rt_public unsigned int eif_thr_is_initialized() {
  /* Returns a non null value if the calling thread is initialized for
	 Eiffel, null otherwise */

#ifdef EIF_WIN32
  eif_global_context_t *x;
  /* On windows, GetLastError() yields NO_ERROR if such key was initialized */
  EIF_TSD_GET0 ((eif_global_context_t *),eif_global_key,x);
  return (GetLastError() == NO_ERROR);

#elif defined VXWORKS
  /* On VXWORKS, eif_global_key holds a pointer to eif_globals. If the
	 thread isn't initialized, eif_global_key == 0 */
  return (eif_global_key != (EIF_TSD_TYPE) 0);

#elif defined EIF_POSIX_THREADS
#ifdef EIF_NONPOSIX_TSD
  eif_global_context_t *x;
  return (EIF_TSD_GET0((void *),eif_global_key,x) == 0); /* FIXME.. not sure */
#else /* EIF_NONPOSIX_TSD */
  return (EIF_TSD_GET0(0,eif_global_key,0) != 0);
#endif

#elif defined SOLARIS_THREADS
  eif_global_context_t *x;
  return (EIF_TSD_GET0((void *),eif_global_key,x) == 0);
#endif
}

rt_private void eif_init_context(eif_global_context_t *eif_globals) {

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
	EIF_GET_CONTEXT
	start_routine_ctxt_t *routine_ctxt;
	EIF_THR_TYPE tid;

	routine_ctxt = (start_routine_ctxt_t *) malloc (sizeof(start_routine_ctxt_t));
	if (!routine_ctxt)
		eif_thr_panic("No more memory to launch new thread\n");
	routine_ctxt->current = eif_adopt(thr_root_obj);
	routine_ctxt->routine = init_func;
#ifdef THREAD_DEVEL
/* 	printf("root: addr_n_children = %x\n", &n_children); */
	routine_ctxt->addr_n_children = &n_children;
	eif_thr_mutex_lock(eif_children_mutex);
	n_children ++;	
/* 	printf("root: n_children = %d\n", n_children); */
	eif_thr_mutex_unlock(eif_children_mutex);
#endif
	EIF_THR_CREATE(
		eif_thr_entry,
		routine_ctxt,
		tid,
		"Cannot create thread\n");
	EIF_END_GET_CONTEXT
}


rt_private EIF_THR_ENTRY_TYPE eif_thr_entry(EIF_THR_ENTRY_ARG_TYPE arg)
{
	start_routine_ctxt_t *routine_ctxt = (start_routine_ctxt_t *)arg;
	eif_thr_register();
	{
		EIF_GET_CONTEXT

		struct ex_vect *exvect;
		jmp_buf exenv;

		eif_thr_context = routine_ctxt;
		eif_thr_mutex_lock(eif_rmark_mutex); /*paulv*/

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
		eif_thr_mutex_unlock(eif_rmark_mutex); /*paulv*/

		/*paulv (routine_ctxt->routine)(eif_access (routine_ctxt->current));  */
#ifdef THREAD_DEVEL
		n_brothers = routine_ctxt->addr_n_children;
#endif
 		(routine_ctxt->routine)(root_obj);
		root_obj = (char *)0;
		EIF_END_GET_CONTEXT
	}
	eif_thr_exit ();
}


rt_public void eif_thr_exit(void) {
	EIF_GET_CONTEXT
#ifdef THREAD_DEVEL
	if (n_brothers) {
	  eif_thr_mutex_lock(eif_children_mutex);
	  /* We decrement the number of child threads of the parent, for join_all */
	  *(n_brothers) -= 1;	
	  eif_thr_mutex_unlock(eif_children_mutex);
	}
#endif
	free (eif_thr_context);
	reclaim ();
	EIF_THR_EXIT(0);
	EIF_END_GET_CONTEXT
}

rt_public void eif_thr_yield(void) {
	EIF_THR_YIELD;
}

#ifndef THREAD_DEVEL
rt_public void eif_thr_join_all(void) {
    EIF_THR_JOIN_ALL;
}
#else
rt_public void eif_thr_join_all(void) {
	EIF_GET_CONTEXT
	int end = 0, i;
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

	/******************************/
	/* class MUTEX implementation */
	/******************************/

rt_public EIF_MUTEX_TYPE eif_thr_mutex_create(void) {
	EIF_MUTEX_TYPE a_mutex_pointer;

	EIF_MUTEX_CREATE(a_mutex_pointer, "cannot create mutex\n");
	return a_mutex_pointer;
}

rt_public void eif_thr_mutex_lock(EIF_MUTEX_TYPE a_mutex_pointer) {
/*   printf("Locking %x\n", a_mutex_pointer); */
	if (a_mutex_pointer != (EIF_MUTEX_TYPE) 0) {
		EIF_MUTEX_LOCK(a_mutex_pointer, "cannot lock mutex\n");
/* 		printf("Locked %x\n", a_mutex_pointer); */
	} else 
		eraise("Trying to lock a NULL mutex", EN_EXT);
}

rt_public void eif_thr_mutex_unlock(EIF_MUTEX_TYPE a_mutex_pointer) {
	if (a_mutex_pointer != (EIF_MUTEX_TYPE) 0) {
/* 		printf("Unlocking %x\n", a_mutex_pointer); */
		EIF_MUTEX_UNLOCK(a_mutex_pointer, "cannot unlock mutex\n");
/* 		printf("Unlocked %x\n", a_mutex_pointer); */
	} else
		eraise("Trying to unlock a NULL mutex", EN_EXT);
}

rt_public EIF_BOOLEAN eif_thr_mutex_trylock(EIF_MUTEX_TYPE a_mutex_pointer) {
  int status;
	if (a_mutex_pointer != (EIF_MUTEX_TYPE) 0) {
		EIF_MUTEX_TRYLOCK(a_mutex_pointer, status, "cannot lock mutex\n");
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
/*	if (!efreeze(eif_access(object))) { */
	if (!efreeze(object)) {
		if (!spfreeze(eif_access(object)))
			eif_thr_panic("cannot freeze\n");
	}
}


	/******************************/
	/* class PROXY implementation */
	/******************************/

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

