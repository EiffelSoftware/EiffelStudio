/*

######  #  ######	     ####   ######  #####  #    #  #####       #    #
#       #  #            #       #         #    #    #  #    #      #    #
#####   #  #####         ####   #####     #    #    #  #    #      ######
#       #  #                 #  #         #    #    #  #####  ###  #    #
#       #  #                 #  #         #    #    #  #      ###  #    #
######  #  #    #######  ####   ######    #     ####   #      ###  #    #

	Setup macros for Eiffel run-time.

*/

#include "eif_except.h"		/* Exception vectors definition */
#include "eif_sig.h"		/* initsig() */
#include "eif_local.h"		/* initstk(), local stacks */
#include "eif_cecil.h"		/* eif_rtinit(), run-time initialization */

#ifdef WORKBENCH
#include "eif_interp.h"		/* xinitint(), interpreter initialization */
#endif

#ifdef __cplusplus
extern "C" {
#endif

/*
 * The following macros are available :
 *
 * EIF_INITIALIZE(fail_func)
 *    Initializes Eiffel run-time and registers calling thread
 *    for Eiffel use.
 *    First initialization of the run-time, use this only once, at startup.
 *    fail_func() is called when an uncatched exception happens.
 * NB: Except if you are using VxWorks, the function that calls this macro
 * should have these three variables defined: argc, argv, envp. Typically:
 *
 *     int main(int argc, char **argv, char ** envp) { ...
 *
 * EIF_REGISTER_THREAD(fail_func)
 *    'Registers' a thread spawned outside Eiffel in order to enable
 *    it to call Eiffel programs.
 *    Thread's own view on the run-time initialization.
 *    Each thread spawned outside Eiffel should use this
 *    macro before running Eiffel code.
 *    This assumes that some thread (considered as 'root')
 *    called EIF_INITIALIZE before.
 *    Also, EIF_DISPOSE_ALL should not be called
 *    as long as some threads may need Eiffel registering.
 *    fail_func() is called when an uncatched exception happens.
 *
 * EIF_THREAD_DISPOSE
 *    'Unregisters' a thread for Eiffel use.
 *    Macro to use when a thread does not need Eiffel facilities anymore.
 *    This should release ANY resources the thread allocated.
 *
 * EIF_DISPOSE_ALL
 *    Removes Eiffel ressources for the whole process.
 *    This macro releases all Eiffel ressources.
 *    When called, a new call to EIF_INITIALIZE needs to be
 *    done in order to be able to use Eiffel possibilities again.
 *    Don't spawn any thread that needs to use Eiffel stuff after
 *    calling this (unless you call EIF_INITIALIZE again).
 *    Note that this macro might be called by any thread.
 *    Usually the 'root' one does it, you may call it from
 *    any thread, if you know what you are doing...
 *    If another thread still runs Eiffel after a call to this
 *    macro, it'll soon terminate execution with a panic.
 */


/* -------------------------------
 * --    Extern declarations    --
 * ------------------------------- */

extern void egc_init_plug ();		/* Defined in E1/eplug.c, and
									 * called in the CECIL macros. */
/* -------------------------------
 * --    Primary definitions    --
 * ------------------------------- */

/*
 * Very basic stuff...
 * Skip this section if you don't want to know what
 * is called to initialize Eiffel run-time.
 */

#ifndef _CRAY
#define EIF_RT_BASIC_SETUP(fail_func) \
	EIF_GET_CONTEXT \
	struct ex_vect *exvect; \
	jmp_buf exenv; \
	egc_init_plug(); \
	initsig(); \
	initstk(); \
	exvect = exset((char *) 0, 0, (char *) 0); \
	(exvect->ex_jbuf) = &exenv; \
	if ( ((echval) = setjmp(exenv)) ) \
		fail_func(); \
	if (root_obj == (char *)0) \
		root_obj = cmalloc(1);
#else	/* !_CRAY */
#define EIF_RT_BASIC_SETUP(fail_func) \
	EIF_GET_CONTEXT \
	struct ex_vect *exvect; \
	jmp_buf exenv; \
	egc_init_plug(); \
	initsig(); \
	initstk(); \
	exvect = exset((char *) 0, 0, (char *) 0); \
	(exvect->ex_jbuf) = &exenv; \
	if ( setjmp(exenv)) \
		fail_func(); \
	if (root_obj == (char *)0) \
		root_obj = cmalloc(1);
#endif	/* !_CRAY */

#define EIF_RT_BASIC_CLEANUP \
	reclaim(); \
}


#ifdef EIF_THREADS

/* ----------------------------------------------------
 * --    Definition of the macros in a MT context    --
 * ---------------------------------------------------- */

#ifdef VXWORKS
#define EIF_INITIALIZE(fail_func) \
	eif_alloc_init (); \
	eif_thr_init_root(); \
{ \
	EIF_RT_BASIC_SETUP(fail_func) \
	eif_rtinit(0, NULL, NULL);
#else
#define EIF_INITIALIZE(fail_func) \
	eif_alloc_init(); \
	eif_thr_init_root(); \
{ \
	EIF_RT_BASIC_SETUP(fail_func) \
	eif_rtinit(argc, argv, envp);
#endif

#ifdef WORKBENCH
#define EIF_REGISTER_THREAD(fail_func) \
	eif_thr_register(); \
	eif_set_thr_context ();	\
{ \
	EIF_RT_BASIC_SETUP(fail_func) \
	xinitint();
#else
#define EIF_REGISTER_THREAD(fail_func) \
	eif_thr_register(); \
	eif_set_thr_context ();\
{ \
	EIF_RT_BASIC_SETUP(fail_func)
#endif


#define EIF_THREAD_DISPOSE \
	EIF_RT_BASIC_CLEANUP \
}


#define EIF_DISPOSE_ALL \
	EIF_RT_BASIC_CLEANUP \
	EIF_TSD_DESTROY(eif_global_key,"Couldn't destroy context key"); \
}


#else

/* -------------------------------------------------------------
 * --    Definition of the macros in a traditional context    --
 * ------------------------------------------------------------- */

#define EIF_INITIALIZE(fail_func) \
	eif_alloc_init(); \
{ \
	EIF_RT_BASIC_SETUP(fail_func) \
	eif_rtinit(argc, argv, envp);

#define EIF_REGISTER_THREAD(fail_func) \
	Oops, trying to use multithreading facilities without proper flags

#define EIF_THREAD_DISPOSE \
	Oops, trying to use multithreading facilities without proper flags

#define EIF_DISPOSE_ALL \
	EIF_RT_BASIC_CLEANUP

#ifdef __cplusplus
}
#endif

#endif	/* EIF_THREADS */
