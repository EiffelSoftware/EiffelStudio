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
#include "portable.h"

extern EIF_CHARACTER chconv(EIF_INTEGER i);
extern EIF_INTEGER chcode(EIF_CHARACTER c);
extern EIF_POINTER conv_pp(EIF_POINTER p);
extern EIF_INTEGER conv_pi(EIF_POINTER p);
extern EIF_REAL conv_ir(EIF_INTEGER v);
extern EIF_INTEGER conv_ri(EIF_REAL v);
extern EIF_REAL conv_dr (EIF_DOUBLE d);
extern EIF_INTEGER conv_di(EIF_DOUBLE d);
extern EIF_INTEGER bointdiv(EIF_INTEGER n1, EIF_INTEGER n2);
extern EIF_INTEGER upintdiv(EIF_INTEGER n1, EIF_INTEGER n2);
extern EIF_CHARACTER chupper(EIF_CHARACTER c);
extern EIF_CHARACTER chlower(EIF_CHARACTER c);
extern EIF_BOOLEAN chis_upper(EIF_CHARACTER c);
extern EIF_BOOLEAN chis_lower(EIF_CHARACTER c);
extern EIF_BOOLEAN chis_digit(EIF_CHARACTER c);
extern EIF_BOOLEAN chis_alpha(EIF_CHARACTER c);
extern EIF_INTEGER eschar_size(void);
extern EIF_INTEGER esreal_size(void);
extern EIF_INTEGER esint_size(void);
extern EIF_INTEGER esdouble_size(void);
extern EIF_INTEGER eif_system (char *s);
extern EIF_INTEGER eif_putenv (EIF_OBJ v, EIF_OBJ k);
extern EIF_OBJ eif_getenv(EIF_OBJ k);
extern char *arycpy(char *area, EIF_INTEGER i, EIF_INTEGER j, EIF_INTEGER k);

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
