/*-----------------------------------------------------------
Implemented `IEiffelClusterProperties' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelClusterProperties_impl_proxy_s.h"
static const IID IID_IEiffelClusterProperties_ = {0x5d0b0013,0xf831,0x4ff6,{0xa4,0x43,0x7b,0x30,0x88,0x2a,0x5e,0xb8}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::IEiffelClusterProperties_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
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

ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::~IEiffelClusterProperties_impl_proxy()
{
	p_unknown->Release ();
	
	CoTaskMemFree ((void *)excepinfo);
	if (p_IEiffelClusterProperties!=NULL)
		p_IEiffelClusterProperties->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_last_error_code()

/*-----------------------------------------------------------
	Last error code
-----------------------------------------------------------*/
{
	return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_last_source_of_exception()

/*-----------------------------------------------------------
	Last source of exception
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_last_error_description()

/*-----------------------------------------------------------
	Last error description
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_last_error_help_file()

/*-----------------------------------------------------------
	Last error help file
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_name(  )

/*-----------------------------------------------------------
	Cluster name.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelClusterProperties->name( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_cluster_path(  )

/*-----------------------------------------------------------
	Full path to cluster.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelClusterProperties->cluster_path( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_set_cluster_path(  /* [in] */ EIF_OBJECT path )

/*-----------------------------------------------------------
	Full path to cluster.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_path = 0;
	tmp_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (path));
	
	hr = p_IEiffelClusterProperties->set_cluster_path(tmp_path);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_path);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_override(  )

/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->override( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_set_override(  /* [in] */ EIF_BOOLEAN return_value )

/*-----------------------------------------------------------
	Should this cluster classes take priority over other classes with same name?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_return_value = 0;
	tmp_return_value = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (return_value);
	
	hr = p_IEiffelClusterProperties->set_override(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_is_library(  )

/*-----------------------------------------------------------
	Should this cluster be treated as library?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->is_library( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_set_is_library(  /* [in] */ EIF_BOOLEAN return_value )

/*-----------------------------------------------------------
	Should this cluster be treated as library?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_return_value = 0;
	tmp_return_value = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (return_value);
	
	hr = p_IEiffelClusterProperties->set_is_library(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_all1(  )

/*-----------------------------------------------------------
	Should all subclusters be included?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->all( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_set_all(  /* [in] */ EIF_BOOLEAN return_value )

/*-----------------------------------------------------------
	Should all subclusters be included?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_return_value = 0;
	tmp_return_value = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (return_value);
	
	hr = p_IEiffelClusterProperties->set_all(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_use_system_default(  )

/*-----------------------------------------------------------
	Should use system default?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->use_system_default( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_set_use_system_default(  /* [in] */ EIF_BOOLEAN return_value )

/*-----------------------------------------------------------
	Should use system default?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_return_value = 0;
	tmp_return_value = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (return_value);
	
	hr = p_IEiffelClusterProperties->set_use_system_default(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_evaluate_require_by_default(  )

/*-----------------------------------------------------------
	Should preconditions be evaluated by default?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->evaluate_require_by_default( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_evaluate_ensure_by_default(  )

/*-----------------------------------------------------------
	Should postconditions be evaluated by default?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->evaluate_ensure_by_default( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_evaluate_check_by_default(  )

/*-----------------------------------------------------------
	Should check assertions be evaluated by default?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->evaluate_check_by_default( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_evaluate_loop_by_default(  )

/*-----------------------------------------------------------
	Should loop assertions be evaluated by default?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->evaluate_loop_by_default( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_evaluate_invariant_by_default(  )

/*-----------------------------------------------------------
	Should class invariants be evaluated by default?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->evaluate_invariant_by_default( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_set_assertions(  /* [in] */ EIF_BOOLEAN evaluate_check,  /* [in] */ EIF_BOOLEAN evaluate_require,  /* [in] */ EIF_BOOLEAN evaluate_ensure,  /* [in] */ EIF_BOOLEAN evaluate_loop,  /* [in] */ EIF_BOOLEAN evaluate_invariant )

