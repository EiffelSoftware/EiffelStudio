//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_bindptr.h
//
//  Contents: Accessors of BINDPTR structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_BIND_PTR_H_INC__
#define __ECOM_E_BIND_PTR_H_INC__

#include <oaidl.h>

#ifdef __cplusplus
extern "C" {
#endif

#define ccom_bindptr_funcdesc(_ptr_) ((EIF_POINTER) (((BINDPTR*)_ptr_)->lpfuncdesc))
#define ccom_bindptr_vardesc(_ptr_) ((EIF_POINTER) (((BINDPTR*)_ptr_)->lpvardesc))
#define ccom_bindptr_itypecomp(_ptr_) ((EIF_POINTER) (((BINDPTR*)_ptr_)->lptcomp))

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_E_BIND_PTR_H_INC__
