/*
	description: "Facilities to initialize and destroy the runtime in a shared library."
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

#ifndef _egc_dynlib_h_
#define _egc_dynlib_h_
#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#include "eif_cecil.h"
#include "eif_eiffel.h"
	
#ifdef __cplusplus
extern "C" {
#endif

/* Initialization and destruction of runtime. */
#define DYNAMIC_LIB_RT_INITIALIZE(x)\
	{ \
		EIF_ENTER_EIFFEL; \
		RTGC; \
		{ \
			RTLD; \
			RTLI(x); \
		
#define DYNAMIC_LIB_RT_END \
			RTLE; \
		} \
		EIF_EXIT_EIFFEL; \
	}

#ifndef EIF_WINDOWS
	/* Define calling convention type so that it Eiffel dlls for windows can also be compiled
	 * on other platforms where it does not matter. */
#ifndef __stdcall
#define __stdcall
#endif

#ifndef __cdecl
#define __cdecl
#endif

#ifndef __fastcall
#define __fastcall
#endif

#endif

#ifdef __cplusplus
}
#endif

#endif

