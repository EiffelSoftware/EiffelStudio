//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_type_attr.h
//
//  Contents: Accessors of TYPEATTR structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_TYPE_ATTR_H_INC__
#define __ECOM_E_TYPE_ATTR_H_INC__

#include <oaidl.h>

#define ccom_typeattr_guid(_ptr_) ((EIF_POINTER) &(((TYPEATTR*)_ptr_)->guid))
#define ccom_typeattr_lcid(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->lcid))
#define ccom_typeattr_memid_constructor(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->memidConstructor))
#define ccom_typeattr_memid_destructor(_ptr_)  ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->memidDestructor))
#define ccom_typeattr_size_instance(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->cbSizeInstance))
#define ccom_typeattr_type_kind(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->typekind))
#define ccom_typeattr_func_count(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->cFuncs))
#define ccom_typeattr_variable_count(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->cVars))
#define ccom_typeattr_interface_count(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->cImplTypes))
#define ccom_typeattr_vtbl_size(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->cbSizeVft))
#define ccom_typeattr_alignment(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->cbAlignment))
#define ccom_typeattr_type_flags(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->wTypeFlags))
#define ccom_typeattr_major_vernum(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->wMajorVerNum))
#define ccom_typeattr_minor_vernum(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->wMinorVerNum))
#define ccom_typeattr_alias_typedesc(_ptr_) ((EIF_POINTER) &(((TYPEATTR*)_ptr_)->tdescAlias))
#define ccom_typeattr_idl_attributes(_ptr_) ((EIF_POINTER) &(((TYPEATTR*)_ptr_)->idldescType))

#endif // !__ECOM_E_TYPE_ATTR_H_INC__
