/*-----------------------------------------------------------
Implemented `IEnumClusterExcludes' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEnumClusterExcludes_impl_proxy.h"
static const IID IID_IEnumClusterExcludes_ = {0xca8db208,0x5e92,0x426e,{0x95,0x3d,0x26,0x60,0xc1,0x31,0xc6,0x18}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEnumClusterExcludes_impl_proxy::IEnumClusterExcludes_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEnumClusterExcludes_, (void **)&p_IEnumClusterExcludes);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumClusterExcludes_impl_proxy::~IEnumClusterExcludes_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEnumClusterExcludes!=NULL)
		p_IEnumClusterExcludes->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumClusterExcludes_impl_proxy::ccom_next(  /* [out] */ EIF_OBJECT pbstr_exclude,  /* [out] */ EIF_OBJECT pul_fetched )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumClusterExcludes == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumClusterExcludes_, (void **)&p_IEnumClusterExcludes);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR * tmp_pbstr_exclude = 0;
	tmp_pbstr_exclude = (BSTR *)grt_ec_ISE_c.ccom_ec_pointed_cell_213 (eif_access (pbstr_exclude), NULL);
	ULONG * tmp_pul_fetched = 0;
	tmp_pul_fetched = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pul_fetched), NULL);
	
	hr = p_IEnumClusterExcludes->Next(tmp_pbstr_exclude,tmp_pul_fetched);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE_c.ccom_ce_pointed_cell_213 ((BSTR *)tmp_pbstr_exclude, pbstr_exclude);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pul_fetched, pul_fetched);
	
	grt_ce_ISE_c.ccom_free_memory_pointed_213 (tmp_pbstr_exclude);
grt_ce_ISE_c.ccom_free_memory_pointed_214 (tmp_pul_fetched);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumClusterExcludes_impl_proxy::ccom_skip(  /* [in] */ EIF_INTEGER ul_count )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumClusterExcludes == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumClusterExcludes_, (void **)&p_IEnumClusterExcludes);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ul_count = 0;
	tmp_ul_count = (ULONG)ul_count;
	
	hr = p_IEnumClusterExcludes->Skip(tmp_ul_count);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumClusterExcludes_impl_proxy::ccom_reset()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumClusterExcludes == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumClusterExcludes_, (void **)&p_IEnumClusterExcludes);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IEnumClusterExcludes->Reset ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumClusterExcludes_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT pp_ienum_cluster_excludes )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumClusterExcludes == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumClusterExcludes_, (void **)&p_IEnumClusterExcludes);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEnumClusterExcludes * * tmp_pp_ienum_cluster_excludes = 0;
	tmp_pp_ienum_cluster_excludes = (ecom_EiffelComCompiler::IEnumClusterExcludes * *)grt_ec_ISE_c.ccom_ec_pointed_cell_205 (eif_access (pp_ienum_cluster_excludes), NULL);
	
	hr = p_IEnumClusterExcludes->Clone(tmp_pp_ienum_cluster_excludes);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE_c.ccom_ce_pointed_cell_205 ((ecom_EiffelComCompiler::IEnumClusterExcludes * *)tmp_pp_ienum_cluster_excludes, pp_ienum_cluster_excludes);
	
	grt_ce_ISE_c.ccom_free_memory_pointed_205 (tmp_pp_ienum_cluster_excludes);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumClusterExcludes_impl_proxy::ccom_ith_item(  /* [in] */ EIF_INTEGER ul_index,  /* [out] */ EIF_OBJECT pbstr_exclude )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumClusterExcludes == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumClusterExcludes_, (void **)&p_IEnumClusterExcludes);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ul_index = 0;
	tmp_ul_index = (ULONG)ul_index;
	BSTR * tmp_pbstr_exclude = 0;
	tmp_pbstr_exclude = (BSTR *)grt_ec_ISE_c.ccom_ec_pointed_cell_215 (eif_access (pbstr_exclude), NULL);
	
	hr = p_IEnumClusterExcludes->IthItem(tmp_ul_index,tmp_pbstr_exclude);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE_c.ccom_ce_pointed_cell_215 ((BSTR *)tmp_pbstr_exclude, pbstr_exclude);
	
	grt_ce_ISE_c.ccom_free_memory_pointed_215 (tmp_pbstr_exclude);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelComCompiler::IEnumClusterExcludes_impl_proxy::ccom_count(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumClusterExcludes == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumClusterExcludes_, (void **)&p_IEnumClusterExcludes);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG ret_value = 0;
	
	hr = p_IEnumClusterExcludes->Count( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_INTEGER eiffel_result =  (EIF_INTEGER)ret_value;
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_EiffelComCompiler::IEnumClusterExcludes_impl_proxy::ccom_item()

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