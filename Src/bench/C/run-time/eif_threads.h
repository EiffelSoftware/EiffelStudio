/*

 ######     #    ######           #####  #    #  #####   ######    ##    #####    ####           #    #
 #          #    #                  #    #    #  #    #  #        #  #   #    #  #               #    #
 #####      #    #####              #    ######  #    #  #####   #    #  #    #   ####           ######
 #          #    #                  #    #    #  #####   #       ######  #    #       #   ###    #    #
 #          #    #                  #    #    #  #   #   #       #    #  #    #  #    #   ###    #    #
 ######     #    #      #######     #    #    #  #    #  ######  #    #  #####    ####    ###    #    #

	Thread management routines.

*/

#ifdef EIF_THREADS
#ifndef _eif_threads_h_
#define _eif_threads_h_

#ifndef EIF_REENTRANT		/* Make sure we have reentrant run-time */
#define EIF_REENTRANT
#endif

#ifdef POSIX_THREADS
#define EIF_THREAD_T pthread_t
#define EIF_MUTEX_T pthread_mutex_t
#else
#ifdef WIN32
#define EIF_THREAD_T HANDLE
#define EIF_MUTEX_T			/* ? */
#else
#ifdef SOLARIS_THREADS
#define EIF_THREAD_T thread_t
#define EIF_MUTEXT_T mutex_t
#endif
#endif
#endif

extern eif_global_context_t *eif_get_new_context(EIF_THREAD_T);


#endif	/* _eif_threads_h_ */
#endif	/* EIF_THREADS */
