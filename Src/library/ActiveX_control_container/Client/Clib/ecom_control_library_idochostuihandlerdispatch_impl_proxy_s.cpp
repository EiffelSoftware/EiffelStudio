/*-----------------------------------------------------------
Implemented `IDocHostUIHandlerDispatch' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IDocHostUIHandlerDispatch_impl_proxy_s.h"
static const IID IID_IDocHostUIHandlerDispatch_ = {0x425b5af0,0x65f1,0x11d1,{0x96,0x11,0x00,0x00,0xf8,0x1e,0x0d,0x0d}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::IDocHostUIHandlerDispatch_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::~IDocHostUIHandlerDispatch_impl_proxy()
{
	p_unknown->Release ();
	if (p_IDocHostUIHandlerDispatch!=NULL)
		p_IDocHostUIHandlerDispatch->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_show_context_menu(  /* [in] */ EIF_INTEGER dw_id,  /* [in] */ EIF_INTEGER x,  /* [in] */ EIF_INTEGER y,  /* [in] */ IUnknown * pcmdt_reserved,  /* [in] */ IDispatch * pdisp_reserved )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_id = 0;
	tmp_dw_id = (ULONG)dw_id;
	ULONG tmp_x = 0;
	tmp_x = (ULONG)x;
	ULONG tmp_y = 0;
	tmp_y = (ULONG)y;
	HRESULT ret_value = 0;
	
	hr = p_IDocHostUIHandlerDispatch->ShowContextMenu(tmp_dw_id,tmp_x,tmp_y,pcmdt_reserved,pdisp_reserved, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_hresult (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_get_host_info(  /* [in, out] */ EIF_OBJECT pdw_flags,  /* [in, out] */ EIF_OBJECT pdw_double_click )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG * tmp_pdw_flags = 0;
	tmp_pdw_flags = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_flags), NULL);
	ULONG * tmp_pdw_double_click = 0;
	tmp_pdw_double_click = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_double_click), NULL);
	
	hr = p_IDocHostUIHandlerDispatch->GetHostInfo(tmp_pdw_flags,tmp_pdw_double_click);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_flags, pdw_flags);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_double_click, pdw_double_click);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_128 (tmp_pdw_flags);
grt_ce_control_interfaces2.ccom_free_memory_pointed_129 (tmp_pdw_double_click);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_show_ui(  /* [in] */ EIF_INTEGER dw_id,  /* [in] */ IUnknown * p_active_object,  /* [in] */ IUnknown * p_command_target,  /* [in] */ IUnknown * p_frame,  /* [in] */ IUnknown * p_doc )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_id = 0;
	tmp_dw_id = (ULONG)dw_id;
	HRESULT ret_value = 0;
	
	hr = p_IDocHostUIHandlerDispatch->ShowUI(tmp_dw_id,p_active_object,p_command_target,p_frame,p_doc, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_hresult (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_hide_ui()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IDocHostUIHandlerDispatch->HideUI ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_update_ui()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IDocHostUIHandlerDispatch->UpdateUI ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_enable_modeless(  /* [in] */ EIF_BOOLEAN f_enable )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_f_enable = 0;
	tmp_f_enable = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (f_enable);
	
	hr = p_IDocHostUIHandlerDispatch->EnableModeless(tmp_f_enable);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_on_doc_window_activate(  /* [in] */ EIF_BOOLEAN f_activate )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_f_activate = 0;
	tmp_f_activate = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (f_activate);
	
	hr = p_IDocHostUIHandlerDispatch->OnDocWindowActivate(tmp_f_activate);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_on_frame_window_activate(  /* [in] */ EIF_BOOLEAN f_activate )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_f_activate = 0;
	tmp_f_activate = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (f_activate);
	
	hr = p_IDocHostUIHandlerDispatch->OnFrameWindowActivate(tmp_f_activate);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_resize_border(  /* [in] */ EIF_INTEGER left,  /* [in] */ EIF_INTEGER top,  /* [in] */ EIF_INTEGER right,  /* [in] */ EIF_INTEGER bottom,  /* [in] */ IUnknown * p_uiwindow,  /* [in] */ EIF_BOOLEAN f_frame_window )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_left = 0;
	tmp_left = (LONG)left;
	LONG tmp_top = 0;
	tmp_top = (LONG)top;
	LONG tmp_right = 0;
	tmp_right = (LONG)right;
	LONG tmp_bottom = 0;
	tmp_bottom = (LONG)bottom;
	VARIANT_BOOL tmp_f_frame_window = 0;
	tmp_f_frame_window = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (f_frame_window);
	
	hr = p_IDocHostUIHandlerDispatch->ResizeBorder(tmp_left,tmp_top,tmp_right,tmp_bottom,p_uiwindow,tmp_f_frame_window);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_translate_accelerator(  /* [in] */ EIF_INTEGER h_wnd,  /* [in] */ EIF_INTEGER n_message,  /* [in] */ EIF_INTEGER w_param,  /* [in] */ EIF_INTEGER l_param,  /* [in] */ EIF_OBJECT bstr_guid_cmd_group,  /* [in] */ EIF_INTEGER n_cmd_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_h_wnd = 0;
	tmp_h_wnd = (ULONG)h_wnd;
	ULONG tmp_n_message = 0;
	tmp_n_message = (ULONG)n_message;
	ULONG tmp_w_param = 0;
	tmp_w_param = (ULONG)w_param;
	ULONG tmp_l_param = 0;
	tmp_l_param = (ULONG)l_param;
	BSTR tmp_bstr_guid_cmd_group = 0;
	tmp_bstr_guid_cmd_group = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_guid_cmd_group));
	ULONG tmp_n_cmd_id = 0;
	tmp_n_cmd_id = (ULONG)n_cmd_id;
	HRESULT ret_value = 0;
	
	hr = p_IDocHostUIHandlerDispatch->TranslateAccelerator(tmp_h_wnd,tmp_n_message,tmp_w_param,tmp_l_param,tmp_bstr_guid_cmd_group,tmp_n_cmd_id, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_guid_cmd_group);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_hresult (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_get_option_key_path(  /* [out] */ EIF_OBJECT pbstr_key,  /* [in] */ EIF_INTEGER dw )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR * tmp_pbstr_key = 0;
	tmp_pbstr_key = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_132 (eif_access (pbstr_key), NULL);
	ULONG tmp_dw = 0;
	tmp_dw = (ULONG)dw;
	
	hr = p_IDocHostUIHandlerDispatch->GetOptionKeyPath(tmp_pbstr_key,tmp_dw);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_132 ((BSTR *)tmp_pbstr_key, pbstr_key);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_132 (tmp_pbstr_key);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_get_drop_target(  /* [in] */ IUnknown * p_drop_target,  /* [out] */ EIF_OBJECT pp_drop_target )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	IUnknown * * tmp_pp_drop_target = 0;
	tmp_pp_drop_target = (IUnknown * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_133 (eif_access (pp_drop_target), NULL);
	
	hr = p_IDocHostUIHandlerDispatch->GetDropTarget(p_drop_target,tmp_pp_drop_target);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_133 ((IUnknown * *)tmp_pp_drop_target, pp_drop_target);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_133 (tmp_pp_drop_target);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_get_external(  /* [out] */ EIF_OBJECT pp_dispatch )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	IDispatch * * tmp_pp_dispatch = 0;
	tmp_pp_dispatch = (IDispatch * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_134 (eif_access (pp_dispatch), NULL);
	
	hr = p_IDocHostUIHandlerDispatch->GetExternal(tmp_pp_dispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_134 ((IDispatch * *)tmp_pp_dispatch, pp_dispatch);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_134 (tmp_pp_dispatch);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_translate_url(  /* [in] */ EIF_INTEGER dw_translate,  /* [in] */ EIF_OBJECT bstr_urlin,  /* [out] */ EIF_OBJECT pbstr_urlout )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_translate = 0;
	tmp_dw_translate = (ULONG)dw_translate;
	BSTR tmp_bstr_urlin = 0;
	tmp_bstr_urlin = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_urlin));
	BSTR * tmp_pbstr_urlout = 0;
	tmp_pbstr_urlout = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_135 (eif_access (pbstr_urlout), NULL);
	
	hr = p_IDocHostUIHandlerDispatch->TranslateUrl(tmp_dw_translate,tmp_bstr_urlin,tmp_pbstr_urlout);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_135 ((BSTR *)tmp_pbstr_urlout, pbstr_urlout);
	
	rt_ce.free_memory_bstr (tmp_bstr_urlin);
grt_ce_control_interfaces2.ccom_free_memory_pointed_135 (tmp_pbstr_urlout);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_filter_data_object(  /* [in] */ IUnknown * p_do,  /* [out] */ EIF_OBJECT pp_doret )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IDocHostUIHandlerDispatch == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IDocHostUIHandlerDispatch_, (void **)&p_IDocHostUIHandlerDispatch);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	IUnknown * * tmp_pp_doret = 0;
	tmp_pp_doret = (IUnknown * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_136 (eif_access (pp_doret), NULL);
	
	hr = p_IDocHostUIHandlerDispatch->FilterDataObject(p_do,tmp_pp_doret);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_136 ((IUnknown * *)tmp_pp_doret, pp_doret);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_136 (tmp_pp_doret);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IDocHostUIHandlerDispatch_impl_proxy::ccom_item()

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