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

#ifndef __ECOM_E_IROOT_STORAGE_H_INC__
#define __ECOM_E_IROOT_STORAGE_H_INC__

#include <objidl.h>
#include "eif_cecil.h"
#include "eif_except.h"
#include "ecom_rt_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

class E_IRootStorage
{
public:
  // Commands
  E_IRootStorage(IUnknown * pstgName);
  ~E_IRootStorage();
  void ccom_switch_to_file (EIF_POINTER filename);
  
  // Queries  
  EIF_POINTER ccom_item();
  
private:  
  IRootStorage * pIRootStorage;
};

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_E_IROOT_STORAGE_H_INC__
