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

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::system_classes(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * some_classes )

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
		*some_classes = grt_ec_ISE.ccom_ec_pointed_interface_39 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*some_classes = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::class_count(  /* [out, retval] */ ULONG * return_value )

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
	*return_value = (ULONG)tmp_value;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::system_clusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumCluster * * some_clusters )

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
		*some_clusters = grt_ec_ISE.ccom_ec_pointed_interface_43 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*some_clusters = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::external_clusters(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumCluster * * some_clusters )

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
		*some_clusters = grt_ec_ISE.ccom_ec_pointed_interface_43 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*some_clusters = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::assemblies(  /* [out, retval] */ ecom_EiffelComCompiler::IEnumAssembly * * return_value )

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
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_46 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::cluster_count(  /* [out, retval] */ ULONG * return_value )

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
	*return_value = (ULONG)tmp_value;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::root_cluster(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClusterDescriptor * * return_value )

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
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_50 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::cluster_descriptor(  /* [in] */ BSTR cluster_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClusterDescriptor * * return_value )

/*-----------------------------------------------------------
	Cluster descriptor.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_cluster_name = NULL;
	if (cluster_name != NULL)
	{
		tmp_cluster_name = eif_protect (rt_ce.ccom_ce_bstr (cluster_name));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("cluster_descriptor", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_cluster_name != NULL) ? eif_access (tmp_cluster_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "cluster_descriptor", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_50 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	if (tmp_cluster_name != NULL)
		eif_wean (tmp_cluster_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::class_descriptor(  /* [in] */ BSTR class_name1, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelClassDescriptor * * return_value )

/*-----------------------------------------------------------
	Class descriptor.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_class_name1 = NULL;
	if (class_name1 != NULL)
	{
		tmp_class_name1 = eif_protect (rt_ce.ccom_ce_bstr (class_name1));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("class_descriptor", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_class_name1 != NULL) ? eif_access (tmp_class_name1) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "class_descriptor", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_53 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	if (tmp_class_name1 != NULL)
		eif_wean (tmp_class_name1);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::feature_descriptor(  /* [in] */ BSTR class_name1, /* [in] */ BSTR feature_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * return_value )

/*-----------------------------------------------------------
	Feature descriptor.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_class_name1 = NULL;
	if (class_name1 != NULL)
	{
		tmp_class_name1 = eif_protect (rt_ce.ccom_ce_bstr (class_name1));
	}
	EIF_OBJECT tmp_feature_name = NULL;
	if (feature_name != NULL)
	{
		tmp_feature_name = eif_protect (rt_ce.ccom_ce_bstr (feature_name));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("feature_descriptor", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_class_name1 != NULL) ? eif_access (tmp_class_name1) : NULL), ((tmp_feature_name != NULL) ? eif_access (tmp_feature_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "feature_descriptor", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_56 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	if (tmp_class_name1 != NULL)
		eif_wean (tmp_class_name1);
	if (tmp_feature_name != NULL)
		eif_wean (tmp_feature_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::search_classes(  /* [in] */ BSTR a_string, /* [in] */ VARIANT_BOOL is_substring, /* [out, retval] */ ecom_EiffelComCompiler::IEnumEiffelClass * * some_classes )

/*-----------------------------------------------------------
	Search classes with names matching `a_string'.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_string = NULL;
	if (a_string != NULL)
	{
		tmp_a_string = eif_protect (rt_ce.ccom_ce_bstr (a_string));
	}
	EIF_BOOLEAN tmp_is_substring = rt_ce.ccom_ce_boolean (is_substring);
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("search_classes", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE, EIF_BOOLEAN))eiffel_function) (eif_access (eiffel_object), ((tmp_a_string != NULL) ? eif_access (tmp_a_string) : NULL), (EIF_BOOLEAN)tmp_is_substring);
	else
		tmp_value = eif_field (eif_access (eiffel_object), "search_classes", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*some_classes = grt_ec_ISE.ccom_ec_pointed_interface_39 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*some_classes = NULL;
	if (tmp_a_string != NULL)
		eif_wean (tmp_a_string);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::search_features(  /* [in] */ BSTR a_string, /* [in] */ VARIANT_BOOL is_substring, /* [out, retval] */ ecom_EiffelComCompiler::IEnumFeature * * some_features )

