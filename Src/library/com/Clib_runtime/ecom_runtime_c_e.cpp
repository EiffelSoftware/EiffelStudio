//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		ecom_runtime_c_e.c
//
//  Contents:	Runtime conversion functions from C to Eiffel
//
//--------------------------------------------------------------------------

#include "ecom_runtime_c_e.h"

ecom_runtime_ce rt_ce;

//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_currency (CURRENCY a_currency)

// Create Eiffel object ECOM_CURRENCY from C
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID eif_currency_id = -1;
	EIF_PROCEDURE make  = 0;
	EIF_POINTER an_item = 0;

	eif_currency_id = eif_type_id ("ECOM_CURRENCY");
	make = eif_procedure ("make", eif_currency_id);
	result = eif_create (eif_currency_id);
	make (eif_access (result));
	an_item = eif_field (eif_access (result), "item", EIF_POINTER);
	memcpy (an_item, &a_currency, sizeof (CURRENCY));
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_decimal (DECIMAL a_decimal)

// Create ECOM_DECIMAL from C
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID eif_decimal_id = -1;
	EIF_PROCEDURE make = 0;
	EIF_POINTER an_item = 0;

	eif_decimal_id = eif_type_id ("ECOM_DECIMAL");
	make = eif_procedure ("make", eif_decimal_id);
	result = eif_create (eif_decimal_id);
	make (eif_access (result));
	an_item = eif_field (eif_access (result), "item", EIF_POINTER);
	memcpy (an_item, &a_decimal, sizeof (DECIMAL));
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_variant (VARIANT a_variant)

// Create ECOM_VARIANT from C
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID eif_variant_id = -1;
	EIF_PROCEDURE make = 0;
	EIF_POINTER an_item = 0;

	eif_variant_id = eif_type_id ("ECOM_VARIANT");
	make = eif_procedure ("make", eif_variant_id);
	result = eif_create (eif_variant_id);
	make (eif_access (result));
	an_item = eif_field (eif_access (result), "item", EIF_POINTER);
	memcpy (an_item, &a_variant, sizeof (VARIANT));
	return eif_wean (result);
};

//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_record (void * a_record_pointer, char * a_class_name, int a_size)

// Create Eiffel object from C structure
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE make = 0;
	EIF_POINTER an_item = 0;

	type_id = eif_type_id (a_class_name);
	make = eif_procedure ("make", type_id);
	result = eif_create (type_id);
	make (eif_access (result));
	an_item = eif_field (eif_access (result), "item", EIF_POINTER);
	memcpy (an_item, &a_record_pointer, a_size);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_date (DATE a_date)

//  Create an Eiffel DATE_TIME object with 'a_date'.
{
	SYSTEMTIME a_sys_time;
	EIF_TYPE_ID date_tid = -1;
	EIF_PROCEDURE date_make = 0;
	EIF_OBJECT date_object = 0;

	date_tid = eif_type_id ("DATE_TIME");

	date_object = eif_create (date_tid);

	if ( VariantTimeToSystemTime( a_date, &a_sys_time))
	{
		date_make = eif_procedure ("make", date_tid);
		date_make (eif_access (date_object), a_sys_time.wYear,
				a_sys_time.wMonth, a_sys_time.wDay, a_sys_time.wHour,
				a_sys_time.wMinute, a_sys_time.wSecond);
	}
	else
	{
		com_eraise ("Error generating SYSTEMTIME, EiffelCOM runtime", 24);
	}
	return eif_wean (date_object);
}

//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_hresult (HRESULT a_hresult)

// Create Eiffel object ECOM_HRESULT from C HRESULT.
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE make = 0;

	type_id = eif_type_id ("ECOM_HRESULT");
	make = eif_procedure ("make_from_integer", type_id);
	result = eif_create (type_id);

	make (eif_access (result), (EIF_INTEGER) a_hresult);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_bstr (BSTR a_bstr)

// Create Eiffel STRING from Basic string
{
	return eif_wean (bstr_to_eif_obj (a_bstr));
};
//-------------------------------------------------------------------------

EIF_BOOLEAN ecom_runtime_ce::ccom_ce_boolean (VARIANT_BOOL a_bool)

// Create Eiffel BOOLEAN from COM boolean
{
	if (a_bool == 0)
	{
		return EIF_FALSE;
	}
	else
	{
		return EIF_TRUE;
	}
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_lpstr (LPSTR a_string)

// Create Eiffel STRING from LPSTR
{
	EIF_OBJECT name = 0;
	EIF_TYPE_ID eif_string_id = -1;
	EIF_PROCEDURE string_make = 0;

	if (a_string != NULL)
	{
		name = henter (RTMS (a_string));
	}
	else
	{
		eif_string_id = eif_type_id ("STRING");
		string_make = eif_procedure ("make", eif_string_id);
		name = eif_create (eif_string_id);
		string_make (eif_access (name), 0);
	}
	return eif_wean (name);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_lpwstr (LPWSTR a_string)

// Create Eiffel String from LPWSTR
{
	EIF_OBJECT local_obj = 0;
	char * string = 0;
	size_t size = 0, size_wide = 0;

	size_wide = wcslen(a_string);
	size = wcstombs (NULL, a_string, size_wide + 1);
	string = (char *)malloc(size + 1);

	wcstombs (string, a_string, size_wide + 1);
	local_obj = henter(RTMS(string));
	free (string);
	return eif_wean (local_obj);
};
//----------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_variant (VARIANT * a_variant)

// Create Eiffel ECOM_VARIANT from C
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID eif_variant_id = -1;
	EIF_PROCEDURE make = 0;

	eif_variant_id = eif_type_id ("ECOM_VARIANT");
	make = eif_procedure ("make_from_pointer", eif_variant_id);
	result = eif_create (eif_variant_id);
	make (eif_access (result), (EIF_POINTER)a_variant);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_unknown (IUnknown * a_unknown)

// Create Eiffel ECOM_UNKNOWN_INTERFACE from C
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID eif_id = -1;
	EIF_PROCEDURE make = 0;

	eif_id = eif_type_id ("ECOM_UNKNOWN_INTERFACE");
	make = eif_procedure ("make_from_pointer", eif_id);
	result = eif_create (eif_id);
	make (eif_access (result), (EIF_POINTER)a_unknown);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_dispatch (IDispatch * a_dispatch)

// Create Eiffel ECOM_AUTOMATION_INTERFACE from C
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID eif_id = -1;
	EIF_PROCEDURE make = 0;

	eif_id = eif_type_id ("ECOM_AUTOMATION_INTERFACE");
	make = eif_procedure ("make_from_pointer", eif_id);
	result = eif_create (eif_id);
	make (eif_access (result), (EIF_POINTER)a_dispatch);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_short (short * an_integer, EIF_OBJECT an_object)

// Create INTEGER_REF from integer
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;

	type_id = eif_type_id ("INTEGER_REF");
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		result = eif_create (type_id);
	else
		result = an_object;

	set_item = eif_procedure ("set_item", type_id);
	set_item (eif_access (result), (EIF_INTEGER)*an_integer);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};

//-------------------------------------------------------------------------
EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_hresult (HRESULT * a_hresult, EIF_OBJECT an_object)

// Create ECOM_HRESULT from HRESULT *
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;

	type_id = eif_type_id ("ECOM_HRESULT");
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		result = eif_create (type_id);
	else
		result = an_object;

	set_item = eif_procedure ("set_item", type_id);
	set_item (eif_access (result), (EIF_INTEGER)*a_hresult);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};

//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_long (long * an_integer, EIF_OBJECT an_object)

// Create INTEGER_REF from integer
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;

	type_id = eif_type_id ("INTEGER_REF");
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		result = eif_create (type_id);
	else
		result = an_object;

	set_item = eif_procedure ("set_item", type_id);
	set_item (eif_access (result), (EIF_INTEGER)*an_integer);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};

//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_integer (int * an_integer, EIF_OBJECT an_object)

// Create INTEGER_REF from integer
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item;

	type_id = eif_type_id ("INTEGER_REF");
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		result = eif_create (type_id);
	else
		result = an_object;

	set_item = eif_procedure ("set_item", type_id);
	set_item (eif_access (result), (EIF_INTEGER)*an_integer);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_real (EIF_REAL * a_real, EIF_OBJECT an_object)

// Create REAL_REF from real
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID type_id = -1;
	EIF_SET_REAL_ITEM set_item = 0;

	type_id = eif_type_id ("REAL_REF");
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		result = eif_create (type_id);
	else
		result = an_object;

	set_item = (EIF_SET_REAL_ITEM)eif_procedure ("set_item", type_id);

	set_item (eif_access (result), *a_real);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_double (EIF_DOUBLE * a_double, EIF_OBJECT an_object)

// Create DOUBLE_REF from double
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;

	type_id = eif_type_id ("DOUBLE_REF");
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		result = eif_create (type_id);
	else
		result = an_object;

	set_item = eif_procedure ("set_item", type_id);
	set_item (eif_access (result), *a_double);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_character (char * a_character, EIF_OBJECT an_object)

// Create CHARACTER_REF from character
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID type_id= -1;
	EIF_PROCEDURE set_item = 0;

	type_id = eif_type_id ("CHARACTER_REF");
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		result = eif_create (type_id);
	else
		result = an_object;

	set_item = eif_procedure ("set_item", type_id);
	set_item (eif_access (result), (EIF_INTEGER)*a_character);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_boolean (VARIANT_BOOL * a_bool, EIF_OBJECT an_object)

// Create BOOLEAN_REF from pointer to VARIANT_BOOL
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;

	type_id = eif_type_id ("BOOLEAN_REF");
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		result = eif_create (type_id);
	else
		result = an_object;

	set_item = eif_procedure ("set_item", type_id);
	set_item (eif_access (result), ccom_ce_boolean (*a_bool));

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_currency (CURRENCY * a_currency)

// Create Eiffel object ECOM_CURRENCY from C
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID eif_currency_id = -1;
	EIF_PROCEDURE currency_make = 0;

	eif_currency_id = eif_type_id ("ECOM_CURRENCY");
	currency_make = eif_procedure ("make_by_pointer", eif_currency_id);
	result = eif_create (eif_currency_id);
	currency_make (eif_access (result), (EIF_POINTER)a_currency);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_decimal (DECIMAL * a_decimal)

// Create ECOM_DECIMAL from C
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID eif_decimal_id = -1;
	EIF_PROCEDURE make = 0;

	eif_decimal_id = eif_type_id ("ECOM_DECIMAL");
	make = eif_procedure ("make_by_pointer", eif_decimal_id);
	result = eif_create (eif_decimal_id);
	make (eif_access (result), (EIF_POINTER)a_decimal);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_record (void * a_record_pointer, char * a_class_name)

// Create Eiffel object from C structure
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE make = 0;

	type_id = eif_type_id (a_class_name);
	make = eif_procedure ("make_by_pointer", type_id);
	result = eif_create (type_id);
	make (eif_access (result), (EIF_POINTER)a_record_pointer);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_interface (void * a_interface_pointer, char * a_class_name)

// Create Eiffel object from COM interface.
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE make = 0;

	type_id = eif_type_id (a_class_name);
	make = eif_procedure ("make_from_pointer", type_id);
	result = eif_create (type_id);
	make (eif_access (result), (EIF_POINTER)a_interface_pointer);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_long_long (LARGE_INTEGER * a_large_integer)

// Create Eiffel object ECOM_LARGE_INTEGER
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID eif_large_integer_id = -1;
	EIF_PROCEDURE large_integer_make = 0;

	eif_large_integer_id = eif_type_id ("ECOM_LARGE_INTEGER");
	large_integer_make = eif_procedure ("make_by_pointer", eif_large_integer_id);
	result = eif_create (eif_large_integer_id);
	large_integer_make (eif_access (result), (EIF_POINTER)a_large_integer);
	return eif_wean (result);
};
//----------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_ulong_long (ULARGE_INTEGER * an_ularge_integer)

