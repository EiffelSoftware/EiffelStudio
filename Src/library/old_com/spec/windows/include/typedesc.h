/////////////////////////////////////////////////////////////////////////////
//
//     TYPEDESC.H       Copyright (c) 1998 by ISE
//
//     Version:       0.00
//
//     EiffelCOM Library

#ifndef TYPE_DESC
#define TYPE_DESC

#include <oaidl.h>

#define eole2_typedesc_vartype(_ptr_) ((EIF_INTEGER) (((TYPEDESC*)_ptr_)->vt))
#define eole2_typedesc_typedesc(_ptr_) ((EIF_POINTER) (((TYPEDESC*)_ptr_)->lptdesc))
#define eole2_typedesc_arraydesc(_ptr_) ((EIF_POINTER) (((TYPEDESC*)_ptr_)->lpadesc))
#define eole2_typedesc_href_type(_ptr_) ((EIF_INTEGER) (((TYPEDESC*)_ptr_)->hreftype))
		
#endif /* TYPE_DESC */