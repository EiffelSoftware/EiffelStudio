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

#ifndef __ECOM_E_VAR_DESC_H_INC__
#define __ECOM_E_VAR_DESC_H_INC__

#include <oaidl.h>

#define ccom_vardesc_memid(_ptr_) ((EIF_INTEGER) (((VARDESC*)_ptr_)->memid))
#define ccom_vardesc_offset(_ptr_) ((EIF_INTEGER) (((VARDESC*)_ptr_)->oInst))
#define ccom_vardesc_const_variant(_ptr_) ((EIF_POINTER) (((VARDESC*)_ptr_)->lpvarValue))
#define ccom_vardesc_elemdesc(_ptr_) ((EIF_POINTER) &(((VARDESC*)_ptr_)->elemdescVar))
#define ccom_vardesc_var_flags(_ptr_) ((EIF_INTEGER) (((VARDESC*)_ptr_)->wVarFlags))
#define ccom_vardesc_var_kind(_ptr_) ((EIF_INTEGER) (((VARDESC*)_ptr_)->varkind))

#endif // !__ECOM_E_VAR_DESC_H_INC__
