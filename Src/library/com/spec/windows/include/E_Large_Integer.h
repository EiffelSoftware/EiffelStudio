//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_Large_Integer.h
//
//  Contents: E_Large_Integer macros.
//
//
//--------------------------------------------------------------------------
//
#ifndef __ECOM_E_LARGE_INTEGER_H_INC__
#define __ECOM_E_LARGE_INTEGER_H_INC__

#include <objbase.h>

#define ccom_set_large_integer(_ptr_,v) LISet32(*((LARGE_INTEGER*)_ptr_), v)

#endif // !__ECOM_E_LARGE_INTEGER_H_INC__
