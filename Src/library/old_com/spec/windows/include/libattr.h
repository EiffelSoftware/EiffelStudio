/////////////////////////////////////////////////////////////////////////////
//
//     LIBATTR.H       Copyright (c) 1998 by ISE
//
//     Version:       0.00
//
//     EiffelCOM Library

#ifndef LIB_ATTR
#define LIB_ATTR

#include <oaidl.h>

#define eole2_lib_attr_guid(_ptr_) ((EIF_REFERENCE)GuidToEiffelString (&(((TLIBATTR*)_ptr_)->guid)))
#define eole2_lib_attr_lcid(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->lcid))
#define eole2_lib_attr_sys_kind(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->syskind))
#define eole2_lib_attr_major_version_number(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->wMajorVerNum))
#define eole2_lib_attr_minor_version_number(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->wMinorVerNum))
#define eole2_lib_attr_library_flags(_ptr_) ((EIF_INTEGER) (((TLIBATTR*)_ptr_)->wLibFlags))
		
#endif /* LIB_ATTR */