/*-----------------------------------------------------------
Implemented `IEnumClusterProp' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEnumClusterProp_impl_proxy_s.h"
static const IID IID_IEnumClusterProp_ = {0xc5b13566,0x8a44,0x40e1,{0xa0,0x90,0x3e,0x5c,0xc3,0x6c,0xa7,0x2d}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEnumClusterProp_impl_proxy::IEnumClusterProp_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEnumClusterProp_, (void **)&p_IEnumClusterProp);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

	excepinfo = (EXCEPINFO*)CoTaskMemAlloc (sizeof (EXCEPINFO));
	if (excepinfo != NULL)
		memset (excepinfo, '\0', sizeof (EXCEPINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumClusterProp_impl_proxy::~IEnumClusterProp_impl_proxy()
{
	p_unknown->Release ();
	
	CoTaskMemFree ((void *)excepinfo);
	if (p_IEnumClusterProp!=NULL)
		p_IEnumClusterProp->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelComCompiler::IEnumClusterProp_impl_proxy::ccom_last_error_code()

/*-----------------------------------------------------------
	Last error code
-----------------------------------------------------------*/
{
	return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEnumClusterProp_impl_proxy::ccom_last_source_of_exception()

/*-----------------------------------------------------------
	Last source of exception
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEnumClusterProp_impl_proxy::ccom_last_error_description()

/*-----------------------------------------------------------
	Last error description
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEnumClusterProp_impl_proxy::ccom_last_error_help_file()

/*-----------------------------------------------------------
	Last error help file
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumClusterProp_impl_proxy::ccom_next(  /* [out] */ EIF_OBJECT pp_ieiffel_cluster_properties,  /* [out] */ EIF_OBJECT pul_fetched )

/*-----------------------------------------------------------
	Go to next item in enumerator
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumClusterProp == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumClusterProp_, (void **)&p_IEnumClusterProp);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEiffelClusterProperties * * tmp_pp_ieiffel_cluster_properties = 0;
	tmp_pp_ieiffel_cluster_properties = (ecom_EiffelComCompiler::IEiffelClusterProperties * *)grt_ec_ISE.ccom_ec_pointed_cell_187 (eif_access (pp_ieiffel_cluster_properties), NULL);
	ULONG * tmp_pul_fetched = 0;
	tmp_pul_fetched = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pul_fetched), NULL);
	
	hr = p_IEnumClusterProp->Next(tmp_pp_ieiffel_cluster_properties,tmp_pul_fetched);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_187 ((ecom_EiffelComCompiler::IEiffelClusterProperties * *)tmp_pp_ieiffel_cluster_properties, pp_ieiffel_cluster_properties);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pul_fetched, pul_fetched);
	
	grt_ce_ISE.ccom_free_memory_pointed_187 (tmp_pp_ieiffel_cluster_properties);
grt_ce_ISE.ccom_free_memory_pointed_190 (tmp_pul_fetched);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumClusterProp_impl_proxy::ccom_skip(  /* [in] */ EIF_INTEGER ul_count )

/*-----------------------------------------------------------
	Skip `ulCount' items.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumClusterProp == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumClusterProp_, (void **)&p_IEnumClusterProp);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ul_count = 0;
	tmp_ul_count = (ULONG)ul_count;
	
	hr = p_IEnumClusterProp->Skip(tmp_ul_count);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumClusterProp_impl_proxy::ccom_reset()

/*-----------------------------------------------------------
	Reset enumerator.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumClusterProp == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumClusterProp_, (void **)&p_IEnumClusterProp);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IEnumClusterProp->Reset ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumClusterProp_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT pp_ienum_cluster_prop )

/*-----------------------------------------------------------
	Clone enumerator.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumClusterProp == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumClusterProp_, (void **)&p_IEnumClusterProp);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEnumClusterProp * * tmp_pp_ienum_cluster_prop = 0;
	tmp_pp_ienum_cluster_prop = (ecom_EiffelComCompiler::IEnumClusterProp * *)grt_ec_ISE.ccom_ec_pointed_cell_183 (eif_access (pp_ienum_cluster_prop), NULL);
	
	hr = p_IEnumClusterProp->Clone(tmp_pp_ienum_cluster_prop);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_183 ((ecom_EiffelComCompiler::IEnumClusterProp * *)tmp_pp_ienum_cluster_prop, pp_ienum_cluster_prop);
	
	grt_ce_ISE.ccom_free_memory_pointed_183 (tmp_pp_ienum_cluster_prop);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumClusterProp_impl_proxy::ccom_ith_item(  /* [in] */ EIF_INTEGER ul_index,  /* [out] */ EIF_OBJECT pp_ieiffel_cluster_properties )

/*-----------------------------------------------------------
	Retrieve enumerators ith item at `ulIndex'.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumClusterProp == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumClusterProp_, (void **)&p_IEnumClusterProp);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ul_index = 0;
	tmp_ul_index = (ULONG)ul_index;
	ecom_EiffelComCompiler::IEiffelClusterProperties * * tmp_pp_ieiffel_cluster_properties = 0;
	tmp_pp_ieiffel_cluster_properties = (ecom_EiffelComCompiler::IEiffelClusterProperties * *)grt_ec_ISE.ccom_ec_pointed_cell_187 (eif_access (pp_ieiffel_cluster_properties), NULL);
	
	hr = p_IEnumClusterProp->IthItem(tmp_ul_index,tmp_pp_ieiffel_cluster_properties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_187 ((ecom_EiffelComCompiler::IEiffelClusterProperties * *)tmp_pp_ieiffel_cluster_properties, pp_ieiffel_cluster_properties);
	
	grt_ce_ISE.ccom_free_memory_pointed_187 (tmp_pp_ieiffel_cluster_properties);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelComCompiler::IEnumClusterProp_impl_proxy::ccom_count(  )

/*-----------------------------------------------------------
	Retrieve enumerator item count.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumClusterProp == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumClusterProp_, (void **)&p_IEnumClusterProp);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG ret_value = 0;
	
	hr = p_IEnumClusterProp->Count( &ret_value);
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

EIF_POINTER ecom_EiffelComCompiler::IEnumClusterProp_impl_proxy::ccom_item()

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