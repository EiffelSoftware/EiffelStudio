/*-----------------------------------------------------------
Implemented `IEiffelCompletionInfo' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelCompletionInfo_impl_proxy_s.h"
static const IID IID_IEiffelCompletionInfo_ = {0x8630e639,0xedae,0x46b7,{0x88,0x0b,0x27,0xd6,0x8e,0x71,0x84,0xfa}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelCompletionInfo_impl_proxy::IEiffelCompletionInfo_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEiffelCompletionInfo_, (void **)&p_IEiffelCompletionInfo);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelCompletionInfo_impl_proxy::~IEiffelCompletionInfo_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEiffelCompletionInfo!=NULL)
		p_IEiffelCompletionInfo->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelCompletionInfo_impl_proxy::ccom_add_local(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_OBJECT type )

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
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	BSTR tmp_type = 0;
	tmp_type = (BSTR)rt_ec.ccom_ec_bstr (eif_access (type));
	
	hr = p_IEiffelCompletionInfo->add_local(tmp_name,tmp_type);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_name);
rt_ce.free_memory_bstr (tmp_type);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelCompletionInfo_impl_proxy::ccom_add_argument(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_OBJECT type )

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
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	BSTR tmp_type = 0;
	tmp_type = (BSTR)rt_ec.ccom_ec_bstr (eif_access (type));
	
	hr = p_IEiffelCompletionInfo->add_argument(tmp_name,tmp_type);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_name);
rt_ce.free_memory_bstr (tmp_type);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelCompletionInfo_impl_proxy::ccom_target_features(  /* [in] */ EIF_OBJECT target,  /* [in] */ EIF_OBJECT feature_name,  /* [in] */ EIF_OBJECT file_name,  /* [out] */ VARIANT * return_names,  /* [out] */ VARIANT * return_signatures,  /* [out] */ VARIANT * return_image_indexes )

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
	BSTR tmp_target = 0;
	tmp_target = (BSTR)rt_ec.ccom_ec_bstr (eif_access (target));
	BSTR tmp_feature_name = 0;
	tmp_feature_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (feature_name));
	BSTR tmp_file_name = 0;
	tmp_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (file_name));
	
	hr = p_IEiffelCompletionInfo->target_features(tmp_target,tmp_feature_name,tmp_file_name,return_names,return_signatures,return_image_indexes);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_target);
rt_ce.free_memory_bstr (tmp_feature_name);
rt_ce.free_memory_bstr (tmp_file_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelCompletionInfo_impl_proxy::ccom_target_feature(  /* [in] */ EIF_OBJECT target,  /* [in] */ EIF_OBJECT feature_name,  /* [in] */ EIF_OBJECT file_name )

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
	BSTR tmp_target = 0;
	tmp_target = (BSTR)rt_ec.ccom_ec_bstr (eif_access (target));
	BSTR tmp_feature_name = 0;
	tmp_feature_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (feature_name));
	BSTR tmp_file_name = 0;
	tmp_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (file_name));
	ecom_eiffel_compiler::IEiffelFeatureDescriptor * ret_value = 0;
	
	hr = p_IEiffelCompletionInfo->target_feature(tmp_target,tmp_feature_name,tmp_file_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_target);
rt_ce.free_memory_bstr (tmp_feature_name);
rt_ce.free_memory_bstr (tmp_file_name);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_56 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelCompletionInfo_impl_proxy::ccom_flush_completion_features(  /* [in] */ EIF_OBJECT a_file_name )

/*-----------------------------------------------------------
	Flush temporary completion features for a specifi file
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
	BSTR tmp_a_file_name = 0;
	tmp_a_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_file_name));
	
	hr = p_IEiffelCompletionInfo->flush_completion_features(tmp_a_file_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_file_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelCompletionInfo_impl_proxy::ccom_initialize_feature(  /* [in] */ EIF_OBJECT a_name,  /* [in] */ VARIANT * a_arguments,  /* [in] */ VARIANT * a_argument_types,  /* [in] */ EIF_OBJECT a_return_type,  /* [in] */ EIF_INTEGER a_feature_type,  /* [in] */ EIF_OBJECT a_file_name )

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
	BSTR tmp_a_name = 0;
	tmp_a_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_name));
	BSTR tmp_a_return_type = 0;
	tmp_a_return_type = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_return_type));
	ULONG tmp_a_feature_type = 0;
	tmp_a_feature_type = (ULONG)a_feature_type;
	BSTR tmp_a_file_name = 0;
	tmp_a_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_file_name));
	
	hr = p_IEiffelCompletionInfo->initialize_feature(tmp_a_name,*(VARIANT*)a_arguments,*(VARIANT*)a_argument_types,tmp_a_return_type,tmp_a_feature_type,tmp_a_file_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_name);
rt_ce.free_memory_bstr (tmp_a_return_type);
rt_ce.free_memory_bstr (tmp_a_file_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_eiffel_compiler::IEiffelCompletionInfo_impl_proxy::ccom_item()

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