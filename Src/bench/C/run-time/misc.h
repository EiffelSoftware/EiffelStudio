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

extern EIF_OBJ eif_getenv();
extern EIF_INTEGER eif_putenv ();
extern EIF_INTEGER eif_system ();

#ifdef EIF_WINDOWS

/* DLL declarations */
#include <windows.h>

extern HANDLE eif_load_dll();
extern void eif_free_dlls();

extern char **_argv;
#endif

#ifdef __cplusplus
}
#endif

#endif
