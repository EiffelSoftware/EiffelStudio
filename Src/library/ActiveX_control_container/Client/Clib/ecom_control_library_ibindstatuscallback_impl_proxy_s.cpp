/*-----------------------------------------------------------
Implemented `IBindStatusCallback' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IBindStatusCallback_impl_proxy_s.h"
static const IID IID_IBindStatusCallback_ = {0x79eac9c1,0xbaf9,0x11ce,{0x8c,0x82,0x00,0xaa,0x00,0x4b,0xa9,0x0b}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IBindStatusCallback_impl_proxy::IBindStatusCallback_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IBindStatusCallback_, (void **)&p_IBindStatusCallback);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IBindStatusCallback_impl_proxy::~IBindStatusCallback_impl_proxy()
{
	p_unknown->Release ();
	if (p_IBindStatusCallback!=NULL)
		p_IBindStatusCallback->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindStatusCallback_impl_proxy::ccom_on_start_binding(  /* [in] */ EIF_INTEGER dw_reserved,  /* [in] */ ecom_control_library::IBinding * pib )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindStatusCallback == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindStatusCallback_, (void **)&p_IBindStatusCallback);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_reserved = 0;
	tmp_dw_reserved = (ULONG)dw_reserved;
	
	hr = p_IBindStatusCallback->OnStartBinding(tmp_dw_reserved,pib);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindStatusCallback_impl_proxy::ccom_get_priority(  /* [out] */ EIF_OBJECT pn_priority )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindStatusCallback == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindStatusCallback_, (void **)&p_IBindStatusCallback);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG * tmp_pn_priority = 0;
	tmp_pn_priority = (LONG *)rt_ec.ccom_ec_pointed_long (eif_access (pn_priority), NULL);
	
	hr = p_IBindStatusCallback->GetPriority(tmp_pn_priority);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_long ((LONG *)tmp_pn_priority, pn_priority);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_418 (tmp_pn_priority);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindStatusCallback_impl_proxy::ccom_on_low_resource(  /* [in] */ EIF_INTEGER reserved )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindStatusCallback == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindStatusCallback_, (void **)&p_IBindStatusCallback);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_reserved = 0;
	tmp_reserved = (ULONG)reserved;
	
	hr = p_IBindStatusCallback->OnLowResource(tmp_reserved);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindStatusCallback_impl_proxy::ccom_on_progress(  /* [in] */ EIF_INTEGER ul_progress,  /* [in] */ EIF_INTEGER ul_progress_max,  /* [in] */ EIF_INTEGER ul_status_code,  /* [in] */ EIF_OBJECT sz_status_text )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindStatusCallback == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindStatusCallback_, (void **)&p_IBindStatusCallback);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ul_progress = 0;
	tmp_ul_progress = (ULONG)ul_progress;
	ULONG tmp_ul_progress_max = 0;
	tmp_ul_progress_max = (ULONG)ul_progress_max;
	ULONG tmp_ul_status_code = 0;
	tmp_ul_status_code = (ULONG)ul_status_code;
	LPWSTR tmp_sz_status_text = 0;
	tmp_sz_status_text = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (sz_status_text), NULL);
	
	hr = p_IBindStatusCallback->OnProgress(tmp_ul_progress,tmp_ul_progress_max,tmp_ul_status_code,tmp_sz_status_text);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindStatusCallback_impl_proxy::ccom_on_stop_binding(  /* [in] */ EIF_OBJECT hresult,  /* [in] */ EIF_OBJECT sz_error )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindStatusCallback == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindStatusCallback_, (void **)&p_IBindStatusCallback);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	HRESULT tmp_hresult = 0;
	tmp_hresult = (HRESULT)rt_ec.ccom_ec_hresult (eif_access (hresult));
	LPWSTR tmp_sz_error = 0;
	tmp_sz_error = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (sz_error), NULL);
	
	hr = p_IBindStatusCallback->OnStopBinding(tmp_hresult,tmp_sz_error);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindStatusCallback_impl_proxy::ccom_remote_get_bind_info(  /* [out] */ EIF_OBJECT grf_bindf,  /* [in, out] */ ecom_control_library::_tagRemBINDINFO * pbindinfo,  /* [in, out] */ ecom_control_library::tagRemSTGMEDIUM * p_stgmed )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindStatusCallback == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindStatusCallback_, (void **)&p_IBindStatusCallback);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG * tmp_grf_bindf = 0;
	tmp_grf_bindf = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (grf_bindf), NULL);
	
	hr = p_IBindStatusCallback->RemoteGetBindInfo(tmp_grf_bindf,pbindinfo,p_stgmed);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_grf_bindf, grf_bindf);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_419 (tmp_grf_bindf);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindStatusCallback_impl_proxy::ccom_remote_on_data_available(  /* [in] */ EIF_INTEGER grf_bscf,  /* [in] */ EIF_INTEGER dw_size,  /* [in] */ ecom_control_library::tagRemFORMATETC * p_formatetc,  /* [in] */ ecom_control_library::tagRemSTGMEDIUM * p_stgmed )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindStatusCallback == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindStatusCallback_, (void **)&p_IBindStatusCallback);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_grf_bscf = 0;
	tmp_grf_bscf = (ULONG)grf_bscf;
	ULONG tmp_dw_size = 0;
	tmp_dw_size = (ULONG)dw_size;
	
	hr = p_IBindStatusCallback->RemoteOnDataAvailable(tmp_grf_bscf,tmp_dw_size,p_formatetc,p_stgmed);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IBindStatusCallback_impl_proxy::ccom_on_object_available(  /* [in] */ GUID * riid,  /* [in] */ IUnknown * punk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IBindStatusCallback == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IBindStatusCallback_, (void **)&p_IBindStatusCallback);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IBindStatusCallback->OnObjectAvailable(riid,punk);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IBindStatusCallback_impl_proxy::ccom_item()

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