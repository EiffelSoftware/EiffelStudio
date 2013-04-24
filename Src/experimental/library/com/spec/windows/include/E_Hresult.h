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

#ifndef __ECOM_E_HRESULT_H_INC__
#define __ECOM_E_HRESULT_H_INC__

#include <winerror.h>
#include "eif_eiffel.h"

#define ccom_hresult_error_code(a_ptr) HRESULT_ERROR_CODE(*((HRESULT *)a_ptr))
#define ccom_hresult_facility_code(a_ptr) HRESULT_FACILITY(*((HRESULT *)a_ptr))
#define ccom_hresult_succeeded(a_ptr) (SUCCEEDED(*((HRESULT *)a_ptr))? return EIF_TRUE: return EIF_FALSE)
#define ccom_hresult_make_hresult(a_int, b_int, c_int) (MAKE_HRESULT((unsigned long)a_int, (unsigned long)b_int, (unsigned long)c_int))

#endif // !__ECOM_E_HRESULT_H_INC__
