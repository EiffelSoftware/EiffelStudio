//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 2001.
//
//  File:   ecom_runtime_c_e.cpp
//
//  Contents: Runtime conversion functions from C to Eiffel
//
//--------------------------------------------------------------------------

#include "ecom_runtime_c_e.h"

ecom_runtime_ce rt_ce;

static EIF_TYPE_ID int_array_id = -1;

//-------------------------------------------------------------------------
void ecom_runtime_ce::free_memory_bstr (BSTR a_bstr)
{
  if (a_bstr != NULL)
    SysFreeString (a_bstr);
};

//-------------------------------------------------------------------------
void ecom_runtime_ce::free_memory_safearray (SAFEARRAY * a_safearray)
{
  if (a_safearray != NULL)
    SafeArrayDestroy (a_safearray);
};

//-------------------------------------------------------------------------
EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_enum_variant ( IEnumVARIANT * a_interface_pointer )

/*-----------------------------------------------------------
  Convert IEnumVARIANT *  to IENUM_VARIANT_INTERFACE.
-----------------------------------------------------------*/
{
  if (a_interface_pointer != NULL)
    return ccom_ce_pointed_interface (a_interface_pointer, "IENUM_VARIANT_IMPL_PROXY");
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_pointed_enum_variant( IEnumVARIANT * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
  Convert IEnumVARIANT * *  to CELL [IENUM_VARIANT_INTERFACE].
-----------------------------------------------------------*/
{
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE set_item = 0;
  EIF_OBJECT result = 0;
  EIF_OBJECT tmp_object = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("CELL [IENUM_VARIANT_INTERFACE]");
    
  set_item = eif_procedure ("put", type_id);

  if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
  {
    result = eif_create (type_id);
  }
  else
    result = an_object;
  
  if ((a_pointer != NULL) && (*a_pointer != NULL))
    tmp_object = eif_protect (ccom_ce_pointed_enum_variant (*(IEnumVARIANT * *) a_pointer));
  
  set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
  
  if (tmp_object != NULL)
    eif_wean (tmp_object);
    
  if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
    return eif_wean (result);
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_ifont( IFont * a_interface_pointer )

/*-----------------------------------------------------------
  Convert IFont *  to IFONT_INTERFACE.
-----------------------------------------------------------*/
{
  if (a_interface_pointer != NULL)
    return rt_ce.ccom_ce_pointed_interface (a_interface_pointer, "IFONT_IMPL_PROXY");
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_pointed_ifont( IFont * * a_pointer, EIF_OBJECT an_object )

/*-----------------------------------------------------------
  Convert IFont * *  to CELL [IFONT_INTERFACE].
-----------------------------------------------------------*/
{
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE set_item = 0;
  EIF_OBJECT result = 0;
  EIF_OBJECT tmp_object = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("CELL [IFONT_INTERFACE]");
    
  set_item = eif_procedure ("put", type_id);

  if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
  {
    result = eif_create (type_id);
  }
  else
    result = an_object;
  
  if ((a_pointer != NULL) && (*a_pointer != NULL))
    tmp_object = eif_protect (ccom_ce_pointed_ifont (*(IFont * *) a_pointer));
  
  set_item (eif_access (result), ((tmp_object != NULL) ? eif_access (tmp_object) : NULL));
  
  if (tmp_object != NULL)
    eif_wean (tmp_object);
    
  if ((an_object  ==  NULL) || (eif_access (an_object)  ==  NULL))
    return eif_wean (result);
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_currency (CURRENCY a_currency)

// Create Eiffel object ECOM_CURRENCY from C
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make  = 0;
  EIF_POINTER an_item = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ECOM_CURRENCY");
    
  make = eif_procedure ("make", type_id);
  result = eif_create (type_id);
  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE))make) (eif_access (result));
  an_item = eif_field (eif_access (result), "item", EIF_POINTER);
  memcpy (an_item, &a_currency, sizeof (CURRENCY));
  return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_decimal (DECIMAL a_decimal)

// Create ECOM_DECIMAL from C
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0;
  EIF_POINTER an_item = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ECOM_DECIMAL");
    
  make = eif_procedure ("make", type_id);
  result = eif_create (type_id);
  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE))make) (eif_access (result));
  an_item = eif_field (eif_access (result), "item", EIF_POINTER);
  memcpy (an_item, &a_decimal, sizeof (DECIMAL));
  return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_variant (VARIANT a_variant)

// Create ECOM_VARIANT from C
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0;
  EIF_POINTER an_item = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ECOM_VARIANT");
    
  make = eif_procedure ("make", type_id);
  result = eif_create (type_id);
  nstcall = 0;
  (FUNCTION_CAST (void, (EIF_REFERENCE))make) (eif_access (result));
  an_item = eif_field (eif_access (result), "item", EIF_POINTER);
  memcpy (an_item, &a_variant, sizeof (VARIANT));
  return eif_wean (result);
};

//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_long_long  (LARGE_INTEGER a_large_int)

// Create ECOM_LARGE_INTEGER from C structure
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0;
  EIF_POINTER an_item = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ECOM_LARGE_INTEGER");
    
  make = eif_procedure ("make", type_id);
  result = eif_create (type_id);
  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE))make) (eif_access (result));
  an_item = eif_field (eif_access (result), "item", EIF_POINTER);
  memcpy (an_item, &a_large_int, sizeof (LARGE_INTEGER));
  return eif_wean (result);
};
//-------------------------------------------------------------------------
EIF_REFERENCE ecom_runtime_ce::ccom_ce_u_long_long  (ULARGE_INTEGER a_large_int)

// Create ECOM_ULARGE_INTEGER from C structure
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0;
  EIF_POINTER an_item = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ECOM_ULARGE_INTEGER");
    
  make = eif_procedure ("make", type_id);
  result = eif_create (type_id);
  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE))make) (eif_access (result));
  an_item = eif_field (eif_access (result), "item", EIF_POINTER);
  memcpy (an_item, &a_large_int, sizeof (ULARGE_INTEGER));
  return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_record (void * a_record_pointer, char * a_class_name, int a_size)

// Create Eiffel object from C structure
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0;
  EIF_POINTER an_item = 0;

  if (a_record_pointer != NULL)
  {
    type_id = eif_type_id (a_class_name);

    make = eif_procedure ("make", type_id);
    result = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE))make) (eif_access (result));
    an_item = eif_field (eif_access (result), "item", EIF_POINTER);
    memcpy (an_item, a_record_pointer, a_size);
    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_date (DATE a_date)

//  Create an Eiffel DATE_TIME object with 'a_date'.
{
  EIF_GET_CONTEXT
  SYSTEMTIME a_sys_time;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE date_make = 0;
  EIF_OBJECT date_object = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("DATE_TIME");

  date_object = eif_create (type_id);

  if ( VariantTimeToSystemTime( a_date, &a_sys_time))
  {
    date_make = eif_procedure ("make", type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER,
    EIF_INTEGER, EIF_INTEGER))date_make) (eif_access (date_object), a_sys_time.wYear,
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
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ECOM_HRESULT");
    
  make = eif_procedure ("make_from_integer", type_id);
  result = eif_create (type_id);

  nstcall = 0;

  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER))make) (eif_access (result), (EIF_INTEGER) a_hresult);
  return eif_wean (result);
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_bstr (BSTR a_bstr)

// Create Eiffel STRING from Basic string
{
  if (a_bstr != NULL)
    return eif_wean (bstr_to_eif_obj (a_bstr));
  else
    return NULL;
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

EIF_REFERENCE ecom_runtime_ce::ccom_ce_lpstr (LPSTR a_string, EIF_OBJECT an_object)

// Create Eiffel STRING from LPSTR
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE string_make = 0;
  EIF_PROCEDURE from_c = 0;

  if (a_string != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("STRING");

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
    {
      if (a_string != NULL)
      {
        result = henter (RTMS (a_string));
      }
      else
      {
        string_make = eif_procedure ("make", type_id);
        result = eif_create (type_id);
        nstcall = 0;
        (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER))string_make) (eif_access (result), 0);
      }
    }
    else
    {
      if (a_string != NULL)
      {
        from_c = eif_procedure ("from_c", type_id);
        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))from_c) (eif_access (an_object), a_string);
      }
    }
    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_lpwstr (LPWSTR a_string, EIF_OBJECT an_object)

// Create Eiffel String from LPWSTR
{
  EIF_GET_CONTEXT
  EIF_OBJECT local_obj = 0;
  char * string = 0;
  size_t size = 0, size_wide = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE string_make = 0;
  EIF_PROCEDURE from_c = 0;

  if (a_string != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("STRING");

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
    {
      if (a_string != NULL)
      {
        size_wide = wcslen(a_string);
        size = wcstombs (NULL, a_string, size_wide + 1);
        string = (char *)malloc(size + 1);

        wcstombs (string, a_string, size_wide + 1);
        local_obj = henter(RTMS(string));
        free (string);
      }
      else
      {
        string_make = eif_procedure ("make", type_id);
        local_obj = eif_create (type_id);
        nstcall = 0;
        (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER))string_make) (eif_access (local_obj), 0);
      }
    }
    else
    {
      if (a_string != NULL)
      {
        size_wide = wcslen(a_string);
        size = wcstombs (NULL, a_string, size_wide + 1);
        string = (char *)malloc(size + 1);
        wcstombs (string, a_string, size_wide + 1);

        from_c = eif_procedure ("from_c", type_id);
        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))from_c) (eif_access (an_object), string);

        free (string);
      }
    }
    return eif_wean (local_obj);
  }
  else
    return NULL;
};
//----------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_variant (VARIANT * a_variant)

