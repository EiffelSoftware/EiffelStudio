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

extern void epop(register struct stack *stk, register int nb_items);			/* Pops values off the local stack */
extern char **eget(register int num);		/* Get another chunk for local variables */
extern void eback(register char **top);		/* Get back to the previous stack chunk */
extern void initstk(void);		/* Initialize local stacks */

#ifdef __cplusplus
}
#endif

#endif
