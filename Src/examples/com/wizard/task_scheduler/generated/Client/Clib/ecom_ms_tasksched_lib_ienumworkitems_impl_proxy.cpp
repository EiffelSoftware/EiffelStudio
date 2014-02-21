/*-----------------------------------------------------------
Implemented `IEnumWorkItems' interface.
-----------------------------------------------------------*/

#include "ecom_grt_globals_mstask_modified_idl_c.h"
#include "ecom_MS_TaskSched_lib_IEnumWorkItems_impl_proxy.h"
static const IID IID_IEnumWorkItems_ = {0x148bd528,0xa2ab,0x11ce,{0xb1,0x1f,0x00,0xaa,0x00,0x53,0x05,0x03}};

ecom_MS_TaskSched_lib::IEnumWorkItems_impl_proxy::IEnumWorkItems_impl_proxy( IUnknown * a_pointer )
{
	HRESULT hr, hr2;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	rt.ccom_check_hresult (hr);
	hr = a_pointer->QueryInterface(IID_IUnknown, (void **)&p_unknown);
	rt.ccom_check_hresult (hr);

	hr = a_pointer->QueryInterface(IID_IEnumWorkItems_, (void **)&p_IEnumWorkItems);
	rt.ccom_check_hresult (hr);

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_MS_TaskSched_lib::IEnumWorkItems_impl_proxy::~IEnumWorkItems_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEnumWorkItems != NULL)
		p_IEnumWorkItems->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IEnumWorkItems_impl_proxy::ccom_next(  /* [in] */ EIF_INTEGER celt,  /* [out] */ EIF_OBJECT rgpwsz_names,  /* [out] */ EIF_OBJECT pcelt_fetched )

/*-----------------------------------------------------------
	Retrieves the next set of tasks in the enumeration sequence.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumWorkItems == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumWorkItems_, (void **)&p_IEnumWorkItems);
		rt.ccom_check_hresult (hr);
	};
	ULONG tmp_celt = 0;
	tmp_celt = (ULONG)celt;
	LPWSTR * * tmp_rgpwsz_names = 0;
	tmp_rgpwsz_names = (LPWSTR * *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_63 (eif_access (rgpwsz_names), NULL);
	ULONG * tmp_pcelt_fetched = 0;
	tmp_pcelt_fetched = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pcelt_fetched), NULL);
	
	EIF_ENTER_C;
	hr = p_IEnumWorkItems->Next(tmp_celt,tmp_rgpwsz_names,tmp_pcelt_fetched);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_63 ((LPWSTR * *)tmp_rgpwsz_names, rgpwsz_names);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pcelt_fetched, pcelt_fetched);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_63 (tmp_rgpwsz_names);
grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_64 (tmp_pcelt_fetched);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IEnumWorkItems_impl_proxy::ccom_skip(  /* [in] */ EIF_INTEGER celt )

/*-----------------------------------------------------------
	Skips the next set of tasks in the enumeration sequence.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumWorkItems == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumWorkItems_, (void **)&p_IEnumWorkItems);
		rt.ccom_check_hresult (hr);
	};
	ULONG tmp_celt = 0;
	tmp_celt = (ULONG)celt;
	
	EIF_ENTER_C;
	hr = p_IEnumWorkItems->Skip(tmp_celt);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IEnumWorkItems_impl_proxy::ccom_reset()

/*-----------------------------------------------------------
	Resets the enumeration sequence to the beginning. 
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumWorkItems == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumWorkItems_, (void **)&p_IEnumWorkItems);
		rt.ccom_check_hresult (hr);
	};
	EIF_ENTER_C;
	hr = p_IEnumWorkItems->Reset ();
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_MS_TaskSched_lib::IEnumWorkItems_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT pp_enum_work_items )

/*-----------------------------------------------------------
	Creates a new enumeration object in the same state as the current enumeration object: the new object points to the same place in the enumeration sequence.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumWorkItems == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumWorkItems_, (void **)&p_IEnumWorkItems);
		rt.ccom_check_hresult (hr);
	};
	ecom_MS_TaskSched_lib::IEnumWorkItems * * tmp_pp_enum_work_items = 0;
	tmp_pp_enum_work_items = (ecom_MS_TaskSched_lib::IEnumWorkItems * *)grt_ec_mstask_modified_idl_c.ccom_ec_pointed_cell_57 (eif_access (pp_enum_work_items), NULL);
	
	EIF_ENTER_C;
	hr = p_IEnumWorkItems->Clone(tmp_pp_enum_work_items);
	EIF_EXIT_C;
	rt.ccom_check_hresult (hr);
	grt_ce_mstask_modified_idl_c.ccom_ce_pointed_cell_57 ((ecom_MS_TaskSched_lib::IEnumWorkItems * *)tmp_pp_enum_work_items, pp_enum_work_items);
	
	grt_ce_mstask_modified_idl_c.ccom_free_memory_pointed_57 (tmp_pp_enum_work_items);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_MS_TaskSched_lib::IEnumWorkItems_impl_proxy::ccom_item()

/*-----------------------------------------------------------
	IUnknown interface
-----------------------------------------------------------*/
{
	return (EIF_POINTER)p_unknown;
};
/*----------------------------------------------------------------------------------------------------------------------*/


