/*-----------------------------------------------------------
Implemented `ITypeInfo_2' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_ITypeInfo_2_impl_proxy_s.h"
static const IID IID_ITypeInfo_2_ = {0x00020401,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::ITypeInfo_2_impl_proxy::ITypeInfo_2_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ITypeInfo_2_impl_proxy::~ITypeInfo_2_impl_proxy()
{
	p_unknown->Release ();
	if (p_ITypeInfo_2!=NULL)
		p_ITypeInfo_2->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_remote_get_type_attr(  /* [out] */ EIF_OBJECT pp_type_attr,  /* [out] */ EIF_OBJECT p_dummy )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::tagTYPEATTR * * tmp_pp_type_attr = 0;
	tmp_pp_type_attr = (ecom_control_library::tagTYPEATTR * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_305 (eif_access (pp_type_attr), NULL);
	ecom_control_library::DWORD1 * tmp_p_dummy = 0;
	tmp_p_dummy = (ecom_control_library::DWORD1 *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (p_dummy), NULL);
	
	hr = p_ITypeInfo_2->RemoteGetTypeAttr(tmp_pp_type_attr,tmp_p_dummy);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_305 ((ecom_control_library::tagTYPEATTR * *)tmp_pp_type_attr, pp_type_attr);
	rt_ce.ccom_ce_pointed_unsigned_long ((ecom_control_library::DWORD1 *)tmp_p_dummy, p_dummy);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_305 (tmp_pp_type_attr);
grt_ce_control_interfaces2.ccom_free_memory_pointed_307 (tmp_p_dummy);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_get_type_comp(  /* [out] */ EIF_OBJECT pp_tcomp )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::ITypeComp * * tmp_pp_tcomp = 0;
	tmp_pp_tcomp = (ecom_control_library::ITypeComp * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_310 (eif_access (pp_tcomp), NULL);
	
	hr = p_ITypeInfo_2->GetTypeComp(tmp_pp_tcomp);
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

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_remote_get_func_desc(  /* [in] */ EIF_INTEGER a_index,  /* [out] */ EIF_OBJECT pp_func_desc,  /* [out] */ EIF_OBJECT p_dummy )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	UINT tmp_a_index = 0;
	tmp_a_index = (UINT)a_index;
	ecom_control_library::tagFUNCDESC * * tmp_pp_func_desc = 0;
	tmp_pp_func_desc = (ecom_control_library::tagFUNCDESC * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_313 (eif_access (pp_func_desc), NULL);
	ecom_control_library::DWORD1 * tmp_p_dummy = 0;
	tmp_p_dummy = (ecom_control_library::DWORD1 *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (p_dummy), NULL);
	
	hr = p_ITypeInfo_2->RemoteGetFuncDesc(tmp_a_index,tmp_pp_func_desc,tmp_p_dummy);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_313 ((ecom_control_library::tagFUNCDESC * *)tmp_pp_func_desc, pp_func_desc);
	rt_ce.ccom_ce_pointed_unsigned_long ((ecom_control_library::DWORD1 *)tmp_p_dummy, p_dummy);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_313 (tmp_pp_func_desc);
grt_ce_control_interfaces2.ccom_free_memory_pointed_307 (tmp_p_dummy);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_remote_get_var_desc(  /* [in] */ EIF_INTEGER a_index,  /* [out] */ EIF_OBJECT pp_var_desc,  /* [out] */ EIF_OBJECT p_dummy )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	UINT tmp_a_index = 0;
	tmp_a_index = (UINT)a_index;
	ecom_control_library::tagVARDESC * * tmp_pp_var_desc = 0;
	tmp_pp_var_desc = (ecom_control_library::tagVARDESC * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_316 (eif_access (pp_var_desc), NULL);
	ecom_control_library::DWORD1 * tmp_p_dummy = 0;
	tmp_p_dummy = (ecom_control_library::DWORD1 *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (p_dummy), NULL);
	
	hr = p_ITypeInfo_2->RemoteGetVarDesc(tmp_a_index,tmp_pp_var_desc,tmp_p_dummy);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_316 ((ecom_control_library::tagVARDESC * *)tmp_pp_var_desc, pp_var_desc);
	rt_ce.ccom_ce_pointed_unsigned_long ((ecom_control_library::DWORD1 *)tmp_p_dummy, p_dummy);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_316 (tmp_pp_var_desc);
grt_ce_control_interfaces2.ccom_free_memory_pointed_307 (tmp_p_dummy);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_remote_get_names(  /* [in] */ EIF_INTEGER memid,  /* [out] */ EIF_OBJECT rg_bstr_names,  /* [in] */ EIF_INTEGER c_max_names,  /* [out] */ EIF_OBJECT pc_names )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_memid = 0;
	tmp_memid = (LONG)memid;
	BSTR * tmp_rg_bstr_names = 0;
	tmp_rg_bstr_names = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_317 (eif_access (rg_bstr_names), NULL);
	UINT tmp_c_max_names = 0;
	tmp_c_max_names = (UINT)c_max_names;
	UINT * tmp_pc_names = 0;
	tmp_pc_names = (UINT *)rt_ec.ccom_ec_pointed_unsigned_integer (eif_access (pc_names), NULL);
	
	hr = p_ITypeInfo_2->RemoteGetNames(tmp_memid,tmp_rg_bstr_names,tmp_c_max_names,tmp_pc_names);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_317 ((BSTR *)tmp_rg_bstr_names, rg_bstr_names);
	rt_ce.ccom_ce_pointed_unsigned_integer ((UINT *)tmp_pc_names, pc_names);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_317 (tmp_rg_bstr_names);
grt_ce_control_interfaces2.ccom_free_memory_pointed_318 (tmp_pc_names);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_get_ref_type_of_impl_type(  /* [in] */ EIF_INTEGER a_index,  /* [out] */ EIF_OBJECT p_ref_type )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	UINT tmp_a_index = 0;
	tmp_a_index = (UINT)a_index;
	ULONG * tmp_p_ref_type = 0;
	tmp_p_ref_type = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (p_ref_type), NULL);
	
	hr = p_ITypeInfo_2->GetRefTypeOfImplType(tmp_a_index,tmp_p_ref_type);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_p_ref_type, p_ref_type);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_319 (tmp_p_ref_type);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_get_impl_type_flags(  /* [in] */ EIF_INTEGER a_index,  /* [out] */ EIF_OBJECT p_impl_type_flags )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	UINT tmp_a_index = 0;
	tmp_a_index = (UINT)a_index;
	INT * tmp_p_impl_type_flags = 0;
	tmp_p_impl_type_flags = (INT *)rt_ec.ccom_ec_pointed_integer (eif_access (p_impl_type_flags), NULL);
	
	hr = p_ITypeInfo_2->GetImplTypeFlags(tmp_a_index,tmp_p_impl_type_flags);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_integer ((INT *)tmp_p_impl_type_flags, p_impl_type_flags);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_320 (tmp_p_impl_type_flags);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_local_get_ids_of_names()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ITypeInfo_2->LocalGetIDsOfNames ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_local_invoke()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ITypeInfo_2->LocalInvoke ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_remote_get_documentation(  /* [in] */ EIF_INTEGER memid,  /* [in] */ EIF_INTEGER ref_ptr_flags,  /* [out] */ EIF_OBJECT p_bstr_name,  /* [out] */ EIF_OBJECT p_bstr_doc_string,  /* [out] */ EIF_OBJECT pdw_help_context,  /* [out] */ EIF_OBJECT p_bstr_help_file )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_memid = 0;
	tmp_memid = (LONG)memid;
	ULONG tmp_ref_ptr_flags = 0;
	tmp_ref_ptr_flags = (ULONG)ref_ptr_flags;
	BSTR * tmp_p_bstr_name = 0;
	tmp_p_bstr_name = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_321 (eif_access (p_bstr_name), NULL);
	BSTR * tmp_p_bstr_doc_string = 0;
	tmp_p_bstr_doc_string = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_322 (eif_access (p_bstr_doc_string), NULL);
	ULONG * tmp_pdw_help_context = 0;
	tmp_pdw_help_context = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pdw_help_context), NULL);
	BSTR * tmp_p_bstr_help_file = 0;
	tmp_p_bstr_help_file = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_324 (eif_access (p_bstr_help_file), NULL);
	
	hr = p_ITypeInfo_2->RemoteGetDocumentation(tmp_memid,tmp_ref_ptr_flags,tmp_p_bstr_name,tmp_p_bstr_doc_string,tmp_pdw_help_context,tmp_p_bstr_help_file);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_321 ((BSTR *)tmp_p_bstr_name, p_bstr_name);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_322 ((BSTR *)tmp_p_bstr_doc_string, p_bstr_doc_string);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pdw_help_context, pdw_help_context);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_324 ((BSTR *)tmp_p_bstr_help_file, p_bstr_help_file);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_321 (tmp_p_bstr_name);
grt_ce_control_interfaces2.ccom_free_memory_pointed_322 (tmp_p_bstr_doc_string);
grt_ce_control_interfaces2.ccom_free_memory_pointed_323 (tmp_pdw_help_context);
grt_ce_control_interfaces2.ccom_free_memory_pointed_324 (tmp_p_bstr_help_file);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_remote_get_dll_entry(  /* [in] */ EIF_INTEGER memid,  /* [in] */ EIF_INTEGER invkind,  /* [in] */ EIF_INTEGER ref_ptr_flags,  /* [out] */ EIF_OBJECT p_bstr_dll_name,  /* [out] */ EIF_OBJECT p_bstr_name,  /* [out] */ EIF_OBJECT pw_ordinal )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_memid = 0;
	tmp_memid = (LONG)memid;
	long tmp_invkind = 0;
	tmp_invkind = (long)invkind;
	ULONG tmp_ref_ptr_flags = 0;
	tmp_ref_ptr_flags = (ULONG)ref_ptr_flags;
	BSTR * tmp_p_bstr_dll_name = 0;
	tmp_p_bstr_dll_name = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_326 (eif_access (p_bstr_dll_name), NULL);
	BSTR * tmp_p_bstr_name = 0;
	tmp_p_bstr_name = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_327 (eif_access (p_bstr_name), NULL);
	USHORT * tmp_pw_ordinal = 0;
	tmp_pw_ordinal = (USHORT *)rt_ec.ccom_ec_pointed_unsigned_short (eif_access (pw_ordinal), NULL);
	
	hr = p_ITypeInfo_2->RemoteGetDllEntry(tmp_memid,tmp_invkind,tmp_ref_ptr_flags,tmp_p_bstr_dll_name,tmp_p_bstr_name,tmp_pw_ordinal);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_326 ((BSTR *)tmp_p_bstr_dll_name, p_bstr_dll_name);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_327 ((BSTR *)tmp_p_bstr_name, p_bstr_name);
	rt_ce.ccom_ce_pointed_unsigned_short ((USHORT *)tmp_pw_ordinal, pw_ordinal);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_326 (tmp_p_bstr_dll_name);
grt_ce_control_interfaces2.ccom_free_memory_pointed_327 (tmp_p_bstr_name);
grt_ce_control_interfaces2.ccom_free_memory_pointed_328 (tmp_pw_ordinal);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_get_ref_type_info(  /* [in] */ EIF_INTEGER hreftype,  /* [out] */ EIF_OBJECT pp_tinfo )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_hreftype = 0;
	tmp_hreftype = (ULONG)hreftype;
	ecom_control_library::ITypeInfo_2 * * tmp_pp_tinfo = 0;
	tmp_pp_tinfo = (ecom_control_library::ITypeInfo_2 * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (eif_access (pp_tinfo), NULL);
	
	hr = p_ITypeInfo_2->GetRefTypeInfo(tmp_hreftype,tmp_pp_tinfo);
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

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_local_address_of_member()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ITypeInfo_2->LocalAddressOfMember ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_remote_create_instance(  /* [in] */ GUID * riid,  /* [out] */ EIF_OBJECT ppv_obj )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	IUnknown * * tmp_ppv_obj = 0;
	tmp_ppv_obj = (IUnknown * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_329 (eif_access (ppv_obj), NULL);
	
	hr = p_ITypeInfo_2->RemoteCreateInstance(riid,tmp_ppv_obj);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_329 ((IUnknown * *)tmp_ppv_obj, ppv_obj);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_329 (tmp_ppv_obj);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_get_mops(  /* [in] */ EIF_INTEGER memid,  /* [out] */ EIF_OBJECT p_bstr_mops )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_memid = 0;
	tmp_memid = (LONG)memid;
	BSTR * tmp_p_bstr_mops = 0;
	tmp_p_bstr_mops = (BSTR *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_330 (eif_access (p_bstr_mops), NULL);
	
	hr = p_ITypeInfo_2->GetMops(tmp_memid,tmp_p_bstr_mops);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_330 ((BSTR *)tmp_p_bstr_mops, p_bstr_mops);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_330 (tmp_p_bstr_mops);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_remote_get_containing_type_lib(  /* [out] */ EIF_OBJECT pp_tlib,  /* [out] */ EIF_OBJECT p_index )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_control_library::ITypeLib_2 * * tmp_pp_tlib = 0;
	tmp_pp_tlib = (ecom_control_library::ITypeLib_2 * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_333 (eif_access (pp_tlib), NULL);
	UINT * tmp_p_index = 0;
	tmp_p_index = (UINT *)rt_ec.ccom_ec_pointed_unsigned_integer (eif_access (p_index), NULL);
	
	hr = p_ITypeInfo_2->RemoteGetContainingTypeLib(tmp_pp_tlib,tmp_p_index);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_333 ((ecom_control_library::ITypeLib_2 * *)tmp_pp_tlib, pp_tlib);
	rt_ce.ccom_ce_pointed_unsigned_integer ((UINT *)tmp_p_index, p_index);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_333 (tmp_pp_tlib);
grt_ce_control_interfaces2.ccom_free_memory_pointed_334 (tmp_p_index);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_local_release_type_attr()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ITypeInfo_2->LocalReleaseTypeAttr ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_local_release_func_desc()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ITypeInfo_2->LocalReleaseFuncDesc ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeInfo_2_impl_proxy::ccom_local_release_var_desc()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeInfo_2 == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeInfo_2_, (void **)&p_ITypeInfo_2);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ITypeInfo_2->LocalReleaseVarDesc ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_control_library::ITypeInfo_2_impl_proxy::ccom_item()

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