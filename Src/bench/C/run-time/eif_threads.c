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

#include "eif_config.h"
#include "eif_eiffel.h"
#include "eif_threads.h"
#include "eif_lmalloc.h"
#include "eif_globals.h"
#include "eif_err_msg.h"
#include "eif_hector.h"      /* for efreeze() and eufreeze() */
#include "eif_sig.h"
#include <assert.h>


#ifdef EIF_THREADS

/*---------------------------------------*/
/*---  In multi-threaded environment  ---*/
/*---------------------------------------*/

rt_public void eif_thr_panic(EIF_REFERENCE);
rt_public void eif_thr_init_root(void);
rt_public void eif_thr_register(void);
rt_public unsigned int eif_thr_is_initialized(void);
rt_public void eif_thr_create(EIF_OBJECT, EIF_POINTER);
rt_public void eif_thr_create_with_args(EIF_OBJECT, EIF_POINTER, EIF_INTEGER,
										EIF_INTEGER, EIF_BOOLEAN);
rt_public void eif_thr_exit(void);

rt_public EIF_POINTER eif_thr_mutex_create(void);
rt_public void eif_thr_mutex_lock(EIF_POINTER);
rt_public void eif_thr_mutex_unlock(EIF_POINTER);
rt_public EIF_BOOLEAN eif_thr_mutex_trylock(EIF_POINTER);
rt_public void eif_thr_mutex_destroy(EIF_POINTER);

rt_public EIF_POINTER eif_thr_proxy_set(EIF_REFERENCE);
rt_public EIF_REFERENCE eif_thr_proxy_access(EIF_POINTER);
rt_public void eif_thr_proxy_dispose(EIF_POINTER);

rt_private void eif_init_context(eif_global_context_t *);
rt_private EIF_THR_ENTRY_TYPE eif_thr_entry(EIF_THR_ENTRY_ARG_TYPE);

rt_public EIF_TSD_TYPE eif_global_key;
/* rt_public EIF_MUTEX_TYPE *eif_rmark_mutex; */

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
	 * created for our implementation of `join_all' and `join'.--PCV
	 */

	EIF_TSD_CREATE(eif_global_key,"Couldn't create global key for root thread");
/* 	EIF_MUTEX_CREATE(eif_rmark_mutex,"Couldn't create inter-GC mutex"); */
	eif_thr_register();
}

