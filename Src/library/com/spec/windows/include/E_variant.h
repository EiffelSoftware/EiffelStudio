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

class ecom_variant
{
	public:
		ecom_variant ();
		ecom_variant(VARIANT *);
		~ecom_variant();

		// `item'
		EIF_POINTER ccom_variant_item ();

		// variable type
		EIF_INTEGER ccom_variable_type ();
		void ccom_set_variable_type (VARTYPE a_value);

		// character type
		EIF_CHARACTER ccom_character ();
		EIF_REFERENCE ccom_character_reference ();
		EIF_CHARACTER ccom_unsigned_character ();
		EIF_REFERENCE ccom_unsigned_character_reference();

		void ccom_set_character_reference (EIF_OBJECT char_ref);
		void ccom_set_character (EIF_CHARACTER char_value);
		void ccom_set_unsigned_character (EIF_CHARACTER a_value);
		void ccom_set_unsigned_character_reference (EIF_OBJECT a_value);

		// short
		EIF_INTEGER ccom_integer2 ();
		EIF_REFERENCE ccom_integer2_reference ();
		EIF_INTEGER ccom_unsigned_integer2 ();
		EIF_REFERENCE ccom_unsigned_integer2_reference ();

		void ccom_set_integer2 (EIF_INTEGER a_value);
		void ccom_set_integer2_reference (EIF_OBJECT a_value);
		void ccom_set_unsigned_integer2 (EIF_INTEGER a_value);
		void ccom_set_unsigned_integer2_reference (EIF_OBJECT a_value);

		// long
		EIF_INTEGER ccom_integer4 ();
		EIF_REFERENCE ccom_integer4_reference ();
		EIF_INTEGER ccom_unsigned_integer4 ();
		EIF_REFERENCE ccom_unsigned_integer4_reference ();

 		void ccom_set_integer4 (EIF_INTEGER a_value);
		void ccom_set_integer4_reference (EIF_OBJECT a_value);
		void ccom_set_unsigned_integer4 (EIF_INTEGER a_value);
		void ccom_set_unsigned_integer4_reference (EIF_OBJECT a_value);

		// integer
		EIF_INTEGER ccom_integer ();
		EIF_REFERENCE ccom_integer_reference ();
		EIF_INTEGER ccom_unsigned_integer ();
		EIF_REFERENCE ccom_unsigned_integer_reference ();

		void ccom_set_integer (EIF_INTEGER a_value);
		void ccom_set_integer_reference (EIF_OBJECT a_value);
		void ccom_set_unsigned_integer(EIF_INTEGER a_value);
		void ccom_set_unsigned_integer_reference (EIF_OBJECT a_value);

		// float
		EIF_REAL ccom_real4 ();
		EIF_REFERENCE ccom_real4_reference ();

		void ccom_set_real4 (EIF_REAL a_value);
		void ccom_set_real4_reference (EIF_OBJECT a_value);

		// double
		EIF_DOUBLE ccom_real8 ();
		EIF_REFERENCE ccom_real8_reference ();

		void ccom_set_real8 (EIF_DOUBLE a_value);
		void ccom_set_real8_reference (EIF_OBJECT a_value);

		// boolean
		EIF_BOOLEAN ccom_bool ();
		EIF_REFERENCE ccom_bool_reference ();

		void ccom_set_bool (EIF_BOOLEAN a_value);
		void ccom_set_bool_reference (EIF_OBJECT a_value);

		// date
		EIF_REFERENCE ccom_date ();
		EIF_REFERENCE ccom_date_reference ();

		void ccom_set_date (EIF_OBJECT a_value);
		void ccom_set_date_reference (EIF_OBJECT a_value);

		// scode/HRESULT
		EIF_INTEGER ccom_error ();
		EIF_INTEGER ccom_error_reference ();

		void ccom_set_error (SCODE a_value);
		void ccom_set_error_reference (SCODE a_value);

		// decimal
		EIF_REFERENCE ccom_decimal ();
		EIF_POINTER ccom_decimal_reference ();

		void ccom_set_decimal (DECIMAL * a_value);
		void ccom_set_decimal_reference (DECIMAL *a_value);

		// currency
		EIF_REFERENCE ccom_currency ();
		EIF_POINTER ccom_currency_reference ();

		void ccom_set_currency (CY *a_value);
		void ccom_set_currency_reference (CY *a_value);

		// BSTR
		EIF_REFERENCE ccom_bstr ();
		EIF_REFERENCE ccom_bstr_reference ();

		void ccom_set_bstr (EIF_OBJECT a_value);
		void ccom_set_bstr_reference (EIF_OBJECT a_value);

		// VARIANT
		EIF_REFERENCE ccom_variant ();

		void ccom_set_variant (VARIANT *a_value);

		// IUnknown
		EIF_REFERENCE ccom_unknown_interface ();
		EIF_REFERENCE ccom_unknown_interface_reference ();

		void ccom_set_unknown_interface (IUnknown *a_value);
		void ccom_set_unknown_interface_reference (IUnknown *a_value);

		// IDispatch
		EIF_REFERENCE ccom_dispatch_interface ();
		EIF_REFERENCE ccom_dispatch_interface_reference ();

		void ccom_set_dispatch_interface (IDispatch * a_value);
		void ccom_set_dispatch_interface_reference (IDispatch *a_value);

		// safearray
		EIF_REFERENCE ccom_safearray_unsigned_integer ();
		EIF_REFERENCE ccom_safearray_integer ();
		EIF_REFERENCE ccom_safearray_unsigned_character ();
		EIF_REFERENCE ccom_safearray_character ();
		EIF_REFERENCE ccom_safearray_unsigned_short ();
		EIF_REFERENCE ccom_safearray_short ();
		EIF_REFERENCE ccom_safearray_unsigned_long ();
		EIF_REFERENCE ccom_safearray_long ();
		EIF_REFERENCE ccom_safearray_float ();
		EIF_REFERENCE ccom_safearray_double ();
		EIF_REFERENCE ccom_safearray_currency ();
		EIF_REFERENCE ccom_safearray_date ();
		EIF_REFERENCE ccom_safearray_bstr ();
		EIF_REFERENCE ccom_safearray_dispatch_interface ();
		EIF_REFERENCE ccom_safearray_hresult ();
		EIF_REFERENCE ccom_safearray_boolean ();
		EIF_REFERENCE ccom_safearray_variant ();
		EIF_REFERENCE ccom_safearray_unknown_interface ();
		EIF_REFERENCE ccom_safearray_decimal ();

		// set SAFEARRAY
		void ccom_set_safearray_unsigned_integer (EIF_OBJECT a_value);
		void ccom_set_safearray_integer (EIF_OBJECT a_value);
		void ccom_set_safearray_unsigned_character (EIF_OBJECT a_value);
		void ccom_set_safearray_character (EIF_OBJECT a_value);
		void ccom_set_safearray_unsigned_short (EIF_OBJECT a_value);
		void ccom_set_safearray_short (EIF_OBJECT a_value);
		void ccom_set_safearray_unsigned_long (EIF_OBJECT a_value);
		void ccom_set_safearray_long (EIF_OBJECT a_value);
		void ccom_set_safearray_float (EIF_OBJECT a_value);
		void ccom_set_safearray_double (EIF_OBJECT a_value);
		void ccom_set_safearray_currency (EIF_OBJECT a_value);
		void ccom_set_safearray_date (EIF_OBJECT a_value);
		void ccom_set_safearray_bstr (EIF_OBJECT a_value);
		void ccom_set_safearray_dispatch_interface (EIF_OBJECT a_value);
		void ccom_set_safearray_hresult (EIF_OBJECT a_value);
		void ccom_set_safearray_boolean (EIF_OBJECT a_value);
		void ccom_set_safearray_variant (EIF_OBJECT a_value);
		void ccom_set_safearray_unknown_interface (EIF_OBJECT a_value);
		void ccom_set_safearray_decimal (EIF_OBJECT a_value);

		// safearray reference
		EIF_REFERENCE ccom_safearray_unsigned_integer_reference ();
		EIF_REFERENCE ccom_safearray_integer_reference ();
		EIF_REFERENCE ccom_safearray_unsigned_character_reference ();
		EIF_REFERENCE ccom_safearray_character_reference ();
		EIF_REFERENCE ccom_safearray_unsigned_short_reference ();
		EIF_REFERENCE ccom_safearray_short_reference ();
		EIF_REFERENCE ccom_safearray_unsigned_long_reference ();
		EIF_REFERENCE ccom_safearray_long_reference ();
		EIF_REFERENCE ccom_safearray_float_reference ();
		EIF_REFERENCE ccom_safearray_double_reference ();
		EIF_REFERENCE ccom_safearray_currency_reference ();
		EIF_REFERENCE ccom_safearray_date_reference ();
		EIF_REFERENCE ccom_safearray_bstr_reference ();
		EIF_REFERENCE ccom_safearray_dispatch_interface_reference ();
		EIF_REFERENCE ccom_safearray_hresult_reference ();
		EIF_REFERENCE ccom_safearray_boolean_reference ();
		EIF_REFERENCE ccom_safearray_variant_reference ();
		EIF_REFERENCE ccom_safearray_unknown_interface_reference ();
		EIF_REFERENCE ccom_safearray_decimal_reference ();

		// set SAFEARRAY reference
		void ccom_set_safearray_unsigned_integer_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_integer_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_unsigned_character_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_character_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_unsigned_short_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_short_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_unsigned_long_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_long_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_float_reference(EIF_OBJECT a_value);
		void ccom_set_safearray_double_reference(EIF_OBJECT a_value);
		void ccom_set_safearray_currency_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_date_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_bstr_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_dispatch_interface_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_hresult_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_boolean_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_variant_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_unknown_interface_reference (EIF_OBJECT a_value);
		void ccom_set_safearray_decimal_reference (EIF_OBJECT a_value);

	private:
		VARIANT * variant;
};

#endif // !__ECOM_E_VARIANT_H_INC__
