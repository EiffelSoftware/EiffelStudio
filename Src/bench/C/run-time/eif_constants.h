/*

 ######     #    ######
 #          #    #
 #####      #    #####
 #          #    #
 #          #    #
 ######     #    #      #######

  ####   ####  #    #  #### #####  ##   #    # #####  ####      #    #
 #    # #    # ##   # #       #   #  #  ##   #   #   #          #    #
 #      #    # # #  #  ####   #  #    # # #  #   #    ####      ######
 #      #    # #  # #      #  #  ###### #  # #   #        # ### #    #
 #    # #    # #   ## #    #  #  #    # #   ##   #   #    # ### #    #
  ####   ####  #    #  ####   #  #    # #    #   #    ####  ### #    #

	Constants used in global variable definitions.

*/

#ifndef _eif_constants_h_
#define _eif_constants_h_

#ifdef __cplusplus
extern "C" {
#endif

	/*---------*/
	/* sig.c */
	/*---------*/
/* Make sure EIF_NSIG is defined. If not, set it to 32 (cross your fingers)--RAM */
#ifndef NSIG
#ifdef EIF_WIN32
#define EIF_NSIG 23
#else	/* EIF_WIN32 */
#define EIF_NSIG 32		/* Number of signals (access from 1 to EIF_NSIG-1) */
#endif /* EIF_WIN32 */
#else	/* !NSIG */

#ifdef EIF_LINUXTHREADS
#define EIF_NSIG	32	/* In MT-mode, it is better not to deal 
						 * with signals above 32. */
#else	/* EIF_THREADS */
#define	EIF_NSIG	NSIG	/* EIF_NSIG is NSIG in a single threaded runtime. */
#endif	/* EIF_THREADS */

#endif	/* !NSIG */

#define SIGSTACK	200		/* Size of FIFO stack for signal buffering */

	/*------------*/
	/*  except.h  */
	/*------------*/
#define EN_NEX		29			/* Number of internal exceptions */

	/*-------------*/
 	/*  pattern.c  */
	/*-------------*/
#define ASIZE 256     /* The alphabet's size */


	/*---------*/
	/*  out.c  */
	/*---------*/
#define TAG_SIZE 512  /* Maximum size for a single tagged expression */

	/*------------*/
	/*  string.c  */
	/*------------*/
#define	MAX_NUM_LEN	256	/* Maximum length for an ASCII number. */


#ifdef __cplusplus
}
#endif

#endif	/* _eif_constants_h_ */
