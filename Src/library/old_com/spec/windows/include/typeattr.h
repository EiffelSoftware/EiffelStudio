/////////////////////////////////////////////////////////////////////////////
//
//     TYPEATTR.H       Copyright (c) 1998 by ISE
//
//     Version:       0.00
//
//     EiffelCOM Library

#ifndef TYPE_ATTR
#define TYPE_ATTR

#include <oaidl.h>

#define eole2_type_attr_guid(_ptr_) ((EIF_REFERENCE)GuidToEiffelString (&(((TYPEATTR*)_ptr_)->guid)))
#define eole2_type_attr_lcid(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->lcid))
#define eole2_type_attr_memid_constructor(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->memidConstructor))
#define eole2_type_attr_memid_destructor(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->memidDestructor))
#define eole2_type_attr_size_instance(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->cbSizeInstance))
#define eole2_type_attr_type_kind(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->typekind))
#define eole2_type_attr_count_func(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->cFuncs))
#define eole2_type_attr_count_variables(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->cVars))
#define eole2_type_attr_count_implemented_types(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->cImplTypes))
#define eole2_type_attr_size_VTBL(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->cbSizeVft))
#define eole2_type_attr_byte_alignment(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->cbAlignment))
#define eole2_type_attr_flags(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->wTypeFlags))
#define eole2_type_attr_major_version_number(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->wMajorVerNum))
#define eole2_type_attr_minor_version_number(_ptr_) ((EIF_INTEGER) (((TYPEATTR*)_ptr_)->wMinorVerNum))
#define eole2_type_attr_kind_alias(_ptr_) ((EIF_POINTER) (&((TYPEATTR*)_ptr_)->tdescAlias))
#define eole2_type_attr_idl_desc(_ptr_) ((EIF_POINTER) (&((TYPEATTR*)_ptr_)->idldescType))

#endif /* TYPE_ATTR */