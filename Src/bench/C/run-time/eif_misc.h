/*

 #    #     #     ####    ####           #    #
 ##  ##     #    #       #    #          #    #
 # ## #     #     ####   #               ######
 #    #     #         #  #        ###    #    #
 #    #     #    #    #  #    #   ###    #    #
 #    #     #     ####    ####    ###    #    #

	Declarations for miscellenaous externals

*/

#ifndef _eif_misc_h_
#define _eif_misc_h_

#ifdef __cplusplus
extern "C" {
#endif

#include "eif_cecil.h"
#include "eif_portable.h"

RT_LNK EIF_CHARACTER chconv(EIF_INTEGER i);
RT_LNK EIF_INTEGER chcode(EIF_CHARACTER c);
RT_LNK EIF_POINTER conv_pp(EIF_POINTER p);
RT_LNK EIF_INTEGER conv_pi(EIF_POINTER p);
RT_LNK EIF_REAL conv_ir(EIF_INTEGER v);
RT_LNK EIF_INTEGER conv_ri(EIF_REAL v);
RT_LNK EIF_REAL conv_dr (EIF_DOUBLE d);
RT_LNK EIF_INTEGER conv_di(EIF_DOUBLE d);
RT_LNK EIF_INTEGER bointdiv(EIF_INTEGER n1, EIF_INTEGER n2);
RT_LNK EIF_INTEGER upintdiv(EIF_INTEGER n1, EIF_INTEGER n2);
RT_LNK EIF_CHARACTER chupper(EIF_CHARACTER c);
RT_LNK EIF_CHARACTER chlower(EIF_CHARACTER c);
RT_LNK EIF_BOOLEAN chis_upper(EIF_CHARACTER c);
RT_LNK EIF_BOOLEAN chis_lower(EIF_CHARACTER c);
RT_LNK EIF_BOOLEAN chis_digit(EIF_CHARACTER c);
RT_LNK EIF_BOOLEAN chis_alpha(EIF_CHARACTER c);
RT_LNK EIF_INTEGER eschar_size(void);
RT_LNK EIF_INTEGER esreal_size(void);
RT_LNK EIF_INTEGER esint_size(void);
RT_LNK EIF_INTEGER esdouble_size(void);
RT_LINK EIF_INTEGER eif_system (char *s);
RT_LINK EIF_INTEGER eif_putenv (EIF_OBJ v, EIF_OBJ k);
RT_LINK EIF_OBJ eif_getenv(EIF_OBJ k);
RT_LINK EIF_INTEGER eif_safe_putenv (EIF_OBJ v, EIF_OBJ k); /* Safe Eiffel putenv dealing only with env. var. */

RT_LNK char *arycpy(char *area, EIF_INTEGER i, EIF_INTEGER j, EIF_INTEGER k);

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
