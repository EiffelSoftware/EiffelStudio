/*-----------------------------------------------------------
Implemented `Font' Interface.
-----------------------------------------------------------*/

#include "ecom_Font21_impl_proxy.h"
static const IID IID_Font21_ = {0xbef6e003,0xa874,0x101a,{0x8b,0xba,0x00,0xaa,0x00,0x30,0x0c,0xab}};

#ifdef __cplusplus
extern "C" {
#endif

Font21_impl_proxy::Font21_impl_proxy( IUnknown * a_pointer )
{
  HRESULT hr, hr2;

  hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

  hr = a_pointer->QueryInterface(IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };

  excepinfo = (EXCEPINFO*)CoTaskMemAlloc (sizeof (EXCEPINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

Font21_impl_proxy::~Font21_impl_proxy()
{
  p_unknown->Release ();
  
  CoTaskMemFree ((void *)excepinfo);
  if (p_Font21!=NULL)
    p_Font21->Release ();
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER Font21_impl_proxy::ccom_last_error_code()

/*-----------------------------------------------------------
  Last error code
-----------------------------------------------------------*/
{
  return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE Font21_impl_proxy::ccom_last_source_of_exception()

/*-----------------------------------------------------------
  Last source of exception
-----------------------------------------------------------*/
{
  return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE Font21_impl_proxy::ccom_last_error_description()

/*-----------------------------------------------------------
  Last error description
-----------------------------------------------------------*/
{
  return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE Font21_impl_proxy::ccom_last_error_help_file()

/*-----------------------------------------------------------
  Last error help file
-----------------------------------------------------------*/
{
  return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE Font21_impl_proxy::ccom_name()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 0;
  LCID lcid = (LCID) 0;
  DISPPARAMS args = {NULL, NULL, 0, 0};
  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }
      if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };

  EIF_REFERENCE result = rt_ce.ccom_ce_bstr (pResult.bstrVal);
  return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void Font21_impl_proxy::ccom_set_name( EIF_OBJECT a_value )

/*-----------------------------------------------------------
  Set No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 0;
  LCID lcid = (LCID) 0;
  DISPPARAMS args;
  VARIANTARG arg;

  BSTR tmp_value;
  tmp_value = rt_ec.ccom_ec_bstr (a_value);
  arg.vt = 8;
  arg.bstrVal = tmp_value;
  args.cArgs = 1;
  args.cNamedArgs = 0;

  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }   if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE Font21_impl_proxy::ccom_size()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 2;
  LCID lcid = (LCID) 0;
  DISPPARAMS args = {NULL, NULL, 0, 0};
  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }
      if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };

  EIF_REFERENCE result = rt_ce.ccom_ce_currency (pResult.cyVal);
  return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void Font21_impl_proxy::ccom_set_size( CURRENCY * a_value )

/*-----------------------------------------------------------
  Set No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 2;
  LCID lcid = (LCID) 0;
  DISPPARAMS args;
  VARIANTARG arg;

  arg.vt = 6;
  memcpy (&(arg.cyVal), a_value, sizeof (CURRENCY));
  args.cArgs = 1;
  args.cNamedArgs = 0;

  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }   if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN Font21_impl_proxy::ccom_bold()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 3;
  LCID lcid = (LCID) 0;
  DISPPARAMS args = {NULL, NULL, 0, 0};
  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }
      if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };

  EIF_BOOLEAN result = rt_ce.ccom_ce_boolean (pResult.boolVal);
  return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void Font21_impl_proxy::ccom_set_bold( EIF_BOOLEAN a_value )

/*-----------------------------------------------------------
  Set No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 3;
  LCID lcid = (LCID) 0;
  DISPPARAMS args;
  VARIANTARG arg;

  VARIANT_BOOL tmp_value;
  tmp_value = rt_ec.ccom_ec_boolean (a_value);
  arg.vt = 11;
  arg.boolVal = tmp_value;
  args.cArgs = 1;
  args.cNamedArgs = 0;

  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }   if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN Font21_impl_proxy::ccom_italic()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 4;
  LCID lcid = (LCID) 0;
  DISPPARAMS args = {NULL, NULL, 0, 0};
  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }
      if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };

  EIF_BOOLEAN result = rt_ce.ccom_ce_boolean (pResult.boolVal);
  return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void Font21_impl_proxy::ccom_set_italic( EIF_BOOLEAN a_value )

/*-----------------------------------------------------------
  Set No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 4;
  LCID lcid = (LCID) 0;
  DISPPARAMS args;
  VARIANTARG arg;

  VARIANT_BOOL tmp_value;
  tmp_value = rt_ec.ccom_ec_boolean (a_value);
  arg.vt = 11;
  arg.boolVal = tmp_value;
  args.cArgs = 1;
  args.cNamedArgs = 0;

  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }   if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN Font21_impl_proxy::ccom_underline()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 5;
  LCID lcid = (LCID) 0;
  DISPPARAMS args = {NULL, NULL, 0, 0};
  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }
      if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };

  EIF_BOOLEAN result = rt_ce.ccom_ce_boolean (pResult.boolVal);
  return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void Font21_impl_proxy::ccom_set_underline( EIF_BOOLEAN a_value )

/*-----------------------------------------------------------
  Set No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 5;
  LCID lcid = (LCID) 0;
  DISPPARAMS args;
  VARIANTARG arg;

  VARIANT_BOOL tmp_value;
  tmp_value = rt_ec.ccom_ec_boolean (a_value);
  arg.vt = 11;
  arg.boolVal = tmp_value;
  args.cArgs = 1;
  args.cNamedArgs = 0;

  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }   if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN Font21_impl_proxy::ccom_strikethrough()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 6;
  LCID lcid = (LCID) 0;
  DISPPARAMS args = {NULL, NULL, 0, 0};
  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }
      if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };

  EIF_BOOLEAN result = rt_ce.ccom_ce_boolean (pResult.boolVal);
  return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void Font21_impl_proxy::ccom_set_strikethrough( EIF_BOOLEAN a_value )

/*-----------------------------------------------------------
  Set No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 6;
  LCID lcid = (LCID) 0;
  DISPPARAMS args;
  VARIANTARG arg;

  VARIANT_BOOL tmp_value;
  tmp_value = rt_ec.ccom_ec_boolean (a_value);
  arg.vt = 11;
  arg.boolVal = tmp_value;
  args.cArgs = 1;
  args.cNamedArgs = 0;

  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }   if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER Font21_impl_proxy::ccom_weight()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 7;
  LCID lcid = (LCID) 0;
  DISPPARAMS args = {NULL, NULL, 0, 0};
  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }
      if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };

  EIF_INTEGER result = (EIF_INTEGER)pResult.iVal;
  return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void Font21_impl_proxy::ccom_set_weight( EIF_INTEGER a_value )

/*-----------------------------------------------------------
  Set No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 7;
  LCID lcid = (LCID) 0;
  DISPPARAMS args;
  VARIANTARG arg;

  SHORT tmp_value;
  tmp_value = (SHORT)a_value;
  arg.vt = 2;
  arg.iVal = tmp_value;
  args.cArgs = 1;
  args.cNamedArgs = 0;

  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }   if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER Font21_impl_proxy::ccom_charset()

/*-----------------------------------------------------------
  No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 8;
  LCID lcid = (LCID) 0;
  DISPPARAMS args = {NULL, NULL, 0, 0};
  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }
      if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };

  EIF_INTEGER result = (EIF_INTEGER)pResult.iVal;
  return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void Font21_impl_proxy::ccom_set_charset( EIF_INTEGER a_value )

/*-----------------------------------------------------------
  Set No description available.
-----------------------------------------------------------*/
{
  HRESULT hr;
  if (p_Font21 == NULL)
  {
    hr = p_unknown->QueryInterface (IID_Font21_, (void **)&p_Font21);
  if (FAILED (hr))
  {
    if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
      com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
    com_eraise (f.c_format_message (hr), EN_PROG);
  };
  };
  DISPID disp = (DISPID) 8;
  LCID lcid = (LCID) 0;
  DISPPARAMS args;
  VARIANTARG arg;

  SHORT tmp_value;
  tmp_value = (SHORT)a_value;
  arg.vt = 2;
  arg.iVal = tmp_value;
  args.cArgs = 1;
  args.cNamedArgs = 0;

  VARIANT pResult; 
  VariantInit (&pResult);

  excepinfo->wCode = 0;
  excepinfo->wReserved = 0;
  excepinfo->bstrSource = NULL;
  excepinfo->bstrDescription = NULL;
  excepinfo->bstrHelpFile = NULL;
  excepinfo->dwHelpContext = 0;
  excepinfo->pvReserved = NULL;
  excepinfo->pfnDeferredFillIn = NULL;
  excepinfo->scode = 0;
  
  unsigned int nArgErr;

  hr = p_Font21->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
  
  if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
  {
    char * hresult_error = f.c_format_message (hr);
    char  arg_no[20];
    itoa (nArgErr, arg_no, 10);
    char * arg_name = "Argument No: ";
    int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
    char * message;
    message = (char *)calloc (size, sizeof (char));
    strcat (message, hresult_error);
    strcat (message, arg_no);
    strcat (message, arg_name);
    com_eraise (message, HRESULT_CODE(hr));
  }   if (FAILED (hr))
    {
      com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
    };
  
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER Font21_impl_proxy::ccom_item()

/*-----------------------------------------------------------
  IUnknown interface
-----------------------------------------------------------*/
{
  return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif
