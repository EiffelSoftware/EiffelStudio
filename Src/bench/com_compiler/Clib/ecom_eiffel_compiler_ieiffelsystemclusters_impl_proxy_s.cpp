/*-----------------------------------------------------------
Implemented `IEiffelSystemClusters' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelSystemClusters_impl_proxy_s.h"
static const IID IID_IEiffelSystemClusters_ = {0xcd49d55e,0x5467,0x4058,{0xa9,0x99,0x1d,0x35,0xb9,0x05,0x76,0x4e}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy::IEiffelSystemClusters_impl_proxy( IUnknown * a_pointer )
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

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy::~IEiffelSystemClusters_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEiffelSystemClusters!=NULL)
		p_IEiffelSystemClusters->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy::ccom_cluster_tree(  )

/*-----------------------------------------------------------
	Cluster tree.
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
	ecom_eiffel_compiler::IEnumClusterProp * ret_value = 0;
	
	hr = p_IEiffelSystemClusters->cluster_tree( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_183 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy::ccom_flat_clusters(  )

/*-----------------------------------------------------------
	Cluster in a flat form.
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
	ecom_eiffel_compiler::IEnumClusterProp * ret_value = 0;
	
	hr = p_IEiffelSystemClusters->flat_clusters( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_183 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy::ccom_store()

/*-----------------------------------------------------------
	Save changes.
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
	hr = p_IEiffelSystemClusters->store ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy::ccom_add_cluster(  /* [in] */ EIF_OBJECT cluster_name,  /* [in] */ EIF_OBJECT parent_name,  /* [in] */ EIF_OBJECT cluster_path )

/*-----------------------------------------------------------
	Add a cluster to the project.
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
	BSTR tmp_cluster_name = 0;
	tmp_cluster_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (cluster_name));
	BSTR tmp_parent_name = 0;
	tmp_parent_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (parent_name));
	BSTR tmp_cluster_path = 0;
	tmp_cluster_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (cluster_path));
	
	hr = p_IEiffelSystemClusters->add_cluster(tmp_cluster_name,tmp_parent_name,tmp_cluster_path);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_cluster_name);
rt_ce.free_memory_bstr (tmp_parent_name);
rt_ce.free_memory_bstr (tmp_cluster_path);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy::ccom_remove_cluster(  /* [in] */ EIF_OBJECT cluster_name )

/*-----------------------------------------------------------
	Remove a cluster from the project.
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
	BSTR tmp_cluster_name = 0;
	tmp_cluster_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (cluster_name));
	
	hr = p_IEiffelSystemClusters->remove_cluster(tmp_cluster_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_cluster_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy::ccom_cluster_properties(  /* [in] */ EIF_OBJECT cluster_name )

/*-----------------------------------------------------------
	Cluster properties.
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
	BSTR tmp_cluster_name = 0;
	tmp_cluster_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (cluster_name));
	ecom_eiffel_compiler::IEiffelClusterProperties * ret_value = 0;
	
	hr = p_IEiffelSystemClusters->cluster_properties(tmp_cluster_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_cluster_name);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_186 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy::ccom_cluster_properties_by_id(  /* [in] */ EIF_INTEGER cluster_id )

/*-----------------------------------------------------------
	Cluster properties.
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
	ULONG tmp_cluster_id = 0;
	tmp_cluster_id = (ULONG)cluster_id;
	ecom_eiffel_compiler::IEiffelClusterProperties * ret_value = 0;
	
	hr = p_IEiffelSystemClusters->cluster_properties_by_id(tmp_cluster_id, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_186 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy::ccom_change_cluster_name(  /* [in] */ EIF_OBJECT a_name,  /* [in] */ EIF_OBJECT a_new_name )

/*-----------------------------------------------------------
	Change cluster name.
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
	BSTR tmp_a_name = 0;
	tmp_a_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_name));
	BSTR tmp_a_new_name = 0;
	tmp_a_new_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_new_name));
	
	hr = p_IEiffelSystemClusters->change_cluster_name(tmp_a_name,tmp_a_new_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_name);
rt_ce.free_memory_bstr (tmp_a_new_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy::ccom_is_valid_name(  /* [in] */ EIF_OBJECT cluster_name )

/*-----------------------------------------------------------
	Checks to see if a cluster name is valid
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
	BSTR tmp_cluster_name = 0;
	tmp_cluster_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (cluster_name));
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelSystemClusters->is_valid_name(tmp_cluster_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_cluster_name);

	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy::ccom_get_cluster_fullname(  /* [in] */ EIF_OBJECT cluster_name )

/*-----------------------------------------------------------
	Retrieves a clusters full name from its name
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
	BSTR tmp_cluster_name = 0;
	tmp_cluster_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (cluster_name));
	BSTR ret_value = 0;
	
	hr = p_IEiffelSystemClusters->get_cluster_fullname(tmp_cluster_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_cluster_name);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_eiffel_compiler::IEiffelSystemClusters_impl_proxy::ccom_item()

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