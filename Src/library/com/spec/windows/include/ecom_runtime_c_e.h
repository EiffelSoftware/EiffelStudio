//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		ecom_runtime_c_e.h
//
//  Contents:	Runtime conversion functions from C to Eiffel
//
//--------------------------------------------------------------------------

#ifndef __ECOM_RUNTIME_CE_H_INC__
#define __ECOM_RUNTIME_CE_H_INC__

#include "eif_com.h"
#include <string.h>
#include <assert.h>
#include "eif_eiffel.h"
#include "eif_globals.h"
#include "E_bstr.h"
#include "eif_except.h"

#ifdef __cplusplus
extern "C" {
#endif

#define ccom_c_array_element(_c_array_, _index_, _type_) (*((_type_ *)_c_array_ + _index_))

typedef void (*EIF_SET_REAL_ITEM)(EIF_REFERENCE, EIF_REAL);

#ifdef __cplusplus
class ecom_runtime_ce
{
public:
	// Help functions for arrays.

	char * ccom_name_n_dim_array (char * element_name, EIF_INTEGER dim_count);
	EIF_OBJECT ccom_create_array (char * element_name, EIF_INTEGER dim_count, EIF_INTEGER * element_count);

	int ccom_flat_index (int dim_count, int * element_count, int * index);
	int ccom_next_index (int dim_count, int * element_count, int * index);

	int ccom_element_number (EIF_INTEGER dim_count, EIF_INTEGER * element_count);
	int ccom_safearray_next_index (EIF_INTEGER dim_count,
					EIF_INTEGER * lower_indices, EIF_INTEGER * upper_indices, EIF_INTEGER * index);

	// Automation types

	EIF_REFERENCE ccom_ce_date (DATE a_date);
	EIF_REFERENCE ccom_ce_bstr (BSTR a_bstr);
	EIF_REFERENCE ccom_ce_hresult (HRESULT a_hresult);
	EIF_BOOLEAN ccom_ce_boolean (VARIANT_BOOL a_bool);
	EIF_REFERENCE ccom_ce_lpstr (LPSTR a_string, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_lpwstr (LPWSTR a_wstring, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_currency (CURRENCY a_currency);
	EIF_REFERENCE ccom_ce_decimal (DECIMAL a_decimal);
	EIF_REFERENCE ccom_ce_variant (VARIANT a_variant);
	EIF_REFERENCE ccom_ce_record (void * a_record_pointer, char * a_class_name, int a_size);
	EIF_REFERENCE ccom_ce_long_long (LARGE_INTEGER  a_large_int);
	EIF_REFERENCE ccom_ce_u_long_long (ULARGE_INTEGER  a_ularge_int);

	// Pointed
	EIF_REFERENCE ccom_ce_pointed_bstr (BSTR *a_string);
	EIF_REFERENCE ccom_ce_pointed_date (DATE *a_date);
	EIF_REFERENCE ccom_ce_pointed_hresult (HRESULT * a_hresult, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_pointed_short (short * an_integer, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_pointed_long (long * an_integer, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_pointed_integer (int * an_integer, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_pointed_character (char * a_character, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_pointed_unsigned_short (unsigned short * an_integer, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_pointed_unsigned_long (unsigned long * an_integer, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_pointed_unsigned_integer (unsigned int * an_integer, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_pointed_unsigned_character (unsigned char * a_character, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_pointed_real (EIF_REAL * a_real, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_pointed_double (EIF_DOUBLE * a_double, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_pointed_boolean (VARIANT_BOOL * a_bool, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_pointed_currency (CURRENCY * a_currency);
	EIF_REFERENCE ccom_ce_pointed_decimal (DECIMAL * a_decimal);
	EIF_REFERENCE ccom_ce_pointed_variant (VARIANT * a_variant);
	EIF_REFERENCE ccom_ce_pointed_long_long (LARGE_INTEGER * a_large_int);
	EIF_REFERENCE ccom_ce_pointed_ulong_long (ULARGE_INTEGER * a_ularge_int);

	EIF_REFERENCE ccom_ce_pointed_record (void * a_record_pointer, char * a_class_name);
	EIF_REFERENCE ccom_ce_pointed_interface (void * a_interface_pointer, char * a_class_name);
	EIF_REFERENCE ccom_ce_pointed_dispatch (IDispatch * a_dispatch);
	EIF_REFERENCE ccom_ce_pointed_unknown (IUnknown * a_unknown);
	EIF_REFERENCE ccom_ce_pointed_pointer (void ** a_pointer, EIF_OBJECT an_object);

	// Safearray

	EIF_REFERENCE ccom_ce_safearray_short (SAFEARRAY * a_safearray);
	EIF_REFERENCE ccom_ce_safearray_long (SAFEARRAY * a_safearray);
	EIF_REFERENCE ccom_ce_safearray_float (SAFEARRAY * a_safearray);
	EIF_REFERENCE ccom_ce_safearray_double (SAFEARRAY * a_safearray);
	EIF_REFERENCE ccom_ce_safearray_currency (SAFEARRAY * a_safearray);
	EIF_REFERENCE ccom_ce_safearray_date (SAFEARRAY * a_safearray);
	EIF_REFERENCE ccom_ce_safearray_bstr (SAFEARRAY * a_safearray);
	EIF_REFERENCE ccom_ce_safearray_hresult (SAFEARRAY * a_safearray);
	EIF_REFERENCE ccom_ce_safearray_boolean (SAFEARRAY * a_safearray);
	EIF_REFERENCE ccom_ce_safearray_variant (SAFEARRAY * a_safearray);
	EIF_REFERENCE ccom_ce_safearray_decimal (SAFEARRAY * a_safearray);
	EIF_REFERENCE ccom_ce_safearray_char (SAFEARRAY * a_safearray);
	EIF_REFERENCE ccom_ce_safearray_record (SAFEARRAY * a_safearray);
	EIF_REFERENCE ccom_ce_safearray_dispatch (SAFEARRAY * a_safearray);
	EIF_REFERENCE ccom_ce_safearray_unknown (SAFEARRAY * a_safearray);

	// Pointed SAFEARRAY
	EIF_REFERENCE ccom_ce_pointed_safearray_short (SAFEARRAY ** a_safearray);
	EIF_REFERENCE ccom_ce_pointed_safearray_long (SAFEARRAY ** a_safearray);
	EIF_REFERENCE ccom_ce_pointed_safearray_float (SAFEARRAY ** a_safearray);
	EIF_REFERENCE ccom_ce_pointed_safearray_double (SAFEARRAY ** a_safearray);
	EIF_REFERENCE ccom_ce_pointed_safearray_currency (SAFEARRAY ** a_safearray);
	EIF_REFERENCE ccom_ce_pointed_safearray_date (SAFEARRAY ** a_safearray);
	EIF_REFERENCE ccom_ce_pointed_safearray_bstr (SAFEARRAY ** a_safearray);
	EIF_REFERENCE ccom_ce_pointed_safearray_hresult (SAFEARRAY ** a_safearray);
	EIF_REFERENCE ccom_ce_pointed_safearray_boolean (SAFEARRAY ** a_safearray);
	EIF_REFERENCE ccom_ce_pointed_safearray_variant (SAFEARRAY ** a_safearray);
	EIF_REFERENCE ccom_ce_pointed_safearray_decimal (SAFEARRAY ** a_safearray);
	EIF_REFERENCE ccom_ce_pointed_safearray_char (SAFEARRAY ** a_safearray);
	EIF_REFERENCE ccom_ce_pointed_safearray_record (SAFEARRAY ** a_safearray);
	EIF_REFERENCE ccom_ce_pointed_safearray_dispatch (SAFEARRAY ** a_safearray);
	EIF_REFERENCE ccom_ce_pointed_safearray_unknown (SAFEARRAY ** a_safearray);

	// Array

	EIF_REFERENCE ccom_ce_array_short (short * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_long (long * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_float (float * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_double (double * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_currency (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_date (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_bstr (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_hresult (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_boolean (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_variant (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_decimal (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_character (char * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_record (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_lpstr (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_lpwstr (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_long_long (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_ulong_long (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_dispatch (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_unknown (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);

	EIF_REFERENCE ccom_ce_array_unsigned_short (unsigned short * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_unsigned_long (unsigned long * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_unsigned_character (unsigned char * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_unsigned_integer (unsigned int * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);
	EIF_REFERENCE ccom_ce_array_integer (int * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object);

	// User Defined

	// Alias

	// Enum

	// Record

	// Interface
	
	EIF_REFERENCE ccom_ce_pointed_enum_variant ( IEnumVARIANT * a_interface_pointer );
	EIF_REFERENCE ccom_ce_pointed_pointed_enum_variant( IEnumVARIANT * * a_pointer, EIF_OBJECT an_object );
	EIF_REFERENCE ccom_ce_pointed_ifont( IFont * a_interface_pointer );
	EIF_REFERENCE ccom_ce_pointed_pointed_ifont(IFont * * a_pointer, EIF_OBJECT an_object);
};
#endif

#include "ecom_rt_globals.h"

#ifdef __cplusplus
}
#endif

#endif // !__ECOM_RUNTIME_CE_H_INC__
