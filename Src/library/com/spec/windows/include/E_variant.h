//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		E_variant.h
//
//  Contents:	Accessors of VARIANT structure.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_E_VARIANT_H_INC__
#define __ECOM_E_VARIANT_H_INC__

#include <oaidl.h>
#include <oleauto.h>
#include "eif_eiffel.h"
#include "ecom_rt_globals.h"

// variable type
#define ccom_variant_variable_type(_ptr_) ((EIF_INTEGER) (V_VT(_ptr_)))

#define ccom_set_variant_variable_type(_ptr_,a_value) (V_VT(_ptr_) = (VARTYPE)a_value)

// character
#define ccom_variant_char(_ptr_) ((EIF_CHARACTER) V_I1(_ptr_))
#define ccom_variant_char_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_character((unsigned char *)V_I1REF(_ptr_), NULL))
#define ccom_variant_unsigned_char(_ptr_) ((EIF_CHARACTER) (V_UI1(_ptr_)))
#define ccom_variant_unsigned_char_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_character (V_UI1REF(_ptr_), NULL))

#define ccom_set_variant_char(_ptr_,a_value) (V_VT(_ptr_) = VT_I1,V_I1(_ptr_)=(CHAR)a_value)
#define ccom_set_variant_char_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_I1|VT_BYREF, V_I1REF(_ptr_)=(CHAR *)rt_ec.ccom_ec_pointed_character(a_value, NULL))
#define ccom_set_variant_unsigned_char(_ptr_,a_value) (V_VT(_ptr_) = VT_UI1, V_UI1(_ptr_) = (BYTE)a_value)
#define ccom_set_variant_unsigned_char_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_UI1|VT_BYREF, V_UI1REF(_ptr_) = (BYTE *)rt_ec.ccom_ec_pointed_character(a_value, NULL))

// short
#define ccom_variant_integer2(_ptr_) ((EIF_INTEGER) (V_I2(_ptr_)))
#define ccom_variant_integer2_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_short(V_I2REF(_ptr_), NULL))
#define ccom_variant_unsigned_integer2(_ptr_) ((EIF_INTEGER) (V_UI2(_ptr_)))
#define ccom_variant_unsigned_integer2_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_short((short *)V_UI2REF(_ptr_), NULL))

#define ccom_set_variant_integer2(_ptr_,a_value) (V_VT(_ptr_) = VT_I2, V_I2(_ptr_) = (SHORT)a_value)
#define ccom_set_variant_integer2_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_I2|VT_BYREF, V_I2REF(_ptr_) = (SHORT *)rt_ec.ccom_ec_pointed_short(a_value, NULL))
#define ccom_set_variant_unsigned_integer2(_ptr_,a_value) (V_VT(_ptr_) = VT_UI2, V_UI2(_ptr_) = (USHORT)a_value)
#define ccom_set_variant_unsigned_integer2_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_UI2|VT_BYREF, V_UI2REF(_ptr_) = (USHORT *)rt_ec.ccom_ec_pointed_short(a_value, NULL))

// long
#define ccom_variant_integer4(_ptr_) ((EIF_INTEGER) (V_I4(_ptr_)))
#define ccom_variant_integer4_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_long(V_I4REF(_ptr_), NULL))
#define ccom_variant_unsigned_integer4(_ptr_) ((EIF_INTEGER) (V_UI4(_ptr_)))
#define ccom_variant_unsigned_integer4_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_long((long *)V_UI4REF(_ptr_), NULL))

#define ccom_set_variant_integer4(_ptr_,a_value) (V_VT(_ptr_) = VT_I4, V_I4(_ptr_) = (LONG)a_value )
#define ccom_set_variant_integer4_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_I4|VT_BYREF, V_I4REF(_ptr_) = (LONG *)rt_ec.ccom_ec_pointed_long(a_value, NULL))
#define ccom_set_variant_unsigned_integer4(_ptr_,a_value) (V_VT(_ptr_) = VT_UI4, V_UI4(_ptr_) = (ULONG)a_value)
#define ccom_set_variant_unsigned_integer4_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_UI4|VT_BYREF, V_UI4REF(_ptr_) = (ULONG *)rt_ec.ccom_ec_pointed_long(a_value, NULL))


// integer
#define ccom_variant_integer(_ptr_) ((EIF_INTEGER) (V_INT(_ptr_)))
#define ccom_variant_integer_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_integer(V_INTREF(_ptr_),NULL))
#define ccom_variant_unsigned_integer(_ptr_) ((EIF_INTEGER) (V_UINT(_ptr_)))
#define ccom_variant_unsigned_integer_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_integer((int *)V_UINTREF(_ptr_), NULL))

#define ccom_set_variant_integer(_ptr_,a_value) (V_VT(_ptr_) = VT_INT, V_INT(_ptr_) = (INT)a_value)
#define ccom_set_variant_integer_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_INT|VT_BYREF, V_INTREF(_ptr_) = (INT *)rt_ec.ccom_ec_pointed_long(a_value, NULL))
#define ccom_set_variant_unsigned_integer(_ptr_,a_value) (V_VT(_ptr_) = VT_UINT, V_UINT(_ptr_) = (UINT)a_value)
#define ccom_set_variant_unsigned_integer_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_UINT|VT_BYREF, V_UINTREF(_ptr_) = (UINT *)rt_ec.ccom_ec_pointed_long(a_value, NULL))

// float
#define ccom_variant_real4(_ptr_) ((EIF_REAL) (V_R4(_ptr_)))
#define ccom_variant_real4_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_real(V_R4REF(_ptr_), NULL))

#define ccom_set_variant_real4(_ptr_,a_value) (V_VT(_ptr_) = VT_R4, V_R4(_ptr_) = (FLOAT)a_value )
#define ccom_set_variant_real4_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_R4|VT_BYREF, V_R4REF(_ptr_) = (FLOAT *)rt_ec.ccom_ec_pointed_real(a_value, NULL))

// double
#define ccom_variant_real8(_ptr_) ((EIF_DOUBLE) (V_R8(_ptr_)))
#define ccom_variant_real8_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_double (V_R8REF(_ptr_), NULL))

#define ccom_set_variant_real8(_ptr_,a_value) (V_VT(_ptr_) = VT_R8, V_R8(_ptr_) = (DOUBLE)a_value )
#define ccom_set_variant_real8_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_R8|VT_BYREF, V_R8REF(_ptr_) = (DOUBLE *)rt_ec.ccom_ec_pointed_real(a_value, NULL))

// boolean
#define ccom_variant_bool(_ptr_) ((EIF_BOOLEAN) rt_ce.ccom_ce_boolean (V_BOOL(_ptr_)))
#define ccom_variant_bool_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_boolean (V_BOOLREF(_ptr_), NULL))

#define ccom_set_variant_bool(_ptr_,a_value) (V_VT(_ptr_) = VT_BOOL, V_BOOL(_ptr_) = (VARIANT_BOOL) rt_ec.ccom_ec_boolean ((EIF_BOOLEAN)a_value))
#define ccom_set_variant_bool_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_BOOL|VT_BYREF, V_BOOLREF(_ptr_) = (VARIANT_BOOL *) rt_ec.ccom_ec_pointed_boolean (a_value, NULL))

// date
#define ccom_variant_date(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_date (V_DATE(_ptr_)))
#define ccom_variant_date_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_date(*(V_DATEREF(_ptr_))))

#define ccom_set_variant_date(_ptr_,a_value) (V_VT(_ptr_) = VT_DATE, V_DATE(_ptr_) = (DATE) rt_ec.ccom_ec_date (a_value))
#define ccom_set_variant_date_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_DATE|VT_BYREF, V_DATEREF(_ptr_) = (DATE *) (rt_ec.ccom_ec_pointed_date (a_value, NULL)))

// scode/ HRESULT
#define ccom_variant_error(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_hresult ((HRESULT)V_ERROR(_ptr_)))
#define ccom_variant_error_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_hresult (*(HRESULT *)V_ERRORREF(_ptr_)))

#define ccom_set_variant_error(_ptr_,a_value) (V_VT(_ptr_) = VT_ERROR, V_ERROR(_ptr_) = (SCODE)a_value)
#define ccom_set_variant_error_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ERROR|VT_BYREF, V_ERRORREF(_ptr_) = rt_ec.ccom_ec_pointed_hresult((SCODE)a_value))

// decimal
#define ccom_variant_decimal(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_decimal (V_DECIMAL(_ptr_)))
#define ccom_variant_decimal_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_decimal (V_DECIMALREF(_ptr_)))

#define ccom_set_variant_decimal(_ptr_,a_value) (V_VT(_ptr_) = VT_DECIMAL, V_DECIMAL(_ptr_) = (DECIMAL)*(a_value))
#define ccom_set_variant_decimal_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_DECIMAL|VT_BYREF, V_DECIMALREF(_ptr_) = (DECIMAL *)a_value)

// currency
#define ccom_variant_currency(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_currency (V_CY(_ptr_)))
#define ccom_variant_currency_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_currency (V_CYREF(_ptr_)))

#define ccom_set_variant_currency(_ptr_,a_value) (V_VT(_ptr_) = VT_CY, V_CY(_ptr_) = (CY) *(a_value))
#define ccom_set_variant_currency_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_CY|VT_BYREF, V_CYREF(_ptr_) = (CY *)a_value)

// BSTR
#define ccom_variant_bstr(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_bstr ( V_BSTR(_ptr_)))
#define ccom_variant_bstr_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_bstr ( *(V_BSTRREF(_ptr_))))

#define ccom_set_variant_bstr(_ptr_,a_value) (V_VT(_ptr_) = VT_BSTR, V_BSTR(_ptr_) = (BSTR) rt_ec.ccom_ec_bstr (a_value))
#define ccom_set_variant_bstr_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_BSTR|VT_BYREF, V_BSTRREF(_ptr_) = (BSTR *) (rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_bstr (a_value))))

// VARIANT
#define ccom_variant_variant(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_variant(V_VARIANTREF(_ptr_)))

#define ccom_set_variant_variant(_ptr_,a_value) (V_VT(_ptr_) = VT_VARIANT|VT_BYREF, V_VARIANTREF(_ptr_) = a_value)

// IUnknown
#define ccom_variant_unknown(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_unknown(V_UNKNOWN(_ptr_)))
#define ccom_variant_unknown_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_unknown(*(V_UNKNOWNREF(_ptr_))))

#define ccom_set_variant_unknown(_ptr_,a_value) (V_VT(_ptr_) = VT_UNKNOWN, V_UNKNOWN(_ptr_) = (IUnknown *)a_value)
#define ccom_set_variant_unknown_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_UNKNOWN|VT_BYREF, V_UNKNOWNREF(_ptr_) = (IUnknown **)rt_ec.ccom_ec_pointed_c_pointer((void *)(a_value)))

// IDispatch
#define ccom_variant_dispatch(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_dispatch(V_DISPATCH(_ptr_)))
#define ccom_variant_dispatch_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_pointed_dispatch(*(V_DISPATCHREF(_ptr_))))

#define ccom_set_variant_dispatch(_ptr_,a_value) (V_VT(_ptr_) = VT_DISPATCH, V_DISPATCH(_ptr_) = (IDispatch *) rt_ec.ccom_ec_dispatch (a_value))
#define ccom_set_variant_dispatch_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_DISPATCH|VT_BYREF, V_DISPATCHREF(_ptr_) = (IDispatch **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_dispatch(a_value)))

// safearray
#define ccom_variant_safearray_unsigned_int(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_long(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_int(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_long(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_unsigned_char(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_char(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_char(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_char(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_unsigned_short(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_short(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_short(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_short(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_unsigned_long(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_long(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_long(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_long(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_float(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_float(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_double(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_double(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_currency(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_currency(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_date(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_date(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_bstr(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_bstr(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_dispatch(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_dispatch(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_hresult(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_hresult(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_boolean(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_boolean(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_variant(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_variant(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_unknown(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_unknown(V_ARRAY(_ptr_)))
#define ccom_variant_safearray_decimal(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_decimal(V_ARRAY(_ptr_)))

