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
rt_public void eif_thr_create(EIF_OBJ current_obj, EIF_PROC init_func);

rt_private void eif_init_context(eif_global_context_t *eif_globals);
rt_private void eif_thr_entry(start_routine_ctxt_t *routine_ctxt);

rt_public EIF_TSD_TYPE eif_global_key;
rt_public EIF_MUTEX_TYPE eif_rmark_mutex;
rt_private eif_global_context_t globals_buffer;


rt_public void eif_thr_panic(char *msg) {
	printf("eif_thr_panic!\n");
	fprintf(stderr,"%s\n",msg);
	exit(0);
}

rt_public void eif_thr_init_root(void) {
	EIF_TSD_CREATE(eif_global_key, "could not create global key for initial thread");
	EIF_MUTEX_CREATE(eif_rmark_mutex,"could not create mutex for recursive marking");
	eif_thr_register();
}

rt_public void eif_thr_register(void) {
	eif_global_context_t *eif_globals;

	eif_globals = (eif_global_context_t *)malloc(sizeof(eif_global_context_t));
	if (!eif_globals)
		eif_thr_panic("Could not get memory for thread context");

	eif_init_context(eif_globals);
	EIF_TSD_SET(eif_global_key,eif_globals,"could not bind a specific value to a thread");
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
	start_routine_ctxt_t *routine_ctxt;
	EIF_THR_TYPE tid;

	routine_ctxt = (start_routine_ctxt_t *)malloc(sizeof(start_routine_ctxt_t));
	if (!routine_ctxt)
		eif_thr_panic("No memory for thread info\n");
	routine_ctxt->current = eif_adopt(current_obj);
	routine_ctxt->routine = init_func;

	EIF_THR_CREATE(
		eif_thr_entry,
		(EIF_THR_ENTRY_ARG_TYPE)(routine_ctxt),
		tid,
		"Cannot create thread\n");
}


void eif_thr_entry(start_routine_ctxt_t *routine_ctxt)
{
	eif_register_thread();
	(routine_ctxt->routine)(eif_access (routine_ctxt->current));
}


void eif_exit_thread(void)
{
	EIF_THR_EXIT(0);
}


#endif /* EIF_THREADS */
