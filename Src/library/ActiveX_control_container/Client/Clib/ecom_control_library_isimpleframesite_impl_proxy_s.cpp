/*-----------------------------------------------------------
Implemented `ISimpleFrameSite' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_ISimpleFrameSite_impl_proxy_s.h"
static const IID IID_ISimpleFrameSite_ = {0x742b0e01,0x14e6,0x101b,{0x91,0x4e,0x00,0xaa,0x00,0x30,0x0c,0xab}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::ISimpleFrameSite_impl_proxy::ISimpleFrameSite_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_ISimpleFrameSite_, (void **)&p_ISimpleFrameSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ISimpleFrameSite_impl_proxy::~ISimpleFrameSite_impl_proxy()
{
	p_unknown->Release ();
	if (p_ISimpleFrameSite!=NULL)
		p_ISimpleFrameSite->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ISimpleFrameSite_impl_proxy::ccom_pre_message_filter(  /* [in] */ EIF_POINTER h_wnd,  /* [in] */ EIF_INTEGER msg,  /* [in] */ EIF_INTEGER wp,  /* [in] */ EIF_INTEGER lp,  /* [out] */ EIF_OBJECT pl_result,  /* [out] */ EIF_OBJECT pdw_cookie )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ISimpleFrameSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ISimpleFrameSite_, (void **)&p_ISimpleFrameSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::wireHWND tmp_h_wnd = 0;
	tmp_h_wnd = (ecom_control_library::wireHWND)h_wnd;
	UINT tmp_msg = 0;
	tmp_msg = (UINT)msg;
	UINT tmp_wp = 0;
	tmp_wp = (UINT)wp;
	LONG tmp_lp = 0;
	tmp_lp = (LONG)lp;
	LONG * tmp_pl_result = 0;
	tmp_pl_result = (LONG *)rt_ec.ccom_ec_pointed_long (eif_access (pl_result), NULL);
	ULONG * tmp_pdw_cookie = 0;
	tmp_pdw_cookie = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_cookie), NULL);
	
	hr = p_ISimpleFrameSite->PreMessageFilter(tmp_h_wnd,tmp_msg,tmp_wp,tmp_lp,tmp_pl_result,tmp_pdw_cookie);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_long ((LONG *)tmp_pl_result, pl_result);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_cookie, pdw_cookie);
	
	grt_ce_control_interfaces2.free_memory_202 (tmp_h_wnd);
grt_ce_control_interfaces2.ccom_free_memory_pointed_375 (tmp_pl_result);
grt_ce_control_interfaces2.ccom_free_memory_pointed_376 (tmp_pdw_cookie);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ISimpleFrameSite_impl_proxy::ccom_post_message_filter(  /* [in] */ EIF_POINTER h_wnd,  /* [in] */ EIF_INTEGER msg,  /* [in] */ EIF_INTEGER wp,  /* [in] */ EIF_INTEGER lp,  /* [out] */ EIF_OBJECT pl_result,  /* [in] */ EIF_INTEGER dw_cookie )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ISimpleFrameSite == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ISimpleFrameSite_, (void **)&p_ISimpleFrameSite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::wireHWND tmp_h_wnd = 0;
	tmp_h_wnd = (ecom_control_library::wireHWND)h_wnd;
	UINT tmp_msg = 0;
	tmp_msg = (UINT)msg;
	UINT tmp_wp = 0;
	tmp_wp = (UINT)wp;
	LONG tmp_lp = 0;
	tmp_lp = (LONG)lp;
	LONG * tmp_pl_result = 0;
	tmp_pl_result = (LONG *)rt_ec.ccom_ec_pointed_long (eif_access (pl_result), NULL);
	ULONG tmp_dw_cookie = 0;
	tmp_dw_cookie = (ULONG)dw_cookie;
	
	hr = p_ISimpleFrameSite->PostMessageFilter(tmp_h_wnd,tmp_msg,tmp_wp,tmp_lp,tmp_pl_result,tmp_dw_cookie);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_long ((LONG *)tmp_pl_result, pl_result);
	
	grt_ce_control_interfaces2.free_memory_202 (tmp_h_wnd);
grt_ce_control_interfaces2.ccom_free_memory_pointed_377 (tmp_pl_result);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::ISimpleFrameSite_impl_proxy::ccom_item()

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