// set SAFEARRAY
#define ccom_set_variant_safearray_unsigned_int(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_long(a_value))
#define ccom_set_variant_safearray_int(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_long(a_value))
#define ccom_set_variant_safearray_unsigned_char(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_char(a_value))
#define ccom_set_variant_safearray_char(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_char(a_value))
#define ccom_set_variant_safearray_unsigned_short(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_short(a_value))
#define ccom_set_variant_safearray_short(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_short(a_value))
#define ccom_set_variant_safearray_unsigned_long(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_long(a_value))
#define ccom_set_variant_safearray_long(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_long(a_value))
#define ccom_set_variant_safearray_float(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_float(a_value))
#define ccom_set_variant_safearray_double(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_double(a_value))
#define ccom_set_variant_safearray_currency(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_currency(a_value))
#define ccom_set_variant_safearray_date(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_date(a_value))
#define ccom_set_variant_safearray_bstr(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_bstr(a_value))
#define ccom_set_variant_safearray_dispatch(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_dispatch(a_value))
#define ccom_set_variant_safearray_hresult(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_hresult(a_value))
#define ccom_set_variant_safearray_boolean(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_boolean(a_value))
#define ccom_set_variant_safearray_variant(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_variant(a_value))
#define ccom_set_variant_safearray_unknown(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_unknown(a_value))
#define ccom_set_variant_safearray_decimal(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY, V_ARRAY(_ptr_) = (SAFEARRAY *)rt_ec.ccom_ec_safearray_decimal(a_value))

// safearray byref
#define ccom_variant_safearray_unsigned_int_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_long((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_int_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_long((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_unsigned_char_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_char((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_char_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_char((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_unsigned_short_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_short((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_short_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_short((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_unsigned_long_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_long((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_long_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_long((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_float_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_float((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_double_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_double((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_currency_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_currency((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_date_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_date((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_bstr_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_bstr((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_dispatch_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_dispatch((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_hresult_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_hresult((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_boolean_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_boolean((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_variant_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_variant((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_unknown_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_unknown((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))
#define ccom_variant_safearray_decimal_byref(_ptr_) ((EIF_REFERENCE) rt_ce.ccom_ce_safearray_decimal((SAFEARRAY *)*(V_ARRAYREF(_ptr_))))

// set SAFEARRAY byref
#define ccom_set_variant_safearray_unsigned_int_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_long(a_value)))
#define ccom_set_variant_safearray_int_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_long(a_value)))
#define ccom_set_variant_safearray_unsigned_char_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_char(a_value)))
#define ccom_set_variant_safearray_char_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_char(a_value)))
#define ccom_set_variant_safearray_unsigned_short_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_short(a_value)))
#define ccom_set_variant_safearray_short_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_short(a_value)))
#define ccom_set_variant_safearray_unsigned_long_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_long(a_value)))
#define ccom_set_variant_safearray_long_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_long(a_value)))
#define ccom_set_variant_safearray_float_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_float(a_value)))
#define ccom_set_variant_safearray_double_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_double(a_value)))
#define ccom_set_variant_safearray_currency_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_currency(a_value)))
#define ccom_set_variant_safearray_date_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_date(a_value)))
#define ccom_set_variant_safearray_bstr_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_bstr(a_value)))
#define ccom_set_variant_safearray_dispatch_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_dispatch(a_value)))
#define ccom_set_variant_safearray_hresult_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_hresult(a_value)))
#define ccom_set_variant_safearray_boolean_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_boolean(a_value)))
#define ccom_set_variant_safearray_variant_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_variant(a_value)))
#define ccom_set_variant_safearray_unknown_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_unknown(a_value)))
#define ccom_set_variant_safearray_decimal_byref(_ptr_,a_value) (V_VT(_ptr_) = VT_ARRAY|VT_BYREF, V_ARRAYREF(_ptr_) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_decimal(a_value)))

#endif // !__ECOM_E_VARIANT_H_INC__
