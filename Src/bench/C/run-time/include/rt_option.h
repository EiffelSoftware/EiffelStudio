/*

  ####   #####    #####     #     ####   #    #          #    #
 #    #  #    #     #       #    #    #  ##   #          #    #
 #    #  #    #     #       #    #    #  # #  #          ######
 #    #  #####      #       #    #    #  #  # #   ###    #    #
 #    #  #          #       #    #    #  #   ##   ###    #    #
  ####   #          #       #     ####   #    #   ###    #    #

	Private data for option.c
*/

#ifndef _rt_option_h_
#define _rt_option_h_

#include "eif_option.h"
#include "rt_threads.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
extern EIF_LW_MUTEX_TYPE *eif_trace_mutex;
#endif

extern void exitprf(void);				/* Saves table as textfile */

#ifdef __cplusplus
}
#endif

#endif

