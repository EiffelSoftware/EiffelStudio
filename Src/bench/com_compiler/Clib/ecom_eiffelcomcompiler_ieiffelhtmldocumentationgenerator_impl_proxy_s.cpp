/*-----------------------------------------------------------
Implemented `IEiffelHtmlDocumentationGenerator' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEiffelHtmlDocumentationGenerator_impl_proxy_s.h"
static const IID IID_IEiffelHtmlDocumentationGenerator_ = {0x86270519,0x790f,0x48cb,{0x88,0x69,0xdb,0x06,0x18,0x4f,0x97,0xb4}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_proxy::IEiffelHtmlDocumentationGenerator_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEiffelHtmlDocumentationGenerator_, (void **)&p_IEiffelHtmlDocumentationGenerator);
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

ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_proxy::~IEiffelHtmlDocumentationGenerator_impl_proxy()
{
	p_unknown->Release ();
	
	CoTaskMemFree ((void *)excepinfo);
	if (p_IEiffelHtmlDocumentationGenerator!=NULL)
		p_IEiffelHtmlDocumentationGenerator->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_proxy::ccom_last_error_code()

/*-----------------------------------------------------------
	Last error code
-----------------------------------------------------------*/
{
	return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_proxy::ccom_last_source_of_exception()

/*-----------------------------------------------------------
	Last source of exception
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_proxy::ccom_last_error_description()

/*-----------------------------------------------------------
	Last error description
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_proxy::ccom_last_error_help_file()

/*-----------------------------------------------------------
	Last error help file
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_proxy::ccom_add_excluded_cluster(  /* [in] */ EIF_OBJECT bstr_full_cluster_name )

/*-----------------------------------------------------------
	Exclude a cluster from being generated.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHtmlDocumentationGenerator == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHtmlDocumentationGenerator_, (void **)&p_IEiffelHtmlDocumentationGenerator);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_full_cluster_name = 0;
	tmp_bstr_full_cluster_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_full_cluster_name));
	
	hr = p_IEiffelHtmlDocumentationGenerator->AddExcludedCluster(tmp_bstr_full_cluster_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_full_cluster_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_proxy::ccom_remove_excluded_cluster(  /* [in] */ EIF_OBJECT bstr_full_cluster_name )

/*-----------------------------------------------------------
	Include a cluster to be generated.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHtmlDocumentationGenerator == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHtmlDocumentationGenerator_, (void **)&p_IEiffelHtmlDocumentationGenerator);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_full_cluster_name = 0;
	tmp_bstr_full_cluster_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_full_cluster_name));
	
	hr = p_IEiffelHtmlDocumentationGenerator->RemoveExcludedCluster(tmp_bstr_full_cluster_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_full_cluster_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_proxy::ccom_start_generation(  /* [in] */ EIF_OBJECT bstr_generation_path )

/*-----------------------------------------------------------
	Generate the HTML documents into path.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHtmlDocumentationGenerator == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHtmlDocumentationGenerator_, (void **)&p_IEiffelHtmlDocumentationGenerator);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_generation_path = 0;
	tmp_bstr_generation_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_generation_path));
	
	hr = p_IEiffelHtmlDocumentationGenerator->StartGeneration(tmp_bstr_generation_path);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_generation_path);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_proxy::ccom_advise_status_callback(  /* [in] */ ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents * p_ieiffel_html_documentation_events )

/*-----------------------------------------------------------
	Add a callback interface.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHtmlDocumentationGenerator == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHtmlDocumentationGenerator_, (void **)&p_IEiffelHtmlDocumentationGenerator);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IEiffelHtmlDocumentationGenerator->AdviseStatusCallback(p_ieiffel_html_documentation_events);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_proxy::ccom_unadvise_status_callback(  /* [in] */ ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents * p_ieiffel_html_documentation_events )

/*-----------------------------------------------------------
	Remove a callback interface.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHtmlDocumentationGenerator == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHtmlDocumentationGenerator_, (void **)&p_IEiffelHtmlDocumentationGenerator);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p_IEiffelHtmlDocumentationGenerator->UnadviseStatusCallback(p_ieiffel_html_documentation_events);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_proxy::ccom_item()

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