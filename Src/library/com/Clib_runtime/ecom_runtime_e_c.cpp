//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:   ecom_runtime_e_c.c
//
//  Contents: Runtime conversion functions from C to Eiffel
//
//--------------------------------------------------------------------------

#include "ecom_runtime_e_c.h"

ecom_runtime_ec rt_ec;

static EIF_TYPE_ID int_array_tid = -1;

IUnknown * * ecom_runtime_ec::ccom_ec_pointed_pointed_unknown( EIF_REFERENCE eif_ref, IUnknown * * old )

/*-----------------------------------------------------------
  Convert CELL [ECOM_INTERFACE] to IUnknown * *.
-----------------------------------------------------------*/
{
  EIF_OBJECT eif_object = 0;
  IUnknown * * result = 0;
  EIF_REFERENCE cell_item = 0;

  eif_object = eif_protect (eif_ref);
  if (old != NULL)
    result = old;
  else
    result = (IUnknown * *) CoTaskMemAlloc (sizeof (IUnknown *));
  cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
  if (cell_item == NULL)
    *result = NULL;
  else
    *result = ccom_ec_unknown (cell_item);
  eif_wean (eif_object);
  return result;
};
//-------------------------------------------------------------------------

IDispatch * * ecom_runtime_ec::ccom_ec_pointed_pointed_dispatch ( EIF_REFERENCE eif_ref, IDispatch * * old )

/*-----------------------------------------------------------
  Convert CELL [IFONT_INTERFACE] to IDispatch * *.
-----------------------------------------------------------*/
{
  EIF_OBJECT eif_object = 0;
  IDispatch * * result = 0;
  EIF_REFERENCE cell_item = 0;

  eif_object = eif_protect (eif_ref);
  if (old != NULL)
    result = old;
  else
    result = (IDispatch * *) CoTaskMemAlloc (sizeof (IDispatch *));
  cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
  if (cell_item == NULL)
    *result = NULL;
  else
    *result = ccom_ec_dispatch (cell_item);
  eif_wean (eif_object);
  return result;
};
//-------------------------------------------------------------------------
IFont * ecom_runtime_ec::ccom_ec_pointed_ifont( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
  Convert IFONT_INTERFACE to IFont *.
-----------------------------------------------------------*/
{
  EIF_OBJECT eif_object = 0;
  EIF_POINTER a_pointer = 0;

  if (NULL != eif_ref)
  {
    eif_object = eif_protect (eif_ref);
    a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
    if (a_pointer  == NULL)
    {
      EIF_PROCEDURE create_item = 0;
      EIF_TYPE_ID type_id = eif_type (eif_object);
      create_item = eif_procedure ("create_item", type_id);
      (FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
      a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
    }
    ((IFont *) a_pointer)->AddRef ();
    eif_wean (eif_object);
  }
  return  (IFont * ) a_pointer;
};
//-------------------------------------------------------------------------

IFont * * ecom_runtime_ec::ccom_ec_pointed_pointed_ifont( EIF_REFERENCE eif_ref, IFont * * old )

/*-----------------------------------------------------------
  Convert CELL [IFONT_INTERFACE] to IFont * *.
-----------------------------------------------------------*/
{
  EIF_OBJECT eif_object = 0;
  IFont * * result = 0;
  EIF_REFERENCE cell_item = 0;

  eif_object = eif_protect (eif_ref);
  if (old != NULL)
    result = old;
  else
    result = (IFont * *) CoTaskMemAlloc (sizeof (IFont *));
  cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
  if (cell_item == NULL)
    *result = NULL;
  else
    *result = ccom_ec_pointed_ifont (cell_item);
  eif_wean (eif_object);
  return result;
};
//-------------------------------------------------------------------------

IEnumVARIANT * ecom_runtime_ec::ccom_ec_pointed_enum_variant( EIF_REFERENCE eif_ref )

/*-----------------------------------------------------------
  Convert IENUM_VARIANT_INTERFACE to IEnumVARIANT *.
-----------------------------------------------------------*/
{
  EIF_OBJECT eif_object = 0;
  EIF_POINTER a_pointer = 0;

  if (eif_ref != NULL)
  {
    eif_object = eif_protect (eif_ref);
    a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
    if (a_pointer  == NULL)
    {
      EIF_PROCEDURE create_item = 0;
      EIF_TYPE_ID type_id = eif_type (eif_object);
      create_item = eif_procedure ("create_item", type_id);
      (FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
      a_pointer = (EIF_POINTER) eif_field (eif_access (eif_object), "item", EIF_POINTER);
    }
    ((IEnumVARIANT *) a_pointer)->AddRef ();
    eif_wean (eif_object);
  }
  return  (IEnumVARIANT * ) a_pointer;
};
//-------------------------------------------------------------------------

IEnumVARIANT * * ecom_runtime_ec::ccom_ec_pointed_pointed_enum_variant( EIF_REFERENCE eif_ref, IEnumVARIANT * * old )

/*-----------------------------------------------------------
  Convert CELL [IENUM_VARIANT_INTERFACE] to IEnumVARIANT * *.
-----------------------------------------------------------*/
{
  EIF_OBJECT eif_object = 0;
  IEnumVARIANT * * result = 0;
  EIF_REFERENCE cell_item = 0;

  eif_object = eif_protect (eif_ref);
  if (old != NULL)
    result = old;
  else
    result = (IEnumVARIANT * *) CoTaskMemAlloc (sizeof (IEnumVARIANT *));
  cell_item = eif_field (eif_access (eif_object), "item", EIF_REFERENCE);
  if (cell_item == NULL)
    *result = NULL;
  else
    *result = ccom_ec_pointed_enum_variant (cell_item);
  eif_wean (eif_object);
  return result;
};
//-------------------------------------------------------------------------

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
  EIF_OBJECT eif_object = 0;
  VARIANT_BOOL * result = 0;
  EIF_BOOLEAN temp_bool = 0;

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
  VARIANT_BOOL result = 0;

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

  SYSTEMTIME * systime = 0;
  DATE variant_time;

  EIF_INTEGER_FUNCTION f_year, f_month, f_day, f_hour, f_minute, f_second;
  static EIF_TYPE_ID tid = -1;

  if (-1 == tid)
    tid = eif_type_id ("DATE_TIME");

  f_year = eif_integer_function ("year", tid);
  f_month = eif_integer_function ("month", tid);
  f_day = eif_integer_function ("day", tid);
  f_hour = eif_integer_function ("hour", tid);
  f_minute = eif_integer_function ("minute", tid);
  f_second = eif_integer_function ("second", tid);

  systime = (SYSTEMTIME *)malloc (sizeof (SYSTEMTIME));

  systime->wYear = (WORD)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_year)(eif_access(date_time));
  systime->wMonth = (WORD)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_month)(eif_access(date_time));
  systime->wDay = (WORD)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_day)(eif_access(date_time));
  systime->wHour = (WORD)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_hour)(eif_access(date_time));
  systime->wMinute = (WORD)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_minute)(eif_access(date_time));
  systime->wSecond = (WORD)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_second)(eif_access(date_time));

  SystemTimeToVariantTime (systime, &variant_time);

  eif_wean (date_time);
  free (systime);

  return variant_time;
};
//----------------------------------------------------------------------------

HRESULT ecom_runtime_ec::ccom_ec_hresult (EIF_REFERENCE a_ref)

// Create HRESULT from Eiffel ECOM_HRESULT
{
  EIF_OBJECT hr = 0;

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
  EIF_OBJECT an_int = 0;

  LARGE_INTEGER * c_large_integer = 0;

  an_int = eif_protect (a_ref);

  c_large_integer = (LARGE_INTEGER *)eif_field (eif_access(an_int), "item", EIF_POINTER);
  eif_wean (an_int);

  return (*c_large_integer);
};
//--------------------------------------------------------------------------------

LONGLONG * ecom_runtime_ec::ccom_ec_pointed_long_long (EIF_REFERENCE a_ref, LONGLONG * old)

// Create LONGLONG * from EIF_REFERENCE (INTEGER64_REF)
{
  EIF_OBJECT eif_object = 0;
  LONGLONG * result = 0;

  eif_object = eif_protect (a_ref);

  result = (LONGLONG *) CoTaskMemAlloc (sizeof (LONGLONG));
  * result = (LONGLONG) eif_field (eif_access(eif_object), "item", EIF_INTEGER_64);

  eif_wean (eif_object);
  if (old != NULL)
  {
    *old = *result;
    return NULL;
  }
  else
    return result;
};
//--------------------------------------------------------------------------------

ULARGE_INTEGER ecom_runtime_ec::ccom_ec_ulong_long (EIF_REFERENCE a_ref)

// Create ULARGE_INTEGER from Eiffel ECOM_ULARGE_INTEGER
{
  EIF_OBJECT an_int = 0;

  ULARGE_INTEGER * c_ularge_integer = 0;

  an_int = eif_protect (a_ref);

  c_ularge_integer = (ULARGE_INTEGER *)eif_field(eif_access(an_int), "item", EIF_POINTER);
  eif_wean (an_int);

  return (*c_ularge_integer);
};

//----------------------------------------------------------------------------

ULONGLONG * ecom_runtime_ec::ccom_ec_pointed_ulong_long (EIF_REFERENCE a_ref, ULONGLONG *old)


// Create ULONGLONG * from EIF_REFERENCE (INTEGER64_REF)
{
  EIF_OBJECT eif_object = 0;
  ULONGLONG * result = 0;

  eif_object = eif_protect (a_ref);

  result = (ULONGLONG *) CoTaskMemAlloc (sizeof (ULONGLONG));
  * result = (ULONGLONG) eif_field (eif_access(eif_object), "item", EIF_INTEGER_64);

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

IUnknown * ecom_runtime_ec::ccom_ec_unknown (EIF_REFERENCE eif_ref)

// Create IUnknown from Eiffel ECOM_INTERFACE
{
  EIF_OBJECT eif_object = 0;
  IUnknown * a_pointer = 0;
  IUnknown * result = 0;

  if (NULL != eif_ref)
  {
    eif_object = eif_protect (eif_ref);
    a_pointer = (IUnknown *) eif_field (eif_access (eif_object), "item", EIF_POINTER);
    if (a_pointer  == NULL)
    {
      EIF_PROCEDURE create_item = 0;
      EIF_TYPE_ID type_id = eif_type (eif_object);
      create_item = eif_procedure ("create_item", type_id);
      (FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
      a_pointer = (IUnknown *) eif_field (eif_access (eif_object), "item", EIF_POINTER);
    }
    a_pointer->QueryInterface (IID_IUnknown, (void**)&result);
    eif_wean (eif_object);
  }
  return a_pointer;
};
//----------------------------------------------------------------------------

IDispatch * ecom_runtime_ec::ccom_ec_dispatch (EIF_REFERENCE eif_ref)

// Create IDispatch from Eiffel ECOM_INTERFACE
{
  EIF_OBJECT eif_object = 0;
  IDispatch * a_pointer = 0;
  IDispatch * result = 0;

  if (NULL != eif_ref)
  {
    eif_object = eif_protect (eif_ref);
    a_pointer = (IDispatch *) eif_field (eif_access (eif_object), "item", EIF_POINTER);
    if (a_pointer  == NULL)
    {
      EIF_PROCEDURE create_item = 0;
      EIF_TYPE_ID type_id = eif_type (eif_object);
      create_item = eif_procedure ("create_item", type_id);
      (FUNCTION_CAST (void, (EIF_REFERENCE)) create_item) (eif_access (eif_object));
      a_pointer = (IDispatch *) eif_field (eif_access (eif_object), "item", EIF_POINTER);
    }
    a_pointer->QueryInterface (IID_IDispatch, (void**)&result);
    eif_wean (eif_object);
  }
  return a_pointer;
};
//----------------------------------------------------------------------------

DECIMAL ecom_runtime_ec::ccom_ec_decimal (EIF_REFERENCE a_ref)

// Create DECIMAL from EIF_REFERENCE
{
  EIF_OBJECT a_decimal = 0;
  DECIMAL * c_decimal = 0;

  a_decimal = eif_protect (a_ref);

  c_decimal = (DECIMAL *)eif_field(eif_access(a_decimal), "item", EIF_POINTER);
  eif_wean (a_decimal);

  return (*c_decimal);
};
//----------------------------------------------------------------------------

DECIMAL * ecom_runtime_ec::ccom_ec_pointed_decimal (EIF_REFERENCE a_ref, DECIMAL * old)

// Create DECIMAL from EIF_REFERENCE
{
  EIF_OBJECT a_decimal = 0;
  DECIMAL * c_decimal = 0;
  static EIF_TYPE_ID type_id = -1;

  a_decimal = eif_protect (a_ref);

  c_decimal = (DECIMAL *)eif_field(eif_access(a_decimal), "item", EIF_POINTER);
  

  if (old != NULL)
  {
    memcpy (old, c_decimal, sizeof (DECIMAL));
    eif_wean (a_decimal);
    return NULL;
  }
  else
  {
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_DECIMAL");
      
    EIF_PROCEDURE set_shared = NULL;
    set_shared = eif_procedure ("set_shared", type_id);
    (FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (a_decimal));
    eif_wean (a_decimal);

    return c_decimal;
  }
};
//----------------------------------------------------------------------------

CURRENCY ecom_runtime_ec::ccom_ec_currency (EIF_REFERENCE a_ref)

// Create CURRENCY from EIF_REFERENCE
{
  EIF_OBJECT a_currency = 0;
  CURRENCY * c_currency = 0;

  a_currency = eif_protect (a_ref);

  c_currency = (CURRENCY *)eif_field(eif_access(a_currency), "item", EIF_POINTER);
  eif_wean (a_currency);

  return (*c_currency);
};

//----------------------------------------------------------------------------

unsigned char * ecom_runtime_ec::ccom_ec_pointed_unsigned_character (EIF_REFERENCE a_ref, unsigned char * old)
{
  return (unsigned char *) ccom_ec_pointed_character (a_ref, (char *) old);
}

//----------------------------------------------------------------------------

char * ecom_runtime_ec::ccom_ec_pointed_character (EIF_REFERENCE a_ref, char * old)

// Create char * from EIF_REFERENCE (CHARACTER_REF)
{
  EIF_OBJECT eif_object = 0;
  char * result = 0;

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
  EIF_OBJECT eif_object = 0;
  DATE * result = 0;

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
unsigned short * ecom_runtime_ec::ccom_ec_pointed_unsigned_short (EIF_REFERENCE a_ref, unsigned short * old)
{
  return (unsigned short *) ccom_ec_pointed_short (a_ref, (short *)old);
}


//----------------------------------------------------------------------------
short * ecom_runtime_ec::ccom_ec_pointed_short (EIF_REFERENCE a_ref, short * old)

// Create short * from EIF_REFERENCE (INTEGER_REF)
{
  EIF_OBJECT eif_object = 0;
  short * result = 0;

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

unsigned int * ecom_runtime_ec::ccom_ec_pointed_unsigned_integer (EIF_REFERENCE a_ref, unsigned int * old)
{
  return (unsigned int *)ccom_ec_pointed_integer (a_ref, (int *) old);
}

// ----------------------------------------------------------------------------

int * ecom_runtime_ec::ccom_ec_pointed_integer (EIF_REFERENCE a_ref, int * old)
// Create int * from EIF_REFERENCE (INTEGER_REF)
{
  EIF_OBJECT eif_object = 0;
  int * result = 0;

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

unsigned long * ecom_runtime_ec::ccom_ec_pointed_unsigned_long (EIF_REFERENCE a_ref, unsigned long * old)
{
  return (unsigned long *) ccom_ec_pointed_long (a_ref, (long *)old);
}

//---------------------------------------------------------------------------

long * ecom_runtime_ec::ccom_ec_pointed_long (EIF_REFERENCE a_ref, long * old)

// Create long * from EIF_REFERENCE (INTEGER_REF)
{
  EIF_OBJECT eif_object = 0;
  long * result = 0;

  eif_object = eif_protect (a_ref);

  result = (long *) CoTaskMemAlloc (sizeof (long));
  * result = (long) eif_field (eif_access(eif_object), "item", EIF_INTEGER);

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
  EIF_OBJECT eif_object = 0;
  float * result = 0;

  eif_object = eif_protect (a_ref);

  result = (float *) CoTaskMemAlloc (sizeof (float));
  * result = (float) eif_field (eif_access(eif_object), "item", EIF_REAL);

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
  EIF_OBJECT eif_object = 0;
  double * result = 0;

  eif_object = eif_protect (a_ref);

  result = (double *) CoTaskMemAlloc (sizeof (double));
  * result = (double) eif_field(eif_access(eif_object), "item", EIF_DOUBLE);

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
  EIF_OBJECT a_currency = 0;
  CURRENCY * c_currency = 0;
  static EIF_TYPE_ID type_id = -1;


  a_currency = eif_protect (a_ref);

  c_currency = (CURRENCY *)eif_field(eif_access(a_currency), "item", EIF_POINTER);

  if (old != NULL)
  {
    memcpy (old, c_currency, sizeof (CURRENCY));
    eif_wean (a_currency);
    return NULL;
  }
  else
  {
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_CURRENCY");
      
    EIF_PROCEDURE set_shared = NULL;
    set_shared = eif_procedure ("set_shared", type_id);
    (FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (a_currency));
    
    eif_wean (a_currency);

    return c_currency;
  }
};
//----------------------------------------------------------------------------

BSTR ecom_runtime_ec::ccom_ec_bstr (EIF_REFERENCE a_ref)

// Create BSTR from Eiffel STRING
{
  EIF_OBJECT eif_object = 0;
  static EIF_TYPE_ID tid = -1;
  EIF_REFERENCE_FUNCTION f_to_c = 0;
  char * c_string = 0;
  WCHAR * wide_string = 0;
  BSTR b_string = 0;

  if (a_ref != NULL)
  {
    eif_object = eif_protect (a_ref);
    if (-1 == tid)
      tid = eif_type_id ("STRING");
      
    f_to_c = eif_reference_function ("to_c", tid);

    c_string = (char *)(FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))f_to_c)(eif_access (eif_object));
    wide_string = ccom_create_from_string (c_string);

    b_string = SysAllocString (wide_string);

    free (wide_string);
    eif_wean (eif_object);
  }

  return b_string;
};
//----------------------------------------------------------------------------

LPSTR ecom_runtime_ec::ccom_ec_lpstr (EIF_REFERENCE a_ref, char * old)

// Create LPSTR from Eiffel STRING
{
  EIF_OBJECT eif_object = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_REFERENCE_FUNCTION to_c = 0;
  char * area_string = 0;
  char * result = 0;


  if (a_ref != NULL)
  {
    eif_object = eif_protect (a_ref);
    if (-1 == type_id)
      type_id = eif_type_id ("STRING");
      
    to_c = eif_reference_function ("to_c", type_id);

    area_string = (char *)(FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))to_c)(eif_access (eif_object));
    if (old != NULL)
    {
      result = old;
    }
    else
    {
      result = (char *) CoTaskMemAlloc (strlen (area_string) + 1);
    }
    strcpy (result, area_string);
    eif_wean (eif_object);
  }
  else
    result = NULL;
  return result;
};
//----------------------------------------------------------------------------

LPWSTR ecom_runtime_ec::ccom_ec_lpwstr (EIF_REFERENCE a_ref, LPWSTR old)

// Create LPWSTR from Eiffel STRING
{
  EIF_OBJECT eif_object = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_REFERENCE_FUNCTION to_c = 0;
  char * area_string = 0;
  WCHAR * result = 0;
  size_t size = 0, str_size = 0;

  if (a_ref != NULL)
  {
    eif_object = eif_protect (a_ref);
    if (-1 == type_id)
      type_id = eif_type_id ("STRING");
      
    to_c = eif_reference_function ("to_c", type_id);

    area_string = (char *)(FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))to_c) (eif_access (eif_object));
    str_size = strlen (area_string) + 1;
    size = mbstowcs (NULL, area_string, str_size);
    
    if (old != NULL)
    {
      result = old;
    }
    else
    {
      result = (WCHAR *) CoTaskMemAlloc ((size + 1) * sizeof (WCHAR));
    }
    mbstowcs (result, area_string, str_size);
    eif_wean (eif_object);
  }
  else
    result = NULL;
  return result;
};
//----------------------------------------------------------------------------

VARIANT ecom_runtime_ec::ccom_ec_variant (EIF_REFERENCE a_ref)

// Create VARIANT from EIF_REFERENCE
{
  EIF_OBJECT a_variant = 0;
  VARIANT * c_variant = 0;

  a_variant = eif_protect (a_ref);

  c_variant = (VARIANT *)eif_field(eif_access(a_variant), "item", EIF_POINTER);
  eif_wean (a_variant);

  return (*c_variant);
};
//----------------------------------------------------------------------------

VARIANT * ecom_runtime_ec::ccom_ec_pointed_variant (EIF_REFERENCE a_ref, VARIANT * old)

// Create VARIANT from EIF_REFERENCE
{
  EIF_OBJECT a_variant = 0;
  VARIANT * c_variant = 0;
  

  a_variant = eif_protect (a_ref);

  c_variant = (VARIANT *)eif_field(eif_access(a_variant), "item", EIF_POINTER);
  
  if (old != NULL)
  {
    memcpy (old, c_variant, sizeof (VARIANT));
    eif_wean (a_variant);
    return NULL;
  }
  else
  {
    static EIF_TYPE_ID type_id = -1;
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_VARIANT");
      
    EIF_PROCEDURE set_shared = NULL;
    set_shared = eif_procedure ("set_shared", type_id);
    (FUNCTION_CAST (void, (EIF_REFERENCE))set_shared) (eif_access (a_variant));
    eif_wean (a_variant);

    return c_variant;
  }
};
//----------------------------------------------------------------------------

// ARRAY

DATE * ecom_runtime_ec::ccom_ec_array_date (EIF_REFERENCE a_ref, int dimension, DATE * old)

// Create C array of DATE from Eiffel array
{
  EIF_OBJECT eif_date_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_type_id = -1;
  EIF_REFERENCE_FUNCTION f_item = 0;
  EIF_INTEGER_FUNCTION count = 0;

  DATE * date_array = 0;
  DATE a_date;
  int capacity = 0;

  eif_date_array = eif_protect (a_ref);
  if (dimension > 1)
  {
    if (-1 == tid)
      tid = eif_type_id ("ECOM_ARRAY[DATE_TIME]");
      
    f_item = eif_reference_function ("array_item", tid);
    count = eif_integer_function ("count", tid);
  }
  else
  {
    if (-1 == multi_dim_type_id)
      multi_dim_type_id = eif_type_id ("ARRAY[DATE_TIME]");
      
    f_item = eif_reference_function ("item", multi_dim_type_id);
    count = eif_integer_function ("count", multi_dim_type_id);
  }
  // Allocate memory
  
  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))count)(eif_access(eif_date_array));

  date_array = (DATE *) CoTaskMemAlloc (capacity*(sizeof(DATE)));

  for (int i=0; i < capacity; i++)
  {
    a_date = ccom_ec_date( (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_INTEGER))f_item)
          (eif_access(eif_date_array), ((EIF_INTEGER)(i+1))));
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
  EIF_OBJECT e_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  EIF_INTEGER_FUNCTION f_capacity = 0;
  EIF_POINTER_FUNCTION to_c = 0;

  char * result = 0;
  int capacity = 0;

  e_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[CHARACTER]");
    to_c = eif_pointer_function ("to_c", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[CHARACTER]");
    to_c = eif_pointer_function ("to_c", tid);
    f_capacity = eif_integer_function ("count", tid);
  }

  
  // Allocate memory
  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_array));
  if (old != NULL)
    result = (char *)CoTaskMemAlloc (capacity*(sizeof(char)));
  else
    result = old;


  memcpy (result, (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))to_c)(eif_access(e_array)), capacity*(sizeof(char)));

  eif_wean (e_array);
  return result;
};
//----------------------------------------------------------------------------
unsigned char * ecom_runtime_ec::ccom_ec_array_unsigned_character (EIF_REFERENCE a_ref, 
        int dimension, unsigned char * old)

// Create C array of char from Eiffel array.
{
  EIF_OBJECT e_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  EIF_INTEGER_FUNCTION f_capacity = 0;
  EIF_POINTER_FUNCTION to_c = 0;

  unsigned char * result = 0;
  int capacity = 0;

  e_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[CHARACTER]");
      
    to_c = eif_pointer_function ("to_c", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[CHARACTER]");
      
    to_c = eif_pointer_function ("to_c", tid);
    f_capacity = eif_integer_function ("count", tid);
  }

  
  // Allocate memory
  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_array));
  if (old != NULL)
    result = (unsigned char *)CoTaskMemAlloc (capacity*(sizeof(unsigned char)));
  else
    result = old;


  memcpy (result, (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))to_c)(eif_access(e_array)), capacity*(sizeof(unsigned char)));

  eif_wean (e_array);
  return result;
};
//----------------------------------------------------------------------------

long * ecom_runtime_ec::ccom_ec_array_long (EIF_REFERENCE a_ref, int dimension, long * old)

// Create C array of long from Eiffel array.
{
  EIF_OBJECT e_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_INTEGER_FUNCTION f_capacity = 0;
  EIF_POINTER_FUNCTION to_c = 0;

  long * result = 0;
  int capacity = 0;

  e_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[INTEGER]");
      
    to_c = eif_pointer_function ("to_c", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[INTEGER]");
      
    to_c = eif_pointer_function ("to_c", tid);
    f_capacity = eif_integer_function ("count", tid);
  }

  
  // Allocate memory
  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_array));
  if (old != NULL)
    result = (long *)CoTaskMemAlloc (capacity*(sizeof(long)));
  else
    result = old;


  memcpy (result, (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))to_c)
      (eif_access(e_array)), capacity*(sizeof(long)) );

  eif_wean (e_array);
  return result;
};
//----------------------------------------------------------------------------

unsigned long * ecom_runtime_ec::ccom_ec_array_unsigned_long (EIF_REFERENCE a_ref, int dimension, unsigned long * old)

// Create C array of long from Eiffel array.
{
  EIF_OBJECT e_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_INTEGER_FUNCTION f_capacity = 0;
  EIF_POINTER_FUNCTION to_c = 0;

  unsigned long * result = 0;
  int capacity = 0;

  e_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[INTEGER]");
      
    to_c = eif_pointer_function ("to_c", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[INTEGER]");
      
    to_c = eif_pointer_function ("to_c", tid);
    f_capacity = eif_integer_function ("count", tid);
  }

  
  // Allocate memory
  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_array));
  if (old != NULL)
    result = (unsigned long *)CoTaskMemAlloc (capacity*(sizeof(unsigned long)));
  else
    result = old;


  memcpy (result, (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))to_c)
      (eif_access(e_array)), capacity*(sizeof(unsigned long)) );

  eif_wean (e_array);
  return result;
};
//----------------------------------------------------------------------------

int * ecom_runtime_ec::ccom_ec_array_integer (EIF_REFERENCE a_ref, int dimension, int * old)

// Create C array of long from Eiffel array.
{
  EIF_OBJECT e_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_id = -1;
  
  EIF_INTEGER_FUNCTION f_capacity = 0;
  EIF_POINTER_FUNCTION to_c = 0;

  int * result = 0;
  int capacity = 0;

  e_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_id)
      multi_dim_id = eif_type_id ("ECOM_ARRAY[INTEGER]");
      
    to_c = eif_pointer_function ("to_c", multi_dim_id);
    f_capacity = eif_integer_function ("count", multi_dim_id);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[INTEGER]");
      
    to_c = eif_pointer_function ("to_c", tid);
    f_capacity = eif_integer_function ("count", tid);
  }

  
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_array));
  if (old != NULL)
    result = (int *)CoTaskMemAlloc (capacity*(sizeof(int)));
  else
    result = old;


  memcpy (result, (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))to_c)
      (eif_access(e_array)), capacity*(sizeof(int)) );

  eif_wean (e_array);
  return result;
};
//----------------------------------------------------------------------------

unsigned int * ecom_runtime_ec::ccom_ec_array_unsigned_integer (EIF_REFERENCE a_ref, int dimension, unsigned int * old)

// Create C array of long from Eiffel array.
{
  EIF_OBJECT e_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_INTEGER_FUNCTION f_capacity = 0;
  EIF_POINTER_FUNCTION to_c = 0;

  unsigned int * result = 0;
  int capacity = 0;

  e_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[INTEGER]");
      
    to_c = eif_pointer_function ("to_c", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[INTEGER]");
      
    to_c = eif_pointer_function ("to_c", tid);
    f_capacity = eif_integer_function ("count", tid);
  }

  
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_array));
  if (old != NULL)
    result = (unsigned int *)CoTaskMemAlloc (capacity*(sizeof(unsigned int)));
  else
    result = old;


  memcpy (result, (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))to_c)
      (eif_access(e_array)), capacity*(sizeof(unsigned int)) );

  eif_wean (e_array);
  return result;
};
//----------------------------------------------------------------------------

float * ecom_runtime_ec::ccom_ec_array_float (EIF_REFERENCE a_ref, int dimension, float * old)

// Create C array of float from Eiffel array.
{
  EIF_OBJECT e_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_INTEGER_FUNCTION f_capacity = 0;
  EIF_POINTER_FUNCTION to_c = 0;

  float * result = 0;
  int capacity = 0;

  e_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[REAL]");
      
    to_c = eif_pointer_function ("to_c", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[REAL]");
      
    to_c = eif_pointer_function ("to_c", tid);
    f_capacity = eif_integer_function ("count", tid);
  }

  
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_array));
  if (old != NULL)
    result = (float *)CoTaskMemAlloc (capacity*(sizeof(float)));
  else
    result = old;


  memcpy (result, (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))to_c)
      (eif_access(e_array)), capacity*(sizeof(float)));

  eif_wean (e_array);
  return result;
};
//----------------------------------------------------------------------------

double * ecom_runtime_ec::ccom_ec_array_double (EIF_REFERENCE a_ref, int dimension, double * old)

// Create C array of double from Eiffel array.
{
  EIF_OBJECT e_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_INTEGER_FUNCTION f_capacity = 0;
  EIF_POINTER_FUNCTION to_c = 0;

  double * result = 0;
  int capacity = 0;

  e_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[DOUBLE]");
      
    to_c = eif_pointer_function ("to_c", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[DOUBLE]");
      
    to_c = eif_pointer_function ("to_c", tid);
    f_capacity = eif_integer_function ("count", tid);
  }

  
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_array));
  if (old != NULL)
    result = (double *)CoTaskMemAlloc (capacity*(sizeof(double)));
  else
    result = old;


  memcpy (result, (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))to_c)
      (eif_access(e_array)), capacity*(sizeof(double)));

  eif_wean (e_array);
  return result;
};
//----------------------------------------------------------------------------

short * ecom_runtime_ec::ccom_ec_array_short (EIF_REFERENCE a_ref, int dimension, short * old)

// Create C array of short from Eiffel array.
{
  EIF_OBJECT e_short_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_INTEGER_FUNCTION f_item = 0, f_capacity = 0;

  short * short_array = 0;
  short a_short = 0;
  int capacity = 0;

  e_short_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[INTEGER]");
      
    f_item = eif_integer_function ("array_item", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[INTEGER]");
      
    f_item = eif_integer_function ("item", tid);
    f_capacity = eif_integer_function ("count", tid);
  }
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_short_array));

  short_array = (short *)CoTaskMemAlloc (capacity*(sizeof(short)));

  for (int i=0; i < capacity; i++)
  {
    a_short = (short)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE, EIF_INTEGER))f_item)
        (eif_access(e_short_array), ((EIF_INTEGER)(i+1)));
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

unsigned short * ecom_runtime_ec::ccom_ec_array_unsigned_short (EIF_REFERENCE a_ref, int dimension, unsigned short * old)

// Create C array of short from Eiffel array.
{
  EIF_OBJECT e_short_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  EIF_INTEGER_FUNCTION f_item = 0, f_capacity = 0;

  unsigned short * short_array = 0;
  unsigned short a_short = 0;
  int capacity = 0;

  e_short_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[INTEGER]");
      
    f_item = eif_integer_function ("array_item", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[INTEGER]");
      
    f_item = eif_integer_function ("item", tid);
    f_capacity = eif_integer_function ("count", tid);
  }
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_short_array));

  short_array = (unsigned short *)CoTaskMemAlloc (capacity*(sizeof(unsigned short)));

  for (int i=0; i < capacity; i++)
  {
    a_short = (unsigned short)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE, EIF_INTEGER))f_item)
        (eif_access(e_short_array), ((EIF_INTEGER)(i+1)));
    ccom_c_array_element (short_array, i, short) = a_short;
  }

  eif_wean (e_short_array);
  if (old != NULL)
  {
    memcpy (old, short_array, capacity*(sizeof(unsigned short)));
    return NULL;
  }
  else
    return short_array;
};
//----------------------------------------------------------------------------

HRESULT * ecom_runtime_ec::ccom_ec_array_hresult (EIF_REFERENCE a_ref, int dimension, HRESULT * old)

// Create C array of HRESULT from Eiffel array.
{
  EIF_OBJECT e_hresult_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_INTEGER_FUNCTION f_capacity = 0;
  EIF_REFERENCE_FUNCTION f_item = 0;

  HRESULT * hresult_array = 0;
  HRESULT hr = 0;
  int capacity = 0;

  e_hresult_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[ECOM_HRESULT]");
      
    f_item = eif_reference_function ("array_item", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[ECOM_HRESULT]");
      
    f_item = eif_reference_function ("item", tid);
    f_capacity = eif_integer_function ("count", tid);
  }
  // Allocate memory
  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_hresult_array));

  hresult_array = (HRESULT *)CoTaskMemAlloc (capacity*(sizeof(HRESULT)));

  for (int i=0; i < capacity; i++)
  {
    hr = ccom_ec_hresult ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_INTEGER))f_item)
        (eif_access(e_hresult_array), ((EIF_INTEGER)(i+1))));
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
  EIF_OBJECT e_currency_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_REFERENCE_FUNCTION f_item = 0;
  EIF_INTEGER_FUNCTION f_capacity = 0;

  CURRENCY * currency_array = 0;
  CURRENCY * p_currency = 0;
  int capacity = 0;

  e_currency_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[ECOM_CURRENCY]");
      
    f_item = eif_reference_function ("array_item", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[ECOM_CURRENCY]");
      
    f_item = eif_reference_function ("item", tid);
    f_capacity = eif_integer_function ("count", tid);
  }
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_currency_array));

  currency_array = (CURRENCY *)CoTaskMemAlloc (capacity*(sizeof(CURRENCY)));

  for (int i=0; i < capacity; i++)
  {
    p_currency = ccom_ec_pointed_currency ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_INTEGER))f_item)
        (eif_access(e_currency_array), ((EIF_INTEGER)(i+1))), NULL);
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
  EIF_OBJECT e_variant_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_REFERENCE_FUNCTION f_item = 0;
  EIF_INTEGER_FUNCTION f_capacity = 0;

  VARIANT * variant_array = 0;
  VARIANT * p_var = 0;
  int capacity = 0, i = 0;

  e_variant_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[ECOM_VARIANT]");
      
    f_item = eif_reference_function ("array_item", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[ECOM_VARIANT]");
      
    f_item = eif_reference_function ("item", tid);
    f_capacity = eif_integer_function ("count", tid);
  }
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_variant_array));

  variant_array = (VARIANT *) CoTaskMemAlloc (capacity * (sizeof (VARIANT)));

  for (i = 0; i < capacity; i++)
  {
    p_var = ccom_ec_pointed_variant ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_INTEGER))f_item)
        (eif_access(e_variant_array), ((EIF_INTEGER)(i+1))), NULL);
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
  EIF_OBJECT e_decimal_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_REFERENCE_FUNCTION f_item = 0;
  EIF_INTEGER_FUNCTION f_capacity = 0;

  DECIMAL * decimal_array = 0;
  DECIMAL * p_decimal = 0;
  int capacity = 0, i = 0;

  e_decimal_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[ECOM_DECIMAL]");
      
    f_item = eif_reference_function ("array_item", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[ECOM_DECIMAL]");
      
    f_item = eif_reference_function ("item", tid);
    f_capacity = eif_integer_function ("count", tid);
  }
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_decimal_array));

  decimal_array = (DECIMAL *) CoTaskMemAlloc (capacity * (sizeof (DECIMAL)));

  for (i = 0; i < capacity; i++)
  {
    p_decimal = ccom_ec_pointed_decimal ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_INTEGER))f_item)
        (eif_access(e_decimal_array), ((EIF_INTEGER)(i+1))), NULL);
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
  EIF_OBJECT e_boolean_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_BOOLEAN_FUNCTION f_item = 0;
  EIF_INTEGER_FUNCTION f_capacity = 0;

  VARIANT_BOOL * boolean_array = 0;
  VARIANT_BOOL a_bool = 0;
  int capacity = 0, i = 0;

  e_boolean_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[ECOM_BOOLEAN]");
      
    f_item = eif_boolean_function ("array_item", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[ECOM_BOOLEAN]");
      
    f_item = eif_boolean_function ("item", tid);
    f_capacity = eif_integer_function ("count", tid);
  }
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_boolean_array));

  boolean_array = (VARIANT_BOOL *) CoTaskMemAlloc (capacity * (sizeof (VARIANT_BOOL)));

  for (i = 0; i < capacity; i++)
  {
    a_bool = ccom_ec_boolean ((FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE, EIF_INTEGER))f_item)
        (eif_access(e_boolean_array), ((EIF_INTEGER)(i+1))));
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

LONGLONG * ecom_runtime_ec::ccom_ec_array_long_long (EIF_REFERENCE a_ref, int dimension, LONGLONG * old)

// Create C array of LONGLONG from Eiffel array.

{
  EIF_OBJECT e_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_id = -1;
  
  EIF_INTEGER_FUNCTION f_capacity = 0;
  EIF_POINTER_FUNCTION to_c = 0;

  LONGLONG * result = 0;
  int capacity = 0;

  e_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_id)
      multi_dim_id = eif_type_id ("ECOM_ARRAY[INTEGER_64]");
      
    to_c = eif_pointer_function ("to_c", multi_dim_id);
    f_capacity = eif_integer_function ("count", multi_dim_id);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[INTEGER_64]");
      
    to_c = eif_pointer_function ("to_c", tid);
    f_capacity = eif_integer_function ("count", tid);
  }

  
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_array));
  if (old != NULL)
    result = (LONGLONG *)CoTaskMemAlloc (capacity*(sizeof(LONGLONG)));
  else
    result = old;


  memcpy (result, (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))to_c)
      (eif_access(e_array)), capacity*(sizeof(LONGLONG)) );

  eif_wean (e_array);
  return result;
};

//-----------------------------------------------------------------------

ULONGLONG * ecom_runtime_ec::ccom_ec_array_ulong_long (EIF_REFERENCE a_ref, int dimension, ULONGLONG * old)

// Create C array of LONGLONG from Eiffel array.

{
  EIF_OBJECT e_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_id = -1;
  
  EIF_INTEGER_FUNCTION f_capacity = 0;
  EIF_POINTER_FUNCTION to_c = 0;

  ULONGLONG * result = 0;
  int capacity = 0;

  e_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_id)
      multi_dim_id = eif_type_id ("ECOM_ARRAY[INTEGER_64]");
      
    to_c = eif_pointer_function ("to_c", multi_dim_id);
    f_capacity = eif_integer_function ("count", multi_dim_id);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[INTEGER_64]");
      
    to_c = eif_pointer_function ("to_c", tid);
    f_capacity = eif_integer_function ("count", tid);
  }

  
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_array));
  if (old != NULL)
    result = (ULONGLONG *)CoTaskMemAlloc (capacity*(sizeof(ULONGLONG)));
  else
    result = old;


  memcpy (result, (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))to_c)
      (eif_access(e_array)), capacity*(sizeof(ULONGLONG)) );

  eif_wean (e_array);
  return result;
};
//------------------------------------------------------------------------------------

IDispatch * ecom_runtime_ec::ccom_ec_array_dispatch (EIF_REFERENCE a_ref, int dimension, IDispatch * old)

// Create C array of IDispatch from Eiffel array.
{
  EIF_OBJECT e_dispatch_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_REFERENCE_FUNCTION f_item = 0;
  EIF_INTEGER_FUNCTION f_capacity = 0;

  IDispatch * dispatch_array = 0;
  IDispatch * an_interface = 0;
  int capacity = 0, i = 0;

  e_dispatch_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE]");
      
    f_item = eif_reference_function ("array_item", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[ECOM_AUTOMATION_INTERFACE]");
      
    f_item = eif_reference_function ("item", tid);
    f_capacity = eif_integer_function ("count", tid);
  }
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_dispatch_array));

  dispatch_array = (IDispatch *) CoTaskMemAlloc (capacity * (sizeof (IDispatch *)));

  for (i = 0; i < capacity; i++)
  {
    an_interface = ccom_ec_dispatch ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_INTEGER))f_item)
        (eif_access(e_dispatch_array), ((EIF_INTEGER)(i+1))));
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
  EIF_OBJECT e_unknown_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_REFERENCE_FUNCTION f_item = 0;
  EIF_INTEGER_FUNCTION f_capacity = 0;

  IUnknown * unknown_array = 0;
  IUnknown * an_interface = 0;
  int capacity = 0, i = 0;

  e_unknown_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE]");
      
    f_item = eif_reference_function ("array_item", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[ECOM_UNKNOWN_INTERFACE]");
      
    f_item = eif_reference_function ("item", tid);
    f_capacity = eif_integer_function ("count", tid);
  }
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_unknown_array));

  unknown_array = (IUnknown *) CoTaskMemAlloc (capacity * (sizeof (IUnknown *)));

  for (i = 0; i < capacity; i++)
  {
    an_interface = ccom_ec_unknown ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_INTEGER))f_item)
        (eif_access(e_unknown_array), ((EIF_INTEGER)(i+1))));
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
  EIF_OBJECT e_lpwstr_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_REFERENCE_FUNCTION f_item = 0;
  EIF_INTEGER_FUNCTION f_capacity = 0;

  LPWSTR * lpwstr_array = 0;
  LPWSTR a_string = 0;
  int capacity = 0, i = 0;

  e_lpwstr_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[STRING]");
      
    f_item = eif_reference_function ("array_item", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[STRING]");
      
    f_item = eif_reference_function ("item", tid);
    f_capacity = eif_integer_function ("count", tid);
  }
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_lpwstr_array));

  lpwstr_array = (LPWSTR *)CoTaskMemAlloc (capacity * (sizeof (LPWSTR)));

  for (i = 0; i < capacity; i++)
  {
    a_string = ccom_ec_lpwstr ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_INTEGER))f_item)
        (eif_access(e_lpwstr_array), ((EIF_INTEGER)(i+1))), NULL);
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
  EIF_OBJECT e_lpstr_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_REFERENCE_FUNCTION f_item = 0;
  EIF_INTEGER_FUNCTION f_capacity = 0;

  LPSTR * lpstr_array = 0;
  LPSTR a_string = 0;
  int capacity = 0, i = 0;

  e_lpstr_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[STRING]");
      
    f_item = eif_reference_function ("array_item", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[STRING]");
      
    f_item = eif_reference_function ("item", tid);
    f_capacity = eif_integer_function ("count", tid);
  }
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_lpstr_array));

  lpstr_array = (LPSTR *) CoTaskMemAlloc (capacity * (sizeof (LPSTR)));

  for (i = 0; i < capacity; i++)
  {
    a_string = ccom_ec_lpstr ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_INTEGER))f_item)
        (eif_access(e_lpstr_array), ((EIF_INTEGER)(i+1))), NULL);
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
  EIF_OBJECT e_bstr_array = 0;

  static EIF_TYPE_ID tid = -1;
  static EIF_TYPE_ID multi_dim_tid = -1;
  
  EIF_REFERENCE_FUNCTION f_item = 0;
  EIF_INTEGER_FUNCTION f_capacity = 0;

  BSTR * bstr_array = 0;
  BSTR a_string;
  int capacity = 0, i = 0;

  e_bstr_array = eif_protect (a_ref);

  if (dimension > 1)
  {
    if (-1 == multi_dim_tid)
      multi_dim_tid = eif_type_id ("ECOM_ARRAY[STRING]");
      
    f_item = eif_reference_function ("array_item", multi_dim_tid);
    f_capacity = eif_integer_function ("count", multi_dim_tid);
  }
  else
  {
    if (-1 == tid)
      tid = eif_type_id ("ARRAY[STRING]");
      
    f_item = eif_reference_function ("item", tid);
    f_capacity = eif_integer_function ("count", tid);
  }
  // Allocate memory
  

  capacity = (int)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))f_capacity)(eif_access(e_bstr_array));

  bstr_array = (BSTR *)CoTaskMemAlloc (capacity * (sizeof (BSTR)));

  for (i = 0; i < capacity; i++)
  {
    a_string = ccom_ec_bstr ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_INTEGER))f_item)
        (eif_access(e_bstr_array), ((EIF_INTEGER)(i+1))));
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
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_CHARACTER_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  char an_element = 0;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [CHARACTER]");
    
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect (eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect (eif_field(eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_I1, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_character_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)
      (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = (char)(FUNCTION_CAST (EIF_CHARACTER, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index));

      hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_REAL_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  float a_float = 0;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);

  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid) 
    ecom_array_tid = eif_type_id ("ECOM_ARRAY[REAL]");
    
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY[INTEGER]");

  dimensions = (int) eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect (eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect (eif_field (eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_R4, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_real_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create) (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      a_float = (float)(FUNCTION_CAST (EIF_REAL, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index));
      hr = SafeArrayPutElement(c_safe_array, c_index, &a_float);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_INTEGER_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  long an_element = 0;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [INTEGER]");
    
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_I4, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_integer_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)
      (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = (long)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index));
      hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_int64 (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_INTEGER_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  LONGLONG an_element = 0;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [INTEGER_64]");
    
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_I8, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_integer_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)
      (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = (LONGLONG)(FUNCTION_CAST (EIF_INTEGER_64, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index));
      hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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

SAFEARRAY * ecom_runtime_ec::ccom_ec_safearray_uint64 (EIF_REFERENCE a_ref)

// Create C SAFEARRAY from Eiffel array
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_INTEGER_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  ULONGLONG an_element = 0;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [INTEGER_64]");
    
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_UI8, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_integer_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)
      (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = (ULONGLONG)(FUNCTION_CAST (EIF_INTEGER_64, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index));
      hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_INTEGER_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  short an_element = 0;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [INTEGER]");
    
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect ( eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_I2, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_integer_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)
      (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = (short)(FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index));
      hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_DOUBLE_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  double an_element = 0;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [DOUBLE]");
    
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int) eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect ( eif_field(eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect ( eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect (eif_field(eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_R8, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_double_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create) (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = (double)(FUNCTION_CAST (EIF_DOUBLE, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index));

      hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_BOOLEAN_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  VARIANT_BOOL an_element = 0;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [BOOLEAN]");
    
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int) eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *)(FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_BOOL, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_boolean_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)
      (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = ccom_ec_boolean ((FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index)));
      hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2= 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_REFERENCE_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  DATE an_element;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [DATE_TIME]");
    
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect (eif_field (eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect (eif_field (eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_DATE, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_reference_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)
      (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = ccom_ec_date ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index)));
      hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_REFERENCE_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  HRESULT an_element = 0;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [ECOM_HRESULT]");
    
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);


  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect ( eif_field(eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_HRESULT, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_reference_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)
      (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = ccom_ec_hresult ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index)));
      hr = SafeArrayPutElement(c_safe_array, c_index, &an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_REFERENCE_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  VARIANT * an_element = 0;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [ECOM_VARIANT]");
  
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);

  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect ( eif_field(eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_VARIANT, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_reference_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)
      (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = ccom_ec_pointed_variant ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index)), NULL);
      hr = SafeArrayPutElement(c_safe_array, c_index, an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_REFERENCE_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create;
  long * c_index = 0;
  CURRENCY * an_element = 0;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [ECOM_CURRENCY]");
  
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);

  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect ( eif_field(eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_CY, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_reference_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)
      (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = ccom_ec_pointed_currency ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index)), NULL);
      hr = SafeArrayPutElement(c_safe_array, c_index, an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_REFERENCE_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  DECIMAL * an_element = 0;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [ECOM_DECIMAL]");
  
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);

  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect ( eif_field(eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_DECIMAL, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_reference_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)
      (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = ccom_ec_pointed_decimal ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
            (eif_access (eif_safe_array), eif_access (eif_index)), NULL);
      hr = SafeArrayPutElement(c_safe_array, c_index, an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_REFERENCE_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  BSTR an_element;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [STRING]");
    
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);

  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect ( eif_field(eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_BSTR, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_reference_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)
      (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = ccom_ec_bstr ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index)));

      hr = SafeArrayPutElement(c_safe_array, c_index, an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_REFERENCE_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  IDispatch * an_element = 0;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE]");
    
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);

  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *)(FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect ( eif_field(eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *)(FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *)(FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_DISPATCH, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_reference_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)
      (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = ccom_ec_dispatch ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index)));
        
      hr = SafeArrayPutElement(c_safe_array, c_index, an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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
  EIF_GET_CONTEXT
  EIF_OBJECT eif_safe_array = 0;
  static EIF_TYPE_ID ecom_array_tid = -1;
  
  EIF_INTEGER * lower_indexes = 0, * element_counts = 0, * upper_indexes = 0;
  EIF_INTEGER * tmp_index = 0;
  int dimensions = 0, loop_control = 0, i = 0;
  EIF_POINTER_FUNCTION f_to_c = 0;
  EIF_OBJECT tmp_object1 = 0, tmp_object2 = 0, tmp_object3 = 0, eif_index = 0;
  SAFEARRAYBOUND * array_bound = 0;
  SAFEARRAY * c_safe_array = 0;
  EIF_REFERENCE_FUNCTION f_array_item = 0;
  EIF_PROCEDURE p_array_create = 0;
  long * c_index = 0;
  IUnknown * an_element = 0;
  HRESULT hr = 0;
  long total_elements_count;

  // protect eiffel object
  eif_safe_array = eif_protect (a_ref);


  // get dimensions, lower indexes, upper indexes, and elements counts from Eiffel ECOM_ARRAY object

  if (-1 == ecom_array_tid)
    ecom_array_tid = eif_type_id ("ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE]");
  
  if (-1 == int_array_tid)
    int_array_tid = eif_type_id ("ARRAY [INTEGER]");

  dimensions = (int)eif_field (eif_access (eif_safe_array), "dimension_count", EIF_INTEGER);

  f_to_c = eif_pointer_function ("to_c", int_array_tid);

  tmp_object1 = eif_protect ( eif_field (eif_access (eif_safe_array), "lower_indices", EIF_REFERENCE));
  lower_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object1));

  tmp_object2 = eif_protect ( eif_field(eif_access (eif_safe_array), "element_counts", EIF_REFERENCE));
  element_counts = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object2));

  tmp_object3 = eif_protect ( eif_field (eif_access (eif_safe_array), "upper_indices", EIF_REFERENCE));
  upper_indexes = (EIF_INTEGER *) (FUNCTION_CAST (EIF_POINTER, (EIF_REFERENCE))f_to_c)(eif_access (tmp_object3));

  // create SAFEARRAYBOUND
  array_bound = (SAFEARRAYBOUND *) malloc (dimensions * sizeof (SAFEARRAYBOUND));

  total_elements_count = 1;
  for (i = 0; i < dimensions; i++)
  {
    array_bound[i].lLbound  = (long) lower_indexes [dimensions - i - 1];
    array_bound[i].cElements  = (long) element_counts [dimensions - i - 1];
    total_elements_count *= (long) element_counts [dimensions - i - 1];
  }

  // Create SAFEARRAY
  c_safe_array = SafeArrayCreate (VT_UNKNOWN, dimensions, array_bound);
  if (c_safe_array == NULL)
  {
    enomem ();
  };

  f_array_item = eif_reference_function ("item", ecom_array_tid);
  p_array_create = eif_procedure ("make", int_array_tid);

  // Create index to access Eiffel object
  eif_index = eif_create (int_array_tid);

  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))p_array_create)
      (eif_access (eif_index), 1, dimensions);

  // create index to access C object
  c_index = (long *)malloc (dimensions * sizeof (long));

  tmp_index = (EIF_INTEGER *)malloc (dimensions * sizeof (EIF_INTEGER));
  memcpy (tmp_index, lower_indexes, (dimensions *sizeof (EIF_INTEGER)));

  //
  // copy elements from eiffel array to c array
  if (total_elements_count != 0 )
  {
    do
    {
      eif_make_from_c (eif_access (eif_index), tmp_index, dimensions, EIF_INTEGER);

      for (i = 0; i < dimensions; i++)
      {
        c_index[i] = (long) tmp_index [dimensions - i - 1];
      }
      an_element = ccom_ec_unknown ((FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))f_array_item)
          (eif_access (eif_safe_array), eif_access (eif_index)));
      
        
      hr = SafeArrayPutElement(c_safe_array, c_index, an_element);
      if (FAILED (hr))
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }

      loop_control = rt_ce.ccom_safearray_next_index (dimensions, lower_indexes, upper_indexes, tmp_index);
    } while (loop_control != 0);
  };

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
  EIF_OBJECT eif_object = 0;
  void ** result = 0;

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

  void ** result = 0;

  result = (void **) CoTaskMemAlloc (sizeof (void *));
  * result = a_pointer;

  return result;
};
//-----------------------------------------------------------------------------------
