/*

 #       #    #    ##    #       #        ####    ####           #    #
 #       ##  ##   #  #   #       #       #    #  #    #          #    #
 #       # ## #  #    #  #       #       #    #  #               ######
 #       #    #  ######  #       #       #    #  #        ###    #    #
 #       #    #  #    #  #       #       #    #  #    #   ###    #    #
 ######  #    #  #    #  ######  ######   ####    ####    ###    #    #

*/

#ifndef _rt_lmalloc_h_
#define _rt_lmalloc_h_

#include "eif_lmalloc.h"

#ifdef __cplusplus
extern "C" {
#endif

extern int is_in_lm (void *ptr);
extern void eif_lm_display (void);
extern int eif_lm_free (void);

#ifdef __cplusplus
}
#endif

#endif
