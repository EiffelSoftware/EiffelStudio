/*-----------------------------------------------------------
Implemented `IPropertyBag2' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPropertyBag2_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IPropertyBag2_ = {0x22f55882,0x280b,0x11d0,{0xa8,0xa9,0x00,0xa0,0xc9,0x0c,0x20,0x04}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPropertyBag2_impl_stub::IPropertyBag2_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPropertyBag2_impl_stub::~IPropertyBag2_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyBag2_impl_stub::Read(  /* [in] */ ULONG c_properties, /* [in] */ ecom_control_library::tagPROPBAG2 * p_prop_bag, /* [in] */ ecom_control_library::IErrorLog * p_err_log, /* [out] */ VARIANT * pvar_value, /* [out] */ HRESULT * phr_error )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_c_properties = (EIF_INTEGER)c_properties;
	EIF_OBJECT tmp_p_prop_bag = NULL;
	if (p_prop_bag != NULL)
	{
		tmp_p_prop_bag = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_273 (p_prop_bag));
	}
	EIF_OBJECT tmp_p_err_log = NULL;
	if (p_err_log != NULL)
	{
		tmp_p_err_log = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_267 (p_err_log));
		p_err_log->AddRef ();
	}
	EIF_OBJECT tmp_pvar_value = NULL;
	if (pvar_value != NULL)
	{
		tmp_pvar_value = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_274 (pvar_value));
	}
	EIF_OBJECT tmp_phr_error = NULL;
	if (phr_error != NULL)
	{
		tmp_phr_error = eif_protect (rt_ce.ccom_ce_pointed_hresult (phr_error, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("read", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_c_properties, ((tmp_p_prop_bag != NULL) ? eif_access (tmp_p_prop_bag) : NULL), ((tmp_p_err_log != NULL) ? eif_access (tmp_p_err_log) : NULL), ((tmp_pvar_value != NULL) ? eif_access (tmp_pvar_value) : NULL), ((tmp_phr_error != NULL) ? eif_access (tmp_phr_error) : NULL));
	
	rt_ec.ccom_ec_pointed_hresult (((tmp_phr_error != NULL) ? eif_wean (tmp_phr_error) : NULL), phr_error);
	if (tmp_p_prop_bag != NULL)
		eif_wean (tmp_p_prop_bag);
	if (tmp_p_err_log != NULL)
		eif_wean (tmp_p_err_log);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyBag2_impl_stub::Write(  /* [in] */ ULONG c_properties, /* [in] */ ecom_control_library::tagPROPBAG2 * p_prop_bag, /* [in] */ VARIANT * pvar_value )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_c_properties = (EIF_INTEGER)c_properties;
	EIF_OBJECT tmp_p_prop_bag = NULL;
	if (p_prop_bag != NULL)
	{
		tmp_p_prop_bag = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_273 (p_prop_bag));
	}
	EIF_OBJECT tmp_pvar_value = NULL;
	if (pvar_value != NULL)
	{
		tmp_pvar_value = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_276 (pvar_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("write", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_c_properties, ((tmp_p_prop_bag != NULL) ? eif_access (tmp_p_prop_bag) : NULL), ((tmp_pvar_value != NULL) ? eif_access (tmp_pvar_value) : NULL));
	if (tmp_p_prop_bag != NULL)
		eif_wean (tmp_p_prop_bag);
	if (tmp_pvar_value != NULL)
		eif_wean (tmp_pvar_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyBag2_impl_stub::CountProperties(  /* [out] */ ULONG * pc_properties )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pc_properties = NULL;
	if (pc_properties != NULL)
	{
		tmp_pc_properties = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pc_properties, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("count_properties", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pc_properties != NULL) ? eif_access (tmp_pc_properties) : NULL));
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pc_properties != NULL) ? eif_wean (tmp_pc_properties) : NULL), pc_properties);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyBag2_impl_stub::GetPropertyInfo(  /* [in] */ ULONG i_property, /* [in] */ ULONG c_properties, /* [out] */ ecom_control_library::tagPROPBAG2 * p_prop_bag, /* [out] */ ULONG * pc_properties )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_i_property = (EIF_INTEGER)i_property;
	EIF_INTEGER tmp_c_properties = (EIF_INTEGER)c_properties;
	EIF_OBJECT tmp_p_prop_bag = NULL;
	if (p_prop_bag != NULL)
	{
		tmp_p_prop_bag = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_273 (p_prop_bag));
	}
	EIF_OBJECT tmp_pc_properties = NULL;
	if (pc_properties != NULL)
	{
		tmp_pc_properties = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pc_properties, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_property_info", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_i_property, (EIF_INTEGER)tmp_c_properties, ((tmp_p_prop_bag != NULL) ? eif_access (tmp_p_prop_bag) : NULL), ((tmp_pc_properties != NULL) ? eif_access (tmp_pc_properties) : NULL));
	
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pc_properties != NULL) ? eif_wean (tmp_pc_properties) : NULL), pc_properties);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyBag2_impl_stub::LoadObject(  /* [in] */ LPWSTR pstr_name, /* [in] */ ULONG dw_hint, /* [in] */ IUnknown * punk_object, /* [in] */ ecom_control_library::IErrorLog * p_err_log )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pstr_name = NULL;
	if (pstr_name != NULL)
	{
		tmp_pstr_name = eif_protect (rt_ce.ccom_ce_lpwstr (pstr_name, NULL));
	}
	EIF_INTEGER tmp_dw_hint = (EIF_INTEGER)dw_hint;
	EIF_OBJECT tmp_punk_object = NULL;
	if (punk_object != NULL)
	{
		tmp_punk_object = eif_protect (rt_ce.ccom_ce_pointed_unknown (punk_object));
		punk_object->AddRef ();
	}
	EIF_OBJECT tmp_p_err_log = NULL;
	if (p_err_log != NULL)
	{
		tmp_p_err_log = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_interface_267 (p_err_log));
		p_err_log->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("load_object", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pstr_name != NULL) ? eif_access (tmp_pstr_name) : NULL), (EIF_INTEGER)tmp_dw_hint, ((tmp_punk_object != NULL) ? eif_access (tmp_punk_object) : NULL), ((tmp_p_err_log != NULL) ? eif_access (tmp_p_err_log) : NULL));
	if (tmp_pstr_name != NULL)
		eif_wean (tmp_pstr_name);
	if (tmp_punk_object != NULL)
		eif_wean (tmp_punk_object);
	if (tmp_p_err_log != NULL)
		eif_wean (tmp_p_err_log);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IPropertyBag2_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IPropertyBag2_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPropertyBag2_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IPropertyBag2*>(this);
	else if (riid == IID_IPropertyBag2_)
		*ppv = static_cast<ecom_control_library::IPropertyBag2*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif