/*

 #    #     #     ####    ####           #    #
 ##  ##     #    #       #    #          #    #
 # ## #     #     ####   #               ######
 #    #     #         #  #        ###    #    #
 #    #     #    #    #  #    #   ###    #    #
 #    #     #     ####    ####    ###    #    #

	Declarations for miscellenaous externals

*/

#ifndef _misc_h_
#define _misc_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "cecil.h"

extern EIF_OBJ eif_getenv(EIF_OBJ k);
extern EIF_INTEGER eif_putenv (EIF_OBJ v, EIF_OBJ k);
extern EIF_INTEGER eif_system (char *s);

#ifdef EIF_WINDOWS

/* DLL declarations */
#include <windows.h>

extern HANDLE eif_load_dll(char *module_name);
extern void eif_free_dlls(void);

extern char **_argv;
#endif

#ifdef __cplusplus
}
#endif

#endif
