/*-----------------------------------------------------------
Implemented `IEiffelProject' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEiffelProject_impl_proxy_s.h"
static const IID IID_IEiffelProject_ = {0x3afea5ea,0x1aed,0x489b,{0x9e,0x8a,0xe3,0x53,0x42,0x58,0x2b,0x2b}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEiffelProject_impl_proxy::IEiffelProject_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelProject_impl_proxy::~IEiffelProject_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEiffelProject!=NULL)
		p_IEiffelProject->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_retrieve_eiffel_project(  /* [in] */ EIF_OBJECT bstr_project_file_name )

/*-----------------------------------------------------------
	Retrieve Eiffel Project
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_project_file_name = 0;
	tmp_bstr_project_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_project_file_name));
	
	hr = p_IEiffelProject->RetrieveEiffelProject(tmp_bstr_project_file_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_project_file_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_create_eiffel_project(  /* [in] */ EIF_OBJECT bstr_ace_file_name,  /* [in] */ EIF_OBJECT bstr_project_directory )

/*-----------------------------------------------------------
	Create new Eiffel project from an existing ace file.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_ace_file_name = 0;
	tmp_bstr_ace_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_ace_file_name));
	BSTR tmp_bstr_project_directory = 0;
	tmp_bstr_project_directory = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_project_directory));
	
	hr = p_IEiffelProject->CreateEiffelProject(tmp_bstr_ace_file_name,tmp_bstr_project_directory);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_ace_file_name);
rt_ce.free_memory_bstr (tmp_bstr_project_directory);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_generate_new_eiffel_project(  /* [in] */ EIF_OBJECT bstr_project_name,  /* [in] */ EIF_OBJECT bstr_ace_file_name,  /* [in] */ EIF_OBJECT bstr_root_class_name,  /* [in] */ EIF_OBJECT bstr_creation_routine,  /* [in] */ EIF_OBJECT bstr_project_directory )

/*-----------------------------------------------------------
	Create new Eiffel project from scratch.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_project_name = 0;
	tmp_bstr_project_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_project_name));
	BSTR tmp_bstr_ace_file_name = 0;
	tmp_bstr_ace_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_ace_file_name));
	BSTR tmp_bstr_root_class_name = 0;
	tmp_bstr_root_class_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_root_class_name));
	BSTR tmp_bstr_creation_routine = 0;
	tmp_bstr_creation_routine = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_creation_routine));
	BSTR tmp_bstr_project_directory = 0;
	tmp_bstr_project_directory = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_project_directory));
	
	hr = p_IEiffelProject->GenerateNewEiffelProject(tmp_bstr_project_name,tmp_bstr_ace_file_name,tmp_bstr_root_class_name,tmp_bstr_creation_routine,tmp_bstr_project_directory);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_project_name);
rt_ce.free_memory_bstr (tmp_bstr_ace_file_name);
rt_ce.free_memory_bstr (tmp_bstr_root_class_name);
rt_ce.free_memory_bstr (tmp_bstr_creation_routine);
rt_ce.free_memory_bstr (tmp_bstr_project_directory);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_project_file_name(  )

/*-----------------------------------------------------------
	Full path to .epr file.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProject->ProjectFileName( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_ace_file_name(  )

/*-----------------------------------------------------------
	Full path to Ace file.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProject->AceFileName( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_project_directory(  )

/*-----------------------------------------------------------
	Project directory.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProject->ProjectDirectory( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_is_valid_project(  )

/*-----------------------------------------------------------
	Is project valid?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelProject->IsValidProject( &ret_value);
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

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_last_exception(  )

/*-----------------------------------------------------------
	Last exception raised
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEiffelException * ret_value = 0;
	
	hr = p_IEiffelProject->LastException( &ret_value);
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

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_compiler(  )

/*-----------------------------------------------------------
	Compiler.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEiffelCompiler * ret_value = 0;
	
	hr = p_IEiffelProject->Compiler( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_9 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_is_compiled(  )

/*-----------------------------------------------------------
	Has system been compiled?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelProject->IsCompiled( &ret_value);
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

EIF_BOOLEAN ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_project_has_updated(  )

/*-----------------------------------------------------------
	Has the project updated since last compilation?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelProject->ProjectHasUpdated( &ret_value);
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

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_system_browser(  )

/*-----------------------------------------------------------
	System Browser.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEiffelSystemBrowser * ret_value = 0;
	
	hr = p_IEiffelProject->SystemBrowser( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_14 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_project_properties(  )

/*-----------------------------------------------------------
	Project Properties.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEiffelProjectProperties * ret_value = 0;
	
	hr = p_IEiffelProject->ProjectProperties( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_17 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_completion_information(  )

/*-----------------------------------------------------------
	Completion information
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEiffelCompletionInfo * ret_value = 0;
	
	hr = p_IEiffelProject->CompletionInformation( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_20 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_html_documentation_generator(  )

/*-----------------------------------------------------------
	Help documentation generator
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProject == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProject_, (void **)&p_IEiffelProject);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator * ret_value = 0;
	
	hr = p_IEiffelProject->HtmlDocumentationGenerator( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_OBJECT eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_23 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_EiffelComCompiler::IEiffelProject_impl_proxy::ccom_item()

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