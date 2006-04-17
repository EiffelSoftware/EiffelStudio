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

#ifndef __ECOM_E_TLIB_ATTR_H_INC__
#define __ECOM_E_TLIB_ATTR_H_INC__

#include <oaidl.h>

#define ccom_tlibattr_guid(_ptr_) ((EIF_POINTER) &(((TLIBATTR*)_ptr_)->guid))
#define ccom_tlibattr_lcid(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->lcid))
#define ccom_tlibattr_sys_kind(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->syskind))
#define ccom_tlibattr_major_vernum(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->wMajorVerNum))
#define ccom_tlibattr_minor_vernum(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->wMinorVerNum))
#define ccom_tlibattr_tlib_flags(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->wLibFlags))

#endif // !__ECOM_E_TLIB_ATTR_H_INC__
