/*-----------------------------------------------------------
Implemented `IEiffelSystemBrowser' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelSystemBrowser_impl_proxy_s.h"
static const IID IID_IEiffelSystemBrowser_ = {0xa4caf314,0x6659,0x48d8,{0xa6,0x8e,0x46,0x34,0x92,0xd7,0x9d,0x8a}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy::IEiffelSystemBrowser_impl_proxy( IUnknown * a_pointer )
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

ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy::~IEiffelSystemBrowser_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEiffelSystemBrowser!=NULL)
		p_IEiffelSystemBrowser->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy::ccom_system_classes(  )

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
	ecom_eiffel_compiler::IEnumClass * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->system_classes( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_Eif_compiler.ccom_ce_pointed_interface_19 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy::ccom_class_count(  )

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

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy::ccom_system_clusters(  )

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
	ecom_eiffel_compiler::IEnumCluster * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->system_clusters( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_Eif_compiler.ccom_ce_pointed_interface_23 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy::ccom_cluster_count(  )

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

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy::ccom_cluster_descriptor(  /* [in] */ EIF_OBJECT cluster_name )

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
	ecom_eiffel_compiler::IEiffelClusterDescriptor * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->cluster_descriptor(tmp_cluster_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_cluster_name);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_Eif_compiler.ccom_ce_pointed_interface_27 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy::ccom_class_descriptor(  /* [in] */ EIF_OBJECT class_name1 )

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
	ecom_eiffel_compiler::IEiffelClassDescriptor * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->class_descriptor(tmp_class_name1, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_class_name1);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_Eif_compiler.ccom_ce_pointed_interface_30 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy::ccom_feature_descriptor(  /* [in] */ EIF_OBJECT class_name1,  /* [in] */ EIF_OBJECT feature_name )

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
	ecom_eiffel_compiler::IEiffelFeatureDescriptor * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->feature_descriptor(tmp_class_name1,tmp_feature_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_class_name1);
rt_ce.free_memory_bstr (tmp_feature_name);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_Eif_compiler.ccom_ce_pointed_interface_33 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy::ccom_substring_search_classes(  /* [in] */ EIF_OBJECT a_string )

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
	ecom_eiffel_compiler::IEnumClass * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->substring_search_classes(tmp_a_string, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_string);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_Eif_compiler.ccom_ce_pointed_interface_19 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy::ccom_substring_search_features(  /* [in] */ EIF_OBJECT a_string )

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
	ecom_eiffel_compiler::IEnumFeature * ret_value = 0;
	
	hr = p_IEiffelSystemBrowser->substring_search_features(tmp_a_string, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_string);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_Eif_compiler.ccom_ce_pointed_interface_36 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_eiffel_compiler::IEiffelSystemBrowser_impl_proxy::ccom_item()

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