/*
indexing
	description: "EiffelCOM: library of reusable components for COM."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*********************************
	E_variant.cpp
**********************************/

#include "E_variant.h"


#ifdef __cplusplus
extern "C" {
#endif

VARIANT * create_ecom_variant ()
{
	VARIANT * result = NULL;
	result = (VARIANT*)CoTaskMemAlloc (sizeof (VARIANT));
	VariantInit(result);
	return result;
};
//-------------------------------------------------------------------

void ccom_set_character_reference(VARIANT * variant, EIF_OBJECT char_ref)
{
	VariantClear (variant);
	V_VT(variant) = VT_I1|VT_BYREF;
	V_I1REF(variant) = (CHAR *)rt_ec.ccom_ec_pointed_character(eif_access(char_ref), NULL);
};
//-------------------------------------------------------------------


EIF_INTEGER ccom_variable_type (VARIANT * variant)
{
	return (EIF_INTEGER)V_VT(variant);
};
//-------------------------------------------------------------------


void ccom_set_variable_type(VARIANT * variant, VARTYPE a_value)
{
	V_VT(variant) = a_value;
};
//-------------------------------------------------------------------


EIF_CHARACTER ccom_character (VARIANT * variant)
{
	return (EIF_CHARACTER) V_I1(variant);
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_character_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_character((char *)V_I1REF(variant), NULL);
};
//-------------------------------------------------------------------


EIF_CHARACTER ccom_unsigned_character (VARIANT * variant)
{
	return (EIF_CHARACTER) V_UI1(variant);
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_unsigned_character_reference(VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_character ((char *)V_UI1REF(variant), NULL);
};
//-------------------------------------------------------------------


void ccom_set_character (VARIANT * variant, EIF_CHARACTER char_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_I1;
	V_I1(variant)=(CHAR)char_value;
};
//-------------------------------------------------------------------


void ccom_set_unsigned_character (VARIANT * variant, EIF_CHARACTER a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_UI1;
	V_UI1(variant) = (BYTE)a_value;
};
//-------------------------------------------------------------------


void ccom_set_unsigned_character_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_UI1|VT_BYREF;
	V_UI1REF(variant) = (BYTE *)rt_ec.ccom_ec_pointed_character(eif_access(a_value), NULL);
};
//-------------------------------------------------------------------


EIF_INTEGER ccom_integer2(VARIANT * variant)
{
	return (EIF_INTEGER) V_I2(variant);
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_integer2_reference(VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_short(V_I2REF(variant), NULL);
};
//-------------------------------------------------------------------


EIF_INTEGER ccom_unsigned_integer2(VARIANT * variant)
{
	return (EIF_INTEGER) V_UI2(variant);
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_unsigned_integer2_reference(VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_short((short *)V_UI2REF(variant), NULL);
};
//-------------------------------------------------------------------


void ccom_set_integer2 (VARIANT * variant, EIF_INTEGER a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_I2;
	V_I2(variant) = (SHORT)a_value;
};
//-------------------------------------------------------------------


void ccom_set_integer2_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_I2|VT_BYREF;
	V_I2REF(variant) = (SHORT *)rt_ec.ccom_ec_pointed_short(eif_access(a_value), NULL);
};
//-------------------------------------------------------------------


void ccom_set_unsigned_integer2 (VARIANT * variant, EIF_INTEGER a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_UI2;
	V_UI2(variant) = (USHORT)a_value;
};
//-------------------------------------------------------------------


void ccom_set_unsigned_integer2_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_UI2|VT_BYREF;
	V_UI2REF(variant) = (USHORT *)rt_ec.ccom_ec_pointed_short(eif_access(a_value), NULL);
};
//-------------------------------------------------------------------


EIF_INTEGER ccom_integer4 (VARIANT * variant)
{
	return (EIF_INTEGER) V_I4(variant);
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_integer4_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_long(V_I4REF(variant), NULL);
};
//-------------------------------------------------------------------


EIF_INTEGER ccom_unsigned_integer4 (VARIANT * variant)
{
	return (EIF_INTEGER) V_UI4(variant);
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_unsigned_integer4_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_long((long *)V_UI4REF(variant), NULL);
};
//-------------------------------------------------------------------


void ccom_set_integer4 (VARIANT * variant, EIF_INTEGER a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_I4;
	V_I4(variant) = (LONG)a_value;
};
//-------------------------------------------------------------------


void ccom_set_integer4_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_I4|VT_BYREF;
	V_I4REF(variant) = (LONG *)rt_ec.ccom_ec_pointed_long(eif_access(a_value), NULL);
};
//-------------------------------------------------------------------


void ccom_set_unsigned_integer4 (VARIANT * variant, EIF_INTEGER a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_UI4;
	V_UI4(variant) = (ULONG)a_value;
};
//-------------------------------------------------------------------


void ccom_set_unsigned_integer4_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_UI4|VT_BYREF;
	V_UI4REF(variant) = (ULONG *)rt_ec.ccom_ec_pointed_long(eif_access(a_value), NULL);
};
//-------------------------------------------------------------------


EIF_INTEGER ccom_integer (VARIANT * variant)
{
	return (EIF_INTEGER) V_INT(variant);
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_integer_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_integer(V_INTREF(variant),NULL);
};
//-------------------------------------------------------------------


EIF_INTEGER ccom_unsigned_integer (VARIANT * variant)
{
	return (EIF_INTEGER) V_UINT(variant);
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_unsigned_integer_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_integer((int *)V_UINTREF(variant), NULL);
};
//-------------------------------------------------------------------


void ccom_set_integer (VARIANT * variant, EIF_INTEGER a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_INT;
	V_INT(variant) = (INT)a_value;
};
//-------------------------------------------------------------------


void ccom_set_integer_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_INT|VT_BYREF;
	V_INTREF(variant) = (INT *)rt_ec.ccom_ec_pointed_long(eif_access (a_value), NULL);
};
//-------------------------------------------------------------------


void ccom_set_unsigned_integer(VARIANT * variant, EIF_INTEGER a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_UINT;
	V_UINT(variant) = (UINT)a_value;
};
//-------------------------------------------------------------------


void ccom_set_unsigned_integer_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_UINT|VT_BYREF;
	V_UINTREF(variant) = (UINT *)rt_ec.ccom_ec_pointed_long(eif_access(a_value), NULL);
};
//-------------------------------------------------------------------


EIF_REAL ccom_real (VARIANT * variant)
{
	return (EIF_REAL) V_R4(variant);
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_real_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_real(V_R4REF(variant), NULL);
};
//-------------------------------------------------------------------


void ccom_set_real (VARIANT * variant, EIF_REAL a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_R4;
	V_R4(variant) = (FLOAT)a_value;
};
//-------------------------------------------------------------------


void ccom_set_real_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_R4|VT_BYREF;
	V_R4REF(variant) = (FLOAT *)rt_ec.ccom_ec_pointed_real(eif_access (a_value), NULL);
};
//-------------------------------------------------------------------


EIF_DOUBLE ccom_double (VARIANT * variant)
{
	return (EIF_DOUBLE) V_R8(variant);
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_double_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_double (V_R8REF(variant), NULL);
};
//-------------------------------------------------------------------


void ccom_set_double (VARIANT * variant, EIF_DOUBLE a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_R8;
	V_R8(variant) = (DOUBLE)a_value;
};
//-------------------------------------------------------------------


void ccom_set_double_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_R8|VT_BYREF;
	V_R8REF(variant) = (DOUBLE *)rt_ec.ccom_ec_pointed_double (eif_access (a_value), NULL);
};
//-------------------------------------------------------------------


EIF_BOOLEAN ccom_bool (VARIANT * variant)
{
	return rt_ce.ccom_ce_boolean (V_BOOL(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_bool_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_boolean (V_BOOLREF(variant), NULL);
};
//-------------------------------------------------------------------


void ccom_set_bool (VARIANT * variant, EIF_BOOLEAN a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_BOOL;
	V_BOOL(variant) = rt_ec.ccom_ec_boolean (a_value);
};
//-------------------------------------------------------------------


void ccom_set_bool_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_BOOL|VT_BYREF;
	V_BOOLREF(variant) = rt_ec.ccom_ec_pointed_boolean (eif_access (a_value), NULL);
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_date (VARIANT * variant)
{
	return rt_ce.ccom_ce_date (V_DATE(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_date_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_date(V_DATEREF(variant));
};
//-------------------------------------------------------------------


void ccom_set_date (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_DATE;
	V_DATE(variant) = (DATE) rt_ec.ccom_ec_date (eif_access (a_value));
};
//-------------------------------------------------------------------


void ccom_set_date_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_DATE|VT_BYREF;
	V_DATEREF(variant) = rt_ec.ccom_ec_pointed_date (eif_access(a_value), NULL);
};
//-------------------------------------------------------------------


EIF_INTEGER ccom_error (VARIANT * variant)
{
	return (EIF_INTEGER) V_ERROR(variant);
};
//-------------------------------------------------------------------


EIF_INTEGER ccom_error_reference (VARIANT * variant)
{
	return (EIF_INTEGER) *(V_ERRORREF(variant));
};
//-------------------------------------------------------------------


void ccom_set_error (VARIANT * variant, SCODE a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ERROR;
	V_ERROR(variant) = (SCODE)a_value;
};
//-------------------------------------------------------------------


void ccom_set_error_reference (VARIANT * variant, SCODE a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ERROR|VT_BYREF;
	V_ERRORREF(variant) = rt_ec.ccom_ec_pointed_hresult(a_value);
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_decimal (VARIANT * variant)
{
	return rt_ce.ccom_ce_decimal (V_DECIMAL(variant));
};
//-------------------------------------------------------------------


EIF_POINTER ccom_decimal_reference (VARIANT * variant)
{
	return (EIF_POINTER) V_DECIMALREF(variant);
};
//-------------------------------------------------------------------


void ccom_set_decimal (VARIANT * variant, DECIMAL * a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_DECIMAL;
	V_DECIMAL(variant) = (DECIMAL)*(a_value);
};
//-------------------------------------------------------------------


void ccom_set_decimal_reference (VARIANT * variant, DECIMAL *a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_DECIMAL|VT_BYREF;
	V_DECIMALREF(variant) = a_value;
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_currency (VARIANT * variant)
{
	return rt_ce.ccom_ce_currency(V_CY(variant));
};
//-------------------------------------------------------------------


EIF_POINTER ccom_currency_reference (VARIANT * variant)
{
	return (EIF_POINTER) V_CYREF(variant);
};
//-------------------------------------------------------------------

void ccom_set_currency (VARIANT * variant, CY *a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_CY;
	V_CY(variant) = (CY) *(a_value);
};
//-------------------------------------------------------------------


void ccom_set_currency_reference (VARIANT * variant, CY *a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_CY|VT_BYREF;
	V_CYREF(variant) = (CY *)a_value;
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_bstr (VARIANT * variant)
{
	return rt_ce.ccom_ce_bstr (V_BSTR(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_bstr_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_bstr (V_BSTRREF(variant));
};
//-------------------------------------------------------------------


void ccom_set_bstr (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_BSTR;
	V_BSTR(variant) = (BSTR) rt_ec.ccom_ec_bstr (eif_access (a_value));
};
//-------------------------------------------------------------------


void ccom_set_bstr_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_BSTR|VT_BYREF;
	V_BSTRREF(variant) = (BSTR *) rt_ec.ccom_ec_pointed_c_pointer((void *) rt_ec.ccom_ec_bstr (eif_access(a_value)));
};
//-------------------------------------------------------------------


EIF_POINTER ccom_variant (VARIANT * variant)
{
	VARIANT * a_result = (VARIANT *)CoTaskMemAlloc (sizeof (VARIANT));
	VariantInit (a_result);

	HRESULT hr = VariantCopy (a_result, V_VARIANTREF(variant));
	if (FAILED (hr))
	{
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	return (EIF_POINTER)a_result;
};
//-------------------------------------------------------------------


void ccom_set_variant (VARIANT * variant, VARIANT *a_value)
{
	VARIANT * a_result = (VARIANT *)CoTaskMemAlloc (sizeof (VARIANT));
	VariantInit (a_result);

	HRESULT hr = VariantCopy (a_result, a_value);
	if (FAILED (hr))
	{
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

	VariantClear (variant);
	V_VT(variant) = VT_VARIANT|VT_BYREF;
	V_VARIANTREF(variant) = a_result;
};
//-------------------------------------------------------------------


EIF_POINTER ccom_iunknown (VARIANT * variant)
{
	IUnknown * punk = V_UNKNOWN(variant);
	punk->AddRef ();
	return (EIF_POINTER)punk;
};
//-------------------------------------------------------------------


EIF_POINTER ccom_iunknown_reference (VARIANT * variant)
{
	IUnknown * punk = *(V_UNKNOWNREF(variant));
	punk->AddRef ();
	return (EIF_POINTER)punk;
};
//-------------------------------------------------------------------


void ccom_set_iunknown (VARIANT * variant, IUnknown *a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_UNKNOWN;
	V_UNKNOWN(variant) = a_value;
	if (a_value != NULL)
		a_value->AddRef ();
};
//-------------------------------------------------------------------


void ccom_set_iunknown_reference (VARIANT * variant, IUnknown *a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_UNKNOWN|VT_BYREF;
	V_UNKNOWNREF(variant) = (IUnknown **)rt_ec.ccom_ec_pointed_c_pointer((void *)a_value);
	if (a_value != NULL)
		a_value->AddRef ();
};
//-------------------------------------------------------------------


EIF_POINTER ccom_idispatch (VARIANT * variant)
{
	IDispatch * pdisp = V_DISPATCH(variant);
	pdisp->AddRef ();
	return (EIF_POINTER)pdisp;
};
//-------------------------------------------------------------------


EIF_POINTER ccom_idispatch_reference (VARIANT * variant)
{
	IDispatch * pdisp = *(V_DISPATCHREF(variant));
	pdisp->AddRef ();
	return (EIF_POINTER)pdisp;
};
//-------------------------------------------------------------------


void ccom_set_idispatch (VARIANT * variant, IDispatch * a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_DISPATCH;
	V_DISPATCH(variant) = a_value;
	if (a_value != NULL)
		a_value->AddRef ();
};
//-------------------------------------------------------------------


void ccom_set_idispatch_reference (VARIANT * variant, IDispatch *a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_DISPATCH|VT_BYREF;
	V_DISPATCHREF(variant) = (IDispatch **)rt_ec.ccom_ec_pointed_c_pointer((void *)a_value);
	if (a_value != NULL)
		a_value->AddRef ();
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_unsigned_integer (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_long(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_integer (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_long(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_unsigned_character (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_char(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_character (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_char(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_unsigned_short (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_short(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_short (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_short(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_unsigned_long (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_long(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_long (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_long(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_float (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_float(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_double (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_double(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_currency (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_currency(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_date (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_date(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_bstr (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_bstr(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_idispatch (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_dispatch(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_error (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_hresult(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_boolean (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_boolean(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_variant (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_variant(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_iunknown (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_unknown(V_ARRAY(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_decimal (VARIANT * variant)
{
	return rt_ce.ccom_ce_safearray_decimal(V_ARRAY(variant));
};
//-------------------------------------------------------------------


void ccom_set_safearray_unsigned_integer (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_UINT;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_long(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_integer (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_INT;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_long(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_unsigned_character (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_UI1;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_char(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_character (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_I1;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_char(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_unsigned_short (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_UI2;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_short(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_short (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_I2;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_short(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_unsigned_long (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_UI4;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_long(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_long (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_I4;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_long(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_float (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_R4;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_float(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_double (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_R8;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_double(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_currency (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_CY;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_currency(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_date (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_DATE;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_date(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_bstr (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BSTR;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_bstr(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_idispatch (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_DISPATCH;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_dispatch(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_error (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_ERROR;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_hresult(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_boolean (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BOOL;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_boolean(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_variant (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_VARIANT;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_variant(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_iunknown (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_UNKNOWN;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_unknown(eif_access(a_value));
};
//-------------------------------------------------------------------


void ccom_set_safearray_decimal (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_DECIMAL;
	V_ARRAY(variant) = rt_ec.ccom_ec_safearray_decimal(eif_access(a_value));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_unsigned_integer_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_long(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_integer_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_long(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_unsigned_character_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_char(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_character_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_char(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_unsigned_short_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_short(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_short_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_short(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_unsigned_long_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_long(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_long_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_long(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_float_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_float(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_double_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_double(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_currency_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_currency(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_date_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_date(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_bstr_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_bstr(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_idispatch_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_dispatch(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_error_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_hresult(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_boolean_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_boolean(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_variant_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_variant(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_iunknown_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_unknown(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


EIF_REFERENCE ccom_safearray_decimal_reference (VARIANT * variant)
{
	return rt_ce.ccom_ce_pointed_safearray_decimal(V_ARRAYREF(variant));
};
//-------------------------------------------------------------------


void ccom_set_safearray_unsigned_integer_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_UINT;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_long(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_integer_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_INT;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_long(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_unsigned_character_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_UI1;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_char(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_character_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_I1;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_char(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_unsigned_short_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_UI2;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_short(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_short_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_I2;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_short(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_unsigned_long_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_UI4;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_long(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_long_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_I4;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_long(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_float_reference(VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_R4;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_float(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_double_reference(VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_R8;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_double(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_currency_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_CY;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_currency(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_date_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_DATE;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_date(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_bstr_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_BSTR;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_bstr(eif_access(a_value)));
};
//-------------------------------------------------------------------

void ccom_set_safearray_idispatch_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_DISPATCH;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_dispatch(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_error_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_ERROR;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_hresult(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_boolean_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_BOOL;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_boolean(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_variant_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_VARIANT;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_variant(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_iunknown_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_UNKNOWN;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_unknown(eif_access(a_value)));
};
//-------------------------------------------------------------------


void ccom_set_safearray_decimal_reference (VARIANT * variant, EIF_OBJECT a_value)
{
	VariantClear (variant);
	V_VT(variant) = VT_ARRAY|VT_BYREF|VT_DECIMAL;
	V_ARRAYREF(variant) = (SAFEARRAY **)rt_ec.ccom_ec_pointed_c_pointer((void *)rt_ec.ccom_ec_safearray_decimal(eif_access(a_value)));
};
//-------------------------------------------------------------------


#ifdef __cplusplus
}
#endif
