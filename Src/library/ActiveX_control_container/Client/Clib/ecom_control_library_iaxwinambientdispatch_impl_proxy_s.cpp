/*-----------------------------------------------------------
Implemented `IAxWinAmbientDispatch' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IAxWinAmbientDispatch_impl_proxy_s.h"
static const IID IID_IAxWinAmbientDispatch_ = {0xb6ea2051,0x048a,0x11d1,{0x82,0xb9,0x00,0xc0,0x4f,0xb9,0x94,0x2e}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IAxWinAmbientDispatch_impl_proxy::IAxWinAmbientDispatch_impl_proxy( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

	hr = a_pointer->QueryInterface(IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

	excepinfo = (EXCEPINFO*)CoTaskMemAlloc (sizeof (EXCEPINFO));
	if (excepinfo != NULL)
		memset (excepinfo, '\0', sizeof (EXCEPINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IAxWinAmbientDispatch_impl_proxy::~IAxWinAmbientDispatch_impl_proxy()
{
	p_unknown->Release ();
	
	CoTaskMemFree ((void *)excepinfo);
	if (p_IAxWinAmbientDispatch!=NULL)
		p_IAxWinAmbientDispatch->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_last_error_code()

/*-----------------------------------------------------------
	Last error code
-----------------------------------------------------------*/
{
	return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_last_source_of_exception()

/*-----------------------------------------------------------
	Last source of exception
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_last_error_description()

/*-----------------------------------------------------------
	Last error description
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_last_error_help_file()

/*-----------------------------------------------------------
	Last error help file
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_set_allow_windowless_activation(  /* [in] */ EIF_BOOLEAN pb_can_windowless_activate )

/*-----------------------------------------------------------
	Enable or disable windowless activation
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_pb_can_windowless_activate = 0;
	tmp_pb_can_windowless_activate = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (pb_can_windowless_activate);
	
	hr = p_IAxWinAmbientDispatch->set_AllowWindowlessActivation(tmp_pb_can_windowless_activate);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_allow_windowless_activation(  )

/*-----------------------------------------------------------
	Enable or disable windowless activation
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IAxWinAmbientDispatch->AllowWindowlessActivation( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_set_back_color(  /* [in] */ EIF_INTEGER pclr_background )

/*-----------------------------------------------------------
	Set the background color
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	OLE_COLOR tmp_pclr_background = 0;
	tmp_pclr_background = (OLE_COLOR)pclr_background;
	
	hr = p_IAxWinAmbientDispatch->set_BackColor(tmp_pclr_background);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_back_color(  )

/*-----------------------------------------------------------
	Set the background color
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	OLE_COLOR ret_value = 0;
	
	hr = p_IAxWinAmbientDispatch->BackColor( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_INTEGER eiffel_result =  (EIF_INTEGER)ret_value;
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_set_fore_color(  /* [in] */ EIF_INTEGER pclr_foreground )

/*-----------------------------------------------------------
	Set the ambient foreground color
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	OLE_COLOR tmp_pclr_foreground = 0;
	tmp_pclr_foreground = (OLE_COLOR)pclr_foreground;
	
	hr = p_IAxWinAmbientDispatch->set_ForeColor(tmp_pclr_foreground);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_fore_color(  )

/*-----------------------------------------------------------
	Set the ambient foreground color
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	OLE_COLOR ret_value = 0;
	
	hr = p_IAxWinAmbientDispatch->ForeColor( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_INTEGER eiffel_result =  (EIF_INTEGER)ret_value;
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_set_locale_id(  /* [in] */ EIF_INTEGER plcid_locale_id )

/*-----------------------------------------------------------
	Set the ambient locale
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_plcid_locale_id = 0;
	tmp_plcid_locale_id = (ULONG)plcid_locale_id;
	
	hr = p_IAxWinAmbientDispatch->set_LocaleID(tmp_plcid_locale_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_locale_id(  )

/*-----------------------------------------------------------
	Set the ambient locale
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG ret_value = 0;
	
	hr = p_IAxWinAmbientDispatch->LocaleID( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_INTEGER eiffel_result =  (EIF_INTEGER)ret_value;
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_set_user_mode(  /* [in] */ EIF_BOOLEAN pb_user_mode )

/*-----------------------------------------------------------
	Set the ambient user mode
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_pb_user_mode = 0;
	tmp_pb_user_mode = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (pb_user_mode);
	
	hr = p_IAxWinAmbientDispatch->set_UserMode(tmp_pb_user_mode);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_user_mode(  )

/*-----------------------------------------------------------
	Set the ambient user mode
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IAxWinAmbientDispatch->UserMode( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_set_display_as_default(  /* [in] */ EIF_BOOLEAN pb_display_as_default )

/*-----------------------------------------------------------
	Enable or disable the control as default
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_pb_display_as_default = 0;
	tmp_pb_display_as_default = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (pb_display_as_default);
	
	hr = p_IAxWinAmbientDispatch->set_DisplayAsDefault(tmp_pb_display_as_default);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_display_as_default(  )

/*-----------------------------------------------------------
	Enable or disable the control as default
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IAxWinAmbientDispatch->DisplayAsDefault( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_set_font(  /* [in] */ Font * p_font )