// Create Eiffel ECOM_VARIANT from C
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0;

  if (a_variant != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_VARIANT");

    make = eif_procedure ("make_from_pointer", type_id);
    result = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_POINTER))make) (eif_access (result), (EIF_POINTER)a_variant);

    EIF_PROCEDURE set_unshared = NULL;
    set_unshared = eif_procedure ("set_unshared", type_id);
    (FUNCTION_CAST (void, (EIF_REFERENCE))set_unshared) (eif_access (result));

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_unknown (IUnknown * a_unknown)

// Create Eiffel ECOM_UNKNOWN_INTERFACE from C
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0;

  if (a_unknown != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_UNKNOWN_INTERFACE");

    make = eif_procedure ("make_from_pointer", type_id);
    result = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_POINTER))make) (eif_access (result), (EIF_POINTER)a_unknown);
    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_dispatch (IDispatch * a_dispatch)

// Create Eiffel ECOM_AUTOMATION_INTERFACE from C
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0;

  if (a_dispatch != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_AUTOMATION_INTERFACE");

    make = eif_procedure ("make_from_pointer", type_id);
    result = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_POINTER))make)(eif_access (result), (EIF_POINTER)a_dispatch);
    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_unsigned_short (unsigned short * an_integer, EIF_OBJECT an_object)

// Create INTEGER_REF from integer
{
  if (an_integer != NULL)
    return ccom_ce_pointed_short ((short *) an_integer, an_object);
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_short (short * an_integer, EIF_OBJECT an_object)

// Create INTEGER_REF from integer
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE set_item = 0;

  if (an_integer != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("INTEGER_REF");

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = eif_create (type_id);
    else
      result = an_object;

    set_item = eif_procedure ("set_item", type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER))set_item) (eif_access (result), (EIF_INTEGER)*an_integer);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_hresult (HRESULT * a_hresult, EIF_OBJECT an_object)

// Create ECOM_HRESULT from HRESULT *
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE set_item = 0;

  if (a_hresult != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_HRESULT");

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = eif_create (type_id);
    else
      result = an_object;

    set_item = eif_procedure ("set_item", type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER))set_item) (eif_access (result), (EIF_INTEGER)*a_hresult);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};

//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_unsigned_long (unsigned long * an_integer, EIF_OBJECT an_object)
{
  if (an_integer != NULL)
    return ccom_ce_pointed_long ( (long *)an_integer, an_object);
  else
    return NULL;
}

//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_long (long * an_integer, EIF_OBJECT an_object)

// Create INTEGER_REF from integer
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE set_item = 0;

  if (an_integer != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("INTEGER_REF");

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = eif_create (type_id);
    else
      result = an_object;

    set_item = eif_procedure ("set_item", type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER))set_item) (eif_access (result), (EIF_INTEGER)*an_integer);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_unsigned_integer (unsigned int * an_integer, EIF_OBJECT an_object)
{
  if (an_integer != NULL)
    return ccom_ce_pointed_integer ( (int *)an_integer, an_object);
  else
    return NULL;
}
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_integer (int * an_integer, EIF_OBJECT an_object)

// Create INTEGER_REF from integer
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE set_item;

  if (an_integer != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("INTEGER_REF");

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = eif_create (type_id);
    else
      result = an_object;

    set_item = eif_procedure ("set_item", type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER))set_item)(eif_access (result), (EIF_INTEGER)*an_integer);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_real (EIF_REAL * a_real, EIF_OBJECT an_object)

// Create REAL_REF from real
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_SET_REAL_ITEM set_item = 0;

  if (a_real != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("REAL_REF");

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = eif_create (type_id);
    else
      result = an_object;

    set_item = (EIF_SET_REAL_ITEM)eif_procedure ("set_item", type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REAL))set_item)(eif_access (result), (EIF_REAL)*a_real);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_double (EIF_DOUBLE * a_double, EIF_OBJECT an_object)

// Create DOUBLE_REF from double
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE set_item = 0;

  if (a_double != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("DOUBLE_REF");

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = eif_create (type_id);
    else
      result = an_object;

    set_item = eif_procedure ("set_item", type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_DOUBLE))set_item)(eif_access (result), *a_double);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};

//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_unsigned_character (unsigned char * a_character, EIF_OBJECT an_object)
{
  if (a_character != NULL)
    return ccom_ce_pointed_character ( (char *)a_character, an_object);
  else
    return NULL;
}


//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_character (char * a_character, EIF_OBJECT an_object)

// Create CHARACTER_REF from character
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id= -1;
  EIF_PROCEDURE set_item = 0;

  if (a_character != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("CHARACTER_REF");

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = eif_create (type_id);
    else
      result = an_object;

    set_item = eif_procedure ("set_item", type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE,
    EIF_CHARACTER))set_item) (eif_access (result), (EIF_CHARACTER)*a_character);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_boolean (VARIANT_BOOL * a_bool, EIF_OBJECT an_object)

// Create BOOLEAN_REF from pointer to VARIANT_BOOL
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE set_item = 0;

  if (a_bool != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("BOOLEAN_REF");

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = eif_create (type_id);
    else
      result = an_object;

    set_item = eif_procedure ("set_item", type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_BOOLEAN))set_item) (eif_access (result), ccom_ce_boolean (*a_bool));

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_currency (CURRENCY * a_currency)

// Create Eiffel object ECOM_CURRENCY from C
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE currency_make = 0;

  if (a_currency != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_CURRENCY");

    currency_make = eif_procedure ("make_from_pointer", type_id);
    result = eif_create (type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE,
    EIF_POINTER))currency_make)(eif_access (result), (EIF_POINTER)a_currency);

    EIF_PROCEDURE set_unshared = NULL;
    set_unshared = eif_procedure ("set_unshared", type_id);
    (FUNCTION_CAST (void, (EIF_REFERENCE))set_unshared) (eif_access (result));

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_decimal (DECIMAL * a_decimal)

// Create ECOM_DECIMAL from C
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0;

  if (a_decimal != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_DECIMAL");

    make = eif_procedure ("make_from_pointer", type_id);
    result = eif_create (type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_POINTER))make)(eif_access (result), (EIF_POINTER)a_decimal);

    EIF_PROCEDURE set_unshared = NULL;
    set_unshared = eif_procedure ("set_unshared", type_id);
    (FUNCTION_CAST (void, (EIF_REFERENCE))set_unshared) (eif_access (result));

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_record (void * a_record_pointer, char * a_class_name)

// Create Eiffel object from C structure
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = NULL;
  EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = NULL;

  if (a_record_pointer != NULL)
  {
    type_id = eif_type_id (a_class_name);

    make = eif_procedure ("make_from_pointer", type_id);
    result = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))make) (eif_access (result), (EIF_POINTER)a_record_pointer);


    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_interface (void * a_interface_pointer, char * a_class_name)

// Create Eiffel object from COM interface.
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0;

  if (a_interface_pointer != NULL)
  {
    type_id = eif_type_id (a_class_name);
    make = eif_procedure ("make_from_pointer", type_id);
    result = eif_create (type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE,
        EIF_POINTER))make) (eif_access (result), (EIF_POINTER)a_interface_pointer);
    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_long_long (LONGLONG * a_large_integer, EIF_OBJECT an_object)

// Create INTEGER64_REF from LONGLONG
{
  EIF_GET_CONTEXT
  EIF_OBJECT result = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE set_item;

  if (a_large_integer != NULL)
  {
    if (-1 == type_id)
      type_id = eif_type_id ("INTEGER64_REF");

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = eif_create (type_id);
    else
      result = an_object;

    set_item = eif_procedure ("set_item", type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER_64))set_item)(eif_access (result), (EIF_INTEGER_64)*a_large_integer);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//----------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_ulong_long (ULONGLONG * a_ularge_integer, EIF_OBJECT an_object)

// Create INTEGER64_REF from ULONGLONG
{
  return ccom_ce_pointed_long_long ((LONGLONG *)a_ularge_integer, an_object);
};
//----------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_short
    (short * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of short.
{
  EIF_GET_CONTEXT
  int i = 0, element_number = 0;
  EIF_INTEGER * c_array = 0;
  EIF_OBJECT result = 0;

  if (an_array != NULL)
  {
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

    nstcall = 0;
    eif_make_from_c (eif_access (result), c_array, (EIF_INTEGER)element_number, EIF_INTEGER);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//----------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_unsigned_short
    (unsigned short * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of short.
{
  EIF_GET_CONTEXT
  int i = 0, element_number = 0;
  EIF_INTEGER * c_array = 0;
  EIF_OBJECT result = 0;

  if (an_array != NULL)
  {
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

    nstcall = 0;
    eif_make_from_c (eif_access (result), c_array, (EIF_INTEGER)element_number, EIF_INTEGER);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_long
    (long * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of long.
{
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0;

  if (an_array != NULL)
  {
    element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = ccom_create_array ("INTEGER", dim_count, element_count);
    else
      result = an_object;

    nstcall = 0;
    eif_make_from_c (eif_access (result), an_array, element_number, EIF_INTEGER);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_unsigned_long
    (unsigned long * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of long.
{
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0;

  if (an_array != NULL)
  {
    element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = ccom_create_array ("INTEGER", dim_count, element_count);
    else
      result = an_object;

    nstcall = 0;
    eif_make_from_c (eif_access (result), an_array, element_number, EIF_INTEGER);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_integer
    (int * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of long.
{
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0;

  if (an_array != NULL)
  {
    element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = ccom_create_array ("INTEGER", dim_count, element_count);
    else
      result = an_object;

    nstcall = 0;
    eif_make_from_c (eif_access (result), an_array, element_number, EIF_INTEGER);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_unsigned_integer
    (unsigned int * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of long.
{
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0;

  if (an_array != NULL)
  {
    element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = ccom_create_array ("INTEGER", dim_count, element_count);
    else
      result = an_object;

    nstcall = 0;
    eif_make_from_c (eif_access (result), an_array, element_number, EIF_INTEGER);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_float
    (float * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of float.
{
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0;

  if (an_array != NULL)
  {
    element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = ccom_create_array ("REAL", dim_count, element_count);
    else
      result = an_object;

    nstcall = 0;
    eif_make_from_c (eif_access (result), an_array, element_number, EIF_REAL);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_double
    (double * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of double.
{
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0;

  if (an_array != NULL)
  {
    element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = ccom_create_array ("DOUBLE", dim_count, element_count);
    else
      result = an_object;

    nstcall = 0;
    eif_make_from_c (eif_access (result), an_array, element_number, EIF_DOUBLE);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_character
    (char * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of char.
{
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0;

  if (an_array != NULL)
  {
    element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = ccom_create_array ("CHARACTER", dim_count, element_count);
    else
      result = an_object;

    nstcall = 0;
    eif_make_from_c (eif_access (result), an_array, element_number, EIF_CHARACTER);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_unsigned_character
    (unsigned char * an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of char.
{
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0;

  if (an_array != NULL)
  {
    element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = ccom_create_array ("CHARACTER", dim_count, element_count);
    else
      result = an_object;

    nstcall = 0;
    eif_make_from_c (eif_access (result), an_array, element_number, EIF_CHARACTER);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_currency
    (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of CURRENCY.
{
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indices = 0, eif_element_count = 0;

  static EIF_TYPE_ID type_id = -1;
  static EIF_TYPE_ID multi_dim_type_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  int i = 0;
  EIF_INTEGER * lower_indices = 0;
  CURRENCY * an_array_element = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ARRAY [ECOM_CURRENCY]");
    
  make = eif_procedure ("make", type_id);
  put = eif_procedure ("put", type_id);

  element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

  if ((an_object == NULL) || (eif_access (an_object) == NULL))
  {
    intermediate_array = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make) (eif_access (intermediate_array), 1, element_number);
  }
  else
    intermediate_array = an_object;

  EIF_OBJECT eif_object_buf;

  for (i = 0; i < element_number; i++)
  {
    an_array_element = (CURRENCY *)&((ccom_c_array_element (an_array, i,CURRENCY)));
    eif_object_buf = eif_protect (ccom_ce_pointed_currency (an_array_element));

    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE,
        EIF_INTEGER))put) (eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
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
      // Create array of lower indices
      if (-1 == int_array_id)
        int_array_id = eif_type_id ("ARRAY [INTEGER]");
      make = eif_procedure ("make", int_array_id);
      eif_lower_indices = eif_create (int_array_id);

      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make) (eif_access (eif_lower_indices), 1, dim_count);

      lower_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
      for ( i = 0; i < dim_count; i++)
        lower_indices [i] = 1;

      eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);
      free (lower_indices);

      // Create array of element counts
      eif_element_count = eif_create (int_array_id);

      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make) (eif_access (eif_element_count), 1, dim_count);

      eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

      // Create ECOM_ARRAY [ECOM_CURRENCY]
      if (-1 == multi_dim_type_id)
        multi_dim_type_id = eif_type_id ("ECOM_ARRAY [ECOM_CURRENCY]");
        
      make = eif_procedure ("make_from_array", multi_dim_type_id);

      result = eif_create (multi_dim_type_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
          EIF_REFERENCE)) make) (eif_access (result), eif_access (intermediate_array),
          dim_count, eif_access (eif_lower_indices), eif_access (eif_element_count));
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
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indices = 0, eif_element_count = 0;

  static EIF_TYPE_ID type_id = -1;
  static EIF_TYPE_ID multi_dim_type_id = -1;
  
  EIF_PROCEDURE make = 0, put = 0;
  int i = 0;
  EIF_INTEGER * lower_indices = 0;
  BSTR an_array_element;

  if (-1 == type_id)
    type_id = eif_type_id ("ARRAY [STRING]");
    
  make = eif_procedure ("make", type_id);
  put = eif_procedure ("put", type_id);

  element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

  if ((an_object == NULL) || (eif_access (an_object) == NULL))
  {
    intermediate_array = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make) (eif_access (intermediate_array), 1, element_number);
  }
  else
    intermediate_array = an_object;

  EIF_OBJECT eif_object_buf = 0;

  for (i = 0; i < element_number; i++)
  {
    an_array_element = (BSTR )((ccom_c_array_element (an_array, i, BSTR)));

    eif_object_buf = eif_protect (ccom_ce_bstr ((BSTR)an_array_element));
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE,
        EIF_INTEGER))put) (eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
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
      // Create array of lower indices
      if (-1 == int_array_id)
        int_array_id = eif_type_id ("ARRAY [INTEGER]");
        
      make = eif_procedure ("make", int_array_id);
      eif_lower_indices = eif_create (int_array_id);

      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make) (eif_access (eif_lower_indices), 1, dim_count);

      lower_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
      for ( i = 0; i < dim_count; i++)
        lower_indices [i] = 1;

      eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);
      free (lower_indices);

      // Create array of element counts
      eif_element_count = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make) (eif_access (eif_element_count), 1, dim_count);

      eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

      // Create ECOM_ARRAY [STRING]
      if (-1 == multi_dim_type_id)
        multi_dim_type_id = eif_type_id ("ECOM_ARRAY [STRING]");
        
      make = eif_procedure ("make_from_array", multi_dim_type_id);

      result = eif_create (multi_dim_type_id);

      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
          EIF_REFERENCE))make) (eif_access (result), eif_access (intermediate_array),
          dim_count, eif_access (eif_lower_indices), eif_access (eif_element_count));
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
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indices = 0, eif_element_count = 0;

  static EIF_TYPE_ID type_id = -1;
  static EIF_TYPE_ID multi_dim_type_id = -1;
  
  EIF_PROCEDURE make = 0, put = 0;
  int i = 0;
  EIF_INTEGER * lower_indices = 0;
  DECIMAL * an_array_element = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ARRAY [ECOM_DECIMAL]");
    
  make = eif_procedure ("make", type_id);
  put = eif_procedure ("put", type_id);

  element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

  if (((an_object == NULL) || (eif_access (an_object) == NULL)))
  {
    intermediate_array = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (intermediate_array), 1, element_number);
  }
  else
    intermediate_array = an_object;


  EIF_OBJECT eif_object_buf;

  for (i = 0; i < element_number; i++)
  {
    an_array_element = (DECIMAL *)&((ccom_c_array_element (an_array, i, DECIMAL)));
    eif_object_buf = eif_protect (ccom_ce_pointed_decimal (an_array_element));
    (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE,
        EIF_INTEGER))put) (eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
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
      // Create array of lower indices
      if (-1 == int_array_id)
        int_array_id = eif_type_id ("ARRAY [INTEGER]");
        
      make = eif_procedure ("make", int_array_id);
      eif_lower_indices = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make) (eif_access (eif_lower_indices), 1, dim_count);

      lower_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
      for ( i = 0; i < dim_count; i++)
        lower_indices [i] = 1;

      eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);
      free (lower_indices);

      // Create array of element counts
      eif_element_count = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make) (eif_access (eif_element_count), 1, dim_count);

      eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

      // Create ECOM_ARRAY [ECOM_DECIMAL]
      if (-1 == multi_dim_type_id)
        multi_dim_type_id = eif_type_id ("ECOM_ARRAY [ECOM_DECIMAL]");
        
      make = eif_procedure ("make_from_array", multi_dim_type_id);

      result = eif_create (multi_dim_type_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
          EIF_REFERENCE))make)(eif_access (result), eif_access (intermediate_array),
          dim_count, eif_access (eif_lower_indices), eif_access (eif_element_count));
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
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indices = 0, eif_element_count = 0;

  static EIF_TYPE_ID type_id = -1;
  static EIF_TYPE_ID multi_dim_type_id = -1;
  
  EIF_PROCEDURE make = 0, put = 0;
  int i = 0;
  EIF_INTEGER * lower_indices = 0;
  VARIANT_BOOL * an_array_element = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ARRAY [BOOLEAN]");
  
  make = eif_procedure ("make", type_id);
  put = eif_procedure ("put", type_id);

  element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

  if ((an_object == NULL) || (eif_access (an_object) == NULL))
  {
    intermediate_array = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
    EIF_INTEGER))make)(eif_access (intermediate_array), 1, element_number);
  }
  else
    intermediate_array = an_object;

  for (i = 0; i < element_number; i++)
  {
    an_array_element = (VARIANT_BOOL *)&((ccom_c_array_element (an_array, i, VARIANT_BOOL)));
    (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN,
        EIF_INTEGER))put)(eif_access (intermediate_array), ccom_ce_boolean ((VARIANT_BOOL)*an_array_element), i + 1);
  }

  if ((an_object == NULL) || (eif_access (an_object) == NULL))
  {
    if ( dim_count == 1)
    {
      result = intermediate_array;
    }
    else
    {
      // Create array of lower indices
      if (-1 == int_array_id)
        int_array_id = eif_type_id ("ARRAY [INTEGER]");
        
      make = eif_procedure ("make", int_array_id);
      eif_lower_indices = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

      lower_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
      for ( i = 0; i < dim_count; i++)
        lower_indices [i] = 1;

      eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);
      free (lower_indices);

      // Create array of element counts
      eif_element_count = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make) (eif_access (eif_element_count), 1, dim_count);

      eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

      // Create ECOM_ARRAY [BOOLEAN]
      if (-1 == multi_dim_type_id)
        multi_dim_type_id = eif_type_id ("ECOM_ARRAY [BOOLEAN]");
        
      make = eif_procedure ("make_from_array", multi_dim_type_id);

      result = eif_create (multi_dim_type_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
          EIF_REFERENCE))make) (eif_access (result), eif_access (intermediate_array),
          dim_count, eif_access (eif_lower_indices), eif_access (eif_element_count));
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
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indices = 0, eif_element_count = 0;

  static EIF_TYPE_ID type_id = -1;
  static EIF_TYPE_ID multi_dim_type_id = -1;
  
  EIF_PROCEDURE make = 0, put = 0;
  int i = 0;
  EIF_INTEGER * lower_indices = 0;
  DATE * an_array_element = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ARRAY [DATE_TIME]");
  
  make = eif_procedure ("make", type_id);
  put = eif_procedure ("put", type_id);

  element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

  if ((an_object == NULL) || (eif_access (an_object) == NULL))
  {
    intermediate_array = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make) (eif_access (intermediate_array), 1, element_number);
  }
  else
    intermediate_array = an_object;

  EIF_OBJECT eif_object_buf;

  for (i = 0; i < element_number; i++)
  {
    an_array_element = (DATE *)&((ccom_c_array_element (an_array, i, DATE)));
    eif_object_buf = eif_protect (ccom_ce_date ((DATE)*an_array_element));
    (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE,
        EIF_INTEGER))put)(eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
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
      // Create array of lower indices
      if (-1 == int_array_id)
        int_array_id = eif_type_id ("ARRAY [INTEGER]");
      
      make = eif_procedure ("make", int_array_id);
      eif_lower_indices = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

      lower_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
      for ( i = 0; i < dim_count; i++)
        lower_indices [i] = 1;

      eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);
      free (lower_indices);

      // Create array of element counts
      eif_element_count = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_element_count), 1, dim_count);

      eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

      // Create ECOM_ARRAY [DATE_TIME]
      if (-1 == multi_dim_type_id)
        multi_dim_type_id = eif_type_id ("ECOM_ARRAY [DATE_TIME]");
        
      make = eif_procedure ("make_from_array", multi_dim_type_id);

      result = eif_create (multi_dim_type_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
          EIF_REFERENCE))make)(eif_access (result), eif_access (intermediate_array),
          dim_count, eif_access (eif_lower_indices), eif_access (eif_element_count));
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
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indices = 0, eif_element_count = 0;

  static EIF_TYPE_ID type_id = -1;
  static EIF_TYPE_ID multi_dim_type_id = -1;
  
  EIF_PROCEDURE make = 0, put = 0;
  int i = 0;
  EIF_INTEGER * lower_indices = 0;
  VARIANT * an_array_element = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ARRAY [ECOM_VARIANT]");
  
  make = eif_procedure ("make", type_id);
  put = eif_procedure ("put", type_id);

  element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

  if ((an_object == NULL) || (eif_access (an_object) == NULL))
  {
    intermediate_array = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (intermediate_array), 1, element_number);
  }
  else
    intermediate_array = an_object;

  EIF_OBJECT eif_object_buf;

  for (i = 0; i < element_number; i++)
  {
    an_array_element = (VARIANT *)&(ccom_c_array_element (an_array, i, VARIANT));
    eif_object_buf = eif_protect (ccom_ce_pointed_variant ((VARIANT *)an_array_element));
    (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE,
        EIF_INTEGER))put)(eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
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
      // Create array of lower indices
      if (-1 == int_array_id)
        int_array_id = eif_type_id ("ARRAY [INTEGER]");
      
      make = eif_procedure ("make", int_array_id);
      eif_lower_indices = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

      lower_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
      for ( i = 0; i < dim_count; i++)
        lower_indices [i] = 1;

      eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);
      free (lower_indices);

      // Create array of element counts
      eif_element_count = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_element_count), 1, dim_count);

      eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

      // Create ECOM_ARRAY [ECOM_VARIANT]
      if (-1 == multi_dim_type_id)
        multi_dim_type_id = eif_type_id ("ECOM_ARRAY [ECOM_VARIANT]");
        
      make = eif_procedure ("make_from_array", multi_dim_type_id);

      result = eif_create (multi_dim_type_id);

      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
          EIF_REFERENCE))make)(eif_access (result), eif_access (intermediate_array),
          dim_count, eif_access (eif_lower_indices), eif_access (eif_element_count));
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
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indices = 0, eif_element_count = 0;

  static EIF_TYPE_ID type_id = -1;
  static EIF_TYPE_ID multi_dim_type_id = -1;
  
  EIF_PROCEDURE make = 0, put = 0;
  int i = 0;
  EIF_INTEGER * lower_indices = 0;
  HRESULT * an_array_element = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ARRAY [ECOM_HRESULT]");
    
  make = eif_procedure ("make", type_id);
  put = eif_procedure ("put", type_id);

  element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
  if ((an_object == NULL) || (eif_access (an_object) == NULL))
  {
    intermediate_array = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (intermediate_array), 1, element_number);
  }
  else
    intermediate_array = an_object;

  EIF_OBJECT eif_object_buf;

  for (i = 0; i < element_number; i++)
  {
    an_array_element = (HRESULT *)&((ccom_c_array_element (an_array, i, HRESULT)));
    eif_object_buf = eif_protect (ccom_ce_hresult ((HRESULT)*an_array_element));
    (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE,
        EIF_INTEGER))put)(eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
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
      // Create array of lower indices
      if (-1 == int_array_id)
        int_array_id = eif_type_id ("ARRAY [INTEGER]");
      
      make = eif_procedure ("make", int_array_id);
      eif_lower_indices = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

      lower_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
      for ( i = 0; i < dim_count; i++)
        lower_indices [i] = 1;

      eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);
      free (lower_indices);

      // Create array of element counts
      eif_element_count = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_element_count), 1, dim_count);

      eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

      // Create ECOM_ARRAY [ECOM_HRESULT]
      if (-1 == multi_dim_type_id)
        multi_dim_type_id = eif_type_id ("ECOM_ARRAY [ECOM_HRESULT]");
        
      make = eif_procedure ("make_from_array", multi_dim_type_id);

      result = eif_create (multi_dim_type_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
          EIF_REFERENCE))make)(eif_access (result), eif_access (intermediate_array),
          dim_count, eif_access (eif_lower_indices), eif_access (eif_element_count));
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
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indices = 0, eif_element_count = 0;

  static EIF_TYPE_ID type_id = -1;
  static EIF_TYPE_ID multi_dim_type_id = -1;
  
  EIF_PROCEDURE make = 0, put = 0;
  int i = 0;
  EIF_INTEGER * lower_indices = 0;
  LPSTR an_array_element = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ARRAY [STRING]");
    
  make = eif_procedure ("make", type_id);
  put = eif_procedure ("put", type_id);

  element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
  if ((an_object == NULL) || (eif_access (an_object) == NULL))
  {
    intermediate_array = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (intermediate_array), 1, element_number);
  }
  else
    intermediate_array = an_object;

  EIF_OBJECT eif_object_buf;

  for (i = 0; i < element_number; i++)
  {
    an_array_element = (LPSTR )((ccom_c_array_element (an_array, i, LPSTR)));
    eif_object_buf = eif_protect (ccom_ce_lpstr ((LPSTR)an_array_element, NULL));
    (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE,
        EIF_INTEGER))put)(eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
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
      // Create array of lower indices
      if (-1 == int_array_id)
        int_array_id = eif_type_id ("ARRAY [INTEGER]");
      
      make = eif_procedure ("make", int_array_id);
      eif_lower_indices = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

      lower_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
      for ( i = 0; i < dim_count; i++)
        lower_indices [i] = 1;

      eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);
      free (lower_indices);

      // Create array of element counts
      eif_element_count = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_element_count), 1, dim_count);

      eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

      // Create ECOM_ARRAY [STRING]
      if (-1 == multi_dim_type_id)
        multi_dim_type_id = eif_type_id ("ECOM_ARRAY [STRING]");
        
      make = eif_procedure ("make_from_array", multi_dim_type_id);

      result = eif_create (multi_dim_type_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
          EIF_REFERENCE))make)(eif_access (result), eif_access (intermediate_array),
          dim_count, eif_access (eif_lower_indices), eif_access (eif_element_count));
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
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indices = 0, eif_element_count = 0;

  static EIF_TYPE_ID type_id = -1;
  static EIF_TYPE_ID multi_dim_type_id = -1;
  
  EIF_PROCEDURE make = 0, put = 0;
  int i = 0;
  EIF_INTEGER * lower_indices = 0;
  LPWSTR an_array_element = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ARRAY [STRING]");
    
  make = eif_procedure ("make", type_id);
  put = eif_procedure ("put", type_id);

  element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);
  if ((an_object == NULL) || (eif_access (an_object) == NULL))
  {
    intermediate_array = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (intermediate_array), 1, element_number);
  }
  else
    intermediate_array = an_object;

  EIF_OBJECT tmp_object;

  for (i = 0; i < element_number; i++)
  {
    an_array_element = (LPWSTR)((ccom_c_array_element (an_array, i, LPWSTR)));
    tmp_object = eif_protect (ccom_ce_lpwstr ((LPWSTR)an_array_element, NULL));
    (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE,
        EIF_INTEGER))put)(eif_access (intermediate_array), eif_access(tmp_object), i + 1);
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
      // Create array of lower indices
      if (-1 == int_array_id)
        int_array_id = eif_type_id ("ARRAY [INTEGER]");
        
      make = eif_procedure ("make", int_array_id);
      eif_lower_indices = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

      lower_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
      for ( i = 0; i < dim_count; i++)
        lower_indices [i] = 1;

      eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);
      free (lower_indices);

      // Create array of element counts
      eif_element_count = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_element_count), 1, dim_count);

      eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

      // Create ECOM_ARRAY [STRING]
      if (-1 == multi_dim_type_id)
        multi_dim_type_id = eif_type_id ("ECOM_ARRAY [STRING]");
        
      make = eif_procedure ("make_from_array", multi_dim_type_id);

      result = eif_create (multi_dim_type_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
          EIF_REFERENCE))make)(eif_access (result), eif_access (intermediate_array),
          dim_count, eif_access (eif_lower_indices), eif_access (eif_element_count));
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
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0;

  if (an_array != NULL)
  {
    element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = ccom_create_array ("INTEGER_64", dim_count, element_count);
    else
      result = an_object;

    nstcall = 0;
    eif_make_from_c (eif_access (result), an_array, element_number, EIF_CHARACTER);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//----------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_ulong_long
    (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel Array from C array of ULARGE_INTEGER
{
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0;

  if (an_array != NULL)
  {
    element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      result = ccom_create_array ("INTEGER_64", dim_count, element_count);
    else
      result = an_object;

    nstcall = 0;
    eif_make_from_c (eif_access (result), an_array, element_number, EIF_CHARACTER);

    if ((an_object == NULL) || (eif_access (an_object) == NULL))
      return eif_wean (result);
    else
      return NULL;
  }
  else
    return NULL;
};
//----------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_array_unknown
    (EIF_POINTER an_array, EIF_INTEGER dim_count, EIF_INTEGER * element_count, EIF_OBJECT an_object)

// Create Eiffel ARRAY from C array of IUnknown *.
{
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indices = 0, eif_element_count = 0;

  static EIF_TYPE_ID type_id = -1;
  static EIF_TYPE_ID multi_dim_type_id = -1;
  
  EIF_PROCEDURE make = 0, put = 0;
  int i = 0;
  EIF_INTEGER * lower_indices = 0;
  IUnknown * an_array_element = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ARRAY [ECOM_UNKNOWN_INTERFACE]");
  make = eif_procedure ("make", type_id);
  put = eif_procedure ("put", type_id);

  element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

  if ((an_object == NULL) || (eif_access (an_object) == NULL))
  {
    intermediate_array = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (intermediate_array), 1, element_number);
  }
  else
    intermediate_array = an_object;

  EIF_OBJECT eif_object_buf;

  for (i = 0; i < element_number; i++)
  {
    an_array_element = (IUnknown *)&((ccom_c_array_element (an_array, i, IUnknown *)));
    eif_object_buf = eif_protect (ccom_ce_pointed_unknown ((IUnknown *)an_array_element));
    (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE,
        EIF_INTEGER))put)(eif_access (intermediate_array), eif_access (eif_object_buf) , i + 1);
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
      // Create array of lower indices
      if (-1 == int_array_id)
        int_array_id = eif_type_id ("ARRAY [INTEGER]");
        
      make = eif_procedure ("make", int_array_id);
      eif_lower_indices = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

      lower_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
      for ( i = 0; i < dim_count; i++)
        lower_indices [i] = 1;

      eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);
      free (lower_indices);

      // Create array of element counts
      eif_element_count = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_element_count), 1, dim_count);

      eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

      // Create ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE]
      if (-1 == multi_dim_type_id)
        multi_dim_type_id = eif_type_id ("ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE]");
        
      make = eif_procedure ("make_from_array", multi_dim_type_id);

      result = eif_create (multi_dim_type_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
          EIF_REFERENCE))make)(eif_access (result), eif_access (intermediate_array),
          dim_count, eif_access (eif_lower_indices), eif_access (eif_element_count));
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
  EIF_GET_CONTEXT
  EIF_INTEGER element_number = 0;
  EIF_OBJECT result = 0, intermediate_array = 0, eif_lower_indices = 0, eif_element_count = 0;

  static EIF_TYPE_ID type_id = -1;
  static EIF_TYPE_ID multi_dim_type_id = -1;
  
  EIF_PROCEDURE make = 0, put = 0;
  int i = 0;
  EIF_INTEGER * lower_indices = 0;
  IDispatch * an_array_element = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("ARRAY [ECOM_AUTOMATION_INTERFACE]");
    
  make = eif_procedure ("make", type_id);
  put = eif_procedure ("put", type_id);

  element_number = (EIF_INTEGER) ccom_element_number (dim_count, element_count);

  if ((an_object == NULL) || (eif_access (an_object) == NULL))
  {
    intermediate_array = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (intermediate_array), 1, element_number);
  }

  EIF_OBJECT eif_object_buf;

  for (i = 0; i < element_number; i++)
  {
    an_array_element = (IDispatch *)&((ccom_c_array_element (an_array, i, IDispatch *)));
    eif_object_buf = eif_protect (ccom_ce_pointed_unknown ((IDispatch *)an_array_element));
    (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE,
        EIF_INTEGER))put)(eif_access (intermediate_array), eif_access (eif_object_buf), i + 1);
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
      // Create array of lower indices
      if (-1 == int_array_id)
        int_array_id = eif_type_id ("ARRAY [INTEGER]");
        
      make = eif_procedure ("make", int_array_id);
      eif_lower_indices = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

      lower_indices = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
      for ( i = 0; i < dim_count; i++)
        lower_indices [i] = 1;

      eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);
      free (lower_indices);

      // Create array of element counts
      eif_element_count = eif_create (int_array_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
          EIF_INTEGER))make)(eif_access (eif_element_count), 1, dim_count);

      eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);

      // Create ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE]
      if (-1 == multi_dim_type_id)
        multi_dim_type_id = eif_type_id ("ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE]");
        
      make = eif_procedure ("make_from_array", multi_dim_type_id);

      result = eif_create (multi_dim_type_id);
      nstcall = 0;
      (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
          EIF_REFERENCE))make)(eif_access (result), eif_access (intermediate_array),
          dim_count, eif_access (eif_lower_indices), eif_access (eif_element_count));
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
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * array_index = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  short sa_element = 0;

  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    array_index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER]");
    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [INTEGER]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [INTEGER]");

    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
        EIF_REFERENCE))make)(eif_access (result), dim_count,
        eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (array_index, lower_indices, dim_count * sizeof(EIF_INTEGER));

    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), array_index, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = array_index [dim_count - 1 - i];
        }
        hr = SafeArrayGetElement (a_safearray, sa_indices, &sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }
        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER,
            EIF_REFERENCE))put)(eif_access (result), (EIF_INTEGER)sa_element, eif_access (eif_index));

      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, array_index));
    }

    // free memory

//    hr = SafeArrayDestroy (a_safearray);
//    if (hr != S_OK)
//    {
//      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
//    }
    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (array_index);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_long (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of long
{
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * index_aaaa = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  long sa_element = 0;

  
  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    index_aaaa = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER]");

    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [INTEGER]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [INTEGER]");

    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))
    make)(eif_access (result), dim_count,  eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (index_aaaa, lower_indices, dim_count * sizeof(EIF_INTEGER));

    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), index_aaaa, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = index_aaaa [dim_count - 1 - i];
        }
        hr = SafeArrayGetElement (a_safearray, sa_indices, &sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }
        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER,
            EIF_REFERENCE))put) (eif_access (result), (EIF_INTEGER)sa_element, eif_access (eif_index));

      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, index_aaaa));
    }

    // free memory

//    hr = SafeArrayDestroy (a_safearray);
//    if (hr != S_OK)
//    {
//      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
//    }
    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_int64 (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of long
{
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * index_aaaa = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  LONGLONG sa_element = 0;

  
  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    index_aaaa = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER_64]");

    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [INTEGER]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [INTEGER]");

    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))
    make)(eif_access (result), dim_count,  eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (index_aaaa, lower_indices, dim_count * sizeof(EIF_INTEGER));

    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), index_aaaa, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = index_aaaa [dim_count - 1 - i];
        }
        hr = SafeArrayGetElement (a_safearray, sa_indices, &sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }
        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER_64,
            EIF_REFERENCE))put) (eif_access (result), (EIF_INTEGER_64)sa_element, eif_access (eif_index));

      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, index_aaaa));
    }

    // free memory

//    hr = SafeArrayDestroy (a_safearray);
//    if (hr != S_OK)
//    {
//      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
//    }
    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_bstr (BSTR *a_string)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_string != NULL) && (*a_string != NULL))
    eif_object = eif_protect (ccom_ce_bstr (*a_string));

  static EIF_TYPE_ID tid = -1;
  if (-1 == tid)
    tid = eif_type_id ("CELL[STRING]");
    
  EIF_OBJECT result = eif_create (tid);
  EIF_PROCEDURE put = eif_procedure ("put", tid);
  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));
  
  if (eif_object != NULL)
    eif_wean (eif_object);
    
  return eif_wean(result);
};
//--------------------------------------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_date (DATE *a_date)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if (a_date != NULL)
    eif_object = eif_protect (ccom_ce_date (*a_date));

  static EIF_TYPE_ID tid = -1;
  if (-1 == tid)
    tid = eif_type_id ("CELL[DATE_TIME]");
    
  EIF_OBJECT result = eif_create (tid);
  EIF_PROCEDURE put = eif_procedure ("put", tid);
  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));
  
  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean(result);
};
//--------------------------------------------------------------------------------------------------------


EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_short (SAFEARRAY ** a_safearray)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_safearray != NULL) && (*a_safearray != NULL))
    eif_object = eif_protect (ccom_ce_safearray_short (*a_safearray));

  static EIF_TYPE_ID tid = -1;
  EIF_OBJECT result = 0;
  EIF_PROCEDURE put_proc = 0;

  if (-1 == tid)
    tid = eif_type_id ("CELL[ECOM_ARRAY[INTEGER]]");
    
  result = eif_create (tid);
  put_proc = eif_procedure ("put", tid);

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put_proc)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));

  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean (result);
};
//--------------------------------------------------------------------------------------------------------


EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_long (SAFEARRAY ** a_safearray)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_safearray != NULL) && (*a_safearray != NULL))
    eif_object = eif_protect (ccom_ce_safearray_long (*a_safearray));

  static EIF_TYPE_ID tid = -1;
  EIF_OBJECT result = 0;
  EIF_PROCEDURE put_proc = 0;

  if (-1 == tid)
    tid = eif_type_id ("CELL[ECOM_ARRAY[INTEGER]]");
  result = eif_create (tid);
  put_proc = eif_procedure ("put", tid);

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put_proc)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));

  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean (result);
};
//--------------------------------------------------------------------------------------------------------


EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_float (SAFEARRAY ** a_safearray)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_safearray != NULL) && (*a_safearray != NULL))
    eif_object = eif_protect (ccom_ce_safearray_float (*a_safearray));

  static EIF_TYPE_ID tid = -1;
  EIF_OBJECT result = 0;
  EIF_PROCEDURE put_proc = 0;

  if (-1 == tid)
    tid = eif_type_id ("CELL[ECOM_ARRAY[REAL]]");
  result = eif_create (tid);
  put_proc = eif_procedure ("put", tid);

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put_proc)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));

  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean (result);
};
//--------------------------------------------------------------------------------------------------------


EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_double (SAFEARRAY ** a_safearray)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_safearray != NULL) && (*a_safearray != NULL))
    eif_object = eif_protect (ccom_ce_safearray_double (*a_safearray));

  static EIF_TYPE_ID tid = -1;
  EIF_OBJECT result = 0;
  EIF_PROCEDURE put_proc = 0;

  if (-1 == tid)
    tid = eif_type_id ("CELL[ECOM_ARRAY[DOUBLE]]");
  result = eif_create (tid);
  put_proc = eif_procedure ("put", tid);

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put_proc)(eif_access (result), eif_access (eif_object));

  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean (result);
};
//--------------------------------------------------------------------------------------------------------


EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_currency (SAFEARRAY ** a_safearray)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_safearray != NULL) && (*a_safearray != NULL))
    eif_object = eif_protect (ccom_ce_safearray_currency (*a_safearray));

  static EIF_TYPE_ID tid = -1;
  EIF_OBJECT result = 0;
  EIF_PROCEDURE put_proc = 0;

  if (-1 == tid)
    tid = eif_type_id ("CELL[ECOM_ARRAY[ECOM_CURRENCY]]");
    
  result = eif_create (tid);
  put_proc = eif_procedure ("put", tid);

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put_proc)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));

  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean (result);
};
//--------------------------------------------------------------------------------------------------------


EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_date (SAFEARRAY ** a_safearray)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_safearray != NULL) && (*a_safearray != NULL))
    eif_object = eif_protect (ccom_ce_safearray_date (*a_safearray));

  static EIF_TYPE_ID tid = -1;
  EIF_OBJECT result = 0;
  EIF_PROCEDURE put_proc = 0;

  if (-1 == tid)
    tid = eif_type_id ("CELL[ECOM_ARRAY[DATE_TIME]]");
    
  result = eif_create (tid);
  put_proc = eif_procedure ("put", tid);

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put_proc)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));

  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean (result);
};
//--------------------------------------------------------------------------------------------------------


EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_bstr (SAFEARRAY ** a_safearray)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_safearray != NULL) && (*a_safearray != NULL))
    eif_object = eif_protect (ccom_ce_safearray_bstr (*a_safearray));

  static EIF_TYPE_ID tid = -1;
  EIF_OBJECT result = 0;
  EIF_PROCEDURE put_proc = 0;

  if (-1 == tid)
    tid = eif_type_id ("CELL[ECOM_ARRAY[STRING]]");
    
  result = eif_create (tid);
  put_proc = eif_procedure ("put", tid);

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put_proc)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));

  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean (result);
};
//--------------------------------------------------------------------------------------------------------


EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_hresult (SAFEARRAY ** a_safearray)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_safearray != NULL) && (*a_safearray != NULL))
    eif_object = eif_protect (ccom_ce_safearray_hresult (*a_safearray));

  static EIF_TYPE_ID tid = -1;
  EIF_OBJECT result = 0;
  EIF_PROCEDURE put_proc = 0;

  if (-1 == tid)
    tid = eif_type_id ("CELL[ECOM_ARRAY[ECOM_HRESULT]]");
    
  result = eif_create (tid);
  put_proc = eif_procedure ("put", tid);

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put_proc)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));

  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean (result);
};
//--------------------------------------------------------------------------------------------------------


EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_boolean (SAFEARRAY ** a_safearray)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_safearray != NULL) && (*a_safearray != NULL))
    eif_object = eif_protect (ccom_ce_safearray_boolean (*a_safearray));

  static EIF_TYPE_ID tid = -1;
  EIF_OBJECT result = 0;
  EIF_PROCEDURE put_proc = 0;

  if (-1 == tid)
    tid = eif_type_id ("CELL[ECOM_ARRAY[BOOLEAN]]");
    
  result = eif_create (tid);
  put_proc = eif_procedure ("put", tid);

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put_proc)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));
  
  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean (result);
};
//--------------------------------------------------------------------------------------------------------


EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_variant (SAFEARRAY ** a_safearray)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_safearray != NULL) && (*a_safearray != NULL))
    eif_object = eif_protect (ccom_ce_safearray_variant (*a_safearray));

  static EIF_TYPE_ID tid = -1;
  EIF_OBJECT result = 0;
  EIF_PROCEDURE put_proc = 0;

  if (-1 == tid)
    tid = eif_type_id ("CELL[ECOM_ARRAY[ECOM_VARIANT]]");
    
  result = eif_create (tid);
  put_proc = eif_procedure ("put", tid);

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put_proc)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));
  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean (result);
};
//--------------------------------------------------------------------------------------------------------


EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_decimal (SAFEARRAY ** a_safearray)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_safearray != NULL) && (*a_safearray != NULL))
    eif_object = eif_protect (ccom_ce_safearray_decimal (*a_safearray));

  static EIF_TYPE_ID tid = -1;
  EIF_OBJECT result = 0;
  EIF_PROCEDURE put_proc = 0;

  if (-1 == tid)
    tid = eif_type_id ("CELL[ECOM_ARRAY[ECOM_DECIMAL]]");
    
  result = eif_create (tid);
  put_proc = eif_procedure ("put", tid);

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put_proc)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));
  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean (result);
};
//--------------------------------------------------------------------------------------------------------


EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_char (SAFEARRAY ** a_safearray)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_safearray != NULL) && (*a_safearray != NULL))
    eif_object = eif_protect (ccom_ce_safearray_char (*a_safearray));

  static EIF_TYPE_ID tid = -1;
  EIF_OBJECT result = 0;
  EIF_PROCEDURE put_proc = 0;

  if (-1 == tid)
    tid = eif_type_id ("CELL[ECOM_ARRAY[CHARACTER]]");
    
  result = eif_create (tid);
  put_proc = eif_procedure ("put", tid);

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put_proc)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));
  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean (result);
};
//--------------------------------------------------------------------------------------------------------


EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_dispatch (SAFEARRAY ** a_safearray)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_safearray != NULL) && (*a_safearray != NULL))
    eif_object = eif_protect (ccom_ce_safearray_dispatch (*a_safearray));

  static EIF_TYPE_ID tid = -1;
  EIF_OBJECT result = 0;
  EIF_PROCEDURE put_proc = 0;

  if (-1 == tid)
    tid = eif_type_id ("CELL[ECOM_ARRAY[ECOM_AUTOMATION_INTERFACE]]");
    
  result = eif_create (tid);
  put_proc = eif_procedure ("put", tid);

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put_proc)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));
  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean (result);
};
//--------------------------------------------------------------------------------------------------------


EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_safearray_unknown (SAFEARRAY ** a_safearray)
{
  EIF_GET_CONTEXT
  EIF_OBJECT eif_object = NULL;
  
  if ((a_safearray != NULL) && (*a_safearray != NULL))
    eif_object = eif_protect (ccom_ce_safearray_unknown (*a_safearray));

  static EIF_TYPE_ID tid = -1;
  EIF_OBJECT result = 0;
  EIF_PROCEDURE put_proc = 0;

  if (-1 == tid)
    tid = eif_type_id ("CELL[ECOM_ARRAY[ECOM_UNKNOWN_INTERFACE]]");
    
  result = eif_create (tid);
  put_proc = eif_procedure ("put", tid);

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_REFERENCE))put_proc)(eif_access (result), ((eif_object != NULL) ? eif_access (eif_object) : NULL));
  if (eif_object != NULL)
    eif_wean (eif_object);
  return eif_wean (result);
}

//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_float (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of float
{
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * array_index = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  float sa_element = 0;

  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    array_index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER]");

    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [REAL]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [REAL]");

    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
        EIF_REFERENCE))make)(eif_access (result), dim_count,
        eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (array_index, lower_indices, dim_count * sizeof(EIF_INTEGER));

    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), array_index, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = array_index [dim_count - 1 - i];
        }
        hr = SafeArrayGetElement (a_safearray, sa_indices, &sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }
        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REAL,
            EIF_REFERENCE))put)(eif_access (result), (EIF_REAL)sa_element, eif_access (eif_index));

      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, array_index));
    }

    // free memory

//    hr = SafeArrayDestroy (a_safearray);
//    if (hr != S_OK)
//    {
//      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
//    }
    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (array_index);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_double (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of double
{
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * array_index = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  double sa_element = 0;

  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    array_index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER]");

    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);
    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [DOUBLE]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [DOUBLE]");

    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
        EIF_REFERENCE))make)(eif_access (result), dim_count,
        eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (array_index, lower_indices, dim_count * sizeof(EIF_INTEGER));

    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), array_index, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = array_index [dim_count - 1 - i];
        }
        hr = SafeArrayGetElement (a_safearray, sa_indices, &sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }
        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_DOUBLE,
            EIF_REFERENCE))put)(eif_access (result), (EIF_DOUBLE)sa_element, eif_access (eif_index));

      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, array_index));
    }

    // free memory

//    hr = SafeArrayDestroy (a_safearray);
//    if (hr != S_OK)
//    {
//      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
//    }
    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (array_index);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_char (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of char
{
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * array_index = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  char sa_element = 0;

  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    array_index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER]");

    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [CHARACTER]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [CHARACTER]");

    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);


    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_REFERENCE, EIF_REFERENCE))make)(eif_access (result), dim_count,
        eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (array_index, lower_indices, dim_count * sizeof(EIF_INTEGER));

    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), array_index, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = array_index [dim_count - 1 - i];
        }
        hr = SafeArrayGetElement (a_safearray, sa_indices, &sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }

        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_CHARACTER,
            EIF_REFERENCE))put)(eif_access (result), (EIF_CHARACTER)sa_element, eif_access (eif_index));

      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, array_index));
    }

    // free memory

//    hr = SafeArrayDestroy (a_safearray);
//    if (hr != S_OK)
//    {
//      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
//    }
    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (array_index);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_boolean (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of boolean
{
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * array_index = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  VARIANT_BOOL sa_element = 0;
  EIF_BOOLEAN eif_array_element = 0;

  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    array_index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER]");
    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make) (eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [BOOLEAN]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [BOOLEAN]");
    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
        EIF_REFERENCE))make)(eif_access (result), dim_count,
        eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (array_index, lower_indices, dim_count * sizeof(EIF_INTEGER));

    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), array_index, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = array_index [dim_count - 1 - i];
        }
        hr = SafeArrayGetElement (a_safearray, sa_indices, &sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }
        eif_array_element = (sa_element == 0) ? EIF_FALSE : EIF_TRUE;
        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN,
            EIF_REFERENCE))put)(eif_access (result), eif_array_element, eif_access (eif_index));

      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, array_index));
    }

    // free memory

//    hr = SafeArrayDestroy (a_safearray);
//    if (hr != S_OK)
//    {
//      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
//    }
    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (array_index);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_currency (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of CURRENCY
{
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * array_index = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0, eif_array_element = 0;
  static EIF_TYPE_ID type_id = -1;
  static EIF_TYPE_ID currency_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  CURRENCY * sa_element = 0;

  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    array_index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER]");
    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER,
        EIF_INTEGER))make)(eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [ECOM_CURRENCY]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [ECOM_CURRENCY]");

    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE,
        EIF_REFERENCE))make)(eif_access (result), dim_count,
        eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (array_index, lower_indices, dim_count * sizeof(EIF_INTEGER));

    if (-1 == currency_id)
      currency_id = eif_type_id ("ECOM_CURRENCY");

    make = eif_procedure ("make", currency_id);
    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), array_index, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = array_index [dim_count - 1 - i];
        }

        eif_array_element = eif_create (currency_id);

        nstcall = 0;
        (FUNCTION_CAST ( void, (EIF_REFERENCE))make)(eif_access (eif_array_element));
        sa_element = (CURRENCY *) eif_field (eif_access (eif_array_element), "item", EIF_POINTER);

        hr = SafeArrayGetElement (a_safearray, sa_indices, sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }

        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE,
            EIF_REFERENCE))put)(eif_access (result), eif_access (eif_array_element), eif_access (eif_index));

        eif_wean (eif_array_element);

      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, array_index));
    }

    // free memory

//    hr = SafeArrayDestroy (a_safearray);
//    if (hr != S_OK)
//    {
//      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
//    }
    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (array_index);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_date (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of DATE
{
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * array_index = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  DATE sa_element = 0;

  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    array_index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER]");

    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [DATE_TIME]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [DATE_TIME]");
    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))make)
        (eif_access (result), dim_count,  eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (array_index, lower_indices, dim_count * sizeof(EIF_INTEGER));

    EIF_OBJECT date_object = 0;
    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), array_index, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = array_index [dim_count - 1 - i];
        }
        hr = SafeArrayGetElement (a_safearray, sa_indices, &sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }

        date_object = eif_protect (ccom_ce_date (sa_element));

        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))put)
            (eif_access (result), eif_access (date_object), eif_access (eif_index));

        eif_wean (date_object);

      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, array_index));
    }

    // free memory

//    hr = SafeArrayDestroy (a_safearray);
//    if (hr != S_OK)
//    {
//      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
//    }
    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (array_index);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_decimal (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of DECIMAL
{
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * array_index = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0, eif_array_element = 0;
  static EIF_TYPE_ID type_id = -1;
  static EIF_TYPE_ID decimal_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  DECIMAL * sa_element = 0;

  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    array_index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER]");

    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [ECOM_DECIMAL]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [ECOM_DECIMAL]");

    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))make)
        (eif_access (result), dim_count,  eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (array_index, lower_indices, dim_count * sizeof(EIF_INTEGER));

    if (-1 == decimal_id)
      decimal_id = eif_type_id ("ECOM_DECIMAL");

    make = eif_procedure ("make", decimal_id);
    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), array_index, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = array_index [dim_count - 1 - i];
        }

        eif_array_element = eif_create (decimal_id);

        nstcall = 0;
        (FUNCTION_CAST ( void, (EIF_REFERENCE))make)(eif_access (eif_array_element));

        sa_element = (DECIMAL *) eif_field (eif_access (eif_array_element), "item", EIF_POINTER);

        hr = SafeArrayGetElement (a_safearray, sa_indices, sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }

        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))put)
            (eif_access (result), eif_access (eif_array_element), eif_access (eif_index));

        eif_wean (eif_array_element);

      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, array_index));
    }

    // free memory

//    hr = SafeArrayDestroy (a_safearray);
//    if (hr != S_OK)
//    {
//      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
//    }
    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (array_index);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_bstr (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of BSTR
{
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * array_index = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  BSTR sa_element;

  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    array_index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER]");

    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [STRING]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [STRING]");

    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))make)
        (eif_access (result), dim_count,  eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (array_index, lower_indices, dim_count * sizeof(EIF_INTEGER));

    EIF_OBJECT string_object = 0;

    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), array_index, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = array_index [dim_count - 1 - i];
        }
        hr = SafeArrayGetElement (a_safearray, sa_indices, &sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }

        string_object = eif_protect (ccom_ce_bstr (sa_element));

        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))put)
            (eif_access (result), eif_access (string_object), eif_access (eif_index));

        eif_wean (string_object);

      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, array_index));
    }

    // free memory

    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (array_index);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_variant (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of VARIANT
{
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * array_index = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0, eif_array_element = 0;
  static EIF_TYPE_ID type_id = -1;
  static EIF_TYPE_ID variant_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  VARIANT * sa_element = 0;

  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    array_index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER]");

    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [ECOM_VARIANT]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [ECOM_VARIANT]");

    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))make)
        (eif_access (result), dim_count,  eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (array_index, lower_indices, dim_count * sizeof(EIF_INTEGER));

    if (-1 == variant_id)
      variant_id = eif_type_id ("ECOM_VARIANT");

    make = eif_procedure ("make", variant_id);
    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), array_index, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = array_index [dim_count - 1 - i];
        }

        eif_array_element = eif_create (variant_id);

        nstcall = 0;
        (FUNCTION_CAST ( void, (EIF_REFERENCE))make)(eif_access (eif_array_element));

        sa_element = (VARIANT *)eif_field (eif_access (eif_array_element), "item", EIF_POINTER);

        hr = SafeArrayGetElement (a_safearray, sa_indices, sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }
        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))put)
            (eif_access (result), eif_access (eif_array_element), eif_access (eif_index));

        eif_wean (eif_array_element);

      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, array_index));
    }

    // free memory

//    hr = SafeArrayDestroy (a_safearray);
//    if (hr != S_OK)
//    {
//      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
//    }
    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (array_index);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_hresult (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of HRESULT
{
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * array_index = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  HRESULT sa_element = 0;

  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    array_index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER]");

    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [ECOM_HRESULT]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [ECOM_HRESULT]");

    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))make)
        (eif_access (result), dim_count,  eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (array_index, lower_indices, dim_count * sizeof(EIF_INTEGER));

    EIF_OBJECT hresult_object = 0;

    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), array_index, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = array_index [dim_count - 1 - i];
        }
        hr = SafeArrayGetElement (a_safearray, sa_indices, &sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }
        hresult_object = eif_protect (ccom_ce_hresult (sa_element));

        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))put)
            (eif_access (result), eif_access (hresult_object), eif_access (eif_index));

        eif_wean (hresult_object);
      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, array_index));
    }

    // free memory

//    hr = SafeArrayDestroy (a_safearray);
//    if (hr != S_OK)
//    {
//      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
//    }
    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (array_index);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_unknown (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of IUnknown *.
{
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * array_index = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  IUnknown * sa_element = 0;

  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    array_index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER]");

    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [ECOM_UNKNOWN_INTERFACE]");

    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))make)
        (eif_access (result), dim_count,  eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (array_index, lower_indices, dim_count * sizeof(EIF_INTEGER));

    EIF_OBJECT unknown_object = 0;
    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), array_index, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = array_index [dim_count - 1 - i];
        }
        hr = SafeArrayGetElement (a_safearray, sa_indices, &sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }

        unknown_object = eif_protect (ccom_ce_pointed_unknown (sa_element));

        (FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))put)
            (eif_access (result), eif_access (unknown_object), eif_access (eif_index));
        eif_wean (unknown_object);

        if (sa_element != NULL)
          sa_element->AddRef();

      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, array_index));
    }

    // free memory

    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (array_index);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_safearray_dispatch (SAFEARRAY * a_safearray)

// Create ECOM_ARRAY from SAFEARRAY of IDispatch *.
{
  EIF_GET_CONTEXT
  EIF_INTEGER dim_count = 0;
  EIF_INTEGER * lower_indices = 0;
  EIF_INTEGER * upper_indices = 0;
  EIF_INTEGER * element_counts = 0;
  EIF_INTEGER * array_index = 0;
  long * sa_indices = 0;
  int i = 0;
  long tmp_long = 0;
  HRESULT hr = 0;
  EIF_OBJECT result = 0, eif_lower_indices = 0, eif_element_counts = 0, eif_index = 0;
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE make = 0, put = 0;
  IDispatch * sa_element = 0;

  if (a_safearray != NULL)
  {
    dim_count = (EIF_INTEGER)SafeArrayGetDim (a_safearray);

    lower_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    upper_indices = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    element_counts = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    array_index = (EIF_INTEGER *)calloc (dim_count, sizeof (EIF_INTEGER));
    sa_indices = (long *)calloc (dim_count, sizeof (long));

    for (i = 0; i < dim_count; i++)
    {
      hr = SafeArrayGetLBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
        lower_indices[i] = (EIF_INTEGER)tmp_long;
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
      hr = SafeArrayGetUBound (a_safearray, dim_count - i, &tmp_long);
      if (SUCCEEDED (hr))
      {
        upper_indices[i] = (EIF_INTEGER)tmp_long;
        element_counts[i] = upper_indices[i] - lower_indices[i] + 1;
      }
      else
      {
        com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
      }
    }

    // Create array of lower indices
    if (-1 == int_array_id)
      int_array_id = eif_type_id ("ARRAY [INTEGER]");

    make = eif_procedure ("make", int_array_id);
    eif_lower_indices = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_lower_indices), 1, dim_count);

    eif_make_from_c (eif_access (eif_lower_indices), lower_indices, dim_count, EIF_INTEGER);

    // Create array of element counts
    eif_element_counts = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_element_counts), 1, dim_count);

    eif_make_from_c (eif_access (eif_element_counts), element_counts, dim_count, EIF_INTEGER);

    // Create array of indices
    eif_index = eif_create (int_array_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))make)
        (eif_access (eif_index), 1, dim_count);

    // Create ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE]
    if (-1 == type_id)
      type_id = eif_type_id ("ECOM_ARRAY [ECOM_AUTOMATION_INTERFACE]");

    make = eif_procedure ("make", type_id);
    put = eif_procedure ("put", type_id);
    result = eif_create (type_id);

    nstcall = 0;
    (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))make)
        (eif_access (result), dim_count,  eif_access (eif_lower_indices), eif_access (eif_element_counts));

    // Initialize `result' to contents of SAFEARRAY
    memcpy (array_index, lower_indices, dim_count * sizeof(EIF_INTEGER));

    EIF_OBJECT dispatch_object = 0;
    if (ccom_element_number (dim_count, element_counts) > 0)
    {
      do
      {
        eif_make_from_c (eif_access (eif_index), array_index, dim_count, EIF_INTEGER);
        for (i = 0; i < dim_count; i++)
        {
          sa_indices[i] = array_index [dim_count - 1 - i];
        }
        hr = SafeArrayGetElement (a_safearray, sa_indices, &sa_element);
        if (hr != S_OK)
        {
          com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
        }
        dispatch_object = eif_protect (ccom_ce_pointed_dispatch (sa_element));

        put (eif_access (result), eif_access (dispatch_object), eif_access (eif_index));
        eif_wean (dispatch_object);
        if (sa_element != NULL)
          sa_element->AddRef();

      } while (ccom_safearray_next_index (dim_count, lower_indices, upper_indices, array_index));
    }

    // free memory

//    hr = SafeArrayDestroy (a_safearray);
//    if (hr != S_OK)
//    {
//      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
//    }
    free (lower_indices);
    free (element_counts);
    free (upper_indices);
    free (array_index);
    free (sa_indices);

    eif_wean (eif_lower_indices);
    eif_wean (eif_element_counts);
    eif_wean (eif_index);

    return eif_wean (result);
  }
  else
    return NULL;
};
//-------------------------------------------------------------------------

EIF_REFERENCE ecom_runtime_ce::ccom_ce_pointed_pointer (void ** a_pointer, EIF_OBJECT an_object)

// Create CELL [POINTER] from void **.
{
  EIF_GET_CONTEXT
  static EIF_TYPE_ID type_id = -1;
  EIF_PROCEDURE put = 0;
  EIF_OBJECT result = 0;

  if (-1 == type_id)
    type_id = eif_type_id ("CELL [POINTER]");
  put = eif_procedure ("put", type_id);
  if ((an_object == NULL) || (eif_access (an_object) == NULL))
    result = eif_create (type_id);
  else
    result = an_object;

  nstcall = 0;
  (FUNCTION_CAST ( void, (EIF_REFERENCE, EIF_POINTER))put)(eif_access (result), (((a_pointer != NULL) && (*a_pointer != NULL)) ? (EIF_POINTER)*a_pointer : NULL));

  if ((an_object == NULL) || (eif_access (an_object) == NULL))
    return eif_wean (result);
  else
    return NULL;
};
//-------------------------------------------------------------------------
