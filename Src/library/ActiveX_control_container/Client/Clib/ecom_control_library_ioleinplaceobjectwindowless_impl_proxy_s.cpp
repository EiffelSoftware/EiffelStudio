/*-----------------------------------------------------------
Implemented `IOleInPlaceObjectWindowless' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleInPlaceObjectWindowless_impl_proxy_s.h"
static const IID IID_IOleInPlaceObjectWindowless_ = {0x1c2056cc,0x5ef4,0x101b,{0x8b,0xc8,0x00,0xaa,0x00,0x3e,0x3b,0x29}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy::IOleInPlaceObjectWindowless_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IOleInPlaceObjectWindowless_, (void **)&p_IOleInPlaceObjectWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy::~IOleInPlaceObjectWindowless_impl_proxy()
{
	p_unknown->Release ();
	if (p_IOleInPlaceObjectWindowless!=NULL)
		p_IOleInPlaceObjectWindowless->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy::ccom_get_window(  /* [out] */ EIF_OBJECT phwnd )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceObjectWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceObjectWindowless_, (void **)&p_IOleInPlaceObjectWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::wireHWND * tmp_phwnd = 0;
	tmp_phwnd = (ecom_control_library::wireHWND *)rt_ec.ccom_ec_pointed_pointer (eif_access (phwnd), NULL);
	
	hr = p_IOleInPlaceObjectWindowless->GetWindow(tmp_phwnd);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_pointer ((void **)tmp_phwnd, phwnd);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_208 (tmp_phwnd);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy::ccom_context_sensitive_help(  /* [in] */ EIF_INTEGER f_enter_mode )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceObjectWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceObjectWindowless_, (void **)&p_IOleInPlaceObjectWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_f_enter_mode = 0;
	tmp_f_enter_mode = (LONG)f_enter_mode;
	
	hr = p_IOleInPlaceObjectWindowless->ContextSensitiveHelp(tmp_f_enter_mode);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy::ccom_in_place_deactivate()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceObjectWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceObjectWindowless_, (void **)&p_IOleInPlaceObjectWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceObjectWindowless->InPlaceDeactivate ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy::ccom_uideactivate()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceObjectWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceObjectWindowless_, (void **)&p_IOleInPlaceObjectWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceObjectWindowless->UIDeactivate ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy::ccom_set_object_rects(  /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect,  /* [in] */ ecom_control_library::tagRECT * lprc_clip_rect )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceObjectWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceObjectWindowless_, (void **)&p_IOleInPlaceObjectWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IOleInPlaceObjectWindowless->SetObjectRects(lprc_pos_rect,lprc_clip_rect);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy::ccom_reactivate_and_undo()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceObjectWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceObjectWindowless_, (void **)&p_IOleInPlaceObjectWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IOleInPlaceObjectWindowless->ReactivateAndUndo ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy::ccom_on_window_message(  /* [in] */ EIF_INTEGER msg,  /* [in] */ EIF_INTEGER w_param,  /* [in] */ EIF_INTEGER l_param,  /* [out] */ EIF_OBJECT pl_result )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceObjectWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceObjectWindowless_, (void **)&p_IOleInPlaceObjectWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	UINT tmp_msg = 0;
	tmp_msg = (UINT)msg;
	UINT tmp_w_param = 0;
	tmp_w_param = (UINT)w_param;
	LONG tmp_l_param = 0;
	tmp_l_param = (LONG)l_param;
	LONG * tmp_pl_result = 0;
	tmp_pl_result = (LONG *)rt_ec.ccom_ec_pointed_long (eif_access (pl_result), NULL);
	
	hr = p_IOleInPlaceObjectWindowless->OnWindowMessage(tmp_msg,tmp_w_param,tmp_l_param,tmp_pl_result);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_long ((LONG *)tmp_pl_result, pl_result);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_220 (tmp_pl_result);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy::ccom_get_drop_target(  /* [out] */ EIF_OBJECT pp_drop_target )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleInPlaceObjectWindowless == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleInPlaceObjectWindowless_, (void **)&p_IOleInPlaceObjectWindowless);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::IDropTarget * * tmp_pp_drop_target = 0;
	tmp_pp_drop_target = (ecom_control_library::IDropTarget * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_223 (eif_access (pp_drop_target), NULL);
	
	hr = p_IOleInPlaceObjectWindowless->GetDropTarget(tmp_pp_drop_target);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_223 ((ecom_control_library::IDropTarget * *)tmp_pp_drop_target, pp_drop_target);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_223 (tmp_pp_drop_target);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IOleInPlaceObjectWindowless_impl_proxy::ccom_item()

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