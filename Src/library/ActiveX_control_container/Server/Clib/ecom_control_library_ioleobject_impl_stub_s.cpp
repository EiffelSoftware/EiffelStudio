/*-----------------------------------------------------------
Implemented `IOleObject' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleObject_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IOleObject_ = {0x00000112,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleObject_impl_stub::IOleObject_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleObject_impl_stub::~IOleObject_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::SetClientSite(  /* [in] */ ecom_control_library::IOleClientSite * p_client_site )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_client_site = NULL;
	if (p_client_site != NULL)
	{
		tmp_p_client_site = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_244 (p_client_site));
		p_client_site->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_client_site", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_client_site != NULL) ? eif_access (tmp_p_client_site) : NULL));
	if (tmp_p_client_site != NULL)
		eif_wean (tmp_p_client_site);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::GetClientSite(  /* [out] */ ecom_control_library::IOleClientSite * * pp_client_site )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_client_site = NULL;
	if (pp_client_site != NULL)
	{
		tmp_pp_client_site = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_245 (pp_client_site, NULL));
		if (*pp_client_site != NULL)
			(*pp_client_site)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_client_site", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_client_site != NULL) ? eif_access (tmp_pp_client_site) : NULL));
	
	if (*pp_client_site != NULL)
		(*pp_client_site)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_245 (((tmp_pp_client_site != NULL) ? eif_wean (tmp_pp_client_site) : NULL), pp_client_site);
	if (*pp_client_site != NULL)
		(*pp_client_site)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::SetHostNames(  /* [in] */ LPWSTR sz_container_app, /* [in] */ LPWSTR sz_container_obj )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_sz_container_app = NULL;
	if (sz_container_app != NULL)
	{
		tmp_sz_container_app = eif_protect (rt_ce.ccom_ce_lpwstr (sz_container_app, NULL));
	}
	EIF_OBJECT tmp_sz_container_obj = NULL;
	if (sz_container_obj != NULL)
	{
		tmp_sz_container_obj = eif_protect (rt_ce.ccom_ce_lpwstr (sz_container_obj, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_host_names", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_sz_container_app != NULL) ? eif_access (tmp_sz_container_app) : NULL), ((tmp_sz_container_obj != NULL) ? eif_access (tmp_sz_container_obj) : NULL));
	if (tmp_sz_container_app != NULL)
		eif_wean (tmp_sz_container_app);
	if (tmp_sz_container_obj != NULL)
		eif_wean (tmp_sz_container_obj);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::Close(  /* [in] */ ULONG dw_save_option )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_save_option = (EIF_INTEGER)dw_save_option;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("close", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_save_option);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::SetMoniker(  /* [in] */ ULONG dw_which_moniker, /* [in] */ ecom_control_library::IMoniker * pmk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_which_moniker = (EIF_INTEGER)dw_which_moniker;
	EIF_OBJECT tmp_pmk = NULL;
	if (pmk != NULL)
	{
		tmp_pmk = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk));
		pmk->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_moniker", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_which_moniker, ((tmp_pmk != NULL) ? eif_access (tmp_pmk) : NULL));
	if (tmp_pmk != NULL)
		eif_wean (tmp_pmk);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::GetMoniker(  /* [in] */ ULONG dw_assign, /* [in] */ ULONG dw_which_moniker, /* [out] */ ecom_control_library::IMoniker * * ppmk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_assign = (EIF_INTEGER)dw_assign;
	EIF_INTEGER tmp_dw_which_moniker = (EIF_INTEGER)dw_which_moniker;
	EIF_OBJECT tmp_ppmk = NULL;
	if (ppmk != NULL)
	{
		tmp_ppmk = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 (ppmk, NULL));
		if (*ppmk != NULL)
			(*ppmk)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_moniker", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_assign, (EIF_INTEGER)tmp_dw_which_moniker, ((tmp_ppmk != NULL) ? eif_access (tmp_ppmk) : NULL));
	
	if (*ppmk != NULL)
		(*ppmk)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (((tmp_ppmk != NULL) ? eif_wean (tmp_ppmk) : NULL), ppmk);
	if (*ppmk != NULL)
		(*ppmk)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::InitFromData(  /* [in] */ ecom_control_library::IDataObject * p_data_object, /* [in] */ LONG f_creation, /* [in] */ ULONG dw_reserved )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_data_object = NULL;
	if (p_data_object != NULL)
	{
		tmp_p_data_object = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_106 (p_data_object));
		p_data_object->AddRef ();
	}
	EIF_INTEGER tmp_f_creation = (EIF_INTEGER)f_creation;
	EIF_INTEGER tmp_dw_reserved = (EIF_INTEGER)dw_reserved;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("init_from_data", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_data_object != NULL) ? eif_access (tmp_p_data_object) : NULL), (EIF_INTEGER)tmp_f_creation, (EIF_INTEGER)tmp_dw_reserved);
	if (tmp_p_data_object != NULL)
		eif_wean (tmp_p_data_object);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::GetClipboardData(  /* [in] */ ULONG dw_reserved, /* [out] */ ecom_control_library::IDataObject * * pp_data_object )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_reserved = (EIF_INTEGER)dw_reserved;
	EIF_OBJECT tmp_pp_data_object = NULL;
	if (pp_data_object != NULL)
	{
		tmp_pp_data_object = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_246 (pp_data_object, NULL));
		if (*pp_data_object != NULL)
			(*pp_data_object)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_clipboard_data", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_reserved, ((tmp_pp_data_object != NULL) ? eif_access (tmp_pp_data_object) : NULL));
	
	if (*pp_data_object != NULL)
		(*pp_data_object)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_246 (((tmp_pp_data_object != NULL) ? eif_wean (tmp_pp_data_object) : NULL), pp_data_object);
	if (*pp_data_object != NULL)
		(*pp_data_object)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::DoVerb(  /* [in] */ LONG i_verb, /* [in] */ ecom_control_library::tagMSG * lpmsg, /* [in] */ ecom_control_library::IOleClientSite * p_active_site, /* [in] */ LONG lindex, /* [in] */ ecom_control_library::wireHWND hwnd_parent, /* [in] */ ecom_control_library::tagRECT * lprc_pos_rect )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_i_verb = (EIF_INTEGER)i_verb;
	EIF_OBJECT tmp_lpmsg = NULL;
	if (lpmsg != NULL)
	{
		tmp_lpmsg = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_198 (lpmsg));
	}
	EIF_OBJECT tmp_p_active_site = NULL;
	if (p_active_site != NULL)
	{
		tmp_p_active_site = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_244 (p_active_site));
		p_active_site->AddRef ();
	}
	EIF_INTEGER tmp_lindex = (EIF_INTEGER)lindex;
	EIF_POINTER tmp_hwnd_parent = (EIF_POINTER)hwnd_parent;
	EIF_OBJECT tmp_lprc_pos_rect = NULL;
	if (lprc_pos_rect != NULL)
	{
		tmp_lprc_pos_rect = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_210 (lprc_pos_rect));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("do_verb", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_POINTER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_i_verb, ((tmp_lpmsg != NULL) ? eif_access (tmp_lpmsg) : NULL), ((tmp_p_active_site != NULL) ? eif_access (tmp_p_active_site) : NULL), (EIF_INTEGER)tmp_lindex, (EIF_POINTER)tmp_hwnd_parent, ((tmp_lprc_pos_rect != NULL) ? eif_access (tmp_lprc_pos_rect) : NULL));
	if (tmp_lpmsg != NULL)
		eif_wean (tmp_lpmsg);
	if (tmp_p_active_site != NULL)
		eif_wean (tmp_p_active_site);
	if (tmp_lprc_pos_rect != NULL)
		eif_wean (tmp_lprc_pos_rect);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::EnumVerbs(  /* [out] */ ecom_control_library::IEnumOLEVERB * * pp_enum_ole_verb )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_enum_ole_verb = NULL;
	if (pp_enum_ole_verb != NULL)
	{
		tmp_pp_enum_ole_verb = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_180 (pp_enum_ole_verb, NULL));
		if (*pp_enum_ole_verb != NULL)
			(*pp_enum_ole_verb)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enum_verbs", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_enum_ole_verb != NULL) ? eif_access (tmp_pp_enum_ole_verb) : NULL));
	
	if (*pp_enum_ole_verb != NULL)
		(*pp_enum_ole_verb)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_180 (((tmp_pp_enum_ole_verb != NULL) ? eif_wean (tmp_pp_enum_ole_verb) : NULL), pp_enum_ole_verb);
	if (*pp_enum_ole_verb != NULL)
		(*pp_enum_ole_verb)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::Update( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("update", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::IsUpToDate( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("is_up_to_date", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::GetUserClassID(  /* [out] */ GUID * p_clsid )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_clsid = NULL;
	if (p_clsid != NULL)
	{
		tmp_p_clsid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (p_clsid));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_user_class_id", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_clsid != NULL) ? eif_access (tmp_p_clsid) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::GetUserType(  /* [in] */ ULONG dw_form_of_type, /* [out] */ LPWSTR * psz_user_type )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_form_of_type = (EIF_INTEGER)dw_form_of_type;
	EIF_OBJECT tmp_psz_user_type = NULL;
	if (psz_user_type != NULL)
	{
		tmp_psz_user_type = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_247 (psz_user_type, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_user_type", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_form_of_type, ((tmp_psz_user_type != NULL) ? eif_access (tmp_psz_user_type) : NULL));
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_247 (((tmp_psz_user_type != NULL) ? eif_wean (tmp_psz_user_type) : NULL), psz_user_type);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::SetExtent(  /* [in] */ ULONG dw_draw_aspect, /* [in] */ ecom_control_library::tagSIZEL * psizel )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_draw_aspect = (EIF_INTEGER)dw_draw_aspect;
	EIF_OBJECT tmp_psizel = NULL;
	if (psizel != NULL)
	{
		tmp_psizel = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_249 (psizel));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_extent", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_draw_aspect, ((tmp_psizel != NULL) ? eif_access (tmp_psizel) : NULL));
	if (tmp_psizel != NULL)
		eif_wean (tmp_psizel);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::GetExtent(  /* [in] */ ULONG dw_draw_aspect, /* [out] */ ecom_control_library::tagSIZEL * psizel )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_draw_aspect = (EIF_INTEGER)dw_draw_aspect;
	EIF_OBJECT tmp_psizel = NULL;
	if (psizel != NULL)
	{
		tmp_psizel = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_249 (psizel));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_extent", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_draw_aspect, ((tmp_psizel != NULL) ? eif_access (tmp_psizel) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::Advise(  /* [in] */ ecom_control_library::IAdviseSink * p_adv_sink, /* [out] */ ULONG * pdw_connection )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_adv_sink = NULL;
	if (p_adv_sink != NULL)
	{
		tmp_p_adv_sink = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_108 (p_adv_sink));
		p_adv_sink->AddRef ();
	}
	EIF_OBJECT tmp_pdw_connection = NULL;
	if (pdw_connection != NULL)
	{
		tmp_pdw_connection = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_connection, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("advise", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_adv_sink != NULL) ? eif_access (tmp_p_adv_sink) : NULL), ((tmp_pdw_connection != NULL) ? eif_access (tmp_pdw_connection) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_connection != NULL) ? eif_wean (tmp_pdw_connection) : NULL), pdw_connection);
	if (tmp_p_adv_sink != NULL)
		eif_wean (tmp_p_adv_sink);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::Unadvise(  /* [in] */ ULONG dw_connection )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_connection = (EIF_INTEGER)dw_connection;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("unadvise", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_connection);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::EnumAdvise(  /* [out] */ ecom_control_library::IEnumSTATDATA * * ppenum_advise )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppenum_advise = NULL;
	if (ppenum_advise != NULL)
	{
		tmp_ppenum_advise = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_112 (ppenum_advise, NULL));
		if (*ppenum_advise != NULL)
			(*ppenum_advise)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enum_advise", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppenum_advise != NULL) ? eif_access (tmp_ppenum_advise) : NULL));
	
	if (*ppenum_advise != NULL)
		(*ppenum_advise)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_112 (((tmp_ppenum_advise != NULL) ? eif_wean (tmp_ppenum_advise) : NULL), ppenum_advise);
	if (*ppenum_advise != NULL)
		(*ppenum_advise)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::GetMiscStatus(  /* [in] */ ULONG dw_aspect, /* [out] */ ULONG * pdw_status )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_aspect = (EIF_INTEGER)dw_aspect;
	EIF_OBJECT tmp_pdw_status = NULL;
	if (pdw_status != NULL)
	{
		tmp_pdw_status = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_status, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_misc_status", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_aspect, ((tmp_pdw_status != NULL) ? eif_access (tmp_pdw_status) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_status != NULL) ? eif_wean (tmp_pdw_status) : NULL), pdw_status);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::SetColorScheme(  /* [in] */ ecom_control_library::tagLOGPALETTE * p_logpal )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_logpal = NULL;
	if (p_logpal != NULL)
	{
		tmp_p_logpal = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_47 (p_logpal));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_color_scheme", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_logpal != NULL) ? eif_access (tmp_p_logpal) : NULL));
	if (tmp_p_logpal != NULL)
		eif_wean (tmp_p_logpal);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IOleObject_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IOleObject_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleObject_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IOleObject*>(this);
	else if (riid == IID_IOleObject_)
		*ppv = static_cast<ecom_control_library::IOleObject*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif