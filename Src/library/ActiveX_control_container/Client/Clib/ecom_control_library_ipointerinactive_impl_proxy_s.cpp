/*-----------------------------------------------------------
Implemented `IPointerInactive' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPointerInactive_impl_proxy_s.h"
static const IID IID_IPointerInactive_ = {0x55980ba0,0x35aa,0x11cf,{0xb6,0x71,0x00,0xaa,0x00,0x4c,0xd6,0xd8}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPointerInactive_impl_proxy::IPointerInactive_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IPointerInactive_, (void **)&p_IPointerInactive);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPointerInactive_impl_proxy::~IPointerInactive_impl_proxy()
{
	p_unknown->Release ();
	if (p_IPointerInactive!=NULL)
		p_IPointerInactive->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPointerInactive_impl_proxy::ccom_get_activation_policy(  /* [out] */ EIF_OBJECT pdw_policy )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPointerInactive == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPointerInactive_, (void **)&p_IPointerInactive);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG * tmp_pdw_policy = 0;
	tmp_pdw_policy = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_policy), NULL);
	
	hr = p_IPointerInactive->GetActivationPolicy(tmp_pdw_policy);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_policy, pdw_policy);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_292 (tmp_pdw_policy);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPointerInactive_impl_proxy::ccom_on_inactive_mouse_move(  /* [in] */ ecom_control_library::tagRECT * p_rect_bounds,  /* [in] */ EIF_INTEGER x,  /* [in] */ EIF_INTEGER y,  /* [in] */ EIF_INTEGER grf_key_state )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPointerInactive == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPointerInactive_, (void **)&p_IPointerInactive);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_x = 0;
	tmp_x = (LONG)x;
	LONG tmp_y = 0;
	tmp_y = (LONG)y;
	ULONG tmp_grf_key_state = 0;
	tmp_grf_key_state = (ULONG)grf_key_state;
	
	hr = p_IPointerInactive->OnInactiveMouseMove(p_rect_bounds,tmp_x,tmp_y,tmp_grf_key_state);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPointerInactive_impl_proxy::ccom_on_inactive_set_cursor(  /* [in] */ ecom_control_library::tagRECT * p_rect_bounds,  /* [in] */ EIF_INTEGER x,  /* [in] */ EIF_INTEGER y,  /* [in] */ EIF_INTEGER dw_mouse_msg,  /* [in] */ EIF_INTEGER f_set_always )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPointerInactive == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPointerInactive_, (void **)&p_IPointerInactive);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_x = 0;
	tmp_x = (LONG)x;
	LONG tmp_y = 0;
	tmp_y = (LONG)y;
	ULONG tmp_dw_mouse_msg = 0;
	tmp_dw_mouse_msg = (ULONG)dw_mouse_msg;
	LONG tmp_f_set_always = 0;
	tmp_f_set_always = (LONG)f_set_always;
	
	hr = p_IPointerInactive->OnInactiveSetCursor(p_rect_bounds,tmp_x,tmp_y,tmp_dw_mouse_msg,tmp_f_set_always);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IPointerInactive_impl_proxy::ccom_item()

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