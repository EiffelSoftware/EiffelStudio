/*-----------------------------------------------------------
Implemented `IDocHostUIHandlerDispatch' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IDocHostUIHandlerDispatch_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IDocHostUIHandlerDispatch_ = {0x425b5af0,0x65f1,0x11d1,{0x96,0x11,0x00,0x00,0xf8,0x1e,0x0d,0x0d}};

static const IID LIBID_control_library_ = {0xbde3247e,0x6bc6,0x47f4,{0xa4,0x6f,0xe5,0xae,0xa4,0xf8,0xdf,0x39}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::IDocHostUIHandlerDispatch_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
	pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::~IDocHostUIHandlerDispatch_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	if (pTypeInfo)
		pTypeInfo->Release ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::ShowContextMenu(  /* [in] */ ULONG dw_id, /* [in] */ ULONG x, /* [in] */ ULONG y, /* [in] */ IUnknown * pcmdt_reserved, /* [in] */ IDispatch * pdisp_reserved, /* [out, retval] */ HRESULT * dw_ret_val )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_id = (EIF_INTEGER)dw_id;
	EIF_INTEGER tmp_x = (EIF_INTEGER)x;
	EIF_INTEGER tmp_y = (EIF_INTEGER)y;
	EIF_OBJECT tmp_pcmdt_reserved = NULL;
	if (pcmdt_reserved != NULL)
	{
		tmp_pcmdt_reserved = eif_protect (rt_ce.ccom_ce_pointed_unknown (pcmdt_reserved));
		pcmdt_reserved->AddRef ();
	}
	EIF_OBJECT tmp_pdisp_reserved = NULL;
	if (pdisp_reserved != NULL)
	{
		tmp_pdisp_reserved = eif_protect (rt_ce.ccom_ce_pointed_dispatch (pdisp_reserved));
		pdisp_reserved->AddRef ();
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("show_context_menu", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_id, (EIF_INTEGER)tmp_x, (EIF_INTEGER)tmp_y, ((tmp_pcmdt_reserved != NULL) ? eif_access (tmp_pcmdt_reserved) : NULL), ((tmp_pdisp_reserved != NULL) ? eif_access (tmp_pdisp_reserved) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "show_context_menu", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*dw_ret_val = rt_ec.ccom_ec_hresult (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*dw_ret_val = NULL;
	if (tmp_pcmdt_reserved != NULL)
		eif_wean (tmp_pcmdt_reserved);
	if (tmp_pdisp_reserved != NULL)
		eif_wean (tmp_pdisp_reserved);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::GetHostInfo(  /* [in, out] */ ULONG * pdw_flags, /* [in, out] */ ULONG * pdw_double_click )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pdw_flags = NULL;
	if (pdw_flags != NULL)
	{
		tmp_pdw_flags = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_flags, NULL));
	}
	EIF_OBJECT tmp_pdw_double_click = NULL;
	if (pdw_double_click != NULL)
	{
		tmp_pdw_double_click = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_double_click, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_host_info", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pdw_flags != NULL) ? eif_access (tmp_pdw_flags) : NULL), ((tmp_pdw_double_click != NULL) ? eif_access (tmp_pdw_double_click) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_flags != NULL) ? eif_wean (tmp_pdw_flags) : NULL), pdw_flags);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_double_click != NULL) ? eif_wean (tmp_pdw_double_click) : NULL), pdw_double_click);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::ShowUI(  /* [in] */ ULONG dw_id, /* [in] */ IUnknown * p_active_object, /* [in] */ IUnknown * p_command_target, /* [in] */ IUnknown * p_frame, /* [in] */ IUnknown * p_doc, /* [out, retval] */ HRESULT * dw_ret_val )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_id = (EIF_INTEGER)dw_id;
	EIF_OBJECT tmp_p_active_object = NULL;
	if (p_active_object != NULL)
	{
		tmp_p_active_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (p_active_object));
		p_active_object->AddRef ();
	}
	EIF_OBJECT tmp_p_command_target = NULL;
	if (p_command_target != NULL)
	{
		tmp_p_command_target = eif_protect (rt_ce.ccom_ce_pointed_unknown (p_command_target));
		p_command_target->AddRef ();
	}
	EIF_OBJECT tmp_p_frame = NULL;
	if (p_frame != NULL)
	{
		tmp_p_frame = eif_protect (rt_ce.ccom_ce_pointed_unknown (p_frame));
		p_frame->AddRef ();
	}
	EIF_OBJECT tmp_p_doc = NULL;
	if (p_doc != NULL)
	{
		tmp_p_doc = eif_protect (rt_ce.ccom_ce_pointed_unknown (p_doc));
		p_doc->AddRef ();
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("show_ui", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_id, ((tmp_p_active_object != NULL) ? eif_access (tmp_p_active_object) : NULL), ((tmp_p_command_target != NULL) ? eif_access (tmp_p_command_target) : NULL), ((tmp_p_frame != NULL) ? eif_access (tmp_p_frame) : NULL), ((tmp_p_doc != NULL) ? eif_access (tmp_p_doc) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "show_ui", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*dw_ret_val = rt_ec.ccom_ec_hresult (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*dw_ret_val = NULL;
	if (tmp_p_active_object != NULL)
		eif_wean (tmp_p_active_object);
	if (tmp_p_command_target != NULL)
		eif_wean (tmp_p_command_target);
	if (tmp_p_frame != NULL)
		eif_wean (tmp_p_frame);
	if (tmp_p_doc != NULL)
		eif_wean (tmp_p_doc);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::HideUI( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("hide_ui", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::UpdateUI( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("update_ui", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::EnableModeless(  /* [in] */ VARIANT_BOOL f_enable )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_BOOLEAN tmp_f_enable = rt_ce.ccom_ce_boolean (f_enable);
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enable_modeless", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_f_enable);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::OnDocWindowActivate(  /* [in] */ VARIANT_BOOL f_activate )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_BOOLEAN tmp_f_activate = rt_ce.ccom_ce_boolean (f_activate);
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_doc_window_activate", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_f_activate);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::OnFrameWindowActivate(  /* [in] */ VARIANT_BOOL f_activate )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_BOOLEAN tmp_f_activate = rt_ce.ccom_ce_boolean (f_activate);
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_frame_window_activate", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_f_activate);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::ResizeBorder(  /* [in] */ LONG left, /* [in] */ LONG top, /* [in] */ LONG right, /* [in] */ LONG bottom, /* [in] */ IUnknown * p_uiwindow, /* [in] */ VARIANT_BOOL f_frame_window )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_left = (EIF_INTEGER)left;
	EIF_INTEGER tmp_top = (EIF_INTEGER)top;
	EIF_INTEGER tmp_right = (EIF_INTEGER)right;
	EIF_INTEGER tmp_bottom = (EIF_INTEGER)bottom;
	EIF_OBJECT tmp_p_uiwindow = NULL;
	if (p_uiwindow != NULL)
	{
		tmp_p_uiwindow = eif_protect (rt_ce.ccom_ce_pointed_unknown (p_uiwindow));
		p_uiwindow->AddRef ();
	}
	EIF_BOOLEAN tmp_f_frame_window = rt_ce.ccom_ce_boolean (f_frame_window);
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("resize_border", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_left, (EIF_INTEGER)tmp_top, (EIF_INTEGER)tmp_right, (EIF_INTEGER)tmp_bottom, ((tmp_p_uiwindow != NULL) ? eif_access (tmp_p_uiwindow) : NULL), (EIF_BOOLEAN)tmp_f_frame_window);
	if (tmp_p_uiwindow != NULL)
		eif_wean (tmp_p_uiwindow);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::TranslateAccelerator(  /* [in] */ ULONG h_wnd, /* [in] */ ULONG n_message, /* [in] */ ULONG w_param, /* [in] */ ULONG l_param, /* [in] */ BSTR bstr_guid_cmd_group, /* [in] */ ULONG n_cmd_id, /* [out, retval] */ HRESULT * dw_ret_val )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_h_wnd = (EIF_INTEGER)h_wnd;
	EIF_INTEGER tmp_n_message = (EIF_INTEGER)n_message;
	EIF_INTEGER tmp_w_param = (EIF_INTEGER)w_param;
	EIF_INTEGER tmp_l_param = (EIF_INTEGER)l_param;
	EIF_OBJECT tmp_bstr_guid_cmd_group = NULL;
	if (bstr_guid_cmd_group != NULL)
	{
		tmp_bstr_guid_cmd_group = eif_protect (rt_ce.ccom_ce_bstr (bstr_guid_cmd_group));
	}
	EIF_INTEGER tmp_n_cmd_id = (EIF_INTEGER)n_cmd_id;
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("translate_accelerator", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_INTEGER))eiffel_function) (eif_access (eiffel_object), (EIF_INTEGER)tmp_h_wnd, (EIF_INTEGER)tmp_n_message, (EIF_INTEGER)tmp_w_param, (EIF_INTEGER)tmp_l_param, ((tmp_bstr_guid_cmd_group != NULL) ? eif_access (tmp_bstr_guid_cmd_group) : NULL), (EIF_INTEGER)tmp_n_cmd_id);
	else
		tmp_value = eif_field (eif_access (eiffel_object), "translate_accelerator", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*dw_ret_val = rt_ec.ccom_ec_hresult (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*dw_ret_val = NULL;
	if (tmp_bstr_guid_cmd_group != NULL)
		eif_wean (tmp_bstr_guid_cmd_group);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::GetOptionKeyPath(  /* [out] */ BSTR * pbstr_key, /* [in] */ ULONG dw )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pbstr_key = NULL;
	if (pbstr_key != NULL)
	{
		tmp_pbstr_key = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_132 (pbstr_key, NULL));
	}
	EIF_INTEGER tmp_dw = (EIF_INTEGER)dw;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_option_key_path", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbstr_key != NULL) ? eif_access (tmp_pbstr_key) : NULL), (EIF_INTEGER)tmp_dw);
	
	if (*pbstr_key != NULL)
		rt_ce.free_memory_bstr (*pbstr_key);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_132 (((tmp_pbstr_key != NULL) ? eif_wean (tmp_pbstr_key) : NULL), pbstr_key);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::GetDropTarget(  /* [in] */ IUnknown * p_drop_target, /* [out] */ IUnknown * * pp_drop_target )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_drop_target = NULL;
	if (p_drop_target != NULL)
	{
		tmp_p_drop_target = eif_protect (rt_ce.ccom_ce_pointed_unknown (p_drop_target));
		p_drop_target->AddRef ();
	}
	EIF_OBJECT tmp_pp_drop_target = NULL;
	if (pp_drop_target != NULL)
	{
		tmp_pp_drop_target = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_133 (pp_drop_target, NULL));
		if (*pp_drop_target != NULL)
			(*pp_drop_target)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_drop_target", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_drop_target != NULL) ? eif_access (tmp_p_drop_target) : NULL), ((tmp_pp_drop_target != NULL) ? eif_access (tmp_pp_drop_target) : NULL));
	
	if (*pp_drop_target != NULL)
		(*pp_drop_target)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_133 (((tmp_pp_drop_target != NULL) ? eif_wean (tmp_pp_drop_target) : NULL), pp_drop_target);
	if (*pp_drop_target != NULL)
		(*pp_drop_target)->AddRef ();
	if (tmp_p_drop_target != NULL)
		eif_wean (tmp_p_drop_target);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::GetExternal(  /* [out] */ IDispatch * * pp_dispatch )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_dispatch = NULL;
	if (pp_dispatch != NULL)
	{
		tmp_pp_dispatch = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_134 (pp_dispatch, NULL));
		if (*pp_dispatch != NULL)
			(*pp_dispatch)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_external", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_dispatch != NULL) ? eif_access (tmp_pp_dispatch) : NULL));
	
	if (*pp_dispatch != NULL)
		(*pp_dispatch)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_134 (((tmp_pp_dispatch != NULL) ? eif_wean (tmp_pp_dispatch) : NULL), pp_dispatch);
	if (*pp_dispatch != NULL)
		(*pp_dispatch)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::TranslateUrl(  /* [in] */ ULONG dw_translate, /* [in] */ BSTR bstr_urlin, /* [out] */ BSTR * pbstr_urlout )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_translate = (EIF_INTEGER)dw_translate;
	EIF_OBJECT tmp_bstr_urlin = NULL;
	if (bstr_urlin != NULL)
	{
		tmp_bstr_urlin = eif_protect (rt_ce.ccom_ce_bstr (bstr_urlin));
	}
	EIF_OBJECT tmp_pbstr_urlout = NULL;
	if (pbstr_urlout != NULL)
	{
		tmp_pbstr_urlout = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_135 (pbstr_urlout, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("translate_url", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_translate, ((tmp_bstr_urlin != NULL) ? eif_access (tmp_bstr_urlin) : NULL), ((tmp_pbstr_urlout != NULL) ? eif_access (tmp_pbstr_urlout) : NULL));
	
	if (*pbstr_urlout != NULL)
		rt_ce.free_memory_bstr (*pbstr_urlout);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_135 (((tmp_pbstr_urlout != NULL) ? eif_wean (tmp_pbstr_urlout) : NULL), pbstr_urlout);
	if (tmp_bstr_urlin != NULL)
		eif_wean (tmp_bstr_urlin);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::FilterDataObject(  /* [in] */ IUnknown * p_do, /* [out] */ IUnknown * * pp_doret )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_do = NULL;
	if (p_do != NULL)
	{
		tmp_p_do = eif_protect (rt_ce.ccom_ce_pointed_unknown (p_do));
		p_do->AddRef ();
	}
	EIF_OBJECT tmp_pp_doret = NULL;
	if (pp_doret != NULL)
	{
		tmp_pp_doret = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_136 (pp_doret, NULL));
		if (*pp_doret != NULL)
			(*pp_doret)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("filter_data_object", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_do != NULL) ? eif_access (tmp_p_do) : NULL), ((tmp_pp_doret != NULL) ? eif_access (tmp_pp_doret) : NULL));
	
	if (*pp_doret != NULL)
		(*pp_doret)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_136 (((tmp_pp_doret != NULL) ? eif_wean (tmp_pp_doret) : NULL), pp_doret);
	if (*pp_doret != NULL)
		(*pp_doret)->AddRef ();
	if (tmp_p_do != NULL)
		eif_wean (tmp_p_do);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo )

/*-----------------------------------------------------------
	Get type info
-----------------------------------------------------------*/
{
	if ((itinfo != 0) || (pptinfo == NULL))
		return E_INVALIDARG;
	*pptinfo = NULL;
	if (pTypeInfo == 0)
	{
		HRESULT tmp_hr = 0;
		ITypeLib *pTypeLib = 0;
		tmp_hr = LoadRegTypeLib (LIBID_control_library_, 1, 0, 0, &pTypeLib);
		if (FAILED(tmp_hr))
			return tmp_hr;
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IDocHostUIHandlerDispatch_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	(*pptinfo = pTypeInfo)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::GetTypeInfoCount( unsigned int * pctinfo )

/*-----------------------------------------------------------
	Get type info count
-----------------------------------------------------------*/
{
	if (pctinfo == NULL)
		return E_NOTIMPL;
	*pctinfo = 1;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid )

/*-----------------------------------------------------------
	IDs of function names 'rgszNames'
-----------------------------------------------------------*/
{
	if (pTypeInfo == 0)
	{
		HRESULT tmp_hr = 0;
		ITypeLib *pTypeLib = 0;
		tmp_hr = LoadRegTypeLib (LIBID_control_library_, 1, 0, 0, &pTypeLib);
		if (FAILED(tmp_hr))
			return tmp_hr;
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IDocHostUIHandlerDispatch_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	return pTypeInfo->GetIDsOfNames (rgszNames, cNames, rgdispid);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr )

/*-----------------------------------------------------------
	Invoke function.
-----------------------------------------------------------*/
{
	HRESULT hr = 0;
	int i = 0;

	unsigned int uArgErr;
	if (wFlags & ~(DISPATCH_METHOD | DISPATCH_PROPERTYGET | DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
		return ResultFromScode (E_INVALIDARG);

	if (puArgErr == NULL)
		puArgErr = &uArgErr;

	VARIANTARG * rgvarg = pDispParams->rgvarg;
	DISPID * rgdispidNamedArgs = pDispParams->rgdispidNamedArgs;
	unsigned int cArgs = pDispParams->cArgs;
	unsigned int cNamedArgs = pDispParams->cNamedArgs;
	VARIANTARG ** tmp_value = NULL;

	if (pExcepInfo != NULL)
	{
		pExcepInfo->wCode = 0;
		pExcepInfo->wReserved = 0;
		pExcepInfo->bstrSource = NULL;
		pExcepInfo->bstrDescription = NULL;
		pExcepInfo->bstrHelpFile = NULL;
		pExcepInfo->dwHelpContext = 0;
		pExcepInfo->pvReserved = NULL;
		pExcepInfo->pfnDeferredFillIn = NULL;
		pExcepInfo->scode = 0;
	}
	
	switch (dispID)
	{
		
		default:
			return DISP_E_MEMBERNOTFOUND;
	}
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	LONG res = InterlockedDecrement (&ref_count);
	if (res  ==  0)
	{
		if (pTypeInfo !=NULL)
		{
			pTypeInfo->Release ();
			pTypeInfo = NULL;
		}
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandlerDispatch_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IDocHostUIHandlerDispatch*>(this);
	else if (riid == IID_IDispatch)
		*ppv = static_cast<ecom_control_library::IDocHostUIHandlerDispatch*>(this);
	else if (riid == IID_IDocHostUIHandlerDispatch_)
		*ppv = static_cast<ecom_control_library::IDocHostUIHandlerDispatch*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif