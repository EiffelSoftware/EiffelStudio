/*-----------------------------------------------------------
Implemented `IProvideMultipleClassInfo' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IProvideMultipleClassInfo_impl_proxy_s.h"
static const IID IID_IProvideMultipleClassInfo_ = {0xa7aba9c1,0x8983,0x11cf,{0x8f,0x20,0x00,0x80,0x5f,0x2c,0xd0,0x64}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IProvideMultipleClassInfo_impl_proxy::IProvideMultipleClassInfo_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IProvideMultipleClassInfo_, (void **)&p_IProvideMultipleClassInfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IProvideMultipleClassInfo_impl_proxy::~IProvideMultipleClassInfo_impl_proxy()
{
	p_unknown->Release ();
	if (p_IProvideMultipleClassInfo!=NULL)
		p_IProvideMultipleClassInfo->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IProvideMultipleClassInfo_impl_proxy::ccom_get_class_info(  /* [out] */ EIF_OBJECT pp_ti )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IProvideMultipleClassInfo == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IProvideMultipleClassInfo_, (void **)&p_IProvideMultipleClassInfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::ITypeInfo_2 * * tmp_pp_ti = 0;
	tmp_pp_ti = (ecom_control_library::ITypeInfo_2 * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (eif_access (pp_ti), NULL);
	
	hr = p_IProvideMultipleClassInfo->GetClassInfo(tmp_pp_ti);
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

void ecom_control_library::IProvideMultipleClassInfo_impl_proxy::ccom_get_guid(  /* [in] */ EIF_INTEGER dw_guid_kind,  /* [out] */ GUID * p_guid )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IProvideMultipleClassInfo == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IProvideMultipleClassInfo_, (void **)&p_IProvideMultipleClassInfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_guid_kind = 0;
	tmp_dw_guid_kind = (ULONG)dw_guid_kind;
	
	hr = p_IProvideMultipleClassInfo->GetGUID(tmp_dw_guid_kind,p_guid);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IProvideMultipleClassInfo_impl_proxy::ccom_get_multi_type_info_count(  /* [out] */ EIF_OBJECT pcti )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IProvideMultipleClassInfo == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IProvideMultipleClassInfo_, (void **)&p_IProvideMultipleClassInfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG * tmp_pcti = 0;
	tmp_pcti = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pcti), NULL);
	
	hr = p_IProvideMultipleClassInfo->GetMultiTypeInfoCount(tmp_pcti);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pcti, pcti);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_372 (tmp_pcti);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IProvideMultipleClassInfo_impl_proxy::ccom_get_info_of_index(  /* [in] */ EIF_INTEGER iti,  /* [in] */ EIF_INTEGER dw_flags,  /* [out] */ EIF_OBJECT ppti_co_class,  /* [out] */ EIF_OBJECT pdw_tiflags,  /* [out] */ EIF_OBJECT pcdispid_reserved,  /* [out] */ GUID * piid_primary,  /* [out] */ GUID * piid_source )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IProvideMultipleClassInfo == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IProvideMultipleClassInfo_, (void **)&p_IProvideMultipleClassInfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_iti = 0;
	tmp_iti = (ULONG)iti;
	ULONG tmp_dw_flags = 0;
	tmp_dw_flags = (ULONG)dw_flags;
	ecom_control_library::ITypeInfo_2 * * tmp_ppti_co_class = 0;
	tmp_ppti_co_class = (ecom_control_library::ITypeInfo_2 * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (eif_access (ppti_co_class), NULL);
	ULONG * tmp_pdw_tiflags = 0;
	tmp_pdw_tiflags = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_tiflags), NULL);
	ULONG * tmp_pcdispid_reserved = 0;
	tmp_pcdispid_reserved = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pcdispid_reserved), NULL);
	
	hr = p_IProvideMultipleClassInfo->GetInfoOfIndex(tmp_iti,tmp_dw_flags,tmp_ppti_co_class,tmp_pdw_tiflags,tmp_pcdispid_reserved,piid_primary,piid_source);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_302 ((ecom_control_library::ITypeInfo_2 * *)tmp_ppti_co_class, ppti_co_class);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_tiflags, pdw_tiflags);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pcdispid_reserved, pcdispid_reserved);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_302 (tmp_ppti_co_class);
grt_ce_control_interfaces2.ccom_free_memory_pointed_373 (tmp_pdw_tiflags);
grt_ce_control_interfaces2.ccom_free_memory_pointed_374 (tmp_pcdispid_reserved);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IProvideMultipleClassInfo_impl_proxy::ccom_item()

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