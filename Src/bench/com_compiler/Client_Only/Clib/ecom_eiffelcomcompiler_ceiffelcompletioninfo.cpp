/*-----------------------------------------------------------
Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_CEiffelCompletionInfo.h"
static const CLSID CLSID_CEiffelCompletionInfo_ = {0xbca3e550,0x3e39,0x4a44,{0xa0,0x34,0x38,0xf8,0xb4,0x22,0xd8,0xdf}};

static const IID IID_IEiffelCompletionInfo_ = {0x8630e639,0xedae,0x46b7,{0x88,0x0b,0x27,0xd6,0x8e,0x71,0x84,0xfa}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::CEiffelCompletionInfo::CEiffelCompletionInfo( IUnknown * a_pointer )
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

	p_IEiffelCompletionInfo = 0;
	hr = a_pointer->QueryInterface(IID_IEiffelCompletionInfo_, (void **)&p_IEiffelCompletionInfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::CEiffelCompletionInfo::~CEiffelCompletionInfo()
{
	p_unknown->Release ();
	if (p_IEiffelCompletionInfo!=NULL)
		p_IEiffelCompletionInfo->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::CEiffelCompletionInfo::ccom_add_local(  /* [in] */ EIF_OBJECT bstr_name,  /* [in] */ EIF_OBJECT bstr_type )

/*-----------------------------------------------------------
	Add a local variable used for solving member completion list
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelCompletionInfo == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelCompletionInfo_, (void **)&p_IEiffelCompletionInfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_name = 0;
	tmp_bstr_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_name));
	BSTR tmp_bstr_type = 0;
	tmp_bstr_type = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_type));
	
	hr = p_IEiffelCompletionInfo->AddLocal(tmp_bstr_name,tmp_bstr_type);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_name);
rt_ce.free_memory_bstr (tmp_bstr_type);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::CEiffelCompletionInfo::ccom_add_argument(  /* [in] */ EIF_OBJECT bstr_name,  /* [in] */ EIF_OBJECT bstr_type )

/*-----------------------------------------------------------
	Add an argument used for solving member completion list
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelCompletionInfo == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelCompletionInfo_, (void **)&p_IEiffelCompletionInfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_name = 0;
	tmp_bstr_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_name));
	BSTR tmp_bstr_type = 0;
	tmp_bstr_type = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_type));
	
	hr = p_IEiffelCompletionInfo->AddArgument(tmp_bstr_name,tmp_bstr_type);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_name);
rt_ce.free_memory_bstr (tmp_bstr_type);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::CEiffelCompletionInfo::ccom_target_features(  /* [in] */ EIF_OBJECT bstr_target,  /* [in] */ EIF_OBJECT bstr_feature_name,  /* [in] */ EIF_OBJECT bstr_file_name,  /* [out] */ VARIANT * pvar_names,  /* [out] */ VARIANT * pvar_signatures,  /* [out] */ VARIANT * pvar_image_indexes )

/*-----------------------------------------------------------
	Features accessible from target.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelCompletionInfo == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelCompletionInfo_, (void **)&p_IEiffelCompletionInfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_target = 0;
	tmp_bstr_target = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_target));
	BSTR tmp_bstr_feature_name = 0;
	tmp_bstr_feature_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_feature_name));
	BSTR tmp_bstr_file_name = 0;
	tmp_bstr_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_file_name));
	
	hr = p_IEiffelCompletionInfo->TargetFeatures(tmp_bstr_target,tmp_bstr_feature_name,tmp_bstr_file_name,pvar_names,pvar_signatures,pvar_image_indexes);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_target);
rt_ce.free_memory_bstr (tmp_bstr_feature_name);
rt_ce.free_memory_bstr (tmp_bstr_file_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::CEiffelCompletionInfo::ccom_target_feature(  /* [in] */ EIF_OBJECT bstr_target,  /* [in] */ EIF_OBJECT bstr_feature_name,  /* [in] */ EIF_OBJECT bstr_file_name )

/*-----------------------------------------------------------
	Feature information
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelCompletionInfo == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelCompletionInfo_, (void **)&p_IEiffelCompletionInfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_target = 0;
	tmp_bstr_target = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_target));
	BSTR tmp_bstr_feature_name = 0;
	tmp_bstr_feature_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_feature_name));
	BSTR tmp_bstr_file_name = 0;
	tmp_bstr_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_file_name));
	ecom_EiffelComCompiler::IEiffelFeatureDescriptor * ret_value = 0;
	
	hr = p_IEiffelCompletionInfo->TargetFeature(tmp_bstr_target,tmp_bstr_feature_name,tmp_bstr_file_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_target);
rt_ce.free_memory_bstr (tmp_bstr_feature_name);
rt_ce.free_memory_bstr (tmp_bstr_file_name);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_55 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::CEiffelCompletionInfo::ccom_flush_completion_features(  /* [in] */ EIF_OBJECT bstr_file_name )

/*-----------------------------------------------------------
	Flush temporary completion features for a specific file
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelCompletionInfo == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelCompletionInfo_, (void **)&p_IEiffelCompletionInfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_file_name = 0;
	tmp_bstr_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_file_name));
	
	hr = p_IEiffelCompletionInfo->FlushCompletionFeatures(tmp_bstr_file_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_file_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::CEiffelCompletionInfo::ccom_initialize_feature(  /* [in] */ EIF_OBJECT bstr_name,  /* [in] */ VARIANT * var_arguments,  /* [in] */ VARIANT * var_argument_types,  /* [in] */ EIF_OBJECT bstr_return_type,  /* [in] */ EIF_INTEGER ul_feature_type,  /* [in] */ EIF_OBJECT bstr_file_name )

/*-----------------------------------------------------------
	Initialize a feature for completion without compiltation
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelCompletionInfo == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelCompletionInfo_, (void **)&p_IEiffelCompletionInfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_name = 0;
	tmp_bstr_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_name));
	BSTR tmp_bstr_return_type = 0;
	tmp_bstr_return_type = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_return_type));
	ULONG tmp_ul_feature_type = 0;
	tmp_ul_feature_type = (ULONG)ul_feature_type;
	BSTR tmp_bstr_file_name = 0;
	tmp_bstr_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_file_name));
	
	hr = p_IEiffelCompletionInfo->InitializeFeature(tmp_bstr_name,*(VARIANT*)var_arguments,*(VARIANT*)var_argument_types,tmp_bstr_return_type,tmp_ul_feature_type,tmp_bstr_file_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_name);
rt_ce.free_memory_bstr (tmp_bstr_return_type);
rt_ce.free_memory_bstr (tmp_bstr_file_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_EiffelComCompiler::CEiffelCompletionInfo::ccom_item()

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