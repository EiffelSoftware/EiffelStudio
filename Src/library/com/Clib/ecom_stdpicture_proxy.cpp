/*-----------------------------------------------------------
No description available.
-----------------------------------------------------------*/

#include "ecom_StdPicture.h"

static const CLSID CLSID_StdPicture = {0x0be35204,0x8f91,0x11ce,{0x9d,0xe3,0x00,0xaa,0x00,0x4b,0xb8,0x51}};

static const IID IID_Picture = {0x7bf80981,0xbf32,0x101a,{0x8b,0xbb,0x00,0xaa,0x00,0x30,0x0c,0xab}};

static const IID IID_IPicture = {0x7bf80980,0xbf32,0x101a,{0x8b,0xbb,0x00,0xaa,0x00,0x30,0x0c,0xab}};

#ifdef __cplusplus
extern "C" {
#endif

StdPicture::StdPicture()
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	p_unknown = NULL;
	MULTI_QI a_qi = {&IID_IUnknown, NULL, hr2};

	hr = CoCreateInstanceEx (CLSID_StdPicture, NULL, CLSCTX_INPROC_SERVER, NULL, 1, &a_qi);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	if (FAILED (hr2))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr2), HRESULT_CODE (hr2));
	};
	p_unknown = a_qi.pItf;

	p_Picture = 0;

	p_IPicture = 0;

	excepinfo = (EXCEPINFO*)CoTaskMemAlloc (sizeof (EXCEPINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

StdPicture::StdPicture( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};

	p_Picture = 0;
	p_IPicture = 0;
	excepinfo = (EXCEPINFO*)CoTaskMemAlloc (sizeof (EXCEPINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

StdPicture::~StdPicture()
{
	p_unknown->Release ();
	
	CoTaskMemFree ((void *)excepinfo);
	if (p_Picture!=NULL)
		p_Picture->Release ();
	if (p_IPicture!=NULL)
		p_IPicture->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdPicture::ccom_handle()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Picture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Picture, (void **)&p_Picture);
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

	hr = p_Picture->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
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

	return (EIF_INTEGER)pResult.intVal;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdPicture::ccom_h_pal()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Picture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Picture, (void **)&p_Picture);
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

	hr = p_Picture->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
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

	return (EIF_INTEGER)pResult.intVal;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdPicture::ccom_set_h_pal( EIF_INTEGER a_value )

/*-----------------------------------------------------------
	Set No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Picture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Picture, (void **)&p_Picture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
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

	hr = p_Picture->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYPUT, &args, &pResult, excepinfo, &nArgErr);
	
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

EIF_INTEGER StdPicture::ccom_type()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Picture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Picture, (void **)&p_Picture);
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

	hr = p_Picture->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
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

EIF_INTEGER StdPicture::ccom_width()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Picture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Picture, (void **)&p_Picture);
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

	hr = p_Picture->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
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

	return (EIF_INTEGER)pResult.lVal;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdPicture::ccom_height()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Picture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Picture, (void **)&p_Picture);
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

	hr = p_Picture->Invoke (disp, IID_NULL, lcid, DISPATCH_PROPERTYGET, &args, &pResult, excepinfo, &nArgErr);
	
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

	return (EIF_INTEGER)pResult.lVal;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdPicture::ccom_render(  /* [in] */ EIF_INTEGER hdc,  /* [in] */ EIF_INTEGER x,  /* [in] */ EIF_INTEGER y,  /* [in] */ EIF_INTEGER cx,  /* [in] */ EIF_INTEGER cy,  /* [in] */ EIF_INTEGER x_src,  /* [in] */ EIF_INTEGER y_src,  /* [in] */ EIF_INTEGER cx_src,  /* [in] */ EIF_INTEGER cy_src,  /* [in] */ EIF_POINTER prc_wbounds )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_Picture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_Picture, (void **)&p_Picture);
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
	
	arguments[0].vt = 16408;
	arguments[0].byref = (void *)prc_wbounds;
	
	args.rgvarg = arguments;

	hr = p_Picture->Invoke (disp, IID_NULL, lcid, DISPATCH_METHOD, &args, &pResult, excepinfo, &nArgErr);
	
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

EIF_INTEGER StdPicture::ccom_ipicture_handle(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	OLE_HANDLE tmp_phandle = 0;
	
	hr = p_IPicture->IPicture_Handle( &tmp_phandle);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_INTEGER)tmp_phandle;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdPicture::ccom_ipicture_h_pal(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	OLE_HANDLE tmp_phpal = 0;
	
	hr = p_IPicture->IPicture_hPal( &tmp_phpal);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_INTEGER)tmp_phpal;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdPicture::ccom_ipicture_type(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	SHORT tmp_ptype = 0;
	
	hr = p_IPicture->IPicture_Type( &tmp_ptype);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_INTEGER)tmp_ptype;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdPicture::ccom_ipicture_width(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	OLE_XSIZE_HIMETRIC tmp_pwidth = 0;
	
	hr = p_IPicture->IPicture_Width( &tmp_pwidth);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_INTEGER)tmp_pwidth;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdPicture::ccom_ipicture_height(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	OLE_YSIZE_HIMETRIC tmp_pheight = 0;
	
	hr = p_IPicture->IPicture_Height( &tmp_pheight);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_INTEGER)tmp_pheight;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdPicture::ccom_ipicture_render(  /* [in] */ EIF_INTEGER hdc,  /* [in] */ EIF_INTEGER x,  /* [in] */ EIF_INTEGER y,  /* [in] */ EIF_INTEGER cx,  /* [in] */ EIF_INTEGER cy,  /* [in] */ EIF_INTEGER x_src,  /* [in] */ EIF_INTEGER y_src,  /* [in] */ EIF_INTEGER cx_src,  /* [in] */ EIF_INTEGER cy_src,  /* [in] */ EIF_POINTER prc_wbounds )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IPicture->IPicture_Render((INT)hdc,(LONG)x,(LONG)y,(LONG)cx,(LONG)cy,(OLE_XPOS_HIMETRIC)x_src,(OLE_YPOS_HIMETRIC)y_src,(OLE_XSIZE_HIMETRIC)cx_src,(OLE_YSIZE_HIMETRIC)cy_src,(void *)prc_wbounds);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdPicture::ccom_ipicture_set_h_pal(  /* [in] */ EIF_INTEGER phpal )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IPicture->IPicture_set_hPal((OLE_HANDLE)phpal);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdPicture::ccom_cur_dc(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	INT tmp_phdc_out = 0;
	
	hr = p_IPicture->CurDC( &tmp_phdc_out);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_INTEGER)tmp_phdc_out;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdPicture::ccom_select_picture(  /* [in] */ EIF_INTEGER hdc_in,  /* [out] */ EIF_OBJECT phdc_out,  /* [out] */ EIF_OBJECT phbmp_out )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	INT * tmp_phdc_out = 0;
	tmp_phdc_out = (INT *)rt_ec.ccom_ec_pointed_integer (eif_access (phdc_out), NULL);
	OLE_HANDLE * tmp_phbmp_out = 0;
	tmp_phbmp_out = (OLE_HANDLE *)rt_ec.ccom_ec_pointed_integer (eif_access (phbmp_out), NULL);
	
	hr = p_IPicture->SelectPicture((INT)hdc_in,tmp_phdc_out,tmp_phbmp_out);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	rt_ce.ccom_ce_pointed_integer ((INT *)tmp_phdc_out, phdc_out);
	rt_ce.ccom_ce_pointed_integer ((int *)tmp_phbmp_out, phbmp_out);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN StdPicture::ccom_keep_original_format(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	VARIANT_BOOL tmp_pfkeep = 0;
	
	hr = p_IPicture->KeepOriginalFormat( &tmp_pfkeep);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (tmp_pfkeep);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdPicture::ccom_set_keep_original_format(  /* [in] */ EIF_BOOLEAN pfkeep )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IPicture->set_KeepOriginalFormat((VARIANT_BOOL)rt_ec.ccom_ec_boolean (pfkeep));
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdPicture::ccom_picture_changed()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	hr = p_IPicture->PictureChanged ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdPicture::ccom_save_as_file(  /* [in] */ EIF_POINTER pstm,  /* [in] */ EIF_BOOLEAN f_save_mem_copy,  /* [out] */ EIF_OBJECT pcb_size )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	LONG * tmp_pcb_size = 0;
	tmp_pcb_size = (LONG *)rt_ec.ccom_ec_pointed_long (eif_access (pcb_size), NULL);
	
	hr = p_IPicture->SaveAsFile((void *)pstm,(VARIANT_BOOL)rt_ec.ccom_ec_boolean (f_save_mem_copy),tmp_pcb_size);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	rt_ce.ccom_ce_pointed_long ((LONG *)tmp_pcb_size, pcb_size);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdPicture::ccom_attributes(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	LONG tmp_pdw_attr = 0;
	
	hr = p_IPicture->Attributes( &tmp_pdw_attr);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	

	return (EIF_INTEGER)tmp_pdw_attr;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void StdPicture::ccom_set_hdc(  /* [in] */ EIF_INTEGER hdc )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPicture == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPicture, (void **)&p_IPicture);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_IPicture->SetHdc((OLE_HANDLE)hdc);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024)),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER StdPicture::ccom_last_error_code()

/*-----------------------------------------------------------
	Last error code
-----------------------------------------------------------*/
{
	return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE StdPicture::ccom_last_source_of_exception()

/*-----------------------------------------------------------
	Last source of exception
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE StdPicture::ccom_last_error_description()

/*-----------------------------------------------------------
	Last error description
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE StdPicture::ccom_last_error_help_file()

/*-----------------------------------------------------------
	Last error help file
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER StdPicture::ccom_item()

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