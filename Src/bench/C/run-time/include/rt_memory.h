/*

 #    #  ######  #    #   ####   #####    #   #          #    #
 ##  ##  #       ##  ##  #    #  #    #    # #           #    #
 # ## #  #####   # ## #  #    #  #    #     #            ######
 #    #  #       #    #  #    #  #####      #     ###    #    #
 #    #  #       #    #  #    #  #   #      #     ###    #    #
 #    #  ######  #    #   ####   #    #     #     ###    #    #

*/

#ifndef _rt_memory_h_
#define _rt_memory_h_

#include "eif_memory.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_THREADS
extern EIF_LW_MUTEX_TYPE *eif_memory_mutex;
#endif

#ifdef __cplusplus
}
#endif

#endif
