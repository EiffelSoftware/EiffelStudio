/*-----------------------------------------------------------
Implemented `ITypeComp' Interface.
-----------------------------------------------------------*/

#include "ecom_control_library_ITypeComp_impl_proxy_s.h"
static const IID IID_ITypeComp_ = {0x00020403,0x0000,0x0000,{0xc0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_control_library::ITypeComp_impl_proxy::ITypeComp_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_ITypeComp_, (void **)&p_ITypeComp);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_control_library::ITypeComp_impl_proxy::~ITypeComp_impl_proxy()
{
	p_unknown->Release ();
	if (p_ITypeComp!=NULL)
		p_ITypeComp->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeComp_impl_proxy::ccom_remote_bind(  /* [in] */ EIF_OBJECT sz_name,  /* [in] */ EIF_INTEGER l_hash_val,  /* [in] */ EIF_INTEGER w_flags,  /* [out] */ EIF_OBJECT pp_tinfo,  /* [out] */ EIF_OBJECT p_desc_kind,  /* [out] */ EIF_OBJECT pp_func_desc,  /* [out] */ EIF_OBJECT pp_var_desc,  /* [out] */ EIF_OBJECT pp_type_comp,  /* [out] */ EIF_OBJECT p_dummy )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeComp == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeComp_, (void **)&p_ITypeComp);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_sz_name = 0;
	tmp_sz_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (sz_name), NULL);
	ULONG tmp_l_hash_val = 0;
	tmp_l_hash_val = (ULONG)l_hash_val;
	USHORT tmp_w_flags = 0;
	tmp_w_flags = (USHORT)w_flags;
	ecom_control_library::ITypeInfo_2 * * tmp_pp_tinfo = 0;
	tmp_pp_tinfo = (ecom_control_library::ITypeInfo_2 * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (eif_access (pp_tinfo), NULL);
	long * tmp_p_desc_kind = 0;
	tmp_p_desc_kind = (long *)rt_ec.ccom_ec_pointed_long (eif_access (p_desc_kind), NULL);
	ecom_control_library::tagFUNCDESC * * tmp_pp_func_desc = 0;
	tmp_pp_func_desc = (ecom_control_library::tagFUNCDESC * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_313 (eif_access (pp_func_desc), NULL);
	ecom_control_library::tagVARDESC * * tmp_pp_var_desc = 0;
	tmp_pp_var_desc = (ecom_control_library::tagVARDESC * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_316 (eif_access (pp_var_desc), NULL);
	ecom_control_library::ITypeComp * * tmp_pp_type_comp = 0;
	tmp_pp_type_comp = (ecom_control_library::ITypeComp * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_310 (eif_access (pp_type_comp), NULL);
	ecom_control_library::DWORD1 * tmp_p_dummy = 0;
	tmp_p_dummy = (ecom_control_library::DWORD1 *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (p_dummy), NULL);
	
	hr = p_ITypeComp->RemoteBind(tmp_sz_name,tmp_l_hash_val,tmp_w_flags,tmp_pp_tinfo,tmp_p_desc_kind,tmp_pp_func_desc,tmp_pp_var_desc,tmp_pp_type_comp,tmp_p_dummy);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_302 ((ecom_control_library::ITypeInfo_2 * *)tmp_pp_tinfo, pp_tinfo);
	rt_ce.ccom_ce_pointed_long ((long *)tmp_p_desc_kind, p_desc_kind);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_313 ((ecom_control_library::tagFUNCDESC * *)tmp_pp_func_desc, pp_func_desc);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_316 ((ecom_control_library::tagVARDESC * *)tmp_pp_var_desc, pp_var_desc);
	grt_ce_control_interfaces2.ccom_ce_pointed_cell_310 ((ecom_control_library::ITypeComp * *)tmp_pp_type_comp, pp_type_comp);
	rt_ce.ccom_ce_pointed_unsigned_long ((ecom_control_library::DWORD1 *)tmp_p_dummy, p_dummy);
	
	grt_ce_control_interfaces2.ccom_free_memory_pointed_302 (tmp_pp_tinfo);
grt_ce_control_interfaces2.ccom_free_memory_pointed_345 (tmp_p_desc_kind);
grt_ce_control_interfaces2.ccom_free_memory_pointed_313 (tmp_pp_func_desc);
grt_ce_control_interfaces2.ccom_free_memory_pointed_316 (tmp_pp_var_desc);
grt_ce_control_interfaces2.ccom_free_memory_pointed_310 (tmp_pp_type_comp);
grt_ce_control_interfaces2.ccom_free_memory_pointed_307 (tmp_p_dummy);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_control_library::ITypeComp_impl_proxy::ccom_remote_bind_type(  /* [in] */ EIF_OBJECT sz_name,  /* [in] */ EIF_INTEGER l_hash_val,  /* [out] */ EIF_OBJECT pp_tinfo )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ITypeComp == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ITypeComp_, (void **)&p_ITypeComp);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LPWSTR tmp_sz_name = 0;
	tmp_sz_name = (LPWSTR)rt_ec.ccom_ec_lpwstr (eif_access (sz_name), NULL);
	ULONG tmp_l_hash_val = 0;
	tmp_l_hash_val = (ULONG)l_hash_val;
	ecom_control_library::ITypeInfo_2 * * tmp_pp_tinfo = 0;
	tmp_pp_tinfo = (ecom_control_library::ITypeInfo_2 * *)grt_ec_control_interfaces2.ccom_ec_pointed_cell_302 (eif_access (pp_tinfo), NULL);
	
	hr = p_ITypeComp->RemoteBindType(tmp_sz_name,tmp_l_hash_val,tmp_pp_tinfo);
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

EIF_POINTER ecom_control_library::ITypeComp_impl_proxy::ccom_item()

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