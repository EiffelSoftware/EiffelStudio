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

RT_LNK long EIF_once_count;			/* Nr. of once routines */
RT_LNK long EIF_bonce_count;		/* Nr. of once routines in bytecode */
extern void once_init (void);		/* Initialization and creation of once keys */
extern void dinterrupt(void);
extern void dserver(void);
extern void eif_alloc_init();
extern char *ename;				/* Name of the Eiffel program running */
extern int cc_for_speed;		/* Optimized for speed or for memory */
RT_LNK int scount;				/* Maximum dtype */
extern char *starting_working_directory;

#ifdef __cplusplus
}
#endif

#endif
