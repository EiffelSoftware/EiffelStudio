/*-----------------------------------------------------------
Implemented `IAxWinHostWindow' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IAxWinHostWindow_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IAxWinHostWindow_ = {0xb6ea2050,0x048a,0x11d1,{0x82,0xb9,0x00,0xc0,0x4f,0xb9,0x94,0x2e}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IAxWinHostWindow_impl_stub::IAxWinHostWindow_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IAxWinHostWindow_impl_stub::~IAxWinHostWindow_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IAxWinHostWindow_impl_stub::CreateControl(  /* [in] */ LPWSTR lp_trics_data, /* [in] */ ecom_control_library::wireHWND h_wnd, /* [in] */ ecom_control_library::IStream * p_stream )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_lp_trics_data = NULL;
	if (lp_trics_data != NULL)
	{
		tmp_lp_trics_data = eif_protect (rt_ce.ccom_ce_lpwstr (lp_trics_data, NULL));
	}
	EIF_POINTER tmp_h_wnd = (EIF_POINTER)h_wnd;
	EIF_OBJECT tmp_p_stream = NULL;
	if (p_stream != NULL)
	{
		tmp_p_stream = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_71 (p_stream));
		p_stream->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("create_control", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_POINTER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_lp_trics_data != NULL) ? eif_access (tmp_lp_trics_data) : NULL), (EIF_POINTER)tmp_h_wnd, ((tmp_p_stream != NULL) ? eif_access (tmp_p_stream) : NULL));
	if (tmp_lp_trics_data != NULL)
		eif_wean (tmp_lp_trics_data);
	if (tmp_p_stream != NULL)
		eif_wean (tmp_p_stream);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IAxWinHostWindow_impl_stub::CreateControlEx(  /* [in] */ LPWSTR lp_trics_data, /* [in] */ ecom_control_library::wireHWND h_wnd, /* [in] */ ecom_control_library::IStream * p_stream, /* [out] */ IUnknown * * ppunk, /* [in] */ GUID * riid_advise, /* [in] */ IUnknown * punk_advise )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_lp_trics_data = NULL;
	if (lp_trics_data != NULL)
	{
		tmp_lp_trics_data = eif_protect (rt_ce.ccom_ce_lpwstr (lp_trics_data, NULL));
	}
	EIF_POINTER tmp_h_wnd = (EIF_POINTER)h_wnd;
	EIF_OBJECT tmp_p_stream = NULL;
	if (p_stream != NULL)
	{
		tmp_p_stream = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_71 (p_stream));
		p_stream->AddRef ();
	}
	EIF_OBJECT tmp_ppunk = NULL;
	if (ppunk != NULL)
	{
		tmp_ppunk = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_432 (ppunk, NULL));
		if (*ppunk != NULL)
			(*ppunk)->AddRef ();
	}
	EIF_OBJECT tmp_riid_advise = NULL;
	if (riid_advise != NULL)
	{
		tmp_riid_advise = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (riid_advise));
	}
	EIF_OBJECT tmp_punk_advise = NULL;
	if (punk_advise != NULL)
	{
		tmp_punk_advise = eif_protect (rt_ce.ccom_ce_pointed_unknown (punk_advise));
		punk_advise->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("create_control_ex", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_POINTER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_lp_trics_data != NULL) ? eif_access (tmp_lp_trics_data) : NULL), (EIF_POINTER)tmp_h_wnd, ((tmp_p_stream != NULL) ? eif_access (tmp_p_stream) : NULL), ((tmp_ppunk != NULL) ? eif_access (tmp_ppunk) : NULL), ((tmp_riid_advise != NULL) ? eif_access (tmp_riid_advise) : NULL), ((tmp_punk_advise != NULL) ? eif_access (tmp_punk_advise) : NULL));
	
	if (*ppunk != NULL)
		(*ppunk)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_432 (((tmp_ppunk != NULL) ? eif_wean (tmp_ppunk) : NULL), ppunk);
	if (*ppunk != NULL)
		(*ppunk)->AddRef ();
	if (tmp_lp_trics_data != NULL)
		eif_wean (tmp_lp_trics_data);
	if (tmp_p_stream != NULL)
		eif_wean (tmp_p_stream);
	if (tmp_riid_advise != NULL)
		eif_wean (tmp_riid_advise);
	if (tmp_punk_advise != NULL)
		eif_wean (tmp_punk_advise);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IAxWinHostWindow_impl_stub::AttachControl(  /* [in] */ IUnknown * p_unk_control, /* [in] */ ecom_control_library::wireHWND h_wnd )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_unk_control = NULL;
	if (p_unk_control != NULL)
	{
		tmp_p_unk_control = eif_protect (rt_ce.ccom_ce_pointed_unknown (p_unk_control));
		p_unk_control->AddRef ();
	}
	EIF_POINTER tmp_h_wnd = (EIF_POINTER)h_wnd;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("attach_control", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_unk_control != NULL) ? eif_access (tmp_p_unk_control) : NULL), (EIF_POINTER)tmp_h_wnd);
	if (tmp_p_unk_control != NULL)
		eif_wean (tmp_p_unk_control);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IAxWinHostWindow_impl_stub::QueryControl(  /* [in] */ GUID * riid, /* [out] */ void * * ppv_object )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_riid = NULL;
	if (riid != NULL)
	{
		tmp_riid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (riid));
	}
	EIF_OBJECT tmp_ppv_object = NULL;
	if (ppv_object != NULL)
	{
		tmp_ppv_object = eif_protect (rt_ce.ccom_ce_pointed_pointer ((void **)ppv_object, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("query_control", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_riid != NULL) ? eif_access (tmp_riid) : NULL), ((tmp_ppv_object != NULL) ? eif_access (tmp_ppv_object) : NULL));
	
	if (tmp_riid != NULL)
		eif_wean (tmp_riid);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IAxWinHostWindow_impl_stub::SetExternalDispatch(  /* [in] */ IDispatch * p_disp )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_disp = NULL;
	if (p_disp != NULL)
	{
		tmp_p_disp = eif_protect (rt_ce.ccom_ce_pointed_dispatch (p_disp));
		p_disp->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_external_dispatch", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_disp != NULL) ? eif_access (tmp_p_disp) : NULL));
	if (tmp_p_disp != NULL)
		eif_wean (tmp_p_disp);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IAxWinHostWindow_impl_stub::SetExternalUIHandler(  /* [in] */ ecom_control_library::IDocHostUIHandlerDispatch * p_disp )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_disp = NULL;
	if (p_disp != NULL)
	{
		tmp_p_disp = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_436 (p_disp));
		p_disp->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_external_uihandler", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_disp != NULL) ? eif_access (tmp_p_disp) : NULL));
	if (tmp_p_disp != NULL)
		eif_wean (tmp_p_disp);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IAxWinHostWindow_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IAxWinHostWindow_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IAxWinHostWindow_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IAxWinHostWindow*>(this);
	else if (riid == IID_IAxWinHostWindow_)
		*ppv = static_cast<ecom_control_library::IAxWinHostWindow*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif