/////////////////////////////////////////////////////////////////////////////
//
//     ActiveX.h       Copyright (c) 1999 by ISE
//
//     Version:       0.00
//
//     EiffelCOM Library
//



#ifndef __ECOM_ACTIVEX__
#define __ECOM_ACTIVEX__

#include <objbase.h>
#include <winbase.h>
#include "eif_eiffel.h"

#define c_eole_is_equal_clsid(_pid1_, _pid2_) (EIF_BOOLEAN)(IsEqualCLSID ((REFCLSID)_pid1_, (REFCLSID)_pid2_))

#define c_eole_dll_get_class_object(_ppv_, _pv_) (*((void **)(_ppv_)) = (_pv_))
#define c_eole_register_typlib(_ptlib_, _path_) (EIF_INTEGER)(RegisterTypeLib ((ITypeLib *)_ptlib_, Eif2OleString (_path_), NULL))
		 
extern EIF_INTEGER c_eole_unregister_typelib (EIF_POINTER a_str, EIF_INTEGER major_v, EIF_INTEGER minor_v, EIF_INTEGER a_syskind);
extern EIF_REFERENCE c_eole_get_path_filename (EIF_POINTER a_file_name);
#endif /* !__ECOM_ACTIVEX__ */
