/*
--|----------------------------------------------------------------
--| Eiffel runtime header file
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|     http://www.eiffel.com
--|----------------------------------------------------------------
*/

/*
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
#define conv_ri64(v) ((EIF_INTEGER_64) (v))
#define conv_dr(d) ((EIF_REAL) (d))
#define conv_di(d) ((EIF_INTEGER) (d))
#define conv_di64(d) ((EIF_INTEGER_64) (d))

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
#define esint8_size ((EIF_INTEGER) BYTSIZ*CHRSIZ)
#define esint16_size ((EIF_INTEGER) BYTSIZ*I16SIZ)
#define esint_size ((EIF_INTEGER) BYTSIZ*LNGSIZ)
#define esint64_size ((EIF_INTEGER) BYTSIZ*I64SIZ)
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
#define eif_bit_test(t,i,n)	(EIF_TEST((i)&((t)1 << n)))

RT_LNK EIF_INTEGER eif_system (char *s);
RT_LNK void eif_system_asynchronous (char *s);
RT_LNK char * eif_getenv(char * k);

RT_LNK EIF_REFERENCE arycpy(EIF_REFERENCE area, EIF_INTEGER i, EIF_INTEGER j, EIF_INTEGER k);

#ifdef EIF_WINDOWS
/* DLL declarations */
#ifdef EIF_IL_DLL
#define eif_load_dll(name)	LoadLibrary((LPCSTR) name);
#else
RT_LNK HMODULE eif_load_dll(char *module_name);
RT_LNK void eif_free_dlls(void);
#endif
#endif

#ifndef EIF_WINDOWS
RT_LNK pid_t eiffel_fork(void);
#endif

#ifdef __cplusplus
}
#endif

#endif
