//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_safearraybound.h
//
//  Contents: Declaration of E_wide_string class.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_SAFE_ARRAY_BOUND_H_INC__
#define __ECOM_E_SAFE_ARRAY_BOUND_H_INC__

#include <oaidl.h>

#define ccom_safearraybound_elements(_ptr_) ((EIF_INTEGER) (((SAFEARRAYBOUND*)_ptr_)->cElements))
#define ccom_safearraybound_low_bound(_ptr_) ((EIF_INTEGER) (((SAFEARRAYBOUND*)_ptr_)->lLbound))

#define ccom_safearraybound_set_elements(_ptr_, _value_) ((((SAFEARRAYBOUND*)_ptr_)->cElements)=(ULONG)(_value_))
#define ccom_safearraybound_set_low_bound(_ptr_, _value_) ((((SAFEARRAYBOUND*)_ptr_)->lLbound)=(LONG)(_value_))

#endif // !__ECOM_E_SAFE_ARRAY_BOUND_H_INC__
