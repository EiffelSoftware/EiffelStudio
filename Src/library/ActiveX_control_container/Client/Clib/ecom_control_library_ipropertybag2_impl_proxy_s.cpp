/*-----------------------------------------------------------
Implemented `IPropertyBag2' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IPropertyBag2_impl_proxy_s.h"
static const IID IID_IPropertyBag2_ = {0x22f55882,0x280b,0x11d0,{0xa8,0xa9,0x00,0xa0,0xc9,0x0c,0x20,0x04}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IPropertyBag2_impl_proxy::IPropertyBag2_impl_proxy( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

	hr = a_pointer->QueryInterface(IID_IPropertyBag2_, (void **)&p_IPropertyBag2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IPropertyBag2_impl_proxy::~IPropertyBag2_impl_proxy()
{
	p_unknown->Release ();
	if (p_IPropertyBag2!=NULL)
		p_IPropertyBag2->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPropertyBag2_impl_proxy::ccom_read(  /* [in] */ EIF_INTEGER c_properties,  /* [in] */ ecom_control_library::tagPROPBAG2 * p_prop_bag,  /* [in] */ ecom_control_library::IErrorLog * p_err_log,  /* [out] */ VARIANT * pvar_value,  /* [out] */ EIF_OBJECT phr_error )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPropertyBag2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPropertyBag2_, (void **)&p_IPropertyBag2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_c_properties = 0;
	tmp_c_properties = (ULONG)c_properties;
	HRESULT * tmp_phr_error = 0;
	tmp_phr_error = (HRESULT *)rt_ec.ccom_ec_pointed_hresult (eif_access (phr_error), NULL);
	
	hr = p_IPropertyBag2->Read(tmp_c_properties,p_prop_bag,p_err_log,pvar_value,tmp_phr_error);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_hresult ((HRESULT *)tmp_phr_error, phr_error);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_275 (tmp_phr_error);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPropertyBag2_impl_proxy::ccom_write(  /* [in] */ EIF_INTEGER c_properties,  /* [in] */ ecom_control_library::tagPROPBAG2 * p_prop_bag,  /* [in] */ VARIANT * pvar_value )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPropertyBag2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPropertyBag2_, (void **)&p_IPropertyBag2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_c_properties = 0;
	tmp_c_properties = (ULONG)c_properties;
	
	hr = p_IPropertyBag2->Write(tmp_c_properties,p_prop_bag,pvar_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPropertyBag2_impl_proxy::ccom_count_properties(  /* [out] */ EIF_OBJECT pc_properties )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPropertyBag2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPropertyBag2_, (void **)&p_IPropertyBag2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG * tmp_pc_properties = 0;
	tmp_pc_properties = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pc_properties), NULL);
	
	hr = p_IPropertyBag2->CountProperties(tmp_pc_properties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pc_properties, pc_properties);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_277 (tmp_pc_properties);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPropertyBag2_impl_proxy::ccom_get_property_info(  /* [in] */ EIF_INTEGER i_property,  /* [in] */ EIF_INTEGER c_properties,  /* [out] */ ecom_control_library::tagPROPBAG2 * p_prop_bag,  /* [out] */ EIF_OBJECT pc_properties )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPropertyBag2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPropertyBag2_, (void **)&p_IPropertyBag2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_i_property = 0;
	tmp_i_property = (ULONG)i_property;
	ULONG tmp_c_properties = 0;
	tmp_c_properties = (ULONG)c_properties;
	ULONG * tmp_pc_properties = 0;
	tmp_pc_properties = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pc_properties), NULL);
	
	hr = p_IPropertyBag2->GetPropertyInfo(tmp_i_property,tmp_c_properties,p_prop_bag,tmp_pc_properties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pc_properties, pc_properties);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_278 (tmp_pc_properties);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IPropertyBag2_impl_proxy::ccom_load_object(  /* [in] */ EIF_OBJECT pstr_name,  /* [in] */ EIF_INTEGER dw_hint,  /* [in] */ IUnknown * punk_object,  /* [in] */ ecom_control_library::IErrorLog * p_err_log )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IPropertyBag2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IPropertyBag2_, (void **)&p_IPropertyBag2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_pstr_name = 0;
	tmp_pstr_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (pstr_name), NULL);
	ULONG tmp_dw_hint = 0;
	tmp_dw_hint = (ULONG)dw_hint;
	
	hr = p_IPropertyBag2->LoadObject(tmp_pstr_name,tmp_dw_hint,punk_object,p_err_log);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IPropertyBag2_impl_proxy::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif