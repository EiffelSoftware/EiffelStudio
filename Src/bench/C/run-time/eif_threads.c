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

#include "eif_portable.h"
#include "eif_eiffel.h"
#include "rt_threads.h"
#include "eif_lmalloc.h"
#include "eif_globals.h"
#include "eif_err_msg.h"
#include "eif_sig.h"
#include "rt_garcol.h"
#include "rt_macros.h"
#include "rt_types.h"

#include <string.h>
#include <assert.h>


#ifdef EIF_THREADS

/*---------------------------------------*/
/*---  In multi-threaded environment  ---*/
/*---------------------------------------*/

rt_public void eif_thr_panic(EIF_REFERENCE);
rt_public void eif_thr_init_root(void);
rt_public void eif_thr_register(void);
rt_public unsigned int eif_thr_is_initialized(void);
rt_public void eif_thr_create(EIF_REFERENCE, EIF_POINTER);
rt_public void eif_thr_create_with_args(EIF_REFERENCE, EIF_POINTER, EIF_INTEGER,
										EIF_INTEGER, EIF_BOOLEAN);
rt_public void eif_thr_exit(void);

rt_public EIF_POINTER eif_thr_mutex_create(void);
rt_public void eif_thr_mutex_lock(EIF_POINTER);
rt_public void eif_thr_mutex_unlock(EIF_POINTER);
rt_public EIF_BOOLEAN eif_thr_mutex_trylock(EIF_POINTER);
rt_public void eif_thr_mutex_destroy(EIF_POINTER);

rt_private void eif_init_context(eif_global_context_t *);
rt_private EIF_THR_ENTRY_TYPE eif_thr_entry(EIF_THR_ENTRY_ARG_TYPE);

rt_public EIF_TSD_TYPE eif_global_key;

	/* To update GC with thread specific data */
rt_private void eif_destroy_gc_stacks(void);
rt_private void eif_init_gc_stacks(eif_global_context_t *);
rt_private void load_stack_in_gc (struct stack_list *, void *);
rt_private void remove_stack_from_gc (struct stack_list *, void *);
rt_private void eif_stack_free (void *stack);

rt_private EIF_MUTEX_TYPE *eif_thread_launch_mutex = NULL;	/* Mutex used to protect launching of a thread */

#define LAUNCH_MUTEX_CREATE \
	EIF_MUTEX_CREATE(eif_thread_launch_mutex, "Cannot create mutex for thread launcher\n")
#define LAUNCH_MUTEX_DESTROY \
	EIF_MUTEX_DESTROY(eif_thread_launch_mutex, "Cannot destroy mutex for thread launcher\n");
#define LAUNCH_MUTEX_LOCK	\
	EIF_MUTEX_LOCK(eif_thread_launch_mutex, "Cannot lock mutex for the thread launcher\n")
#define LAUNCH_MUTEX_UNLOCK \
	EIF_MUTEX_UNLOCK(eif_thread_launch_mutex, "Cannot unlock mutex for the thread launcher\n"); 

rt_public void eif_thr_init_root(void) 
{
	/*
	 * This function must be called once and only once at the very beginning
	 * of an Eiffel program (typically from main()) or the first time a thread
	 * initializes the Eiffel run-time if it is part of a Cecil system.
	 * The global key for Thread Specific Data is initialized: this variable
	 * is shared by all the threads, but it allows them to fetch a pointer
	 * to their own context (eif_globals structure).
	 */

	EIF_TSD_CREATE(eif_global_key,"Couldn't create global key for root thread");
	EIF_MUTEX_CREATE(eif_gc_mutex, "Couldn't create GC mutex");
	LAUNCH_MUTEX_CREATE;
	EIF_MUTEX_CREATE(eif_global_once_mutex, "Couldn't create global once mutex");
	eif_thr_register();
}

rt_public void eif_thr_register(void)
{
	/*
	 * Allocates memory for the eif_globals structure, initializes it
	 * and makes it part of the Thread Specific Data (TSD).
	 * Allocates memory for onces (for non-root threads)
	 */

	static int not_root_thread = 0;	/* For initial eif_thread, we don't know how
							 		 * many once values we have to allocate */

	eif_global_context_t *eif_globals;

	eif_globals = (eif_global_context_t *) eif_malloc(sizeof(eif_global_context_t));
	if (!eif_globals) eif_thr_panic("No more memory for thread context");
	eif_init_context(eif_globals);
	EIF_TSD_SET(eif_global_key,eif_globals,"Couldn't bind context to TSD.");

	if (not_root_thread) {
	  /*
	   * Allocate room for once values for all threads but the initial 
	   * because we do not have the number of onces yet
	   * Also set value root thread id.
	   */

		EIF_once_values = (EIF_REFERENCE *) eif_realloc (EIF_once_values, EIF_once_count * REFSIZ);
			/* needs malloc; crashes otherwise on some pure C-ansi compiler (SGI)*/
		if (EIF_once_values == (EIF_REFERENCE *) 0) /* Out of memory */
			enomem();
		memset ((EIF_REFERENCE) EIF_once_values, 0, EIF_once_count * REFSIZ);
	} else 
	{
		not_root_thread = 1;
		eif_cecil_init ();				/* Initialize ressources for cecil. */
		eif_thr_id = (EIF_THR_TYPE *) 0;	/* Null by convention in root */
	}
}

rt_public EIF_BOOLEAN eif_thr_is_root()
{
	/*
	 * Returns True is the calling thread is the Eiffel root thread,
	 * False otherwise.
	 */

	EIF_GET_CONTEXT
	return eif_thr_context ? EIF_FALSE : EIF_TRUE;
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

	memset (eif_globals, 0, sizeof(eif_global_context_t));
	
#ifdef WORKBENCH
		/*----------*/
		/* debug.c  */
		/*----------*/
	db_stack.st_hd = (struct stdchunk *) 0;      /* st_hd */
	db_stack.st_tl =	(struct stdchunk *) 0;      /* st_tl */
	db_stack.st_cur =	(struct stdchunk *) 0;      /* st_cur */
	db_stack.st_top =	(struct dcall *) 0;         /* st_top */
	db_stack.st_end =	(struct dcall *) 0;        /* st_end */

	once_list.idl_hd = (struct idlchunk *) 0;      /* idl_hd */
	once_list.idl_tl =	(struct idlchunk *) 0;      /* idl_tl */
	once_list.idl_last = (uint32 *) 0;               /* idl_last */
	once_list.idl_end =	(uint32 *) 0;               /* idl_end */
 
#endif	/* WORKBENCH */

		/*----------*/
		/* except.c */
		/*----------*/
	
	eif_stack.st_hd =	(struct stxchunk *) 0;				/* st_hd */
	eif_stack.st_tl =	(struct stxchunk *) 0;				/* st_tl */
	eif_stack.st_cur =	(struct stxchunk *) 0;				/* st_cur */
	eif_stack.st_top =	(struct ex_vect *) 0;				/* st_top */
	eif_stack.st_end =	(struct ex_vect *) 0;				/* st_end */

	eif_trace.st_hd = 	(struct stxchunk *) 0;				/* st_hd */
	eif_trace.st_tl =	(struct stxchunk *) 0;				/* st_tl */
	eif_trace.st_cur = 	(struct stxchunk *) 0;				/* st_cur */
	eif_trace.st_top =	(struct ex_vect *) 0;				/* st_top */
	eif_trace.st_end =	(struct ex_vect *) 0;				/* st_end */
	eif_trace.st_bot =	(struct ex_vect *) 0;				/* st_bot */

	exdata.ex_val = 		0;				
	exdata.ex_nomem = 		0;				
	exdata.ex_nsig = 		0;				
	exdata.ex_level = 		0;				
	exdata.ex_org = 		0;				
	exdata.ex_tag = 		(char *) 0;		
	exdata.ex_otag = 		(char *) 0;		
	exdata.ex_rt = 		(char *) 0;		
	exdata.ex_ort = 		(char *) 0;		
	exdata.ex_class = 		0;				
	exdata.ex_oclass = 		0;				

	print_history_table = ~0;

	ex_string.area =	NULL;   
	ex_string.used =	0L;    
	ex_string.size =		0L    ;


		/*----------*/
		/* garcol.c */
		/*----------*/
	loc_stack.st_hd = 		(struct stchunk *) 0;	
	loc_stack.st_tl = 		(struct stchunk *) 0;	
	loc_stack.st_cur = 		(struct stchunk *) 0;	
	loc_stack.st_top = 		(EIF_REFERENCE *) 0;			
	loc_stack.st_end = 		(EIF_REFERENCE *) 0;			

	loc_set.st_hd = 		(struct stchunk *) 0;	
	loc_set.st_tl = 		(struct stchunk *) 0;	
	loc_set.st_cur = 		(struct stchunk *) 0;	
	loc_set.st_top = 		(EIF_REFERENCE *) 0;			
	loc_set.st_end = 		(EIF_REFERENCE *) 0;			
	
#ifdef EIF_REM_SET_OPTIMIZATION
	special_rem_set = (struct special_table *) 0; 
					/* Remembered special table for special objects. */ 
#endif	/* EIF_REM_SET_OPTIMIZATION */

	once_set.st_hd = 		(struct stchunk *) 0;	
	once_set.st_tl = 		(struct stchunk *) 0;	
	once_set.st_cur = 		(struct stchunk *) 0;	
	once_set.st_top = 		(EIF_REFERENCE *) 0;			
	once_set.st_end = 		(EIF_REFERENCE *) 0;			

		/*----------*/
		/* hector.c */
		/*----------*/

	hec_stack.st_hd = 		(struct stchunk *) 0;	
	hec_stack.st_tl = 		(struct stchunk *) 0;	
	hec_stack.st_cur = 		(struct stchunk *) 0;	
	hec_stack.st_top = 		(EIF_REFERENCE *) 0;			
	hec_stack.st_end = 		(EIF_REFERENCE *) 0;			

	hec_saved.st_hd = 		(struct stchunk *) 0;	
	hec_saved.st_tl = 		(struct stchunk *) 0;	
	hec_saved.st_cur = 		(struct stchunk *) 0;	
	hec_saved.st_top = 		(EIF_REFERENCE *) 0;			
	hec_saved.st_end = 		(EIF_REFERENCE *) 0;			

	free_stack.st_hd = 		(struct stchunk *) 0;	
	free_stack.st_tl = 		(struct stchunk *) 0;	
	free_stack.st_cur = 		(struct stchunk *) 0;	
	free_stack.st_top = 		(EIF_REFERENCE *) 0;			
	free_stack.st_end = 		(EIF_REFERENCE *) 0;			

#ifdef WORKBENCH
		/*----------*/
		/* interp.c */
		/*----------*/

	op_stack.st_hd = 		(struct stochunk *) 0;      
	op_stack.st_tl = 		(struct stochunk *) 0;      
	op_stack.st_cur = 		(struct stochunk *) 0;      
	op_stack.st_top = 		(struct item *) 0;          
	op_stack.st_end = 		(struct item *) 0;          

	IC = (unsigned char *) 0;
	iregs = (struct item **) 0;
	iregsz = 0;  
	argnum = 0;  
	locnum = 0; 
	tagval = 0L;
	inv_mark_table = (char *) 0;


#endif	/* WORKBENCH */	
	
		/*--------*/
		/* main.c */
		/*--------*/

	in_assertion = 0;
		/*--------*/
		/* out.c */
		/*--------*/
	tagged_out = (char *) 0;
	tagged_max = 0;
	tagged_len = 0;

		/*-----------*/
		/* pattern.c */
		/*-----------*/

	darray = (uint32 **) 0;

		/*--------*/
		/* plug.c */
		/*--------*/

	nstcall = 0;
	inv_mark_tablep = (char * ) 0;

		/*-------*/
		/* sig.c */
		/*-------*/
	
	esigblk = 0;

	eif_init_gc_stacks(eif_globals);
}


