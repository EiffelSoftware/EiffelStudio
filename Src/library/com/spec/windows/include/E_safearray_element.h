//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		E_safearray_element.h
//
//  Contents:	SAFEARRAY element accesor and setter functions.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_SAFEARRAY_ELEMENT_H_INC__
#define __ECOM_E_SAFEARRAY_ELEMENT_H_INC__

#include <oaidl.h>
#include "eif_eiffel.h"

#define ccom_safearray_el_from_value(_ptr_, _value_) (*(_ptr_) = (_value_))
#define ccom_safearray_el_int_value(_ptr_) ((EIF_INTEGER)*((long*)_ptr_))
#define ccom_safearray_el_short_value(_ptr_) ((EIF_INTEGER)*((short*)_ptr_))
#define ccom_safearray_el_real_value(_ptr_) ((EIF_REAL)*((float*)_ptr_))
#define ccom_safearray_el_double_value(_ptr_) ((EIF_DOUBLE)*((double*)_ptr_))
#define ccom_safearray_el_char_value(_ptr_) ((EIF_CHARACTER)*((unsigned char *)_ptr_))
#define ccom_safearray_el_error_value(_ptr_) ((EIF_INTEGER)*((HRESULT*)_ptr_))

#endif // !__ECOM_E_SAFEARRAY_ELEMENT_H_INC__

