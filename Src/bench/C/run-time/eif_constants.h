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

#include <signal.h>

	/*------------*/
	/*  except.h  */
	/*------------*/
#define EN_NEX		26			/* Number of internal exceptions */

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
/*#define ITERATIVE_MARKING		/* Select iterative marking */
/*#define HYBRID_MARKING		/* Select combined marking */
#define RECURSIVE_MARKING
#endif

/*
 * Garbage collector's statistics
 */
#define GST_NBR		2				/* Number of distinct algorithms */
#define GST_PART	0				/* Index for partial collection stats
*/
#define GST_GEN		1				/* Index for generation collection
stats */
#define AGE_BITS	4				/* How many bits are used to store
age */
#define TENURE_MAX	(1<<AGE_BITS)	/* Non reached age */


	/*------------*/
	/*  malloc.c  */
	/*------------*/
#define NBLOCKS			26		/* Number of block lists (max size is 2^27-1) */


	/*-------------*/
 	/*  pattern.c  */
	/*-------------*/
#define ASIZE 256     /* The alphabet's size */


	/*---------*/
	/*  out.c  */
	/*---------*/
#define TAG_SIZE 512  /* Maximum size for a single tagged expression */


	/*---------*/
	/* sig.c */
	/*---------*/
/* Make sure NSIG is defined. If not, set it to 32 (cross your fingers)--RAM */
#ifndef NSIG
#ifdef EIF_WIN32
#define NSIG 23
#else
#define NSIG 32		/* Number of signals (acess from 1 to NSIG-1) */
#endif
#endif

#define SIGSTACK	200		/* Size of FIFO stack for signal buffering */

#ifdef __cplusplus
}
#endif

#endif	/* _eif_constants_h_ */
