//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_ULarge_Integer.h
//
//  Contents: Declaration of E_ULarge_Integer class.
//
//
//--------------------------------------------------------------------------
//
#ifndef __ECOM_E_ULARGE_INTEGER_H_INC__
#define __ECOM_E_ULARGE_INTEGER_H_INC__

#include <objbase.h>


#define ccom_set_ularge_integer(_ptr_,v) ULISet32(*((ULARGE_INTEGER*)_ptr_), v)


#endif // !__ECOM_E_ULARGE_INTEGER_H_INC__
