//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_vardesc.h
//
//  Contents: Accessors of VARDESC structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_VAR_DESC_H_INC__
#define __ECOM_E_VAR_DESC_H_INC__

#include <oaidl.h>

#define ccom_vardesc_memid(_ptr_) ((EIF_INTEGER) (((VARDESC*)_ptr_)->memid))
#define ccom_vardesc_offset(_ptr_) ((EIF_INTEGER) (((VARDESC*)_ptr_)->oInst))
#define ccom_vardesc_const_variant(_ptr_) ((EIF_POINTER) (((VARDESC*)_ptr_)->lpvarValue))
#define ccom_vardesc_elemdesc(_ptr_) ((EIF_POINTER) &(((VARDESC*)_ptr_)->elemdescVar))
#define ccom_vardesc_var_flags(_ptr_) ((EIF_INTEGER) (((VARDESC*)_ptr_)->wVarFlags))
#define ccom_vardesc_var_kind(_ptr_) ((EIF_INTEGER) (((VARDESC*)_ptr_)->varkind))

#endif // !__ECOM_E_VAR_DESC_H_INC__