rt_public void eif_thr_register(void)
{
	/*
	 * Allocates memory for the eif_globals structure, initializes it
	 * and makes it part of the Thread Specific Data (TSD).
	 * Allocates memory for onces (for non-root threads)
	 */

	static int once = 0;	/* For initial eif_thread, we don't know how
						 * many once values we have to allocate */

	eif_global_context_t *eif_globals;

	eif_globals = (eif_global_context_t *) eif_malloc(sizeof(eif_global_context_t));
	if (!eif_globals) eif_thr_panic("No more memory for thread context");
	eif_init_context(eif_globals);
	EIF_TSD_SET(eif_global_key,eif_globals,"Couldn't bind context to TSD.");

	/* Set the default GC parameters. */
	eif_alloc_init();

	if (once) {
	  /*
	   * Allocate room for once values for all threads but the initial 
	   * because we do not have the number of onces yet
	   * Also set value root thread id.
	   */

		EIF_once_values = (EIF_REFERENCE *) eif_realloc (EIF_once_values, EIF_once_count * REFSIZ);
			/* needs malloc; crashes otherwise on some pure C-ansi compiler (SGI)*/
		if (EIF_once_values == (EIF_REFERENCE *) 0) /* Out of memory */
			enomem();
		bzero((EIF_REFERENCE) EIF_once_values, EIF_once_count * REFSIZ);
	} else 
	{
		once = 1;
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
	EIF_END_GET_CONTEXT
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
	
		/*----------*/
		/* cecil.c  */
		/*----------*/
	eif_ignore_invisible = (unsigned char) 0;

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
	/* `clsc_per'; and `plsc_per', `th_alloc'
	 * are set in eif_alloc_init (), inherithed from 
	 * the thread creato, if any. */
	gc_monitor = 0;
	root_obj = (EIF_REFERENCE) 0;
	last_from = (struct chunk *) 0; 
	spoilt_tbl = (struct s_table *) 0;
	gc_ran = 0;
	last_gc_time = 0;
	gc_running = 0;

#ifdef ITERATIVE_MARKING
	path_stack.st_hd = 		(struct stchunk *) 0;	
	path_stack.st_tl = 		(struct stchunk *) 0;	
	path_stack.st_cur = 		(struct stchunk *) 0;	
	path_stack.st_top = 		(EIF_REFERENCE *) 0;			
	path_stack.st_end = 		(EIF_REFERENCE *) 0;			

	parent_expanded_stack.st_hd = 		(struct stchunk *) 0;	
	parent_expanded_stack.st_tl = 		(struct stchunk *) 0;	
	parent_expanded_stack.st_cur = 		(struct stchunk *) 0;	
	parent_expanded_stack.st_top = 		(EIF_REFERENCE *) 0;			
	parent_expanded_stack.st_end = 		(EIF_REFERENCE *) 0;			

#endif	/* ITERATIVE_MARKING */

	g_data.nb_full = 		0L;			
	g_data.nb_partial = 		0L;			
	g_data.mem_used = 		0L;			
	g_data.gc_to = 		0;			
	g_data.status = 		(char) 0;	

	g_stat [0].mem_used = 			0L;		
	g_stat [0].mem_collect = 			0L;			
	g_stat [0].mem_avg = 	   		0L;		
	g_stat [0].real_avg = 			0L;					
	g_stat [0].real_time = 		   	0L;		
	g_stat [0].real_iavg = 			0L;					 
	g_stat [0].real_itime = 			0L;		
	g_stat [0].cpu_avg = 			0.;					 
	g_stat [0].sys_avg = 			0.;		
	g_stat [0].cpu_iavg = 			0.;					 
	g_stat [0].sys_iavg = 			0.;		
	g_stat [0].cpu_time = 			0.;					
	g_stat [0].sys_time = 			0.;		
	g_stat [0].cpu_itime = 			0.;					 
	g_stat [0].sys_itime = 			0.;		

	g_stat [1].mem_used = 			0L;		
	g_stat [1].mem_collect = 			0L;			
	g_stat [1].mem_avg = 	   		0L;		
	g_stat [1].real_avg = 			0L;					
	g_stat [1].real_time = 		   	0L;		
	g_stat [1].real_iavg = 			0L;					 
	g_stat [1].real_itime = 			0L;		
	g_stat [1].cpu_avg = 			0.;					 
	g_stat [1].sys_avg = 			0.;		
	g_stat [1].cpu_iavg = 			0.;					 
	g_stat [1].sys_iavg = 			0.;		
	g_stat [1].cpu_time = 			0.;					
	g_stat [1].sys_time = 			0.;		
	g_stat [1].cpu_itime = 			0.;					 
	g_stat [1].sys_itime = 			0.;		

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
	
	rem_set.st_hd = 		(struct stchunk *) 0;	
	rem_set.st_tl = 		(struct stchunk *) 0;	
	rem_set.st_cur = 		(struct stchunk *) 0;	
	rem_set.st_top = 		(EIF_REFERENCE *) 0;			
	rem_set.st_end = 		(EIF_REFERENCE *) 0;			

#ifdef EIF_REM_SET_OPTIMIZATION
	special_rem_set = (struct special_table *) 0; 
					/* Remembered special table for special objects. */ 
#endif	/* EIF_REM_SET_OPTIMIZATION */

	moved_set.st_hd = 		(struct stchunk *) 0;	
	moved_set.st_tl = 		(struct stchunk *) 0;	
	moved_set.st_cur = 		(struct stchunk *) 0;	
	moved_set.st_top = 		(EIF_REFERENCE *) 0;			
	moved_set.st_end = 		(EIF_REFERENCE *) 0;			

	once_set.st_hd = 		(struct stchunk *) 0;	
	once_set.st_tl = 		(struct stchunk *) 0;	
	once_set.st_cur = 		(struct stchunk *) 0;	
	once_set.st_top = 		(EIF_REFERENCE *) 0;			
	once_set.st_end = 		(EIF_REFERENCE *) 0;			

#ifdef EIF_MEMORY_OPTIMIZATION

	memory_set.st_hd = 		(struct stchunk *) 0;	
	memory_set.st_tl = 		(struct stchunk *) 0;	
	memory_set.st_cur = 		(struct stchunk *) 0;	
	memory_set.st_top = 		(EIF_REFERENCE *) 0;			
	memory_set.st_end = 		(EIF_REFERENCE *) 0;			

#endif	/* EIF_MEMORY_OPTIMIZATION */


		/*----------*/
		/* malloc.c */
		/*----------*/
	gen_scavenge = GS_SET;
	eiffel_usage = 0;
	type_use = 0;
	c_mem = 0;
	/* eif_max_mem is set in eif_alloc_init (); and inherited from
	 * the thread creator, if any. */
	m_data.ml_chunk = 		0;		
	m_data.ml_total = 		0;		
	m_data.ml_used = 		0;		
	m_data.ml_over = 		0;		

	/* For each C and Eiffel memory; we keep track of general informations too. This
	 * enables us to pilot the garbage collector correctly or to call coalescing
	 * over the memory only if it is has a chance to succeed.
	 */
	c_data.ml_chunk = 		0;		
	c_data.ml_total = 		0;		
	c_data.ml_used = 		0;		
	c_data.ml_over = 		0;		
		
	e_data.ml_chunk = 		0;		
	e_data.ml_total = 		0;		
	e_data.ml_used = 		0;		
	e_data.ml_over = 		0;		

	cklst.ck_head = 		(struct chunk *) 0;			
	cklst.ck_tail = 		(struct chunk *) 0;			
	cklst.cck_head = 		(struct chunk *) 0;			
	cklst.cck_tail = 		(struct chunk *) 0;			
	cklst.eck_head = 		(struct chunk *) 0;			
	cklst.eck_tail = 		(struct chunk *) 0;			

		/*----------*/
		/* urgent.c */
		/*----------*/

	urgent_index = -1;

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

	IC = (char *) 0;
	iregs = (struct item **) 0;
	iregsz = 0;  
	argnum = 0;  
	locnum = 0; 
	tagval = 0L;
	inv_mark_table = (char *) 0;


#endif	/* WORKBENCH */	
		/*----------*/
		/* memory.c */
		/*----------*/

	m_largest = 0;
	
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
	
}


rt_public void eif_thr_create (EIF_OBJECT thr_root_obj, EIF_POINTER init_func)
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


rt_public void eif_thr_create_with_args (EIF_OBJECT thr_root_obj, 
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
	routine_ctxt->current = hector_addr (efreeze (thr_root_obj));
	routine_ctxt->routine = init_func;
	routine_ctxt->tid = tid;
	routine_ctxt->addr_n_children = &n_children;
	routine_ctxt->addr_thr_list = &(eif_globals->unfreeze_list);

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
	if (detach != (EIF_BOOLEAN) 5) {
		EIF_THR_ATTR_TYPE attr;
		EIF_THR_ATTR_INIT(attr,priority,policy,detach);
		EIF_THR_CREATE_WITH_ATTR(eif_thr_entry, routine_ctxt, *tid, attr,
								 "Cannot create thread\n");
		EIF_THR_ATTR_DESTROY(attr);
	} else { /* We're called from eif_thr_create */
		EIF_THR_CREATE(eif_thr_entry, routine_ctxt, *tid,
					   "Cannot create thread\n");
	}
	last_child = tid;

	EIF_END_GET_CONTEXT
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
	{
		EIF_GET_CONTEXT

		struct ex_vect *exvect;
		jmp_buf exenv;

		eif_thr_context = routine_ctxt;
		eif_thr_id = routine_ctxt->tid;	/* Initialize here the thread_id */
/* 		EIF_MUTEX_LOCK(eif_rmark_mutex, "Couldn't lock GC mutex"); */
		EIF_MUTEX_LOCK(eif_thr_context->children_mutex, "Locking GC mutex");
		initsig();
		initstk();
		exvect = exset((char *) 0, 0, (char *) 0);
		exvect->ex_jbuf = (char *) exenv;

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
		root_obj = edclone(eif_access(routine_ctxt->current));
/* 		EIF_MUTEX_UNLOCK(eif_rmark_mutex, "Couldn't unlock GC mutex"); */
		EIF_MUTEX_UNLOCK(eif_thr_context->children_mutex, "Unlocking GC mutex");
		{
			/*
			 * Call the `execute' routine of the thread
			 */
			EIF_PROCEDURE execute = (EIF_PROCEDURE) routine_ctxt->routine;
			(execute)(root_obj);
		}
		root_obj = (EIF_REFERENCE) 0;
		EIF_END_GET_CONTEXT
	}
	eif_thr_exit ();
#ifndef SOLARIS_THREADS
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

		/* We need to keep a reference to the children mutex and 
		 * the children condition variable after freeing ressources */
#ifndef EIF_NO_CONDVAR
	EIF_COND_TYPE *chld_cond = eif_thr_context->children_cond; 
#endif /* EIF_NO_CONDVAR */
	EIF_MUTEX_TYPE *chld_mutex = eif_thr_context->children_mutex;

	thr_list_t *ptr, **thr_list = eif_thr_context->addr_thr_list;
	int ret;	/* Return Status of "eifaddr". */
	EIF_REFERENCE terminated = 
		eifaddr (eif_access (eif_thr_context->current), "terminated", &ret);
	if (ret != EIF_CECIL_OK) 
		eraise ("eif_thr_exit", EN_EXT);

	EIF_MUTEX_LOCK(chld_mutex, "Lock parent mutex");

	/* Set the `terminated' field of the twin thread object to True so that
	 * it knows the thread is terminated
	 */

	*terminated = EIF_TRUE;

	/* Add the address of the parent's thread object to its list of
	 * thread objects to unfreeze.
	 * NB: this has to be done under the protection of a mutex
	 */

	if (*thr_list == (thr_list_t *) 0) {
		*thr_list = (thr_list_t *) eif_malloc (sizeof (thr_list_t));
		(*thr_list)->thread = eif_thr_context->current;
		(*thr_list)->next = (thr_list_t *) 0;
	} else {
		ptr = *thr_list;
		while (ptr->next)
			ptr = ptr->next;
		ptr->next = (thr_list_t *) eif_malloc (sizeof (thr_list_t));
		ptr->next->thread = eif_thr_context->current;
		ptr->next->next = (thr_list_t *) 0;
	}

	/* Decrement the number of child threads of the parent */
	*(eif_thr_context->addr_n_children) -= 1;

	reclaim ();							/* Free all allocated memory chunks */

#ifndef EIF_NO_CONDVAR
	EIF_COND_BROADCAST(chld_cond, "Pbl cond_broadcast");
#endif
	EIF_MUTEX_UNLOCK(chld_mutex, "Unlock parent mutex");
	EIF_THR_EXIT(0);
	EIF_END_GET_CONTEXT
}	/* eif_thr_exit ().*/


rt_private void eif_thr_unfreeze_dead(void)
{
	/*
	 * Unfreezes all the thread objects referenced in the list unfreeze_list
	 * (every terminating thread adds its corresponding thread object --of
	 * the parent-- into this list)
	 * NB: must be called under the protection of a mutex
	 */

	EIF_GET_CONTEXT

	thr_list_t *ptr, *thr_list = eif_globals->unfreeze_list;

	while (thr_list) {
		ptr = thr_list;
		eufreeze (eif_access (thr_list->thread));
		/* plsc(); */
		thr_list = thr_list->next;
		eif_free (ptr);
	}

	eif_globals->unfreeze_list = (thr_list_t *) 0;

	EIF_END_GET_CONTEXT
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

	/* Unfreeze all thread objects whose corresponding threads are dead */
	eif_thr_unfreeze_dead();

	EIF_END_GET_CONTEXT
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
	 * variables.  If the platform doesn't support yield() either, this
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

	/* Unfreeze all thread objects whose corresponding threads are dead */
	eif_thr_unfreeze_dead();

	EIF_END_GET_CONTEXT
}

rt_public void eif_thr_join (EIF_POINTER tid)
{
	/*
	 * Invokes thr_join, pthread_join, etc.. depending on the platform.
	 * No such routine exists on VxWorks or Windows, so the Eiffel version
	 * should be used (ie. `join' <-> eif_thr_wait)
	 */

	EIF_GET_CONTEXT

	if (tid != (EIF_POINTER) 0) {
		EIF_THR_JOIN(* (EIF_THR_TYPE *) tid);
	} else {
		eraise ("Trying to join a thread whose ID is NULL", EN_EXT);
	}

	EIF_END_GET_CONTEXT
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
	int status;
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
	int status;
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


/*
 * Class OBJECT_CONTROL externals
 */

rt_public EIF_POINTER eif_thr_freeze (EIF_OBJECT object)
{
	/* This function is used by the class PROXY: the item of the proxy is
	 * frozen so that it can be accessed by any thread any time. It would
	 * be better to protect the access to the item with a mutex, and also
	 * not to freeze it (locking a mutex while the parent's GC is on), but
	 * the performance wouldn't be as good.
	 *
	 * When we return the address of the object, an entry in hec_saved must
	 * point to it (it will be retrieved using hector_addr).
	 */

 	char *frozen = efreeze (object);

	if (!frozen) {
		/* efreeze() refused to freeze the object (probably because it is
		 * a special object) so we freeze it on location with spfreeze()
		 */
		spfreeze (eif_access (object));
		object = eif_adopt (object);
		return (eif_access (object));
	} else {
		/* efreeze() successfully froze the object and created an entry in
		 * the hector saved table.
		 */

		return frozen;
	}
}

rt_public void eif_thr_unfreeze (EIF_OBJECT object)
{
	/* This function unfreezes an object frozen with eif_thr_freeze()
	 * It should work even if the object has been frozen by spfreeze() and
	 * not efreeze()
	 */

	eufreeze (eif_access (object));
}


/*
 * class PROXY externals
 */

rt_public EIF_POINTER eif_thr_proxy_set(EIF_POINTER object)
		/* `object' is actually an EIF_REFERENCE and this function
		 * returns a EIF_OBJECT. However, we keep this signature so as to match the
		 * one on the Eiffel side. -ET */
{
	/* 
	 * Returns a hec_saved entry pointing to the object given as argument
	 * through $ (avoid calls to  RTHP and RTHF in the generated C-code)
	 * and remembers the object in the hector stack so that the GC does not
	 * collect it. -ET
	 */
#ifdef DEBUG
	printf ("eif_thr_proxy_set(%x) returns %x\n", object, hector_addr(object));
#endif
	return  hector_addr(object); /* should it be inlined? -ET */
}

rt_public EIF_REFERENCE eif_thr_proxy_access(EIF_OBJECT proxy)
{
	/*
	 * Returns the address of the actual proxy item.
	 */

	return eif_access (proxy);
}

rt_public void eif_thr_proxy_dispose(EIF_POINTER proxy)
			/* Once again: it is in fact an EIF_OBJECT */
{
	/*
	 * Frees the entry in the hec_saved stack of the proxy item.
	 */

#ifdef DEBUG
	printf("eif_thr_proxy_dispose(%x)\n", proxy);
#endif
	eufreeze (eif_access (proxy)); /* unfreeze the object */
}

#endif /* EIF_THREADS */
