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

#ifndef __ECOM_E_CUSTDATA_H_INC__
#define __ECOM_E_CUSTDADTA_H_INC__

#include <oaidl.h>
#include "eif_eiffel.h"

#define ccom_custdata_items(_ptr_) ((EIF_INTEGER) (((CUSTDATA *)_ptr_)->cCustData))

#ifdef __cplusplus
  extern "C" {
#endif

EIF_REFERENCE ccom_custdata_array (EIF_POINTER ptr);

#ifdef __cplusplus
  }
#endif

#endif // !__ECOM_E_CUSTDATA_H_INC__
