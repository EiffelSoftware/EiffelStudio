/*-----------------------------------------------------------
Implemented `IPropertyPageSite' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPropertyPageSite_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IPropertyPageSite_ = {0xb196b28c,0xbab4,0x101a,{0xb6,0x9c,0x00,0xaa,0x00,0x34,0x1d,0x07}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPropertyPageSite_impl_stub::IPropertyPageSite_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPropertyPageSite_impl_stub::~IPropertyPageSite_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPageSite_impl_stub::OnStatusChange(  /* [in] */ ULONG dw_flags )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_dw_flags = (EIF_INTEGER)dw_flags;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("on_status_change", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_dw_flags);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPageSite_impl_stub::GetLocaleID(  /* [out] */ ULONG * p_locale_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_locale_id = NULL;
	if (p_locale_id != NULL)
	{
		tmp_p_locale_id = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (p_locale_id, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_locale_id", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_locale_id != NULL) ? eif_access (tmp_p_locale_id) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_p_locale_id != NULL) ? eif_wean (tmp_p_locale_id) : NULL), p_locale_id);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPageSite_impl_stub::GetPageContainer(  /* [out] */ IUnknown * * ppunk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_ppunk = NULL;
	if (ppunk != NULL)
	{
		tmp_ppunk = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_299 (ppunk, NULL));
		if (*ppunk != NULL)
			(*ppunk)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_page_container", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_ppunk != NULL) ? eif_access (tmp_ppunk) : NULL));
	
	if (*ppunk != NULL)
		(*ppunk)->Release ();
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_299 (((tmp_ppunk != NULL) ? eif_wean (tmp_ppunk) : NULL), ppunk);
	if (*ppunk != NULL)
		(*ppunk)->AddRef ();
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPageSite_impl_stub::TranslateAccelerator(  /* [in] */ ecom_control_library::tagMSG * p_msg )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_msg = NULL;
	if (p_msg != NULL)
	{
		tmp_p_msg = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_198 (p_msg));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("translate_accelerator", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_msg != NULL) ? eif_access (tmp_p_msg) : NULL));
	if (tmp_p_msg != NULL)
		eif_wean (tmp_p_msg);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IPropertyPageSite_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IPropertyPageSite_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyPageSite_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IPropertyPageSite*>(this);
	else if (riid == IID_IPropertyPageSite_)
		*ppv = static_cast<ecom_control_library::IPropertyPageSite*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif