/*
indexing
description: "WEL: library of reusable components for Windows."
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Avenue, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

#ifndef __WEL_USER_VALIDATION__
#define __WEL_USER_VALIDATION__

#ifndef __WEL__
#	include "wel.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

extern EIF_BOOLEAN cwel_is_credential_valid (LPTSTR szDomain, LPTSTR szUser, LPTSTR szPassword);

#ifdef __cplusplus
}
#endif

#endif /* __WEL_DISPATCHER__ */
