//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_elemdesc.h
//
//  Contents: Accessors of ELEMDESC structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_ELEM_DESC_H_INC__
#define __ECOM_E_ELEM_DESC_H_INC__

#include <oaidl.h>

#define ccom_elemdesc_typedesc(_ptr_) ((EIF_POINTER) &(((ELEMDESC*)_ptr_)->tdesc))
#define ccom_elemdesc_idldesc(_ptr_) ((EIF_POINTER) &(((ELEMDESC*)_ptr_)->idldesc))
#define ccom_elemdesc_paramdesc(_ptr_) ((EIF_POINTER) &(((ELEMDESC*)_ptr_)->paramdesc))

#endif // !__ECOM_E_ELEM_DESC_H_INC__
