/*-----------------------------------------------------------
Implemented `IEiffelSystemBrowser' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEiffelSystemBrowser_impl_proxy.h"
static const IID IID_IEiffelSystemBrowser_ = {0xafb76625,0x6f73,0x442c,{0x9c,0xae,0x1b,0x98,0x14,0x14,0x05,0x0d}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::IEiffelSystemBrowser_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::~IEiffelSystemBrowser_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEiffelSystemBrowser!=NULL)
		p_IEiffelSystemBrowser->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_system_classes(  )

/*-----------------------------------------------------------
	List of classes in system.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEnumEiffelClass * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->SystemClasses( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_38 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_class_count(  )

/*-----------------------------------------------------------
	Number of classes in system.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->ClassCount( &ret_value);
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

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_system_clusters(  )

/*-----------------------------------------------------------
	List of system's clusters.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEnumCluster * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->SystemClusters( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_42 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_external_clusters(  )

/*-----------------------------------------------------------
	List of system's external clusters.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEnumCluster * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->ExternalClusters( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_42 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_assemblies(  )

/*-----------------------------------------------------------
	Returns all of the assemblies in an enumerator
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEnumAssembly * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->Assemblies( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_45 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_cluster_count(  )

/*-----------------------------------------------------------
	Number of top-level clusters in system.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->ClusterCount( &ret_value);
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

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_root_cluster(  )

/*-----------------------------------------------------------
	Number of top-level clusters in system.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEiffelClusterDescriptor * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->RootCluster( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_49 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_cluster_descriptor(  /* [in] */ EIF_OBJECT bstr_class_name )

/*-----------------------------------------------------------
	Cluster descriptor.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_class_name = 0;
	tmp_bstr_class_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_class_name));
	ecom_EiffelComCompiler::IEiffelClusterDescriptor * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->ClusterDescriptor(tmp_bstr_class_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_class_name);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_49 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_class_descriptor(  /* [in] */ EIF_OBJECT bstr_cluster_name )

/*-----------------------------------------------------------
	Class descriptor.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_cluster_name = 0;
	tmp_bstr_cluster_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_cluster_name));
	ecom_EiffelComCompiler::IEiffelClassDescriptor * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->ClassDescriptor(tmp_bstr_cluster_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_cluster_name);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_52 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_feature_descriptor(  /* [in] */ EIF_OBJECT bstr_class_name,  /* [in] */ EIF_OBJECT bstr_feature_name )

/*-----------------------------------------------------------
	Feature descriptor.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_class_name = 0;
	tmp_bstr_class_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_class_name));
	BSTR tmp_bstr_feature_name = 0;
	tmp_bstr_feature_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_feature_name));
	ecom_EiffelComCompiler::IEiffelFeatureDescriptor * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->FeatureDescriptor(tmp_bstr_class_name,tmp_bstr_feature_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_class_name);
rt_ce.free_memory_bstr (tmp_bstr_feature_name);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_55 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_search_classes(  /* [in] */ EIF_OBJECT bstr_search_str,  /* [in] */ EIF_BOOLEAN vb_is_substring )

/*-----------------------------------------------------------
	Search classes with names matching `a_string'.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_search_str = 0;
	tmp_bstr_search_str = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_search_str));
	VARIANT_BOOL tmp_vb_is_substring = 0;
	tmp_vb_is_substring = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (vb_is_substring);
	ecom_EiffelComCompiler::IEnumEiffelClass * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->SearchClasses(tmp_bstr_search_str,tmp_vb_is_substring, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_search_str);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_38 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_search_features(  /* [in] */ EIF_OBJECT bstr_search_str,  /* [in] */ EIF_BOOLEAN vb_is_substring )

/*-----------------------------------------------------------
	Search feature with names matching `a_string'.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_search_str = 0;
	tmp_bstr_search_str = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_search_str));
	VARIANT_BOOL tmp_vb_is_substring = 0;
	tmp_vb_is_substring = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (vb_is_substring);
	ecom_EiffelComCompiler::IEnumFeature * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->SearchFeatures(tmp_bstr_search_str,tmp_vb_is_substring, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_search_str);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_58 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_description_from_dotnet_type(  /* [in] */ EIF_OBJECT bstr_assembly_name,  /* [in] */ EIF_OBJECT bstr_full_dotnet_name )

/*-----------------------------------------------------------
	Retrieve description from dotnet type
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_assembly_name = 0;
	tmp_bstr_assembly_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_assembly_name));
	BSTR tmp_bstr_full_dotnet_name = 0;
	tmp_bstr_full_dotnet_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_full_dotnet_name));
	BSTR ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->DescriptionFromDotnetType(tmp_bstr_assembly_name,tmp_bstr_full_dotnet_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_assembly_name);
rt_ce.free_memory_bstr (tmp_bstr_full_dotnet_name);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_description_from_dotnet_feature(  /* [in] */ EIF_OBJECT bstr_assembly_name,  /* [in] */ EIF_OBJECT bstr_full_dotnet_name,  /* [in] */ EIF_OBJECT bstr_feature_signature )

/*-----------------------------------------------------------
	Retrieve description from dotnet feature
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemBrowser == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemBrowser_, (void **)&p_IEiffelSystemBrowser);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_assembly_name = 0;
	tmp_bstr_assembly_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_assembly_name));
	BSTR tmp_bstr_full_dotnet_name = 0;
	tmp_bstr_full_dotnet_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_full_dotnet_name));
	BSTR tmp_bstr_feature_signature = 0;
	tmp_bstr_feature_signature = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_feature_signature));
	BSTR ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->DescriptionFromDotnetFeature(tmp_bstr_assembly_name,tmp_bstr_full_dotnet_name,tmp_bstr_feature_signature, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_assembly_name);
rt_ce.free_memory_bstr (tmp_bstr_full_dotnet_name);
rt_ce.free_memory_bstr (tmp_bstr_feature_signature);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_item()

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