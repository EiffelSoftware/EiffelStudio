/*-----------------------------------------------------------
Implemented `IBinding' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IBinding_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IBinding_ = {0x79eac9c0,0xbaf9,0x11ce,{0x8c,0x82,0x00,0xaa,0x00,0x4b,0xa9,0x0b}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IBinding_impl_stub::IBinding_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IBinding_impl_stub::~IBinding_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBinding_impl_stub::Abort( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("abort", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBinding_impl_stub::Suspend( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("suspend", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBinding_impl_stub::Resume( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("resume", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBinding_impl_stub::SetPriority(  /* [in] */ LONG n_priority )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_n_priority = (EIF_INTEGER)n_priority;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("set_priority", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_n_priority);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBinding_impl_stub::GetPriority(  /* [out] */ LONG * pn_priority )

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

STDMETHODIMP ecom_control_library::IBinding_impl_stub::RemoteGetBindResult(  /* [out] */ GUID * pclsid_protocol, /* [out] */ ULONG * pdw_result, /* [out] */ LPWSTR * psz_result, /* [in] */ ULONG dw_reserved )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pclsid_protocol = NULL;
	if (pclsid_protocol != NULL)
	{
		tmp_pclsid_protocol = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (pclsid_protocol));
	}
	EIF_OBJECT tmp_pdw_result = NULL;
	if (pdw_result != NULL)
	{
		tmp_pdw_result = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pdw_result, NULL));
	}
	EIF_OBJECT tmp_psz_result = NULL;
	if (psz_result != NULL)
	{
		tmp_psz_result = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_428 (psz_result, NULL));
	}
	EIF_INTEGER tmp_dw_reserved = (EIF_INTEGER)dw_reserved;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_get_bind_result", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pclsid_protocol != NULL) ? eif_access (tmp_pclsid_protocol) : NULL), ((tmp_pdw_result != NULL) ? eif_access (tmp_pdw_result) : NULL), ((tmp_psz_result != NULL) ? eif_access (tmp_psz_result) : NULL), (EIF_INTEGER)tmp_dw_reserved);
	
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pdw_result != NULL) ? eif_wean (tmp_pdw_result) : NULL), pdw_result);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_428 (((tmp_psz_result != NULL) ? eif_wean (tmp_psz_result) : NULL), psz_result);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IBinding_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IBinding_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IBinding_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IBinding*>(this);
	else if (riid == IID_IBinding_)
		*ppv = static_cast<ecom_control_library::IBinding*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif