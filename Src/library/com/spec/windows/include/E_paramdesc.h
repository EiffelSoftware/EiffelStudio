//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_paramdesc.h
//
//  Contents: Accessors of PARAMDESC structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_PARAM_DESC_H_INC__
#define __ECOM_E_PARAM_DESC_H_INC__

#include <oaidl.h>

#define ccom_paramdesc_default(_ptr_) ((EIF_POINTER) (((PARAMDESC*)_ptr_)->pparamdescex))
#define ccom_paramdesc_flags(_ptr_) ((EIF_INTEGER) (((PARAMDESC*)_ptr_)->wParamFlags))

#endif // !__ECOM_E_PARAM_DESC_H_INC__
