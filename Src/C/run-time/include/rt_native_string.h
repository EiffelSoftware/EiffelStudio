/*
	description: "Macro definitions related to EIF_NATIVE_CHAR."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2012, Eiffel Software."
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

#ifndef _rt_native_string_h_
#define _rt_native_string_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_portable.h"
#include <string.h>
#ifndef EIF_WINDOWS
#include <sys/types.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef EIF_WINDOWS

	/* Macro used to manipulate native string, i.e: (wchar_t*) */
#define rt_nstrlen wcslen /* size of string */
#define rt_nstrncpy wcsncpy /* Copy n characters of one string to another */
#define rt_nstrcpy wcscpy /* Copy one string to another */
#define rt_nstrncat wcsncat /* Append characters of a string */
#define rt_nstrcat wcscat /* Append a string */
#define rt_nstrstr wcsstr /* Return a pointer to the first occurrence of a search string in a string. */
#define rt_nmakestr(quote) L##quote /* Manifest Native string declaration */
#define rt_nstr_fopen	_wfopen /* Open file using native string name */
#define rt_nstrcmp wcscmp /* Compare two strings. */
#define rt_nstrdup _wcsdup /* Duplicate string. */

#define rt_nstr_cat_ascii(dest, src) { 						\
		int i;													\
		size_t dest_len, src_len;								\
		dest_len = rt_nstrlen (dest);							\
		src_len = strlen (src);									\
		for (i = 0; i < src_len; i++) {							\
			dest[dest_len + i] = (EIF_NATIVE_CHAR) src[i];		\
		}														\
		dest[dest_len + src_len] = (EIF_NATIVE_CHAR) 0;			\
	}

#else /* not EIF_WINDOWS */

	/* Macro used to manipulate native string, i.e: (char*) */
#define rt_nstrlen  strlen /* size of string */
#define rt_nstrncpy strncpy /* Copy n characters of one string to another */
#define rt_nstrcpy strcpy /* Copy one string to another */
#define rt_nstrncat strncat /* Append characters of a string */
#define rt_nstrcat strcat /* Append a string */
#define rt_nstrstr strstr /* Return a pointer to the first occurrence of a search string in a string. */
#define rt_nmakestr(quote) quote /* Manifest Native string declaration */
#define rt_nstr_fopen	fopen /* Open file using native string name */
#define rt_nstrcmp strcmp /* Compare two strings. */
#define rt_nstrdup strdup /* Duplicate string. */

#define rt_nstr_cat_ascii strcat

#endif

#ifdef __cplusplus
}
#endif

#endif
