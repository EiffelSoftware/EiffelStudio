/*-----------------------------------------------------------
Implemented `IEiffelSystemAssemblies' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelSystemAssemblies_impl_proxy_s.h"
static const IID IID_IEiffelSystemAssemblies_ = {0x85662941,0x227e,0x42cb,{0xbc,0x91,0xf4,0xc1,0x7d,0x41,0x07,0xe2}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::IEiffelSystemAssemblies_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEiffelSystemAssemblies_, (void **)&p_IEiffelSystemAssemblies);
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

ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::~IEiffelSystemAssemblies_impl_proxy()
{
	p_unknown->Release ();
	
	CoTaskMemFree ((void *)excepinfo);
	if (p_IEiffelSystemAssemblies!=NULL)
		p_IEiffelSystemAssemblies->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_last_error_code()

/*-----------------------------------------------------------
	Last error code
-----------------------------------------------------------*/
{
	return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_last_source_of_exception()

/*-----------------------------------------------------------
	Last source of exception
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_last_error_description()

/*-----------------------------------------------------------
	Last error description
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_last_error_help_file()

/*-----------------------------------------------------------
	Last error help file
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_store()

/*-----------------------------------------------------------
	Save changes.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemAssemblies == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemAssemblies_, (void **)&p_IEiffelSystemAssemblies);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IEiffelSystemAssemblies->store ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_add_assembly(  /* [in] */ EIF_OBJECT assembly_prefix,  /* [in] */ EIF_OBJECT cluster_name,  /* [in] */ EIF_OBJECT a_name,  /* [in] */ EIF_OBJECT a_version,  /* [in] */ EIF_OBJECT a_culture,  /* [in] */ EIF_OBJECT a_publickey )

/*-----------------------------------------------------------
	Add a signed assembly to the project.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemAssemblies == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemAssemblies_, (void **)&p_IEiffelSystemAssemblies);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_assembly_prefix = 0;
	tmp_assembly_prefix = (BSTR)rt_ec.ccom_ec_bstr (eif_access (assembly_prefix));
	BSTR tmp_cluster_name = 0;
	tmp_cluster_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (cluster_name));
	BSTR tmp_a_name = 0;
	tmp_a_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_name));
	BSTR tmp_a_version = 0;
	tmp_a_version = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_version));
	BSTR tmp_a_culture = 0;
	tmp_a_culture = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_culture));
	BSTR tmp_a_publickey = 0;
	tmp_a_publickey = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_publickey));
	
	hr = p_IEiffelSystemAssemblies->add_assembly(tmp_assembly_prefix,tmp_cluster_name,tmp_a_name,tmp_a_version,tmp_a_culture,tmp_a_publickey);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_assembly_prefix);
rt_ce.free_memory_bstr (tmp_cluster_name);
rt_ce.free_memory_bstr (tmp_a_name);
rt_ce.free_memory_bstr (tmp_a_version);
rt_ce.free_memory_bstr (tmp_a_culture);
rt_ce.free_memory_bstr (tmp_a_publickey);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_remove_assembly(  /* [in] */ EIF_OBJECT assembly_identifier )

/*-----------------------------------------------------------
	Remove an assembly from the project.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemAssemblies == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemAssemblies_, (void **)&p_IEiffelSystemAssemblies);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_assembly_identifier = 0;
	tmp_assembly_identifier = (BSTR)rt_ec.ccom_ec_bstr (eif_access (assembly_identifier));
	
	hr = p_IEiffelSystemAssemblies->remove_assembly(tmp_assembly_identifier);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_assembly_identifier);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_assembly_properties(  /* [in] */ EIF_OBJECT cluster_name )

/*-----------------------------------------------------------
	Assembly properties.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemAssemblies == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemAssemblies_, (void **)&p_IEiffelSystemAssemblies);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_cluster_name = 0;
	tmp_cluster_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (cluster_name));
	ecom_eiffel_compiler::IEiffelAssemblyProperties * ret_value = 0;
	
	hr = p_IEiffelSystemAssemblies->assembly_properties(tmp_cluster_name, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_cluster_name);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_191 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_is_valid_cluster_name(  /* [in] */ EIF_OBJECT cluster_name )

/*-----------------------------------------------------------
	Checks to see if a assembly cluster name is valid
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemAssemblies == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemAssemblies_, (void **)&p_IEiffelSystemAssemblies);
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
	
	hr = p_IEiffelSystemAssemblies->is_valid_cluster_name(tmp_cluster_name, &ret_value);
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

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_contains_assembly(  /* [in] */ EIF_OBJECT cluster_name )

/*-----------------------------------------------------------
	Checks to see if a assembly cluster name has already been added to the project
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemAssemblies == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemAssemblies_, (void **)&p_IEiffelSystemAssemblies);
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
	
	hr = p_IEiffelSystemAssemblies->contains_assembly(tmp_cluster_name, &ret_value);
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

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_contains_gac_assembly(  /* [in] */ EIF_OBJECT a_name,  /* [in] */ EIF_OBJECT a_version,  /* [in] */ EIF_OBJECT a_culture,  /* [in] */ EIF_OBJECT a_publickey )

/*-----------------------------------------------------------
	Checks to see if a signed assembly has already been added to the project
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemAssemblies == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemAssemblies_, (void **)&p_IEiffelSystemAssemblies);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_a_name = 0;
	tmp_a_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_name));
	BSTR tmp_a_version = 0;
	tmp_a_version = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_version));
	BSTR tmp_a_culture = 0;
	tmp_a_culture = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_culture));
	BSTR tmp_a_publickey = 0;
	tmp_a_publickey = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_publickey));
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelSystemAssemblies->contains_gac_assembly(tmp_a_name,tmp_a_version,tmp_a_culture,tmp_a_publickey, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_name);
rt_ce.free_memory_bstr (tmp_a_version);
rt_ce.free_memory_bstr (tmp_a_culture);
rt_ce.free_memory_bstr (tmp_a_publickey);

	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_contains_local_assembly(  /* [in] */ EIF_OBJECT a_path )

/*-----------------------------------------------------------
	Checks to see if a unsigned assembly has already been added to the project
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemAssemblies == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemAssemblies_, (void **)&p_IEiffelSystemAssemblies);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_a_path = 0;
	tmp_a_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_path));
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelSystemAssemblies->contains_local_assembly(tmp_a_path, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_path);

	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_cluster_name_from_gac_assembly(  /* [in] */ EIF_OBJECT a_name,  /* [in] */ EIF_OBJECT a_version,  /* [in] */ EIF_OBJECT a_culture,  /* [in] */ EIF_OBJECT a_publickey )

/*-----------------------------------------------------------
	Retrieves the cluster name for a signed assembly in the project
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemAssemblies == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemAssemblies_, (void **)&p_IEiffelSystemAssemblies);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_a_name = 0;
	tmp_a_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_name));
	BSTR tmp_a_version = 0;
	tmp_a_version = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_version));
	BSTR tmp_a_culture = 0;
	tmp_a_culture = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_culture));
	BSTR tmp_a_publickey = 0;
	tmp_a_publickey = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_publickey));
	BSTR ret_value = 0;
	
	hr = p_IEiffelSystemAssemblies->cluster_name_from_gac_assembly(tmp_a_name,tmp_a_version,tmp_a_culture,tmp_a_publickey, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_name);
rt_ce.free_memory_bstr (tmp_a_version);
rt_ce.free_memory_bstr (tmp_a_culture);
rt_ce.free_memory_bstr (tmp_a_publickey);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_cluster_name_from_local_assembly(  /* [in] */ EIF_OBJECT a_path )

/*-----------------------------------------------------------
	Retrieves the cluster name for a unsigned assembly in the project
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemAssemblies == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemAssemblies_, (void **)&p_IEiffelSystemAssemblies);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_a_path = 0;
	tmp_a_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_path));
	BSTR ret_value = 0;
	
	hr = p_IEiffelSystemAssemblies->cluster_name_from_local_assembly(tmp_a_path, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_path);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_is_valid_prefix(  /* [in] */ EIF_OBJECT assembly_prefix )

/*-----------------------------------------------------------
	Is 'prefix' a valid assembly prefix
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemAssemblies == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemAssemblies_, (void **)&p_IEiffelSystemAssemblies);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_assembly_prefix = 0;
	tmp_assembly_prefix = (BSTR)rt_ec.ccom_ec_bstr (eif_access (assembly_prefix));
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelSystemAssemblies->is_valid_prefix(tmp_assembly_prefix, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_assembly_prefix);

	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_is_prefix_allocated(  /* [in] */ EIF_OBJECT assembly_prefix )

/*-----------------------------------------------------------
	Has the 'prefix' already been allocated to another assembly
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemAssemblies == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemAssemblies_, (void **)&p_IEiffelSystemAssemblies);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_assembly_prefix = 0;
	tmp_assembly_prefix = (BSTR)rt_ec.ccom_ec_bstr (eif_access (assembly_prefix));
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelSystemAssemblies->is_prefix_allocated(tmp_assembly_prefix, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_assembly_prefix);

	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_assemblies(  )

/*-----------------------------------------------------------
	Returns all of the assemblies in an enumerator
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemAssemblies == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemAssemblies_, (void **)&p_IEiffelSystemAssemblies);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_eiffel_compiler::IEnumAssembly * ret_value = 0;
	
	hr = p_IEiffelSystemAssemblies->assemblies( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_202 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_eiffel_compiler::IEiffelSystemAssemblies_impl_proxy::ccom_item()

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