/*

 #    #    ##       #    #    #          #    #
 ##  ##   #  #      #    ##   #          #    #
 # ## #  #    #     #    # #  #          ######
 #    #  ######     #    #  # #   ###    #    #
 #    #  #    #     #    #   ##   ###    #    #
 #    #  #    #     #    #    #   ###    #    #

*/

#ifndef _rt_main_h_
#define _rt_main_h_

#include "eif_main.h"

#ifdef __cplusplus
extern "C" {
#endif

extern long EIF_bonce_count;		/* Nr. of once routines in bytecode */
extern void once_init (void);		/* Initialization and creation of once keys */
extern char dinterrupt(void);
extern void dserver(void);
extern int eif_no_reclaim;		/* Call reclaim ion termination? */
extern int cc_for_speed;		/* Optimized for speed or for memory */
extern char *starting_working_directory;

#ifdef EIF_WIN32
/* Console management for Windows */
extern void eif_console_cleanup (EIF_BOOLEAN);
extern void eif_show_console (void);					/* Show the DOS console if needed */
#endif

#ifdef __cplusplus
}
#endif

#endif
