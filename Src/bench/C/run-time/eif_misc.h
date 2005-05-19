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
#ifdef EIF_WINDOWS
#include <stdlib.h>
#endif	/* EIF_WINDOWS */
#ifdef EIF_WINDOWS
#include <windows.h> /* DLL declarations */
#endif

#ifdef __cplusplus
extern "C" {
#endif

RT_LNK EIF_INTEGER bointdiv(EIF_INTEGER n1, EIF_INTEGER n2);
RT_LNK EIF_INTEGER upintdiv(EIF_INTEGER n1, EIF_INTEGER n2);

#define esbool_size ((EIF_INTEGER) BYTSIZ*CHRSIZ)
#define eschar_size ((EIF_INTEGER) BYTSIZ*CHRSIZ)
#define esreal32_size ((EIF_INTEGER) BYTSIZ*R32SIZ)
#define esuint8_size ((EIF_INTEGER) BYTSIZ*CHRSIZ)
#define esuint16_size ((EIF_INTEGER) BYTSIZ*I16SIZ)
#define esuint32_size ((EIF_INTEGER) BYTSIZ*LNGSIZ)
#define esuint64_size ((EIF_INTEGER) BYTSIZ*I64SIZ)
#define esint8_size ((EIF_INTEGER) BYTSIZ*CHRSIZ)
#define esint16_size ((EIF_INTEGER) BYTSIZ*I16SIZ)
#define esint32_size ((EIF_INTEGER) BYTSIZ*LNGSIZ)
#define esint64_size ((EIF_INTEGER) BYTSIZ*I64SIZ)
#define esptr_size ((EIF_INTEGER) BYTSIZ*PTRSIZ)
#define esreal64_size ((EIF_INTEGER) BYTSIZ*R64SIZ)

#define eif_bit_and(i,j)			((i)&(j))
#define eif_bit_or(i,j)				((i)|(j))
#define eif_bit_xor(i,j)			((i)^(j))
#define eif_bit_not(i)				(~(i))
#define eif_bit_shift_left(i,n)		((i)<<(n))
#define eif_bit_shift_right(i,n)	((i)>>(n))
#define eif_bit_test(t,i,n)	(EIF_TEST((i)&((t)1 << (n))))
#define eif_set_bit(t,i,b,n)			(b ? (i) | ((t)1<< (n)) : (i) & ~((t)1 << (n)))
#define eif_set_bit_with_mask(i,b,m)	(b ? (i) | (m) : (i) & ~(m))


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
