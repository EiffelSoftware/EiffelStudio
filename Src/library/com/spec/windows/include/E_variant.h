//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   E_variant.h
//
//  Contents: Accessors of VARIANT structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_VARIANT_H_INC__
#define __ECOM_E_VARIANT_H_INC__

#include <oaidl.h>
#include <oleauto.h>
#include "eif_eiffel.h"
#include "ecom_rt_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

#define ccom_variant_clear(_PTR_)   VariantClear (_PTR_)


VARIANT * create_ecom_variant ();


// variable type
EIF_INTEGER ccom_variable_type (VARIANT * variant);
void ccom_set_variable_type (VARIANT * variant, VARTYPE a_value);

// character type
EIF_CHARACTER ccom_character (VARIANT * variant);
EIF_REFERENCE ccom_character_reference (VARIANT * variant);
EIF_CHARACTER ccom_unsigned_character (VARIANT * variant);
EIF_REFERENCE ccom_unsigned_character_reference(VARIANT * variant);

void ccom_set_character_reference (VARIANT * variant, EIF_OBJECT char_ref);
void ccom_set_character (VARIANT * variant, EIF_CHARACTER char_value);
void ccom_set_unsigned_character (VARIANT * variant, EIF_CHARACTER a_value);
void ccom_set_unsigned_character_reference (VARIANT * variant, EIF_OBJECT a_value);

// short
EIF_INTEGER ccom_integer2 (VARIANT * variant);
EIF_REFERENCE ccom_integer2_reference (VARIANT * variant);
EIF_INTEGER ccom_unsigned_integer2 (VARIANT * variant);
EIF_REFERENCE ccom_unsigned_integer2_reference (VARIANT * variant);

void ccom_set_integer2 (VARIANT * variant, EIF_INTEGER a_value);
void ccom_set_integer2_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_unsigned_integer2 (VARIANT * variant, EIF_INTEGER a_value);
void ccom_set_unsigned_integer2_reference (VARIANT * variant, EIF_OBJECT a_value);

// long
EIF_INTEGER ccom_integer4 (VARIANT * variant);
EIF_REFERENCE ccom_integer4_reference (VARIANT * variant);
EIF_INTEGER ccom_unsigned_integer4 (VARIANT * variant);
EIF_REFERENCE ccom_unsigned_integer4_reference (VARIANT * variant);

void ccom_set_integer4 (VARIANT * variant, EIF_INTEGER a_value);
void ccom_set_integer4_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_unsigned_integer4 (VARIANT * variant, EIF_INTEGER a_value);
void ccom_set_unsigned_integer4_reference (VARIANT * variant, EIF_OBJECT a_value);

// integer
EIF_INTEGER ccom_integer (VARIANT * variant);
EIF_REFERENCE ccom_integer_reference (VARIANT * variant);
EIF_INTEGER ccom_unsigned_integer (VARIANT * variant);
EIF_REFERENCE ccom_unsigned_integer_reference (VARIANT * variant);

void ccom_set_integer (VARIANT * variant, EIF_INTEGER a_value);
void ccom_set_integer_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_unsigned_integer (VARIANT * variant, EIF_INTEGER a_value);
void ccom_set_unsigned_integer_reference (VARIANT * variant, EIF_OBJECT a_value);

// float
EIF_REAL ccom_real4 (VARIANT * variant);
EIF_REFERENCE ccom_real4_reference (VARIANT * variant);

void ccom_set_real4 (VARIANT * variant, EIF_REAL a_value);
void ccom_set_real4_reference (VARIANT * variant, EIF_OBJECT a_value);

// double
EIF_DOUBLE ccom_real8 (VARIANT * variant);
EIF_REFERENCE ccom_real8_reference (VARIANT * variant);

void ccom_set_real8 (VARIANT * variant, EIF_DOUBLE a_value);
void ccom_set_real8_reference (VARIANT * variant, EIF_OBJECT a_value);

// boolean
EIF_BOOLEAN ccom_bool (VARIANT * variant);
EIF_REFERENCE ccom_bool_reference (VARIANT * variant);

void ccom_set_bool (VARIANT * variant, EIF_BOOLEAN a_value);
void ccom_set_bool_reference (VARIANT * variant, EIF_OBJECT a_value);

// date
EIF_REFERENCE ccom_date (VARIANT * variant);
EIF_REFERENCE ccom_date_reference (VARIANT * variant);

