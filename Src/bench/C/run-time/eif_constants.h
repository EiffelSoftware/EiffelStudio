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

#include <signal.h>

#ifdef __cplusplus
extern "C" {
#endif

	/*----------------*/
	/*  eif_memory.h  */
	/*----------------*/
#define CLSC_PER	0;
	/*------------*/
	/*  except.h  */
	/*------------*/
#define EN_NEX		28			/* Number of internal exceptions */

	/*------------*/
	/*  garcol.h  */
	/*------------*/
/* Algorithm used by the GC to mark the objects. Select one of the
following.
 * By default, recursive marking is selected.
 */
#ifdef VXWORKS
#define ITERATIVE_MARKING		/* Select iterative marking */
#else
/*#define ITERATIVE_MARKING	*/	/* Select iterative marking */
#define HYBRID_MARKING		/* Select combined marking */
/* #define RECURSIVE_MARKING */ /* Select recursive marking */
#endif

/*
 * Garbage collector's statistics
 */
#define GST_NBR		2				/* Number of distinct algorithms */
#define GST_PART	0				/* Index for partial collection stats
*/
#define GST_GEN		1				/* Index for generation collection
stats */
#define	EIF_REFERENCE_BITS	2		/* To divide by sizeof(EIF_REFERENCE). 
								     * Do >> EIF_REFERENCE_BITS instead. 
									 * FIXME: is 3 in 64 bits platforms. */

#define AGE_BITS	4		/* Number of bits to represents the age. */
#define TENURE_MAX	(1<<AGE_BITS)	/* Non reached age */


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

	/*---------*/
	/* debug.c */
	/*---------*/
#ifdef WORKBENCH
#define BP_TABLE_SIZE 1024 /* size of the hash table used to store enabled breakpoints */
#endif

#ifdef __cplusplus
}
#endif

#endif	/* _eif_constants_h_ */
