/*

 #        ####    ####     ##    #               #    #
 #       #    #  #    #   #  #   #               #    #
 #       #    #  #       #    #  #               ######
 #       #    #  #       ######  #        ###    #    #
 #       #    #  #    #  #    #  #        ###    #    #
 ######   ####    ####   #    #  ######   ###    #    #

	Declarations for local variable stack handling.
*/

#ifndef _local_h_
#define _local_h_

#ifdef __cplusplus
extern "C" {
#endif

extern void epop();			/* Pops values off the local stack */
extern char **eget();		/* Get another chunk for local variables */
extern void eback();		/* Get back to the previous stack chunk */
extern void initstk();		/* Initialize local stacks */

#ifdef __cplusplus
}
#endif

#endif
