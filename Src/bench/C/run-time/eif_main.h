/*

 #    #    ##       #    #    #          #    #
 ##  ##   #  #      #    ##   #          #    #
 # ## #  #    #     #    # #  #          ######
 #    #  ######     #    #  # #   ###    #    #
 #    #  #    #     #    #   ##   ###    #    #
 #    #  #    #     #    #    #   ###    #    #

*/

#ifndef _eif_main_h_
#define _eif_main_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_threads.h"
#include "eif_globals.h"

extern long EIF_once_count;			/* Nr. of once routines */
extern long EIF_bonce_count;		/* Nr. of once routines in bytecode */
extern void once_init (void);		/* Initialization and creation of once keys */

extern void dinterrupt(void);
extern void dserver(void);
extern void eif_alloc_init();
extern int in_assertion;
extern char *ename;				/* Name of the Eiffel program running */
extern int cc_for_speed;		/* Optimized for speed or for memory */
extern int scount;				/* Maximum dtype */
#ifdef __cplusplus
}
#endif

#endif
