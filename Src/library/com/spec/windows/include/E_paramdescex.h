//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_paramdescex.h
//
//  Contents: Accessors of PARAMDESCEX structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_PARAM_DESCEX_H_INC__
#define __ECOM_E_PARAM_DESCEX_H_INC__

#include <oaidl.h>

#define ccom_paramdescex_variant(_ptr_) ((EIF_POINTER) &(((PARAMDESCEX*)_ptr_)->varDefaultValue))
#define ccom_paramdescex_bytes(_ptr_) ((EIF_INTEGER) (((PARAMDESCEX*)_ptr_)->cBytes))

#endif // !__ECOM_E_PARAM_DESCEX_H_INC__
