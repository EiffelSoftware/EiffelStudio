/*-----------------------------------------------------------
Implemented `IPerPropertyBrowsing' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPerPropertyBrowsing_impl_proxy_s.h"
static const IID IID_IPerPropertyBrowsing_ = {0x376bd3aa,0x3845,0x101b,{0x84,0xed,0x08,0x00,0x2b,0x2e,0xc7,0x13}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPerPropertyBrowsing_impl_proxy::IPerPropertyBrowsing_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IPerPropertyBrowsing_, (void **)&p_IPerPropertyBrowsing);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPerPropertyBrowsing_impl_proxy::~IPerPropertyBrowsing_impl_proxy()
{
	p_unknown->Release ();
	if (p_IPerPropertyBrowsing!=NULL)
		p_IPerPropertyBrowsing->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPerPropertyBrowsing_impl_proxy::ccom_get_display_string(  /* [in] */ EIF_INTEGER disp_id,  /* [out] */ EIF_OBJECT p_bstr )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPerPropertyBrowsing == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPerPropertyBrowsing_, (void **)&p_IPerPropertyBrowsing);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_disp_id = 0;
	tmp_disp_id = (LONG)disp_id;
	BSTR * tmp_p_bstr = 0;
	tmp_p_bstr = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_252 (eif_access (p_bstr), NULL);
	
	hr = p_IPerPropertyBrowsing->GetDisplayString(tmp_disp_id,tmp_p_bstr);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_252 ((BSTR *)tmp_p_bstr, p_bstr);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_252 (tmp_p_bstr);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPerPropertyBrowsing_impl_proxy::ccom_map_property_to_page(  /* [in] */ EIF_INTEGER disp_id,  /* [out] */ GUID * p_clsid )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPerPropertyBrowsing == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPerPropertyBrowsing_, (void **)&p_IPerPropertyBrowsing);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_disp_id = 0;
	tmp_disp_id = (LONG)disp_id;
	
	hr = p_IPerPropertyBrowsing->MapPropertyToPage(tmp_disp_id,p_clsid);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPerPropertyBrowsing_impl_proxy::ccom_get_predefined_strings(  /* [in] */ EIF_INTEGER disp_id,  /* [out] */ ecom_control_library::tagCALPOLESTR * p_ca_strings_out,  /* [out] */ ecom_control_library::tagCADWORD * p_ca_cookies_out )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPerPropertyBrowsing == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPerPropertyBrowsing_, (void **)&p_IPerPropertyBrowsing);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_disp_id = 0;
	tmp_disp_id = (LONG)disp_id;
	
	hr = p_IPerPropertyBrowsing->GetPredefinedStrings(tmp_disp_id,p_ca_strings_out,p_ca_cookies_out);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPerPropertyBrowsing_impl_proxy::ccom_get_predefined_value(  /* [in] */ EIF_INTEGER disp_id,  /* [in] */ EIF_INTEGER dw_cookie,  /* [out] */ VARIANT * p_var_out )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPerPropertyBrowsing == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPerPropertyBrowsing_, (void **)&p_IPerPropertyBrowsing);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_disp_id = 0;
	tmp_disp_id = (LONG)disp_id;
	ULONG tmp_dw_cookie = 0;
	tmp_dw_cookie = (ULONG)dw_cookie;
	
	hr = p_IPerPropertyBrowsing->GetPredefinedValue(tmp_disp_id,tmp_dw_cookie,p_var_out);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IPerPropertyBrowsing_impl_proxy::ccom_item()

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