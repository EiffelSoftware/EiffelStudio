/*-----------------------------------------------------------
Implemented `IBindHost' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IBindHost_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IBindHost_ = {0xfc4801a1,0x2ba9,0x11cf,{0xa2,0x29,0x00,0xaa,0x00,0x3d,0x73,0x52}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IBindHost_impl_stub::IBindHost_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IBindHost_impl_stub::~IBindHost_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindHost_impl_stub::CreateMoniker(  /* [in] */ LPWSTR sz_name, /* [in] */ ecom_control_library::IBindCtx * pbc, /* [out] */ ecom_control_library::IMoniker * * ppmk, /* [in] */ ULONG dw_reserved )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_sz_name = NULL;
	if (sz_name != NULL)
	{
		tmp_sz_name = eif_protect (rt_ce.ccom_ce_lpwstr (sz_name, NULL));
	}
	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
	EIF_OBJECT tmp_ppmk = NULL;
	if (ppmk != NULL)
	{
		tmp_ppmk = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 (ppmk, NULL));
		if (*ppmk != NULL)
			(*ppmk)->AddRef ();
	}
	EIF_INTEGER tmp_dw_reserved = (EIF_INTEGER)dw_reserved;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("create_moniker", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_sz_name != NULL) ? eif_access (tmp_sz_name) : NULL), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), ((tmp_ppmk != NULL) ? eif_access (tmp_ppmk) : NULL), (EIF_INTEGER)tmp_dw_reserved);
	
	if (*ppmk != NULL)
		(*ppmk)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (((tmp_ppmk != NULL) ? eif_wean (tmp_ppmk) : NULL), ppmk);
	if (*ppmk != NULL)
		(*ppmk)->AddRef ();
	if (tmp_sz_name != NULL)
		eif_wean (tmp_sz_name);
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindHost_impl_stub::RemoteMonikerBindToStorage(  /* [in] */ ecom_control_library::IMoniker * pmk, /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IBindStatusCallback * p_bsc, /* [in] */ GUID * riid, /* [out] */ IUnknown * * ppv_obj )

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
	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
	EIF_OBJECT tmp_p_bsc = NULL;
	if (p_bsc != NULL)
	{
		tmp_p_bsc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_413 (p_bsc));
		p_bsc->AddRef ();
	}
	EIF_OBJECT tmp_riid = NULL;
	if (riid != NULL)
	{
		tmp_riid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (riid));
	}
	EIF_OBJECT tmp_ppv_obj = NULL;
	if (ppv_obj != NULL)
	{
		tmp_ppv_obj = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_414 (ppv_obj, NULL));
		if (*ppv_obj != NULL)
			(*ppv_obj)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_moniker_bind_to_storage", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pmk != NULL) ? eif_access (tmp_pmk) : NULL), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), ((tmp_p_bsc != NULL) ? eif_access (tmp_p_bsc) : NULL), ((tmp_riid != NULL) ? eif_access (tmp_riid) : NULL), ((tmp_ppv_obj != NULL) ? eif_access (tmp_ppv_obj) : NULL));
	
	if (*ppv_obj != NULL)
		(*ppv_obj)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_414 (((tmp_ppv_obj != NULL) ? eif_wean (tmp_ppv_obj) : NULL), ppv_obj);
	if (*ppv_obj != NULL)
		(*ppv_obj)->AddRef ();
	if (tmp_pmk != NULL)
		eif_wean (tmp_pmk);
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	if (tmp_p_bsc != NULL)
		eif_wean (tmp_p_bsc);
	if (tmp_riid != NULL)
		eif_wean (tmp_riid);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindHost_impl_stub::RemoteMonikerBindToObject(  /* [in] */ ecom_control_library::IMoniker * pmk, /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ ecom_control_library::IBindStatusCallback * p_bsc, /* [in] */ GUID * riid, /* [out] */ IUnknown * * ppv_obj )

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
	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
	EIF_OBJECT tmp_p_bsc = NULL;
	if (p_bsc != NULL)
	{
		tmp_p_bsc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_413 (p_bsc));
		p_bsc->AddRef ();
	}
	EIF_OBJECT tmp_riid = NULL;
	if (riid != NULL)
	{
		tmp_riid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (riid));
	}
	EIF_OBJECT tmp_ppv_obj = NULL;
	if (ppv_obj != NULL)
	{
		tmp_ppv_obj = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_415 (ppv_obj, NULL));
		if (*ppv_obj != NULL)
			(*ppv_obj)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_moniker_bind_to_object", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pmk != NULL) ? eif_access (tmp_pmk) : NULL), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), ((tmp_p_bsc != NULL) ? eif_access (tmp_p_bsc) : NULL), ((tmp_riid != NULL) ? eif_access (tmp_riid) : NULL), ((tmp_ppv_obj != NULL) ? eif_access (tmp_ppv_obj) : NULL));
	
	if (*ppv_obj != NULL)
		(*ppv_obj)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_415 (((tmp_ppv_obj != NULL) ? eif_wean (tmp_ppv_obj) : NULL), ppv_obj);
	if (*ppv_obj != NULL)
		(*ppv_obj)->AddRef ();
	if (tmp_pmk != NULL)
		eif_wean (tmp_pmk);
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	if (tmp_p_bsc != NULL)
		eif_wean (tmp_p_bsc);
	if (tmp_riid != NULL)
		eif_wean (tmp_riid);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IBindHost_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IBindHost_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindHost_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IBindHost*>(this);
	else if (riid == IID_IBindHost_)
		*ppv = static_cast<ecom_control_library::IBindHost*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif