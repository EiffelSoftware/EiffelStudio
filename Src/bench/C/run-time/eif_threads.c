/*

 ######     #    ######           #####  #    #  #####   ######    ##    #####    ####            ####
 #          #    #                  #    #    #  #    #  #        #  #   #    #  #               #    #
 #####      #    #####              #    ######  #    #  #####   #    #  #    #   ####           #
 #          #    #                  #    #    #  #####   #       ######  #    #       #   ###    #
 #          #    #                  #    #    #  #   #   #       #    #  #    #  #    #   ###    #    #
 ######     #    #      #######     #    #    #  #    #  ######  #    #  #####    ####    ###     ####

	Thread management routines.

*/

#include "eiffel.h"
#include "eif_threads.h"
#include "eif_globals.h"
#include "except.h"				/* for panic () */

#ifdef EIF_THREADS

rt_public void eif_init_root_thread(void);
rt_public void eif_register_thread(void);
rt_public void eif_init_context(eif_global_context_t *eif_globals);

typedef struct {
	EIF_OBJ current;
	EIF_PROC routine;
} start_routine_ctxt_t;

void eif_thr_create (EIF_OBJ current_obj, EIF_PROC init_func);
EIF_THR_ENTRY_TYPE eif_thr_entry(start_routine_ctxt_t *routine_ctxt);

rt_public EIF_TSD_TYPE eif_global_key;
rt_private eif_global_context_t globals_buffer;
rt_private EIF_MUTEX_TYPE globals_buffer_mutex;


rt_public void eif_init_root_thread(void) {

	if (eif_global_key)
		panic("global key already allocated !");

	EIF_TSD_CREATE(eif_global_key,"could not create global key for initial thread");

	EIF_MUTEX_CREATE(globals_buffer_mutex,"could not create mutex for context buffer");

	eif_register_thread();
}

rt_public void eif_register_thread(void) {
	eif_global_context_t *eif_globals;

	EIF_MUTEX_LOCK(globals_buffer_mutex,"problem while trying to lock mutex on context buffer");

	eif_globals = &globals_buffer;
	eif_init_context(eif_globals);

	EIF_TSD_SET(eif_global_key,eif_globals,"could not bind a specific value to a thread");

	eif_globals = (eif_global_context_t *)cmalloc(sizeof(eif_global_context_t));
	if (!eif_globals)
		panic("Could not get memory for thread context");

	bcopy((char *)&globals_buffer, (char *)eif_globals, sizeof(eif_global_context_t));

	EIF_TSD_SET(eif_global_key,eif_globals,"could not bind a specific value to a thread");

	EIF_MUTEX_UNLOCK(globals_buffer_mutex,"problem while unlocking mutex on context buffer");

}


rt_public void eif_init_context(eif_global_context_t *eif_globals) {

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


void eif_thr_create (EIF_OBJ current_obj, EIF_PROC init_func)
{
	start_routine_ctxt_t routine_ctxt;
	EIF_THR_TYPE tid;

	routine_ctxt.current = eif_adopt(current_obj);
	routine_ctxt.routine = init_func;

	EIF_THR_CREATE(
		eif_thr_entry, 
		(EIF_THR_ENTRY_ARG_TYPE)(&routine_ctxt), 
		tid,
		"Cannot create thread\n");
}


EIF_THR_ENTRY_TYPE eif_thr_entry(start_routine_ctxt_t *routine_ctxt)
{
	eif_register_thread();
	(routine_ctxt->routine)(eif_access (routine_ctxt->current));
}


void eif_exit_thread(void)
{
	EIF_THR_EXIT(0);
}


#endif /* EIF_THREADS */
