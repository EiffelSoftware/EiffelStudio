/*-----------------------------------------------------------
Implemented `IEiffelSystemClusters' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEiffelSystemClusters_impl_proxy.h"
static const IID IID_IEiffelSystemClusters_ = {0xcd49d55e,0x5467,0x4058,{0xa9,0x99,0x1d,0x35,0xb9,0x05,0x76,0x4e}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::IEiffelSystemClusters_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEiffelSystemClusters_, (void **)&p_IEiffelSystemClusters);
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

ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::~IEiffelSystemClusters_impl_proxy()
{
	p_unknown->Release ();
	
	CoTaskMemFree ((void *)excepinfo);
	if (p_IEiffelSystemClusters!=NULL)
		p_IEiffelSystemClusters->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_last_error_code()

/*-----------------------------------------------------------
	Last error code
-----------------------------------------------------------*/
{
	return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_last_source_of_exception()

/*-----------------------------------------------------------
	Last source of exception
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_last_error_description()

/*-----------------------------------------------------------
	Last error description
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_last_error_help_file()

/*-----------------------------------------------------------
	Last error help file
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_get_cluster_tree(  )

/*-----------------------------------------------------------
	Retrieve enumerator of clusters in tree form.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemClusters == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemClusters_, (void **)&p_IEiffelSystemClusters);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEnumClusterProp * ret_value = 0;
	
	hr = p_IEiffelSystemClusters->GetClusterTree( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_182 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_get_all_clusters(  )

/*-----------------------------------------------------------
	Retrieve enumerator of all defined clusters.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemClusters == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemClusters_, (void **)&p_IEiffelSystemClusters);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEnumClusterProp * ret_value = 0;
	
	hr = p_IEiffelSystemClusters->GetAllClusters( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_182 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_get_cluster_full_name(  /* [in] */ EIF_OBJECT bstr_name )

/*-----------------------------------------------------------
	Get a clusters full name from its name.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemClusters == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemClusters_, (void **)&p_IEiffelSystemClusters);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_name = 0;
	tmp_bstr_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_name));
	BSTR ret_value = 0;
	
	hr = p_IEiffelSystemClusters->GetClusterFullName(tmp_bstr_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_name);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_get_cluster_properties(  /* [in] */ EIF_OBJECT bstr_name )

/*-----------------------------------------------------------
	Retrieve a clusters properties by its name.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemClusters == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemClusters_, (void **)&p_IEiffelSystemClusters);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_name = 0;
	tmp_bstr_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_name));
	ecom_EiffelComCompiler::IEiffelClusterProperties * ret_value = 0;
	
	hr = p_IEiffelSystemClusters->GetClusterProperties(tmp_bstr_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_name);

	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_186 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_get_cluster_properties_by_id(  /* [in] */ EIF_INTEGER n_cluster_id )

/*-----------------------------------------------------------
	Retrieve a clusters properties by its ID.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemClusters == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemClusters_, (void **)&p_IEiffelSystemClusters);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_n_cluster_id = 0;
	tmp_n_cluster_id = (ULONG)n_cluster_id;
	ecom_EiffelComCompiler::IEiffelClusterProperties * ret_value = 0;
	
	hr = p_IEiffelSystemClusters->GetClusterPropertiesById(tmp_n_cluster_id, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_186 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_change_cluster_name(  /* [in] */ EIF_OBJECT bstr_name,  /* [in] */ EIF_OBJECT bstr_new_name )

/*-----------------------------------------------------------
	Change a clusters name.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemClusters == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemClusters_, (void **)&p_IEiffelSystemClusters);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_name = 0;
	tmp_bstr_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_name));
	BSTR tmp_bstr_new_name = 0;
	tmp_bstr_new_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_new_name));
	
	hr = p_IEiffelSystemClusters->ChangeClusterName(tmp_bstr_name,tmp_bstr_new_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_name);
rt_ce.free_memory_bstr (tmp_bstr_new_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_add_cluster(  /* [in] */ EIF_OBJECT bstr_name,  /* [in] */ EIF_OBJECT bstr_parent_name,  /* [in] */ EIF_OBJECT bstr_path )

/*-----------------------------------------------------------
	Add a cluster to system clusters.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemClusters == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemClusters_, (void **)&p_IEiffelSystemClusters);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_name = 0;
	tmp_bstr_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_name));
	BSTR tmp_bstr_parent_name = 0;
	tmp_bstr_parent_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_parent_name));
	BSTR tmp_bstr_path = 0;
	tmp_bstr_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_path));
	
	hr = p_IEiffelSystemClusters->AddCluster(tmp_bstr_name,tmp_bstr_parent_name,tmp_bstr_path);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_name);
rt_ce.free_memory_bstr (tmp_bstr_parent_name);
rt_ce.free_memory_bstr (tmp_bstr_path);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_remove_cluster(  /* [in] */ EIF_OBJECT bstr_name )

/*-----------------------------------------------------------
	Remove a cluster from system clusters.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemClusters == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemClusters_, (void **)&p_IEiffelSystemClusters);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_name = 0;
	tmp_bstr_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_name));
	
	hr = p_IEiffelSystemClusters->RemoveCluster(tmp_bstr_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_store()

/*-----------------------------------------------------------
	Persist current changes to disk
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemClusters == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemClusters_, (void **)&p_IEiffelSystemClusters);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IEiffelSystemClusters->Store ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_is_cluster_name_available(  /* [in] */ EIF_OBJECT bstr_name )

/*-----------------------------------------------------------
	Determins if 'bstrName' is available as a cluster name
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemClusters == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemClusters_, (void **)&p_IEiffelSystemClusters);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_name = 0;
	tmp_bstr_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_name));
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelSystemClusters->IsClusterNameAvailable(tmp_bstr_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_name);

	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_is_valid_cluster_name(  /* [in] */ EIF_OBJECT bstr_name )

/*-----------------------------------------------------------
	Validates a cluster name
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemClusters == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemClusters_, (void **)&p_IEiffelSystemClusters);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_name = 0;
	tmp_bstr_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_name));
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelSystemClusters->IsValidClusterName(tmp_bstr_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_name);

	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_EiffelComCompiler::IEiffelSystemClusters_impl_proxy::ccom_item()

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