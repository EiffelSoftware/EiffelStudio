//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		ecom_runtime_e_c.h
//
//  Contents:	Runtime conversion functions from Eiffel to C
//				
//--------------------------------------------------------------------------

#ifndef __ECOM_RUNTIME_EC_H_INC__
#define __ECOM_RUNTIME_EC_H_INC__

#include <objbase.h>
#include <oleauto.h>
#include <string.h>
#include <assert.h>
#include "eif_eiffel.h"
#include "E_bstr.h"
#include "E_wide_string.h"
#include "eif_except.h"


class ecom_runtime_ec
{
	public:
		VARIANT_BOOL ccom_ec_boolean (EIF_BOOLEAN a_bool);
		DATE ccom_ec_date (EIF_REFERENCE a_ref);
		HRESULT ccom_ec_hresult (EIF_REFERENCE a_ref);
		LARGE_INTEGER ccom_ec_long_long (EIF_REFERENCE a_ref);
		ULARGE_INTEGER ccom_ec_ulong_long (EIF_REFERENCE a_ref);
		IUnknown * ccom_ec_unknown (EIF_REFERENCE a_ref);
		IDispatch * ccom_ec_dispatch (EIF_REFERENCE a_ref);
		DECIMAL ccom_ec_decimal (EIF_REFERENCE a_ref);
		CURRENCY ccom_ec_currency (EIF_REFERENCE a_ref);
		BSTR ccom_ec_bstr (EIF_REFERENCE a_ref);
		LPSTR ccom_ec_lpstr (EIF_REFERENCE a_ref);
		LPWSTR ccom_ec_lpwstr (EIF_REFERENCE a_ref);
		VARIANT ccom_ec_variant (EIF_REFERENCE a_ref);
		
		//Pointed
		
		CURRENCY * ccom_ec_pointed_currency (EIF_REFERENCE a_ref);
		VARIANT * ccom_ec_pointed_variant (EIF_REFERENCE a_ref);
		DECIMAL * ccom_ec_pointed_decimal (EIF_REFERENCE a_ref);
		LARGE_INTEGER * ccom_ec_pointed_long_long (EIF_REFERENCE a_ref);
		ULARGE_INTEGER * ccom_ec_pointed_ulong_long (EIF_REFERENCE a_ref);
		
		// ARRAY
		DATE * ccom_ec_array_date (EIF_REFERENCE a_ref, int dimension);
		short * ccom_ec_array_short (EIF_REFERENCE a_ref, int dimension);
		HRESULT * ccom_ec_array_hresult (EIF_REFERENCE a_ref, int dimension);
		CURRENCY * ccom_ec_array_currency (EIF_REFERENCE a_ref, int dimension);
		VARIANT * ccom_ec_array_variant (EIF_REFERENCE a_ref, int dimension);
		DECIMAL * ccom_ec_array_decimal (EIF_REFERENCE a_ref, int dimension);
		VARIANT_BOOL * ccom_ec_array_boolean (EIF_REFERENCE a_ref, int dimension);
		LARGE_INTEGER * ccom_ec_array_long_long (EIF_REFERENCE a_ref, int dimension);
		ULARGE_INTEGER * ccom_ec_array_ulong_long (EIF_REFERENCE a_ref, int dimension);
		IDispatch * ccom_ec_array_dispatch (EIF_REFERENCE a_ref, int dimension);
		IUnknown * ccom_ec_array_unknown (EIF_REFERENCE a_ref, int dimension);
		LPWSTR * ccom_ec_array_lpwstr (EIF_REFERENCE a_ref, int dimension);
		LPSTR * ccom_ec_array_lpstr (EIF_REFERENCE a_ref, int dimension);
		BSTR * ccom_ec_array_bstr (EIF_REFERENCE a_ref, int dimension);
		
		// SAFEARRAY
		SAFEARRAY * ccom_ec_safearray_char (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_float (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_long (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_short (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_double (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_boolean (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_date (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_hresult (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_variant (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_currency (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_decimal (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_bstr (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_dispatch (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_unknown (EIF_REFERENCE a_ref);
};

#include "ecom_rt_globals.h"

#endif // !__ECOM_RUNTIME_EC_H_INC__
