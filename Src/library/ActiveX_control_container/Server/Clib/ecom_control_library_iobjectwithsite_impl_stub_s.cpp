/*-----------------------------------------------------------
Implemented `IObjectWithSite' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IObjectWithSite_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IObjectWithSite_ = {0xfc4801a3,0x2ba9,0x11cf,{0xa2,0x29,0x00,0xaa,0x00,0x3d,0x73,0x52}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IObjectWithSite_impl_stub::IObjectWithSite_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IObjectWithSite_impl_stub::~IObjectWithSite_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IObjectWithSite_impl_stub::SetSite(  /* [in] */ IUnknown * p_unk_site )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_unk_site = NULL;
	if (p_unk_site != NULL)
	{
		tmp_p_unk_site = eif_protect (rt_ce.ccom_ce_pointed_unknown (p_unk_site));
		p_unk_site->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_site", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_unk_site != NULL) ? eif_access (tmp_p_unk_site) : NULL));
	if (tmp_p_unk_site != NULL)
		eif_wean (tmp_p_unk_site);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IObjectWithSite_impl_stub::GetSite(  /* [in] */ GUID * riid, /* [out] */ void * * ppv_site )

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
	EIF_OBJECT tmp_ppv_site = NULL;
	if (ppv_site != NULL)
	{
		tmp_ppv_site = eif_protect (rt_ce.ccom_ce_pointed_pointer ((void **)ppv_site, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_site", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_riid != NULL) ? eif_access (tmp_riid) : NULL), ((tmp_ppv_site != NULL) ? eif_access (tmp_ppv_site) : NULL));
	
	if (tmp_riid != NULL)
		eif_wean (tmp_riid);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IObjectWithSite_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IObjectWithSite_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IObjectWithSite_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IObjectWithSite*>(this);
	else if (riid == IID_IObjectWithSite_)
		*ppv = static_cast<ecom_control_library::IObjectWithSite*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif