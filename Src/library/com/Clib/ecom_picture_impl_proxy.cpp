/*-----------------------------------------------------------
Implemented `Picture23' Interface.
-----------------------------------------------------------*/

#include "ecom_Picture23_impl_proxy.h"
static const IID IID_Picture23_ = {0x7bf80981,0xbf32,0x101a,{0x8b,0xbb,0x00,0xaa,0x00,0x30,0x0c,0xab}};

#ifdef __cplusplus
extern "C" {
#endif

Picture23_impl_proxy::Picture23_impl_proxy( IUnknown * a_pointer )
{
	HRESULT hr, hr2;

	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

	hr = a_pointer->QueryInterface(IID_Picture23_, (void **)&p_Picture23);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

	excepinfo = (EXCEPINFO*)CoTaskMemAlloc (sizeof (EXCEPINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

Picture23_impl_proxy::~Picture23_impl_proxy()
{
	p_unknown->Release ();
	
	CoTaskMemFree ((void *)excepinfo);
	if (p_Picture23!=NULL)
		p_Picture23->Release ();
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER Picture23_impl_proxy::ccom_last_error_code()

/*-----------------------------------------------------------
	Last error code
-----------------------------------------------------------*/
{
	return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE Picture23_impl_proxy::ccom_last_source_of_exception()

/*-----------------------------------------------------------
	Last source of exception
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE Picture23_impl_proxy::ccom_last_error_description()

/*-----------------------------------------------------------
	Last error description
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE Picture23_impl_proxy::ccom_last_error_help_file()

/*-----------------------------------------------------------
	Last error help file
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER Picture23_impl_proxy::ccom_handle()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Picture23 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Picture23_, (void **)&p_Picture23);
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

	hr = p_Picture23->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
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

	EIF_INTEGER result = (EIF_INTEGER)pResult.intVal;
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER Picture23_impl_proxy::ccom_h_pal()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Picture23 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Picture23_, (void **)&p_Picture23);
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

	hr = p_Picture23->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
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

	EIF_INTEGER result = (EIF_INTEGER)pResult.intVal;
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void Picture23_impl_proxy::ccom_set_h_pal( EIF_INTEGER a_value )

/*-----------------------------------------------------------
	Set No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Picture23 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Picture23_, (void **)&p_Picture23);
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

	OLE_HANDLE tmp_value;
	tmp_value = (OLE_HANDLE)a_value;
	arg.vt = 22;
	arg.intVal = tmp_value;
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

	hr = p_Picture23->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
		itoa (nArgErr, arg_no, 10);
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

EIF_INTEGER Picture23_impl_proxy::ccom_type()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Picture23 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Picture23_, (void **)&p_Picture23);
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

	hr = p_Picture23->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
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

EIF_INTEGER Picture23_impl_proxy::ccom_width()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Picture23 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Picture23_, (void **)&p_Picture23);
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

	hr = p_Picture23->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
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

	EIF_INTEGER result = (EIF_INTEGER)pResult.lVal;
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER Picture23_impl_proxy::ccom_height()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Picture23 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Picture23_, (void **)&p_Picture23);
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

	hr = p_Picture23->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
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

	EIF_INTEGER result = (EIF_INTEGER)pResult.lVal;
	return result;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void Picture23_impl_proxy::ccom_render(  /* [in] */ EIF_INTEGER hdc,  /* [in] */ EIF_INTEGER x,  /* [in] */ EIF_INTEGER y,  /* [in] */ EIF_INTEGER cx,  /* [in] */ EIF_INTEGER cy,  /* [in] */ EIF_INTEGER x_src,  /* [in] */ EIF_INTEGER y_src,  /* [in] */ EIF_INTEGER cx_src,  /* [in] */ EIF_INTEGER cy_src,  /* [in] */ EIF_POINTER prc_wbounds )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Picture23 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Picture23_, (void **)&p_Picture23);
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
	args.cArgs = 10;
	VARIANTARG *arguments;
	arguments = (VARIANTARG *)CoTaskMemAlloc (10*sizeof (VARIANTARG));
	
	arguments[9].vt = 22;
	arguments[9].intVal = (INT)hdc;
	
	arguments[8].vt = 3;
	arguments[8].lVal = (LONG)x;
	
	arguments[7].vt = 3;
	arguments[7].lVal = (LONG)y;
	
	arguments[6].vt = 3;
	arguments[6].lVal = (LONG)cx;
	
	arguments[5].vt = 3;
	arguments[5].lVal = (LONG)cy;
	
	arguments[4].vt = 3;
	arguments[4].lVal = (OLE_XPOS_HIMETRIC)x_src;
	
	arguments[3].vt = 3;
	arguments[3].lVal = (OLE_YPOS_HIMETRIC)y_src;
	
	arguments[2].vt = 3;
	arguments[2].lVal = (OLE_XSIZE_HIMETRIC)cx_src;
	
	arguments[1].vt = 3;
	arguments[1].lVal = (OLE_YSIZE_HIMETRIC)cy_src;
	
	arguments[0].byref = (void *)prc_wbounds;
	
	args.rgvarg = arguments;

	hr = p_Picture23->Invoke (disp, IID_NULL, lcid, DISPATCH_METHOD, &args, &pResult, excepinfo, &nArgErr);
	
	if (hr == DISP_E_TYPEMISMATCH || hr == DISP_E_PARAMNOTFOUND)
	{
		char * hresult_error = f.c_format_message (hr);
		char * arg_no = 0;
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
			CoTaskMemFree ((void *)arguments);
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	
	 ((void *)arguments[0].byref, prc_wbounds);
	CoTaskMemFree ((void *)arguments);
	 
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER Picture23_impl_proxy::ccom_item()

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