/*-----------------------------------------------------------
	Set the ambient font
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IAxWinAmbientDispatch->set_Font(p_font);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_font(  )

/*-----------------------------------------------------------
	Set the ambient font
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	Font * ret_value = 0;
	
	hr = p_IAxWinAmbientDispatch->a_Font( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_control_interfaces2.ccom_ce_pointed_interface_443 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_set_message_reflect(  /* [in] */ EIF_BOOLEAN pb_msg_reflect )

/*-----------------------------------------------------------
	Enable or disable message reflection
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_pb_msg_reflect = 0;
	tmp_pb_msg_reflect = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (pb_msg_reflect);
	
	hr = p_IAxWinAmbientDispatch->set_MessageReflect(tmp_pb_msg_reflect);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_message_reflect(  )

/*-----------------------------------------------------------
	Enable or disable message reflection
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IAxWinAmbientDispatch->MessageReflect( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_show_grab_handles(  /* [in] */ EIF_OBJECT pb_show_grab_handles )

/*-----------------------------------------------------------
	Show or hide grab handles
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL * tmp_pb_show_grab_handles = 0;
	tmp_pb_show_grab_handles = (VARIANT_BOOL *)rt_ec.ccom_ec_pointed_boolean (eif_access (pb_show_grab_handles), NULL);
	
	hr = p_IAxWinAmbientDispatch->ShowGrabHandles(tmp_pb_show_grab_handles);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_446 (tmp_pb_show_grab_handles);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_show_hatching(  /* [in] */ EIF_OBJECT pb_show_hatching )

/*-----------------------------------------------------------
	Are grab handles enabled
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL * tmp_pb_show_hatching = 0;
	tmp_pb_show_hatching = (VARIANT_BOOL *)rt_ec.ccom_ec_pointed_boolean (eif_access (pb_show_hatching), NULL);
	
	hr = p_IAxWinAmbientDispatch->ShowHatching(tmp_pb_show_hatching);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_447 (tmp_pb_show_hatching);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_set_doc_host_flags(  /* [in] */ EIF_INTEGER pdw_doc_host_flags )

/*-----------------------------------------------------------
	Set the DOCHOSTUIFLAG flags
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_pdw_doc_host_flags = 0;
	tmp_pdw_doc_host_flags = (ULONG)pdw_doc_host_flags;
	
	hr = p_IAxWinAmbientDispatch->set_DocHostFlags(tmp_pdw_doc_host_flags);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_doc_host_flags(  )

/*-----------------------------------------------------------
	Set the DOCHOSTUIFLAG flags
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG ret_value = 0;
	
	hr = p_IAxWinAmbientDispatch->DocHostFlags( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_INTEGER eiffel_result =  (EIF_INTEGER)ret_value;
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_set_doc_host_double_click_flags(  /* [in] */ EIF_INTEGER pdw_doc_host_double_click_flags )

/*-----------------------------------------------------------
	Set the DOCHOSTUIDBLCLK flags
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_pdw_doc_host_double_click_flags = 0;
	tmp_pdw_doc_host_double_click_flags = (ULONG)pdw_doc_host_double_click_flags;
	
	hr = p_IAxWinAmbientDispatch->set_DocHostDoubleClickFlags(tmp_pdw_doc_host_double_click_flags);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_doc_host_double_click_flags(  )

/*-----------------------------------------------------------
	Set the DOCHOSTUIDBLCLK flags
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG ret_value = 0;
	
	hr = p_IAxWinAmbientDispatch->DocHostDoubleClickFlags( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_INTEGER eiffel_result =  (EIF_INTEGER)ret_value;
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_set_allow_context_menu(  /* [in] */ EIF_BOOLEAN pb_allow_context_menu )

/*-----------------------------------------------------------
	Enable or disable context menus
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_pb_allow_context_menu = 0;
	tmp_pb_allow_context_menu = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (pb_allow_context_menu);
	
	hr = p_IAxWinAmbientDispatch->set_AllowContextMenu(tmp_pb_allow_context_menu);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_allow_context_menu(  )

/*-----------------------------------------------------------
	Enable or disable context menus
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IAxWinAmbientDispatch->AllowContextMenu( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_set_allow_show_ui(  /* [in] */ EIF_BOOLEAN pb_allow_show_ui )

/*-----------------------------------------------------------
	Enable or disable UI
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_pb_allow_show_ui = 0;
	tmp_pb_allow_show_ui = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (pb_allow_show_ui);
	
	hr = p_IAxWinAmbientDispatch->set_AllowShowUI(tmp_pb_allow_show_ui);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_allow_show_ui(  )

/*-----------------------------------------------------------
	Enable or disable UI
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IAxWinAmbientDispatch->AllowShowUI( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_set_option_key_path(  /* [in] */ EIF_OBJECT pbstr_option_key_path )

/*-----------------------------------------------------------
	Set the option key path
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_pbstr_option_key_path = 0;
	tmp_pbstr_option_key_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (pbstr_option_key_path));
	
	hr = p_IAxWinAmbientDispatch->set_OptionKeyPath(tmp_pbstr_option_key_path);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_pbstr_option_key_path);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_option_key_path(  )

/*-----------------------------------------------------------
	Set the option key path
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinAmbientDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinAmbientDispatch_, (void **)&p_IAxWinAmbientDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IAxWinAmbientDispatch->OptionKeyPath( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IAxWinAmbientDispatch_impl_proxy::ccom_item()

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