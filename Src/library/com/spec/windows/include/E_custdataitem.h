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

#ifndef __ECOM_E_CUST_DATA_ITEM_H_INC__
#define __ECOM_E_CUST_DATA_ITEM_H_INC__

#include <oaidl.h>
#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#define ccom_custdataitem_guid(_ptr_) ((EIF_POINTER) &(((CUSTDATAITEM *)_ptr_)->guid))
#define ccom_custdataitem_variant(_ptr_) ((EIF_POINTER) &(((CUSTDATAITEM *)_ptr_)->varValue))

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_E_CUST_DATA_ITEM_H_INC__
