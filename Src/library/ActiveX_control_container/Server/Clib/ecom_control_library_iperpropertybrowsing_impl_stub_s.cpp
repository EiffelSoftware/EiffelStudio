/*-----------------------------------------------------------
Implemented `IPerPropertyBrowsing' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPerPropertyBrowsing_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IPerPropertyBrowsing_ = {0x376bd3aa,0x3845,0x101b,{0x84,0xed,0x08,0x00,0x2b,0x2e,0xc7,0x13}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPerPropertyBrowsing_impl_stub::IPerPropertyBrowsing_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPerPropertyBrowsing_impl_stub::~IPerPropertyBrowsing_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPerPropertyBrowsing_impl_stub::GetDisplayString(  /* [in] */ LONG disp_id, /* [out] */ BSTR * p_bstr )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_disp_id = (EIF_INTEGER)disp_id;
	EIF_OBJECT tmp_p_bstr = NULL;
	if (p_bstr != NULL)
	{
		tmp_p_bstr = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_cell_252 (p_bstr, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_display_string", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_disp_id, ((tmp_p_bstr != NULL) ? eif_access (tmp_p_bstr) : NULL));
	
	if (*p_bstr != NULL)
		rt_ce.free_memory_bstr (*p_bstr);
	grt_ec_control_interfaces2.ccom_ec_pointed_cell_252 (((tmp_p_bstr != NULL) ? eif_wean (tmp_p_bstr) : NULL), p_bstr);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPerPropertyBrowsing_impl_stub::MapPropertyToPage(  /* [in] */ LONG disp_id, /* [out] */ GUID * p_clsid )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_disp_id = (EIF_INTEGER)disp_id;
	EIF_OBJECT tmp_p_clsid = NULL;
	if (p_clsid != NULL)
	{
		tmp_p_clsid = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_57 (p_clsid));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("map_property_to_page", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_disp_id, ((tmp_p_clsid != NULL) ? eif_access (tmp_p_clsid) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPerPropertyBrowsing_impl_stub::GetPredefinedStrings(  /* [in] */ LONG disp_id, /* [out] */ ecom_control_library::tagCALPOLESTR * p_ca_strings_out, /* [out] */ ecom_control_library::tagCADWORD * p_ca_cookies_out )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_disp_id = (EIF_INTEGER)disp_id;
	EIF_OBJECT tmp_p_ca_strings_out = NULL;
	if (p_ca_strings_out != NULL)
	{
		tmp_p_ca_strings_out = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_254 (p_ca_strings_out));
	}
	EIF_OBJECT tmp_p_ca_cookies_out = NULL;
	if (p_ca_cookies_out != NULL)
	{
		tmp_p_ca_cookies_out = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_256 (p_ca_cookies_out));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_predefined_strings", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_disp_id, ((tmp_p_ca_strings_out != NULL) ? eif_access (tmp_p_ca_strings_out) : NULL), ((tmp_p_ca_cookies_out != NULL) ? eif_access (tmp_p_ca_cookies_out) : NULL));
	
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPerPropertyBrowsing_impl_stub::GetPredefinedValue(  /* [in] */ LONG disp_id, /* [in] */ ULONG dw_cookie, /* [out] */ VARIANT * p_var_out )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_disp_id = (EIF_INTEGER)disp_id;
	EIF_INTEGER tmp_dw_cookie = (EIF_INTEGER)dw_cookie;
	EIF_OBJECT tmp_p_var_out = NULL;
	if (p_var_out != NULL)
	{
		tmp_p_var_out = eif_protect (grt_ce_control_interfaces2.ccom_ce_pointed_record_257 (p_var_out));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("get_predefined_value", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_disp_id, (EIF_INTEGER)tmp_dw_cookie, ((tmp_p_var_out != NULL) ? eif_access (tmp_p_var_out) : NULL));
	
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_control_library::IPerPropertyBrowsing_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_control_library::IPerPropertyBrowsing_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_control_library::IPerPropertyBrowsing_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_control_library::IPerPropertyBrowsing*>(this);
	else if (riid == IID_IPerPropertyBrowsing_)
		*ppv = static_cast<ecom_control_library::IPerPropertyBrowsing*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif