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

#include "cecil.h"

extern EIF_OBJ eif_getenv();
extern EIF_INTEGER eif_putenv ();
extern EIF_INTEGER eif_system ();

#ifdef __WINDOWS_386__

/* DLL declarations */

#include <windows.h>

extern HANDLE eif_load_dll();
extern void eif_free_dlls();

#endif

#endif
