/*-----------------------------------------------------------
Implemented `IEiffelSystemBrowser' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEiffelSystemBrowser_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IEiffelSystemBrowser_ = {0xafb76625,0x6f73,0x442c,{0x9c,0xae,0x1b,0x98,0x14,0x14,0x05,0x0d}};

static const IID LIBID_EiffelComCompiler_ = {0x06b5d7c0,0x2c7d,0x4d1c,{0xa9,0x8b,0x45,0x99,0xbd,0xcd,0xfa,0x58}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::IEiffelSystemBrowser_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
	pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::~IEiffelSystemBrowser_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	if (pTypeInfo)
		pTypeInfo->Release ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::SystemClasses(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class )

/*-----------------------------------------------------------
	List of classes in system.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("system_classes", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "system_classes", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ienum_eiffel_class = grt_ec_ISE.ccom_ec_pointed_interface_38 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ienum_eiffel_class = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::ClassCount(  /* [out, retval] */ ULONG * pul_class_count )

/*-----------------------------------------------------------
	Number of classes in system.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_INTEGER_FUNCTION eiffel_function = 0;
	eiffel_function = eif_integer_function ("class_count", type_id);
	EIF_INTEGER tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "class_count", EIF_INTEGER);
	*pul_class_count = (ULONG)tmp_value;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::SystemClusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumCluster * * pp_ienum_cluster )

/*-----------------------------------------------------------
	List of system's clusters.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("system_clusters", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "system_clusters", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ienum_cluster = grt_ec_ISE.ccom_ec_pointed_interface_42 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ienum_cluster = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::ExternalClusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumCluster * * pp_ienum_cluster )

/*-----------------------------------------------------------
	List of system's external clusters.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("external_clusters", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "external_clusters", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ienum_cluster = grt_ec_ISE.ccom_ec_pointed_interface_42 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ienum_cluster = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::Assemblies(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumAssembly * * pp_ienum_assembly )

/*-----------------------------------------------------------
	Returns all of the assemblies in an enumerator
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("assemblies", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "assemblies", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ienum_assembly = grt_ec_ISE.ccom_ec_pointed_interface_45 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ienum_assembly = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::ClusterCount(  /* [out, retval] */ ULONG * pul_cluster_count )

/*-----------------------------------------------------------
	Number of top-level clusters in system.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_INTEGER_FUNCTION eiffel_function = 0;
	eiffel_function = eif_integer_function ("cluster_count", type_id);
	EIF_INTEGER tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "cluster_count", EIF_INTEGER);
	*pul_cluster_count = (ULONG)tmp_value;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::RootCluster(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClusterDescriptor * * pp_ieiffel_cluster_descriptor )

/*-----------------------------------------------------------
	Number of top-level clusters in system.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("root_cluster", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "root_cluster", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ieiffel_cluster_descriptor = grt_ec_ISE.ccom_ec_pointed_interface_49 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ieiffel_cluster_descriptor = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::ClusterDescriptor(  /* [in] */ BSTR bstr_class_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClusterDescriptor * * pp_ieiffel_cluster_descriptor )

/*-----------------------------------------------------------
	Cluster descriptor.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_class_name = NULL;
	if (bstr_class_name != NULL)
	{
		tmp_bstr_class_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_class_name));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("cluster_descriptor", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_bstr_class_name != NULL) ? eif_access (tmp_bstr_class_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "cluster_descriptor", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ieiffel_cluster_descriptor = grt_ec_ISE.ccom_ec_pointed_interface_49 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ieiffel_cluster_descriptor = NULL;
	if (tmp_bstr_class_name != NULL)
		eif_wean (tmp_bstr_class_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::ClassDescriptor(  /* [in] */ BSTR bstr_cluster_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClassDescriptor * * pp_ieiffel_class_descriptor )

/*-----------------------------------------------------------
	Class descriptor.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_cluster_name = NULL;
	if (bstr_cluster_name != NULL)
	{
		tmp_bstr_cluster_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_cluster_name));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("class_descriptor", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_bstr_cluster_name != NULL) ? eif_access (tmp_bstr_cluster_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "class_descriptor", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ieiffel_class_descriptor = grt_ec_ISE.ccom_ec_pointed_interface_52 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ieiffel_class_descriptor = NULL;
	if (tmp_bstr_cluster_name != NULL)
		eif_wean (tmp_bstr_cluster_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::FeatureDescriptor(  /* [in] */ BSTR bstr_class_name, /* [in] */ BSTR bstr_feature_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * pp_ieiffel_feature_descriptor )

/*-----------------------------------------------------------
	Feature descriptor.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_class_name = NULL;
	if (bstr_class_name != NULL)
	{
		tmp_bstr_class_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_class_name));
	}
	EIF_OBJECT tmp_bstr_feature_name = NULL;
	if (bstr_feature_name != NULL)
	{
		tmp_bstr_feature_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_feature_name));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("feature_descriptor", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_bstr_class_name != NULL) ? eif_access (tmp_bstr_class_name) : NULL), ((tmp_bstr_feature_name != NULL) ? eif_access (tmp_bstr_feature_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "feature_descriptor", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ieiffel_feature_descriptor = grt_ec_ISE.ccom_ec_pointed_interface_55 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ieiffel_feature_descriptor = NULL;
	if (tmp_bstr_class_name != NULL)
		eif_wean (tmp_bstr_class_name);
	if (tmp_bstr_feature_name != NULL)
		eif_wean (tmp_bstr_feature_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::SearchClasses(  /* [in] */ BSTR bstr_search_str, /* [in] */ VARIANT_BOOL vb_is_substring, /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * pp_ienum_eiffel_class )

/*-----------------------------------------------------------
	Search classes with names matching `a_string'.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_search_str = NULL;
	if (bstr_search_str != NULL)
	{
		tmp_bstr_search_str = eif_protect (rt_ce.ccom_ce_bstr (bstr_search_str));
	}
	EIF_BOOLEAN tmp_vb_is_substring = rt_ce.ccom_ce_boolean (vb_is_substring);
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("search_classes", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE, EIF_BOOLEAN))eiffel_function) (eif_access (eiffel_object), ((tmp_bstr_search_str != NULL) ? eif_access (tmp_bstr_search_str) : NULL), (EIF_BOOLEAN)tmp_vb_is_substring);
	else
		tmp_value = eif_field (eif_access (eiffel_object), "search_classes", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ienum_eiffel_class = grt_ec_ISE.ccom_ec_pointed_interface_38 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ienum_eiffel_class = NULL;
	if (tmp_bstr_search_str != NULL)
		eif_wean (tmp_bstr_search_str);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::SearchFeatures(  /* [in] */ BSTR bstr_search_str, /* [in] */ VARIANT_BOOL vb_is_substring, /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature )

/*-----------------------------------------------------------
	Search feature with names matching `a_string'.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_search_str = NULL;
	if (bstr_search_str != NULL)
	{
		tmp_bstr_search_str = eif_protect (rt_ce.ccom_ce_bstr (bstr_search_str));
	}
	EIF_BOOLEAN tmp_vb_is_substring = rt_ce.ccom_ce_boolean (vb_is_substring);
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("search_features", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE, EIF_BOOLEAN))eiffel_function) (eif_access (eiffel_object), ((tmp_bstr_search_str != NULL) ? eif_access (tmp_bstr_search_str) : NULL), (EIF_BOOLEAN)tmp_vb_is_substring);
	else
		tmp_value = eif_field (eif_access (eiffel_object), "search_features", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ienum_feature = grt_ec_ISE.ccom_ec_pointed_interface_58 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ienum_feature = NULL;
	if (tmp_bstr_search_str != NULL)
		eif_wean (tmp_bstr_search_str);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::DescriptionFromDotnetType(  /* [in] */ BSTR bstr_assembly_name, /* [in] */ BSTR bstr_full_dotnet_name, /* [out, retval] */ BSTR * pbstr_description )

/*-----------------------------------------------------------
	Retrieve description from dotnet type
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_assembly_name = NULL;
	if (bstr_assembly_name != NULL)
	{
		tmp_bstr_assembly_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_assembly_name));
	}
	EIF_OBJECT tmp_bstr_full_dotnet_name = NULL;
	if (bstr_full_dotnet_name != NULL)
	{
		tmp_bstr_full_dotnet_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_full_dotnet_name));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("description_from_dotnet_type", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_bstr_assembly_name != NULL) ? eif_access (tmp_bstr_assembly_name) : NULL), ((tmp_bstr_full_dotnet_name != NULL) ? eif_access (tmp_bstr_full_dotnet_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "description_from_dotnet_type", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pbstr_description = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pbstr_description = NULL;
	if (tmp_bstr_assembly_name != NULL)
		eif_wean (tmp_bstr_assembly_name);
	if (tmp_bstr_full_dotnet_name != NULL)
		eif_wean (tmp_bstr_full_dotnet_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::DescriptionFromDotnetFeature(  /* [in] */ BSTR bstr_assembly_name, /* [in] */ BSTR bstr_full_dotnet_name, /* [in] */ BSTR bstr_feature_signature, /* [out, retval] */ BSTR * pbstr_description )

/*-----------------------------------------------------------
	Retrieve description from dotnet feature
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_assembly_name = NULL;
	if (bstr_assembly_name != NULL)
	{
		tmp_bstr_assembly_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_assembly_name));
	}
	EIF_OBJECT tmp_bstr_full_dotnet_name = NULL;
	if (bstr_full_dotnet_name != NULL)
	{
		tmp_bstr_full_dotnet_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_full_dotnet_name));
	}
	EIF_OBJECT tmp_bstr_feature_signature = NULL;
	if (bstr_feature_signature != NULL)
	{
		tmp_bstr_feature_signature = eif_protect (rt_ce.ccom_ce_bstr (bstr_feature_signature));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("description_from_dotnet_feature", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_bstr_assembly_name != NULL) ? eif_access (tmp_bstr_assembly_name) : NULL), ((tmp_bstr_full_dotnet_name != NULL) ? eif_access (tmp_bstr_full_dotnet_name) : NULL), ((tmp_bstr_feature_signature != NULL) ? eif_access (tmp_bstr_feature_signature) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "description_from_dotnet_feature", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pbstr_description = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pbstr_description = NULL;
	if (tmp_bstr_assembly_name != NULL)
		eif_wean (tmp_bstr_assembly_name);
	if (tmp_bstr_full_dotnet_name != NULL)
		eif_wean (tmp_bstr_full_dotnet_name);
	if (tmp_bstr_feature_signature != NULL)
		eif_wean (tmp_bstr_feature_signature);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo )

/*-----------------------------------------------------------
	Get type info
-----------------------------------------------------------*/
{
	if ((itinfo != 0) || (pptinfo == NULL))
		return E_INVALIDARG;
	*pptinfo = NULL;
	if (pTypeInfo == 0)
	{
		HRESULT tmp_hr = 0;
		ITypeLib *pTypeLib = 0;
		tmp_hr = LoadRegTypeLib (LIBID_EiffelComCompiler_, 2, 0, 0, &pTypeLib);
		if (FAILED(tmp_hr))
			return tmp_hr;
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelSystemBrowser_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	(*pptinfo = pTypeInfo)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::GetTypeInfoCount( unsigned int * pctinfo )

/*-----------------------------------------------------------
	Get type info count
-----------------------------------------------------------*/
{
	if (pctinfo == NULL)
		return E_NOTIMPL;
	*pctinfo = 1;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid )

/*-----------------------------------------------------------
	IDs of function names 'rgszNames'
-----------------------------------------------------------*/
{
	if (pTypeInfo == 0)
	{
		HRESULT tmp_hr = 0;
		ITypeLib *pTypeLib = 0;
		tmp_hr = LoadRegTypeLib (LIBID_EiffelComCompiler_, 2, 0, 0, &pTypeLib);
		if (FAILED(tmp_hr))
			return tmp_hr;
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelSystemBrowser_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	return pTypeInfo->GetIDsOfNames (rgszNames, cNames, rgdispid);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr )

/*-----------------------------------------------------------
	Invoke function.
-----------------------------------------------------------*/
{
	HRESULT hr = 0;
	int i = 0;

	unsigned int uArgErr;
	if (wFlags & ~(DISPATCH_METHOD | DISPATCH_PROPERTYGET | DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
		return ResultFromScode (E_INVALIDARG);

	if (puArgErr == NULL)
		puArgErr = &uArgErr;

	VARIANTARG * rgvarg = pDispParams->rgvarg;
	DISPID * rgdispidNamedArgs = pDispParams->rgdispidNamedArgs;
	unsigned int cArgs = pDispParams->cArgs;
	unsigned int cNamedArgs = pDispParams->cNamedArgs;
	VARIANTARG ** tmp_value = NULL;

	if (pExcepInfo != NULL)
	{
		pExcepInfo->wCode = 0;
		pExcepInfo->wReserved = 0;
		pExcepInfo->bstrSource = NULL;
		pExcepInfo->bstrDescription = NULL;
		pExcepInfo->bstrHelpFile = NULL;
		pExcepInfo->dwHelpContext = 0;
		pExcepInfo->pvReserved = NULL;
		pExcepInfo->pfnDeferredFillIn = NULL;
		pExcepInfo->scode = 0;
	}
	
	switch (dispID)
	{
		
		default:
			return DISP_E_MEMBERNOTFOUND;
	}
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	UnlockModule ();
	LONG res = InterlockedDecrement (&ref_count);
	if (res  ==  0)
	{
		if (pTypeInfo !=NULL)
		{
			pTypeInfo->Release ();
			pTypeInfo = NULL;
		}
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelSystemBrowser*>(this);
	else if (riid == IID_IDispatch)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelSystemBrowser*>(this);
	else if (riid == IID_IEiffelSystemBrowser_)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelSystemBrowser*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif