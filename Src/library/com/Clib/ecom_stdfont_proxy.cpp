/*-----------------------------------------------------------
No description available.
-----------------------------------------------------------*/

#include "ecom_StdFont.h"

static const CLSID CLSID_StdFont = {0x0be35203,0x8f91,0x11ce,{0x9d,0xe3,0x00,0xaa,0x00,0x4b,0xb8,0x51}};

static const IID IID_Font = {0xbef6e003,0xa874,0x101a,{0x8b,0xba,0x00,0xaa,0x00,0x30,0x0c,0xab}};

static const IID IID_FontEvents = {0x4ef6100a,0xaf88,0x11d0,{0x98,0x46,0x00,0xc0,0x4f,0xc2,0x99,0x93}};

static const IID IID_IFont1 = {0xbef6e002,0xa874,0x101a,{0x8b,0xba,0x00,0xaa,0x00,0x30,0x0c,0xab}};


StdFont::StdFont()
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	p_unknown = NULL;
	MULTI_QI a_qi = {&IID_IUnknown, NULL, hr2};

	hr = CoCreateInstanceEx (CLSID_StdFont, NULL, CLSCTX_INPROC_SERVER, NULL, 1, &a_qi);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	if (FAILED (hr2))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr2), HRESULT_CODE (hr2));
	};
	p_unknown = a_qi.pItf;

	p_Font = 0;

	p_FontEvents = 0;

	p_IFont = 0;

	excepinfo = (EXCEPINFO*)CoTaskMemAlloc (sizeof (EXCEPINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

StdFont::StdFont( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};

	p_Font = 0;
	p_FontEvents = 0;
	p_IFont = 0;
	excepinfo = (EXCEPINFO*)CoTaskMemAlloc (sizeof (EXCEPINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

StdFont::~StdFont()
{
	p_unknown->Release ();
	
	CoTaskMemFree ((void *)excepinfo);
	if (p_Font!=NULL)
		p_Font->Release ();
	if (p_FontEvents!=NULL)
		p_FontEvents->Release ();
	if (p_IFont!=NULL)
		p_IFont->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE StdFont::ccom_name()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
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

	return (EIF_REFERENCE)(rt_ce.ccom_ce_bstr (pResult.bstrVal));
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_set_name( EIF_OBJECT a_value )

/*-----------------------------------------------------------
	Set No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
		char * arg_name = "Argument No: ";
		int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
		char * message;
		message = (char *)calloc (size, sizeof (char));
		strcat (message, hresult_error);
		strcat (message, arg_no);
		strcat (message, arg_name);
		com_eraise (message, HRESULT_CODE(hr));
	}		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE StdFont::ccom_size()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
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

	return (EIF_REFERENCE)(rt_ce.ccom_ce_currency (pResult.cyVal));
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_set_size( CURRENCY * a_value )

/*-----------------------------------------------------------
	Set No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	DISPID disp = (DISPID) 2;
	LCID lcid = (LCID) 0;
	DISPPARAMS args;
	VARIANTARG arg;

	CURRENCY tmp_value;
	tmp_value = *(CURRENCY*)a_value;
	arg.vt = 6;
	arg.cyVal = tmp_value;
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
		char * arg_name = "Argument No: ";
		int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
		char * message;
		message = (char *)calloc (size, sizeof (char));
		strcat (message, hresult_error);
		strcat (message, arg_no);
		strcat (message, arg_name);
		com_eraise (message, HRESULT_CODE(hr));
	}		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN StdFont::ccom_bold()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
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

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (pResult.boolVal);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_set_bold( EIF_BOOLEAN a_value )

/*-----------------------------------------------------------
	Set No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
		char * arg_name = "Argument No: ";
		int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
		char * message;
		message = (char *)calloc (size, sizeof (char));
		strcat (message, hresult_error);
		strcat (message, arg_no);
		strcat (message, arg_name);
		com_eraise (message, HRESULT_CODE(hr));
	}		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN StdFont::ccom_italic()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
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

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (pResult.boolVal);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_set_italic( EIF_BOOLEAN a_value )

/*-----------------------------------------------------------
	Set No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
		char * arg_name = "Argument No: ";
		int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
		char * message;
		message = (char *)calloc (size, sizeof (char));
		strcat (message, hresult_error);
		strcat (message, arg_no);
		strcat (message, arg_name);
		com_eraise (message, HRESULT_CODE(hr));
	}		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN StdFont::ccom_underline()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
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

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (pResult.boolVal);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_set_underline( EIF_BOOLEAN a_value )

/*-----------------------------------------------------------
	Set No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
		char * arg_name = "Argument No: ";
		int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
		char * message;
		message = (char *)calloc (size, sizeof (char));
		strcat (message, hresult_error);
		strcat (message, arg_no);
		strcat (message, arg_name);
		com_eraise (message, HRESULT_CODE(hr));
	}		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN StdFont::ccom_strikethrough()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
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

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (pResult.boolVal);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_set_strikethrough( EIF_BOOLEAN a_value )

/*-----------------------------------------------------------
	Set No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
		char * arg_name = "Argument No: ";
		int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
		char * message;
		message = (char *)calloc (size, sizeof (char));
		strcat (message, hresult_error);
		strcat (message, arg_no);
		strcat (message, arg_name);
		com_eraise (message, HRESULT_CODE(hr));
	}		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdFont::ccom_weight()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
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

	return (EIF_INTEGER)pResult.iVal;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_set_weight( EIF_INTEGER a_value )

/*-----------------------------------------------------------
	Set No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
		char * arg_name = "Argument No: ";
		int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
		char * message;
		message = (char *)calloc (size, sizeof (char));
		strcat (message, hresult_error);
		strcat (message, arg_no);
		strcat (message, arg_name);
		com_eraise (message, HRESULT_CODE(hr));
	}		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdFont::ccom_charset()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
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

	return (EIF_INTEGER)pResult.iVal;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_set_charset( EIF_INTEGER a_value )

/*-----------------------------------------------------------
	Set No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Font == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Font, (void **)&p_Font);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Font->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
		char * arg_name = "Argument No: ";
		int size = strlen (hresult_error) + strlen (arg_no) + strlen (arg_name) + 1;
		char * message;
		message = (char *)calloc (size, sizeof (char));
		strcat (message, hresult_error);
		strcat (message, arg_no);
		strcat (message, arg_name);
		com_eraise (message, HRESULT_CODE(hr));
	}		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_font_changed(  /* [in] */ EIF_OBJECT property_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_FontEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_FontEvents, (void **)&p_FontEvents);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	DISPID disp = (DISPID) 9;
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
	args.cArgs = 1;
	VARIANTARG *arguments;
	arguments = (VARIANTARG *)CoTaskMemAlloc (1*sizeof (VARIANTARG));
	
	arguments[0].vt = 8;
	arguments[0].bstrVal = (BSTR)rt_ec.ccom_ec_bstr (eif_access (property_name));
	
	args.rgvarg = arguments;

	hr = p_FontEvents->Invoke (disp, IID_NULL, lcid, DISPATCH_METHOD, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		_itoa (nArgErr, arg_no, 10);
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
			CoTaskMemFree ((void *)arguments);
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	CoTaskMemFree ((void *)arguments);
	 
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE StdFont::ccom_ifont_name(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	BSTR tmp_pname = 0;
	
	hr = p_IFont->IFont_Name( &tmp_pname);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_REFERENCE)rt_ce.ccom_ce_bstr (tmp_pname);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_ifont_set_name(  /* [in] */ EIF_OBJECT pname )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Name((BSTR)rt_ec.ccom_ec_bstr (eif_access (pname)));
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE StdFont::ccom_ifont_size(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	EIF_TYPE_ID tid = -1;
	EIF_OBJECT result;
	EIF_PROCEDURE make;
	CURRENCY * ret_value;

	tid = eif_type_id ("ECOM_CURRENCY");
	make = eif_procedure ("make", tid);
	result = eif_create (tid);
	make (eif_access (result));
	ret_value = (CURRENCY *)eif_field (eif_access (result), "item", EIF_POINTER);
	
	hr = p_IFont->IFont_Size( ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return eif_wean (result);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_ifont_set_size(  /* [in] */ CURRENCY * psize )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Size(*(CURRENCY*)psize);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN StdFont::ccom_ifont_bold(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	VARIANT_BOOL tmp_pbold = 0;
	
	hr = p_IFont->IFont_Bold( &tmp_pbold);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (tmp_pbold);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_ifont_set_bold(  /* [in] */ EIF_BOOLEAN pbold )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Bold((VARIANT_BOOL)rt_ec.ccom_ec_boolean (pbold));
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN StdFont::ccom_ifont_italic(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	VARIANT_BOOL tmp_pitalic = 0;
	
	hr = p_IFont->IFont_Italic( &tmp_pitalic);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (tmp_pitalic);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_ifont_set_italic(  /* [in] */ EIF_BOOLEAN pitalic )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Italic((VARIANT_BOOL)rt_ec.ccom_ec_boolean (pitalic));
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN StdFont::ccom_ifont_underline(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	VARIANT_BOOL tmp_punderline = 0;
	
	hr = p_IFont->IFont_Underline( &tmp_punderline);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (tmp_punderline);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_ifont_set_underline(  /* [in] */ EIF_BOOLEAN punderline )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Underline((VARIANT_BOOL)rt_ec.ccom_ec_boolean (punderline));
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN StdFont::ccom_ifont_strikethrough(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	VARIANT_BOOL tmp_pstrikethrough = 0;
	
	hr = p_IFont->IFont_Strikethrough( &tmp_pstrikethrough);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (tmp_pstrikethrough);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_ifont_set_strikethrough(  /* [in] */ EIF_BOOLEAN pstrikethrough )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Strikethrough((VARIANT_BOOL)rt_ec.ccom_ec_boolean (pstrikethrough));
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdFont::ccom_ifont_weight(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	SHORT tmp_pweight = 0;
	
	hr = p_IFont->IFont_Weight( &tmp_pweight);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_INTEGER)tmp_pweight;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_ifont_set_weight(  /* [in] */ EIF_INTEGER pweight )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Weight((SHORT)pweight);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdFont::ccom_ifont_charset(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	SHORT tmp_pcharset = 0;
	
	hr = p_IFont->IFont_Charset( &tmp_pcharset);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_INTEGER)tmp_pcharset;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_ifont_set_charset(  /* [in] */ EIF_INTEGER pcharset )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IFont_set_Charset((SHORT)pcharset);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdFont::ccom_h_font(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	OLE_HANDLE tmp_phfont = 0;
	
	hr = p_IFont->hFont( &tmp_phfont);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_INTEGER)tmp_phfont;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER StdFont::ccom_clone1(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	IFont * tmp_ppfont = 0;
	
	hr = p_IFont->Clone1(&tmp_ppfont);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	return (EIF_POINTER) tmp_ppfont;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_is_equal1(  /* [in] */ IFont * pfont_other )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->IsEqual((IFont *)pfont_other);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_set_ratio(  /* [in] */ EIF_INTEGER cy_logical,  /* [in] */ EIF_INTEGER cy_himetric )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->SetRatio((LONG)cy_logical,(LONG)cy_himetric);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_add_ref_hfont(  /* [in] */ EIF_INTEGER a_h_font )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->AddRefHfont((OLE_HANDLE)a_h_font);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdFont::ccom_release_hfont(  /* [in] */ EIF_INTEGER a_h_font )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IFont == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IFont1, (void **)&p_IFont);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IFont->ReleaseHfont((OLE_HANDLE)a_h_font);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdFont::ccom_last_error_code()

/*-----------------------------------------------------------
	Last error code
-----------------------------------------------------------*/
{
	return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE StdFont::ccom_last_source_of_exception()

/*-----------------------------------------------------------
	Last source of exception
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE StdFont::ccom_last_error_description()

/*-----------------------------------------------------------
	Last error description
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE StdFont::ccom_last_error_help_file()

/*-----------------------------------------------------------
	Last error help file
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER StdFont::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/
