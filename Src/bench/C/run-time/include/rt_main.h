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
extern char *ename;				/* Name of the Eiffel program running */
extern int eif_no_reclaim;		/* Call reclaim ion termination? */
extern int cc_for_speed;		/* Optimized for speed or for memory */
extern char *starting_working_directory;

#ifdef __cplusplus
}
#endif

#endif