/*-----------------------------------------------------------
	Search feature with names matching `a_string'.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_string = NULL;
	if (a_string != NULL)
	{
		tmp_a_string = eif_protect (rt_ce.ccom_ce_bstr (a_string));
	}
	EIF_BOOLEAN tmp_is_substring = rt_ce.ccom_ce_boolean (is_substring);
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("search_features", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE, EIF_BOOLEAN))eiffel_function) (eif_access (eiffel_object), ((tmp_a_string != NULL) ? eif_access (tmp_a_string) : NULL), (EIF_BOOLEAN)tmp_is_substring);
	else
		tmp_value = eif_field (eif_access (eiffel_object), "search_features", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*some_features = grt_ec_ISE.ccom_ec_pointed_interface_59 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*some_features = NULL;
	if (tmp_a_string != NULL)
		eif_wean (tmp_a_string);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::description_from_dotnet_type(  /* [in] */ BSTR a_assembly_name, /* [in] */ BSTR a_full_dotnet_type, /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Retrieve description from dotnet type
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_assembly_name = NULL;
	if (a_assembly_name != NULL)
	{
		tmp_a_assembly_name = eif_protect (rt_ce.ccom_ce_bstr (a_assembly_name));
	}
	EIF_OBJECT tmp_a_full_dotnet_type = NULL;
	if (a_full_dotnet_type != NULL)
	{
		tmp_a_full_dotnet_type = eif_protect (rt_ce.ccom_ce_bstr (a_full_dotnet_type));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("description_from_dotnet_type", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_a_assembly_name != NULL) ? eif_access (tmp_a_assembly_name) : NULL), ((tmp_a_full_dotnet_type != NULL) ? eif_access (tmp_a_full_dotnet_type) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "description_from_dotnet_type", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	if (tmp_a_assembly_name != NULL)
		eif_wean (tmp_a_assembly_name);
	if (tmp_a_full_dotnet_type != NULL)
		eif_wean (tmp_a_full_dotnet_type);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelSystemBrowser_impl_stub::description_from_dotnet_feature(  /* [in] */ BSTR a_assembly_name, /* [in] */ BSTR a_full_dotnet_type, /* [in] */ BSTR a_feature_signature, /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Retrieve description from dotnet feature
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_assembly_name = NULL;
	if (a_assembly_name != NULL)
	{
		tmp_a_assembly_name = eif_protect (rt_ce.ccom_ce_bstr (a_assembly_name));
	}
	EIF_OBJECT tmp_a_full_dotnet_type = NULL;
	if (a_full_dotnet_type != NULL)
	{
		tmp_a_full_dotnet_type = eif_protect (rt_ce.ccom_ce_bstr (a_full_dotnet_type));
	}
	EIF_OBJECT tmp_a_feature_signature = NULL;
	if (a_feature_signature != NULL)
	{
		tmp_a_feature_signature = eif_protect (rt_ce.ccom_ce_bstr (a_feature_signature));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("description_from_dotnet_feature", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_a_assembly_name != NULL) ? eif_access (tmp_a_assembly_name) : NULL), ((tmp_a_full_dotnet_type != NULL) ? eif_access (tmp_a_full_dotnet_type) : NULL), ((tmp_a_feature_signature != NULL) ? eif_access (tmp_a_feature_signature) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "description_from_dotnet_feature", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	if (tmp_a_assembly_name != NULL)
		eif_wean (tmp_a_assembly_name);
	if (tmp_a_full_dotnet_type != NULL)
		eif_wean (tmp_a_full_dotnet_type);
	if (tmp_a_feature_signature != NULL)
		eif_wean (tmp_a_feature_signature);
	
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