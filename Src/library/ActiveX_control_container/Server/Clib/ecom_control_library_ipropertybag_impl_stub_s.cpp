/*-----------------------------------------------------------
Implemented `IPropertyBag' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPropertyBag_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IPropertyBag_ = {0x55272a00,0x42cb,0x11ce,{0x81,0x35,0x00,0xaa,0x00,0x4b,0xb8,0x51}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPropertyBag_impl_stub::IPropertyBag_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPropertyBag_impl_stub::~IPropertyBag_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyBag_impl_stub::RemoteRead(  /* [in] */ LPWSTR psz_prop_name, /* [out] */ VARIANT * p_var, /* [in] */ ecom_control_library::IErrorLog * p_error_log, /* [in] */ ULONG var_type, /* [in] */ IUnknown * p_unk_obj )

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
	EIF_OBJECT tmp_p_var = NULL;
	if (p_var != NULL)
	{
		tmp_p_var = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_268 (p_var));
	}
	EIF_OBJECT tmp_p_error_log = NULL;
	if (p_error_log != NULL)
	{
		tmp_p_error_log = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_267 (p_error_log));
		p_error_log->AddRef ();
	}
	EIF_INTEGER tmp_var_type = (EIF_INTEGER)var_type;
	EIF_OBJECT tmp_p_unk_obj = NULL;
	if (p_unk_obj != NULL)
	{
		tmp_p_unk_obj = eif_protect (rt_ce.ccom_ce_pointed_unknown (p_unk_obj));
		p_unk_obj->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remote_read", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_psz_prop_name != NULL) ? eif_access (tmp_psz_prop_name) : NULL), ((tmp_p_var != NULL) ? eif_access (tmp_p_var) : NULL), ((tmp_p_error_log != NULL) ? eif_access (tmp_p_error_log) : NULL), (EIF_INTEGER)tmp_var_type, ((tmp_p_unk_obj != NULL) ? eif_access (tmp_p_unk_obj) : NULL));
	
	if (tmp_psz_prop_name != NULL)
		eif_wean (tmp_psz_prop_name);
	if (tmp_p_error_log != NULL)
		eif_wean (tmp_p_error_log);
	if (tmp_p_unk_obj != NULL)
		eif_wean (tmp_p_unk_obj);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyBag_impl_stub::Write(  /* [in] */ LPWSTR psz_prop_name, /* [in] */ VARIANT * p_var )

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
	EIF_OBJECT tmp_p_var = NULL;
	if (p_var != NULL)
	{
		tmp_p_var = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_269 (p_var));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("write", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_psz_prop_name != NULL) ? eif_access (tmp_psz_prop_name) : NULL), ((tmp_p_var != NULL) ? eif_access (tmp_p_var) : NULL));
	if (tmp_psz_prop_name != NULL)
		eif_wean (tmp_psz_prop_name);
	if (tmp_p_var != NULL)
		eif_wean (tmp_p_var);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IPropertyBag_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IPropertyBag_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyBag_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IPropertyBag*>(this);
	else if (riid == IID_IPropertyBag_)
		*ppv = static_cast<ecom_control_library::IPropertyBag*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif