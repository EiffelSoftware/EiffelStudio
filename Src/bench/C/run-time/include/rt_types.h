/*

 ######     #    ######
 #          #    #
 #####      #    #####
 #          #    #
 #          #    #
 ######     #    #      #######

 #####   #   #  #####   ######   ####           #    #
   #      # #   #    #  #       #               #    #
   #       #    #    #  #####    ####           ######
   #       #    #####   #            #   ###    #    #
   #       #    #       #       #    #   ###    #    #
   #       #    #       ######   ####    ###    #    #

	Structures and types defining global variables.
	All type definitions are concentrates here because we need
	to put them in a context when running multithreaded apps.

*/

#ifndef _rt_types_h_
#define _rt_types_h_

#include "eif_types.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
	/* Structure used for keep stacks that are thread specific, so GC knows about all
	 * stacks in all threads and traverse them when performing a collection. */
struct stack_list {
	int count;						/* Number of stacks in Current */
	int capacity;					/* Number of possible stacks in Current */
	union {
		void **stack;				/* Array of stack */
		struct stack **sstack;		/* Typed array of stack - GC stack */
		struct xstack **xstack;		/* Typed array of xtack - exception stack */
#ifdef WORKBENCH
		struct opstack **opstack;	/* Typed array of opstack - interpreter */
#endif
	} threads;
};

#endif

#ifdef __cplusplus
}
#endif

#endif	 /* _rt_types_h */