rt_public void eif_thr_create (EIF_REFERENCE thr_root_obj, EIF_POINTER init_func)
{
	/*
	 * Creates a new Eiffel thread. This function is only called from
	 * Eiffel and is given three arguments: 
	 * - the object (whose class inherits from THREAD) a clone of which
	 *   will become the root object of the new thread
	 * - the Eiffel routine it will execute
	 *
	 * These arguments are part of the routine context that will be
	 * passed to the new thread via the low-level platform-dependant
	 * thread-creation function.
	 *
	 * This context also contains a pointer to the thread-id of the new
	 * thread, a pointer to the parent's children-counter `n_children', a
	 * mutex and a condition variable that are used by eif_thr_join_all()
	 * and eif_thr_exit()  --PCV
	 */

	eif_thr_create_with_args (thr_root_obj, init_func,
							  (EIF_INTEGER) -1, /* Priority: not used */
							  (EIF_INTEGER) -1, /* Policy: not used */
							  (EIF_BOOLEAN) 5); /* -> Don't use args */
}


rt_public void eif_thr_create_with_args (EIF_REFERENCE thr_root_obj, 
										 EIF_POINTER init_func,
										 EIF_INTEGER priority,
										 EIF_INTEGER policy,
										 EIF_BOOLEAN detach)
{
	/*
	 * This function is the same as eif_thr_create() but makes it possible
	 * to set the thread priority, scheduling policy and detached_state
	 * (when allowed by the current architecture) upon creation.--PCV
	 */

	EIF_GET_CONTEXT

	start_routine_ctxt_t *routine_ctxt;
	EIF_THR_TYPE *tid = (EIF_THR_TYPE *) eif_malloc (sizeof (EIF_THR_TYPE));

	routine_ctxt = (start_routine_ctxt_t *)eif_malloc(sizeof(start_routine_ctxt_t));
	if (!routine_ctxt)
		eif_thr_panic("No more memory to launch new thread\n");
	routine_ctxt->current = eif_protect (thr_root_obj);
	routine_ctxt->routine = init_func;
	routine_ctxt->tid = tid;
	routine_ctxt->addr_n_children = &n_children;

	if (!eif_children_mutex) {
		/* It is the first time this thread creates a subthread (hopefully!), so
		* we create a mutex and a condition variable for join and join_all */
		EIF_MUTEX_CREATE(eif_children_mutex, "Couldn't create join mutex");
#ifndef EIF_NO_CONDVAR
		eif_children_cond = (EIF_COND_TYPE *) eif_malloc (sizeof (EIF_COND_TYPE));
		EIF_COND_INIT(eif_children_cond, "Couldn't initialize cond. variable");
#endif /* EIF_NO_CONDVAR */
	}
	routine_ctxt->children_mutex = eif_children_mutex;
#ifndef EIF_NO_CONDVAR
	routine_ctxt->children_cond = eif_children_cond;
#endif /* EIF_NO_CONDVAR */
	EIF_MUTEX_LOCK(eif_children_mutex, "Couldn't lock children mutex");
	n_children ++;	
	EIF_MUTEX_UNLOCK(eif_children_mutex, "Couldn't unlock children mutex");
	LAUNCH_MUTEX_LOCK;
	if (detach != (EIF_BOOLEAN) 5) {
		EIF_THR_ATTR_TYPE attr;
		EIF_THR_ATTR_INIT(attr,priority,policy,detach);
		EIF_THR_CREATE_WITH_ATTR(eif_thr_entry, routine_ctxt, *tid, attr,
								 "Cannot create thread\n");
		EIF_THR_ATTR_DESTROY(attr);
	} else { /* We're called from eif_thr_create */
		EIF_THR_CREATE(eif_thr_entry, routine_ctxt, *tid, "Cannot create thread\n");
	}
	LAUNCH_MUTEX_UNLOCK;
	last_child = tid;
}

rt_private EIF_THR_ENTRY_TYPE eif_thr_entry (EIF_THR_ENTRY_ARG_TYPE arg)
{
	/*
	 * This function is a wrapper to the Eiffel routine that will be
	 * executed by the new thread. It is directly called upon creation
	 * of the thread, and initializes the Eiffel run-time.
	 * Also, it initializes the eif_thr_id, for the overhead of
	 * the Eiffel objects allocated in this thread.
	 */

	start_routine_ctxt_t *routine_ctxt = (start_routine_ctxt_t *)arg;
	eif_thr_register();
		/* To prevent current thread to return too soon after call
		 * to EIF_THR_CREATE or EIF_THR_CREATE_WITH_ATTR.
		 * That way `tid' is properly initialized and can be freed
		 * safely later on */
	LAUNCH_MUTEX_LOCK;
	LAUNCH_MUTEX_UNLOCK;
	{
		EIF_GET_CONTEXT

		struct ex_vect *exvect;
		jmp_buf exenv;
		EIF_PROCEDURE execute = (EIF_PROCEDURE) routine_ctxt->routine;

		eif_thr_context = routine_ctxt;
		eif_thr_id = routine_ctxt->tid;	/* Initialize here the thread_id */
		EIF_MUTEX_LOCK(eif_thr_context->children_mutex, "Locking GC mutex");
		initsig();
		initstk();
		exvect = new_exset((char *) 0, 0, (char *) 0, 0, 0, 0);
		exvect->ex_jbuf = &exenv;

#ifdef _CRAY
		if (setjmp(exenv))
			failure();
#else
		if ((echval = setjmp(exenv)))
			failure();
#endif

#ifdef WORKBENCH
		xinitint();
#endif
		EIF_MUTEX_UNLOCK(eif_thr_context->children_mutex, "Unlocking GC mutex");

			/* Call the `execute' routine of the thread */
		(FUNCTION_CAST(void,(EIF_REFERENCE)) execute)(eif_access(routine_ctxt->current));

		exok();
	}
	eif_thr_exit ();
#if (!defined SOLARIS_THREADS && !defined EIF_WIN32)
	return (EIF_THR_ENTRY_TYPE) 0;	/* 	NOTREACHED. */
#else
	/* On solaris, EIF_ENTRY_TYPE is void: there is no Null void. */
	return;
#endif
}


rt_public void eif_thr_exit(void)
{
	/*
	 * Function called to terminate a thread launched by Eiffel with
	 * eif_thr_create() or eif_thr_create_with_args().
	 * All the memory allocated with eif_malloc() for the thread context is freed
	 * This function must be called from the thread itself (not the parent).
	 */

	EIF_GET_CONTEXT

	int destroy_mutex = 0; /* If non null, we'll destroy the 'join' mutex */

		/* We need to keep a reference to the children mutex and 
		 * the children condition variable after freeing ressources */
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *chld_cond = eif_thr_context->children_cond; 
#endif /* EIF_NO_CONDVAR */
	EIF_MUTEX_TYPE *chld_mutex = eif_thr_context->children_mutex;

	int ret;	/* Return Status of "eifaddr". */
	EIF_REFERENCE terminated = 
		eifaddr (eif_access (eif_thr_context->current), "terminated", &ret);
	eif_wean(eif_thr_context->current);
	if (ret != EIF_CECIL_OK) 
		eraise ("eif_thr_exit", EN_EXT);

	EIF_MUTEX_LOCK(chld_mutex, "Lock parent mutex");

	/* Set the `terminated' field of the twin thread object to True so that
	 * it knows the thread is terminated
	 */

	*terminated = EIF_TRUE;

	/* Decrement the number of child threads of the parent */
	*(eif_thr_context->addr_n_children) -= 1;

#ifndef EIF_NO_CONDVAR
	EIF_COND_BROADCAST(chld_cond, "Pbl cond_broadcast");
#endif
	EIF_MUTEX_UNLOCK(chld_mutex, "Unlock parent mutex");

		/* Clean GC of non-used data that were used to hold objects */
	eif_destroy_gc_stacks();

	/* 
	 * Every thread that has created a child thread with eif_thr_create() or
	 * eif_thr_create_with_args() has created a mutex and a condition 
	 * variable to be able to do a join_all (or a join). If no children are
	 * still alive, we destroy eif_children_mutex and eif_children_cond.
	 * If children are still alive, it is better not to remove the mutex
	 * because it would cause a crash upon their termination. If it is the
	 * case, no join_all has been called, which is a bit dangerous--PCV
	 */

	if (eif_children_mutex) {
		EIF_MUTEX_LOCK (eif_children_mutex, "Locking problem in reclaim()");
		if (!n_children) destroy_mutex = 1; /* No children are alive */
		EIF_MUTEX_UNLOCK (eif_children_mutex, "Unlocking problem in reclaim()");
	}
	if (destroy_mutex) {
	  EIF_MUTEX_DESTROY(eif_children_mutex, "Couldn't destroy join mutex.");
#ifndef EIF_NO_CONDVAR
	  EIF_COND_DESTROY(eif_children_cond, "Couldn't destroy join cond. var");
#endif
	  eif_children_mutex = (EIF_MUTEX_TYPE *) 0;
	}

	/* The TSD is managed in a different way under VxWorks: each thread
	 * must call taskVarAdd upon initialization and taskVarDelete upon
	 * termination.  It was impossible to call taskVarDelete using the same
	 * model as on other platforms unless creating a new macro that would
	 * be useful only for VxWorks. It is easier to do the following:
	 */

	if (eif_thr_is_root ())	{	/* Is this the root thread */
		eif_cecil_reclaim ();
		eif_free (eif_globals);			
						/* Global variables specific to the current thread */
		assert (!eif_thr_context);
#ifdef LMALLOC_CHECK
		eif_lm_display ();
		eif_lm_free ();
#endif	/* LMALLOC_CHECK */
	} else {
		eif_free (eif_thr_context->tid); /* Free id of the current thread */
		eif_free (eif_thr_context);		/* Thread context passed by parent */
		eif_free (eif_globals);			
						/* Global variables specific to the current thread */
	}	
#ifdef VXWORKS
	if (taskVarDelete(0,(int *)&(eif_global_key))) 
	  eif_thr_panic("Problem with taskVarDelete\n");
#endif	/* VXWORKS */

	EIF_THR_EXIT(0);
}	/* eif_thr_exit ().*/


/**************************************************************************/
/* NAME: eif_init_gc_stacks                                               */
/* ARGS: eif_globals: References to thread specific data                  */
/*------------------------------------------------------------------------*/
/* Initialize shared global stacks with thread specific stack. That way   */
/* the GC holds references to Eiffel objects in each thread               */
/**************************************************************************/

rt_private void eif_init_gc_stacks(eif_global_context_t *eif_globals)
{
	EIF_GC_MUTEX_LOCK;
	load_stack_in_gc (&loc_stack_list, &loc_stack);	
	load_stack_in_gc (&loc_set_list, &loc_set);	
	load_stack_in_gc (&once_set_list, &once_set);	
	load_stack_in_gc (&hec_stack_list, &hec_stack);	
	load_stack_in_gc (&hec_saved_list, &hec_saved);	
	load_stack_in_gc (&eif_stack_list, &eif_stack);	
	load_stack_in_gc (&eif_trace_list, &eif_trace);
#ifdef WORKBENCH
	load_stack_in_gc (&opstack_list, &op_stack);
#endif
	EIF_GC_MUTEX_UNLOCK;
}


/**************************************************************************/
/* NAME: eif_destroy_gc_stacks                                            */
/* ARGS: eif_globals: References to thread specific data                  */
/*------------------------------------------------------------------------*/
/* Destroy thread specific stacks and remove them from GC global stack    */
/**************************************************************************/

rt_private void eif_destroy_gc_stacks(void)
{
	EIF_GET_CONTEXT
	EIF_GC_MUTEX_LOCK;
	remove_stack_from_gc (&loc_stack_list, &loc_stack);
	remove_stack_from_gc (&loc_set_list, &loc_set);	
	remove_stack_from_gc (&once_set_list, &once_set);	
	remove_stack_from_gc (&hec_stack_list, &hec_stack);	
	remove_stack_from_gc (&hec_saved_list, &hec_saved);	
	remove_stack_from_gc (&eif_stack_list, &eif_stack);	
	remove_stack_from_gc (&eif_trace_list, &eif_trace);
#ifdef WORKBENCH
	remove_stack_from_gc (&opstack_list, &op_stack);
#endif
	eif_stack_free (&free_stack);
	EIF_GC_MUTEX_UNLOCK;
}


/**************************************************************************/
/* NAME: load_stack_in_gc                                                 */
/* ARGS: st_list: Global GC stack                                         */
/*       st: thread specific stack that we are putting in `st_list'.      */
/*------------------------------------------------------------------------*/
/* Insert `st' in `st_list->threads_stack' and update `st_list'.          */
/**************************************************************************/

rt_private void load_stack_in_gc (struct stack_list *st_list, void *st)
{
	int count = st_list->count + 1;
	st_list->count = count;
	if (st_list->capacity < st_list->count) {
		st_list->threads.stack = (void **) eif_realloc (st_list->threads.stack,
															count * sizeof(struct stack **));
		st_list->capacity = count;
	}
	st_list->threads.stack[count - 1] = st;
}


/**************************************************************************/
/* NAME: remove_stack_from_gc                                             */
/* ARGS: st_list: Global GC stack                                         */
/*       st: thread specific stack that should be in `st_list'.           */
/*------------------------------------------------------------------------*/
/* Remove `st' from `st_list->threads_stack' and update `st_list'         */
/* accordingly.                                                           */
/**************************************************************************/

rt_private void remove_stack_from_gc (struct stack_list *st_list, void *st)
{
	int count = st_list->count;
	int i = 0;
	void **stack = st_list->threads.stack;

	assert(count > 0);	/* Must be something in threads_stack */

		/* Linear search to find `st' in `threads_stack' */
	while (i < count) {
		if (stack[i] == st)
			break;
		i = i + 1;
	}

	assert (i < count);	/* We must have found entry that holds reference to `st' */

		/* Free memory used by `st'. */
	eif_stack_free (st);

		/* Remove one element */
	st_list->count = count - 1;
	stack [i] = stack [count -1];
	stack [count - 1] = NULL;
}

/**************************************************************************/
/* NAME: eif_stack_free                                                   */
/* ARGS: st: thread specific stack.                                       */
/*------------------------------------------------------------------------*/
/* Free memory used by `st'.                                              */
/**************************************************************************/

rt_private void eif_stack_free (void *stack){
	struct stack *st = (struct stack *) stack;
	struct stchunk *c, *cn;

	for (c = st->st_hd; c != (struct stchunk *) 0; c = cn) {
		cn = c->sk_next;
		xfree ((EIF_REFERENCE) c);
	}

	st->st_hd = NULL;
	st->st_tl = NULL;
	st->st_cur = NULL;
	st->st_top = NULL;
	st->st_end = NULL;
}


rt_public void eif_thr_yield(void)
{
	/*
	 * Yields execution to other threads. Platform dependant, sometimes
	 * undefined.
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

#ifdef EIF_NO_CONDVAR
	int end = 0;
#endif

	/* If no thread has been launched, the mutex isn't initialized */
	if (!eif_children_mutex) return;

#ifdef EIF_NO_CONDVAR
	EIF_THR_YIELD;
	while (!end) {
		EIF_MUTEX_LOCK(eif_children_mutex, "Failed lock mutex join_all");
		if (n_children) {
			EIF_MUTEX_UNLOCK(eif_children_mutex,"Failed unlock mutex join_all");
			EIF_THR_YIELD;
		} else {
			end = 1;
			EIF_MUTEX_UNLOCK(eif_children_mutex,"Failed unlock mutex join_all");
		}
	}
#else
	EIF_MUTEX_LOCK(eif_children_mutex, "Failed lock mutex join_all");
	while (n_children)
		EIF_COND_WAIT(eif_children_cond, eif_children_mutex, "pb wait");
	EIF_MUTEX_UNLOCK(eif_children_mutex,"Failed unlock mutex join_all");
#endif
}
#endif

rt_public void eif_thr_wait (EIF_BOOLEAN *terminated)
{
	/*
	 * Waits until a thread sets `terminated' to True, which means it
	 * is terminated. This function is called by `join'. The calling
	 * thread must be the direct parent of the thread, or the function
	 * might loop indefinitely --PCV
	 */

	EIF_GET_CONTEXT

#ifdef EIF_NO_CONDVAR
	int end = 0;
#endif

	/* If no thread has been launched, the mutex isn't initialized */
	if (!eif_children_mutex) return;

#ifdef EIF_NO_CONDVAR

	/* This version is for platforms that don't support condition
	 * variables. If the platform doesn't support yield() either, this
	 * function can use much of the CPU time.
	 */

	EIF_THR_YIELD;
	while (!end) {
		EIF_MUTEX_LOCK(eif_children_mutex, "Failed lock mutex join()");
		if (*terminated == EIF_FALSE) {
			EIF_MUTEX_UNLOCK(eif_children_mutex,"Failed unlock mutex join()");
			EIF_THR_YIELD;
		} else {
			end = 1;
			EIF_MUTEX_UNLOCK(eif_children_mutex,"Failed unlock mutex join()");
		}
	}
#else

	/* This version is for platforms that support condition variables, like
	 * the platforms supporting POSIX threads, Solaris and Vxworks (if
	 * properly configured, ie compiled with POSIX_SCHED).
	 */

	EIF_MUTEX_LOCK(eif_children_mutex, "Failed lock mutex join()");
	while (*terminated == EIF_FALSE)
		EIF_COND_WAIT(eif_children_cond, eif_children_mutex, "pb wait");
	EIF_MUTEX_UNLOCK(eif_children_mutex,"Failed unlock mutex join()");

#endif
}

rt_public void eif_thr_join (EIF_POINTER tid)
{
	/*
	 * Invokes thr_join, pthread_join, etc.. depending on the platform.
	 * No such routine exists on VxWorks or Windows, so the Eiffel version
	 * should be used (ie. `join' <-> eif_thr_wait)
	 */

	if (tid != (EIF_POINTER) 0) {
		EIF_THR_JOIN(* (EIF_THR_TYPE *) tid);
	} else {
		eraise ("Trying to join a thread whose ID is NULL", EN_EXT);
	}
}


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
 * These two functions each return a pointer to respectively the thread-id
 * of the current thread and the thread-id of the last created thread.
 * They are used from the class THREAD.--PCV
 */

rt_public EIF_POINTER eif_thr_thread_id(void) {
	EIF_GET_CONTEXT
	if (eif_thr_context) {
		return (EIF_POINTER) eif_thr_context->tid;
	} else
		return (EIF_POINTER) 0; /* Root thread's id is 0 */
}

rt_public EIF_POINTER eif_thr_last_thread(void) {
	EIF_GET_CONTEXT
	return (EIF_POINTER) last_child;
}


/*
 * Functions for mutex management:
 *	- creation, locking, unlocking, non-blocking locking and destruction
 */
 
rt_public EIF_POINTER eif_thr_mutex_create(void) {
	EIF_MUTEX_TYPE *a_mutex_pointer;

	EIF_MUTEX_CREATE(a_mutex_pointer, "cannot create mutex\n");
#ifdef DEBUG
	printf ("Created mutex %x\n", a_mutex_pointer);
#endif
	return (EIF_POINTER) a_mutex_pointer;
}

rt_public void eif_thr_mutex_lock(EIF_POINTER mutex_pointer) {
	EIF_MUTEX_TYPE *a_mutex_pointer = (EIF_MUTEX_TYPE *) mutex_pointer;
	if (a_mutex_pointer != (EIF_MUTEX_TYPE *) 0) {
		EIF_MUTEX_LOCK(a_mutex_pointer, "cannot lock mutex\n");
		/* Don't remove curly braces, macro could be several lines */
	} else 
		eraise("Trying to lock a NULL mutex", EN_EXT);
}

rt_public void eif_thr_mutex_unlock(EIF_POINTER mutex_pointer) {
	EIF_MUTEX_TYPE *a_mutex_pointer = (EIF_MUTEX_TYPE *) mutex_pointer;
	if (a_mutex_pointer != (EIF_MUTEX_TYPE *) 0) {
		EIF_MUTEX_UNLOCK(a_mutex_pointer, "cannot unlock mutex\n");
		/* Don't remove curly braces, macro could be several lines */
	} else
		eraise("Trying to unlock a NULL mutex", EN_EXT);
}

rt_public EIF_BOOLEAN eif_thr_mutex_trylock(EIF_POINTER mutex_pointer) {
	int status = 0;
	EIF_MUTEX_TYPE *a_mutex_pointer = (EIF_MUTEX_TYPE *) mutex_pointer;
	if (a_mutex_pointer != (EIF_MUTEX_TYPE *) 0) {
		EIF_MUTEX_TRYLOCK(a_mutex_pointer, status, "cannot trylock mutex\n");
		/* Don't remove curly braces, macro could be several lines */
	} else
		eraise("Trying to lock a NULL mutex", EN_EXT);
	return ((EIF_BOOLEAN)(!status));
}

rt_public void eif_thr_mutex_destroy(EIF_POINTER mutex_pointer) {
	EIF_MUTEX_TYPE *a_mutex_pointer = (EIF_MUTEX_TYPE *) mutex_pointer;

#ifdef DEBUG
	printf ("Destroying mutex %x\n", a_mutex_pointer);
#endif
	if (a_mutex_pointer != (EIF_MUTEX_TYPE *) 0) {
		EIF_MUTEX_DESTROY(a_mutex_pointer, "cannot destroy mutex\n");
		a_mutex_pointer = (EIF_MUTEX_TYPE *) 0;
	}
}


/*
 * class SEMAPHORE externals
 */

rt_public EIF_POINTER eif_thr_sem_create (EIF_INTEGER count)
{
#ifndef EIF_NO_SEM
	EIF_SEM_TYPE *a_sem_pointer;

	EIF_SEM_CREATE(a_sem_pointer, count, "cannot create semaphore\n");
#ifdef DEBUG
	printf ("Created semaphore %x\n", a_sem_pointer);
#endif
	return (EIF_POINTER) a_sem_pointer;
#else
	return (EIF_POINTER) 0;
#endif
}

rt_public void eif_thr_sem_wait (EIF_POINTER sem)
{
#ifndef EIF_NO_SEM
	EIF_SEM_TYPE *a_sem_pointer = (EIF_SEM_TYPE *) sem;
	if (a_sem_pointer != (EIF_SEM_TYPE *) 0) {
		EIF_SEM_WAIT(a_sem_pointer, "cannot lock semaphore");
	} else 
		eraise("Trying to lock a NULL semaphore", EN_EXT);
#endif
}

rt_public void eif_thr_sem_post (EIF_POINTER sem)
{
#ifndef EIF_NO_SEM
	EIF_SEM_TYPE *a_sem_pointer = (EIF_SEM_TYPE *) sem;
	if (a_sem_pointer != (EIF_SEM_TYPE *) 0) {
		EIF_SEM_POST(a_sem_pointer, "cannot post semaphore");
	} else 
		eraise("Trying to post a NULL semaphore", EN_EXT);
#endif
}

rt_public EIF_BOOLEAN eif_thr_sem_trywait (EIF_POINTER sem)
{
#ifndef EIF_NO_SEM
	int status = 0;
	EIF_SEM_TYPE *a_sem_pointer = (EIF_SEM_TYPE *) sem;
	if (a_sem_pointer != (EIF_SEM_TYPE *) 0) {
		EIF_SEM_TRYWAIT(a_sem_pointer, status, "cannot trywait semaphore\n");
	} else
		eraise("Trying to trywait a NULL semaphore", EN_EXT);
	return ((EIF_BOOLEAN)(!status));
#else
	return EIF_FALSE;	/* Not implemented. */
#endif
}

rt_public void eif_thr_sem_destroy (EIF_POINTER sem)
{
#ifndef EIF_NO_SEM
	EIF_SEM_TYPE *a_sem_pointer = (EIF_SEM_TYPE *) sem;
#ifdef DEBUG
	printf ("Destroying semaphore %x\n", a_sem_pointer);
#endif
	if (a_sem_pointer != (EIF_SEM_TYPE *) 0) {
		EIF_SEM_DESTROY(a_sem_pointer, "cannot destroy semaphore");
		a_sem_pointer = (EIF_SEM_TYPE *) 0;
	}
#endif
}

/*
 * class CONDITION_VARIABLE externals
 */

rt_public EIF_POINTER eif_thr_cond_create (void)
{
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *cond;

	EIF_COND_CREATE(cond, "cannot create cond. variable");
#ifdef DEBUG
	printf ("Created cond. var %x\n", cond);
#endif
	return (EIF_POINTER) cond;
#else
	return (EIF_POINTER) 0;
#endif /* EIF_NO_CONDVAR */
}

rt_public void eif_thr_cond_broadcast (EIF_POINTER cond_ptr)
{
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *cond = (EIF_COND_TYPE *) cond_ptr;

	if (cond != (EIF_COND_TYPE *) 0) {
		EIF_COND_BROADCAST(cond, "cannot cond_broadcast");
	} else
		eraise ("Trying to cond_broadcast on NULL", EN_EXT);
#endif /* EIF_NO_CONDVAR */
}

rt_public void eif_thr_cond_signal (EIF_POINTER cond_ptr)
{
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *cond = (EIF_COND_TYPE *) cond_ptr;

	if (cond != (EIF_COND_TYPE *) 0) {
		EIF_COND_SIGNAL(cond, "cannot cond_signal");
	} else
		eraise ("Trying to cond_signal on NULL", EN_EXT);
#endif /* EIF_NO_CONDVAR */
}

rt_public void eif_thr_cond_wait (EIF_POINTER cond_ptr, EIF_POINTER mutex_ptr)
{
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *cond = (EIF_COND_TYPE *) cond_ptr;
	EIF_MUTEX_TYPE *mutex = (EIF_MUTEX_TYPE *) mutex_ptr;

	if (cond != (EIF_COND_TYPE *) 0) {
		EIF_COND_WAIT(cond, mutex, "cannot cond_wait");
	} else
		eraise ("Trying to cond_wait on NULL", EN_EXT);
#endif /* EIF_NO_CONDVAR */
}

rt_public void eif_thr_cond_destroy (EIF_POINTER cond_ptr)
{
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *cond = (EIF_COND_TYPE *) cond_ptr;
#ifdef DEBUG
	printf ("Destroying cond. var %x\n", cond);
#endif
	EIF_COND_DESTROY(cond, "destroying condition variable");
#endif /* EIF_NO_CONDVAR */
}


rt_public void eif_thr_panic(char *msg)
{
	print_err_msg (stderr, "*** Thread panic! ***\n");
	eif_panic(msg);
	exit(0);
}

#endif /* EIF_THREADS */
