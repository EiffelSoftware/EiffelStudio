/*-----------------------------------------------------------
Implemented `IOleItemContainer' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleItemContainer_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IOleItemContainer_ = {0x0000011c,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IOleContainer_ = {0x0000011b,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

static const IID IID_IParseDisplayName_ = {0x0000011a,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleItemContainer_impl_stub::IOleItemContainer_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleItemContainer_impl_stub::~IOleItemContainer_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleItemContainer_impl_stub::ParseDisplayName(  /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ LPWSTR psz_display_name, /* [out] */ ULONG * pch_eaten, /* [out] */ ecom_control_library::IMoniker * * ppmk_out )

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
	EIF_OBJECT tmp_psz_display_name = NULL;
	if (psz_display_name != NULL)
	{
		tmp_psz_display_name = eif_protect (rt_ce.ccom_ce_lpwstr (psz_display_name, NULL));
	}
	EIF_OBJECT tmp_pch_eaten = NULL;
	if (pch_eaten != NULL)
	{
		tmp_pch_eaten = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pch_eaten, NULL));
	}
	EIF_OBJECT tmp_ppmk_out = NULL;
	if (ppmk_out != NULL)
	{
		tmp_ppmk_out = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 (ppmk_out, NULL));
		if (*ppmk_out != NULL)
			(*ppmk_out)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("parse_display_name", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), ((tmp_psz_display_name != NULL) ? eif_access (tmp_psz_display_name) : NULL), ((tmp_pch_eaten != NULL) ? eif_access (tmp_pch_eaten) : NULL), ((tmp_ppmk_out != NULL) ? eif_access (tmp_ppmk_out) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pch_eaten != NULL) ? eif_wean (tmp_pch_eaten) : NULL), pch_eaten);
	
	if (*ppmk_out != NULL)
		(*ppmk_out)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (((tmp_ppmk_out != NULL) ? eif_wean (tmp_ppmk_out) : NULL), ppmk_out);
	if (*ppmk_out != NULL)
		(*ppmk_out)->AddRef ();
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	if (tmp_psz_display_name != NULL)
		eif_wean (tmp_psz_display_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleItemContainer_impl_stub::EnumObjects(  /* [in] */ ULONG grf_flags, /* [out] */ ecom_control_library::IEnumUnknown * * ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_grf_flags = (EIF_INTEGER)grf_flags;
	EIF_OBJECT tmp_ppenum = NULL;
	if (ppenum != NULL)
	{
		tmp_ppenum = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_191 (ppenum, NULL));
		if (*ppenum != NULL)
			(*ppenum)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("enum_objects", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_grf_flags, ((tmp_ppenum != NULL) ? eif_access (tmp_ppenum) : NULL));
	
	if (*ppenum != NULL)
		(*ppenum)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_191 (((tmp_ppenum != NULL) ? eif_wean (tmp_ppenum) : NULL), ppenum);
	if (*ppenum != NULL)
		(*ppenum)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleItemContainer_impl_stub::LockContainer(  /* [in] */ LONG f_lock )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_f_lock = (EIF_INTEGER)f_lock;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("lock_container", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_f_lock);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleItemContainer_impl_stub::GetObject(  /* [in] */ LPWSTR psz_item, /* [in] */ ULONG dw_speed_needed, /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ GUID * riid, /* [out] */ void * * ppv_object )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_psz_item = NULL;
	if (psz_item != NULL)
	{
		tmp_psz_item = eif_protect (rt_ce.ccom_ce_lpwstr (psz_item, NULL));
	}
	EIF_INTEGER tmp_dw_speed_needed = (EIF_INTEGER)dw_speed_needed;
	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
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
	eiffel_procedure = eif_procedure ("get_object", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_psz_item != NULL) ? eif_access (tmp_psz_item) : NULL), (EIF_INTEGER)tmp_dw_speed_needed, ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), ((tmp_riid != NULL) ? eif_access (tmp_riid) : NULL), ((tmp_ppv_object != NULL) ? eif_access (tmp_ppv_object) : NULL));
	
	if (tmp_psz_item != NULL)
		eif_wean (tmp_psz_item);
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	if (tmp_riid != NULL)
		eif_wean (tmp_riid);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleItemContainer_impl_stub::GetObjectStorage(  /* [in] */ LPWSTR psz_item, /* [in] */ ecom_control_library::IBindCtx * pbc, /* [in] */ GUID * riid, /* [out] */ void * * ppv_storage )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_psz_item = NULL;
	if (psz_item != NULL)
	{
		tmp_psz_item = eif_protect (rt_ce.ccom_ce_lpwstr (psz_item, NULL));
	}
	EIF_OBJECT tmp_pbc = NULL;
	if (pbc != NULL)
	{
		tmp_pbc = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_55 (pbc));
		pbc->AddRef ();
	}
	EIF_OBJECT tmp_riid = NULL;
	if (riid != NULL)
	{
		tmp_riid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (riid));
	}
	EIF_OBJECT tmp_ppv_storage = NULL;
	if (ppv_storage != NULL)
	{
		tmp_ppv_storage = eif_protect (rt_ce.ccom_ce_pointed_pointer ((void **)ppv_storage, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_object_storage", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_psz_item != NULL) ? eif_access (tmp_psz_item) : NULL), ((tmp_pbc != NULL) ? eif_access (tmp_pbc) : NULL), ((tmp_riid != NULL) ? eif_access (tmp_riid) : NULL), ((tmp_ppv_storage != NULL) ? eif_access (tmp_ppv_storage) : NULL));
	
	if (tmp_psz_item != NULL)
		eif_wean (tmp_psz_item);
	if (tmp_pbc != NULL)
		eif_wean (tmp_pbc);
	if (tmp_riid != NULL)
		eif_wean (tmp_riid);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleItemContainer_impl_stub::IsRunning(  /* [in] */ LPWSTR psz_item )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_psz_item = NULL;
	if (psz_item != NULL)
	{
		tmp_psz_item = eif_protect (rt_ce.ccom_ce_lpwstr (psz_item, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("is_running", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_psz_item != NULL) ? eif_access (tmp_psz_item) : NULL));
	if (tmp_psz_item != NULL)
		eif_wean (tmp_psz_item);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IOleItemContainer_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IOleItemContainer_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IOleItemContainer_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IOleItemContainer*>(this);
	else if (riid == IID_IOleItemContainer_)
		*ppv = static_cast<ecom_control_library::IOleItemContainer*>(this);
	else if (riid == IID_IOleContainer_)
		*ppv = static_cast<ecom_control_library::IOleContainer*>(this);
	else if (riid == IID_IParseDisplayName_)
		*ppv = static_cast<ecom_control_library::IParseDisplayName*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif