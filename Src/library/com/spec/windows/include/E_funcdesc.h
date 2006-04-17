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

#ifndef __ECOM_E_FUNC_DESC_H_INC__
#define __ECOM_E_FUNC_DESC_H_INC__

#include <oaidl.h>

#define ccom_funcdesc_memberid(_ptr_) ((EIF_INTEGER) (((FUNCDESC*)_ptr_)->memid))
#define ccom_funcdesc_funckind(_ptr_) ((EIF_INTEGER) (((FUNCDESC*)_ptr_)->funckind))
#define ccom_funcdesc_invokekind(_ptr_) ((EIF_INTEGER) (((FUNCDESC*)_ptr_)->invkind))
#define ccom_funcdesc_callconv(_ptr_) ((EIF_INTEGER) (((FUNCDESC*)_ptr_)->callconv))
#define ccom_funcdesc_param_count(_ptr_) ((EIF_INTEGER) (((FUNCDESC*)_ptr_)->cParams))
#define ccom_funcdesc_opt_param_count(_ptr_) ((EIF_INTEGER) (((FUNCDESC*)_ptr_)->cParamsOpt))
#define ccom_funcdesc_vtbl_offset(_ptr_) ((EIF_INTEGER) (((FUNCDESC*)_ptr_)->oVft))
#define ccom_funcdesc_scode_count(_ptr_) ((EIF_INTEGER) (((FUNCDESC*)_ptr_)->cScodes))
#define ccom_funcdesc_scode_i(_ptr_, _i_) ((EIF_INTEGER) (((FUNCDESC*)_ptr_)->lprgscode[_i_]))
#define ccom_funcdesc_parameter_i(_ptr_, _i_) ((EIF_POINTER) &(((FUNCDESC*)_ptr_)->lprgelemdescParam[_i_]))
#define ccom_funcdesc_return_type(_ptr_) ((EIF_POINTER) &(((FUNCDESC*)_ptr_)->elemdescFunc))
#define ccom_funcdesc_func_flags(_ptr_) ((EIF_INTEGER) (((FUNCDESC*)_ptr_)->wFuncFlags))

#endif // !__ECOM_E_FUNC_DESC_H_INC__
