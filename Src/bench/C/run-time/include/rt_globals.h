/*

 #####    #####
 #    #     #
 #    #     #
 #####      #
 #   #      #
 #    #     #   #######

  ####   #        ####   #####     ##    #        ####          #    #
 #    #  #       #    #  #    #   #  #   #       #              #    #
 #       #       #    #  #####   #    #  #        ####          ######
 #  ###  #       #    #  #    #  ######  #            #   ###   #    #
 #    #  #       #    #  #    #  #    #  #       #    #   ###   #    #
  ####   ######   ####   #####   #    #  ######   ####    ###   #    #

	Private runtime global variables handling.

*/

#ifndef _rt_globals_h_
#define _rt_globals_h_

#include "eif_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef EIF_THREADS

/******************************************
 *    Traditional run-time definitions    *
 ******************************************/

#define RT_GET_CONTEXT

#else

/****************************************
 *    Reentrant run-time definitions    *
 ****************************************/

#endif

#ifdef __cplusplus
}
#endif

#endif

