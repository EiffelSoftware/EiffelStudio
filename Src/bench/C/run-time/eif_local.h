/*

 #        ####    ####     ##    #               #    #
 #       #    #  #    #   #  #   #               #    #
 #       #    #  #       #    #  #               ######
 #       #    #  #       ######  #        ###    #    #
 #       #    #  #    #  #    #  #        ###    #    #
 ######   ####    ####   #    #  ######   ###    #    #

	Declarations for local variable stack handling.
*/

#ifndef _eif_local_h_
#define _eif_local_h_

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK void epop(register struct stack *stk, register int nb_items);			/* Pops values off the local stack */
#ifdef ISE_GC
RT_LNK char **eget(register int num);		/* Get another chunk for local variables */
RT_LNK void eback(register char **top);		/* Get back to the previous stack chunk */
#endif
RT_LNK void initstk(void);		/* Initialize local stacks */

#ifdef __cplusplus
}
#endif

#endif
