/*-----------------------------------------------------------
Implemented `IBindStatusCallback' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IBindStatusCallback_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IBindStatusCallback_ = {0x79eac9c1,0xbaf9,0x11ce,{0x8c,0x82,0x00,0xaa,0x00,0x4b,0xa9,0x0b}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IBindStatusCallback_impl_stub::IBindStatusCallback_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IBindStatusCallback_impl_stub::~IBindStatusCallback_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindStatusCallback_impl_stub::OnStartBinding(  /* [in] */ ULONG dw_reserved, /* [in] */ ecom_control_library::IBinding * pib )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_reserved = (EIF_INTEGER)dw_reserved;
	EIF_OBJECT tmp_pib = NULL;
	if (pib != NULL)
	{
		tmp_pib = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_417 (pib));
		pib->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_start_binding", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_reserved, ((tmp_pib != NULL) ? eif_access (tmp_pib) : NULL));
	if (tmp_pib != NULL)
		eif_wean (tmp_pib);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindStatusCallback_impl_stub::GetPriority(  /* [out] */ LONG * pn_priority )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pn_priority = NULL;
	if (pn_priority != NULL)
	{
		tmp_pn_priority = eif_protect (rt_ce.ccom_ce_pointed_long (pn_priority, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_priority", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pn_priority != NULL) ? eif_access (tmp_pn_priority) : NULL));
	rt_ec.ccom_ec_pointed_long (((tmp_pn_priority != NULL) ? eif_wean (tmp_pn_priority) : NULL), pn_priority);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindStatusCallback_impl_stub::OnLowResource(  /* [in] */ ULONG reserved )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_reserved = (EIF_INTEGER)reserved;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_low_resource", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_reserved);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindStatusCallback_impl_stub::OnProgress(  /* [in] */ ULONG ul_progress, /* [in] */ ULONG ul_progress_max, /* [in] */ ULONG ul_status_code, /* [in] */ LPWSTR sz_status_text )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_ul_progress = (EIF_INTEGER)ul_progress;
	EIF_INTEGER tmp_ul_progress_max = (EIF_INTEGER)ul_progress_max;
	EIF_INTEGER tmp_ul_status_code = (EIF_INTEGER)ul_status_code;
	EIF_OBJECT tmp_sz_status_text = NULL;
	if (sz_status_text != NULL)
	{
		tmp_sz_status_text = eif_protect (rt_ce.ccom_ce_lpwstr (sz_status_text, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_progress", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_ul_progress, (EIF_INTEGER)tmp_ul_progress_max, (EIF_INTEGER)tmp_ul_status_code, ((tmp_sz_status_text != NULL) ? eif_access (tmp_sz_status_text) : NULL));
	if (tmp_sz_status_text != NULL)
		eif_wean (tmp_sz_status_text);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindStatusCallback_impl_stub::OnStopBinding(  /* [in] */ HRESULT hresult, /* [in] */ LPWSTR sz_error )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_hresult = NULL;
	if (hresult != NULL)
	{
		tmp_hresult = eif_protect (rt_ce.ccom_ce_hresult (hresult));
	}
	EIF_OBJECT tmp_sz_error = NULL;
	if (sz_error != NULL)
	{
		tmp_sz_error = eif_protect (rt_ce.ccom_ce_lpwstr (sz_error, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_stop_binding", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_hresult != NULL) ? eif_access (tmp_hresult) : NULL), ((tmp_sz_error != NULL) ? eif_access (tmp_sz_error) : NULL));
	if (tmp_hresult != NULL)
		eif_wean (tmp_hresult);
	if (tmp_sz_error != NULL)
		eif_wean (tmp_sz_error);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindStatusCallback_impl_stub::RemoteGetBindInfo(  /* [out] */ ULONG * grf_bindf, /* [in, out] */ ecom_control_library::_tagRemBINDINFO * pbindinfo, /* [in, out] */ ecom_control_library::tagRemSTGMEDIUM * p_stgmed )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_grf_bindf = NULL;
	if (grf_bindf != NULL)
	{
		tmp_grf_bindf = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (grf_bindf, NULL));
	}
	EIF_OBJECT tmp_pbindinfo = NULL;
	if (pbindinfo != NULL)
	{
		tmp_pbindinfo = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_421 (pbindinfo));
	}
	EIF_OBJECT tmp_p_stgmed = NULL;
	if (p_stgmed != NULL)
	{
		tmp_p_stgmed = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_423 (p_stgmed));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_bind_info", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_grf_bindf != NULL) ? eif_access (tmp_grf_bindf) : NULL), ((tmp_pbindinfo != NULL) ? eif_access (tmp_pbindinfo) : NULL), ((tmp_p_stgmed != NULL) ? eif_access (tmp_p_stgmed) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_grf_bindf != NULL) ? eif_wean (tmp_grf_bindf) : NULL), grf_bindf);
	
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindStatusCallback_impl_stub::RemoteOnDataAvailable(  /* [in] */ ULONG grf_bscf, /* [in] */ ULONG dw_size, /* [in] */ ecom_control_library::tagRemFORMATETC * p_formatetc, /* [in] */ ecom_control_library::tagRemSTGMEDIUM * p_stgmed )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_grf_bscf = (EIF_INTEGER)grf_bscf;
	EIF_INTEGER tmp_dw_size = (EIF_INTEGER)dw_size;
	EIF_OBJECT tmp_p_formatetc = NULL;
	if (p_formatetc != NULL)
	{
		tmp_p_formatetc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_425 (p_formatetc));
	}
	EIF_OBJECT tmp_p_stgmed = NULL;
	if (p_stgmed != NULL)
	{
		tmp_p_stgmed = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_423 (p_stgmed));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_on_data_available", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_grf_bscf, (EIF_INTEGER)tmp_dw_size, ((tmp_p_formatetc != NULL) ? eif_access (tmp_p_formatetc) : NULL), ((tmp_p_stgmed != NULL) ? eif_access (tmp_p_stgmed) : NULL));
	if (tmp_p_formatetc != NULL)
		eif_wean (tmp_p_formatetc);
	if (tmp_p_stgmed != NULL)
		eif_wean (tmp_p_stgmed);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindStatusCallback_impl_stub::OnObjectAvailable(  /* [in] */ GUID * riid, /* [in] */ IUnknown * punk )

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
	EIF_OBJECT tmp_punk = NULL;
	if (punk != NULL)
	{
		tmp_punk = eif_protect (rt_ce.ccom_ce_pointed_unknown (punk));
		punk->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_object_available", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_riid != NULL) ? eif_access (tmp_riid) : NULL), ((tmp_punk != NULL) ? eif_access (tmp_punk) : NULL));
	if (tmp_riid != NULL)
		eif_wean (tmp_riid);
	if (tmp_punk != NULL)
		eif_wean (tmp_punk);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IBindStatusCallback_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IBindStatusCallback_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindStatusCallback_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IBindStatusCallback*>(this);
	else if (riid == IID_IBindStatusCallback_)
		*ppv = static_cast<ecom_control_library::IBindStatusCallback*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif