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

#ifndef __ECOM_RUNTIME_H_INC__
#define __ECOM_RUNTIME_H_INC__

#ifdef __cplusplus
class ecom_runtime;
#endif

#include "eif_com.h"
#include <assert.h>
#include "eif_eiffel.h"
#include "eif_except.h"
#include "ecom_exception.h"
#include "ecom_runtime_c_e.h"
#include "ecom_runtime_e_c.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
class ecom_runtime
{
  public:
    void ccom_check_hresult (HRESULT hr);
};
#endif

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_RUNTIME_H_INC__
