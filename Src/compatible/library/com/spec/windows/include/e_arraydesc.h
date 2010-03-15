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

#ifndef __ECOM_E_ARRAY_DESC_H_INC__
#define __ECOM_E_ARRAY_DESC_H_INC__

#include <oaidl.h>
#include "eif_eiffel.h"

#define ccom_arraydesc_typedesc(_ptr_) ((EIF_POINTER) &(((ARRAYDESC *)_ptr_)->tdescElem))
#define ccom_arraydesc_dim_count(_ptr_) ((EIF_INTEGER) (((ARRAYDESC *)_ptr_)->cDims))

#ifdef __cplusplus
  extern "C" {
#endif

EIF_REFERENCE ccom_arraydesc_bounds (EIF_POINTER ptr);

#ifdef __cplusplus
  }
#endif

#endif // !__ECOM_E_ARRAY_DESC_H_INC__