/*-----------------------------------------------------------
	Set assertions for cluster.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_evaluate_check = 0;
	tmp_evaluate_check = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (evaluate_check);
	VARIANT_BOOL tmp_evaluate_require = 0;
	tmp_evaluate_require = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (evaluate_require);
	VARIANT_BOOL tmp_evaluate_ensure = 0;
	tmp_evaluate_ensure = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (evaluate_ensure);
	VARIANT_BOOL tmp_evaluate_loop = 0;
	tmp_evaluate_loop = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (evaluate_loop);
	VARIANT_BOOL tmp_evaluate_invariant = 0;
	tmp_evaluate_invariant = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (evaluate_invariant);
	
	hr = p_IEiffelClusterProperties->set_assertions(tmp_evaluate_check,tmp_evaluate_require,tmp_evaluate_ensure,tmp_evaluate_loop,tmp_evaluate_invariant);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_excluded(  )

/*-----------------------------------------------------------
	List of excluded directories.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_eiffel_compiler::IEnumClusterExcludes * ret_value = 0;
	
	hr = p_IEiffelClusterProperties->excluded( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_149 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_add_exclude(  /* [in] */ EIF_OBJECT dir_name )

/*-----------------------------------------------------------
	Add a directory to exclude.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_dir_name = 0;
	tmp_dir_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (dir_name));
	
	hr = p_IEiffelClusterProperties->add_exclude(tmp_dir_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_dir_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_remove_exclude(  /* [in] */ EIF_OBJECT dir_name )

/*-----------------------------------------------------------
	Remove a directory to exclude.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_dir_name = 0;
	tmp_dir_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (dir_name));
	
	hr = p_IEiffelClusterProperties->remove_exclude(tmp_dir_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_dir_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_parent_name(  )

/*-----------------------------------------------------------
	Name of the parent cluster.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelClusterProperties->parent_name( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_set_parent_name(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	Name of the parent cluster.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelClusterProperties->set_parent_name(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_has_parent(  )

/*-----------------------------------------------------------
	Does the current cluster have a parent cluster?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->has_parent( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_subclusters(  )

/*-----------------------------------------------------------
	List of subclusters (list of IEiffelClusterProperties*).
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_eiffel_compiler::IEnumClusterProp * ret_value = 0;
	
	hr = p_IEiffelClusterProperties->subclusters( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_129 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_has_children(  )

/*-----------------------------------------------------------
	Does the current cluster have children?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->has_children( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_cluster_id(  )

/*-----------------------------------------------------------
	Cluster identifier.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG ret_value = 0;
	
	hr = p_IEiffelClusterProperties->cluster_id( &ret_value);
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

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_is_eiffel_library(  )

/*-----------------------------------------------------------
	Is the cluster in the Eiffel library
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->is_eiffel_library( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_expanded_cluster_path(  )

/*-----------------------------------------------------------
	Full path to cluster with ISE_EIFFEL env var expanded.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelClusterProperties->expanded_cluster_path( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_cluster_path_exists(  )

/*-----------------------------------------------------------
	Does the path to the cluster exsit
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->cluster_path_exists( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_create_cluster_path(  )

/*-----------------------------------------------------------
	Create the cluster path if it doesnt exist
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->create_cluster_path( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_all_cluster_path_not_excluded(  )

/*-----------------------------------------------------------
	Does parent cluster have all set and does the cluster path extend upon the parents
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelClusterProperties->all_cluster_path_not_excluded( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_cluster_namespace(  )

/*-----------------------------------------------------------
	Cluster namespace.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelClusterProperties->cluster_namespace( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_set_cluster_namespace(  /* [in] */ EIF_OBJECT a_namespace )

/*-----------------------------------------------------------
	Cluster namespace.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelClusterProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelClusterProperties_, (void **)&p_IEiffelClusterProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_a_namespace = 0;
	tmp_a_namespace = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_namespace));
	
	hr = p_IEiffelClusterProperties->set_cluster_namespace(tmp_a_namespace);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_namespace);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_eiffel_compiler::IEiffelClusterProperties_impl_proxy::ccom_item()

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