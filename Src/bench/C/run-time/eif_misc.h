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

#include "eif_cecil.h"
#include "eif_portable.h"
#include <ctype.h>
#ifdef EIF_WIN32
#include <stdlib.h>
#endif	/* EIF_WIN32 */
#ifdef EIF_WINDOWS
#include <windows.h> /* DLL declarations */
#endif

#include <math.h>
#include <ctype.h>

#ifdef __cplusplus
extern "C" {
#endif

#define chconv(i) ((EIF_CHARACTER) (i))
#define chcode(c) ((EIF_INTEGER) (c))
#define conv_pi(p) ((EIF_INTEGER) (p))
#define conv_ri(v) ((EIF_INTEGER) (v))
#define conv_dr(d) ((EIF_REAL) (d))
#define conv_di(d) ((EIF_INTEGER) (d))

RT_LNK EIF_INTEGER bointdiv(EIF_INTEGER n1, EIF_INTEGER n2);
RT_LNK EIF_INTEGER upintdiv(EIF_INTEGER n1, EIF_INTEGER n2);

#define chupper(c) ((EIF_CHARACTER) toupper(c))
#define chlower(c) ((EIF_CHARACTER) tolower(c))
#define chis_upper(c) (EIF_TEST(isupper(c)))
#define chis_lower(c) (EIF_TEST(islower(c)))
#define chis_digit(c) (EIF_TEST(isdigit(c)))
#define chis_alpha(c) (EIF_TEST(isalpha(c)))

#define esbool_size ((EIF_INTEGER) BYTSIZ*CHRSIZ)
#define eschar_size ((EIF_INTEGER) BYTSIZ*CHRSIZ)
#define esreal_size ((EIF_INTEGER) BYTSIZ*FLTSIZ)
#define esint_size ((EIF_INTEGER) BYTSIZ*LNGSIZ)
#define esptr_size ((EIF_INTEGER) BYTSIZ*PTRSIZ)
#define esdouble_size ((EIF_INTEGER) BYTSIZ*DBLSIZ)

#define float_cos(x)	(cos ((EIF_DOUBLE) (x)))
#define float_acos(x)	(acos ((EIF_DOUBLE) (x)))
#define float_fabs(x)	(fabs ((EIF_DOUBLE) (x)))
#define float_ceil(x)	(ceil ((EIF_DOUBLE) (x)))
#define float_floor(x)	(floor ((EIF_DOUBLE) (x)))
#define float_log10(x)	(log10 ((EIF_DOUBLE) (x)))
#define float_log(x)	(log ((EIF_DOUBLE) (x)))
#define float_sqrt(x)	(sqrt ((EIF_DOUBLE) (x)))
#define float_tan(x)	(tan ((EIF_DOUBLE) (x)))
#define float_atan(x)	(atan ((EIF_DOUBLE) (x)))
#define float_sin(x)	(sin ((EIF_DOUBLE) (x)))
#define float_asin(x)	(asin ((EIF_DOUBLE) (x)))

#define eif_bit_and(i,j)			((i)&(j))
#define eif_bit_or(i,j)				((i)|(j))
#define eif_bit_xor(i,j)			((i)^(j))
#define eif_bit_not(i)				(~(i))
#define eif_bit_shift_left(i,n)		((i)<<(n))
#define eif_bit_shift_right(i,n)	((i)>>(n))
#define eif_bit_test(i,n)			(EIF_TEST((i)&(1 << n)))

RT_LNK EIF_INTEGER eif_system (char *s);
RT_LNK void eif_system_asynchronous (char *s);
RT_LNK EIF_INTEGER eif_putenv (char * v, char * k);
RT_LNK char * eif_getenv(char * k);
RT_LNK EIF_INTEGER eif_safe_putenv (char *v, char *k); /* Safe Eiffel putenv dealing only with env. var. */

RT_LNK EIF_REFERENCE arycpy(EIF_REFERENCE area, EIF_INTEGER i, EIF_INTEGER j, EIF_INTEGER k);

#ifdef EIF_WINDOWS
/* DLL declarations */
RT_LNK HMODULE eif_load_dll(char *module_name);
RT_LNK void eif_free_dlls(void);

extern char **_argv;
#endif

#ifdef __cplusplus
}
#endif

#endif
