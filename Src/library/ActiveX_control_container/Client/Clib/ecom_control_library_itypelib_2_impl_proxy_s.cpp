/*-----------------------------------------------------------
Implemented `ITypeLib_2' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_ITypeLib_2_impl_proxy_s.h"
static const IID IID_ITypeLib_2_ = {0x00020402,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::ITypeLib_2_impl_proxy::ITypeLib_2_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_ITypeLib_2_, (void **)&p_ITypeLib_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ITypeLib_2_impl_proxy::~ITypeLib_2_impl_proxy()
{
	p_unknown->Release ();
	if (p_ITypeLib_2!=NULL)
		p_ITypeLib_2->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeLib_2_impl_proxy::ccom_remote_get_type_info_count(  /* [out] */ EIF_OBJECT pc_tinfo )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeLib_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeLib_2_, (void **)&p_ITypeLib_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	UINT * tmp_pc_tinfo = 0;
	tmp_pc_tinfo = (UINT *)rt_ec.ccom_ec_pointed_unsigned_integer (eif_access (pc_tinfo), NULL);
	
	hr = p_ITypeLib_2->RemoteGetTypeInfoCount(tmp_pc_tinfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_integer ((UINT *)tmp_pc_tinfo, pc_tinfo);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_357 (tmp_pc_tinfo);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeLib_2_impl_proxy::ccom_get_type_info(  /* [in] */ EIF_INTEGER a_index,  /* [out] */ EIF_OBJECT pp_tinfo )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeLib_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeLib_2_, (void **)&p_ITypeLib_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	UINT tmp_a_index = 0;
	tmp_a_index = (UINT)a_index;
	ecom_control_library::ITypeInfo_2 * * tmp_pp_tinfo = 0;
	tmp_pp_tinfo = (ecom_control_library::ITypeInfo_2 * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (eif_access (pp_tinfo), NULL);
	
	hr = p_ITypeLib_2->a_GetTypeInfo(tmp_a_index,tmp_pp_tinfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_302 ((ecom_control_library::ITypeInfo_2 * *)tmp_pp_tinfo, pp_tinfo);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_302 (tmp_pp_tinfo);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeLib_2_impl_proxy::ccom_get_type_info_type(  /* [in] */ EIF_INTEGER a_index,  /* [out] */ EIF_OBJECT p_tkind )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeLib_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeLib_2_, (void **)&p_ITypeLib_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	UINT tmp_a_index = 0;
	tmp_a_index = (UINT)a_index;
	long * tmp_p_tkind = 0;
	tmp_p_tkind = (long *)rt_ec.ccom_ec_pointed_long (eif_access (p_tkind), NULL);
	
	hr = p_ITypeLib_2->GetTypeInfoType(tmp_a_index,tmp_p_tkind);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_long ((long *)tmp_p_tkind, p_tkind);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_358 (tmp_p_tkind);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeLib_2_impl_proxy::ccom_get_type_info_of_guid(  /* [in] */ GUID * guid,  /* [out] */ EIF_OBJECT pp_tinfo )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeLib_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeLib_2_, (void **)&p_ITypeLib_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::ITypeInfo_2 * * tmp_pp_tinfo = 0;
	tmp_pp_tinfo = (ecom_control_library::ITypeInfo_2 * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (eif_access (pp_tinfo), NULL);
	
	hr = p_ITypeLib_2->GetTypeInfoOfGuid(guid,tmp_pp_tinfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_302 ((ecom_control_library::ITypeInfo_2 * *)tmp_pp_tinfo, pp_tinfo);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_302 (tmp_pp_tinfo);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeLib_2_impl_proxy::ccom_remote_get_lib_attr(  /* [out] */ EIF_OBJECT pp_tlib_attr,  /* [out] */ EIF_OBJECT p_dummy )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeLib_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeLib_2_, (void **)&p_ITypeLib_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::tagTLIBATTR * * tmp_pp_tlib_attr = 0;
	tmp_pp_tlib_attr = (ecom_control_library::tagTLIBATTR * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_361 (eif_access (pp_tlib_attr), NULL);
	ecom_control_library::DWORD1 * tmp_p_dummy = 0;
	tmp_p_dummy = (ecom_control_library::DWORD1 *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (p_dummy), NULL);
	
	hr = p_ITypeLib_2->RemoteGetLibAttr(tmp_pp_tlib_attr,tmp_p_dummy);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_361 ((ecom_control_library::tagTLIBATTR * *)tmp_pp_tlib_attr, pp_tlib_attr);
	rt_ce.ccom_ce_pointed_unsigned_long ((ecom_control_library::DWORD1 *)tmp_p_dummy, p_dummy);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_361 (tmp_pp_tlib_attr);
grt_ce_control_interfaces2.ccom_free_memory_pointed_307 (tmp_p_dummy);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeLib_2_impl_proxy::ccom_get_type_comp(  /* [out] */ EIF_OBJECT pp_tcomp )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeLib_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeLib_2_, (void **)&p_ITypeLib_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::ITypeComp * * tmp_pp_tcomp = 0;
	tmp_pp_tcomp = (ecom_control_library::ITypeComp * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_310 (eif_access (pp_tcomp), NULL);
	
	hr = p_ITypeLib_2->GetTypeComp(tmp_pp_tcomp);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_310 ((ecom_control_library::ITypeComp * *)tmp_pp_tcomp, pp_tcomp);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_310 (tmp_pp_tcomp);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeLib_2_impl_proxy::ccom_remote_get_documentation(  /* [in] */ EIF_INTEGER a_index,  /* [in] */ EIF_INTEGER ref_ptr_flags,  /* [out] */ EIF_OBJECT p_bstr_name,  /* [out] */ EIF_OBJECT p_bstr_doc_string,  /* [out] */ EIF_OBJECT pdw_help_context,  /* [out] */ EIF_OBJECT p_bstr_help_file )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeLib_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeLib_2_, (void **)&p_ITypeLib_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	INT tmp_a_index = 0;
	tmp_a_index = (INT)a_index;
	ULONG tmp_ref_ptr_flags = 0;
	tmp_ref_ptr_flags = (ULONG)ref_ptr_flags;
	BSTR * tmp_p_bstr_name = 0;
	tmp_p_bstr_name = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_362 (eif_access (p_bstr_name), NULL);
	BSTR * tmp_p_bstr_doc_string = 0;
	tmp_p_bstr_doc_string = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_363 (eif_access (p_bstr_doc_string), NULL);
	ULONG * tmp_pdw_help_context = 0;
	tmp_pdw_help_context = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_help_context), NULL);
	BSTR * tmp_p_bstr_help_file = 0;
	tmp_p_bstr_help_file = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_365 (eif_access (p_bstr_help_file), NULL);
	
	hr = p_ITypeLib_2->RemoteGetDocumentation(tmp_a_index,tmp_ref_ptr_flags,tmp_p_bstr_name,tmp_p_bstr_doc_string,tmp_pdw_help_context,tmp_p_bstr_help_file);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_362 ((BSTR *)tmp_p_bstr_name, p_bstr_name);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_363 ((BSTR *)tmp_p_bstr_doc_string, p_bstr_doc_string);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_help_context, pdw_help_context);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_365 ((BSTR *)tmp_p_bstr_help_file, p_bstr_help_file);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_362 (tmp_p_bstr_name);
grt_ce_control_interfaces2.ccom_free_memory_pointed_363 (tmp_p_bstr_doc_string);
grt_ce_control_interfaces2.ccom_free_memory_pointed_364 (tmp_pdw_help_context);
grt_ce_control_interfaces2.ccom_free_memory_pointed_365 (tmp_p_bstr_help_file);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeLib_2_impl_proxy::ccom_remote_is_name(  /* [in] */ EIF_OBJECT sz_name_buf,  /* [in] */ EIF_INTEGER l_hash_val,  /* [out] */ EIF_OBJECT pf_name,  /* [out] */ EIF_OBJECT p_bstr_lib_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeLib_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeLib_2_, (void **)&p_ITypeLib_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_sz_name_buf = 0;
	tmp_sz_name_buf = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (sz_name_buf), NULL);
	ULONG tmp_l_hash_val = 0;
	tmp_l_hash_val = (ULONG)l_hash_val;
	LONG * tmp_pf_name = 0;
	tmp_pf_name = (LONG *)rt_ec.ccom_ec_pointed_long (eif_access (pf_name), NULL);
	BSTR * tmp_p_bstr_lib_name = 0;
	tmp_p_bstr_lib_name = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_367 (eif_access (p_bstr_lib_name), NULL);
	
	hr = p_ITypeLib_2->RemoteIsName(tmp_sz_name_buf,tmp_l_hash_val,tmp_pf_name,tmp_p_bstr_lib_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_long ((LONG *)tmp_pf_name, pf_name);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_367 ((BSTR *)tmp_p_bstr_lib_name, p_bstr_lib_name);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_366 (tmp_pf_name);
grt_ce_control_interfaces2.ccom_free_memory_pointed_367 (tmp_p_bstr_lib_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeLib_2_impl_proxy::ccom_remote_find_name(  /* [in] */ EIF_OBJECT sz_name_buf,  /* [in] */ EIF_INTEGER l_hash_val,  /* [out] */ EIF_OBJECT pp_tinfo,  /* [out] */ EIF_OBJECT rg_mem_id,  /* [in, out] */ EIF_OBJECT pc_found,  /* [out] */ EIF_OBJECT p_bstr_lib_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeLib_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeLib_2_, (void **)&p_ITypeLib_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_sz_name_buf = 0;
	tmp_sz_name_buf = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (sz_name_buf), NULL);
	ULONG tmp_l_hash_val = 0;
	tmp_l_hash_val = (ULONG)l_hash_val;
	ecom_control_library::ITypeInfo_2 * * tmp_pp_tinfo = 0;
	tmp_pp_tinfo = (ecom_control_library::ITypeInfo_2 * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (eif_access (pp_tinfo), NULL);
	LONG * tmp_rg_mem_id = 0;
	tmp_rg_mem_id = (LONG *)rt_ec.ccom_ec_pointed_long (eif_access (rg_mem_id), NULL);
	USHORT * tmp_pc_found = 0;
	tmp_pc_found = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pc_found), NULL);
	BSTR * tmp_p_bstr_lib_name = 0;
	tmp_p_bstr_lib_name = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_370 (eif_access (p_bstr_lib_name), NULL);
	
	hr = p_ITypeLib_2->RemoteFindName(tmp_sz_name_buf,tmp_l_hash_val,tmp_pp_tinfo,tmp_rg_mem_id,tmp_pc_found,tmp_p_bstr_lib_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_302 ((ecom_control_library::ITypeInfo_2 * *)tmp_pp_tinfo, pp_tinfo);
	rt_ce.ccom_ce_pointed_long ((LONG *)tmp_rg_mem_id, rg_mem_id);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pc_found, pc_found);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_370 ((BSTR *)tmp_p_bstr_lib_name, p_bstr_lib_name);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_302 (tmp_pp_tinfo);
grt_ce_control_interfaces2.ccom_free_memory_pointed_368 (tmp_rg_mem_id);
grt_ce_control_interfaces2.ccom_free_memory_pointed_369 (tmp_pc_found);
grt_ce_control_interfaces2.ccom_free_memory_pointed_370 (tmp_p_bstr_lib_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeLib_2_impl_proxy::ccom_local_release_tlib_attr()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeLib_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeLib_2_, (void **)&p_ITypeLib_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ITypeLib_2->LocalReleaseTLibAttr ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::ITypeLib_2_impl_proxy::ccom_item()

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