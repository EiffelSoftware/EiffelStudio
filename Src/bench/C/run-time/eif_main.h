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

#ifdef EIF_WIN32
#include <windows.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK long EIF_once_count;			/* Nr. of once routines */
RT_LNK int scount;					/* Maximum dtype */
RT_LNK void eif_alloc_init(void);

#ifdef EIF_WIN32
RT_LNK void get_argcargv (int *argc, char ***argv);
RT_LNK void free_argv (char ***argv);
RT_LNK HANDLE ghInstance;
RT_LNK HINSTANCE eif_hInstance;
RT_LNK HINSTANCE eif_hPrevInstance;
RT_LNK LPSTR eif_lpCmdLine;
RT_LNK int eif_nCmdShow;
#endif

#ifdef __cplusplus
}
#endif

#endif
