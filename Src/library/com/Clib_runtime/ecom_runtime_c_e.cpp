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
#include "ecom_rt_globals.h"

ecom_runtime_ce rt_ce;
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_currency (CURRENCY a_currency)

// Create Eiffel object ECOM_CURRENCY from C	
{
	EIF_OBJECT result;
	EIF_TYPE_ID eif_currency_id;
	EIF_PROC currency_make;
	
	eif_currency_id = eif_type_id ("ECOM_CURRENCY");
	currency_make = eif_proc ("make_by_pointer", eif_currency_id);
	result = eif_create (eif_currency_id);
	currency_make (eif_access (result), (EIF_POINTER)&a_currency);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_date (DATE a_date)

//  Create an Eiffel DATE_TIME object with 'a_date'.  
{
	SYSTEMTIME a_sys_time;
	EIF_TYPE_ID date_tid;
	EIF_PROCEDURE date_make;
	EIF_OBJECT date_object;

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
	EIF_OBJECT result;
	EIF_TYPE_ID type_id;
	EIF_PROCEDURE make;
	
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
		return EIF_FALSE;
	}
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_decimal (DECIMAL a_decimal)

// Create ECOM_DECIMAL from C 
{
	EIF_OBJECT result;
	EIF_TYPE_ID eif_decimal_id;
	EIF_PROC make;
				
	eif_decimal_id = eif_type_id ("ECOM_DECIMAL");
	make = eif_proc ("make_by_pointer", eif_decimal_id);
	result = eif_create (eif_decimal_id);
	make (eif_access (result), (EIF_POINTER)&a_decimal);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_lpstr (LPSTR a_string)

// Create Eiffel STRING from LPSTR	
{
	EIF_OBJ name;
	EIF_TYPE_ID eif_string_id;
	EIF_PROC string_make;
	
	if (a_string != NULL)
	{
		name = henter (RTMS (a_string));
	}
	else
	{
		eif_string_id = eif_type_id ("STRING");
		string_make = eif_proc ("make", eif_string_id);
		name = eif_create (eif_string_id);
		string_make (eif_access (name), 0);
	}
	return eif_wean (name);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_variant (VARIANT * a_variant)

// Create Eiffel ECOM_VARIANT from C
{
	EIF_OBJECT result;
	EIF_TYPE_ID eif_variant_id;
	EIF_PROC make;
	
	eif_variant_id = eif_type_id ("ECOM_VARIANT");
	make = eif_proc ("make_by_pointer", eif_variant_id);
	result = eif_create (eif_variant_id);
	make (eif_access (result), (EIF_POINTER)a_variant);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_unknown (IUnknown * a_unknown)

// Create Eiffel ECOM_GENERIC_INTERFACE from C
{
	EIF_OBJECT result;
	EIF_TYPE_ID eif_id;
	EIF_PROCEDURE make;
	
	eif_id = eif_type_id ("ECOM_GENERIC_INTERFACE");
	make = eif_proc ("make_from_pointer", eif_id);
	result = eif_create (eif_id);
	make (eif_access (result), (EIF_POINTER)a_unknown);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_dispatch (IDispatch * a_dispatch)

// Create Eiffel ECOM_GENERIC_DISPINTERFACE from C
{
	EIF_OBJECT result;
	EIF_TYPE_ID eif_id;
	EIF_PROCEDURE make;
	
	eif_id = eif_type_id ("ECOM_GENERIC_DISPINTERFACE");
	make = eif_proc ("make_from_pointer", eif_id);
	result = eif_create (eif_id);
	make (eif_access (result), (EIF_POINTER)a_dispatch);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_integer (EIF_INTEGER * an_integer)

// Create INTEGER_REF from integer
{
	EIF_OBJECT result;
	EIF_TYPE_ID type_id;
	EIF_PROC set_item;
	
	type_id = eif_type_id ("INTEGER_REF");
	result = eif_create (type_id);
	set_item = eif_proc ("set_item", type_id);
	set_item (eif_access (result), *an_integer);
	
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_real (EIF_REAL * a_real)

// Create REAL_REF from real
{
	EIF_OBJECT result;
	EIF_TYPE_ID type_id;
	EIF_PROC set_item;
		
	type_id = eif_type_id ("REAL_REF");
	result = eif_create (type_id);
	set_item = eif_proc ("set_item", type_id);
	set_item (eif_access (result), *a_real);
	
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_double (EIF_DOUBLE * a_double)

// Create DOUBLE_REF from double
{
	EIF_OBJECT result;
	EIF_TYPE_ID type_id;
	EIF_PROC set_item;
	
	type_id = eif_type_id ("DOUBLE_REF");
	result = eif_create (type_id);
	set_item = eif_proc ("set_item", type_id);
	set_item (eif_access (result), *a_double);
								
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_character (EIF_CHARACTER * a_character)

// Create CHARACTER_REF from character
{
	EIF_OBJECT result;
	EIF_TYPE_ID type_id;
	EIF_PROC set_item;
				
	type_id = eif_type_id ("CHARACTER_REF");
	result = eif_create (type_id);
	set_item = eif_proc ("set_item", type_id);
	set_item (eif_access (result), *a_character);
													
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_boolean (VARIANT_BOOL * a_bool)

// Create BOOLEAN_REF from pointer to VARIANT_BOOL
{
	EIF_OBJECT result;
	EIF_TYPE_ID type_id;
	EIF_PROC set_item;
				
	type_id = eif_type_id ("BOOLEAN_REF");
	result = eif_create (type_id);
	set_item = eif_proc ("set_item", type_id);
	set_item (eif_access (result), ccom_ce_boolean (*a_bool));
													
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_currency (CURRENCY * a_currency)

// Create Eiffel object ECOM_CURRENCY from C	
{
	EIF_OBJECT result;
	EIF_TYPE_ID eif_currency_id;
	EIF_PROC currency_make;
	
	eif_currency_id = eif_type_id ("ECOM_CURRENCY");
	currency_make = eif_proc ("make_by_pointer", eif_currency_id);
	result = eif_create (eif_currency_id);
	currency_make (eif_access (result), (EIF_POINTER)a_currency);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_decimal (DECIMAL * a_decimal)

// Create ECOM_DECIMAL from C 
{
	EIF_OBJECT result;
	EIF_TYPE_ID eif_decimal_id;
	EIF_PROC make;
				
	eif_decimal_id = eif_type_id ("ECOM_DECIMAL");
	make = eif_proc ("make_by_pointer", eif_decimal_id);
	result = eif_create (eif_decimal_id);
	make (eif_access (result), (EIF_POINTER)a_decimal);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_hresult (HRESULT * a_hresult)

// Create ECOM_HRESULT from pointer to HRESULT.
{
	EIF_OBJECT result;

	result = eif_protect (ccom_ce_hresult (* (HRESULT *)a_hresult));	
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_record (void * a_record_pointer, char * a_class_name)

// Create Eiffel object from C structure
{
	EIF_OBJECT result;
	EIF_TYPE_ID type_id;
	EIF_PROC make;
				
	type_id = eif_type_id (a_class_name);
	make = eif_proc ("make_by_pointer", type_id);
	result = eif_create (type_id);
	make (eif_access (result), (EIF_POINTER)a_record_pointer);
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_short (short * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count)

// Create Eiffel ARRAY from C array of short.
{
	int i, element_number;
	EIF_INTEGER * c_array;
	EIF_OBJECT result;
	
	// Conver array of short into array of EIF_INTEGER
	element_number = ccom_element_number (dim_count, element_count);
	c_array = (EIF_INTEGER *)calloc (element_number, sizeof (EIF_INTEGER));
	
	for (i = 0; i < element_number; i++)
	{
		c_array[i] = (EIF_INTEGER)an_array[i];
	}
	
	// Create Eiffel array and initialize it to C array.
	result = ccom_create_array ("INTEGER", dim_count, element_count);
	eif_make_from_c (eif_access (result), c_array, (EIF_INTEGER)element_number, EIF_INTEGER);
	
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_long (long * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count)

// Create Eiffel ARRAY from C array of long.
{
	EIF_INTEGER element_number;
	EIF_OBJECT result;
	
	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
	
	result = ccom_create_array ("INTEGER", dim_count, element_count);
	eif_make_from_c (eif_access (result), an_array, element_number, EIF_INTEGER);
	
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_float (float * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count)
	
// Create Eiffel ARRAY from C array of float.
{
	EIF_INTEGER element_number;
	EIF_OBJECT result;
		
	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
					
	result = ccom_create_array ("REAL", dim_count, element_count);
	eif_make_from_c (eif_access (result), an_array, element_number, EIF_REAL);
								
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_double (double * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count)
	
// Create Eiffel ARRAY from C array of double.
{
	EIF_INTEGER element_number;
	EIF_OBJECT result;
		
	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
					
	result = ccom_create_array ("DOUBLE", dim_count, element_count);
	eif_make_from_c (eif_access (result), an_array, element_number, EIF_DOUBLE);
								
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_character (char * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count)
	
// Create Eiffel ARRAY from C array of char.
{
	EIF_INTEGER element_number;
	EIF_OBJECT result;
		
	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
					
	result = ccom_create_array ("CHARACTER", dim_count, element_count);
	eif_make_from_c (eif_access (result), an_array, element_number, EIF_CHARACTER);
								
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_currency (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count)

// Create Eiffel ARRAY from C array of CURRENCY.
{
	EIF_INTEGER element_number;
	EIF_OBJECT result, intermediate_array, eif_lower_indeces, eif_element_count;
	
	EIF_TYPE_ID type_id, int_array_id;
	EIF_PROCEDURE make, put;	
	int i;
	EIF_INTEGER * lower_indeces;
	CURRENCY * an_array_element;
	
	type_id = eif_type_id ("ARRAY [ECOM_CURRENCY]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	
	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
	intermediate_array = eif_create (type_id);
	make (eif_access (intermediate_array), 1, element_number);
	
	for (i = 0; i < element_number; i++)
	{
		an_array_element = (CURRENCY *)&((ccom_c_array_element (an_array, i,CURRENCY)));
		put (eif_access (intermediate_array), ccom_ce_pointed_currency (an_array_element), i + 1);
	}
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
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_bstr (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count)

// Create Eiffel ARRAY from C array of BSTR.
{
	EIF_INTEGER element_number;
	EIF_OBJECT result, intermediate_array, eif_lower_indeces, eif_element_count;
	
	EIF_TYPE_ID type_id, int_array_id;
	EIF_PROCEDURE make, put;	
	int i;
	EIF_INTEGER * lower_indeces;
	BSTR * an_array_element;
	
	type_id = eif_type_id ("ARRAY [STRING]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	
	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
	intermediate_array = eif_create (type_id);
	make (eif_access (intermediate_array), 1, element_number);
	
	for (i = 0; i < element_number; i++)
	{
		an_array_element = (BSTR *)&((ccom_c_array_element (an_array, i, BSTR)));
		put (eif_access (intermediate_array), ccom_ce_bstr ((BSTR)*an_array_element), i + 1);
	}
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
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_decimal (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count)

// Create Eiffel ARRAY from C array of DECIMAL.
{
	EIF_INTEGER element_number;
	EIF_OBJECT result, intermediate_array, eif_lower_indeces, eif_element_count;
	
	EIF_TYPE_ID type_id, int_array_id;
	EIF_PROCEDURE make, put;	
	int i;
	EIF_INTEGER * lower_indeces;
	DECIMAL * an_array_element;
	
	type_id = eif_type_id ("ARRAY [ECOM_DECIMAL]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	
	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
	intermediate_array = eif_create (type_id);
	make (eif_access (intermediate_array), 1, element_number);
	
	for (i = 0; i < element_number; i++)
	{
		an_array_element = (DECIMAL *)&((ccom_c_array_element (an_array, i, DECIMAL)));
		put (eif_access (intermediate_array), ccom_ce_pointed_decimal (an_array_element), i + 1);
	}
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
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_boolean (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count)

// Create Eiffel ARRAY from C array of VARIANT_BOOL.
{
	EIF_INTEGER element_number;
	EIF_OBJECT result, intermediate_array, eif_lower_indeces, eif_element_count;
	
	EIF_TYPE_ID type_id, int_array_id;
	EIF_PROCEDURE make, put;	
	int i;
	EIF_INTEGER * lower_indeces;
	VARIANT_BOOL * an_array_element;
	
	type_id = eif_type_id ("ARRAY [BOOLEAN]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	
	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
	intermediate_array = eif_create (type_id);
	make (eif_access (intermediate_array), 1, element_number);
	
	for (i = 0; i < element_number; i++)
	{
		an_array_element = (VARIANT_BOOL *)&((ccom_c_array_element (an_array, i, VARIANT_BOOL)));
		put (eif_access (intermediate_array), ccom_ce_boolean ((VARIANT_BOOL)*an_array_element), i + 1);
	}
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
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_date (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count)

// Create Eiffel ARRAY from C array of DATE.
{
	EIF_INTEGER element_number;
	EIF_OBJECT result, intermediate_array, eif_lower_indeces, eif_element_count;
	
	EIF_TYPE_ID type_id, int_array_id;
	EIF_PROCEDURE make, put;	
	int i;
	EIF_INTEGER * lower_indeces;
	DATE * an_array_element;
	
	type_id = eif_type_id ("ARRAY [DATE_TIME]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	
	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
	intermediate_array = eif_create (type_id);
	make (eif_access (intermediate_array), 1, element_number);
	
	for (i = 0; i < element_number; i++)
	{
		an_array_element = (DATE *)&((ccom_c_array_element (an_array, i, DATE)));
		put (eif_access (intermediate_array), ccom_ce_date ((DATE)*an_array_element), i + 1);
	}
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
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_variant (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count)

// Create Eiffel ARRAY from C array of VARIANT.
{
	EIF_INTEGER element_number;
	EIF_OBJECT result, intermediate_array, eif_lower_indeces, eif_element_count;
	
	EIF_TYPE_ID type_id, int_array_id;
	EIF_PROCEDURE make, put;	
	int i;
	EIF_INTEGER * lower_indeces;
	VARIANT * an_array_element;
	
	type_id = eif_type_id ("ARRAY [ECOM_VARIANT]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	
	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
	intermediate_array = eif_create (type_id);
	make (eif_access (intermediate_array), 1, element_number);
	
	for (i = 0; i < element_number; i++)
	{
		an_array_element = (VARIANT *)&(ccom_c_array_element (an_array, i, VARIANT));
		put (eif_access (intermediate_array), ccom_ce_variant ((VARIANT *) an_array_element), i + 1);
	}
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
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_hresult (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count)

// Create Eiffel ARRAY from C array of HRESULT.
{
	EIF_INTEGER element_number;
	EIF_OBJECT result, intermediate_array, eif_lower_indeces, eif_element_count;
	
	EIF_TYPE_ID type_id, int_array_id;
	EIF_PROCEDURE make, put;	
	int i;
	EIF_INTEGER * lower_indeces;
	HRESULT * an_array_element;
	
	type_id = eif_type_id ("ARRAY [ECOM_HRESULT]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	
	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
	intermediate_array = eif_create (type_id);
	make (eif_access (intermediate_array), 1, element_number);
	
	for (i = 0; i < element_number; i++)
	{
		an_array_element = (HRESULT *)&((ccom_c_array_element (an_array, i, HRESULT)));
		put (eif_access (intermediate_array), ccom_ce_hresult ((HRESULT)*an_array_element), i + 1);
	}
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
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_unknown (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count)

// Create Eiffel ARRAY from C array of IUnknown *.
{
	EIF_INTEGER element_number;
	EIF_OBJECT result, intermediate_array, eif_lower_indeces, eif_element_count;
	
	EIF_TYPE_ID type_id, int_array_id;
	EIF_PROCEDURE make, put;	
	int i;
	EIF_INTEGER * lower_indeces;
	IUnknown * an_array_element;
	
	type_id = eif_type_id ("ARRAY [ECOM_GENERIC_INTERFACE]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	
	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
	intermediate_array = eif_create (type_id);
	make (eif_access (intermediate_array), 1, element_number);
	
	for (i = 0; i < element_number; i++)
	{
		an_array_element = (IUnknown *)&((ccom_c_array_element (an_array, i, IUnknown *)));
		put (eif_access (intermediate_array), ccom_ce_unknown ((IUnknown *)an_array_element), i + 1);
	}
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
		
		// Create ECOM_ARRAY [ECOM_GENERIC_INTERFACE]
		type_id = eif_type_id ("ECOM_ARRAY [ECOM_GENERIC_INTERFACE]");
		make = eif_procedure ("make_from_array", type_id);
		
		result = eif_create (type_id);
		make (eif_access (result), eif_access (intermediate_array), 
				dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
		eif_wean (intermediate_array);
	}
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_dispatch (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count)

// Create Eiffel ARRAY from C array of IDispatch *.
{
	EIF_INTEGER element_number;
	EIF_OBJECT result, intermediate_array, eif_lower_indeces, eif_element_count;
	
	EIF_TYPE_ID type_id, int_array_id;
	EIF_PROCEDURE make, put;	
	int i;
	EIF_INTEGER * lower_indeces;
	IDispatch * an_array_element;
	
	type_id = eif_type_id ("ARRAY [ECOM_GENERIC_DISPINTERFACE]");
	make = eif_procedure ("make", type_id);
	put = eif_procedure ("put", type_id);
	
	element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
	intermediate_array = eif_create (type_id);
	make (eif_access (intermediate_array), 1, element_number);
	
	for (i = 0; i < element_number; i++)
	{
		an_array_element = (IDispatch *)&((ccom_c_array_element (an_array, i, IDispatch *)));
		put (eif_access (intermediate_array), ccom_ce_unknown ((IDispatch *)an_array_element), i + 1);
	}
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
		
		// Create ECOM_ARRAY [ECOM_GENERIC_DISPINTERFACE]
		type_id = eif_type_id ("ECOM_ARRAY [ECOM_GENERIC_DISPINTERFACE]");
		make = eif_procedure ("make_from_array", type_id);
		
		result = eif_create (type_id);
		make (eif_access (result), eif_access (intermediate_array), 
				dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
		eif_wean (intermediate_array);
	}
	return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_short (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of short
{
	EIF_INTEGER dim_count;
	EIF_INTEGER * lower_indeces;
	EIF_INTEGER * upper_indeces;
	EIF_INTEGER * element_counts;
	EIF_INTEGER * index;
	long * sa_indeces;
	int i;
	long tmp_long;
	HRESULT hr;
	EIF_OBJECT result, eif_lower_indeces, eif_element_counts, eif_index;
	EIF_TYPE_ID int_array_id, type_id;
	EIF_PROCEDURE make, put;
	short sa_element;
	
	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);
	
	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));
	
	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i, &tmp_long);
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
		SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
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
	EIF_INTEGER dim_count;
	EIF_INTEGER * lower_indeces;
	EIF_INTEGER * upper_indeces;
	EIF_INTEGER * element_counts;
	EIF_INTEGER * index;
	long * sa_indeces;
	int i;
	long tmp_long;
	HRESULT hr;
	EIF_OBJECT result, eif_lower_indeces, eif_element_counts, eif_index;
	EIF_TYPE_ID int_array_id, type_id;
	EIF_PROCEDURE make, put;
	long sa_element;
	
	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);
	
	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));
	
	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i, &tmp_long);
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
		SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
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

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_float (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of float
{
	EIF_INTEGER dim_count;
	EIF_INTEGER * lower_indeces;
	EIF_INTEGER * upper_indeces;
	EIF_INTEGER * element_counts;
	EIF_INTEGER * index;
	long * sa_indeces;
	int i;
	long tmp_long;
	HRESULT hr;
	EIF_OBJECT result, eif_lower_indeces, eif_element_counts, eif_index;
	EIF_TYPE_ID int_array_id, type_id;
	EIF_PROCEDURE make, put;
	float sa_element;
	
	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);
	
	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));
	
	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i, &tmp_long);
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
		SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
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
	EIF_INTEGER dim_count;
	EIF_INTEGER * lower_indeces;
	EIF_INTEGER * upper_indeces;
	EIF_INTEGER * element_counts;
	EIF_INTEGER * index;
	long * sa_indeces;
	int i;
	long tmp_long;
	HRESULT hr;
	EIF_OBJECT result, eif_lower_indeces, eif_element_counts, eif_index;
	EIF_TYPE_ID int_array_id, type_id;
	EIF_PROCEDURE make, put;
	double sa_element;
	
	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);
	
	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));
	
	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i, &tmp_long);
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
		SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
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
	EIF_INTEGER dim_count;
	EIF_INTEGER * lower_indeces;
	EIF_INTEGER * upper_indeces;
	EIF_INTEGER * element_counts;
	EIF_INTEGER * index;
	long * sa_indeces;
	int i;
	long tmp_long;
	HRESULT hr;
	EIF_OBJECT result, eif_lower_indeces, eif_element_counts, eif_index;
	EIF_TYPE_ID int_array_id, type_id;
	EIF_PROCEDURE make, put;
	char sa_element;
	
	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);
	
	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));
	
	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i, &tmp_long);
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
		SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
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
	EIF_INTEGER dim_count;
	EIF_INTEGER * lower_indeces;
	EIF_INTEGER * upper_indeces;
	EIF_INTEGER * element_counts;
	EIF_INTEGER * index;
	long * sa_indeces;
	int i;
	long tmp_long;
	HRESULT hr;
	EIF_OBJECT result, eif_lower_indeces, eif_element_counts, eif_index;
	EIF_TYPE_ID int_array_id, type_id;
	EIF_PROCEDURE make, put;
	VARIANT_BOOL sa_element;
	EIF_BOOLEAN eif_array_element;
	
	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);
	
	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));
	
	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i, &tmp_long);
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
		SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
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
	EIF_INTEGER dim_count;
	EIF_INTEGER * lower_indeces;
	EIF_INTEGER * upper_indeces;
	EIF_INTEGER * element_counts;
	EIF_INTEGER * index;
	long * sa_indeces;
	int i;
	long tmp_long;
	HRESULT hr;
	EIF_OBJECT result, eif_lower_indeces, eif_element_counts, eif_index, eif_array_element;
	EIF_TYPE_ID int_array_id, type_id, currency_id;
	EIF_PROCEDURE make, put;
	EIF_POINTER_FUNCTION item;
	CURRENCY * sa_element;
	
	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);
	
	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));
	
	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i, &tmp_long);
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
	item = eif_pointer_function ("item", currency_id);
	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}
		
		eif_array_element = eif_create (currency_id);
		make (eif_access (eif_array_element));
		sa_element = (CURRENCY *)item (eif_access (eif_array_element));

		SafeArrayGetElement (a_safearray, sa_indeces, sa_element);
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
	EIF_INTEGER dim_count;
	EIF_INTEGER * lower_indeces;
	EIF_INTEGER * upper_indeces;
	EIF_INTEGER * element_counts;
	EIF_INTEGER * index;
	long * sa_indeces;
	int i;
	long tmp_long;
	HRESULT hr;
	EIF_OBJECT result, eif_lower_indeces, eif_element_counts, eif_index;
	EIF_TYPE_ID int_array_id, type_id;
	EIF_PROCEDURE make, put;
	DATE sa_element;
	
	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);
	
	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));
	
	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i, &tmp_long);
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
		SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
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
	EIF_INTEGER dim_count;
	EIF_INTEGER * lower_indeces;
	EIF_INTEGER * upper_indeces;
	EIF_INTEGER * element_counts;
	EIF_INTEGER * index;
	long * sa_indeces;
	int i;
	long tmp_long;
	HRESULT hr;
	EIF_OBJECT result, eif_lower_indeces, eif_element_counts, eif_index, eif_array_element;
	EIF_TYPE_ID int_array_id, type_id, decimal_id;
	EIF_PROCEDURE make, put;
	EIF_POINTER_FUNCTION item;
	DECIMAL * sa_element;
	
	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);
	
	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));
	
	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i, &tmp_long);
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
	item = eif_pointer_function ("item", decimal_id);
	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}
		
		eif_array_element = eif_create (decimal_id);
		make (eif_access (eif_array_element));
		sa_element = (DECIMAL *)item (eif_access (eif_array_element));

		SafeArrayGetElement (a_safearray, sa_indeces, sa_element);
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
	EIF_INTEGER dim_count;
	EIF_INTEGER * lower_indeces;
	EIF_INTEGER * upper_indeces;
	EIF_INTEGER * element_counts;
	EIF_INTEGER * index;
	long * sa_indeces;
	int i;
	long tmp_long;
	HRESULT hr;
	EIF_OBJECT result, eif_lower_indeces, eif_element_counts, eif_index;
	EIF_TYPE_ID int_array_id, type_id;
	EIF_PROCEDURE make, put;
	BSTR sa_element;
	
	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);
	
	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));
	
	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i, &tmp_long);
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
		SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
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
	EIF_INTEGER dim_count;
	EIF_INTEGER * lower_indeces;
	EIF_INTEGER * upper_indeces;
	EIF_INTEGER * element_counts;
	EIF_INTEGER * index;
	long * sa_indeces;
	int i;
	long tmp_long;
	HRESULT hr;
	EIF_OBJECT result, eif_lower_indeces, eif_element_counts, eif_index, eif_array_element;
	EIF_TYPE_ID int_array_id, type_id, variant_id;
	EIF_PROCEDURE make, put;
	EIF_POINTER_FUNCTION item;
	VARIANT * sa_element;
	
	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);
	
	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));
	
	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i, &tmp_long);
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
	item = eif_pointer_function ("item", variant_id);
	do
	{
		eif_make_from_c (eif_access (eif_index), index, dim_count, EIF_INTEGER);
		for (i = 0; i < dim_count; i++)
		{
			sa_indeces[i] = index [dim_count - 1 - i];
		}
		
		eif_array_element = eif_create (variant_id);
		make (eif_access (eif_array_element));
		sa_element = (VARIANT *)item (eif_access (eif_array_element));

		SafeArrayGetElement (a_safearray, sa_indeces, sa_element);
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
	EIF_INTEGER dim_count;
	EIF_INTEGER * lower_indeces;
	EIF_INTEGER * upper_indeces;
	EIF_INTEGER * element_counts;
	EIF_INTEGER * index;
	long * sa_indeces;
	int i;
	long tmp_long;
	HRESULT hr;
	EIF_OBJECT result, eif_lower_indeces, eif_element_counts, eif_index;
	EIF_TYPE_ID int_array_id, type_id;
	EIF_PROCEDURE make, put;
	HRESULT sa_element;
	
	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);
	
	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));
	
	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i, &tmp_long);
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
		SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);	
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
	EIF_INTEGER dim_count;
	EIF_INTEGER * lower_indeces;
	EIF_INTEGER * upper_indeces;
	EIF_INTEGER * element_counts;
	EIF_INTEGER * index;
	long * sa_indeces;
	int i;
	long tmp_long;
	HRESULT hr;
	EIF_OBJECT result, eif_lower_indeces, eif_element_counts, eif_index;
	EIF_TYPE_ID int_array_id, type_id;
	EIF_PROCEDURE make, put;
	IUnknown * sa_element;
	
	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);
	
	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));
	
	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i, &tmp_long);
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

	// Create ECOM_ARRAY [ECOM_GENERIC_INTERFACE]
	type_id = eif_type_id ("ECOM_ARRAY [ECOM_GENERIC_INTERFACE]");
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
		SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
		put (eif_access (result), ccom_ce_unknown (sa_element), eif_access (eif_index));
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
	EIF_INTEGER dim_count;
	EIF_INTEGER * lower_indeces;
	EIF_INTEGER * upper_indeces;
	EIF_INTEGER * element_counts;
	EIF_INTEGER * index;
	long * sa_indeces;
	int i;
	long tmp_long;
	HRESULT hr;
	EIF_OBJECT result, eif_lower_indeces, eif_element_counts, eif_index;
	EIF_TYPE_ID int_array_id, type_id;
	EIF_PROCEDURE make, put;
	IDispatch * sa_element;
	
	dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);
	
	lower_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	upper_indeces = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
	sa_indeces = (long *)calloc (dim_count, sizeof (long));
	
	for (i = 0; i < dim_count; i++)
	{
		hr = SafeArrayGetLBound (a_safearray, i, &tmp_long);
		if (SUCCEEDED (hr))
			lower_indeces[i] = (EIF_INTEGER)tmp_long;
		else
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		}
		hr = SafeArrayGetUBound (a_safearray, i, &tmp_long);
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

	// Create ECOM_ARRAY [ECOM_GENERIC_DISPINTERFACE]
	type_id = eif_type_id ("ECOM_ARRAY [ECOM_GENERIC_DISPINTERFACE]");
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
		SafeArrayGetElement (a_safearray, sa_indeces, &sa_element);
		put (eif_access (result), ccom_ce_dispatch (sa_element), eif_access (eif_index));
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

