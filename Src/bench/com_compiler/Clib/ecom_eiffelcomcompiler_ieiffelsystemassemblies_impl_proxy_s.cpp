/*-----------------------------------------------------------
Implemented `IEiffelSystemAssemblies' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEiffelSystemAssemblies_impl_proxy_s.h"
static const IID IID_IEiffelSystemAssemblies_ = {0x9cf82ea0,0xb5f9,0x4110,{0xa7,0x58,0x24,0x1a,0x3b,0xc9,0x5d,0x52}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEiffelSystemAssemblies_impl_proxy::IEiffelSystemAssemblies_impl_proxy( IUnknown * a_pointer )
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

ecom_EiffelComCompiler::IEiffelSystemAssemblies_impl_proxy::~IEiffelSystemAssemblies_impl_proxy()
{
	p_unknown->Release ();
	
	CoTaskMemFree ((void *)excepinfo);
	if (p_IEiffelSystemAssemblies!=NULL)
		p_IEiffelSystemAssemblies->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelComCompiler::IEiffelSystemAssemblies_impl_proxy::ccom_last_error_code()

/*-----------------------------------------------------------
	Last error code
-----------------------------------------------------------*/
{
	return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemAssemblies_impl_proxy::ccom_last_source_of_exception()

/*-----------------------------------------------------------
	Last source of exception
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemAssemblies_impl_proxy::ccom_last_error_description()

/*-----------------------------------------------------------
	Last error description
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemAssemblies_impl_proxy::ccom_last_error_help_file()

/*-----------------------------------------------------------
	Last error help file
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelSystemAssemblies_impl_proxy::ccom_wipe_out()

/*-----------------------------------------------------------
	Wipe out current list of assemblies
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
	hr = p_IEiffelSystemAssemblies->wipe_out ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelSystemAssemblies_impl_proxy::ccom_add_assembly(  /* [in] */ EIF_OBJECT a_prefix,  /* [in] */ EIF_OBJECT a_cluster_name,  /* [in] */ EIF_OBJECT a_path,  /* [in] */ EIF_BOOLEAN a_copy )

/*-----------------------------------------------------------
	Add an assembly to the project.
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
	BSTR tmp_a_prefix = 0;
	tmp_a_prefix = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_prefix));
	BSTR tmp_a_cluster_name = 0;
	tmp_a_cluster_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_cluster_name));
	BSTR tmp_a_path = 0;
	tmp_a_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_path));
	VARIANT_BOOL tmp_a_copy = 0;
	tmp_a_copy = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (a_copy);
	
	hr = p_IEiffelSystemAssemblies->add_assembly(tmp_a_prefix,tmp_a_cluster_name,tmp_a_path,tmp_a_copy);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_prefix);
rt_ce.free_memory_bstr (tmp_a_cluster_name);
rt_ce.free_memory_bstr (tmp_a_path);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelSystemAssemblies_impl_proxy::ccom_last_exception(  )

/*-----------------------------------------------------------
	Last execption to occur
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
	ecom_EiffelComCompiler::IEiffelException * ret_value = 0;
	
	hr = p_IEiffelSystemAssemblies->last_exception( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_6 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelSystemAssemblies_impl_proxy::ccom_store()

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
	hr = p_IEiffelSystemAssemblies->Store ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_EiffelComCompiler::IEiffelSystemAssemblies_impl_proxy::ccom_item()

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