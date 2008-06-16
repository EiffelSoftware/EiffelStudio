/*
	description: "Declarations for miscellenaous externals."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.

			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _eif_misc_h_
#define _eif_misc_h_

#include "eif_portable.h"
#include "eif_cecil.h"
#ifdef EIF_WINDOWS
#include <stdlib.h>
#include <windows.h> /* DLL declarations */
#else
#include <sys/types.h>
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
#define eif_set_bit(t,i,b,n)			(b ? (i) | (t)((t)1<< (n)) : (i) & (t)(~((t)1 << (n))))
#define eif_set_bit_with_mask(i,b,m)	(b ? (i) | (m) : (i) & ~(m))


RT_LNK void eif_sleep(EIF_INTEGER_64);
RT_LNK EIF_INTEGER eif_system (char *s);
RT_LNK void eif_system_asynchronous (char *s);

RT_LNK EIF_REFERENCE arycpy(EIF_REFERENCE area, EIF_INTEGER i, EIF_INTEGER j, EIF_INTEGER k);

#ifdef EIF_WINDOWS
/* DLL declarations */
#ifdef EIF_IL_DLL
#define eif_load_dll(name)	LoadLibraryA((LPCSTR) name);
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
