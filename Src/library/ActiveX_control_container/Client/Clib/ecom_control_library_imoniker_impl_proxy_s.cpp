/*-----------------------------------------------------------
Implemented `IMoniker' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_IMoniker_impl_proxy_s.h"
static const IID IID_IMoniker_ = {0x0000000f,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::IMoniker_impl_proxy::IMoniker_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::IMoniker_impl_proxy::~IMoniker_impl_proxy()
{
	p_unknown->Release ();
	if (p_IMoniker!=NULL)
		p_IMoniker->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_get_class_id(  /* [out] */ GUID * p_class_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IMoniker->IPersist_GetClassID(p_class_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_is_dirty()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IMoniker->IsDirty ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_load(  /* [in] */ ecom_control_library::IStream * pstm )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IMoniker->Load(pstm);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_save(  /* [in] */ ecom_control_library::IStream * pstm,  /* [in] */ EIF_INTEGER f_clear_dirty )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_f_clear_dirty = 0;
	tmp_f_clear_dirty = (LONG)f_clear_dirty;
	
	hr = p_IMoniker->Save(pstm,tmp_f_clear_dirty);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_get_size_max(  /* [out] */ ecom_control_library::_ULARGE_INTEGER * pcb_size )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IMoniker->GetSizeMax(pcb_size);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_remote_bind_to_object(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ ecom_control_library::IMoniker * pmk_to_left,  /* [in] */ GUID * riid_result,  /* [out] */ EIF_OBJECT ppv_result )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	IUnknown * * tmp_ppv_result = 0;
	tmp_ppv_result = (IUnknown * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_58 (eif_access (ppv_result), NULL);
	
	hr = p_IMoniker->RemoteBindToObject(pbc,pmk_to_left,riid_result,tmp_ppv_result);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_58 ((IUnknown * *)tmp_ppv_result, ppv_result);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_58 (tmp_ppv_result);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_remote_bind_to_storage(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ ecom_control_library::IMoniker * pmk_to_left,  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_obj )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	IUnknown * * tmp_ppv_obj = 0;
	tmp_ppv_obj = (IUnknown * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_59 (eif_access (ppv_obj), NULL);
	
	hr = p_IMoniker->RemoteBindToStorage(pbc,pmk_to_left,riid,tmp_ppv_obj);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_59 ((IUnknown * *)tmp_ppv_obj, ppv_obj);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_59 (tmp_ppv_obj);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_reduce(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ EIF_INTEGER dw_reduce_how_far,  /* [in, out] */ EIF_OBJECT ppmk_to_left,  /* [out] */ EIF_OBJECT ppmk_reduced )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_dw_reduce_how_far = 0;
	tmp_dw_reduce_how_far = (ULONG)dw_reduce_how_far;
	ecom_control_library::IMoniker * * tmp_ppmk_to_left = 0;
	tmp_ppmk_to_left = (ecom_control_library::IMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (eif_access (ppmk_to_left), NULL);
	ecom_control_library::IMoniker * * tmp_ppmk_reduced = 0;
	tmp_ppmk_reduced = (ecom_control_library::IMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (eif_access (ppmk_reduced), NULL);
	
	hr = p_IMoniker->Reduce(pbc,tmp_dw_reduce_how_far,tmp_ppmk_to_left,tmp_ppmk_reduced);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 ((ecom_control_library::IMoniker * *)tmp_ppmk_to_left, ppmk_to_left);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 ((ecom_control_library::IMoniker * *)tmp_ppmk_reduced, ppmk_reduced);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_60 (tmp_ppmk_to_left);
grt_ce_control_interfaces2.ccom_free_memory_pointed_60 (tmp_ppmk_reduced);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_compose_with(  /* [in] */ ecom_control_library::IMoniker * pmk_right,  /* [in] */ EIF_INTEGER f_only_if_not_generic,  /* [out] */ EIF_OBJECT ppmk_composite )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_f_only_if_not_generic = 0;
	tmp_f_only_if_not_generic = (LONG)f_only_if_not_generic;
	ecom_control_library::IMoniker * * tmp_ppmk_composite = 0;
	tmp_ppmk_composite = (ecom_control_library::IMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (eif_access (ppmk_composite), NULL);
	
	hr = p_IMoniker->ComposeWith(pmk_right,tmp_f_only_if_not_generic,tmp_ppmk_composite);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 ((ecom_control_library::IMoniker * *)tmp_ppmk_composite, ppmk_composite);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_60 (tmp_ppmk_composite);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_enum(  /* [in] */ EIF_INTEGER f_forward,  /* [out] */ EIF_OBJECT ppenum_moniker )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_f_forward = 0;
	tmp_f_forward = (LONG)f_forward;
	ecom_control_library::IEnumMoniker * * tmp_ppenum_moniker = 0;
	tmp_ppenum_moniker = (ecom_control_library::IEnumMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_63 (eif_access (ppenum_moniker), NULL);
	
	hr = p_IMoniker->Enum(tmp_f_forward,tmp_ppenum_moniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_63 ((ecom_control_library::IEnumMoniker * *)tmp_ppenum_moniker, ppenum_moniker);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_63 (tmp_ppenum_moniker);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_is_equal1(  /* [in] */ ecom_control_library::IMoniker * pmk_other_moniker )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IMoniker->IsEqual(pmk_other_moniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_hash(  /* [out] */ EIF_OBJECT pdw_hash )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG * tmp_pdw_hash = 0;
	tmp_pdw_hash = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_hash), NULL);
	
	hr = p_IMoniker->Hash(tmp_pdw_hash);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_hash, pdw_hash);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_64 (tmp_pdw_hash);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_is_running(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ ecom_control_library::IMoniker * pmk_to_left,  /* [in] */ ecom_control_library::IMoniker * pmk_newly_running )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IMoniker->IsRunning(pbc,pmk_to_left,pmk_newly_running);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_get_time_of_last_change(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ ecom_control_library::IMoniker * pmk_to_left,  /* [out] */ ecom_control_library::_FILETIME * pfiletime )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IMoniker->GetTimeOfLastChange(pbc,pmk_to_left,pfiletime);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_inverse(  /* [out] */ EIF_OBJECT ppmk )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::IMoniker * * tmp_ppmk = 0;
	tmp_ppmk = (ecom_control_library::IMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (eif_access (ppmk), NULL);
	
	hr = p_IMoniker->Inverse(tmp_ppmk);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 ((ecom_control_library::IMoniker * *)tmp_ppmk, ppmk);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_60 (tmp_ppmk);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_common_prefix_with(  /* [in] */ ecom_control_library::IMoniker * pmk_other,  /* [out] */ EIF_OBJECT ppmk_prefix )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::IMoniker * * tmp_ppmk_prefix = 0;
	tmp_ppmk_prefix = (ecom_control_library::IMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (eif_access (ppmk_prefix), NULL);
	
	hr = p_IMoniker->CommonPrefixWith(pmk_other,tmp_ppmk_prefix);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 ((ecom_control_library::IMoniker * *)tmp_ppmk_prefix, ppmk_prefix);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_60 (tmp_ppmk_prefix);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_relative_path_to(  /* [in] */ ecom_control_library::IMoniker * pmk_other,  /* [out] */ EIF_OBJECT ppmk_rel_path )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::IMoniker * * tmp_ppmk_rel_path = 0;
	tmp_ppmk_rel_path = (ecom_control_library::IMoniker * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_60 (eif_access (ppmk_rel_path), NULL);
	
	hr = p_IMoniker->RelativePathTo(pmk_other,tmp_ppmk_rel_path);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 ((ecom_control_library::IMoniker * *)tmp_ppmk_rel_path, ppmk_rel_path);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_60 (tmp_ppmk_rel_path);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_get_display_name(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ ecom_control_library::IMoniker * pmk_to_left,  /* [out] */ EIF_OBJECT ppsz_display_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR * tmp_ppsz_display_name = 0;
	tmp_ppsz_display_name = (LPWSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_67 (eif_access (ppsz_display_name), NULL);
	
	hr = p_IMoniker->GetDisplayName(pbc,pmk_to_left,tmp_ppsz_display_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_67 ((LPWSTR *)tmp_ppsz_display_name, ppsz_display_name);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_67 (tmp_ppsz_display_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_parse_display_name(  /* [in] */ ecom_control_library::IBindCtx * pbc,  /* [in] */ ecom_control_library::IMoniker * pmk_to_left,  /* [in] */ EIF_OBJECT psz_display_name,  /* [out] */ EIF_OBJECT pch_eaten,  /* [out] */ EIF_OBJECT ppmk_out )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
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
	
	hr = p_IMoniker->ParseDisplayName(pbc,pmk_to_left,tmp_psz_display_name,tmp_pch_eaten,tmp_ppmk_out);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pch_eaten, pch_eaten);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_60 ((ecom_control_library::IMoniker * *)tmp_ppmk_out, ppmk_out);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_68 (tmp_pch_eaten);
grt_ce_control_interfaces2.ccom_free_memory_pointed_60 (tmp_ppmk_out);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::IMoniker_impl_proxy::ccom_is_system_moniker(  /* [out] */ EIF_OBJECT pdw_mksys )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IMoniker == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IMoniker_, (void **)&p_IMoniker);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG * tmp_pdw_mksys = 0;
	tmp_pdw_mksys = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_mksys), NULL);
	
	hr = p_IMoniker->IsSystemMoniker(tmp_pdw_mksys);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_mksys, pdw_mksys);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_69 (tmp_pdw_mksys);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::IMoniker_impl_proxy::ccom_item()

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