//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_typedesc.h
//
//  Contents: Accessors of TYPEDESC structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_TYPE_DESC_H_INC__
#define __ECOM_E_TYPE_DESC_H_INC__

#include <oaidl.h>

#define ccom_typedesc_vartype(_ptr_) ((EIF_INTEGER) (((TYPEDESC*)_ptr_)->vt))
#define ccom_typedesc_typedesc(_ptr_) ((EIF_POINTER) (((TYPEDESC*)_ptr_)->lptdesc))
#define ccom_typedesc_arraydesc(_ptr_) ((EIF_POINTER) (((TYPEDESC*)_ptr_)->lpadesc))
#define ccom_typedesc_href_type(_ptr_) ((EIF_INTEGER) (((TYPEDESC*)_ptr_)->hreftype))

#endif // !__ECOM_E_TYPE_DESC_H_INC__
