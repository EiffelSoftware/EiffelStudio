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

#ifndef __ECOM_E_GENERIC_INTERFACE_H_INC__
#define __ECOM_E_GENERIC_INTERFACE_H_INC__

#include <oaidl.h>
#include <objbase.h>
#include <eif_eiffel.h>
#include "eif_except.h"
#include "ecom_rt_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

class E_generic_interface
{
  public:
    // Commands
    E_generic_interface () {};
    E_generic_interface (IUnknown * other);
    ~E_generic_interface ();
    
    // Queries
    EIF_POINTER ccom_item ();
  private:
    IUnknown * item;
};

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_E_GENERIC_INTERFACE_H_INC__