// Create Eiffel object ECOM_ULARGE_INTEGER
{
	EIF_OBJECT result = 0;
	EIF_TYPE_ID eif_ularge_integer_id = -1;
	EIF_PROCEDURE ularge_integer_make = 0;

	eif_ularge_integer_id = eif_type_id ("ECOM_ULARGE_INTEGER");
	ularge_integer_make = eif_procedure ("make_by_pointer", eif_ularge_integer_id);
	result = eif_create (eif_ularge_integer_id);
	ularge_integer_make (eif_access (result), (EIF_POINTER)an_ularge_integer);
	return eif_wean (result);
};
//----------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_short
		(short * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of short.
{
	int i = 0, element_number = 0;
	EIF_INTEGER * c_array = 0;
	EIF_OBJECT result = 0;

	// Conver array of short into array of EIF_INTEGER
	element_number = ccom_element_number (dim_count, element_count);
	c_array = (EIF_INTEGER *)calloc (element_number, sizeof (EIF_INTEGER));

	for (i = 0; i < element_number; i++)
	{
		c_array[i] = (EIF_INTEGER)an_array[i];
	}

	// Create Eiffel array and initialize it to C array.
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		result = ccom_create_array ("INTEGER", dim_count, element_count);
	else
		result = an_object;

	eif_make_from_c (eif_access (result), c_array, (EIF_INTEGER)element_number, EIF_INTEGER);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_long
		(long * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of long.
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0;

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		result = ccom_create_array ("INTEGER", dim_count, element_count);
	else
		result = an_object;

	eif_make_from_c (eif_access (result), an_array, element_number, EIF_INTEGER);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_float
		(float * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of float.
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0;

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		result = ccom_create_array ("REAL", dim_count, element_count);
	else
		result = an_object;

	eif_make_from_c (eif_access (result), an_array, element_number, EIF_REAL);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_double
		(double * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of double.
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0;

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		result = ccom_create_array ("DOUBLE", dim_count, element_count);
	else
		result = an_object;

	eif_make_from_c (eif_access (result), an_array, element_number, EIF_DOUBLE);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_character
		(char * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of char.
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0;

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		result = ccom_create_array ("CHARACTER", dim_count, element_count);
	else
		result = an_object;
	eif_make_from_c (eif_access (result), an_array, element_number, EIF_CHARACTER);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_currency
		(EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of CURRENCY.
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indeces = 0, eif_element_count = 0;

	EIF_TYPE_ID type_id = -1, int_array_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	int i = 0;
	EIF_INTEGER * lower_indeces = 0;
	CURRENCY * an_array_element = 0;

	type_id = eif_type_id ("ARRAY [ECOM_CURRENCY]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		intermediate_array = eif_create (type_id);
		make (eif_access (intermediate_array), 1, element_number);
	}
	else
		intermediate_array = an_object;

	EIF_OBJECT eif_object_buf;

	for (i = 0; i < element_number; i++)
	{
		an_array_element = (CURRENCY *)&((ccom_c_array_element (an_array, i,CURRENCY)));
		eif_object_buf = eif_protect (ccom_ce_pointed_currency (an_array_element));

		put (eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
		eif_wean (eif_object_buf);
	}

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		if ( dim_count == 1)
		{
			result = intermediate_array;
		}
		else
		{
			// Create array of lower indeces
			int_array_id = eif_type_id ("ARRAY [INTEGER]");
			make = eif_procedure ("make", int_array_id);
			eif_lower_indeces = eif_create (int_array_id);
			make (eif_access (eif_lower_indeces), 1, dim_count);

			lower_indeces = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
			for ( i = 0; i < dim_count; i++)
				lower_indeces [i] = 1;

			eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);
			free (lower_indeces);

			// Create array of element counts
			eif_element_count = eif_create (int_array_id);
			make (eif_access (eif_element_count), 1, dim_count);

			eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

			// Create ECOM_ARRAY [ECOM_CURRENCY]
			type_id = eif_type_id ("ECOM_ARRAY [ECOM_CURRENCY]");
			make = eif_procedure ("make_from_array", type_id);

				result = eif_create (type_id);
			make (eif_access (result), eif_access (intermediate_array),
					dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
			eif_wean (intermediate_array);
		}
		return eif_wean (result);
	}
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_bstr
		(EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of BSTR.
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indeces = 0, eif_element_count = 0;

	EIF_TYPE_ID type_id = -1, int_array_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	int i = 0;
	EIF_INTEGER * lower_indeces = 0;
	BSTR an_array_element;

	type_id = eif_type_id ("ARRAY [STRING]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		intermediate_array = eif_create (type_id);
		make (eif_access (intermediate_array), 1, element_number);
	}
	else
		intermediate_array = an_object;

	EIF_OBJECT eif_object_buf;

	for (i = 0; i < element_number; i++)
	{
		an_array_element = (BSTR )((ccom_c_array_element (an_array, i, BSTR)));

		eif_object_buf = eif_protect (ccom_ce_bstr ((BSTR)an_array_element));
		put (eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
		eif_wean (eif_object_buf);
	}

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		if ( dim_count == 1)
		{
			result = intermediate_array;
		}
		else
		{
			// Create array of lower indeces
			int_array_id = eif_type_id ("ARRAY [INTEGER]");
			make = eif_procedure ("make", int_array_id);
			eif_lower_indeces = eif_create (int_array_id);
			make (eif_access (eif_lower_indeces), 1, dim_count);

			lower_indeces = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
			for ( i = 0; i < dim_count; i++)
				lower_indeces [i] = 1;

			eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);
			free (lower_indeces);

			// Create array of element counts
			eif_element_count = eif_create (int_array_id);
			make (eif_access (eif_element_count), 1, dim_count);

			eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

			// Create ECOM_ARRAY [STRING]
			type_id = eif_type_id ("ECOM_ARRAY [STRING]");
			make = eif_procedure ("make_from_array", type_id);

			result = eif_create (type_id);
			make (eif_access (result), eif_access (intermediate_array),
					dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
			eif_wean (intermediate_array);
		}
		return eif_wean (result);
	}
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_decimal
		(EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of DECIMAL.
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indeces = 0, eif_element_count = 0;

	EIF_TYPE_ID type_id = -1, int_array_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	int i = 0;
	EIF_INTEGER * lower_indeces = 0;
	DECIMAL * an_array_element = 0;

	type_id = eif_type_id ("ARRAY [ECOM_DECIMAL]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

	if (((an_object == NULL) || (eif_access (an_object) == NULL)))
	{
		intermediate_array = eif_create (type_id);
		make (eif_access (intermediate_array), 1, element_number);
	}
	else
		intermediate_array = an_object;


	EIF_OBJECT eif_object_buf;

	for (i = 0; i < element_number; i++)
	{
		an_array_element = (DECIMAL *)&((ccom_c_array_element (an_array, i, DECIMAL)));
		eif_object_buf = eif_protect (ccom_ce_pointed_decimal (an_array_element));
		put (eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
		eif_wean (eif_object_buf);
	}

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		if ( dim_count == 1)
		{
			result = intermediate_array;
		}
		else
		{
			// Create array of lower indeces
			int_array_id = eif_type_id ("ARRAY [INTEGER]");
			make = eif_procedure ("make", int_array_id);
			eif_lower_indeces = eif_create (int_array_id);
			make (eif_access (eif_lower_indeces), 1, dim_count);

			lower_indeces = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
			for ( i = 0; i < dim_count; i++)
				lower_indeces [i] = 1;

			eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);
			free (lower_indeces);

			// Create array of element counts
			eif_element_count = eif_create (int_array_id);
			make (eif_access (eif_element_count), 1, dim_count);

			eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

			// Create ECOM_ARRAY [ECOM_DECIMAL]
			type_id = eif_type_id ("ECOM_ARRAY [ECOM_DECIMAL]");
			make = eif_procedure ("make_from_array", type_id);

			result = eif_create (type_id);
			make (eif_access (result), eif_access (intermediate_array),
					dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
			eif_wean (intermediate_array);
		}
		return eif_wean (result);
	}
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_boolean
		(EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of VARIANT_BOOL.
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indeces = 0, eif_element_count = 0;

	EIF_TYPE_ID type_id = -1, int_array_id= -1;
	EIF_PROCEDURE make = 0, put = 0;
	int i = 0;
	EIF_INTEGER * lower_indeces = 0;
	VARIANT_BOOL * an_array_element = 0;

	type_id = eif_type_id ("ARRAY [BOOLEAN]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		intermediate_array = eif_create (type_id);
		make (eif_access (intermediate_array), 1, element_number);
	}
	else
		intermediate_array = an_object;

	for (i = 0; i < element_number; i++)
	{
		an_array_element = (VARIANT_BOOL *)&((ccom_c_array_element (an_array, i, VARIANT_BOOL)));
		put (eif_access (intermediate_array), ccom_ce_boolean ((VARIANT_BOOL)*an_array_element), i + 1);
	}

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		if ( dim_count == 1)
		{
			result = intermediate_array;
		}
		else
		{
			// Create array of lower indeces
			int_array_id = eif_type_id ("ARRAY [INTEGER]");
			make = eif_procedure ("make", int_array_id);
			eif_lower_indeces = eif_create (int_array_id);
			make (eif_access (eif_lower_indeces), 1, dim_count);

			lower_indeces = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
			for ( i = 0; i < dim_count; i++)
				lower_indeces [i] = 1;

			eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);
			free (lower_indeces);

			// Create array of element counts
			eif_element_count = eif_create (int_array_id);
			make (eif_access (eif_element_count), 1, dim_count);

			eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

			// Create ECOM_ARRAY [BOOLEAN]
			type_id = eif_type_id ("ECOM_ARRAY [BOOLEAN]");
			make = eif_procedure ("make_from_array", type_id);

			result = eif_create (type_id);
			make (eif_access (result), eif_access (intermediate_array),
					dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
			eif_wean (intermediate_array);
		}
		return eif_wean (result);
	}
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_date
		(EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of DATE.
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indeces = 0, eif_element_count = 0;

	EIF_TYPE_ID type_id = -1, int_array_id= -1;
	EIF_PROCEDURE make = 0, put = 0;
	int i = 0;
	EIF_INTEGER * lower_indeces = 0;
	DATE * an_array_element = 0;

	type_id = eif_type_id ("ARRAY [DATE_TIME]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		intermediate_array = eif_create (type_id);
		make (eif_access (intermediate_array), 1, element_number);
	}
	else
		intermediate_array = an_object;

	EIF_OBJECT eif_object_buf;

	for (i = 0; i < element_number; i++)
	{
		an_array_element = (DATE *)&((ccom_c_array_element (an_array, i, DATE)));
		eif_object_buf = eif_protect (ccom_ce_date ((DATE)*an_array_element));
		put (eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
		eif_wean (eif_object_buf);
	}

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		if ( dim_count == 1)
		{
			result = intermediate_array;
		}
		else
		{
			// Create array of lower indeces
			int_array_id = eif_type_id ("ARRAY [INTEGER]");
			make = eif_procedure ("make", int_array_id);
			eif_lower_indeces = eif_create (int_array_id);
			make (eif_access (eif_lower_indeces), 1, dim_count);

			lower_indeces = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
			for ( i = 0; i < dim_count; i++)
				lower_indeces [i] = 1;

			eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);
			free (lower_indeces);

			// Create array of element counts
			eif_element_count = eif_create (int_array_id);
			make (eif_access (eif_element_count), 1, dim_count);

			eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

			// Create ECOM_ARRAY [DATE_TIME]
			type_id = eif_type_id ("ECOM_ARRAY [DATE_TIME]");
			make = eif_procedure ("make_from_array", type_id);

			result = eif_create (type_id);
			make (eif_access (result), eif_access (intermediate_array),
					dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
			eif_wean (intermediate_array);
		}
		return eif_wean (result);
	}
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_variant
		(EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of VARIANT.
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indeces = 0, eif_element_count = 0;

	EIF_TYPE_ID type_id = -1, int_array_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	int i = 0;
	EIF_INTEGER * lower_indeces = 0;
	VARIANT * an_array_element = 0;

	type_id = eif_type_id ("ARRAY [ECOM_VARIANT]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		intermediate_array = eif_create (type_id);
		make (eif_access (intermediate_array), 1, element_number);
	}
	else
		intermediate_array = an_object;

	EIF_OBJECT eif_object_buf;

	for (i = 0; i < element_number; i++)
	{
		an_array_element = (VARIANT *)&(ccom_c_array_element (an_array, i, VARIANT));
		eif_object_buf = eif_protect (ccom_ce_pointed_variant ((VARIANT *)an_array_element));
		put (eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
		eif_wean (eif_object_buf);
	}

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		if ( dim_count == 1)
		{
			result = intermediate_array;
		}
		else
		{
			// Create array of lower indeces
			int_array_id = eif_type_id ("ARRAY [INTEGER]");
			make = eif_procedure ("make", int_array_id);
			eif_lower_indeces = eif_create (int_array_id);
			make (eif_access (eif_lower_indeces), 1, dim_count);

			lower_indeces = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
			for ( i = 0; i < dim_count; i++)
				lower_indeces [i] = 1;

			eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);
			free (lower_indeces);

			// Create array of element counts
			eif_element_count = eif_create (int_array_id);
			make (eif_access (eif_element_count), 1, dim_count);

			eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

			// Create ECOM_ARRAY [ECOM_VARIANT]
			type_id = eif_type_id ("ECOM_ARRAY [ECOM_VARIANT]");
			make = eif_procedure ("make_from_array", type_id);

			result = eif_create (type_id);
			make (eif_access (result), eif_access (intermediate_array),
					dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
			eif_wean (intermediate_array);
		}
		return eif_wean (result);
	}
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_hresult
		(EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of HRESULT.
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indeces = 0, eif_element_count = 0;

	EIF_TYPE_ID type_id = -1, int_array_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	int i = 0;
	EIF_INTEGER * lower_indeces = 0;
	HRESULT * an_array_element = 0;

	type_id = eif_type_id ("ARRAY [ECOM_HRESULT]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		intermediate_array = eif_create (type_id);
		make (eif_access (intermediate_array), 1, element_number);
	}
	else
		intermediate_array = an_object;

	EIF_OBJECT eif_object_buf;

	for (i = 0; i < element_number; i++)
	{
		an_array_element = (HRESULT *)&((ccom_c_array_element (an_array, i, HRESULT)));
		eif_object_buf = eif_protect (ccom_ce_hresult ((HRESULT)*an_array_element));
		put (eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
		eif_wean (eif_object_buf);
	}

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		if ( dim_count == 1)
		{
			result = intermediate_array;
		}
		else
		{
			// Create array of lower indeces
			int_array_id = eif_type_id ("ARRAY [INTEGER]");
			make = eif_procedure ("make", int_array_id);
			eif_lower_indeces = eif_create (int_array_id);
			make (eif_access (eif_lower_indeces), 1, dim_count);

			lower_indeces = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
			for ( i = 0; i < dim_count; i++)
				lower_indeces [i] = 1;

			eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);
			free (lower_indeces);

			// Create array of element counts
			eif_element_count = eif_create (int_array_id);
			make (eif_access (eif_element_count), 1, dim_count);

			eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

			// Create ECOM_ARRAY [ECOM_HRESULT]
			type_id = eif_type_id ("ECOM_ARRAY [ECOM_HRESULT]");
			make = eif_procedure ("make_from_array", type_id);

			result = eif_create (type_id);
			make (eif_access (result), eif_access (intermediate_array),
					dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
			eif_wean (intermediate_array);
		}
		return eif_wean (result);
	}
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_lpstr
		(EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel Array from C array of LPSTR
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indeces = 0, eif_element_count = 0;

	EIF_TYPE_ID type_id = -1, int_array_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	int i = 0;
	EIF_INTEGER * lower_indeces = 0;
	LPSTR an_array_element = 0;

	type_id = eif_type_id ("ARRAY [STRING]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		intermediate_array = eif_create (type_id);
		make (eif_access (intermediate_array), 1, element_number);
	}
	else
		intermediate_array = an_object;

	EIF_OBJECT eif_object_buf;

	for (i = 0; i < element_number; i++)
	{
		an_array_element = (LPSTR )((ccom_c_array_element (an_array, i, LPSTR)));
		eif_object_buf = eif_protect (ccom_ce_lpstr ((LPSTR)an_array_element));
		put (eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
		eif_wean (eif_object_buf);
	}

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		if ( dim_count == 1)
		{
			result = intermediate_array;
		}
		else
		{
			// Create array of lower indeces
			int_array_id = eif_type_id ("ARRAY [INTEGER]");
			make = eif_procedure ("make", int_array_id);
			eif_lower_indeces = eif_create (int_array_id);
			make (eif_access (eif_lower_indeces), 1, dim_count);

			lower_indeces = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
			for ( i = 0; i < dim_count; i++)
				lower_indeces [i] = 1;

			eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);
			free (lower_indeces);

			// Create array of element counts
			eif_element_count = eif_create (int_array_id);
			make (eif_access (eif_element_count), 1, dim_count);

			eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

			// Create ECOM_ARRAY [STRING]
			type_id = eif_type_id ("ECOM_ARRAY [STRING]");
			make = eif_procedure ("make_from_array", type_id);

			result = eif_create (type_id);
			make (eif_access (result), eif_access (intermediate_array),
					dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
			eif_wean (intermediate_array);
		}
		return eif_wean (result);
	}
	else
		return NULL;
};
//----------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_lpwstr
		(EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel Array from C array of LPWSTR
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indeces = 0, eif_element_count = 0;

	EIF_TYPE_ID type_id = -1, int_array_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	int i = 0;
	EIF_INTEGER * lower_indeces = 0;
	LPWSTR an_array_element = 0;

	type_id = eif_type_id ("ARRAY [STRING]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		intermediate_array = eif_create (type_id);
		make (eif_access (intermediate_array), 1, element_number);
	}
	else
		intermediate_array = an_object;

	EIF_OBJECT tmp_object;

	for (i = 0; i < element_number; i++)
	{
		an_array_element = (LPWSTR)((ccom_c_array_element (an_array, i, LPWSTR)));
		tmp_object = eif_protect (ccom_ce_lpwstr ((LPWSTR)an_array_element));
		put (eif_access (intermediate_array), eif_access(tmp_object), i + 1);
		eif_wean (tmp_object);
	}


	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		if ( dim_count == 1)
		{
			result = intermediate_array;
		}
		else
		{
			// Create array of lower indeces
			int_array_id = eif_type_id ("ARRAY [INTEGER]");
			make = eif_procedure ("make", int_array_id);
			eif_lower_indeces = eif_create (int_array_id);
			make (eif_access (eif_lower_indeces), 1, dim_count);

			lower_indeces = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
			for ( i = 0; i < dim_count; i++)
				lower_indeces [i] = 1;

			eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);
			free (lower_indeces);

			// Create array of element counts
			eif_element_count = eif_create (int_array_id);
			make (eif_access (eif_element_count), 1, dim_count);

			eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

			// Create ECOM_ARRAY [STRING]
			type_id = eif_type_id ("ECOM_ARRAY [STRING]");
			make = eif_procedure ("make_from_array", type_id);

			result = eif_create (type_id);
			make (eif_access (result), eif_access (intermediate_array),
					dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
			eif_wean (intermediate_array);
		}
		return eif_wean (result);
	}
	else
		return NULL;
};
//----------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_long_long
		(EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel Array from C array of LARGE_INTEGER
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indeces = 0, eif_element_count = 0;

	EIF_TYPE_ID type_id = -1, int_array_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	int i = 0;
	EIF_INTEGER * lower_indeces = 0;
	LARGE_INTEGER * an_array_element = 0;

	type_id = eif_type_id ("ARRAY [ECOM_LARGE_INTEGER]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		intermediate_array = eif_create (type_id);
		make (eif_access (intermediate_array), 1, element_number);
	}
	else
		intermediate_array = an_object;

	EIF_OBJECT tmp_object;

	for (i = 0; i < element_number; i++)
	{
		an_array_element = (LARGE_INTEGER *)&((ccom_c_array_element (an_array, i, LARGE_INTEGER)));
		tmp_object = eif_protect (ccom_ce_pointed_long_long (an_array_element));
		put (eif_access (intermediate_array), eif_access (tmp_object), i + 1);
		eif_wean (tmp_object);
	}

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		if ( dim_count == 1)
		{
			result = intermediate_array;
		}
		else
		{
			// Create array of lower indeces
			int_array_id = eif_type_id ("ARRAY [INTEGER]");
			make = eif_procedure ("make", int_array_id);
			eif_lower_indeces = eif_create (int_array_id);
			make (eif_access (eif_lower_indeces), 1, dim_count);

			lower_indeces = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
			for ( i = 0; i < dim_count; i++)
				lower_indeces [i] = 1;

			eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);
			free (lower_indeces);

			// Create array of element counts
			eif_element_count = eif_create (int_array_id);
			make (eif_access (eif_element_count), 1, dim_count);

			eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

			// Create ECOM_ARRAY [ECOM_LARGE_INTEGER]
			type_id = eif_type_id ("ECOM_ARRAY [ECOM_LARGE_INTEGER]");
			make = eif_procedure ("make_from_array", type_id);

			result = eif_create (type_id);
			make (eif_access (result), eif_access (intermediate_array),
					dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
			eif_wean (intermediate_array);
		}
		return eif_wean (result);
	}
	else
		return NULL;
};
//----------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_ulong_long
		(EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel Array from C array of ULARGE_INTEGER
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indeces = 0, eif_element_count = 0;

	EIF_TYPE_ID type_id = -1, int_array_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	int i = 0;
	EIF_INTEGER * lower_indeces = 0;
	ULARGE_INTEGER * an_array_element = 0;

	type_id = eif_type_id ("ARRAY [ECOM_ULARGE_INTEGER]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		intermediate_array = eif_create (type_id);
		make (eif_access (intermediate_array), 1, element_number);
	}
	else
		intermediate_array = an_object;

	EIF_OBJECT tmp_object;

	for (i = 0; i < element_number; i++)
	{
		an_array_element = (ULARGE_INTEGER *)&((ccom_c_array_element (an_array, i, ULARGE_INTEGER)));
		tmp_object = eif_protect (ccom_ce_pointed_ulong_long (an_array_element));
		put (eif_access (intermediate_array), eif_access (tmp_object), i + 1);
	}

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		if ( dim_count == 1)
		{
			result = intermediate_array;
		}
		else
		{
			// Create array of lower indeces
			int_array_id = eif_type_id ("ARRAY [INTEGER]");
			make = eif_procedure ("make", int_array_id);
			eif_lower_indeces = eif_create (int_array_id);
			make (eif_access (eif_lower_indeces), 1, dim_count);

			lower_indeces = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
			for ( i = 0; i < dim_count; i++)
				lower_indeces [i] = 1;

			eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);
			free (lower_indeces);

			// Create array of element counts
			eif_element_count = eif_create (int_array_id);
			make (eif_access (eif_element_count), 1, dim_count);

			eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

			// Create ECOM_ARRAY [ECOM_ULARGE_INTEGER]
			type_id = eif_type_id ("ECOM_ARRAY [ECOM_ULARGE_INTEGER]");
			make = eif_procedure ("make_from_array", type_id);

			result = eif_create (type_id);
			make (eif_access (result), eif_access (intermediate_array),
					dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
			eif_wean (intermediate_array);
		}
		return eif_wean (result);
	}
	else
		return NULL;
};
//----------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_unknown
		(EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of IUnknown *.
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indeces = 0, eif_element_count = 0;

	EIF_TYPE_ID type_id = -1, int_array_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	int i = 0;
	EIF_INTEGER * lower_indeces = 0;
	IUnknown * an_array_element = 0;

	type_id = eif_type_id ("ARRAY [ECOM_UNKNOWN_INTERFACE]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		intermediate_array = eif_create (type_id);
		make (eif_access (intermediate_array), 1, element_number);
	}
	else
		intermediate_array = an_object;

	EIF_OBJECT eif_object_buf;

	for (i = 0; i < element_number; i++)
	{
		an_array_element = (IUnknown *)&((ccom_c_array_element (an_array, i, IUnknown *)));
		eif_object_buf = eif_protect (ccom_ce_pointed_unknown ((IUnknown *)an_array_element));
		put (eif_access (intermediate_array), eif_access (eif_object_buf) , i + 1);
		eif_wean (eif_object_buf);
	}

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		if ( dim_count == 1)
		{
			result = intermediate_array;
		}
		else
		{
			// Create array of lower indeces
			int_array_id = eif_type_id ("ARRAY [INTEGER]");
			make = eif_procedure ("make", int_array_id);
			eif_lower_indeces = eif_create (int_array_id);
			make (eif_access (eif_lower_indeces), 1, dim_count);

			lower_indeces = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
			for ( i = 0; i < dim_count; i++)
				lower_indeces [i] = 1;

			eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);
			free (lower_indeces);

			// Create array of element counts
			eif_element_count = eif_create (int_array_id);
			make (eif_access (eif_element_count), 1, dim_count);

			eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

			// Create ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE]
			type_id = eif_type_id ("ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE]");
			make = eif_procedure ("make_from_array", type_id);

			result = eif_create (type_id);
			make (eif_access (result), eif_access (intermediate_array),
					dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
			eif_wean (intermediate_array);
		}
		return eif_wean (result);
	}
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_dispatch
		(EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of IDispatch *.
{
	EIF_INTEGER element_number = 0;
	EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indeces = 0, eif_element_count = 0;

	EIF_TYPE_ID type_id = -1, int_array_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	int i = 0;
	EIF_INTEGER * lower_indeces = 0;
	IDispatch * an_array_element = 0;

	type_id = eif_type_id ("ARRAY [ECOM_AUTOMATION_INTERFACE]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);

	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		intermediate_array = eif_create (type_id);
		make (eif_access (intermediate_array), 1, element_number);
	}

	EIF_OBJECT eif_object_buf;

	for (i = 0; i < element_number; i++)
	{
		an_array_element = (IDispatch *)&((ccom_c_array_element (an_array, i, IDispatch *)));
		eif_object_buf = eif_protect (ccom_ce_pointed_unknown ((IDispatch *)an_array_element));
		put (eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
		eif_wean (eif_object_buf);
	}

	if ((an_object == NULL) || (eif_access (an_object) == NULL))
	{
		if ( dim_count == 1)
		{
			result = intermediate_array;
		}
		else
		{
			// Create array of lower indeces
			int_array_id = eif_type_id ("ARRAY [INTEGER]");
			make = eif_procedure ("make", int_array_id);
			eif_lower_indeces = eif_create (int_array_id);
			make (eif_access (eif_lower_indeces), 1, dim_count);

			lower_indeces = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
			for ( i = 0; i < dim_count; i++)
				lower_indeces [i] = 1;

			eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);
			free (lower_indeces);

			// Create array of element counts
			eif_element_count = eif_create (int_array_id);
			make (eif_access (eif_element_count), 1, dim_count);

			eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

			// Create ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE]
			type_id = eif_type_id ("ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE]");
			make = eif_procedure ("make_from_array", type_id);

			result = eif_create (type_id);
			make (eif_access (result), eif_access (intermediate_array),
					dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
			eif_wean (intermediate_array);
		}
		return eif_wean (result);
	}
	else
		return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_short (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of short
{
	EIF_INTEGER dim_count = 0;
	EIF_INTEGER * lower_indeces = 0;
	EIF_INTEGER * upper_indeces = 0;
	EIF_INTEGER * element_counts = 0;
	EIF_INTEGER * index = 0;
	long * sa_indeces = 0;
	int i = 0;
	long tmp_long = 0;
	HRESULT hr = 0;
	EIF_OBJECT result = 0, eif_lower_indeces = 0, eif_element_counts = 0, eif_index = 0;
	EIF_TYPE_ID int_array_id = -1, type_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	short sa_element = 0;

	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));

	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
		{
			upper_indeces[i] = (EIF_INTEGER)tmp_long;
			element_counts[i] = upper_indeces[i] - lower_indeces[i] + 1;
		}
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
	}

	// Create array of lower indeces
	int_array_id = eif_type_id ("ARRAY [INTEGER]");
	make = eif_procedure ("make", int_array_id);
	eif_lower_indeces = eif_create (int_array_id);
	make (eif_access (eif_lower_indeces), 1, dim_count);

	eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);

	// Create array of element counts
	eif_element_counts = eif_create (int_array_id);
	make (eif_access (eif_element_counts), 1, dim_count);

	eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

	// Create array of indeces
	eif_index = eif_create (int_array_id);
	make (eif_access (eif_index), 1, dim_count);

	// Create ECOM_ARRAY [INTEGER]
	type_id = eif_type_id ("ECOM_ARRAY [INTEGER]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	result = eif_create (type_id);
	make (eif_access (result), dim_count,  eif_access (eif_lower_indeces), eif_access (eif_element_counts));

	// Initialize `result' to contents of SAFEARRAY
	memcpy (index, lower_indeces, dim_count * sizeof(EIF_INTEGER));

	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}
		hr = SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
		if (hr != S_OK)
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		put (eif_access (result), (EIF_INTEGER)sa_element, eif_access (eif_index));

	} while (ccom_safearray_next_index (dim_count, lower_indeces, upper_indeces, index));

	// free memory

	hr = SafeArrayDestroy (a_safearray);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	free (lower_indeces);
	free (element_counts);
	free (upper_indeces);
	free (index);
	free (sa_indeces);

	eif_wean (eif_lower_indeces);
	eif_wean (eif_element_counts);
	eif_wean (eif_index);

	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_long (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of long
{
	EIF_INTEGER dim_count = 0;
	EIF_INTEGER * lower_indeces = 0;
	EIF_INTEGER * upper_indeces = 0;
	EIF_INTEGER * element_counts = 0;
	EIF_INTEGER * index = 0;
	long * sa_indeces = 0;
	int i = 0;
	long tmp_long = 0;
	HRESULT hr = 0;
	EIF_OBJECT result = 0, eif_lower_indeces = 0, eif_element_counts = 0, eif_index = 0;
	EIF_TYPE_ID int_array_id = -1, type_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	long sa_element = 0;

	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));

	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
		{
			upper_indeces[i] = (EIF_INTEGER)tmp_long;
			element_counts[i] = upper_indeces[i] - lower_indeces[i] + 1;
		}
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
	}

	// Create array of lower indeces
	int_array_id = eif_type_id ("ARRAY [INTEGER]");
	make = eif_procedure ("make", int_array_id);
	eif_lower_indeces = eif_create (int_array_id);
	make (eif_access (eif_lower_indeces), 1, dim_count);

	eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);

	// Create array of element counts
	eif_element_counts = eif_create (int_array_id);
	make (eif_access (eif_element_counts), 1, dim_count);

	eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

	// Create array of indeces
	eif_index = eif_create (int_array_id);
	make (eif_access (eif_index), 1, dim_count);

	// Create ECOM_ARRAY [INTEGER]
	type_id = eif_type_id ("ECOM_ARRAY [INTEGER]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	result = eif_create (type_id);
	make (eif_access (result), dim_count,  eif_access (eif_lower_indeces), eif_access (eif_element_counts));

	// Initialize `result' to contents of SAFEARRAY
	memcpy (index, lower_indeces, dim_count * sizeof(EIF_INTEGER));

	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}
		hr = SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
		if (hr != S_OK)
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		put (eif_access (result), (EIF_INTEGER)sa_element, eif_access (eif_index));

	} while (ccom_safearray_next_index (dim_count, lower_indeces, upper_indeces, index));

	// free memory

	hr = SafeArrayDestroy (a_safearray);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	free (lower_indeces);
	free (element_counts);
	free (upper_indeces);
	free (index);
	free (sa_indeces);

	eif_wean (eif_lower_indeces);
	eif_wean (eif_element_counts);
	eif_wean (eif_index);

	return eif_wean (result);
};

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_bstr (BSTR *a_string)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_bstr (*a_string));

	EIF_TYPE_ID tid = eif_type_id ("CELL[STRING]");
	EIF_OBJECT result = eif_create (tid);
	EIF_PROCEDURE put = eif_procedure ("put", tid);
	put (eif_access (result), eif_access (eif_object));
	return eif_wean(result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_date (DATE *a_date)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_date (*a_date));

	EIF_TYPE_ID tid = eif_type_id ("CELL[DATE_TIME]");
	EIF_OBJECT result = eif_create (tid);
	EIF_PROCEDURE put = eif_procedure ("put", tid);
	put (eif_access (result), eif_access (eif_object));
	return eif_wean(result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_short (SAFEARRAY ** a_safearray)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_safearray_short (*a_safearray));

	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE put_proc = 0;

	tid = eif_type_id ("CELL[ECOM_ARRAY[INTEGER]]");
	result = eif_create (tid);
	put_proc = eif_procedure ("put", tid);

	put_proc (eif_access (result), eif_access (eif_object));

	return eif_wean (result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_long (SAFEARRAY ** a_safearray)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_safearray_long (*a_safearray));

	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE put_proc = 0;

	tid = eif_type_id ("CELL[ECOM_ARRAY[INTEGER]]");
	result = eif_create (tid);
	put_proc = eif_procedure ("put", tid);

	put_proc (eif_access (result), eif_access (eif_object));

	return eif_wean (result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_float (SAFEARRAY ** a_safearray)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_safearray_float (*a_safearray));

	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE put_proc = 0;

	tid = eif_type_id ("CELL[ECOM_ARRAY[REAL]]");
	result = eif_create (tid);
	put_proc = eif_procedure ("put", tid);

	put_proc (eif_access (result), eif_access (eif_object));

	return eif_wean (result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_double (SAFEARRAY ** a_safearray)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_safearray_double (*a_safearray));

	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE put_proc = 0;

	tid = eif_type_id ("CELL[ECOM_ARRAY[DOUBLE]]");
	result = eif_create (tid);
	put_proc = eif_procedure ("put", tid);

	put_proc (eif_access (result), eif_access (eif_object));

	return eif_wean (result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_currency (SAFEARRAY ** a_safearray)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_safearray_currency (*a_safearray));

	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE put_proc = 0;

	tid = eif_type_id ("CELL[ECOM_ARRAY[ECOM_CURRENCY]]");
	result = eif_create (tid);
	put_proc = eif_procedure ("put", tid);

	put_proc (eif_access (result), eif_access (eif_object));

	return eif_wean (result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_date (SAFEARRAY ** a_safearray)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_safearray_date (*a_safearray));

	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE put_proc = 0;

	tid = eif_type_id ("CELL[ECOM_ARRAY[DATE_TIME]]");
	result = eif_create (tid);
	put_proc = eif_procedure ("put", tid);

	put_proc (eif_access (result), eif_access (eif_object));

	return eif_wean (result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_bstr (SAFEARRAY ** a_safearray)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_safearray_bstr (*a_safearray));

	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE put_proc = 0;

	tid = eif_type_id ("CELL[ECOM_ARRAY[STRING]]");
	result = eif_create (tid);
	put_proc = eif_procedure ("put", tid);

	put_proc (eif_access (result), eif_access (eif_object));

	return eif_wean (result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_hresult (SAFEARRAY ** a_safearray)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_safearray_hresult (*a_safearray));

	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE put_proc = 0;

	tid = eif_type_id ("CELL[ECOM_ARRAY[ECOM_HRESULT]]");
	result = eif_create (tid);
	put_proc = eif_procedure ("put", tid);

	put_proc (eif_access (result), eif_access (eif_object));

	return eif_wean (result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_boolean (SAFEARRAY ** a_safearray)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_safearray_boolean (*a_safearray));

	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE put_proc = 0;

	tid = eif_type_id ("CELL[ECOM_ARRAY[BOOLEAN]]");
	result = eif_create (tid);
	put_proc = eif_procedure ("put", tid);

	put_proc (eif_access (result), eif_access (eif_object));
	eif_wean (eif_object);
	return eif_wean (result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_variant (SAFEARRAY ** a_safearray)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_safearray_variant (*a_safearray));

	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE put_proc = 0;

	tid = eif_type_id ("CELL[ECOM_ARRAY[ECOM_VARIANT]]");
	result = eif_create (tid);
	put_proc = eif_procedure ("put", tid);

	put_proc (eif_access (result), eif_access (eif_object));
	eif_wean (eif_object);
	return eif_wean (result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_decimal (SAFEARRAY ** a_safearray)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_safearray_decimal (*a_safearray));

	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE put_proc = 0;

	tid = eif_type_id ("CELL[ECOM_ARRAY[ECOM_DECIMAL]]");
	result = eif_create (tid);
	put_proc = eif_procedure ("put", tid);

	put_proc (eif_access (result), eif_access (eif_object));
	eif_wean (eif_object);
	return eif_wean (result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_char (SAFEARRAY ** a_safearray)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_safearray_char (*a_safearray));

	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE put_proc = 0;

	tid = eif_type_id ("CELL[ECOM_ARRAY[CHARACTER]]");
	result = eif_create (tid);
	put_proc = eif_procedure ("put", tid);

	put_proc (eif_access (result), eif_access (eif_object));
	eif_wean (eif_object);
	return eif_wean (result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_dispatch (SAFEARRAY ** a_safearray)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_safearray_dispatch (*a_safearray));

	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE put_proc = 0;

	tid = eif_type_id ("CELL[ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE]]");
	result = eif_create (tid);
	put_proc = eif_procedure ("put", tid);

	put_proc (eif_access (result), eif_access (eif_object));
	eif_wean (eif_object);
	return eif_wean (result);
}

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_unknown (SAFEARRAY ** a_safearray)
{
	EIF_OBJECT eif_object = eif_protect (ccom_ce_safearray_unknown (*a_safearray));

	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result = 0;
	EIF_PROCEDURE put_proc = 0;

	tid = eif_type_id ("CELL[ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE]]");
	result = eif_create (tid);
	put_proc = eif_procedure ("put", tid);

	put_proc (eif_access (result), eif_access (eif_object));
	eif_wean (eif_object);
	return eif_wean (result);
}

//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_float (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of float
{
	EIF_INTEGER dim_count = 0;
	EIF_INTEGER * lower_indeces = 0;
	EIF_INTEGER * upper_indeces = 0;
	EIF_INTEGER * element_counts = 0;
	EIF_INTEGER * index = 0;
	long * sa_indeces = 0;
	int i = 0;
	long tmp_long = 0;
	HRESULT hr = 0;
	EIF_OBJECT result = 0, eif_lower_indeces = 0, eif_element_counts = 0, eif_index = 0;
	EIF_TYPE_ID int_array_id = -1, type_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	float sa_element = 0;

	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));

	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
		{
			upper_indeces[i] = (EIF_INTEGER)tmp_long;
			element_counts[i] = upper_indeces[i] - lower_indeces[i] + 1;
		}
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
	}

	// Create array of lower indeces
	int_array_id = eif_type_id ("ARRAY [INTEGER]");
	make = eif_procedure ("make", int_array_id);
	eif_lower_indeces = eif_create (int_array_id);
	make (eif_access (eif_lower_indeces), 1, dim_count);

	eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);

	// Create array of element counts
	eif_element_counts = eif_create (int_array_id);
	make (eif_access (eif_element_counts), 1, dim_count);

	eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

	// Create array of indeces
	eif_index = eif_create (int_array_id);
	make (eif_access (eif_index), 1, dim_count);

	// Create ECOM_ARRAY [REAL]
	type_id = eif_type_id ("ECOM_ARRAY [REAL]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	result = eif_create (type_id);
	make (eif_access (result), dim_count,  eif_access (eif_lower_indeces), eif_access (eif_element_counts));

	// Initialize `result' to contents of SAFEARRAY
	memcpy (index, lower_indeces, dim_count * sizeof(EIF_INTEGER));

	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}
		hr = SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
		if (hr != S_OK)
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		put (eif_access (result), (EIF_REAL)sa_element, eif_access (eif_index));

	} while (ccom_safearray_next_index (dim_count, lower_indeces, upper_indeces, index));

	// free memory

	hr = SafeArrayDestroy (a_safearray);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	free (lower_indeces);
	free (element_counts);
	free (upper_indeces);
	free (index);
	free (sa_indeces);

	eif_wean (eif_lower_indeces);
	eif_wean (eif_element_counts);
	eif_wean (eif_index);

	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_double (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of double
{
	EIF_INTEGER dim_count = 0;
	EIF_INTEGER * lower_indeces = 0;
	EIF_INTEGER * upper_indeces = 0;
	EIF_INTEGER * element_counts = 0;
	EIF_INTEGER * index = 0;
	long * sa_indeces = 0;
	int i = 0;
	long tmp_long = 0;
	HRESULT hr = 0;
	EIF_OBJECT result = 0, eif_lower_indeces = 0, eif_element_counts = 0, eif_index = 0;
	EIF_TYPE_ID int_array_id = -1, type_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	double sa_element = 0;

	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));

	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
		{
			upper_indeces[i] = (EIF_INTEGER)tmp_long;
			element_counts[i] = upper_indeces[i] - lower_indeces[i] + 1;
		}
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
	}

	// Create array of lower indeces
	int_array_id = eif_type_id ("ARRAY [INTEGER]");
	make = eif_procedure ("make", int_array_id);
	eif_lower_indeces = eif_create (int_array_id);
	make (eif_access (eif_lower_indeces), 1, dim_count);

	eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);

	// Create array of element counts
	eif_element_counts = eif_create (int_array_id);
	make (eif_access (eif_element_counts), 1, dim_count);

	eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

	// Create array of indeces
	eif_index = eif_create (int_array_id);
	make (eif_access (eif_index), 1, dim_count);

	// Create ECOM_ARRAY [DOUBLE]
	type_id = eif_type_id ("ECOM_ARRAY [DOUBLE]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	result = eif_create (type_id);
	make (eif_access (result), dim_count,  eif_access (eif_lower_indeces), eif_access (eif_element_counts));

	// Initialize `result' to contents of SAFEARRAY
	memcpy (index, lower_indeces, dim_count * sizeof(EIF_INTEGER));

	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}
		hr = SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
		if (hr != S_OK)
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		put (eif_access (result), (EIF_DOUBLE)sa_element, eif_access (eif_index));

	} while (ccom_safearray_next_index (dim_count, lower_indeces, upper_indeces, index));

	// free memory

	hr = SafeArrayDestroy (a_safearray);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	free (lower_indeces);
	free (element_counts);
	free (upper_indeces);
	free (index);
	free (sa_indeces);

	eif_wean (eif_lower_indeces);
	eif_wean (eif_element_counts);
	eif_wean (eif_index);

	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_char (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of char
{
	EIF_INTEGER dim_count = 0;
	EIF_INTEGER * lower_indeces = 0;
	EIF_INTEGER * upper_indeces = 0;
	EIF_INTEGER * element_counts = 0;
	EIF_INTEGER * index = 0;
	long * sa_indeces = 0;
	int i = 0;
	long tmp_long = 0;
	HRESULT hr = 0;
	EIF_OBJECT result = 0, eif_lower_indeces = 0, eif_element_counts = 0, eif_index = 0;
	EIF_TYPE_ID int_array_id = -1, type_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	char sa_element = 0;

	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));

	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
		{
			upper_indeces[i] = (EIF_INTEGER)tmp_long;
			element_counts[i] = upper_indeces[i] - lower_indeces[i] + 1;
		}
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
	}

	// Create array of lower indeces
	int_array_id = eif_type_id ("ARRAY [INTEGER]");
	make = eif_procedure ("make", int_array_id);
	eif_lower_indeces = eif_create (int_array_id);
	make (eif_access (eif_lower_indeces), 1, dim_count);

	eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);

	// Create array of element counts
	eif_element_counts = eif_create (int_array_id);
	make (eif_access (eif_element_counts), 1, dim_count);

	eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

	// Create array of indeces
	eif_index = eif_create (int_array_id);
	make (eif_access (eif_index), 1, dim_count);

	// Create ECOM_ARRAY [CHARACTER]
	type_id = eif_type_id ("ECOM_ARRAY [CHARACTER]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	result = eif_create (type_id);
	make (eif_access (result), dim_count,  eif_access (eif_lower_indeces), eif_access (eif_element_counts));

	// Initialize `result' to contents of SAFEARRAY
	memcpy (index, lower_indeces, dim_count * sizeof(EIF_INTEGER));

	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}
		hr = SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
		if (hr != S_OK)
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		put (eif_access (result), (EIF_CHARACTER)sa_element, eif_access (eif_index));

	} while (ccom_safearray_next_index (dim_count, lower_indeces, upper_indeces, index));

	// free memory

	hr = SafeArrayDestroy (a_safearray);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	free (lower_indeces);
	free (element_counts);
	free (upper_indeces);
	free (index);
	free (sa_indeces);

	eif_wean (eif_lower_indeces);
	eif_wean (eif_element_counts);
	eif_wean (eif_index);

	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_boolean (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of boolean
{
	EIF_INTEGER dim_count = 0;
	EIF_INTEGER * lower_indeces = 0;
	EIF_INTEGER * upper_indeces = 0;
	EIF_INTEGER * element_counts = 0;
	EIF_INTEGER * index = 0;
	long * sa_indeces = 0;
	int i = 0;
	long tmp_long = 0;
	HRESULT hr = 0;
	EIF_OBJECT result = 0, eif_lower_indeces = 0, eif_element_counts = 0, eif_index = 0;
	EIF_TYPE_ID int_array_id = -1, type_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	VARIANT_BOOL sa_element = 0;
	EIF_BOOLEAN eif_array_element = 0;

	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));

	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
		{
			upper_indeces[i] = (EIF_INTEGER)tmp_long;
			element_counts[i] = upper_indeces[i] - lower_indeces[i] + 1;
		}
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
	}

	// Create array of lower indeces
	int_array_id = eif_type_id ("ARRAY [INTEGER]");
	make = eif_procedure ("make", int_array_id);
	eif_lower_indeces = eif_create (int_array_id);
	make (eif_access (eif_lower_indeces), 1, dim_count);

	eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);

	// Create array of element counts
	eif_element_counts = eif_create (int_array_id);
	make (eif_access (eif_element_counts), 1, dim_count);

	eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

	// Create array of indeces
	eif_index = eif_create (int_array_id);
	make (eif_access (eif_index), 1, dim_count);

	// Create ECOM_ARRAY [BOOLEAN]
	type_id = eif_type_id ("ECOM_ARRAY [BOOLEAN]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	result = eif_create (type_id);
	make (eif_access (result), dim_count,  eif_access (eif_lower_indeces), eif_access (eif_element_counts));

	// Initialize `result' to contents of SAFEARRAY
	memcpy (index, lower_indeces, dim_count * sizeof(EIF_INTEGER));

	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}
		hr = SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
		if (hr != S_OK)
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		eif_array_element = (sa_element == 0) ? EIF_FALSE : EIF_TRUE;
		put (eif_access (result), eif_array_element, eif_access (eif_index));

	} while (ccom_safearray_next_index (dim_count, lower_indeces, upper_indeces, index));

	// free memory

	hr = SafeArrayDestroy (a_safearray);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	free (lower_indeces);
	free (element_counts);
	free (upper_indeces);
	free (index);
	free (sa_indeces);

	eif_wean (eif_lower_indeces);
	eif_wean (eif_element_counts);
	eif_wean (eif_index);

	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_currency (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of CURRENCY
{
	EIF_INTEGER dim_count = 0;
	EIF_INTEGER * lower_indeces = 0;
	EIF_INTEGER * upper_indeces = 0;
	EIF_INTEGER * element_counts = 0;
	EIF_INTEGER * index = 0;
	long * sa_indeces = 0;
	int i = 0;
	long tmp_long = 0;
	HRESULT hr = 0;
	EIF_OBJECT result = 0, eif_lower_indeces = 0, eif_element_counts = 0, eif_index = 0, eif_array_element = 0;
	EIF_TYPE_ID int_array_id = -1, type_id = -1, currency_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	CURRENCY * sa_element = 0;

	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));

	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
		{
			upper_indeces[i] = (EIF_INTEGER)tmp_long;
			element_counts[i] = upper_indeces[i] - lower_indeces[i] + 1;
		}
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
	}

	// Create array of lower indeces
	int_array_id = eif_type_id ("ARRAY [INTEGER]");
	make = eif_procedure ("make", int_array_id);
	eif_lower_indeces = eif_create (int_array_id);
	make (eif_access (eif_lower_indeces), 1, dim_count);

	eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);

	// Create array of element counts
	eif_element_counts = eif_create (int_array_id);
	make (eif_access (eif_element_counts), 1, dim_count);

	eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

	// Create array of indeces
	eif_index = eif_create (int_array_id);
	make (eif_access (eif_index), 1, dim_count);

	// Create ECOM_ARRAY [ECOM_CURRENCY]
	type_id = eif_type_id ("ECOM_ARRAY [ECOM_CURRENCY]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	result = eif_create (type_id);
	make (eif_access (result), dim_count,  eif_access (eif_lower_indeces), eif_access (eif_element_counts));

	// Initialize `result' to contents of SAFEARRAY
	memcpy (index, lower_indeces, dim_count * sizeof(EIF_INTEGER));

	currency_id = eif_type_id ("ECOM_CURRENCY");
	make = eif_procedure ("make", currency_id);
	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}

		eif_array_element = eif_create (currency_id);
		make (eif_access (eif_array_element));
		sa_element = (CURRENCY *) eif_field (eif_access (eif_array_element), "item", EIF_POINTER);

		hr = SafeArrayGetElement (a_safearray, sa_indeces, sa_element);
		if (hr != S_OK)
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		put (eif_access (result), eif_access (eif_array_element), eif_access (eif_index));
		eif_wean (eif_array_element);

	} while (ccom_safearray_next_index (dim_count, lower_indeces, upper_indeces, index));

	// free memory

	hr = SafeArrayDestroy (a_safearray);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	free (lower_indeces);
	free (element_counts);
	free (upper_indeces);
	free (index);
	free (sa_indeces);

	eif_wean (eif_lower_indeces);
	eif_wean (eif_element_counts);
	eif_wean (eif_index);

	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_date (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of DATE
{
	EIF_INTEGER dim_count = 0;
	EIF_INTEGER * lower_indeces = 0;
	EIF_INTEGER * upper_indeces = 0;
	EIF_INTEGER * element_counts = 0;
	EIF_INTEGER * index = 0;
	long * sa_indeces = 0;
	int i = 0;
	long tmp_long = 0;
	HRESULT hr = 0;
	EIF_OBJECT result = 0, eif_lower_indeces = 0, eif_element_counts = 0, eif_index = 0;
	EIF_TYPE_ID int_array_id = -1, type_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	DATE sa_element = 0;

	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));

	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
		{
			upper_indeces[i] = (EIF_INTEGER)tmp_long;
			element_counts[i] = upper_indeces[i] - lower_indeces[i] + 1;
		}
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
	}

	// Create array of lower indeces
	int_array_id = eif_type_id ("ARRAY [INTEGER]");
	make = eif_procedure ("make", int_array_id);
	eif_lower_indeces = eif_create (int_array_id);
	make (eif_access (eif_lower_indeces), 1, dim_count);

	eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);

	// Create array of element counts
	eif_element_counts = eif_create (int_array_id);
	make (eif_access (eif_element_counts), 1, dim_count);

	eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

	// Create array of indeces
	eif_index = eif_create (int_array_id);
	make (eif_access (eif_index), 1, dim_count);

	// Create ECOM_ARRAY [DATE_TIME]
	type_id = eif_type_id ("ECOM_ARRAY [DATE_TIME]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	result = eif_create (type_id);
	make (eif_access (result), dim_count,  eif_access (eif_lower_indeces), eif_access (eif_element_counts));

	// Initialize `result' to contents of SAFEARRAY
	memcpy (index, lower_indeces, dim_count * sizeof(EIF_INTEGER));

	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}
		hr = SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
		if (hr != S_OK)
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		put (eif_access (result), ccom_ce_date (sa_element), eif_access (eif_index));

	} while (ccom_safearray_next_index (dim_count, lower_indeces, upper_indeces, index));

	// free memory

	hr = SafeArrayDestroy (a_safearray);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	free (lower_indeces);
	free (element_counts);
	free (upper_indeces);
	free (index);
	free (sa_indeces);

	eif_wean (eif_lower_indeces);
	eif_wean (eif_element_counts);
	eif_wean (eif_index);

	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_decimal (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of DECIMAL
{
	EIF_INTEGER dim_count = 0;
	EIF_INTEGER * lower_indeces = 0;
	EIF_INTEGER * upper_indeces = 0;
	EIF_INTEGER * element_counts = 0;
	EIF_INTEGER * index = 0;
	long * sa_indeces = 0;
	int i = 0;
	long tmp_long = 0;
	HRESULT hr = 0;
	EIF_OBJECT result = 0, eif_lower_indeces = 0, eif_element_counts = 0, eif_index = 0, eif_array_element = 0;
	EIF_TYPE_ID int_array_id = -1, type_id = -1, decimal_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	DECIMAL * sa_element = 0;

	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));

	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
		{
			upper_indeces[i] = (EIF_INTEGER)tmp_long;
			element_counts[i] = upper_indeces[i] - lower_indeces[i] + 1;
		}
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
	}

	// Create array of lower indeces
	int_array_id = eif_type_id ("ARRAY [INTEGER]");
	make = eif_procedure ("make", int_array_id);
	eif_lower_indeces = eif_create (int_array_id);
	make (eif_access (eif_lower_indeces), 1, dim_count);

	eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);

	// Create array of element counts
	eif_element_counts = eif_create (int_array_id);
	make (eif_access (eif_element_counts), 1, dim_count);

	eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

	// Create array of indeces
	eif_index = eif_create (int_array_id);
	make (eif_access (eif_index), 1, dim_count);

	// Create ECOM_ARRAY [ECOM_DECIMAL]
	type_id = eif_type_id ("ECOM_ARRAY [ECOM_DECIMAL]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	result = eif_create (type_id);
	make (eif_access (result), dim_count,  eif_access (eif_lower_indeces), eif_access (eif_element_counts));

	// Initialize `result' to contents of SAFEARRAY
	memcpy (index, lower_indeces, dim_count * sizeof(EIF_INTEGER));

	decimal_id = eif_type_id ("ECOM_DECIMAL");
	make = eif_procedure ("make", decimal_id);
	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}

		eif_array_element = eif_create (decimal_id);
		make (eif_access (eif_array_element));
		sa_element = (DECIMAL *) eif_field (eif_access (eif_array_element), "item", EIF_POINTER);

		hr = SafeArrayGetElement (a_safearray, sa_indeces, sa_element);
		if (hr != S_OK)
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		put (eif_access (result), eif_access (eif_array_element), eif_access (eif_index));
		eif_wean (eif_array_element);

	} while (ccom_safearray_next_index (dim_count, lower_indeces, upper_indeces, index));

	// free memory

	hr = SafeArrayDestroy (a_safearray);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	free (lower_indeces);
	free (element_counts);
	free (upper_indeces);
	free (index);
	free (sa_indeces);

	eif_wean (eif_lower_indeces);
	eif_wean (eif_element_counts);
	eif_wean (eif_index);

	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_bstr (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of BSTR
{
	EIF_INTEGER dim_count = 0;
	EIF_INTEGER * lower_indeces = 0;
	EIF_INTEGER * upper_indeces = 0;
	EIF_INTEGER * element_counts = 0;
	EIF_INTEGER * index = 0;
	long * sa_indeces = 0;
	int i = 0;
	long tmp_long = 0;
	HRESULT hr = 0;
	EIF_OBJECT result = 0, eif_lower_indeces = 0, eif_element_counts = 0, eif_index = 0;
	EIF_TYPE_ID int_array_id = -1, type_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	BSTR sa_element;

	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));

	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
		{
			upper_indeces[i] = (EIF_INTEGER)tmp_long;
			element_counts[i] = upper_indeces[i] - lower_indeces[i] + 1;
		}
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
	}

	// Create array of lower indeces
	int_array_id = eif_type_id ("ARRAY [INTEGER]");
	make = eif_procedure ("make", int_array_id);
	eif_lower_indeces = eif_create (int_array_id);
	make (eif_access (eif_lower_indeces), 1, dim_count);

	eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);

	// Create array of element counts
	eif_element_counts = eif_create (int_array_id);
	make (eif_access (eif_element_counts), 1, dim_count);

	eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

	// Create array of indeces
	eif_index = eif_create (int_array_id);
	make (eif_access (eif_index), 1, dim_count);

	// Create ECOM_ARRAY [STRING]
	type_id = eif_type_id ("ECOM_ARRAY [STRING]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	result = eif_create (type_id);
	make (eif_access (result), dim_count,  eif_access (eif_lower_indeces), eif_access (eif_element_counts));

	// Initialize `result' to contents of SAFEARRAY
	memcpy (index, lower_indeces, dim_count * sizeof(EIF_INTEGER));

	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}
		hr = SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
		if (hr != S_OK)
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		put (eif_access (result), ccom_ce_bstr (sa_element), eif_access (eif_index));

	} while (ccom_safearray_next_index (dim_count, lower_indeces, upper_indeces, index));

	// free memory

	hr = SafeArrayDestroy (a_safearray);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	free (lower_indeces);
	free (element_counts);
	free (upper_indeces);
	free (index);
	free (sa_indeces);

	eif_wean (eif_lower_indeces);
	eif_wean (eif_element_counts);
	eif_wean (eif_index);

	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_variant (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of VARIANT
{
	EIF_INTEGER dim_count = 0;
	EIF_INTEGER * lower_indeces = 0;
	EIF_INTEGER * upper_indeces = 0;
	EIF_INTEGER * element_counts = 0;
	EIF_INTEGER * index = 0;
	long * sa_indeces = 0;
	int i = 0;
	long tmp_long = 0;
	HRESULT hr = 0;
	EIF_OBJECT result = 0, eif_lower_indeces = 0, eif_element_counts = 0, eif_index = 0, eif_array_element = 0;
	EIF_TYPE_ID int_array_id = -1, type_id = -1, variant_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	VARIANT * sa_element = 0;

	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));

	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
		{
			upper_indeces[i] = (EIF_INTEGER)tmp_long;
			element_counts[i] = upper_indeces[i] - lower_indeces[i] + 1;
		}
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
	}

	// Create array of lower indeces
	int_array_id = eif_type_id ("ARRAY [INTEGER]");
	make = eif_procedure ("make", int_array_id);
	eif_lower_indeces = eif_create (int_array_id);
	make (eif_access (eif_lower_indeces), 1, dim_count);

	eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);

	// Create array of element counts
	eif_element_counts = eif_create (int_array_id);
	make (eif_access (eif_element_counts), 1, dim_count);

	eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

	// Create array of indeces
	eif_index = eif_create (int_array_id);
	make (eif_access (eif_index), 1, dim_count);

	// Create ECOM_ARRAY [ECOM_VARIANT]
	type_id = eif_type_id ("ECOM_ARRAY [ECOM_VARIANT]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	result = eif_create (type_id);
	make (eif_access (result), dim_count,  eif_access (eif_lower_indeces), eif_access (eif_element_counts));

	// Initialize `result' to contents of SAFEARRAY
	memcpy (index, lower_indeces, dim_count * sizeof(EIF_INTEGER));

	variant_id = eif_type_id ("ECOM_VARIANT");
	make = eif_procedure ("make", variant_id);
	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}

		eif_array_element = eif_create (variant_id);
		make (eif_access (eif_array_element));
		sa_element = (VARIANT *)eif_field (eif_access (eif_array_element), "item", EIF_POINTER);

		hr = SafeArrayGetElement (a_safearray, sa_indeces, sa_element);
		if (hr != S_OK)
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		put (eif_access (result), eif_access (eif_array_element), eif_access (eif_index));
		eif_wean (eif_array_element);

	} while (ccom_safearray_next_index (dim_count, lower_indeces, upper_indeces, index));

	// free memory

	hr = SafeArrayDestroy (a_safearray);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	free (lower_indeces);
	free (element_counts);
	free (upper_indeces);
	free (index);
	free (sa_indeces);

	eif_wean (eif_lower_indeces);
	eif_wean (eif_element_counts);
	eif_wean (eif_index);

	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_hresult (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of HRESULT
{
	EIF_INTEGER dim_count = 0;
	EIF_INTEGER * lower_indeces = 0;
	EIF_INTEGER * upper_indeces = 0;
	EIF_INTEGER * element_counts = 0;
	EIF_INTEGER * index = 0;
	long * sa_indeces = 0;
	int i = 0;
	long tmp_long = 0;
	HRESULT hr = 0;
	EIF_OBJECT result = 0, eif_lower_indeces = 0, eif_element_counts = 0, eif_index = 0;
	EIF_TYPE_ID int_array_id = -1, type_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	HRESULT sa_element = 0;

	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));

	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
		{
			upper_indeces[i] = (EIF_INTEGER)tmp_long;
			element_counts[i] = upper_indeces[i] - lower_indeces[i] + 1;
		}
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
	}

	// Create array of lower indeces
	int_array_id = eif_type_id ("ARRAY [INTEGER]");
	make = eif_procedure ("make", int_array_id);
	eif_lower_indeces = eif_create (int_array_id);
	make (eif_access (eif_lower_indeces), 1, dim_count);

	eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);

	// Create array of element counts
	eif_element_counts = eif_create (int_array_id);
	make (eif_access (eif_element_counts), 1, dim_count);

	eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

	// Create array of indeces
	eif_index = eif_create (int_array_id);
	make (eif_access (eif_index), 1, dim_count);

	// Create ECOM_ARRAY [ECOM_HRESULT]
	type_id = eif_type_id ("ECOM_ARRAY [ECOM_HRESULT]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	result = eif_create (type_id);
	make (eif_access (result), dim_count,  eif_access (eif_lower_indeces), eif_access (eif_element_counts));

	// Initialize `result' to contents of SAFEARRAY
	memcpy (index, lower_indeces, dim_count * sizeof(EIF_INTEGER));

	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}
		hr = SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
		if (hr != S_OK)
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		put (eif_access (result), ccom_ce_hresult (sa_element), eif_access (eif_index));

	} while (ccom_safearray_next_index (dim_count, lower_indeces, upper_indeces, index));

	// free memory

	hr = SafeArrayDestroy (a_safearray);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	free (lower_indeces);
	free (element_counts);
	free (upper_indeces);
	free (index);
	free (sa_indeces);

	eif_wean (eif_lower_indeces);
	eif_wean (eif_element_counts);
	eif_wean (eif_index);

	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_unknown (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of IUnknown *.
{
	EIF_INTEGER dim_count = 0;
	EIF_INTEGER * lower_indeces = 0;
	EIF_INTEGER * upper_indeces = 0;
	EIF_INTEGER * element_counts = 0;
	EIF_INTEGER * index = 0;
	long * sa_indeces = 0;
	int i = 0;
	long tmp_long = 0;
	HRESULT hr = 0;
	EIF_OBJECT result = 0, eif_lower_indeces = 0, eif_element_counts = 0, eif_index = 0;
	EIF_TYPE_ID int_array_id = -1, type_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	IUnknown * sa_element = 0;

	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));

	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
		{
			upper_indeces[i] = (EIF_INTEGER)tmp_long;
			element_counts[i] = upper_indeces[i] - lower_indeces[i] + 1;
		}
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
	}

	// Create array of lower indeces
	int_array_id = eif_type_id ("ARRAY [INTEGER]");
	make = eif_procedure ("make", int_array_id);
	eif_lower_indeces = eif_create (int_array_id);
	make (eif_access (eif_lower_indeces), 1, dim_count);

	eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);

	// Create array of element counts
	eif_element_counts = eif_create (int_array_id);
	make (eif_access (eif_element_counts), 1, dim_count);

	eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

	// Create array of indeces
	eif_index = eif_create (int_array_id);
	make (eif_access (eif_index), 1, dim_count);

	// Create ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE]
	type_id = eif_type_id ("ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	result = eif_create (type_id);
	make (eif_access (result), dim_count,  eif_access (eif_lower_indeces), eif_access (eif_element_counts));

	// Initialize `result' to contents of SAFEARRAY
	memcpy (index, lower_indeces, dim_count * sizeof(EIF_INTEGER));

	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}
		hr = SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
		if (hr != S_OK)
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		put (eif_access (result), ccom_ce_pointed_unknown (sa_element), eif_access (eif_index));
		sa_element->AddRef();

	} while (ccom_safearray_next_index (dim_count, lower_indeces, upper_indeces, index));

	// free memory

	hr = SafeArrayDestroy (a_safearray);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	free (lower_indeces);
	free (element_counts);
	free (upper_indeces);
	free (index);
	free (sa_indeces);

	eif_wean (eif_lower_indeces);
	eif_wean (eif_element_counts);
	eif_wean (eif_index);

	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_dispatch (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of IDispatch *.
{
	EIF_INTEGER dim_count = 0;
	EIF_INTEGER * lower_indeces = 0;
	EIF_INTEGER * upper_indeces = 0;
	EIF_INTEGER * element_counts = 0;
	EIF_INTEGER * index = 0;
	long * sa_indeces = 0;
	int i = 0;
	long tmp_long = 0;
	HRESULT hr = 0;
	EIF_OBJECT result = 0, eif_lower_indeces = 0, eif_element_counts = 0, eif_index = 0;
	EIF_TYPE_ID int_array_id = -1, type_id = -1;
	EIF_PROCEDURE make = 0, put = 0;
	IDispatch * sa_element = 0;

	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));

	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i + 1, &tmp_long);
		if (SUCCEEDED (hr))
		{
			upper_indeces[i] = (EIF_INTEGER)tmp_long;
			element_counts[i] = upper_indeces[i] - lower_indeces[i] + 1;
		}
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
	}

	// Create array of lower indeces
	int_array_id = eif_type_id ("ARRAY [INTEGER]");
	make = eif_procedure ("make", int_array_id);
	eif_lower_indeces = eif_create (int_array_id);
	make (eif_access (eif_lower_indeces), 1, dim_count);

	eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);

	// Create array of element counts
	eif_element_counts = eif_create (int_array_id);
	make (eif_access (eif_element_counts), 1, dim_count);

	eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

	// Create array of indeces
	eif_index = eif_create (int_array_id);
	make (eif_access (eif_index), 1, dim_count);

	// Create ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE]
	type_id = eif_type_id ("ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	result = eif_create (type_id);
	make (eif_access (result), dim_count,  eif_access (eif_lower_indeces), eif_access (eif_element_counts));

	// Initialize `result' to contents of SAFEARRAY
	memcpy (index, lower_indeces, dim_count * sizeof(EIF_INTEGER));

	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}
		hr = SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
		if (hr != S_OK)
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		put (eif_access (result), ccom_ce_pointed_dispatch (sa_element), eif_access (eif_index));
		sa_element->AddRef();

	} while (ccom_safearray_next_index (dim_count, lower_indeces, upper_indeces, index));

	// free memory

	hr = SafeArrayDestroy (a_safearray);
	if (hr != S_OK)
	{
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	}
	free (lower_indeces);
	free (element_counts);
	free (upper_indeces);
	free (index);
	free (sa_indeces);

	eif_wean (eif_lower_indeces);
	eif_wean (eif_element_counts);
	eif_wean (eif_index);

	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_pointer (void ** a_pointer, EIF_OBJECT an_object)

// Create CELL [POINTER] from void **.
{
	EIF_TYPE_ID type_id = -1;
	EIF_PROCEDURE set_item = 0;
	EIF_OBJECT result = 0;

	type_id = eif_type_id ("CELL [POINTER]");
	set_item = eif_procedure ("set_item", type_id);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		result = eif_create (type_id);
	else
		result = an_object;
	set_item (eif_access (result), *a_pointer);
	CoTaskMemFree (a_pointer);
	if ((an_object == NULL) || (eif_access (an_object) == NULL))
		return eif_wean (result);
	else
		return NULL;
};
//-------------------------------------------------------------------------
