/*********************************
	E_variant.cpp
**********************************/

#include "E_variant.h"

ecom_variant::ecom_variant ()
{
	variant = (VARIANT*)CoTaskMemAlloc (sizeof (VARIANT));
	VariantInit(variant);
}

ecom_variant::ecom_variant (VARIANT *a_ptr)
{
	variant = (VARIANT*)CoTaskMemAlloc (sizeof (VARIANT));
	VariantInit(variant);
	VariantCopy (variant, a_ptr);
}

ecom_variant::~ecom_variant()
{
	CoTaskMemFree (variant);
}

EIF_POINTER ecom_variant::ccom_variant_item ()
{
	return (EIF_POINTER) variant;
}

void ecom_variant::ccom_set_character_reference(EIF_OBJECT char_ref)
{
	V_VT(variant) = VT_I1|VT_BYREF;
	V_I1REF(variant) = (CHAR *)rt_ec.ccom_ec_pointed_character(eif_access(char_ref), NULL);
}

EIF_INTEGER ecom_variant::ccom_variable_type ()
{
	return (EIF_INTEGER)V_VT(variant);
}

void ecom_variant::ccom_set_variable_type(VARTYPE a_value)
{
	V_VT(variant) = a_value;
}

EIF_CHARACTER ecom_variant::ccom_character ()
{
	return (EIF_CHARACTER) V_I1(variant);
}

EIF_REFERENCE ecom_variant::ccom_character_reference ()
{
	return rt_ce.ccom_ce_pointed_character((unsigned char *)V_I1REF(variant), NULL);
}

EIF_CHARACTER ecom_variant::ccom_unsigned_character ()
{
	return (EIF_CHARACTER) V_UI1(variant);
}

EIF_REFERENCE ecom_variant::ccom_unsigned_character_reference()
{
	return rt_ce.ccom_ce_pointed_character (V_UI1REF(variant), NULL);
}

void ecom_variant::ccom_set_character (EIF_CHARACTER char_value)
{
	V_VT(variant) = VT_I1;
	V_I1(variant)=(CHAR)char_value;
}

void ecom_variant::ccom_set_unsigned_character (EIF_CHARACTER a_value)
{
	V_VT(variant) = VT_UI1;
	V_UI1(variant) = (BYTE)a_value;
}

void ecom_variant::ccom_set_unsigned_character_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_UI1|VT_BYREF;
	V_UI1REF(variant) = (BYTE *)rt_ec.ccom_ec_pointed_character(eif_access(a_value), NULL);
}

EIF_INTEGER ecom_variant::ccom_integer2()
{
	return (EIF_INTEGER) V_I2(variant);
}

EIF_REFERENCE ecom_variant::ccom_integer2_reference()
{
	return rt_ce.ccom_ce_pointed_short(V_I2REF(variant), NULL);
}

EIF_INTEGER ecom_variant::ccom_unsigned_integer2()
{
	return (EIF_INTEGER) V_UI2(variant);
}

EIF_REFERENCE ecom_variant::ccom_unsigned_integer2_reference()
{
	return rt_ce.ccom_ce_pointed_short((short *)V_UI2REF(variant), NULL);
}

void ecom_variant::ccom_set_integer2 (EIF_INTEGER a_value)
{
	V_VT(variant) = VT_I2;
	V_I2(variant) = (SHORT)a_value;
}

void ecom_variant::ccom_set_integer2_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_I2|VT_BYREF;
	V_I2REF(variant) = (SHORT *)rt_ec.ccom_ec_pointed_short(eif_access(a_value), NULL);
}

void ecom_variant::ccom_set_unsigned_integer2 (EIF_INTEGER a_value)
{
	V_VT(variant) = VT_UI2;
	V_UI2(variant) = (USHORT)a_value;
}

