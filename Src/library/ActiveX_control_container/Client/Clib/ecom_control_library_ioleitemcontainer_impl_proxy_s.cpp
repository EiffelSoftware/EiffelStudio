/*-----------------------------------------------------------
Implemented `IOleItemContainer' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IOleItemContainer_impl_proxy_s.h"
static const IID IID_IOleItemContainer_ = {0x0000011c,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IOleItemContainer_impl_proxy::IOleItemContainer_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IOleItemContainer_, (void **)&p_IOleItemContainer);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IOleItemContainer_impl_proxy::~IOleItemContainer_impl_proxy()
{
	p_unknown->Release ();
	if (p_IOleItemContainer!=NULL)
		p_IOleItemContainer->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleItemContainer_impl_proxy::ccom_parse_display_name(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ EIF_OBJECT psz_display_name,  /* [out] */ EIF_OBJECT pch_eaten,  /* [out] */ EIF_OBJECT ppmk_out )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleItemContainer == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleItemContainer_, (void **)&p_IOleItemContainer);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_psz_display_name = 0;
	tmp_psz_display_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_display_name), NULL);
	ULONG * tmp_pch_eaten = 0;
	tmp_pch_eaten = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pch_eaten), NULL);
	ecom_control_library::IMoniker * * tmp_ppmk_out = 0;
	tmp_ppmk_out = (ecom_control_library::IMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (eif_access (ppmk_out), NULL);
	
	hr = p_IOleItemContainer->ParseDisplayName(pbc,tmp_psz_display_name,tmp_pch_eaten,tmp_ppmk_out);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pch_eaten, pch_eaten);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 ((ecom_control_library::IMoniker * *)tmp_ppmk_out, ppmk_out);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_192 (tmp_pch_eaten);
grt_ce_control_interfaces2.ccom_free_memory_pointed_60 (tmp_ppmk_out);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleItemContainer_impl_proxy::ccom_enum_objects(  /* [in] */ EIF_INTEGER grf_flags,  /* [out] */ EIF_OBJECT ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleItemContainer == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleItemContainer_, (void **)&p_IOleItemContainer);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_grf_flags = 0;
	tmp_grf_flags = (ULONG)grf_flags;
	ecom_control_library::IEnumUnknown * * tmp_ppenum = 0;
	tmp_ppenum = (ecom_control_library::IEnumUnknown * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_191 (eif_access (ppenum), NULL);
	
	hr = p_IOleItemContainer->EnumObjects(tmp_grf_flags,tmp_ppenum);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_191 ((ecom_control_library::IEnumUnknown * *)tmp_ppenum, ppenum);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_191 (tmp_ppenum);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleItemContainer_impl_proxy::ccom_lock_container(  /* [in] */ EIF_INTEGER f_lock )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleItemContainer == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleItemContainer_, (void **)&p_IOleItemContainer);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_f_lock = 0;
	tmp_f_lock = (LONG)f_lock;
	
	hr = p_IOleItemContainer->LockContainer(tmp_f_lock);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleItemContainer_impl_proxy::ccom_get_object(  /* [in] */ EIF_OBJECT psz_item,  /* [in] */ EIF_INTEGER dw_speed_needed,  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_object )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleItemContainer == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleItemContainer_, (void **)&p_IOleItemContainer);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_psz_item = 0;
	tmp_psz_item = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_item), NULL);
	ULONG tmp_dw_speed_needed = 0;
	tmp_dw_speed_needed = (ULONG)dw_speed_needed;
	void * * tmp_ppv_object = 0;
	tmp_ppv_object = (void * *)rt_ec.ccom_ec_pointed_pointer (eif_access (ppv_object), NULL);
	
	hr = p_IOleItemContainer->GetObject(tmp_psz_item,tmp_dw_speed_needed,pbc,riid,tmp_ppv_object);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_pointer ((void **)tmp_ppv_object, ppv_object);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_237 (tmp_ppv_object);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleItemContainer_impl_proxy::ccom_get_object_storage(  /* [in] */ EIF_OBJECT psz_item,  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_storage )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleItemContainer == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleItemContainer_, (void **)&p_IOleItemContainer);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_psz_item = 0;
	tmp_psz_item = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_item), NULL);
	void * * tmp_ppv_storage = 0;
	tmp_ppv_storage = (void * *)rt_ec.ccom_ec_pointed_pointer (eif_access (ppv_storage), NULL);
	
	hr = p_IOleItemContainer->GetObjectStorage(tmp_psz_item,pbc,riid,tmp_ppv_storage);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_pointer ((void **)tmp_ppv_storage, ppv_storage);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_239 (tmp_ppv_storage);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IOleItemContainer_impl_proxy::ccom_is_running(  /* [in] */ EIF_OBJECT psz_item )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IOleItemContainer == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IOleItemContainer_, (void **)&p_IOleItemContainer);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_psz_item = 0;
	tmp_psz_item = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (psz_item), NULL);
	
	hr = p_IOleItemContainer->IsRunning(tmp_psz_item);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IOleItemContainer_impl_proxy::ccom_item()

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