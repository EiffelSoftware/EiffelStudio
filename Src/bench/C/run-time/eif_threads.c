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

#include "eiffel.h"
#include "eif_threads.h"
#include "eif_globals.h"
#include "err_msg.h"
#include "hector.h"      /* for efreeze() and eufreeze() */

#ifdef EIF_THREADS

/* Structure used to give two arguments to a new thread,
   with only one used -- the pointer on this structure.
   This structure is only needed locally */

typedef struct {
	EIF_OBJ current;
	EIF_PROC routine;
} start_routine_ctxt_t;

rt_public void eif_thr_panic(char *);
rt_public void eif_thr_init_root(void);
rt_public void eif_thr_register(void);
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
rt_private void eif_thr_entry(EIF_THR_ENTRY_ARG_TYPE);

rt_public EIF_TSD_TYPE eif_global_key;
rt_public EIF_MUTEX_TYPE eif_rmark_mutex;

rt_public void eif_thr_init_root(void) {
	EIF_TSD_CREATE(eif_global_key, "could not create global key for initial thread");
	EIF_MUTEX_CREATE(eif_rmark_mutex,"could not create mutex for inter-GC recursing marking");
	eif_thr_register();
}

rt_public void eif_thr_register(void) {
	static once = 0;	/* For initial eif_thread, we don't know how
						 * many once values we have to allocate */

	eif_global_context_t *eif_globals;

	eif_globals = (eif_global_context_t *)malloc(sizeof(eif_global_context_t));
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
	start_routine_ctxt_t *routine_ctxt;
	EIF_THR_TYPE tid;

	routine_ctxt = (start_routine_ctxt_t *)malloc(sizeof(start_routine_ctxt_t));
	if (!routine_ctxt)
		eif_thr_panic("No more memory to launch new thread\n");
	routine_ctxt->current = eif_adopt(thr_root_obj);
	routine_ctxt->routine = init_func;

	EIF_THR_CREATE(
		eif_thr_entry,
		(EIF_THR_ENTRY_ARG_TYPE)(routine_ctxt),
		tid,
		"Cannot create thread\n");
}


rt_private EIF_THR_ENTRY_TYPE eif_thr_entry(EIF_THR_ENTRY_ARG_TYPE arg)
{
	start_routine_ctxt_t *routine_ctxt = (start_routine_ctxt_t *)arg;
	eif_thr_register();
	{
		EIF_GET_CONTEXT

		struct ex_vect *exvect;
		jmp_buf exenv;

		EIF_MUTEX_LOCK(eif_rmark_mutex,
			"problem while trying to lock mutex on context buffer");
		initsig();
		initstk();
		exvect = exset((char *) 0, 0, (char *) 0);
		exvect->ex_jbuf = (char *) exenv;
		if (echval = setjmp(exenv))
			failure();

#ifdef WORKBENCH
		xinitint();
#endif

		root_obj = eclone(eif_access(routine_ctxt->current));
	/*
		root_obj = RTLN(eiftype(&(routine_ctxt->current)));
		root_obj = edclone(eif_access(routine_ctxt->current));
		root_obj = eclone(eif_access(routine_ctxt->current));
		ecopy(routine_ctxt->current, root_obj);
	*/
		EIF_MUTEX_UNLOCK(eif_rmark_mutex,
			"problem while unlocking mutex on context buffer");

		(routine_ctxt->routine)(eif_access (routine_ctxt->current));
		root_obj = (char *)0;
		EIF_END_GET_CONTEXT
	}
	plsc();
	free(routine_ctxt);
}


rt_public void eif_thr_exit(void) {
	EIF_THR_EXIT(0);
}

rt_public void eif_thr_yield(void) {
    EIF_THR_YIELD;
}

rt_public void eif_thr_join_all(void) {
    EIF_THR_JOIN_ALL;
}


	/******************************/
	/* class MUTEX implementation */
	/******************************/

rt_public EIF_MUTEX_TYPE eif_thr_mutex_create(void) {
	EIF_MUTEX_TYPE a_mutex_pointer;

	EIF_MUTEX_CREATE(a_mutex_pointer, "cannot create mutex\n");
	return a_mutex_pointer;
}

rt_public void eif_thr_mutex_lock(EIF_MUTEX_TYPE a_mutex_pointer) {
	EIF_MUTEX_LOCK(a_mutex_pointer, "cannot lock mutex\n");
}

rt_public void eif_thr_mutex_unlock(EIF_MUTEX_TYPE a_mutex_pointer) {
	EIF_MUTEX_UNLOCK(a_mutex_pointer, "cannot unlock mutex\n");
}

rt_public EIF_BOOLEAN eif_thr_mutex_trylock(EIF_MUTEX_TYPE a_mutex_pointer) {
	int status;
	EIF_MUTEX_TRYLOCK(a_mutex_pointer, status, "cannot lock mutex\n");
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