void ecom_variant::ccom_set_unsigned_integer2_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_UI2|VT_BYREF;
	V_UI2REF(variant) = (USHORT *)rt_ec.ccom_ec_pointed_short(eif_access(a_value), NULL);
}

EIF_INTEGER ecom_variant::ccom_integer4 ()
{
	return (EIF_INTEGER) V_I4(variant);
}

EIF_REFERENCE ecom_variant::ccom_integer4_reference ()
{
	return rt_ce.ccom_ce_pointed_long(V_I4REF(variant), NULL);
}

EIF_INTEGER ecom_variant::ccom_unsigned_integer4 ()
{
	return (EIF_INTEGER) V_UI4(variant);
}

EIF_REFERENCE ecom_variant::ccom_unsigned_integer4_reference ()
{
	return rt_ce.ccom_ce_pointed_long((long *)V_UI4REF(variant), NULL);
}

void ecom_variant::ccom_set_integer4 (EIF_INTEGER a_value)
{
	V_VT(variant) = VT_I4;
	V_I4(variant) = (LONG)a_value;
}

void ecom_variant::ccom_set_integer4_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_I4|VT_BYREF;
	V_I4REF(variant) = (LONG *)rt_ec.ccom_ec_pointed_long(eif_access(a_value), NULL);
}

void ecom_variant::ccom_set_unsigned_integer4 (EIF_INTEGER a_value)
{
	V_VT(variant) = VT_UI4;
	V_UI4(variant) = (ULONG)a_value;
}

void ecom_variant::ccom_set_unsigned_integer4_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_UI4|VT_BYREF;
	V_UI4REF(variant) = (ULONG *)rt_ec.ccom_ec_pointed_long(eif_access(a_value), NULL);
}

EIF_INTEGER ecom_variant::ccom_integer ()
{
	return (EIF_INTEGER) V_INT(variant);
}

EIF_REFERENCE ecom_variant::ccom_integer_reference ()
{
	return rt_ce.ccom_ce_pointed_integer(V_INTREF(variant),NULL);
}

EIF_INTEGER ecom_variant::ccom_unsigned_integer ()
{
	return (EIF_INTEGER) V_UINT(variant);
}

EIF_REFERENCE ecom_variant::ccom_unsigned_integer_reference ()
{
	return rt_ce.ccom_ce_pointed_integer((int *)V_UINTREF(variant), NULL);
}

void ecom_variant::ccom_set_integer (EIF_INTEGER a_value)
{
	V_VT(variant) = VT_INT;
	V_INT(variant) = (INT)a_value;
}

void ecom_variant::ccom_set_integer_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_INT|VT_BYREF;
	V_INTREF(variant) = (INT *)rt_ec.ccom_ec_pointed_long(eif_access (a_value), NULL);
}

void ecom_variant::ccom_set_unsigned_integer(EIF_INTEGER a_value)
{
	V_VT(variant) = VT_UINT;
	V_UINT(variant) = (UINT)a_value;
}

void ecom_variant::ccom_set_unsigned_integer_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_UINT|VT_BYREF;
	V_UINTREF(variant) = (UINT *)rt_ec.ccom_ec_pointed_long(eif_access(a_value), NULL);
}

EIF_REAL ecom_variant::ccom_real4 ()
{
	return (EIF_REAL) V_R4(variant);
}

EIF_REFERENCE ecom_variant::ccom_real4_reference ()
{
	return rt_ce.ccom_ce_pointed_real(V_R4REF(variant), NULL);
}

void ecom_variant::ccom_set_real4 (EIF_REAL a_value)
{
	V_VT(variant) = VT_R4;
	V_R4(variant) = (FLOAT)a_value;
}

void ecom_variant::ccom_set_real4_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_R4|VT_BYREF;
	V_R4REF(variant) = (FLOAT *)rt_ec.ccom_ec_pointed_real(eif_access (a_value), NULL);
}

EIF_DOUBLE ecom_variant::ccom_real8 ()
{
	return (EIF_DOUBLE) V_R8(variant);
}

EIF_REFERENCE ecom_variant::ccom_real8_reference ()
{
	return rt_ce.ccom_ce_pointed_double (V_R8REF(variant), NULL);
}

void ecom_variant::ccom_set_real8 (EIF_DOUBLE a_value)
{
	V_VT(variant) = VT_R8;
	V_R8(variant) = (DOUBLE)a_value;
}

void ecom_variant::ccom_set_real8_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_R8|VT_BYREF;
	V_R8REF(variant) = (DOUBLE *)rt_ec.ccom_ec_pointed_double (eif_access (a_value), NULL);
}

EIF_BOOLEAN ecom_variant::ccom_bool ()
{
	return rt_ce.ccom_ce_boolean (V_BOOL(variant));
}

EIF_REFERENCE ecom_variant::ccom_bool_reference ()
{
	return rt_ce.ccom_ce_pointed_boolean (V_BOOLREF(variant), NULL);
}

void ecom_variant::ccom_set_bool (EIF_BOOLEAN a_value)
{
	V_VT(variant) = VT_BOOL;
	V_BOOL(variant) = rt_ec.ccom_ec_boolean (a_value);
}

void ecom_variant::ccom_set_bool_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_BOOL|VT_BYREF;
	V_BOOLREF(variant) = rt_ec.ccom_ec_pointed_boolean (eif_access (a_value), NULL);
}

EIF_REFERENCE ecom_variant::ccom_date ()
{
	return rt_ce.ccom_ce_date (V_DATE(variant));
}

EIF_REFERENCE ecom_variant::ccom_date_reference ()
{
	return rt_ce.ccom_ce_pointed_date(V_DATEREF(variant));
}

void ecom_variant::ccom_set_date (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_DATE;
	V_DATE(variant) = (DATE) rt_ec.ccom_ec_date (eif_access (a_value));
}

void ecom_variant::ccom_set_date_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_DATE|VT_BYREF;
	V_DATEREF(variant) = rt_ec.ccom_ec_pointed_date (eif_access(a_value), NULL);
}

EIF_INTEGER ecom_variant::ccom_error ()
{
	return (EIF_INTEGER) V_ERROR(variant);
}

EIF_INTEGER ecom_variant::ccom_error_reference ()
{
	return (EIF_INTEGER) *(V_ERRORREF(variant));
}

void ecom_variant::ccom_set_error (SCODE a_value)
{
	V_VT(variant) = VT_ERROR;
	V_ERROR(variant) = (SCODE)a_value;
}

void ecom_variant::ccom_set_error_reference (SCODE a_value)
{
	V_VT(variant) = VT_ERROR|VT_BYREF;
	V_ERRORREF(variant) = rt_ec.ccom_ec_pointed_hresult(a_value);
}

EIF_REFERENCE ecom_variant::ccom_decimal ()
{
	return rt_ce.ccom_ce_decimal (V_DECIMAL(variant));
}

EIF_POINTER ecom_variant::ccom_decimal_reference ()
{
	return (EIF_POINTER) V_DECIMALREF(variant);
}

void ecom_variant::ccom_set_decimal (DECIMAL * a_value)
{
	V_VT(variant) = VT_DECIMAL;
	V_DECIMAL(variant) = (DECIMAL)*(a_value);
}

void ecom_variant::ccom_set_decimal_reference (DECIMAL *a_value)
{
	V_VT(variant) = VT_DECIMAL|VT_BYREF;
	V_DECIMALREF(variant) = a_value;
}

EIF_REFERENCE ecom_variant::ccom_currency ()
{
	return rt_ce.ccom_ce_currency (V_CY(variant));
}

EIF_POINTER ecom_variant::ccom_currency_reference ()
{
	return (EIF_POINTER) V_CYREF(variant);
}

void ecom_variant::ccom_set_currency (CY *a_value)
{
	V_VT(variant) = VT_CY;
	V_CY(variant) = (CY) *(a_value);
}

void ecom_variant::ccom_set_currency_reference (CY *a_value)
{
	V_VT(variant) = VT_CY|VT_BYREF;
	V_CYREF(variant) = (CY *)a_value;
}

EIF_REFERENCE ecom_variant::ccom_bstr ()
{
	return rt_ce.ccom_ce_bstr ( V_BSTR(variant));
}

EIF_REFERENCE ecom_variant::ccom_bstr_reference ()
{
	return rt_ce.ccom_ce_pointed_bstr (V_BSTRREF(variant));
}

void ecom_variant::ccom_set_bstr (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_BSTR;
	V_BSTR(variant) = (BSTR) rt_ec.ccom_ec_bstr (eif_access (a_value));
}

void ecom_variant::ccom_set_bstr_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_BSTR|VT_BYREF;
	V_BSTRREF(variant) = (BSTR *) rt_ec.ccom_ec_pointed_c_pointer((void *) rt_ec.ccom_ec_bstr (eif_access(a_value)));
}

EIF_REFERENCE ecom_variant::ccom_variant ()
{
	return rt_ce.ccom_ce_pointed_variant(V_VARIANTREF(variant));
}

void ecom_variant::ccom_set_variant (VARIANT *a_value)
{
	V_VT(variant) = VT_VARIANT|VT_BYREF;
	V_VARIANTREF(variant) = a_value;
}

EIF_REFERENCE ecom_variant::ccom_unknown_interface ()
{
	return rt_ce.ccom_ce_pointed_unknown(V_UNKNOWN(variant));
}

EIF_REFERENCE ecom_variant::ccom_unknown_interface_reference ()
{
	return rt_ce.ccom_ce_pointed_unknown(*(V_UNKNOWNREF(variant)));
}

void ecom_variant::ccom_set_unknown_interface (IUnknown *a_value)
{
	V_VT(variant) = VT_UNKNOWN;
	V_UNKNOWN(variant) = a_value;
}

void ecom_variant::ccom_set_unknown_interface_reference (IUnknown *a_value)
{
	V_VT(variant) = VT_UNKNOWN|VT_BYREF;
	V_UNKNOWNREF(variant) = (IUnknown **)rt_ec.ccom_ec_pointed_c_pointer((void *)a_value);
}

EIF_REFERENCE ecom_variant::ccom_dispatch_interface ()
{
	return rt_ce.ccom_ce_pointed_dispatch(V_DISPATCH(variant));
}

EIF_REFERENCE ecom_variant::ccom_dispatch_interface_reference ()
{
	return rt_ce.ccom_ce_pointed_dispatch(*(V_DISPATCHREF(variant)));
}

void ecom_variant::ccom_set_dispatch_interface (IDispatch * a_value)
{
	V_VT(variant) = VT_DISPATCH;
	V_DISPATCH(variant) = a_value;
}

void ecom_variant::ccom_set_dispatch_interface_reference (IDispatch *a_value)
{
	V_VT(variant) = VT_DISPATCH|VT_BYREF;
	V_DISPATCHREF(variant) = (IDispatch **)rt_ec.ccom_ec_pointed_c_pointer((void *)a_value);
}

EIF_REFERENCE ecom_variant::ccom_safearray_unsigned_integer ()
{
	return rt_ce.ccom_ce_safearray_long(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_integer ()
{
	return rt_ce.ccom_ce_safearray_long(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_unsigned_character ()
{
	return rt_ce.ccom_ce_safearray_char(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_character ()
{
	return rt_ce.ccom_ce_safearray_char(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_unsigned_short ()
{
	return rt_ce.ccom_ce_safearray_short(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_short ()
{
	return rt_ce.ccom_ce_safearray_short(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_unsigned_long ()
{
	return rt_ce.ccom_ce_safearray_long(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_long ()
{
	return rt_ce.ccom_ce_safearray_long(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_float ()
{
	return rt_ce.ccom_ce_safearray_float(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_double ()
{
	return rt_ce.ccom_ce_safearray_double(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_currency ()
{
	return rt_ce.ccom_ce_safearray_currency(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_date ()
{
	return rt_ce.ccom_ce_safearray_date(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_bstr ()
{
	return rt_ce.ccom_ce_safearray_bstr(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_dispatch_interface ()
{
	return rt_ce.ccom_ce_safearray_dispatch(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_hresult ()
{
	return rt_ce.ccom_ce_safearray_hresult(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_boolean ()
{
	return rt_ce.ccom_ce_safearray_boolean(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_variant ()
{
	return rt_ce.ccom_ce_safearray_variant(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_unknown_interface ()
{
	return rt_ce.ccom_ce_safearray_unknown(V_ARRAY(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_decimal ()
{
	return rt_ce.ccom_ce_safearray_decimal(V_ARRAY(variant));
}

void ecom_variant::ccom_set_safearray_unsigned_integer (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_UINT;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_long(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_integer (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_INT;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_long(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_unsigned_character (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_UI1;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_char(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_character (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_I1;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_char(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_unsigned_short (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_UI2;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_short(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_short (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_I2;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_short(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_unsigned_long (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_UI4;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_long(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_long (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_I4;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_long(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_float (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_R4;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_float(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_double (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_R8;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_double(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_currency (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_CY;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_currency(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_date (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_DATE;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_date(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_bstr (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BSTR;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_bstr(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_dispatch_interface (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_DISPATCH;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_dispatch(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_hresult (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_ERROR;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_hresult(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_boolean (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BOOL;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_boolean(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_variant (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_VARIANT;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_variant(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_unknown_interface (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_UNKNOWN;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_unknown(eif_access(a_value));
}

void ecom_variant::ccom_set_safearray_decimal (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_DECIMAL;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_decimal(eif_access(a_value));
}

EIF_REFERENCE ecom_variant::ccom_safearray_unsigned_integer_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_long(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_integer_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_long(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_unsigned_character_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_char(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_character_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_char(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_unsigned_short_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_short(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_short_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_short(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_unsigned_long_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_long(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_long_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_long(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_float_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_float(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_double_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_double(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_currency_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_currency(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_date_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_date(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_bstr_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_bstr(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_dispatch_interface_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_dispatch(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_hresult_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_hresult(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_boolean_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_boolean(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_variant_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_variant(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_unknown_interface_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_unknown(V_ARRAYREF(variant));
}

EIF_REFERENCE ecom_variant::ccom_safearray_decimal_reference ()
{
	return rt_ce.ccom_ce_pointed_safearray_decimal(V_ARRAYREF(variant));
}

void ecom_variant::ccom_set_safearray_unsigned_integer_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_UINT;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_long(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_integer_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_INT;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_long(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_unsigned_character_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_UI1;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_char(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_character_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_I1;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_char(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_unsigned_short_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_UI2;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_short(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_short_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_I2;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_short(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_unsigned_long_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_UI4;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_long(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_long_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_I4;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_long(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_float_reference(EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_R4;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_float(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_double_reference(EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_R8;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_double(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_currency_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_CY;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_currency(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_date_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_DATE;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_date(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_bstr_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_BSTR;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_bstr(eif_access(a_value)));
}
void ecom_variant::ccom_set_safearray_dispatch_interface_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_DISPATCH;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_dispatch(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_hresult_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_ERROR;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_hresult(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_boolean_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_BOOL;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_boolean(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_variant_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_VARIANT;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_variant(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_unknown_interface_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_UNKNOWN;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_unknown(eif_access(a_value)));
}

void ecom_variant::ccom_set_safearray_decimal_reference (EIF_OBJECT a_value)
{
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_DECIMAL;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_decimal(eif_access(a_value)));
}
