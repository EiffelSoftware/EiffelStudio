/*-----------------------------------------------------------
Implemented `IOleLink' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleLink_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IOleLink_ = {0x0000011d,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleLink_impl_stub::IOleLink_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleLink_impl_stub::~IOleLink_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleLink_impl_stub::SetUpdateOptions(  /* [in] */ ULONG dw_update_opt )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_update_opt = (EIF_INTEGER)dw_update_opt;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_update_options", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_update_opt);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleLink_impl_stub::GetUpdateOptions(  /* [out] */ ULONG * pdw_update_opt )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pdw_update_opt = NULL;
	if (pdw_update_opt != NULL)
	{
		tmp_pdw_update_opt = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_update_opt, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_update_options", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pdw_update_opt != NULL) ? eif_access (tmp_pdw_update_opt) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_update_opt != NULL) ? eif_wean (tmp_pdw_update_opt) : NULL), pdw_update_opt);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleLink_impl_stub::SetSourceMoniker(  /* [in] */ ecom_control_library::IMoniker * pmk, /* [in] */ GUID * rclsid )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pmk = NULL;
	if (pmk != NULL)
	{
		tmp_pmk = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_8 (pmk));
		pmk->AddRef ();
	}
	EIF_OBJECT tmp_rclsid = NULL;
	if (rclsid != NULL)
	{
		tmp_rclsid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (rclsid));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_source_moniker", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pmk != NULL) ? eif_access (tmp_pmk) : NULL), ((tmp_rclsid != NULL) ? eif_access (tmp_rclsid) : NULL));
	if (tmp_pmk != NULL)
		eif_wean (tmp_pmk);
	if (tmp_rclsid != NULL)
		eif_wean (tmp_rclsid);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleLink_impl_stub::GetSourceMoniker(  /* [out] */ ecom_control_library::IMoniker * * ppmk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppmk = NULL;
	if (ppmk != NULL)
	{
		tmp_ppmk = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 (ppmk, NULL));
		if (*ppmk != NULL)
			(*ppmk)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_source_moniker", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppmk != NULL) ? eif_access (tmp_ppmk) : NULL));
	
	if (*ppmk != NULL)
		(*ppmk)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (((tmp_ppmk != NULL) ? eif_wean (tmp_ppmk) : NULL), ppmk);
	if (*ppmk != NULL)
		(*ppmk)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleLink_impl_stub::SetSourceDisplayName(  /* [in] */ LPWSTR psz_status_text )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_psz_status_text = NULL;
	if (psz_status_text != NULL)
	{
		tmp_psz_status_text = eif_protect (rt_ce.ccom_ce_lpwstr (psz_status_text, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_source_display_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_psz_status_text != NULL) ? eif_access (tmp_psz_status_text) : NULL));
	if (tmp_psz_status_text != NULL)
		eif_wean (tmp_psz_status_text);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleLink_impl_stub::GetSourceDisplayName(  /* [out] */ LPWSTR * ppsz_display_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppsz_display_name = NULL;
	if (ppsz_display_name != NULL)
	{
		tmp_ppsz_display_name = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_241 (ppsz_display_name, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_source_display_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppsz_display_name != NULL) ? eif_access (tmp_ppsz_display_name) : NULL));
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_241 (((tmp_ppsz_display_name != NULL) ? eif_wean (tmp_ppsz_display_name) : NULL), ppsz_display_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleLink_impl_stub::BindToSource(  /* [in] */ ULONG bindflags, /* [in] */ ecom_control_library::IBindCtx * pbc )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_bindflags = (EIF_INTEGER)bindflags;
	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("bind_to_source", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_bindflags, ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL));
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleLink_impl_stub::BindIfRunning( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("bind_if_running", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleLink_impl_stub::GetBoundSource(  /* [out] */ IUnknown * * ppunk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppunk = NULL;
	if (ppunk != NULL)
	{
		tmp_ppunk = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_242 (ppunk, NULL));
		if (*ppunk != NULL)
			(*ppunk)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_bound_source", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppunk != NULL) ? eif_access (tmp_ppunk) : NULL));
	
	if (*ppunk != NULL)
		(*ppunk)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_242 (((tmp_ppunk != NULL) ? eif_wean (tmp_ppunk) : NULL), ppunk);
	if (*ppunk != NULL)
		(*ppunk)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleLink_impl_stub::UnbindSource( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("unbind_source", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleLink_impl_stub::Update(  /* [in] */ ecom_control_library::IBindCtx * pbc )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("update", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL));
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IOleLink_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IOleLink_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleLink_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IOleLink*>(this);
	else if (riid == IID_IOleLink_)
		*ppv = static_cast<ecom_control_library::IOleLink*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif