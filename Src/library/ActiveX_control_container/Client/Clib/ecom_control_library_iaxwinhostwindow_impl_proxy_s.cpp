/*-----------------------------------------------------------
Implemented `IAxWinHostWindow' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IAxWinHostWindow_impl_proxy_s.h"
static const IID IID_IAxWinHostWindow_ = {0xb6ea2050,0x048a,0x11d1,{0x82,0xb9,0x00,0xc0,0x4f,0xb9,0x94,0x2e}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IAxWinHostWindow_impl_proxy::IAxWinHostWindow_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IAxWinHostWindow_, (void **)&p_IAxWinHostWindow);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IAxWinHostWindow_impl_proxy::~IAxWinHostWindow_impl_proxy()
{
	p_unknown->Release ();
	if (p_IAxWinHostWindow!=NULL)
		p_IAxWinHostWindow->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinHostWindow_impl_proxy::ccom_create_control(  /* [in] */ EIF_OBJECT lp_trics_data,  /* [in] */ EIF_POINTER h_wnd,  /* [in] */ ecom_control_library::IStream * p_stream )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinHostWindow == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinHostWindow_, (void **)&p_IAxWinHostWindow);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_lp_trics_data = 0;
	tmp_lp_trics_data = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (lp_trics_data), NULL);
	ecom_control_library::wireHWND tmp_h_wnd = 0;
	tmp_h_wnd = (ecom_control_library::wireHWND)h_wnd;
	
	hr = p_IAxWinHostWindow->CreateControl(tmp_lp_trics_data,tmp_h_wnd,p_stream);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	grt_ce_control_interfaces2.free_memory_202 (tmp_h_wnd);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinHostWindow_impl_proxy::ccom_create_control_ex(  /* [in] */ EIF_OBJECT lp_trics_data,  /* [in] */ EIF_POINTER h_wnd,  /* [in] */ ecom_control_library::IStream * p_stream,  /* [out] */ EIF_OBJECT ppunk,  /* [in] */ GUID * riid_advise,  /* [in] */ IUnknown * punk_advise )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinHostWindow == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinHostWindow_, (void **)&p_IAxWinHostWindow);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_lp_trics_data = 0;
	tmp_lp_trics_data = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (lp_trics_data), NULL);
	ecom_control_library::wireHWND tmp_h_wnd = 0;
	tmp_h_wnd = (ecom_control_library::wireHWND)h_wnd;
	IUnknown * * tmp_ppunk = 0;
	tmp_ppunk = (IUnknown * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_432 (eif_access (ppunk), NULL);
	
	hr = p_IAxWinHostWindow->CreateControlEx(tmp_lp_trics_data,tmp_h_wnd,p_stream,tmp_ppunk,riid_advise,punk_advise);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_432 ((IUnknown * *)tmp_ppunk, ppunk);
	
	grt_ce_control_interfaces2.free_memory_202 (tmp_h_wnd);
grt_ce_control_interfaces2.ccom_free_memory_pointed_432 (tmp_ppunk);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinHostWindow_impl_proxy::ccom_attach_control(  /* [in] */ IUnknown * p_unk_control,  /* [in] */ EIF_POINTER h_wnd )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinHostWindow == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinHostWindow_, (void **)&p_IAxWinHostWindow);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::wireHWND tmp_h_wnd = 0;
	tmp_h_wnd = (ecom_control_library::wireHWND)h_wnd;
	
	hr = p_IAxWinHostWindow->AttachControl(p_unk_control,tmp_h_wnd);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	grt_ce_control_interfaces2.free_memory_202 (tmp_h_wnd);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinHostWindow_impl_proxy::ccom_query_control(  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_object )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinHostWindow == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinHostWindow_, (void **)&p_IAxWinHostWindow);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	void * * tmp_ppv_object = 0;
	tmp_ppv_object = (void * *)rt_ec.ccom_ec_pointed_pointer (eif_access (ppv_object), NULL);
	
	hr = p_IAxWinHostWindow->QueryControl(riid,tmp_ppv_object);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_pointer ((void **)tmp_ppv_object, ppv_object);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_434 (tmp_ppv_object);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinHostWindow_impl_proxy::ccom_set_external_dispatch(  /* [in] */ IDispatch * p_disp )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinHostWindow == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinHostWindow_, (void **)&p_IAxWinHostWindow);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IAxWinHostWindow->SetExternalDispatch(p_disp);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IAxWinHostWindow_impl_proxy::ccom_set_external_uihandler(  /* [in] */ ecom_control_library::IDocHostUIHandlerDispatch * p_disp )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAxWinHostWindow == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAxWinHostWindow_, (void **)&p_IAxWinHostWindow);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IAxWinHostWindow->SetExternalUIHandler(p_disp);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IAxWinHostWindow_impl_proxy::ccom_item()

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