/*-----------------------------------------------------------
Implemented `FontEvents' Interface.
-----------------------------------------------------------*/

#include "ecom_FontEvents_impl.h"

static const IID IID_FontEvents = {0x4ef6100a,0xaf88,0x11d0,{0x98,0x46,0x00,0xc0,0x4f,0xc2,0x99,0x93}};

#ifdef __cplusplus
extern "C" {
#endif

FontEvents_impl::FontEvents_impl( IUnknown * a_pointer )
{
	HRESULT hr, hr2;

	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};

	hr = a_pointer->QueryInterface(IID_FontEvents, (void **)&p_FontEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};

	excepinfo = (EXCEPINFO*)CoTaskMemAlloc (sizeof (EXCEPINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

FontEvents_impl::~FontEvents_impl()
{
	p_unknown->Release ();
	
	CoTaskMemFree ((void *)excepinfo);
	if (p_FontEvents!=NULL)
		p_FontEvents->Release ();
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER FontEvents_impl::ccom_last_error_code()

/*-----------------------------------------------------------
	Last error code
-----------------------------------------------------------*/
{
	return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE FontEvents_impl::ccom_last_source_of_exception()

/*-----------------------------------------------------------
	Last source of exception
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE FontEvents_impl::ccom_last_error_description()

/*-----------------------------------------------------------
	Last error description
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE FontEvents_impl::ccom_last_error_help_file()

/*-----------------------------------------------------------
	Last error help file
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void FontEvents_impl::ccom_font_changed(  /* [in] */ EIF_OBJECT property_name )

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

EIF_POINTER FontEvents_impl::ccom_item()

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