/*-----------------------------------------------------------
Implemented `IProvideClassInfo2' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IProvideClassInfo2_impl_proxy_s.h"


#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IProvideClassInfo2_impl_proxy::IProvideClassInfo2_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IProvideClassInfo2, (void **)&p_IProvideClassInfo2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IProvideClassInfo2_impl_proxy::~IProvideClassInfo2_impl_proxy()
{
	p_unknown->Release ();
	if (p_IProvideClassInfo2!=NULL)
		p_IProvideClassInfo2->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IProvideClassInfo2_impl_proxy::ccom_get_class_info(  /* [out] */ EIF_OBJECT pp_ti )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IProvideClassInfo2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IProvideClassInfo2, (void **)&p_IProvideClassInfo2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::ITypeInfo_2 * * tmp_pp_ti = 0;
	tmp_pp_ti = (ecom_control_library::ITypeInfo_2 * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (eif_access (pp_ti), NULL);
	
	hr = p_IProvideClassInfo2->GetClassInfo(tmp_pp_ti);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_302 ((ecom_control_library::ITypeInfo_2 * *)tmp_pp_ti, pp_ti);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_302 (tmp_pp_ti);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IProvideClassInfo2_impl_proxy::ccom_get_guid(  /* [in] */ EIF_INTEGER dw_guid_kind,  /* [out] */ GUID * p_guid )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IProvideClassInfo2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IProvideClassInfo2, (void **)&p_IProvideClassInfo2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_guid_kind = 0;
	tmp_dw_guid_kind = (ULONG)dw_guid_kind;
	
	hr = p_IProvideClassInfo2->GetGUID(tmp_dw_guid_kind,p_guid);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IProvideClassInfo2_impl_proxy::ccom_item()

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