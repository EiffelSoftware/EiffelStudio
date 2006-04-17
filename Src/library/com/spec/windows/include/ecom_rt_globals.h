/*
indexing
	description: "EiffelCOM: library of reusable components for COM."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef __ECOM_RUNTIME_GLOBALS_H_INC__
#define __ECOM_RUNTIME_GLOBALS_H_INC__

#include "ecom_exception.h"
#include "ecom_runtime_c_e.h"
#include "ecom_runtime_e_c.h"

#ifdef __cplusplus

extern "C" Formatter  f;

extern "C" ecom_runtime_ce rt_ce;

extern "C" ecom_runtime_ec rt_ec;

#endif // __cplusplus

#endif // !__ECOM_RUNTIME_GLOBALS_H_INC__
