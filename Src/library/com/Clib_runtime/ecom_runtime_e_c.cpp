//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		ecom_runtime_e_c.c
//
//  Contents:	Runtime conversion functions from C to Eiffel
//
//--------------------------------------------------------------------------

#include "ecom_runtime_e_c.h"

ecom_runtime_ec rt_ec;

HRESULT * ecom_runtime_ec::ccom_ec_pointed_hresult (EIF_REFERENCE a_ref, HRESULT * old)

// create HRESULT * from ECOM_HRESULT
{
	EIF_OBJECT eif_object = eif_protect (a_ref);

	HRESULT * hresult =0;
	HRESULT tmp_hresult = 0;

	tmp_hresult = (HRESULT) eif_field (eif_access(eif_object), "item", EIF_INTEGER);

	if ( old == NULL)
	{
		hresult = (HRESULT *)CoTaskMemAlloc (sizeof (HRESULT));
		*hresult = tmp_hresult;
	}
	else
	{
		*old = tmp_hresult;
		hresult = NULL;
	}
	eif_wean (eif_object);
	return hresult;
}

//-------------------------------------------------------------------------
VARIANT_BOOL *ecom_runtime_ec::ccom_ec_pointed_boolean (EIF_REFERENCE a_bool, VARIANT_BOOL * old)

// Create VARIANT_BOOL from ECOM_BOOLEAN
{
	EIF_OBJECT eif_object;
	VARIANT_BOOL * result;
	EIF_BOOLEAN temp_bool;

	eif_object = eif_protect (a_bool);

	temp_bool = (EIF_BOOLEAN) eif_field (eif_access (eif_object), "item", EIF_BOOLEAN);

	eif_wean (eif_object);
	if (old != NULL)
	{
		if (temp_bool == EIF_TRUE)
			*old = VARIANT_TRUE;
		else
			*old = VARIANT_FALSE;
		result = NULL;
	}
	else
	{
		result = (VARIANT_BOOL *) CoTaskMemAlloc (sizeof (VARIANT_BOOL));
		if (temp_bool == EIF_TRUE)
			*result = VARIANT_TRUE;
		else
			*result = VARIANT_FALSE;
	}
	return result;
};

//-------------------------------------------------------------------------

VARIANT_BOOL ecom_runtime_ec::ccom_ec_boolean (EIF_BOOLEAN a_bool)

// Create VARIANT_BOOL from ECOM_BOOLEAN
{
	VARIANT_BOOL result;

	if (a_bool == EIF_TRUE)
		result = VARIANT_TRUE;
	else
		result = VARIANT_FALSE;
	return result;
};
//----------------------------------------------------------------------------

DATE ecom_runtime_ec::ccom_ec_date (EIF_REFERENCE a_ref)

// Create DATE from Eiffel DATE_TIME
{
	EIF_OBJECT date_time = eif_protect (a_ref);

	SYSTEMTIME * systime;
	DATE variant_time;

	EIF_INTEGER_FUNCTION f_year, f_month, f_day, f_hour, f_minute, f_second;
	EIF_TYPE_ID tid;

	tid = eif_type_id ("DATE_TIME");

	f_year = eif_integer_function ("year", tid);
	f_month = eif_integer_function ("month", tid);
	f_day = eif_integer_function ("day", tid);
	f_hour = eif_integer_function ("hour", tid);
	f_minute = eif_integer_function ("minute", tid);
	f_second = eif_integer_function ("second", tid);

	systime = (SYSTEMTIME *)malloc (sizeof (SYSTEMTIME));

	systime->wYear = (WORD)(f_year)(eif_access(date_time));
	systime->wMonth = (WORD)(f_month)(eif_access(date_time));
	systime->wDay = (WORD)(f_day)(eif_access(date_time));
	systime->wHour = (WORD)(f_hour)(eif_access(date_time));
	systime->wMinute = (WORD)(f_minute)(eif_access(date_time));
	systime->wSecond = (WORD)(f_second)(eif_access(date_time));

	SystemTimeToVariantTime (systime, &variant_time);

	eif_wean (date_time);
	free (systime);

	return variant_time;
};
//----------------------------------------------------------------------------

HRESULT ecom_runtime_ec::ccom_ec_hresult (EIF_REFERENCE a_ref)

// Create HRESULT from Eiffel ECOM_HRESULT
{
	EIF_OBJECT hr;

	hr = eif_protect (a_ref);

	HRESULT result = 0;
	result = (HRESULT) eif_field (eif_access(hr), "item", EIF_INTEGER);

	eif_wean (hr);

	return result;
};
//---------------------------------------------------------------------------

LARGE_INTEGER ecom_runtime_ec::ccom_ec_long_long (EIF_REFERENCE a_ref)

// Create LARGE_INTEGER from Eiffel ECOM_LARGE_INTEGER
{
	EIF_OBJECT an_int;

	LARGE_INTEGER * c_large_integer;

	an_int = eif_protect (a_ref);

	c_large_integer = (LARGE_INTEGER *)eif_field (eif_access(an_int), "item", EIF_POINTER);
	eif_wean (an_int);

	return (*c_large_integer);
};
//--------------------------------------------------------------------------------

LARGE_INTEGER * ecom_runtime_ec::ccom_ec_pointed_long_long (EIF_REFERENCE a_ref, LARGE_INTEGER * old)

// Create LARGE_INTEGER from Eiffel ECOM_LARGE_INTEGER
{
	EIF_OBJECT an_int;

	LARGE_INTEGER * c_large_integer;

	an_int = eif_protect (a_ref);

	c_large_integer = (LARGE_INTEGER *)eif_field(eif_access(an_int), "item", EIF_POINTER);
	eif_wean (an_int);

	if (old != NULL)
	{
		memcpy (old, c_large_integer, sizeof (LARGE_INTEGER));
		return NULL;
	}
	else
		return c_large_integer;
};
//--------------------------------------------------------------------------------

ULARGE_INTEGER ecom_runtime_ec::ccom_ec_ulong_long (EIF_REFERENCE a_ref)

// Create ULARGE_INTEGER from Eiffel ECOM_ULARGE_INTEGER
{
	EIF_OBJECT an_int;

	ULARGE_INTEGER * c_ularge_integer;

	an_int = eif_protect (a_ref);

	c_ularge_integer = (ULARGE_INTEGER *)eif_field(eif_access(an_int), "item", EIF_POINTER);
	eif_wean (an_int);

	return (*c_ularge_integer);
};
//----------------------------------------------------------------------------

ULARGE_INTEGER * ecom_runtime_ec::ccom_ec_pointed_ulong_long (EIF_REFERENCE a_ref, ULARGE_INTEGER *old)

// Create ULARGE_INTEGER from Eiffel ECOM_ULARGE_INTEGER
{
	EIF_OBJECT an_int;

	ULARGE_INTEGER * c_ularge_integer;

	an_int = eif_protect (a_ref);

	c_ularge_integer = (ULARGE_INTEGER *)eif_field(eif_access(an_int), "item", EIF_POINTER);
	eif_wean (an_int);

	if (old != NULL)
	{
		memcpy (old, c_ularge_integer, sizeof (ULARGE_INTEGER));
		return NULL;
	}
	else
		return c_ularge_integer;
};
//----------------------------------------------------------------------------

IUnknown * ecom_runtime_ec::ccom_ec_unknown (EIF_REFERENCE a_ref)

// Create IUnknown from Eiffel ECOM_UNKNOWN_INTERFACE
{
	EIF_OBJECT an_interface;

	IUnknown * c_iunknown;

	an_interface = eif_protect (a_ref);

	c_iunknown = (IUnknown *)eif_field(eif_access(an_interface), "item", EIF_POINTER);
	eif_wean (an_interface);

	return c_iunknown;
};
//----------------------------------------------------------------------------

IDispatch * ecom_runtime_ec::ccom_ec_dispatch (EIF_REFERENCE a_ref)

// Create IDispatch from Eiffel ECOM_AUTOMATION_INTERFACE
{
	EIF_OBJECT an_interface;

	IDispatch * c_dispatch;

	an_interface = eif_protect (a_ref);

	c_dispatch = (IDispatch *)eif_field(eif_access(an_interface), "item", EIF_POINTER);
	eif_wean (an_interface);

	return c_dispatch;
};
//----------------------------------------------------------------------------

DECIMAL ecom_runtime_ec::ccom_ec_decimal (EIF_REFERENCE a_ref)

// Create DECIMAL from EIF_REFERENCE
{
	EIF_OBJECT a_decimal;
	DECIMAL * c_decimal;

	a_decimal = eif_protect (a_ref);

	c_decimal = (DECIMAL *)eif_field(eif_access(a_decimal), "item", EIF_POINTER);
	eif_wean (a_decimal);

	return (*c_decimal);
};
//----------------------------------------------------------------------------

DECIMAL * ecom_runtime_ec::ccom_ec_pointed_decimal (EIF_REFERENCE a_ref, DECIMAL * old)

// Create DECIMAL from EIF_REFERENCE
{
	EIF_OBJECT a_decimal;
	DECIMAL * c_decimal;

	a_decimal = eif_protect (a_ref);

	c_decimal = (DECIMAL *)eif_field(eif_access(a_decimal), "item", EIF_POINTER);
	eif_wean (a_decimal);

	if (old != NULL)
	{
		memcpy (old, c_decimal, sizeof (DECIMAL));
		return NULL;
	}
	else
		return c_decimal;
};
//----------------------------------------------------------------------------

CURRENCY ecom_runtime_ec::ccom_ec_currency (EIF_REFERENCE a_ref)

// Create CURRENCY from EIF_REFERENCE
{
	EIF_OBJECT a_currency;
	CURRENCY * c_currency;

	a_currency = eif_protect (a_ref);

	c_currency = (CURRENCY *)eif_field(eif_access(a_currency), "item", EIF_POINTER);
	eif_wean (a_currency);

	return (*c_currency);
};
//----------------------------------------------------------------------------

char * ecom_runtime_ec::ccom_ec_pointed_character (EIF_REFERENCE a_ref, char * old)

// Create char * from EIF_REFERENCE (CHARACTER_REF)
{
	EIF_OBJECT eif_object;
	char * result;

	eif_object = eif_protect (a_ref);

	result = (char *) CoTaskMemAlloc (sizeof (char));
	* result = (char) eif_field(eif_access(eif_object), "item", EIF_CHARACTER);

	eif_wean (eif_object);
	if (old != NULL)
	{
		*old = *result;
		return NULL;
	}
	else
		return result;
};
//----------------------------------------------------------------------------

DATE * ecom_runtime_ec::ccom_ec_pointed_date (EIF_REFERENCE a_ref, DATE * old)

// Create char * from EIF_REFERENCE (CELL [DATE_TIME])
{
	EIF_OBJECT eif_object;
	DATE * result;

	eif_object = eif_protect (a_ref);

	result = (DATE *) CoTaskMemAlloc (sizeof (DATE));
	* result = (DATE) ccom_ec_date (eif_field (eif_access (eif_object), "item", EIF_REFERENCE));

	eif_wean (eif_object);
	if (old != NULL)
	{
		*old = *result;
		return NULL;
	}
	else
		return result;
};
//----------------------------------------------------------------------------
short * ecom_runtime_ec::ccom_ec_pointed_short (EIF_REFERENCE a_ref, short * old)

// Create short * from EIF_REFERENCE (INTEGER_REF)
{
	EIF_OBJECT eif_object;
	short * result;

	eif_object = eif_protect (a_ref);

	result = (short *) CoTaskMemAlloc (sizeof (short));
	* result = (short) eif_field (eif_access (eif_object), "item", EIF_INTEGER);

	eif_wean (eif_object);
	if (old != NULL)
	{
		*old = *result;
		return NULL;
	}
	else
		return result;
};

// ----------------------------------------------------------------------------

int * ecom_runtime_ec::ccom_ec_pointed_integer (EIF_REFERENCE a_ref, int * old)
// Create int * from EIF_REFERENCE (INTEGER_REF)
{
	EIF_OBJECT eif_object;
	int * result;

	eif_object = eif_protect (a_ref);

	result = (int *) CoTaskMemAlloc (sizeof (int));
	* result = (int) eif_field (eif_access(eif_object), "item", EIF_INTEGER);

	eif_wean (eif_object);
	if (old != NULL)
	{
		*old = *result;
		return NULL;
	}
	else
		return result;
};

//---------------------------------------------------------------------------

long * ecom_runtime_ec::ccom_ec_pointed_long (EIF_REFERENCE a_ref, long * old)

// Create long * from EIF_REFERENCE (INTEGER_REF)
{
	EIF_OBJECT eif_object;
	long * result;

	eif_object = eif_protect (a_ref);

	result = (long *) CoTaskMemAlloc (sizeof (long));
	* result = (long) eif_field (eif_access(eif_object), "item", EIF_INTEGER);

	eif_wean (eif_object);
	eif_wean (eif_object);
	if (old != NULL)
	{
		*old = *result;
		return NULL;
	}
	else
		return result;
};
//---------------------------------------------------------------------------

float * ecom_runtime_ec::ccom_ec_pointed_real (EIF_REFERENCE a_ref, float * old)

// Create float * from EIF_REFERENCE (REAL_REF)
{
	EIF_OBJECT eif_object;
	EIF_TYPE_ID type_id;
	float * result;

	eif_object = eif_protect (a_ref);

	result = (float *) CoTaskMemAlloc (sizeof (float));
	* result = (float) eif_field (eif_access(eif_object), "item", EIF_REAL);

	eif_wean (eif_object);
	eif_wean (eif_object);
	if (old != NULL)
	{
		*old = *result;
		return NULL;
	}
	else
		return result;
};
//---------------------------------------------------------------------------

double * ecom_runtime_ec::ccom_ec_pointed_double (EIF_REFERENCE a_ref, double * old)

// Create double * from EIF_REFERENCE (DOUBLE_REF)
{
	EIF_OBJECT eif_object;
	double * result;

	eif_object = eif_protect (a_ref);

	result = (double *) CoTaskMemAlloc (sizeof (double));
	* result = (double) eif_field(eif_access(eif_object), "item", EIF_DOUBLE);

	eif_wean (eif_object);
	eif_wean (eif_object);
	if (old != NULL)
	{
		*old = *result;
		return NULL;
	}
	else
		return result;
};
//---------------------------------------------------------------------------

CURRENCY * ecom_runtime_ec::ccom_ec_pointed_currency (EIF_REFERENCE a_ref, CURRENCY * old)

// Create (CURRENCY *) from EIF_REFERENCE
{
	EIF_OBJECT a_currency;
	CURRENCY * c_currency;

	a_currency = eif_protect (a_ref);

	c_currency = (CURRENCY *)eif_field(eif_access(a_currency), "item", EIF_POINTER);
	eif_wean (a_currency);

	if (old != NULL)
	{
		memcpy (old, c_currency, sizeof (CURRENCY));
		return NULL;
	}
	else
		return c_currency;
};
//----------------------------------------------------------------------------

BSTR ecom_runtime_ec::ccom_ec_bstr (EIF_REFERENCE a_ref)

// Create BSTR from Eiffel STRING
{
	EIF_OBJECT eif_object;
	EIF_TYPE_ID tid;
	EIF_REFERENCE_FUNCTION f_to_c;
	char * c_string;
	WCHAR * wide_string;
	BSTR b_string;

	eif_object = eif_protect (a_ref);
	tid = eif_type_id ("STRING");
	f_to_c = eif_reference_function ("to_c", tid);

	c_string = (f_to_c)(eif_access (eif_object));
	wide_string = ccom_create_from_string (c_string);

	b_string = SysAllocString (wide_string);

	free (wide_string);
	eif_wean (eif_object);
	return b_string;
};
//----------------------------------------------------------------------------

LPSTR ecom_runtime_ec::ccom_ec_lpstr (EIF_REFERENCE a_ref)

// Create LPSTR from Eiffel STRING
{
	EIF_OBJECT eif_object;
	EIF_TYPE_ID type_id;
	EIF_REFERENCE_FUNCTION to_c;
	char * area_string;
	char * result;


	eif_object = eif_protect (a_ref);
	type_id = eif_type_id ("STRING");
	to_c = eif_reference_function ("to_c", type_id);

	area_string = to_c (eif_access (eif_object));
	result = (char *) CoTaskMemAlloc (strlen (area_string) + 1);
	strcpy (result, area_string);
	eif_wean (eif_object);
	return result;
};
//----------------------------------------------------------------------------

LPWSTR ecom_runtime_ec::ccom_ec_lpwstr (EIF_REFERENCE a_ref)

// Create LPWSTR from Eiffel STRING
{
	EIF_OBJECT eif_object;
	EIF_TYPE_ID type_id;
	EIF_REFERENCE_FUNCTION to_c;
	char * area_string;
	WCHAR * result;
	size_t size, str_size;

	eif_object = eif_protect (a_ref);
	type_id = eif_type_id ("STRING");
	to_c = eif_reference_function ("to_c", type_id);

	area_string = to_c (eif_access (eif_object));
	str_size = strlen (area_string) + 1;
	size = mbstowcs (NULL, area_string, str_size);
	result = (WCHAR *) CoTaskMemAlloc ((size + 1) * sizeof (WCHAR));
	mbstowcs (result, area_string, str_size);
	eif_wean (eif_object);
	return result;
};
//----------------------------------------------------------------------------

VARIANT ecom_runtime_ec::ccom_ec_variant (EIF_REFERENCE a_ref)

// Create VARIANT from EIF_REFERENCE
{
	EIF_OBJECT a_variant;
	VARIANT * c_variant;

	a_variant = eif_protect (a_ref);

	c_variant = (VARIANT *)eif_field(eif_access(a_variant), "item", EIF_POINTER);
	eif_wean (a_variant);

	return (*c_variant);
};
//----------------------------------------------------------------------------

VARIANT * ecom_runtime_ec::ccom_ec_pointed_variant (EIF_REFERENCE a_ref, VARIANT * old)

// Create VARIANT from EIF_REFERENCE
{
	EIF_OBJECT a_variant;
	VARIANT * c_variant;

	a_variant = eif_protect (a_ref);

	c_variant = (VARIANT *)eif_field(eif_access(a_variant), "item", EIF_POINTER);
	eif_wean (a_variant);
	if (old != NULL)
	{
		memcpy (old, c_variant, sizeof (VARIANT));
		return NULL;
	}
	else
		return c_variant;
};
//----------------------------------------------------------------------------

// ARRAY

DATE * ecom_runtime_ec::ccom_ec_array_date (EIF_REFERENCE a_ref, int dimension, DATE * old)

// Create C array of DATE from Eiffel array
{
	EIF_OBJECT eif_date_array;

	EIF_TYPE_ID tid;
	EIF_REFERENCE_FUNCTION f_item;
	EIF_INTEGER_FUNCTION count;

	DATE * date_array;
	DATE a_date;
	int capacity;

	eif_date_array = eif_protect (a_ref);
	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[DATE_TIME]");
		f_item = eif_reference_function ("array_item", tid);
	}
	else
	{
		tid = eif_type_id ("ARRAY[DATE_TIME]");
		f_item = eif_reference_function ("item", tid);
	}
	// Allocate memory
	count = eif_integer_function ("count", tid);

	capacity = (int)(count)(eif_access(eif_date_array));

	date_array = (DATE *) CoTaskMemAlloc (capacity*(sizeof(DATE)));

	for (int i=0; i < capacity; i++)
	{
		a_date = ccom_ec_date( (f_item)(eif_access(eif_date_array), ((EIF_INTEGER)(i+1))));
		ccom_c_array_element (date_array, i, DATE) = a_date;
	}

	eif_wean (eif_date_array);

	if (old != NULL)
	{
		memcpy (old, date_array, capacity*(sizeof(DATE)));
		return NULL;
	}
	else
		return date_array;
};
//----------------------------------------------------------------------------
char * ecom_runtime_ec::ccom_ec_array_character (EIF_REFERENCE a_ref, int dimension, char * old)

// Create C array of char from Eiffel array.
{
	EIF_OBJECT e_array;

	EIF_TYPE_ID tid;
	EIF_INTEGER_FUNCTION f_capacity;
	EIF_POINTER_FUNCTION to_c;

	char * result;
	int capacity;

	e_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[CHARACTER]");
	}
	else
	{
		tid = eif_type_id ("ARRAY[CHARACTER]");
	}

	to_c = eif_pointer_function ("to_c", tid);
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_array));
	if (old != NULL)
		result = (char *)CoTaskMemAlloc (capacity*(sizeof(char)));
	else
		result = old;


	memcpy (result, (to_c)(eif_access(e_array)), capacity*(sizeof(char)));

	eif_wean (e_array);
	return result;
};
//----------------------------------------------------------------------------

long * ecom_runtime_ec::ccom_ec_array_long (EIF_REFERENCE a_ref, int dimension, long * old)

// Create C array of long from Eiffel array.
{
	EIF_OBJECT e_array;

	EIF_TYPE_ID tid;
	EIF_INTEGER_FUNCTION f_capacity;
	EIF_POINTER_FUNCTION to_c;

	long * result;
	int capacity;

	e_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[INTEGER]");
	}
	else
	{
		tid = eif_type_id ("ARRAY[INTEGER]");
	}

	to_c = eif_pointer_function ("to_c", tid);
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_array));
	if (old != NULL)
		result = (long *)CoTaskMemAlloc (capacity*(sizeof(long)));
	else
		result = old;


	memcpy (result, (to_c)(eif_access(e_array)), capacity*(sizeof(long)));

	eif_wean (e_array);
	return result;
};
//----------------------------------------------------------------------------

float * ecom_runtime_ec::ccom_ec_array_float (EIF_REFERENCE a_ref, int dimension, float * old)

// Create C array of float from Eiffel array.
{
	EIF_OBJECT e_array;

	EIF_TYPE_ID tid;
	EIF_INTEGER_FUNCTION f_capacity;
	EIF_POINTER_FUNCTION to_c;

	float * result;
	int capacity;

	e_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[REAL]");
	}
	else
	{
		tid = eif_type_id ("ARRAY[REAL]");
	}

	to_c = eif_pointer_function ("to_c", tid);
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_array));
	if (old != NULL)
		result = (float *)CoTaskMemAlloc (capacity*(sizeof(float)));
	else
		result = old;


	memcpy (result, (to_c)(eif_access(e_array)), capacity*(sizeof(float)));

	eif_wean (e_array);
	return result;
};
//----------------------------------------------------------------------------

double * ecom_runtime_ec::ccom_ec_array_double (EIF_REFERENCE a_ref, int dimension, double * old)

// Create C array of double from Eiffel array.
{
	EIF_OBJECT e_array;

	EIF_TYPE_ID tid;
	EIF_INTEGER_FUNCTION f_capacity;
	EIF_POINTER_FUNCTION to_c;

	double * result;
	int capacity;

	e_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[DOUBLE]");
	}
	else
	{
		tid = eif_type_id ("ARRAY[DOUBLE]");
	}

	to_c = eif_pointer_function ("to_c", tid);
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_array));
	if (old != NULL)
		result = (double *)CoTaskMemAlloc (capacity*(sizeof(double)));
	else
		result = old;


	memcpy (result, (to_c)(eif_access(e_array)), capacity*(sizeof(double)));

	eif_wean (e_array);
	return result;
};
//----------------------------------------------------------------------------

short * ecom_runtime_ec::ccom_ec_array_short (EIF_REFERENCE a_ref, int dimension, short * old)

// Create C array of short from Eiffel array.
{
	EIF_OBJECT e_short_array;

	EIF_TYPE_ID tid;
	EIF_INTEGER_FUNCTION f_item, f_capacity;

	short * short_array;
	short a_short;
	int capacity;

	e_short_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[INTEGER]");
		f_item = eif_integer_function ("array_item", tid);
	}
	else
	{
		tid = eif_type_id ("ARRAY[INTEGER]");
		f_item = eif_integer_function ("item", tid);
	}
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_short_array));

	short_array = (short *)CoTaskMemAlloc (capacity*(sizeof(short)));

	for (int i=0; i < capacity; i++)
	{
		a_short = (short)(f_item)(eif_access(e_short_array), ((EIF_INTEGER)(i+1)));
		ccom_c_array_element (short_array, i, short) = a_short;
	}

	eif_wean (e_short_array);
	if (old != NULL)
	{
		memcpy (old, short_array, capacity*(sizeof(short)));
		return NULL;
	}
	else
		return short_array;
};
//----------------------------------------------------------------------------

HRESULT * ecom_runtime_ec::ccom_ec_array_hresult (EIF_REFERENCE a_ref, int dimension, HRESULT * old)

// Create C array of HRESULT from Eiffel array.
{
	EIF_OBJECT e_hresult_array;

	EIF_TYPE_ID tid;
	EIF_INTEGER_FUNCTION f_capacity;
	EIF_REFERENCE_FUNCTION f_item;

	HRESULT * hresult_array;
	HRESULT hr;
	int capacity;

	e_hresult_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[ECOM_HRESULT]");
		f_item = eif_reference_function ("array_item", tid);
	}
	else
	{
		tid = eif_type_id ("ARRAY[ECOM_HRESULT]");
		f_item = eif_reference_function ("item", tid);
	}
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_hresult_array));

	hresult_array = (HRESULT *)CoTaskMemAlloc (capacity*(sizeof(HRESULT)));

	for (int i=0; i < capacity; i++)
	{
		hr = ccom_ec_hresult ((f_item)(eif_access(e_hresult_array), ((EIF_INTEGER)(i+1))));
		ccom_c_array_element (hresult_array, i, HRESULT) = hr;
	}

	eif_wean (e_hresult_array);
	if (old != NULL)
	{
		memcpy (old, hresult_array, capacity*(sizeof(HRESULT)));
		return NULL;
	}
	else
		return hresult_array;
};
//----------------------------------------------------------------------------

CURRENCY * ecom_runtime_ec::ccom_ec_array_currency (EIF_REFERENCE a_ref, int dimension, CURRENCY * old)

// Create C array of CURRENCY from Eiffel array.
{
	EIF_OBJECT e_currency_array;

	EIF_TYPE_ID tid;
	EIF_REFERENCE_FUNCTION f_item;
	EIF_INTEGER_FUNCTION f_capacity;

	CURRENCY * currency_array;
	CURRENCY * p_currency;
	int capacity;

	e_currency_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[ECOM_CURRENCY]");
		f_item = eif_reference_function ("array_item", tid);
	}
	else
	{
		tid = eif_type_id ("ARRAY[ECOM_CURRENCY]");
		f_item = eif_reference_function ("item", tid);
	}
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_currency_array));

	currency_array = (CURRENCY *)CoTaskMemAlloc (capacity*(sizeof(CURRENCY)));

	for (int i=0; i < capacity; i++)
	{
		p_currency = ccom_ec_pointed_currency ((f_item)(eif_access(e_currency_array), ((EIF_INTEGER)(i+1))), NULL);
		memcpy (((CURRENCY *)currency_array + i), p_currency, sizeof (CURRENCY));
	}

	eif_wean (e_currency_array);

	if (old != NULL)
	{
		memcpy (old, currency_array, capacity*(sizeof(CURRENCY)));
		return NULL;
	}
	else
		return currency_array;
};
//----------------------------------------------------------------------------

VARIANT * ecom_runtime_ec::ccom_ec_array_variant (EIF_REFERENCE a_ref, int dimension, VARIANT * old)

// Create C array of VARIANT from Eiffel array.
{
	EIF_OBJECT e_variant_array;

	EIF_TYPE_ID tid;
	EIF_REFERENCE_FUNCTION f_item;
	EIF_INTEGER_FUNCTION f_capacity;

	VARIANT * variant_array;
	VARIANT * p_var;
	int capacity, i;

	e_variant_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[ECOM_VARIANT]");
		f_item = eif_reference_function ("array_item", tid);
	}
	else
	{
		tid = eif_type_id ("ARRAY[ECOM_VARIANT]");
		f_item = eif_reference_function ("item", tid);
	}
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_variant_array));

	variant_array = (VARIANT *) CoTaskMemAlloc (capacity * (sizeof (VARIANT)));

	for (i = 0; i < capacity; i++)
	{
		p_var = ccom_ec_pointed_variant ((f_item)(eif_access(e_variant_array), ((EIF_INTEGER)(i+1))), NULL);
		memcpy (((VARIANT *) variant_array + i), p_var, sizeof (VARIANT));
	}

	eif_wean (e_variant_array);

	if (old != NULL)
	{
		memcpy (old, variant_array, capacity*(sizeof(VARIANT)));
		return NULL;
	}
	else
		return variant_array;
};
//----------------------------------------------------------------------------

DECIMAL * ecom_runtime_ec::ccom_ec_array_decimal (EIF_REFERENCE a_ref, int dimension, DECIMAL * old)

// Create C array of DECIMAL from Eiffel array.
{
	EIF_OBJECT e_decimal_array;

	EIF_TYPE_ID tid;
	EIF_REFERENCE_FUNCTION f_item;
	EIF_INTEGER_FUNCTION f_capacity;

	DECIMAL * decimal_array;
	DECIMAL * p_decimal;
	int capacity, i;

	e_decimal_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[ECOM_DECIMAL]");
		f_item = eif_reference_function ("array_item", tid);
	}
	else
	{
		tid = eif_type_id ("ARRAY[ECOM_DECIMAL]");
		f_item = eif_reference_function ("item", tid);
	}
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_decimal_array));

	decimal_array = (DECIMAL *) CoTaskMemAlloc (capacity * (sizeof (DECIMAL)));

	for (i = 0; i < capacity; i++)
	{
		p_decimal = ccom_ec_pointed_decimal ((f_item)(eif_access(e_decimal_array), ((EIF_INTEGER)(i+1))), NULL);
		memcpy (((DECIMAL *) decimal_array + i),p_decimal, sizeof (DECIMAL));
	}

	eif_wean (e_decimal_array);

	if (old != NULL)
	{
		memcpy (old, decimal_array, capacity*(sizeof(DECIMAL)));
		return NULL;
	}
	else
		return decimal_array;
};
//----------------------------------------------------------------------------

VARIANT_BOOL * ecom_runtime_ec::ccom_ec_array_boolean (EIF_REFERENCE a_ref, int dimension, VARIANT_BOOL * old)

// Create C array of Boolean from Eiffel array.
{
	EIF_OBJECT e_boolean_array;

	EIF_TYPE_ID tid;
	EIF_BOOLEAN_FUNCTION f_item;
	EIF_INTEGER_FUNCTION f_capacity;

	VARIANT_BOOL * boolean_array;
	VARIANT_BOOL a_bool;
	int capacity, i;

	e_boolean_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[ECOM_BOOLEAN]");
		f_item = eif_boolean_function ("array_item", tid);
	}
	else
	{
		tid = eif_type_id ("ARRAY[ECOM_BOOLEAN]");
		f_item = eif_boolean_function ("item", tid);
	}
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_boolean_array));

	boolean_array = (VARIANT_BOOL *) CoTaskMemAlloc (capacity * (sizeof (VARIANT_BOOL)));

	for (i = 0; i < capacity; i++)
	{
		a_bool = ccom_ec_boolean ((f_item)(eif_access(e_boolean_array), ((EIF_INTEGER)(i+1))));
		ccom_c_array_element (boolean_array, i, VARIANT_BOOL) = a_bool;
	}

	eif_wean (e_boolean_array);

	if (old != NULL)
	{
		memcpy (old, boolean_array, capacity*(sizeof(VARIANT_BOOL)));
		return NULL;
	}
	else
		return boolean_array;
};
//-----------------------------------------------------------------------

