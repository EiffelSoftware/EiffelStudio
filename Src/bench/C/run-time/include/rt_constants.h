/*

 #####    #####
 #    #     #
 #    #     #
 #####      #
 #   #      #
 #    #     #   #######

  ####   ####  #    #  #### #####  ##   #    # #####  ####      #    #
 #    # #    # ##   # #       #   #  #  ##   #   #   #          #    #
 #      #    # # #  #  ####   #  #    # # #  #   #    ####      ######
 #      #    # #  # #      #  #  ###### #  # #   #        # ### #    #
 #    # #    # #   ## #    #  #  #    # #   ##   #   #    # ### #    #
  ####   ####  #    #  ####   #  #    # #    #   #    ####  ### #    #

	Constants used in global variable definitions.

*/

#ifndef _rt_constants_h_
#define _rt_constants_h_

#include <signal.h>

#ifdef __cplusplus
extern "C" {
#endif

	/*----------------*/
	/*  eif_memory.h  */
	/*----------------*/
#define CLSC_PER	20

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


	/*---------*/
	/* debug.c */
	/*---------*/
#ifdef WORKBENCH
#define BP_TABLE_SIZE 1024 /* size of the hash table used to store enabled breakpoints */
#endif

	/*--------*/
	/* file.c */
	/*--------*/
#define FILE_TYPE_MAX 4		/* max size of fopen type string (like "a+b") */


#ifdef __cplusplus
}
#endif

#endif	/* _eif_constants_h_ */
