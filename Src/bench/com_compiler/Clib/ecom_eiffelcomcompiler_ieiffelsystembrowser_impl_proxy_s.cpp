/*-----------------------------------------------------------
Implemented `IEiffelSystemBrowser' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEiffelSystemBrowser_impl_proxy_s.h"
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
	
	hr = p_IEiffelSystemBrowser->system_classes( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_39 (ret_value));
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
	
	hr = p_IEiffelSystemBrowser->class_count( &ret_value);
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
	
	hr = p_IEiffelSystemBrowser->system_clusters( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_43 (ret_value));
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
	
	hr = p_IEiffelSystemBrowser->external_clusters( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_43 (ret_value));
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
	
	hr = p_IEiffelSystemBrowser->assemblies( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_46 (ret_value));
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
	
	hr = p_IEiffelSystemBrowser->cluster_count( &ret_value);
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
	
	hr = p_IEiffelSystemBrowser->root_cluster( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_50 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_cluster_descriptor(  /* [in] */ EIF_OBJECT cluster_name )

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
	BSTR tmp_cluster_name = 0;
	tmp_cluster_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (cluster_name));
	ecom_EiffelComCompiler::IEiffelClusterDescriptor * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->cluster_descriptor(tmp_cluster_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_cluster_name);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_50 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_class_descriptor(  /* [in] */ EIF_OBJECT class_name1 )

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
	BSTR tmp_class_name1 = 0;
	tmp_class_name1 = (BSTR)rt_ec.ccom_ec_bstr (eif_access (class_name1));
	ecom_EiffelComCompiler::IEiffelClassDescriptor * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->class_descriptor(tmp_class_name1, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_class_name1);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_53 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_feature_descriptor(  /* [in] */ EIF_OBJECT class_name1,  /* [in] */ EIF_OBJECT feature_name )

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
	BSTR tmp_class_name1 = 0;
	tmp_class_name1 = (BSTR)rt_ec.ccom_ec_bstr (eif_access (class_name1));
	BSTR tmp_feature_name = 0;
	tmp_feature_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (feature_name));
	ecom_EiffelComCompiler::IEiffelFeatureDescriptor * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->feature_descriptor(tmp_class_name1,tmp_feature_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_class_name1);
rt_ce.free_memory_bstr (tmp_feature_name);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_56 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_search_classes(  /* [in] */ EIF_OBJECT a_string,  /* [in] */ EIF_BOOLEAN is_substring )

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
	BSTR tmp_a_string = 0;
	tmp_a_string = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_string));
	VARIANT_BOOL tmp_is_substring = 0;
	tmp_is_substring = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_substring);
	ecom_EiffelComCompiler::IEnumEiffelClass * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->search_classes(tmp_a_string,tmp_is_substring, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_string);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_39 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_search_features(  /* [in] */ EIF_OBJECT a_string,  /* [in] */ EIF_BOOLEAN is_substring )

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
	BSTR tmp_a_string = 0;
	tmp_a_string = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_string));
	VARIANT_BOOL tmp_is_substring = 0;
	tmp_is_substring = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_substring);
	ecom_EiffelComCompiler::IEnumFeature * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->search_features(tmp_a_string,tmp_is_substring, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_string);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_59 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_description_from_dotnet_type(  /* [in] */ EIF_OBJECT a_assembly_name,  /* [in] */ EIF_OBJECT a_full_dotnet_type )

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
	BSTR tmp_a_assembly_name = 0;
	tmp_a_assembly_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_assembly_name));
	BSTR tmp_a_full_dotnet_type = 0;
	tmp_a_full_dotnet_type = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_full_dotnet_type));
	BSTR ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->description_from_dotnet_type(tmp_a_assembly_name,tmp_a_full_dotnet_type, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_assembly_name);
rt_ce.free_memory_bstr (tmp_a_full_dotnet_type);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_proxy::ccom_description_from_dotnet_feature(  /* [in] */ EIF_OBJECT a_assembly_name,  /* [in] */ EIF_OBJECT a_full_dotnet_type,  /* [in] */ EIF_OBJECT a_feature_signature )

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
	BSTR tmp_a_assembly_name = 0;
	tmp_a_assembly_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_assembly_name));
	BSTR tmp_a_full_dotnet_type = 0;
	tmp_a_full_dotnet_type = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_full_dotnet_type));
	BSTR tmp_a_feature_signature = 0;
	tmp_a_feature_signature = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_feature_signature));
	BSTR ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->description_from_dotnet_feature(tmp_a_assembly_name,tmp_a_full_dotnet_type,tmp_a_feature_signature, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_assembly_name);
rt_ce.free_memory_bstr (tmp_a_full_dotnet_type);
rt_ce.free_memory_bstr (tmp_a_feature_signature);

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