LARGE_INTEGER * ecom_runtime_ec::ccom_ec_array_long_long (EIF_REFERENCE a_ref, int dimension, LARGE_INTEGER * old)

// Create C array of LARGE_INTEGER from Eiffel array.
{
	EIF_OBJECT e_large_integer_array;

	EIF_TYPE_ID tid;
	EIF_REFERENCE_FUNCTION f_item;
	EIF_INTEGER_FUNCTION f_capacity;

	LARGE_INTEGER * int_array;
	LARGE_INTEGER * p_int;

	int capacity, i;

	e_large_integer_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[ECOM_LARGE_INTEGER]");
		f_item = eif_reference_function ("array_item", tid);
	}
	else
	{
		tid = eif_type_id ("ARRAY[ECOM_LARGE_INTEGER]");
		f_item = eif_reference_function ("item", tid);
	}
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_large_integer_array));

	int_array = (LARGE_INTEGER *) CoTaskMemAlloc (capacity * (sizeof (LARGE_INTEGER)));

	for (i = 0; i < capacity; i++)
	{
		p_int = ccom_ec_pointed_long_long ((f_item)(eif_access(e_large_integer_array), ((EIF_INTEGER)(i+1))), NULL);
		memcpy ((LARGE_INTEGER *) int_array, p_int, sizeof (LARGE_INTEGER));
	}

	eif_wean (e_large_integer_array);

	if (old != NULL)
	{
		memcpy (old, int_array, capacity*(sizeof(LARGE_INTEGER)));
		return NULL;
	}
	else
		return int_array;
};
//-----------------------------------------------------------------------

ULARGE_INTEGER * ecom_runtime_ec::ccom_ec_array_ulong_long (EIF_REFERENCE a_ref, int dimension, ULARGE_INTEGER * old)

// Create C array of ULARGE_INTEGER from Eiffel array.
{
	EIF_OBJECT e_ularge_integer_array;

	EIF_TYPE_ID tid;
	EIF_REFERENCE_FUNCTION f_item;
	EIF_INTEGER_FUNCTION f_capacity;

	ULARGE_INTEGER * int_array;
	ULARGE_INTEGER * p_int;
	int capacity, i;

	e_ularge_integer_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[ECOM_ULARGE_INTEGER]");
		f_item = eif_reference_function ("array_item", tid);
	}
	else
	{
		tid = eif_type_id ("ARRAY[ECOM_ULARGE_INTEGER]");
		f_item = eif_reference_function ("item", tid);
	}
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_ularge_integer_array));
	int_array = (ULARGE_INTEGER *)CoTaskMemAlloc (capacity * (sizeof (ULARGE_INTEGER)));

	for (i = 0; i < capacity; i++)
	{
		p_int = ccom_ec_pointed_ulong_long ((f_item)(eif_access(e_ularge_integer_array), ((EIF_INTEGER)(i+1))), NULL);
		memcpy ((ULARGE_INTEGER *)int_array, p_int, sizeof (ULARGE_INTEGER));
	}
	eif_wean (e_ularge_integer_array);

	if (old != NULL)
	{
		memcpy (old, int_array, capacity*(sizeof(ULARGE_INTEGER)));
		return NULL;
	}
	else
		return int_array;
};
//------------------------------------------------------------------------------------

IDispatch * ecom_runtime_ec::ccom_ec_array_dispatch (EIF_REFERENCE a_ref, int dimension, IDispatch * old)

// Create C array of IDispatch from Eiffel array.
{
	EIF_OBJECT e_dispatch_array;

	EIF_TYPE_ID tid;
	EIF_REFERENCE_FUNCTION f_item;
	EIF_INTEGER_FUNCTION f_capacity;

	IDispatch * dispatch_array;
	IDispatch * an_interface;
	int capacity, i;

	e_dispatch_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE]");
		f_item = eif_reference_function ("array_item", tid);
	}
	else
	{
		tid = eif_type_id ("ARRAY[ECOM_AUTOMATION_INTERFACE]");
		f_item = eif_reference_function ("item", tid);
	}
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_dispatch_array));

	dispatch_array = (IDispatch *) CoTaskMemAlloc (capacity * (sizeof (IDispatch *)));

	for (i = 0; i < capacity; i++)
	{
		an_interface = ccom_ec_dispatch ((f_item)(eif_access(e_dispatch_array), ((EIF_INTEGER)(i+1))));
		ccom_c_array_element (dispatch_array, i, IDispatch *) = an_interface;
	}

	eif_wean (e_dispatch_array);

	if (old != NULL)
	{
		memcpy (old, dispatch_array, capacity*(sizeof(IDispatch *)));
		return NULL;
	}
	else
		return dispatch_array;
};
//-----------------------------------------------------------------------------------------------

IUnknown * ecom_runtime_ec::ccom_ec_array_unknown (EIF_REFERENCE a_ref, int dimension, IUnknown * old)

// Create C array of IUnknown from Eiffel array.
{
	EIF_OBJECT e_unknown_array;

	EIF_TYPE_ID tid;
	EIF_REFERENCE_FUNCTION f_item;
	EIF_INTEGER_FUNCTION f_capacity;

	IUnknown * unknown_array;
	IUnknown * an_interface;
	int capacity, i;

	e_unknown_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE]");
		f_item = eif_reference_function ("array_item", tid);
	}
	else
	{
		tid = eif_type_id ("ARRAY[ECOM_UNKNOWN_INTERFACE]");
		f_item = eif_reference_function ("item", tid);
	}
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_unknown_array));

	unknown_array = (IUnknown *) CoTaskMemAlloc (capacity * (sizeof (IUnknown *)));

	for (i = 0; i < capacity; i++)
	{
		an_interface = ccom_ec_unknown ((f_item)(eif_access(e_unknown_array), ((EIF_INTEGER)(i+1))));
		ccom_c_array_element (unknown_array, i, IUnknown *) = an_interface;
	}

	eif_wean (e_unknown_array);

	if (old != NULL)
	{
		memcpy (old, unknown_array, capacity*(sizeof(IUnknown *)));
		return NULL;
	}
	else
		return unknown_array;
};
//-------------------------------------------------------------------------------------------

LPWSTR * ecom_runtime_ec::ccom_ec_array_lpwstr (EIF_REFERENCE a_ref, int dimension, LPWSTR * old)

// Create C array of LPWSTR from Eiffel array.
{
	EIF_OBJECT e_lpwstr_array;

	EIF_TYPE_ID tid;
	EIF_REFERENCE_FUNCTION f_item;
	EIF_INTEGER_FUNCTION f_capacity;

	LPWSTR * lpwstr_array;
	LPWSTR a_string;
	int capacity, i;

	e_lpwstr_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[STRING]");
		f_item = eif_reference_function ("array_item", tid);
	}
	else
	{
		tid = eif_type_id ("ARRAY[STRING]");
		f_item = eif_reference_function ("item", tid);
	}
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_lpwstr_array));

	lpwstr_array = (LPWSTR *)CoTaskMemAlloc (capacity * (sizeof (LPWSTR)));

	for (i = 0; i < capacity; i++)
	{
		a_string = ccom_ec_lpwstr ((f_item)(eif_access(e_lpwstr_array), ((EIF_INTEGER)(i+1))));
		ccom_c_array_element (lpwstr_array, i, LPWSTR) = a_string;
	}

	eif_wean (e_lpwstr_array);

	if (old != NULL)
	{
		memcpy (old, lpwstr_array, capacity*(sizeof(LPWSTR)));
		return NULL;
	}
	else
		return lpwstr_array;
};
//----------------------------------------------------------------------------------------

LPSTR * ecom_runtime_ec::ccom_ec_array_lpstr (EIF_REFERENCE a_ref, int dimension, LPSTR * old)

// Create C array of LPSTR from Eiffel array.
{
	EIF_OBJECT e_lpstr_array;

	EIF_TYPE_ID tid;
	EIF_REFERENCE_FUNCTION f_item;
	EIF_INTEGER_FUNCTION f_capacity;

	LPSTR * lpstr_array;
	LPSTR a_string;
	int capacity, i;

	e_lpstr_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[STRING]");
		f_item = eif_reference_function ("array_item", tid);
	}
	else
	{
		tid = eif_type_id ("ARRAY[STRING]");
		f_item = eif_reference_function ("item", tid);
	}
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_lpstr_array));

	lpstr_array = (LPSTR *) CoTaskMemAlloc (capacity * (sizeof (LPSTR)));

	for (i = 0; i < capacity; i++)
	{
		a_string = ccom_ec_lpstr ((f_item)(eif_access(e_lpstr_array), ((EIF_INTEGER)(i+1))));
		ccom_c_array_element (lpstr_array, i, LPSTR) = a_string;
	}

	eif_wean (e_lpstr_array);

	if (old != NULL)
	{
		memcpy (old, lpstr_array, capacity*(sizeof(LPSTR)));
		return NULL;
	}
	else
		return lpstr_array;
};
//---------------------------------------------------------------------------------------------

BSTR * ecom_runtime_ec::ccom_ec_array_bstr (EIF_REFERENCE a_ref, int dimension, BSTR * old)

// Create C array of BSTR from Eiffel array.
{
	EIF_OBJECT e_bstr_array;

	EIF_TYPE_ID tid;
	EIF_REFERENCE_FUNCTION f_item;
	EIF_INTEGER_FUNCTION f_capacity;

	BSTR * bstr_array;
	BSTR a_string;
	int capacity, i;

	e_bstr_array = eif_protect (a_ref);

	if (dimension > 1)
	{
		tid = eif_type_id ("ECOM_ARRAY[STRING]");
		f_item = eif_reference_function ("array_item", tid);
	}
	else
	{
		tid = eif_type_id ("ARRAY[STRING]");
		f_item = eif_reference_function ("item", tid);
	}
	// Allocate memory
	f_capacity = eif_integer_function ("count", tid);

	capacity = (int)(f_capacity)(eif_access(e_bstr_array));

	bstr_array = (BSTR *)CoTaskMemAlloc (capacity * (sizeof (BSTR)));

	for (i = 0; i < capacity; i++)
	{
		a_string = ccom_ec_bstr ((f_item)(eif_access(e_bstr_array), ((EIF_INTEGER)(i+1))));
		ccom_c_array_element (bstr_array, i, BSTR) = a_string;
	}

	eif_wean (e_bstr_array);

	if (old != NULL)
	{
		memcpy (old, bstr_array, capacity*(sizeof(BSTR)));
		return NULL;
	}
	else
		return bstr_array;
};
//------------------------------------------------------------------------------------

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_char (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
	EIF_OBJECT eif_safe_array;
	EIF_TYPE_ID ecom_array_tid, int_array_tid;
	EIF_INTEGER * lower_indexes, * element_counts, * upper_indexes;
	EIF_INTEGER * tmp_index;
	int dimensions, loop_control, i;
	EIF_POINTER_FUNCTION f_to_c;
	EIF_OBJECT tmp_object1, tmp_object2, tmp_object3, eif_index;
	SAFEARRAYBOUND * array_bound;
	SAFEARRAY * c_safe_array;
	EIF_CHARACTER_FUNCTION f_array_item;
	EIF_PROCEDURE p_array_create, p_array_put;
	long * c_index;
	char an_element;
	HRESULT hr;

	// protect eiffel object
	eif_safe_array = eif_protect (a_ref);


	// get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

	ecom_array_tid = eif_type_id ("ECOM_ARRAY [CHARACTER]");
	int_array_tid = eif_type_id ("ARRAY [INTEGER]");

	dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


	f_to_c = eif_pointer_function ("to_c", int_array_tid);

	tmp_object1 = eif_protect (eif_field (eif_access (eif_safe_array), "lower_indeces", EIF_REFERENCE));
	lower_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object1)));

	tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
	element_counts = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object2)));

	tmp_object3 = eif_protect (eif_field(eif_access (eif_safe_array), "upper_indeces", EIF_REFERENCE));
	upper_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object3)));

	// create SAFEARRAYBOUND
	array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

	for (i = 0; i < dimensions; i++)
	{
		array_bound[i].lLbound  = (long) lower_indexes [i];
		array_bound[i].cElements  = (long) element_counts [i];
	}

	// Create SAFEARRAY
	c_safe_array = SafeArrayCreate (VT_I1, dimensions, array_bound);
	if (c_safe_array == NULL)
	{
		enomem ();
	};

	f_array_item = eif_character_function ("item", ecom_array_tid);
	p_array_create = eif_procedure ("make", int_array_tid);
	p_array_put = eif_procedure ("put", int_array_tid);

	// Create index to access Eiffel object
	eif_index = eif_create (int_array_tid);
	(p_array_create) (eif_access (eif_index), 1, dimensions);

	// create index to access C object
	c_index = (long *)malloc (dimensions * sizeof (long));

	tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
	memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

	//
	// copy elements from eiffel array to c array
	do
	{
		eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

		for (i = 0; i < dimensions; i++)
		{
			c_index[i] = (long) tmp_index [dimensions - i - 1];
		}
		an_element = (char)(f_array_item)(eif_access (eif_safe_array), eif_access (eif_index));
		hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}

		loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
	} while (loop_control != 0);

	// free memory
	free (array_bound);
	free (c_index);
	free (tmp_index);
	eif_wean (tmp_object1);
	eif_wean (tmp_object2);
	eif_wean (tmp_object3);
	eif_wean (eif_index);
	eif_wean (eif_safe_array);

	return c_safe_array;
};
//-----------------------------------------------------------------------------------

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_float (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
	EIF_OBJECT eif_safe_array;
	EIF_TYPE_ID ecom_array_tid, int_array_tid;
	EIF_INTEGER * lower_indexes, * element_counts, * upper_indexes;
	EIF_INTEGER * tmp_index;
	int dimensions, loop_control, i;
	EIF_POINTER_FUNCTION f_to_c;
	EIF_OBJECT tmp_object1, tmp_object2, tmp_object3, eif_index;
	SAFEARRAYBOUND * array_bound;
	SAFEARRAY * c_safe_array;
	EIF_REAL_FUNCTION f_array_item;
	EIF_PROCEDURE p_array_create, p_array_put;
	long * c_index;
	float a_float;
	HRESULT hr;

	// protect eiffel object
	eif_safe_array = eif_protect (a_ref);

	// get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

	ecom_array_tid = eif_type_id ("ECOM_ARRAY[REAL]");
	int_array_tid = eif_type_id ("ARRAY[INTEGER]");

	dimensions = (int) eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


	f_to_c = eif_pointer_function ("to_c", int_array_tid);

	tmp_object1 = eif_protect (eif_field (eif_access (eif_safe_array), "lower_indeces", EIF_REFERENCE));
	lower_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object1)));

	tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
	element_counts = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object2)));

	tmp_object3 = eif_protect (eif_field (eif_access (eif_safe_array), "upper_indeces", EIF_REFERENCE));
	upper_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object3)));

	// create SAFEARRAYBOUND
	array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

	for (i = 0; i < dimensions; i++)
	{
		array_bound[i].lLbound  = (long) lower_indexes [i];
		array_bound[i].cElements  = (long) element_counts [i];
	}

	// Create SAFEARRAY
	c_safe_array = SafeArrayCreate (VT_R4, dimensions, array_bound);
	if (c_safe_array == NULL)
	{
		enomem ();
	};

	f_array_item = eif_real_function ("item", ecom_array_tid);
	p_array_create = eif_procedure ("make", int_array_tid);
	p_array_put = eif_procedure ("put", int_array_tid);

	// Create index to access Eiffel object
	eif_index = eif_create (int_array_tid);
	(p_array_create) (eif_access (eif_index), 1, dimensions);

	// create index to access C object
	c_index = (long *)malloc (dimensions * sizeof (long));

	tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
	memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

	//
	// copy elements from eiffel array to c array
	do
	{
		eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

		for (i = 0; i < dimensions; i++)
		{
			c_index[i] = (long) tmp_index [dimensions - i - 1];
		}
		a_float = (float)(f_array_item)(eif_access (eif_safe_array), eif_access (eif_index));
		hr = SafeArrayPutElement(c_safe_array, c_index, &a_float);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}

		loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
	} while (loop_control != 0);

	// free memory
	free (array_bound);
	free (c_index);
	free (tmp_index);
	eif_wean (tmp_object1);
	eif_wean (tmp_object2);
	eif_wean (tmp_object3);
	eif_wean (eif_index);
	eif_wean (eif_safe_array);

	return c_safe_array;
};
//-----------------------------------------------------------------------------------

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_long (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
	EIF_OBJECT eif_safe_array;
	EIF_TYPE_ID ecom_array_tid, int_array_tid;
	EIF_INTEGER * lower_indexes, * element_counts, * upper_indexes;
	EIF_INTEGER * tmp_index;
	int dimensions, loop_control, i;
	EIF_POINTER_FUNCTION f_to_c;
	EIF_OBJECT tmp_object1, tmp_object2, tmp_object3, eif_index;
	SAFEARRAYBOUND * array_bound;
	SAFEARRAY * c_safe_array;
	EIF_INTEGER_FUNCTION f_array_item;
	EIF_PROCEDURE p_array_create, p_array_put;
	long * c_index;
	long an_element;
	HRESULT hr;

	// protect eiffel object
	eif_safe_array = eif_protect (a_ref);


	// get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

	ecom_array_tid = eif_type_id ("ECOM_ARRAY [INTEGER]");
	int_array_tid = eif_type_id ("ARRAY [INTEGER]");

	dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


	f_to_c = eif_pointer_function ("to_c", int_array_tid);

	tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indeces", EIF_REFERENCE));
	lower_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object1)));

	tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
	element_counts = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object2)));

	tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indeces", EIF_REFERENCE));
	upper_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object3)));

	// create SAFEARRAYBOUND
	array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

	for (i = 0; i < dimensions; i++)
	{
		array_bound[i].lLbound  = (long) lower_indexes [i];
		array_bound[i].cElements  = (long) element_counts [i];
	}

	// Create SAFEARRAY
	c_safe_array = SafeArrayCreate (VT_I4, dimensions, array_bound);
	if (c_safe_array == NULL)
	{
		enomem ();
	};

	f_array_item = eif_integer_function ("item", ecom_array_tid);
	p_array_create = eif_procedure ("make", int_array_tid);
	p_array_put = eif_procedure ("put", int_array_tid);

	// Create index to access Eiffel object
	eif_index = eif_create (int_array_tid);
	(p_array_create) (eif_access (eif_index), 1, dimensions);

	// create index to access C object
	c_index = (long *)malloc (dimensions * sizeof (long));

	tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
	memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

	//
	// copy elements from eiffel array to c array
	do
	{
		eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

		for (i = 0; i < dimensions; i++)
		{
			c_index[i] = (long) tmp_index [dimensions - i - 1];
		}
		an_element = (long)(f_array_item)(eif_access (eif_safe_array), eif_access (eif_index));
		hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}

		loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
	} while (loop_control != 0);

	// free memory
	free (array_bound);
	free (c_index);
	free (tmp_index);
	eif_wean (tmp_object1);
	eif_wean (tmp_object2);
	eif_wean (tmp_object3);
	eif_wean (eif_index);
	eif_wean (eif_safe_array);

	return c_safe_array;
};
//-----------------------------------------------------------------------------------

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_short (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
	EIF_OBJECT eif_safe_array;
	EIF_TYPE_ID ecom_array_tid, int_array_tid;
	EIF_INTEGER * lower_indexes, * element_counts, * upper_indexes;
	EIF_INTEGER * tmp_index;
	int dimensions, loop_control, i;
	EIF_POINTER_FUNCTION f_to_c;
	EIF_OBJECT tmp_object1, tmp_object2, tmp_object3, eif_index;
	SAFEARRAYBOUND * array_bound;
	SAFEARRAY * c_safe_array;
	EIF_INTEGER_FUNCTION f_array_item;
	EIF_PROCEDURE p_array_create, p_array_put;
	long * c_index;
	short an_element;
	HRESULT hr;

	// protect eiffel object
	eif_safe_array = eif_protect (a_ref);


	// get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

	ecom_array_tid = eif_type_id ("ECOM_ARRAY [INTEGER]");
	int_array_tid = eif_type_id ("ARRAY [INTEGER]");

	dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


	f_to_c = eif_pointer_function ("to_c", int_array_tid);

	tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indeces", EIF_REFERENCE));
	lower_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object1)));

	tmp_object2 = eif_protect ( eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
	element_counts = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object2)));

	tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indeces", EIF_REFERENCE));
	upper_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object3)));

	// create SAFEARRAYBOUND
	array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

	for (i = 0; i < dimensions; i++)
	{
		array_bound[i].lLbound  = (long) lower_indexes [i];
		array_bound[i].cElements  = (long) element_counts [i];
	}

	// Create SAFEARRAY
	c_safe_array = SafeArrayCreate (VT_I2, dimensions, array_bound);
	if (c_safe_array == NULL)
	{
		enomem ();
	};

	f_array_item = eif_integer_function ("item", ecom_array_tid);
	p_array_create = eif_procedure ("make", int_array_tid);
	p_array_put = eif_procedure ("put", int_array_tid);

	// Create index to access Eiffel object
	eif_index = eif_create (int_array_tid);
	(p_array_create) (eif_access (eif_index), 1, dimensions);

	// create index to access C object
	c_index = (long *)malloc (dimensions * sizeof (long));

	tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
	memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

	//
	// copy elements from eiffel array to c array
	do
	{
		eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

		for (i = 0; i < dimensions; i++)
		{
			c_index[i] = (long) tmp_index [dimensions - i - 1];
		}
		an_element = (short)(f_array_item)(eif_access (eif_safe_array), eif_access (eif_index));
		hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}

		loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
	} while (loop_control != 0);

	// free memory
	free (array_bound);
	free (c_index);
	free (tmp_index);
	eif_wean (tmp_object1);
	eif_wean (tmp_object2);
	eif_wean (tmp_object3);
	eif_wean (eif_index);
	eif_wean (eif_safe_array);

	return c_safe_array;
};
//-----------------------------------------------------------------------------------

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_double (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
	EIF_OBJECT eif_safe_array;
	EIF_TYPE_ID ecom_array_tid, int_array_tid;
	EIF_INTEGER * lower_indexes, * element_counts, * upper_indexes;
	EIF_INTEGER * tmp_index;
	int dimensions, loop_control, i;
	EIF_POINTER_FUNCTION f_to_c;
	EIF_OBJECT tmp_object1, tmp_object2, tmp_object3, eif_index;
	SAFEARRAYBOUND * array_bound;
	SAFEARRAY * c_safe_array;
	EIF_DOUBLE_FUNCTION f_array_item;
	EIF_PROCEDURE p_array_create, p_array_put;
	long * c_index;
	double an_element;
	HRESULT hr;

	// protect eiffel object
	eif_safe_array = eif_protect (a_ref);


	// get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

	ecom_array_tid = eif_type_id ("ECOM_ARRAY [DOUBLE]");
	int_array_tid = eif_type_id ("ARRAY [INTEGER]");

	dimensions = (int) eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


	f_to_c = eif_pointer_function ("to_c", int_array_tid);

	tmp_object1 = eif_protect ( eif_field(eif_access (eif_safe_array), "lower_indeces", EIF_REFERENCE));
	lower_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object1)));

	tmp_object2 = eif_protect ( eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
	element_counts = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object2)));

	tmp_object3 = eif_protect (eif_field(eif_access (eif_safe_array), "upper_indeces", EIF_REFERENCE));
	upper_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object3)));

	// create SAFEARRAYBOUND
	array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

	for (i = 0; i < dimensions; i++)
	{
		array_bound[i].lLbound  = (long) lower_indexes [i];
		array_bound[i].cElements  = (long) element_counts [i];
	}

	// Create SAFEARRAY
	c_safe_array = SafeArrayCreate (VT_R8, dimensions, array_bound);
	if (c_safe_array == NULL)
	{
		enomem ();
	};

	f_array_item = eif_double_function ("item", ecom_array_tid);
	p_array_create = eif_procedure ("make", int_array_tid);
	p_array_put = eif_procedure ("put", int_array_tid);

	// Create index to access Eiffel object
	eif_index = eif_create (int_array_tid);
	(p_array_create) (eif_access (eif_index), 1, dimensions);

	// create index to access C object
	c_index = (long *)malloc (dimensions * sizeof (long));

	tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
	memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

	//
	// copy elements from eiffel array to c array
	do
	{
		eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

		for (i = 0; i < dimensions; i++)
		{
			c_index[i] = (long) tmp_index [dimensions - i - 1];
		}
		an_element = (double)(f_array_item)(eif_access (eif_safe_array), eif_access (eif_index));
		hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}

		loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
	} while (loop_control != 0);

	// free memory
	free (array_bound);
	free (c_index);
	free (tmp_index);
	eif_wean (tmp_object1);
	eif_wean (tmp_object2);
	eif_wean (tmp_object3);
	eif_wean (eif_index);
	eif_wean (eif_safe_array);

	return c_safe_array;
};
//-----------------------------------------------------------------------------------

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_boolean (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
	EIF_OBJECT eif_safe_array;
	EIF_TYPE_ID ecom_array_tid, int_array_tid;
	EIF_INTEGER * lower_indexes, * element_counts, * upper_indexes;
	EIF_INTEGER * tmp_index;
	int dimensions, loop_control, i;
	EIF_POINTER_FUNCTION f_to_c;
	EIF_OBJECT tmp_object1, tmp_object2, tmp_object3, eif_index;
	SAFEARRAYBOUND * array_bound;
	SAFEARRAY * c_safe_array;
	EIF_BOOLEAN_FUNCTION f_array_item;
	EIF_PROCEDURE p_array_create, p_array_put;
	long * c_index;
	VARIANT_BOOL an_element;
	HRESULT hr;

	// protect eiffel object
	eif_safe_array = eif_protect (a_ref);


	// get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

	ecom_array_tid = eif_type_id ("ECOM_ARRAY [BOOLEAN]");
	int_array_tid = eif_type_id ("ARRAY [INTEGER]");

	dimensions = (int) eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


	f_to_c = eif_pointer_function ("to_c", int_array_tid);

	tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indeces", EIF_REFERENCE));
	lower_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object1)));

	tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
	element_counts = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object2)));

	tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indeces", EIF_REFERENCE));
	upper_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object3)));

	// create SAFEARRAYBOUND
	array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

	for (i = 0; i < dimensions; i++)
	{
		array_bound[i].lLbound  = (long) lower_indexes [i];
		array_bound[i].cElements  = (long) element_counts [i];
	}

	// Create SAFEARRAY
	c_safe_array = SafeArrayCreate (VT_BOOL, dimensions, array_bound);
	if (c_safe_array == NULL)
	{
		enomem ();
	};

	f_array_item = eif_boolean_function ("item", ecom_array_tid);
	p_array_create = eif_procedure ("make", int_array_tid);
	p_array_put = eif_procedure ("put", int_array_tid);

	// Create index to access Eiffel object
	eif_index = eif_create (int_array_tid);
	(p_array_create) (eif_access (eif_index), 1, dimensions);

	// create index to access C object
	c_index = (long *)malloc (dimensions * sizeof (long));

	tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
	memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

	//
	// copy elements from eiffel array to c array
	do
	{
		eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

		for (i = 0; i < dimensions; i++)
		{
			c_index[i] = (long) tmp_index [dimensions - i - 1];
		}
		an_element = ccom_ec_boolean (f_array_item(eif_access (eif_safe_array), eif_access (eif_index)));
		hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}

		loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
	} while (loop_control != 0);

	// free memory
	free (array_bound);
	free (c_index);
	free (tmp_index);
	eif_wean (tmp_object1);
	eif_wean (tmp_object2);
	eif_wean (tmp_object3);
	eif_wean (eif_index);
	eif_wean (eif_safe_array);

	return c_safe_array;
};
//-----------------------------------------------------------------------------------

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_date (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
	EIF_OBJECT eif_safe_array;
	EIF_TYPE_ID ecom_array_tid, int_array_tid;
	EIF_INTEGER * lower_indexes, * element_counts, * upper_indexes;
	EIF_INTEGER * tmp_index;
	int dimensions, loop_control, i;
	EIF_POINTER_FUNCTION f_to_c;
	EIF_OBJECT tmp_object1, tmp_object2, tmp_object3, eif_index;
	SAFEARRAYBOUND * array_bound;
	SAFEARRAY * c_safe_array;
	EIF_REFERENCE_FUNCTION f_array_item;
	EIF_PROCEDURE p_array_create, p_array_put;
	long * c_index;
	DATE an_element;
	HRESULT hr;

	// protect eiffel object
	eif_safe_array = eif_protect (a_ref);


	// get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

	ecom_array_tid = eif_type_id ("ECOM_ARRAY [DATE_TIME]");
	int_array_tid = eif_type_id ("ARRAY [INTEGER]");

	dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


	f_to_c = eif_pointer_function ("to_c", int_array_tid);

	tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indeces", EIF_REFERENCE));
	lower_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object1)));

	tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
	element_counts = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object2)));

	tmp_object3 = eif_protect (eif_field (eif_access (eif_safe_array), "upper_indeces", EIF_REFERENCE));
	upper_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object3)));

	// create SAFEARRAYBOUND
	array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

	for (i = 0; i < dimensions; i++)
	{
		array_bound[i].lLbound  = (long) lower_indexes [i];
		array_bound[i].cElements  = (long) element_counts [i];
	}

	// Create SAFEARRAY
	c_safe_array = SafeArrayCreate (VT_DATE, dimensions, array_bound);
	if (c_safe_array == NULL)
	{
		enomem ();
	};

	f_array_item = eif_reference_function ("item", ecom_array_tid);
	p_array_create = eif_procedure ("make", int_array_tid);
	p_array_put = eif_procedure ("put", int_array_tid);

	// Create index to access Eiffel object
	eif_index = eif_create (int_array_tid);
	(p_array_create) (eif_access (eif_index), 1, dimensions);

	// create index to access C object
	c_index = (long *)malloc (dimensions * sizeof (long));

	tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
	memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

	//
	// copy elements from eiffel array to c array
	do
	{
		eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

		for (i = 0; i < dimensions; i++)
		{
			c_index[i] = (long) tmp_index [dimensions - i - 1];
		}
		an_element = ccom_ec_date (f_array_item(eif_access (eif_safe_array), eif_access (eif_index)));
		hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}

		loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
	} while (loop_control != 0);

	// free memory
	free (array_bound);
	free (c_index);
	free (tmp_index);
	eif_wean (tmp_object1);
	eif_wean (tmp_object2);
	eif_wean (tmp_object3);
	eif_wean (eif_index);
	eif_wean (eif_safe_array);

	return c_safe_array;
};
//-----------------------------------------------------------------------------------

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_hresult (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
	EIF_OBJECT eif_safe_array;
	EIF_TYPE_ID ecom_array_tid, int_array_tid;
	EIF_INTEGER * lower_indexes, * element_counts, * upper_indexes;
	EIF_INTEGER * tmp_index;
	int dimensions, loop_control, i;
	EIF_POINTER_FUNCTION f_to_c;
	EIF_OBJECT tmp_object1, tmp_object2, tmp_object3, eif_index;
	SAFEARRAYBOUND * array_bound;
	SAFEARRAY * c_safe_array;
	EIF_REFERENCE_FUNCTION f_array_item;
	EIF_PROCEDURE p_array_create, p_array_put;
	long * c_index;
	HRESULT an_element;
	HRESULT hr;

	// protect eiffel object
	eif_safe_array = eif_protect (a_ref);


	// get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

	ecom_array_tid = eif_type_id ("ECOM_ARRAY [ECOM_HRESULT]");
	int_array_tid = eif_type_id ("ARRAY [INTEGER]");

	dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


	f_to_c = eif_pointer_function ("to_c", int_array_tid);

	tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indeces", EIF_REFERENCE));
	lower_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object1)));

	tmp_object2 = eif_protect ( eif_field(eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
	element_counts = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object2)));

	tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indeces", EIF_REFERENCE));
	upper_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object3)));

	// create SAFEARRAYBOUND
	array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

	for (i = 0; i < dimensions; i++)
	{
		array_bound[i].lLbound  = (long) lower_indexes [i];
		array_bound[i].cElements  = (long) element_counts [i];
	}

	// Create SAFEARRAY
	c_safe_array = SafeArrayCreate (VT_HRESULT, dimensions, array_bound);
	if (c_safe_array == NULL)
	{
		enomem ();
	};

	f_array_item = eif_reference_function ("item", ecom_array_tid);
	p_array_create = eif_procedure ("make", int_array_tid);
	p_array_put = eif_procedure ("put", int_array_tid);

	// Create index to access Eiffel object
	eif_index = eif_create (int_array_tid);
	(p_array_create) (eif_access (eif_index), 1, dimensions);

	// create index to access C object
	c_index = (long *)malloc (dimensions * sizeof (long));

	tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
	memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

	//
	// copy elements from eiffel array to c array
	do
	{
		eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

		for (i = 0; i < dimensions; i++)
		{
			c_index[i] = (long) tmp_index [dimensions - i - 1];
		}
		an_element = ccom_ec_hresult (f_array_item(eif_access (eif_safe_array), eif_access (eif_index)));
		hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}

		loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
	} while (loop_control != 0);

	// free memory
	free (array_bound);
	free (c_index);
	free (tmp_index);
	eif_wean (tmp_object1);
	eif_wean (tmp_object2);
	eif_wean (tmp_object3);
	eif_wean (eif_index);
	eif_wean (eif_safe_array);

	return c_safe_array;
};
//-----------------------------------------------------------------------------------

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_variant (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
	EIF_OBJECT eif_safe_array;
	EIF_TYPE_ID ecom_array_tid, int_array_tid;
	EIF_INTEGER * lower_indexes, * element_counts, * upper_indexes;
	EIF_INTEGER * tmp_index;
	int dimensions, loop_control, i;
	EIF_POINTER_FUNCTION f_to_c;
	EIF_OBJECT tmp_object1, tmp_object2, tmp_object3, eif_index;
	SAFEARRAYBOUND * array_bound;
	SAFEARRAY * c_safe_array;
	EIF_REFERENCE_FUNCTION f_array_item;
	EIF_PROCEDURE p_array_create, p_array_put;
	long * c_index;
	VARIANT * an_element;
	HRESULT hr;

	// protect eiffel object
	eif_safe_array = eif_protect (a_ref);


	// get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

	ecom_array_tid = eif_type_id ("ECOM_ARRAY [ECOM_VARIANT]");
	int_array_tid = eif_type_id ("ARRAY [INTEGER]");

	dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);

	f_to_c = eif_pointer_function ("to_c", int_array_tid);

	tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indeces", EIF_REFERENCE));
	lower_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object1)));

	tmp_object2 = eif_protect ( eif_field(eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
	element_counts = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object2)));

	tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indeces", EIF_REFERENCE));
	upper_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object3)));

	// create SAFEARRAYBOUND
	array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

	for (i = 0; i < dimensions; i++)
	{
		array_bound[i].lLbound  = (long) lower_indexes [i];
		array_bound[i].cElements  = (long) element_counts [i];
	}

	// Create SAFEARRAY
	c_safe_array = SafeArrayCreate (VT_VARIANT, dimensions, array_bound);
	if (c_safe_array == NULL)
	{
		enomem ();
	};

	f_array_item = eif_reference_function ("item", ecom_array_tid);
	p_array_create = eif_procedure ("make", int_array_tid);
	p_array_put = eif_procedure ("put", int_array_tid);

	// Create index to access Eiffel object
	eif_index = eif_create (int_array_tid);
	(p_array_create) (eif_access (eif_index), 1, dimensions);

	// create index to access C object
	c_index = (long *)malloc (dimensions * sizeof (long));

	tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
	memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

	//
	// copy elements from eiffel array to c array
	do
	{
		eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

		for (i = 0; i < dimensions; i++)
		{
			c_index[i] = (long) tmp_index [dimensions - i - 1];
		}
		an_element = ccom_ec_pointed_variant (f_array_item(eif_access (eif_safe_array), eif_access (eif_index)), NULL);
		hr = SafeArrayPutElement(c_safe_array, c_index, an_element);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}

		loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
	} while (loop_control != 0);

	// free memory
	free (array_bound);
	free (c_index);
	free (tmp_index);
	eif_wean (tmp_object1);
	eif_wean (tmp_object2);
	eif_wean (tmp_object3);
	eif_wean (eif_index);
	eif_wean (eif_safe_array);

	return c_safe_array;
};
//-----------------------------------------------------------------------------------

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_currency (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
	EIF_OBJECT eif_safe_array;
	EIF_TYPE_ID ecom_array_tid, int_array_tid;
	EIF_INTEGER * lower_indexes, * element_counts, * upper_indexes;
	EIF_INTEGER * tmp_index;
	int dimensions, loop_control, i;
	EIF_POINTER_FUNCTION f_to_c;
	EIF_OBJECT tmp_object1, tmp_object2, tmp_object3, eif_index;
	SAFEARRAYBOUND * array_bound;
	SAFEARRAY * c_safe_array;
	EIF_REFERENCE_FUNCTION f_array_item;
	EIF_PROCEDURE p_array_create, p_array_put;
	long * c_index;
	CURRENCY * an_element;
	HRESULT hr;

	// protect eiffel object
	eif_safe_array = eif_protect (a_ref);


	// get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

	ecom_array_tid = eif_type_id ("ECOM_ARRAY [ECOM_CURRENCY]");
	int_array_tid = eif_type_id ("ARRAY [INTEGER]");

	dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);

	f_to_c = eif_pointer_function ("to_c", int_array_tid);

	tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indeces", EIF_REFERENCE));
	lower_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object1)));

	tmp_object2 = eif_protect ( eif_field(eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
	element_counts = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object2)));

	tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indeces", EIF_REFERENCE));
	upper_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object3)));

	// create SAFEARRAYBOUND
	array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

	for (i = 0; i < dimensions; i++)
	{
		array_bound[i].lLbound  = (long) lower_indexes [i];
		array_bound[i].cElements  = (long) element_counts [i];
	}

	// Create SAFEARRAY
	c_safe_array = SafeArrayCreate (VT_CY, dimensions, array_bound);
	if (c_safe_array == NULL)
	{
		enomem ();
	};

	f_array_item = eif_reference_function ("item", ecom_array_tid);
	p_array_create = eif_procedure ("make", int_array_tid);
	p_array_put = eif_procedure ("put", int_array_tid);

	// Create index to access Eiffel object
	eif_index = eif_create (int_array_tid);
	(p_array_create) (eif_access (eif_index), 1, dimensions);

	// create index to access C object
	c_index = (long *)malloc (dimensions * sizeof (long));

	tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
	memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

	//
	// copy elements from eiffel array to c array
	do
	{
		eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

		for (i = 0; i < dimensions; i++)
		{
			c_index[i] = (long) tmp_index [dimensions - i - 1];
		}
		an_element = ccom_ec_pointed_currency (f_array_item(eif_access (eif_safe_array), eif_access (eif_index)), NULL);
		hr = SafeArrayPutElement(c_safe_array, c_index, an_element);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}

		loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
	} while (loop_control != 0);

	// free memory
	free (array_bound);
	free (c_index);
	free (tmp_index);
	eif_wean (tmp_object1);
	eif_wean (tmp_object2);
	eif_wean (tmp_object3);
	eif_wean (eif_index);
	eif_wean (eif_safe_array);

	return c_safe_array;
};
//-----------------------------------------------------------------------------------

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_decimal (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
	EIF_OBJECT eif_safe_array;
	EIF_TYPE_ID ecom_array_tid, int_array_tid;
	EIF_INTEGER * lower_indexes, * element_counts, * upper_indexes;
	EIF_INTEGER * tmp_index;
	int dimensions, loop_control, i;
	EIF_POINTER_FUNCTION f_to_c;
	EIF_OBJECT tmp_object1, tmp_object2, tmp_object3, eif_index;
	SAFEARRAYBOUND * array_bound;
	SAFEARRAY * c_safe_array;
	EIF_REFERENCE_FUNCTION f_array_item;
	EIF_PROCEDURE p_array_create, p_array_put;
	long * c_index;
	DECIMAL * an_element;
	HRESULT hr;

	// protect eiffel object
	eif_safe_array = eif_protect (a_ref);


	// get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

	ecom_array_tid = eif_type_id ("ECOM_ARRAY [ECOM_DECIMAL]");
	int_array_tid = eif_type_id ("ARRAY [INTEGER]");

	dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);

	f_to_c = eif_pointer_function ("to_c", int_array_tid);

	tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indeces", EIF_REFERENCE));
	lower_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object1)));

	tmp_object2 = eif_protect ( eif_field(eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
	element_counts = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object2)));

	tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indeces", EIF_REFERENCE));
	upper_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object3)));

	// create SAFEARRAYBOUND
	array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

	for (i = 0; i < dimensions; i++)
	{
		array_bound[i].lLbound  = (long) lower_indexes [i];
		array_bound[i].cElements  = (long) element_counts [i];
	}

	// Create SAFEARRAY
	c_safe_array = SafeArrayCreate (VT_DECIMAL, dimensions, array_bound);
	if (c_safe_array == NULL)
	{
		enomem ();
	};

	f_array_item = eif_reference_function ("item", ecom_array_tid);
	p_array_create = eif_procedure ("make", int_array_tid);
	p_array_put = eif_procedure ("put", int_array_tid);

	// Create index to access Eiffel object
	eif_index = eif_create (int_array_tid);
	(p_array_create) (eif_access (eif_index), 1, dimensions);

	// create index to access C object
	c_index = (long *)malloc (dimensions * sizeof (long));

	tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
	memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

	//
	// copy elements from eiffel array to c array
	do
	{
		eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

		for (i = 0; i < dimensions; i++)
		{
			c_index[i] = (long) tmp_index [dimensions - i - 1];
		}
		an_element = ccom_ec_pointed_decimal (f_array_item(eif_access (eif_safe_array), eif_access (eif_index)), NULL);
		hr = SafeArrayPutElement(c_safe_array, c_index, an_element);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}

		loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
	} while (loop_control != 0);

	// free memory
	free (array_bound);
	free (c_index);
	free (tmp_index);
	eif_wean (tmp_object1);
	eif_wean (tmp_object2);
	eif_wean (tmp_object3);
	eif_wean (eif_index);
	eif_wean (eif_safe_array);

	return c_safe_array;
};
//-----------------------------------------------------------------------------------

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_bstr (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
	EIF_OBJECT eif_safe_array;
	EIF_TYPE_ID ecom_array_tid, int_array_tid;
	EIF_INTEGER * lower_indexes, * element_counts, * upper_indexes;
	EIF_INTEGER * tmp_index;
	int dimensions, loop_control, i;
	EIF_POINTER_FUNCTION f_to_c;
	EIF_OBJECT tmp_object1, tmp_object2, tmp_object3, eif_index;
	SAFEARRAYBOUND * array_bound;
	SAFEARRAY * c_safe_array;
	EIF_REFERENCE_FUNCTION f_array_item;
	EIF_PROCEDURE p_array_create, p_array_put;
	long * c_index;
	BSTR an_element;
	HRESULT hr;

	// protect eiffel object
	eif_safe_array = eif_protect (a_ref);


	// get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

	ecom_array_tid = eif_type_id ("ECOM_ARRAY [STRING]");
	int_array_tid = eif_type_id ("ARRAY [INTEGER]");

	dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);

	f_to_c = eif_pointer_function ("to_c", int_array_tid);

	tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indeces", EIF_REFERENCE));
	lower_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object1)));

	tmp_object2 = eif_protect ( eif_field(eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
	element_counts = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object2)));

	tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indeces", EIF_REFERENCE));
	upper_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object3)));

	// create SAFEARRAYBOUND
	array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

	for (i = 0; i < dimensions; i++)
	{
		array_bound[i].lLbound  = (long) lower_indexes [i];
		array_bound[i].cElements  = (long) element_counts [i];
	}

	// Create SAFEARRAY
	c_safe_array = SafeArrayCreate (VT_BSTR, dimensions, array_bound);
	if (c_safe_array == NULL)
	{
		enomem ();
	};

	f_array_item = eif_reference_function ("item", ecom_array_tid);
	p_array_create = eif_procedure ("make", int_array_tid);
	p_array_put = eif_procedure ("put", int_array_tid);

	// Create index to access Eiffel object
	eif_index = eif_create (int_array_tid);
	(p_array_create) (eif_access (eif_index), 1, dimensions);

	// create index to access C object
	c_index = (long *)malloc (dimensions * sizeof (long));

	tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
	memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

	//
	// copy elements from eiffel array to c array
	do
	{
		eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

		for (i = 0; i < dimensions; i++)
		{
			c_index[i] = (long) tmp_index [dimensions - i - 1];
		}
		an_element = ccom_ec_bstr (f_array_item(eif_access (eif_safe_array), eif_access (eif_index)));
		hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}

		loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
	} while (loop_control != 0);

	// free memory
	free (array_bound);
	free (c_index);
	free (tmp_index);
	eif_wean (tmp_object1);
	eif_wean (tmp_object2);
	eif_wean (tmp_object3);
	eif_wean (eif_index);
	eif_wean (eif_safe_array);

	return c_safe_array;
};
//-----------------------------------------------------------------------------------

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_dispatch (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
	EIF_OBJECT eif_safe_array;
	EIF_TYPE_ID ecom_array_tid, int_array_tid;
	EIF_INTEGER * lower_indexes, * element_counts, * upper_indexes;
	EIF_INTEGER * tmp_index;
	int dimensions, loop_control, i;
	EIF_POINTER_FUNCTION f_to_c;
	EIF_OBJECT tmp_object1, tmp_object2, tmp_object3, eif_index;
	SAFEARRAYBOUND * array_bound;
	SAFEARRAY * c_safe_array;
	EIF_REFERENCE_FUNCTION f_array_item;
	EIF_PROCEDURE p_array_create, p_array_put;
	long * c_index;
	IDispatch * an_element;
	HRESULT hr;

	// protect eiffel object
	eif_safe_array = eif_protect (a_ref);


	// get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

	ecom_array_tid = eif_type_id ("ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE]");
	int_array_tid = eif_type_id ("ARRAY [INTEGER]");

	dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);

	f_to_c = eif_pointer_function ("to_c", int_array_tid);

	tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indeces", EIF_REFERENCE));
	lower_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object1)));

	tmp_object2 = eif_protect ( eif_field(eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
	element_counts = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object2)));

	tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indeces", EIF_REFERENCE));
	upper_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object3)));

	// create SAFEARRAYBOUND
	array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

	for (i = 0; i < dimensions; i++)
	{
		array_bound[i].lLbound  = (long) lower_indexes [i];
		array_bound[i].cElements  = (long) element_counts [i];
	}

	// Create SAFEARRAY
	c_safe_array = SafeArrayCreate (VT_DISPATCH, dimensions, array_bound);
	if (c_safe_array == NULL)
	{
		enomem ();
	};

	f_array_item = eif_reference_function ("item", ecom_array_tid);
	p_array_create = eif_procedure ("make", int_array_tid);
	p_array_put = eif_procedure ("put", int_array_tid);

	// Create index to access Eiffel object
	eif_index = eif_create (int_array_tid);
	(p_array_create) (eif_access (eif_index), 1, dimensions);

	// create index to access C object
	c_index = (long *)malloc (dimensions * sizeof (long));

	tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
	memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

	//
	// copy elements from eiffel array to c array
	do
	{
		eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

		for (i = 0; i < dimensions; i++)
		{
			c_index[i] = (long) tmp_index [dimensions - i - 1];
		}
		an_element = ccom_ec_dispatch (f_array_item(eif_access (eif_safe_array), eif_access (eif_index)));
		hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}

		loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
	} while (loop_control != 0);

	// free memory
	free (array_bound);
	free (c_index);
	free (tmp_index);
	eif_wean (tmp_object1);
	eif_wean (tmp_object2);
	eif_wean (tmp_object3);
	eif_wean (eif_index);
	eif_wean (eif_safe_array);

	return c_safe_array;
};
//-----------------------------------------------------------------------------------

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_unknown (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
	EIF_OBJECT eif_safe_array;
	EIF_TYPE_ID ecom_array_tid, int_array_tid;
	EIF_INTEGER * lower_indexes, * element_counts, * upper_indexes;
	EIF_INTEGER * tmp_index;
	int dimensions, loop_control, i;
	EIF_POINTER_FUNCTION f_to_c;
	EIF_OBJECT tmp_object1, tmp_object2, tmp_object3, eif_index;
	SAFEARRAYBOUND * array_bound;
	SAFEARRAY * c_safe_array;
	EIF_REFERENCE_FUNCTION f_array_item;
	EIF_PROCEDURE p_array_create, p_array_put;
	long * c_index;
	IUnknown * an_element;
	HRESULT hr;

	// protect eiffel object
	eif_safe_array = eif_protect (a_ref);


	// get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

	ecom_array_tid = eif_type_id ("ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE]");
	int_array_tid = eif_type_id ("ARRAY [INTEGER]");

	dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);

	f_to_c = eif_pointer_function ("to_c", int_array_tid);

	tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indeces", EIF_REFERENCE));
	lower_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object1)));

	tmp_object2 = eif_protect ( eif_field(eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
	element_counts = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object2)));

	tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indeces", EIF_REFERENCE));
	upper_indexes = (EIF_INTEGER *) ((f_to_c)(eif_access (tmp_object3)));

	// create SAFEARRAYBOUND
	array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

	for (i = 0; i < dimensions; i++)
	{
		array_bound[i].lLbound  = (long) lower_indexes [i];
		array_bound[i].cElements  = (long) element_counts [i];
	}

	// Create SAFEARRAY
	c_safe_array = SafeArrayCreate (VT_UNKNOWN, dimensions, array_bound);
	if (c_safe_array == NULL)
	{
		enomem ();
	};

	f_array_item = eif_reference_function ("item", ecom_array_tid);
	p_array_create = eif_procedure ("make", int_array_tid);
	p_array_put = eif_procedure ("put", int_array_tid);

	// Create index to access Eiffel object
	eif_index = eif_create (int_array_tid);
	(p_array_create) (eif_access (eif_index), 1, dimensions);

	// create index to access C object
	c_index = (long *)malloc (dimensions * sizeof (long));

	tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
	memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

	//
	// copy elements from eiffel array to c array
	do
	{
		eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

		for (i = 0; i < dimensions; i++)
		{
			c_index[i] = (long) tmp_index [dimensions - i - 1];
		}
		an_element = ccom_ec_unknown (f_array_item(eif_access (eif_safe_array), eif_access (eif_index)));
		hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}

		loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
	} while (loop_control != 0);

	// free memory
	free (array_bound);
	free (c_index);
	free (tmp_index);
	eif_wean (tmp_object1);
	eif_wean (tmp_object2);
	eif_wean (tmp_object3);
	eif_wean (eif_index);
	eif_wean (eif_safe_array);

	return c_safe_array;
};
//-----------------------------------------------------------------------------------

void ** ecom_runtime_ec::ccom_ec_pointed_pointer (EIF_REFERENCE eif_ref, void ** old)

// Create pointed pointer from CELL [POINTER].
{
	EIF_OBJECT eif_object;
	void ** result;

	eif_object = eif_protect (eif_ref);

	result = (void **) CoTaskMemAlloc (sizeof (void *));
	* result = (void *) eif_field (eif_access (eif_object), "item", EIF_POINTER);
	eif_wean (eif_object);
	if (old != NULL)
	{
		*old = *result;
		return NULL;
	}
	else
		return result;
};

SCODE * ecom_runtime_ec::ccom_ec_pointed_hresult (SCODE a_hresult)
// create pointed SCODE from SCODE

{
	SCODE * result = (SCODE *)CoTaskMemAlloc(sizeof(SCODE));
	*result = a_hresult;
	return result;
}

//-----------------------------------------------------------------------------------

void ** ecom_runtime_ec::ccom_ec_pointed_c_pointer (void * a_pointer)

// Create pointed pointer from pointer.
{

	void ** result;

	result = (void **) CoTaskMemAlloc (sizeof (void *));
	* result = a_pointer;

	return result;
};
//-----------------------------------------------------------------------------------