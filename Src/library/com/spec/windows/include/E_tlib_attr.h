//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_tlib_attr.h
//
//  Contents: Accessors of TLIBATTR structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_TLIB_ATTR_H_INC__
#define __ECOM_E_TLIB_ATTR_H_INC__

#include <oaidl.h>

#define ccom_tlibattr_guid(_ptr_) ((EIF_POINTER) &(((TLIBATTR*)_ptr_)->guid))
#define ccom_tlibattr_lcid(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->lcid))
#define ccom_tlibattr_sys_kind(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->syskind))
#define ccom_tlibattr_major_vernum(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->wMajorVerNum))
#define ccom_tlibattr_minor_vernum(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->wMinorVerNum))
#define ccom_tlibattr_tlib_flags(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->wLibFlags))

#endif // !__ECOM_E_TLIB_ATTR_H_INC__
