/*
	description: "Wrapper for time functions for each platforms."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 5949 Hollister Ave., Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _eif_time_h_
#define _eif_time_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_portable.h"

#ifdef EIF_WINDOWS
/* This will include the definition of struct timeval. The implementation of gettimeofday is in class C_DATE. */
#include <windows.h>
#include <winsock2.h>
#else
/* This will include the definition of gettimeofday and struct timeval. */
#include <sys/time.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
}
#endif

#endif