void ccom_set_date (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_date_reference (VARIANT * variant, EIF_OBJECT a_value);

// scode/HRESULT
EIF_INTEGER ccom_error (VARIANT * variant);
EIF_INTEGER ccom_error_reference (VARIANT * variant);

void ccom_set_error (VARIANT * variant, SCODE a_value);
void ccom_set_error_reference (VARIANT * variant, SCODE a_value);

// decimal
EIF_REFERENCE ccom_decimal (VARIANT * variant);
EIF_POINTER ccom_decimal_reference (VARIANT * variant);

void ccom_set_decimal (VARIANT * variant, DECIMAL * a_value);
void ccom_set_decimal_reference (VARIANT * variant, DECIMAL *a_value);

// currency
EIF_REFERENCE ccom_currency (VARIANT * variant);
EIF_POINTER ccom_currency_reference (VARIANT * variant);

void ccom_set_currency (VARIANT * variant, CY *a_value);
void ccom_set_currency_reference (VARIANT * variant, CY *a_value);

// BSTR
EIF_REFERENCE ccom_bstr (VARIANT * variant);
EIF_REFERENCE ccom_bstr_reference (VARIANT * variant);

void ccom_set_bstr (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_bstr_reference (VARIANT * variant, EIF_OBJECT a_value);

// VARIANT
EIF_POINTER ccom_variant (VARIANT * variant);

void ccom_set_variant (VARIANT * variant, VARIANT *a_value);

// IUnknown
EIF_POINTER ccom_unknown_interface (VARIANT * variant);
EIF_POINTER ccom_unknown_interface_reference (VARIANT * variant);

void ccom_set_unknown_interface (VARIANT * variant, IUnknown *a_value);
void ccom_set_unknown_interface_reference (VARIANT * variant, IUnknown *a_value);

// IDispatch
EIF_POINTER ccom_dispatch_interface (VARIANT * variant);
EIF_POINTER ccom_dispatch_interface_reference (VARIANT * variant);

void ccom_set_dispatch_interface (VARIANT * variant, IDispatch * a_value);
void ccom_set_dispatch_interface_reference (VARIANT * variant, IDispatch * a_value);

// safearray
EIF_REFERENCE ccom_safearray_unsigned_integer (VARIANT * variant);
EIF_REFERENCE ccom_safearray_integer (VARIANT * variant);
EIF_REFERENCE ccom_safearray_unsigned_character (VARIANT * variant);
EIF_REFERENCE ccom_safearray_character (VARIANT * variant);
EIF_REFERENCE ccom_safearray_unsigned_short (VARIANT * variant);
EIF_REFERENCE ccom_safearray_short (VARIANT * variant);
EIF_REFERENCE ccom_safearray_unsigned_long (VARIANT * variant);
EIF_REFERENCE ccom_safearray_long (VARIANT * variant);
EIF_REFERENCE ccom_safearray_float (VARIANT * variant);
EIF_REFERENCE ccom_safearray_double (VARIANT * variant);
EIF_REFERENCE ccom_safearray_currency (VARIANT * variant);
EIF_REFERENCE ccom_safearray_date (VARIANT * variant);
EIF_REFERENCE ccom_safearray_bstr (VARIANT * variant);
EIF_REFERENCE ccom_safearray_dispatch_interface (VARIANT * variant);
EIF_REFERENCE ccom_safearray_hresult (VARIANT * variant);
EIF_REFERENCE ccom_safearray_boolean (VARIANT * variant);
EIF_REFERENCE ccom_safearray_variant (VARIANT * variant);
EIF_REFERENCE ccom_safearray_unknown_interface (VARIANT * variant);
EIF_REFERENCE ccom_safearray_decimal (VARIANT * variant);

// set SAFEARRAY
void ccom_set_safearray_unsigned_integer (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_integer (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_unsigned_character (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_character (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_unsigned_short (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_short (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_unsigned_long (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_long (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_float (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_double (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_currency (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_date (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_bstr (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_dispatch_interface (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_hresult (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_boolean (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_variant (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_unknown_interface (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_decimal (VARIANT * variant, EIF_OBJECT a_value);

// safearray reference
EIF_REFERENCE ccom_safearray_unsigned_integer_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_integer_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_unsigned_character_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_character_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_unsigned_short_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_short_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_unsigned_long_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_long_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_float_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_double_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_currency_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_date_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_bstr_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_dispatch_interface_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_hresult_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_boolean_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_variant_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_unknown_interface_reference (VARIANT * variant);
EIF_REFERENCE ccom_safearray_decimal_reference (VARIANT * variant);

// set SAFEARRAY reference
void ccom_set_safearray_unsigned_integer_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_integer_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_unsigned_character_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_character_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_unsigned_short_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_short_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_unsigned_long_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_long_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_float_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_double_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_currency_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_date_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_bstr_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_dispatch_interface_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_hresult_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_boolean_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_variant_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_unknown_interface_reference (VARIANT * variant, EIF_OBJECT a_value);
void ccom_set_safearray_decimal_reference (VARIANT * variant, EIF_OBJECT a_value);



#ifdef __cplusplus
}
#endif


#endif // !__ECOM_E_VARIANT_H_INC__
