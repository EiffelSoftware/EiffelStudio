//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_idldesc.h
//
//  Contents: Accessors of IDLDESC structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_IDL_DESC_H_INC__
#define __ECOM_E_IDL_DESC_H_INC__

#include <oaidl.h>

#define ccom_idldesc_flags(_ptr_) ((EIF_INTEGER) (((IDLDESC*)_ptr_)->wIDLFlags))

#endif // !__ECOM_E_IDL_DESC_H_INC__
