/*-----------------------------------------------------------
Implemented `IEnumFeature' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEnumFeature_impl_proxy_s.h"
static const IID IID_IEnumFeature_ = {0xdc003e49,0x6c17,0x4be2,{0xbd,0x81,0x3d,0x35,0x40,0xb7,0x38,0xb1}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEnumFeature_impl_proxy::IEnumFeature_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEnumFeature_, (void **)&p_IEnumFeature);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumFeature_impl_proxy::~IEnumFeature_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEnumFeature!=NULL)
		p_IEnumFeature->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumFeature_impl_proxy::ccom_next(  /* [out] */ EIF_OBJECT pp_ieiffel_feature_descriptor,  /* [out] */ EIF_OBJECT pul_fetched )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumFeature == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumFeature_, (void **)&p_IEnumFeature);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * tmp_pp_ieiffel_feature_descriptor = 0;
	tmp_pp_ieiffel_feature_descriptor = (ecom_EiffelComCompiler::IEiffelFeatureDescriptor * *)grt_ec_ISE.ccom_ec_pointed_cell_56 (eif_access (pp_ieiffel_feature_descriptor), NULL);
	ULONG * tmp_pul_fetched = 0;
	tmp_pul_fetched = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pul_fetched), NULL);
	
	hr = p_IEnumFeature->Next(tmp_pp_ieiffel_feature_descriptor,tmp_pul_fetched);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_56 ((ecom_EiffelComCompiler::IEiffelFeatureDescriptor * *)tmp_pp_ieiffel_feature_descriptor, pp_ieiffel_feature_descriptor);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pul_fetched, pul_fetched);
	
	grt_ce_ISE.ccom_free_memory_pointed_56 (tmp_pp_ieiffel_feature_descriptor);
grt_ce_ISE.ccom_free_memory_pointed_84 (tmp_pul_fetched);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumFeature_impl_proxy::ccom_skip(  /* [in] */ EIF_INTEGER ul_count )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumFeature == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumFeature_, (void **)&p_IEnumFeature);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ul_count = 0;
	tmp_ul_count = (ULONG)ul_count;
	
	hr = p_IEnumFeature->Skip(tmp_ul_count);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumFeature_impl_proxy::ccom_reset()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumFeature == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumFeature_, (void **)&p_IEnumFeature);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IEnumFeature->Reset ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumFeature_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT pp_ienum_feature )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumFeature == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumFeature_, (void **)&p_IEnumFeature);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEnumFeature * * tmp_pp_ienum_feature = 0;
	tmp_pp_ienum_feature = (ecom_EiffelComCompiler::IEnumFeature * *)grt_ec_ISE.ccom_ec_pointed_cell_59 (eif_access (pp_ienum_feature), NULL);
	
	hr = p_IEnumFeature->Clone(tmp_pp_ienum_feature);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_59 ((ecom_EiffelComCompiler::IEnumFeature * *)tmp_pp_ienum_feature, pp_ienum_feature);
	
	grt_ce_ISE.ccom_free_memory_pointed_59 (tmp_pp_ienum_feature);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumFeature_impl_proxy::ccom_ith_item(  /* [in] */ EIF_INTEGER ul_index,  /* [out] */ EIF_OBJECT pp_ieiffel_feature_descriptor )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumFeature == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumFeature_, (void **)&p_IEnumFeature);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ul_index = 0;
	tmp_ul_index = (ULONG)ul_index;
	ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * tmp_pp_ieiffel_feature_descriptor = 0;
	tmp_pp_ieiffel_feature_descriptor = (ecom_EiffelComCompiler::IEiffelFeatureDescriptor * *)grt_ec_ISE.ccom_ec_pointed_cell_56 (eif_access (pp_ieiffel_feature_descriptor), NULL);
	
	hr = p_IEnumFeature->IthItem(tmp_ul_index,tmp_pp_ieiffel_feature_descriptor);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_56 ((ecom_EiffelComCompiler::IEiffelFeatureDescriptor * *)tmp_pp_ieiffel_feature_descriptor, pp_ieiffel_feature_descriptor);
	
	grt_ce_ISE.ccom_free_memory_pointed_56 (tmp_pp_ieiffel_feature_descriptor);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelComCompiler::IEnumFeature_impl_proxy::ccom_count(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumFeature == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumFeature_, (void **)&p_IEnumFeature);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG ret_value = 0;
	
	hr = p_IEnumFeature->Count( &ret_value);
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

EIF_POINTER ecom_EiffelComCompiler::IEnumFeature_impl_proxy::ccom_item()

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