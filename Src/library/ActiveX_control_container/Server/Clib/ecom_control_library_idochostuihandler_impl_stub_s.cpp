/*-----------------------------------------------------------
Implemented `IDocHostUIHandler' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IDocHostUIHandler_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IDocHostUIHandler_ = {0xbd3f23c0,0xd43e,0x11cf,{0x89,0x3b,0x00,0xaa,0x00,0xbd,0xce,0x1a}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IDocHostUIHandler_impl_stub::IDocHostUIHandler_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IDocHostUIHandler_impl_stub::~IDocHostUIHandler_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::ShowContextMenu(  /* [in] */ ULONG dw_id, /* [in] */ ecom_control_library::tagPOINT * ppt, /* [in] */ IUnknown * pcmdt_reserved, /* [in] */ IDispatch * pdisp_reserved )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_id = (EIF_INTEGER)dw_id;
	EIF_OBJECT tmp_ppt = NULL;
	if (ppt != NULL)
	{
		tmp_ppt = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_453 (ppt));
	}
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
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("show_context_menu", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_id, ((tmp_ppt != NULL) ? eif_access (tmp_ppt) : NULL), ((tmp_pcmdt_reserved != NULL) ? eif_access (tmp_pcmdt_reserved) : NULL), ((tmp_pdisp_reserved != NULL) ? eif_access (tmp_pdisp_reserved) : NULL));
	if (tmp_ppt != NULL)
		eif_wean (tmp_ppt);
	if (tmp_pcmdt_reserved != NULL)
		eif_wean (tmp_pcmdt_reserved);
	if (tmp_pdisp_reserved != NULL)
		eif_wean (tmp_pdisp_reserved);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::GetHostInfo(  /* [in, out] */ ecom_control_library::_DOCHOSTUIINFO * p_info )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_info = NULL;
	if (p_info != NULL)
	{
		tmp_p_info = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_455 (p_info));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_host_info", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_info != NULL) ? eif_access (tmp_p_info) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::ShowUI(  /* [in] */ ULONG dw_id, /* [in] */ ecom_control_library::IOleInPlaceActiveObject * p_active_object, /* [in] */ ecom_control_library::IOleCommandTarget * p_command_target, /* [in] */ ecom_control_library::IOleInPlaceFrame * p_frame, /* [in] */ ecom_control_library::IOleInPlaceUIWindow * p_doc )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_id = (EIF_INTEGER)dw_id;
	EIF_OBJECT tmp_p_active_object = NULL;
	if (p_active_object != NULL)
	{
		tmp_p_active_object = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_214 (p_active_object));
		p_active_object->AddRef ();
	}
	EIF_OBJECT tmp_p_command_target = NULL;
	if (p_command_target != NULL)
	{
		tmp_p_command_target = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_457 (p_command_target));
		p_command_target->AddRef ();
	}
	EIF_OBJECT tmp_p_frame = NULL;
	if (p_frame != NULL)
	{
		tmp_p_frame = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_225 (p_frame));
		p_frame->AddRef ();
	}
	EIF_OBJECT tmp_p_doc = NULL;
	if (p_doc != NULL)
	{
		tmp_p_doc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_212 (p_doc));
		p_doc->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("show_ui", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_id, ((tmp_p_active_object != NULL) ? eif_access (tmp_p_active_object) : NULL), ((tmp_p_command_target != NULL) ? eif_access (tmp_p_command_target) : NULL), ((tmp_p_frame != NULL) ? eif_access (tmp_p_frame) : NULL), ((tmp_p_doc != NULL) ? eif_access (tmp_p_doc) : NULL));
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

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::HideUI( void )

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

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::UpdateUI( void )

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

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::EnableModeless(  /* [in] */ LONG f_enable )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_f_enable = (EIF_INTEGER)f_enable;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enable_modeless", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_enable);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::OnDocWindowActivate(  /* [in] */ LONG f_activate )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_f_activate = (EIF_INTEGER)f_activate;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_doc_window_activate", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_activate);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::OnFrameWindowActivate(  /* [in] */ LONG f_activate )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_f_activate = (EIF_INTEGER)f_activate;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_frame_window_activate", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_activate);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::ResizeBorder(  /* [in] */ ecom_control_library::tagRECT * prc_border, /* [in] */ ecom_control_library::IOleInPlaceUIWindow * p_uiwindow, /* [in] */ LONG f_rame_window )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_prc_border = NULL;
	if (prc_border != NULL)
	{
		tmp_prc_border = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 (prc_border));
	}
	EIF_OBJECT tmp_p_uiwindow = NULL;
	if (p_uiwindow != NULL)
	{
		tmp_p_uiwindow = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_212 (p_uiwindow));
		p_uiwindow->AddRef ();
	}
	EIF_INTEGER tmp_f_rame_window = (EIF_INTEGER)f_rame_window;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("resize_border", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_prc_border != NULL) ? eif_access (tmp_prc_border) : NULL), ((tmp_p_uiwindow != NULL) ? eif_access (tmp_p_uiwindow) : NULL), (EIF_INTEGER)tmp_f_rame_window);
	if (tmp_prc_border != NULL)
		eif_wean (tmp_prc_border);
	if (tmp_p_uiwindow != NULL)
		eif_wean (tmp_p_uiwindow);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::IDocHostUIHandler_TranslateAccelerator(  /* [in] */ ecom_control_library::tagMSG * lpmsg, /* [in] */ GUID * pguid_cmd_group, /* [in] */ ULONG n_cmd_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_lpmsg = NULL;
	if (lpmsg != NULL)
	{
		tmp_lpmsg = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_198 (lpmsg));
	}
	EIF_OBJECT tmp_pguid_cmd_group = NULL;
	if (pguid_cmd_group != NULL)
	{
		tmp_pguid_cmd_group = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (pguid_cmd_group));
	}
	EIF_INTEGER tmp_n_cmd_id = (EIF_INTEGER)n_cmd_id;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("translate_accelerator", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_lpmsg != NULL) ? eif_access (tmp_lpmsg) : NULL), ((tmp_pguid_cmd_group != NULL) ? eif_access (tmp_pguid_cmd_group) : NULL), (EIF_INTEGER)tmp_n_cmd_id);
	if (tmp_lpmsg != NULL)
		eif_wean (tmp_lpmsg);
	if (tmp_pguid_cmd_group != NULL)
		eif_wean (tmp_pguid_cmd_group);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::GetOptionKeyPath(  /* [out] */ LPWSTR * pch_key, /* [in] */ ULONG dw )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pch_key = NULL;
	if (pch_key != NULL)
	{
		tmp_pch_key = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_458 (pch_key, NULL));
	}
	EIF_INTEGER tmp_dw = (EIF_INTEGER)dw;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_option_key_path", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pch_key != NULL) ? eif_access (tmp_pch_key) : NULL), (EIF_INTEGER)tmp_dw);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_458 (((tmp_pch_key != NULL) ? eif_wean (tmp_pch_key) : NULL), pch_key);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::GetDropTarget(  /* [in] */ ecom_control_library::IDropTarget * p_drop_target, /* [out] */ ecom_control_library::IDropTarget * * pp_drop_target )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_drop_target = NULL;
	if (p_drop_target != NULL)
	{
		tmp_p_drop_target = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_222 (p_drop_target));
		p_drop_target->AddRef ();
	}
	EIF_OBJECT tmp_pp_drop_target = NULL;
	if (pp_drop_target != NULL)
	{
		tmp_pp_drop_target = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_223 (pp_drop_target, NULL));
		if (*pp_drop_target != NULL)
			(*pp_drop_target)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_drop_target", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_drop_target != NULL) ? eif_access (tmp_p_drop_target) : NULL), ((tmp_pp_drop_target != NULL) ? eif_access (tmp_pp_drop_target) : NULL));
	
	if (*pp_drop_target != NULL)
		(*pp_drop_target)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_223 (((tmp_pp_drop_target != NULL) ? eif_wean (tmp_pp_drop_target) : NULL), pp_drop_target);
	if (*pp_drop_target != NULL)
		(*pp_drop_target)->AddRef ();
	if (tmp_p_drop_target != NULL)
		eif_wean (tmp_p_drop_target);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::GetExternal(  /* [out] */ IDispatch * * pp_dispatch )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_dispatch = NULL;
	if (pp_dispatch != NULL)
	{
		tmp_pp_dispatch = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_459 (pp_dispatch, NULL));
		if (*pp_dispatch != NULL)
			(*pp_dispatch)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_external", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_dispatch != NULL) ? eif_access (tmp_pp_dispatch) : NULL));
	
	if (*pp_dispatch != NULL)
		(*pp_dispatch)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_459 (((tmp_pp_dispatch != NULL) ? eif_wean (tmp_pp_dispatch) : NULL), pp_dispatch);
	if (*pp_dispatch != NULL)
		(*pp_dispatch)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::TranslateUrl(  /* [in] */ ULONG dw_translate, /* [in] */ SHORT * pch_urlin, /* [out] */ SHORT * * ppch_urlout )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_translate = (EIF_INTEGER)dw_translate;
	EIF_OBJECT tmp_pch_urlin = NULL;
	if (pch_urlin != NULL)
	{
		tmp_pch_urlin = eif_protect (rt_ce.ccom_ce_pointed_short (pch_urlin, NULL));
	}
	EIF_OBJECT tmp_ppch_urlout = NULL;
	if (ppch_urlout != NULL)
	{
		tmp_ppch_urlout = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_462 (ppch_urlout, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("translate_url", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_translate, ((tmp_pch_urlin != NULL) ? eif_access (tmp_pch_urlin) : NULL), ((tmp_ppch_urlout != NULL) ? eif_access (tmp_ppch_urlout) : NULL));
	
	if (*ppch_urlout != NULL)
		grt_ce_control_interfaces2.ccom_free_memory_pointed_461 (*ppch_urlout);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_462 (((tmp_ppch_urlout != NULL) ? eif_wean (tmp_ppch_urlout) : NULL), ppch_urlout);
	if (tmp_pch_urlin != NULL)
		eif_wean (tmp_pch_urlin);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::FilterDataObject(  /* [in] */ ecom_control_library::IDataObject * p_do, /* [out] */ ecom_control_library::IDataObject * * pp_doret )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_do = NULL;
	if (p_do != NULL)
	{
		tmp_p_do = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_106 (p_do));
		p_do->AddRef ();
	}
	EIF_OBJECT tmp_pp_doret = NULL;
	if (pp_doret != NULL)
	{
		tmp_pp_doret = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_246 (pp_doret, NULL));
		if (*pp_doret != NULL)
			(*pp_doret)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("filter_data_object", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_do != NULL) ? eif_access (tmp_p_do) : NULL), ((tmp_pp_doret != NULL) ? eif_access (tmp_pp_doret) : NULL));
	
	if (*pp_doret != NULL)
		(*pp_doret)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_246 (((tmp_pp_doret != NULL) ? eif_wean (tmp_pp_doret) : NULL), pp_doret);
	if (*pp_doret != NULL)
		(*pp_doret)->AddRef ();
	if (tmp_p_do != NULL)
		eif_wean (tmp_p_do);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IDocHostUIHandler_impl_stub::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	LONG res = InterlockedDecrement (&ref_count);
	if (res  ==  0)
	{
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IDocHostUIHandler_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IDocHostUIHandler_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IDocHostUIHandler*>(this);
	else if (riid == IID_IDocHostUIHandler_)
		*ppv = static_cast<ecom_control_library::IDocHostUIHandler*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif