/*-----------------------------------------------------------
Implemented `IErrorLog' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IErrorLog_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IErrorLog_ = {0x3127ca40,0x446e,0x11ce,{0x81,0x35,0x00,0xaa,0x00,0x4b,0xb8,0x51}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IErrorLog_impl_stub::IErrorLog_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IErrorLog_impl_stub::~IErrorLog_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IErrorLog_impl_stub::AddError(  /* [in] */ LPWSTR psz_prop_name, /* [in] */ EXCEPINFO * p_excep_info )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_psz_prop_name = NULL;
	if (psz_prop_name != NULL)
	{
		tmp_psz_prop_name = eif_protect (rt_ce.ccom_ce_lpwstr (psz_prop_name, NULL));
	}
	EIF_OBJECT tmp_p_excep_info = NULL;
	if (p_excep_info != NULL)
	{
		tmp_p_excep_info = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_182 (p_excep_info));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_error", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_psz_prop_name != NULL) ? eif_access (tmp_psz_prop_name) : NULL), ((tmp_p_excep_info != NULL) ? eif_access (tmp_p_excep_info) : NULL));
	if (tmp_psz_prop_name != NULL)
		eif_wean (tmp_psz_prop_name);
	if (tmp_p_excep_info != NULL)
		eif_wean (tmp_p_excep_info);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IErrorLog_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IErrorLog_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IErrorLog_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IErrorLog*>(this);
	else if (riid == IID_IErrorLog_)
		*ppv = static_cast<ecom_control_library::IErrorLog*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif