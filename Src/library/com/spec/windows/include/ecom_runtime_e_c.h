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

#ifdef __cplusplus
class ecom_runtime_ec;
#endif

#include "eif_com.h"
#include <string.h>
#include <assert.h>
#include "eif_eiffel.h"
#include "E_bstr.h"
#include "E_wide_string.h"
#include "eif_except.h"
#include "ecom_rt_globals.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
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
		LPSTR ccom_ec_lpstr (EIF_REFERENCE a_ref, LPSTR old);
		LPWSTR ccom_ec_lpwstr (EIF_REFERENCE a_ref, LPWSTR old);
		VARIANT ccom_ec_variant (EIF_REFERENCE a_ref);
		IEnumVARIANT * ccom_ec_pointed_enum_variant( EIF_REFERENCE eif_ref );
		IFont * ccom_ec_pointed_ifont( EIF_REFERENCE eif_ref );

		//Pointed
		DATE * ccom_ec_pointed_date (EIF_REFERENCE a_ref, DATE * old);
		char * ccom_ec_pointed_character (EIF_REFERENCE a_ref, char * old);
		short * ccom_ec_pointed_short (EIF_REFERENCE a_ref, short * old);
		long * ccom_ec_pointed_long (EIF_REFERENCE a_ref, long * old);
		int * ccom_ec_pointed_integer (EIF_REFERENCE a_ref, int * old);
		unsigned char * ccom_ec_pointed_unsigned_character (EIF_REFERENCE a_ref, unsigned char * old);
		unsigned short * ccom_ec_pointed_unsigned_short (EIF_REFERENCE a_ref, unsigned short * old);
		unsigned long * ccom_ec_pointed_unsigned_long (EIF_REFERENCE a_ref, unsigned long * old);
		unsigned int * ccom_ec_pointed_unsigned_integer (EIF_REFERENCE a_ref, unsigned int * old);
		float * ccom_ec_pointed_real (EIF_REFERENCE a_ref, float * old);
		double * ccom_ec_pointed_double (EIF_REFERENCE a_ref, double * old);
		HRESULT * ccom_ec_pointed_hresult (EIF_REFERENCE a_ref, HRESULT *old);
		SCODE * ccom_ec_pointed_hresult (SCODE a_hresult);
		VARIANT_BOOL * ccom_ec_pointed_boolean (EIF_REFERENCE a_ref, VARIANT_BOOL * old);
		CURRENCY * ccom_ec_pointed_currency (EIF_REFERENCE a_ref, CURRENCY * old);
		VARIANT * ccom_ec_pointed_variant (EIF_REFERENCE a_ref, VARIANT * old);
		DECIMAL * ccom_ec_pointed_decimal (EIF_REFERENCE a_ref, DECIMAL * old);
		LONGLONG * ccom_ec_pointed_long_long (EIF_REFERENCE a_ref, LONGLONG * old);
		ULONGLONG * ccom_ec_pointed_ulong_long (EIF_REFERENCE a_ref, ULONGLONG * old);
		void ** ccom_ec_pointed_pointer (EIF_REFERENCE a_pointer, void ** old);
		void ** ccom_ec_pointed_c_pointer (void * a_pointer);
		IEnumVARIANT * * ccom_ec_pointed_pointed_enum_variant( EIF_REFERENCE eif_ref, IEnumVARIANT * * old );
		IFont * * ccom_ec_pointed_pointed_ifont( EIF_REFERENCE eif_ref, IFont * * old );
		IUnknown * * ccom_ec_pointed_pointed_unknown ( EIF_REFERENCE eif_ref, IUnknown * * old );
		IDispatch * * ccom_ec_pointed_pointed_dispatch ( EIF_REFERENCE eif_ref, IDispatch * * old );

		// ARRAY
		char * ccom_ec_array_character (EIF_REFERENCE a_ref, int dimension, char * old);
		long * ccom_ec_array_long (EIF_REFERENCE a_ref, int dimension, long * old);
		float * ccom_ec_array_float (EIF_REFERENCE a_ref, int dimension, float * old);
		double * ccom_ec_array_double (EIF_REFERENCE a_ref, int dimension, double * old);
		DATE * ccom_ec_array_date (EIF_REFERENCE a_ref, int dimension, DATE * old);
		short * ccom_ec_array_short (EIF_REFERENCE a_ref, int dimension, short * old);
		HRESULT * ccom_ec_array_hresult (EIF_REFERENCE a_ref, int dimension, HRESULT * old);
		CURRENCY * ccom_ec_array_currency (EIF_REFERENCE a_ref, int dimension, CURRENCY * old);
		VARIANT * ccom_ec_array_variant (EIF_REFERENCE a_ref, int dimension, VARIANT * old);
		DECIMAL * ccom_ec_array_decimal (EIF_REFERENCE a_ref, int dimension, DECIMAL * old);
		VARIANT_BOOL * ccom_ec_array_boolean (EIF_REFERENCE a_ref, int dimension, VARIANT_BOOL * old);
		LONGLONG * ccom_ec_array_long_long (EIF_REFERENCE a_ref, int dimension, LONGLONG * old);
		ULONGLONG * ccom_ec_array_ulong_long (EIF_REFERENCE a_ref, int dimension, ULONGLONG * old);
		IDispatch * ccom_ec_array_dispatch (EIF_REFERENCE a_ref, int dimension, IDispatch * old);
		IUnknown * ccom_ec_array_unknown (EIF_REFERENCE a_ref, int dimension, IUnknown * old);
		LPWSTR * ccom_ec_array_lpwstr (EIF_REFERENCE a_ref, int dimension, LPWSTR * old);
		LPSTR * ccom_ec_array_lpstr (EIF_REFERENCE a_ref, int dimension, LPSTR * old);
		BSTR * ccom_ec_array_bstr (EIF_REFERENCE a_ref, int dimension, BSTR * old);
		unsigned char * ccom_ec_array_unsigned_character (EIF_REFERENCE a_ref, int dimension, unsigned char * old);
		unsigned long * ccom_ec_array_unsigned_long (EIF_REFERENCE a_ref, int dimension, unsigned long * old);
		unsigned short * ccom_ec_array_unsigned_short (EIF_REFERENCE a_ref, int dimension, unsigned short * old);
		int * ccom_ec_array_integer (EIF_REFERENCE a_ref, int dimension, int * old);
		unsigned int * ccom_ec_array_unsigned_integer (EIF_REFERENCE a_ref, int dimension, unsigned int * old);

		// SAFEARRAY
		SAFEARRAY * ccom_ec_safearray_char (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_float (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_long (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_int64 (EIF_REFERENCE a_ref);
		SAFEARRAY * ccom_ec_safearray_uint64 (EIF_REFERENCE a_ref);
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
#endif

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_RUNTIME_EC_H_INC__
