/*-----------------------------------------------------------
Implemented `VBA__ErrObject' Interface.
-----------------------------------------------------------*/

#include "ecom_VBA__ErrObject_impl.h"
static const IID IID_VBA__ErrObject = {0xa4c466b8,0x499f,0x101b,{0xbb,0x78,0x00,0xaa,0x00,0x38,0x3c,0xbb}};

VBA__ErrObject_impl::VBA__ErrObject_impl( IUnknown * a_pointer )
{
	HRESULT hr, hr2;

	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};

	hr = a_pointer->QueryInterface(IID_VBA__ErrObject, (void **)&p_VBA__ErrObject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

VBA__ErrObject_impl::~VBA__ErrObject_impl()
{
	p_unknown->Release ();
	if (p_VBA__ErrObject!=NULL)
		p_VBA__ErrObject->Release ();
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER VBA__ErrObject_impl::ccom_number()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__ErrObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__ErrObject, (void **)&p_VBA__ErrObject);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	long ret_value = 0;
	
	hr = p_VBA__ErrObject->Number( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	

	return (EIF_INTEGER)ret_value;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void VBA__ErrObject_impl::ccom_number12(  /* [in] */ EIF_INTEGER arg_1 )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__ErrObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__ErrObject, (void **)&p_VBA__ErrObject);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_VBA__ErrObject->Number((long)arg_1);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE VBA__ErrObject_impl::ccom_source()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__ErrObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__ErrObject, (void **)&p_VBA__ErrObject);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	BSTR ret_value = SysAllocString (OLESTR (""));
	
	hr = p_VBA__ErrObject->Source( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	SysFreeString (ret_value);
	

	return (EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void VBA__ErrObject_impl::ccom_source13(  /* [in] */ EIF_OBJECT arg_1 )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__ErrObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__ErrObject, (void **)&p_VBA__ErrObject);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_VBA__ErrObject->Source((BSTR)rt_ec.ccom_ec_bstr (eif_access (arg_1)));
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE VBA__ErrObject_impl::ccom_description()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__ErrObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__ErrObject, (void **)&p_VBA__ErrObject);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	BSTR ret_value = SysAllocString (OLESTR (""));
	
	hr = p_VBA__ErrObject->Description( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	SysFreeString (ret_value);
	

	return (EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void VBA__ErrObject_impl::ccom_description14(  /* [in] */ EIF_OBJECT arg_1 )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__ErrObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__ErrObject, (void **)&p_VBA__ErrObject);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_VBA__ErrObject->Description((BSTR)rt_ec.ccom_ec_bstr (eif_access (arg_1)));
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE VBA__ErrObject_impl::ccom_help_file()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__ErrObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__ErrObject, (void **)&p_VBA__ErrObject);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	BSTR ret_value = SysAllocString (OLESTR (""));
	
	hr = p_VBA__ErrObject->HelpFile( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	SysFreeString (ret_value);
	

	return (EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void VBA__ErrObject_impl::ccom_help_file15(  /* [in] */ EIF_OBJECT arg_1 )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__ErrObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__ErrObject, (void **)&p_VBA__ErrObject);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_VBA__ErrObject->HelpFile((BSTR)rt_ec.ccom_ec_bstr (eif_access (arg_1)));
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER VBA__ErrObject_impl::ccom_help_context()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__ErrObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__ErrObject, (void **)&p_VBA__ErrObject);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	long ret_value = 0;
	
	hr = p_VBA__ErrObject->HelpContext( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	

	return (EIF_INTEGER)ret_value;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void VBA__ErrObject_impl::ccom_help_context16(  /* [in] */ EIF_INTEGER arg_1 )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__ErrObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__ErrObject, (void **)&p_VBA__ErrObject);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_VBA__ErrObject->HelpContext((long)arg_1);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void VBA__ErrObject_impl::ccom_raise(  /* [in] */ EIF_INTEGER a_number,  /* [in] */ VARIANT * a_source,  /* [in] */ VARIANT * a_description,  /* [in] */ VARIANT * a_help_file,  /* [in] */ VARIANT * a_help_context )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__ErrObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__ErrObject, (void **)&p_VBA__ErrObject);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	
	hr = p_VBA__ErrObject->Raise((long)a_number,(VARIANT *)a_source,(VARIANT *)a_description,(VARIANT *)a_help_file,(VARIANT *)a_help_context);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void VBA__ErrObject_impl::ccom_clear()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__ErrObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__ErrObject, (void **)&p_VBA__ErrObject);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	hr = p_VBA__ErrObject->Clear ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER VBA__ErrObject_impl::ccom_last_dll_error()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_VBA__ErrObject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_VBA__ErrObject, (void **)&p_VBA__ErrObject);
		if (FAILED (hr))
		{
			com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
		};
	};
	long ret_value = 0;
	
	hr = p_VBA__ErrObject->LastDllError( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), HRESULT_CODE (hr));
	};
	
	

	return (EIF_INTEGER)ret_value;
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER VBA__ErrObject_impl::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/

