/////////////////////////////////////////////////////////////////////////////
//
//     PARAMDESC.H       Copyright (c) 1998 by ISE
//
//     Version:       0.00
//
//     EiffelCOM Library

#ifndef PARAM_DESC
#define PARAM_DESC

#include <oaidl.h>

#define eole2_paramdesc_flags(_ptr_) ((EIF_INTEGER) (((PARAMDESC*)_ptr_)->wParamFlags))
#define eole2_paramdesc_default(_ptr_) ((EIF_POINTER) (&(((PARAMDESC*)_ptr_)->pparamdescex)->varDefaultValue))
#define eole2_paramdesc_count(_ptr_) ((EIF_POINTER) ((((PARAMDESC*)_ptr_)->pparamdescex)->cBytes))
		
#endif /* PARAM_DESC */