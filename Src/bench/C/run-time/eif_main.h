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

#include "eif_portable.h"
#include "eif_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK long EIF_once_count;			/* Nr. of once routines */
RT_LNK int scount;					/* Maximum dtype */
RT_LNK void eif_alloc_init(void);

#ifdef __cplusplus
}
#endif

#endif
