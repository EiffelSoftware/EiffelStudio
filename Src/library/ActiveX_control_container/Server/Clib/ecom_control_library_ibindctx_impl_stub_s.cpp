/*-----------------------------------------------------------
Implemented `IBindCtx' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IBindCtx_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IBindCtx_ = {0x0000000e,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IBindCtx_impl_stub::IBindCtx_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IBindCtx_impl_stub::~IBindCtx_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindCtx_impl_stub::RegisterObjectBound(  /* [in] */ IUnknown * punk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_punk = NULL;
	if (punk != NULL)
	{
		tmp_punk = eif_protect (rt_ce.ccom_ce_pointed_unknown (punk));
		punk->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("register_object_bound", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_punk != NULL) ? eif_access (tmp_punk) : NULL));
	if (tmp_punk != NULL)
		eif_wean (tmp_punk);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindCtx_impl_stub::RevokeObjectBound(  /* [in] */ IUnknown * punk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_punk = NULL;
	if (punk != NULL)
	{
		tmp_punk = eif_protect (rt_ce.ccom_ce_pointed_unknown (punk));
		punk->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("revoke_object_bound", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_punk != NULL) ? eif_access (tmp_punk) : NULL));
	if (tmp_punk != NULL)
		eif_wean (tmp_punk);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindCtx_impl_stub::ReleaseBoundObjects( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("release_bound_objects", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindCtx_impl_stub::RemoteSetBindOptions(  /* [in] */ ecom_control_library::tagBIND_OPTS2 * pbindopts )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pbindopts = NULL;
	if (pbindopts != NULL)
	{
		tmp_pbindopts = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_83 (pbindopts));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_set_bind_options", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbindopts != NULL) ? eif_access (tmp_pbindopts) : NULL));
	if (tmp_pbindopts != NULL)
		eif_wean (tmp_pbindopts);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindCtx_impl_stub::RemoteGetBindOptions(  /* [in, out] */ ecom_control_library::tagBIND_OPTS2 * pbindopts )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pbindopts = NULL;
	if (pbindopts != NULL)
	{
		tmp_pbindopts = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_83 (pbindopts));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_bind_options", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbindopts != NULL) ? eif_access (tmp_pbindopts) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindCtx_impl_stub::GetRunningObjectTable(  /* [out] */ ecom_control_library::IRunningObjectTable * * pprot )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pprot = NULL;
	if (pprot != NULL)
	{
		tmp_pprot = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_86 (pprot, NULL));
		if (*pprot != NULL)
			(*pprot)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_running_object_table", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pprot != NULL) ? eif_access (tmp_pprot) : NULL));
	
	if (*pprot != NULL)
		(*pprot)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_86 (((tmp_pprot != NULL) ? eif_wean (tmp_pprot) : NULL), pprot);
	if (*pprot != NULL)
		(*pprot)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindCtx_impl_stub::RegisterObjectParam(  /* [in] */ LPWSTR psz_key, /* [in] */ IUnknown * punk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_psz_key = NULL;
	if (psz_key != NULL)
	{
		tmp_psz_key = eif_protect (rt_ce.ccom_ce_lpwstr (psz_key, NULL));
	}
	EIF_OBJECT tmp_punk = NULL;
	if (punk != NULL)
	{
		tmp_punk = eif_protect (rt_ce.ccom_ce_pointed_unknown (punk));
		punk->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("register_object_param", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_psz_key != NULL) ? eif_access (tmp_psz_key) : NULL), ((tmp_punk != NULL) ? eif_access (tmp_punk) : NULL));
	if (tmp_psz_key != NULL)
		eif_wean (tmp_psz_key);
	if (tmp_punk != NULL)
		eif_wean (tmp_punk);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindCtx_impl_stub::GetObjectParam(  /* [in] */ LPWSTR psz_key, /* [out] */ IUnknown * * ppunk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_psz_key = NULL;
	if (psz_key != NULL)
	{
		tmp_psz_key = eif_protect (rt_ce.ccom_ce_lpwstr (psz_key, NULL));
	}
	EIF_OBJECT tmp_ppunk = NULL;
	if (ppunk != NULL)
	{
		tmp_ppunk = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_87 (ppunk, NULL));
		if (*ppunk != NULL)
			(*ppunk)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_object_param", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_psz_key != NULL) ? eif_access (tmp_psz_key) : NULL), ((tmp_ppunk != NULL) ? eif_access (tmp_ppunk) : NULL));
	
	if (*ppunk != NULL)
		(*ppunk)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_87 (((tmp_ppunk != NULL) ? eif_wean (tmp_ppunk) : NULL), ppunk);
	if (*ppunk != NULL)
		(*ppunk)->AddRef ();
	if (tmp_psz_key != NULL)
		eif_wean (tmp_psz_key);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindCtx_impl_stub::EnumObjectParam(  /* [out] */ ecom_control_library::IEnumString * * ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppenum = NULL;
	if (ppenum != NULL)
	{
		tmp_ppenum = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_90 (ppenum, NULL));
		if (*ppenum != NULL)
			(*ppenum)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enum_object_param", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppenum != NULL) ? eif_access (tmp_ppenum) : NULL));
	
	if (*ppenum != NULL)
		(*ppenum)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_90 (((tmp_ppenum != NULL) ? eif_wean (tmp_ppenum) : NULL), ppenum);
	if (*ppenum != NULL)
		(*ppenum)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindCtx_impl_stub::RevokeObjectParam(  /* [in] */ LPWSTR psz_key )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_psz_key = NULL;
	if (psz_key != NULL)
	{
		tmp_psz_key = eif_protect (rt_ce.ccom_ce_lpwstr (psz_key, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("revoke_object_param", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_psz_key != NULL) ? eif_access (tmp_psz_key) : NULL));
	if (tmp_psz_key != NULL)
		eif_wean (tmp_psz_key);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IBindCtx_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IBindCtx_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBindCtx_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IBindCtx*>(this);
	else if (riid == IID_IBindCtx_)
		*ppv = static_cast<ecom_control_library::IBindCtx*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif