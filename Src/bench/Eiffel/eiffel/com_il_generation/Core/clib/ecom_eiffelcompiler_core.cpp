/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#include "ecom_EiffelCompiler_Core.h"
static const CLSID CLSID_Core_ = {0x9daf83a1,0x15d7,0x3a80,{0xab,0x8f,0x0e,0x03,0x4f,0x47,0x9c,0x3f}};

static const IID IID_ICore_ = {0x9f1ca01d,0xe32f,0x3689,{0x98,0x16,0x79,0xaf,0x32,0x02,0x17,0x8a}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelCompiler::Core::Core()
{
	HRESULT hr;
	hr = CoInitializeEx (NULL, COINIT_APARTMENTTHREADED);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	p_unknown = NULL;
	MULTI_QI a_qi = {&IID_IUnknown, NULL, 0};

	hr = CoCreateInstanceEx (CLSID_Core_, NULL, CLSCTX_INPROC_SERVER, NULL, 1, &a_qi);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	if (FAILED (a_qi.hr))
	{
		if ((HRESULT_FACILITY (a_qi.hr)  ==  FACILITY_ITF) && (HRESULT_CODE (a_qi.hr) > 1024) && (HRESULT_CODE (a_qi.hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (a_qi.hr) - 1024), NULL),HRESULT_CODE (a_qi.hr) - 1024);
		com_eraise (f.c_format_message (a_qi.hr), EN_PROG);
	};
	p_unknown = a_qi.pItf;

	p_ICore = 0;

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelCompiler::Core::Core( IUnknown * a_pointer )
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

	p_ICore = 0;
	hr = a_pointer->QueryInterface(IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelCompiler::Core::~Core()
{
	p_unknown->Release ();
	if (p_ICore!=NULL)
		p_ICore->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_set_console_application()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->SetConsoleApplication ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_set_window_application()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->SetWindowApplication ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_set_dll()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->SetDll ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_start_assembly_generation(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_OBJECT fname,  /* [in] */ EIF_OBJECT location )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	BSTR tmp_fname = 0;
	tmp_fname = (BSTR)rt_ec.ccom_ec_bstr (eif_access (fname));
	BSTR tmp_location = 0;
	tmp_location = (BSTR)rt_ec.ccom_ec_bstr (eif_access (location));
	
	hr = p_ICore->StartAssemblyGeneration(tmp_name,tmp_fname,tmp_location);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_name);
rt_ce.free_memory_bstr (tmp_fname);
rt_ce.free_memory_bstr (tmp_location);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_assembly_reference(  /* [in] */ EIF_OBJECT name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	
	hr = p_ICore->AddAssemblyReference(tmp_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_start_module_generation(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_BOOLEAN debug1 )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	VARIANT_BOOL tmp_debug1 = 0;
	tmp_debug1 = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (debug1);
	
	hr = p_ICore->StartModuleGeneration(tmp_name,tmp_debug1);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_end_assembly_generation()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->EndAssemblyGeneration ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_start_class_mappings(  /* [in] */ EIF_INTEGER class_count )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_class_count = 0;
	tmp_class_count = (LONG)class_count;
	
	hr = p_ICore->StartClassMappings(tmp_class_count);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_class_mappings(  /* [in] */ EIF_OBJECT class_name1,  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER interface_id,  /* [in] */ EIF_OBJECT source_file_name,  /* [in] */ EIF_OBJECT element_type_name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_class_name1 = 0;
	tmp_class_name1 = (BSTR)rt_ec.ccom_ec_bstr (eif_access (class_name1));
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	LONG tmp_interface_id = 0;
	tmp_interface_id = (LONG)interface_id;
	BSTR tmp_source_file_name = 0;
	tmp_source_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (source_file_name));
	BSTR tmp_element_type_name = 0;
	tmp_element_type_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (element_type_name));
	
	hr = p_ICore->GenerateClassMappings(tmp_class_name1,tmp_type_id,tmp_interface_id,tmp_source_file_name,tmp_element_type_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_class_name1);
rt_ce.free_memory_bstr (tmp_source_file_name);
rt_ce.free_memory_bstr (tmp_element_type_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_class_header(  /* [in] */ EIF_BOOLEAN is_interface,  /* [in] */ EIF_BOOLEAN is_deferred,  /* [in] */ EIF_BOOLEAN is_frozen,  /* [in] */ EIF_BOOLEAN is_expanded,  /* [in] */ EIF_BOOLEAN is_external,  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_is_interface = 0;
	tmp_is_interface = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_interface);
	VARIANT_BOOL tmp_is_deferred = 0;
	tmp_is_deferred = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_deferred);
	VARIANT_BOOL tmp_is_frozen = 0;
	tmp_is_frozen = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_frozen);
	VARIANT_BOOL tmp_is_expanded = 0;
	tmp_is_expanded = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_expanded);
	VARIANT_BOOL tmp_is_external = 0;
	tmp_is_external = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_external);
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->GenerateClassHeader(tmp_is_interface,tmp_is_deferred,tmp_is_frozen,tmp_is_expanded,tmp_is_external,tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_end_class()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->EndClass ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_to_parents_list(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->AddToParentsList(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_interface(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->AddInterface(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_eiffel_interface(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->AddEiffelInterface(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_end_parents_list()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->EndParentsList ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_start_features_list(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->StartFeaturesList(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_mark_invariant(  /* [in] */ EIF_INTEGER feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	
	hr = p_ICore->MarkInvariant(tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_mark_creation_routines(  /* [in] */ EIF_OBJECT feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	SAFEARRAY *  tmp_feature_id = 0;
	tmp_feature_id = (SAFEARRAY * )rt_ec.ccom_ec_safearray_long (eif_access (feature_id));
	
	hr = p_ICore->MarkCreationRoutines(tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_safearray (tmp_feature_id);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_start_feature_description(  /* [in] */ EIF_INTEGER arg_count )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_arg_count = 0;
	tmp_arg_count = (LONG)arg_count;
	
	hr = p_ICore->StartFeatureDescription(tmp_arg_count);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_interface_feature_identification(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_INTEGER feature_id,  /* [in] */ EIF_BOOLEAN is_attribute )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	VARIANT_BOOL tmp_is_attribute = 0;
	tmp_is_attribute = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_attribute);
	
	hr = p_ICore->GenerateInterfaceFeatureIdentification(tmp_name,tmp_feature_id,tmp_is_attribute);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_feature_identification(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_INTEGER feature_id,  /* [in] */ EIF_BOOLEAN is_redefined,  /* [in] */ EIF_BOOLEAN is_deferred,  /* [in] */ EIF_BOOLEAN is_frozen,  /* [in] */ EIF_BOOLEAN is_attribute,  /* [in] */ EIF_BOOLEAN is_c_external,  /* [in] */ EIF_BOOLEAN is_static )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	VARIANT_BOOL tmp_is_redefined = 0;
	tmp_is_redefined = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_redefined);
	VARIANT_BOOL tmp_is_deferred = 0;
	tmp_is_deferred = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_deferred);
	VARIANT_BOOL tmp_is_frozen = 0;
	tmp_is_frozen = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_frozen);
	VARIANT_BOOL tmp_is_attribute = 0;
	tmp_is_attribute = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_attribute);
	VARIANT_BOOL tmp_is_c_external = 0;
	tmp_is_c_external = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_c_external);
	VARIANT_BOOL tmp_is_static = 0;
	tmp_is_static = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_static);
	
	hr = p_ICore->GenerateFeatureIdentification(tmp_name,tmp_feature_id,tmp_is_redefined,tmp_is_deferred,tmp_is_frozen,tmp_is_attribute,tmp_is_c_external,tmp_is_static);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_external_identification(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_OBJECT com_name,  /* [in] */ EIF_INTEGER external_kind,  /* [in] */ EIF_INTEGER feature_id,  /* [in] */ EIF_INTEGER routine_id,  /* [in] */ EIF_BOOLEAN in_current_class,  /* [in] */ EIF_INTEGER written_type_id,  /* [in] */ EIF_OBJECT parameters,  /* [in] */ EIF_OBJECT return_type )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	BSTR tmp_com_name = 0;
	tmp_com_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (com_name));
	LONG tmp_external_kind = 0;
	tmp_external_kind = (LONG)external_kind;
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	LONG tmp_routine_id = 0;
	tmp_routine_id = (LONG)routine_id;
	VARIANT_BOOL tmp_in_current_class = 0;
	tmp_in_current_class = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (in_current_class);
	LONG tmp_written_type_id = 0;
	tmp_written_type_id = (LONG)written_type_id;
	SAFEARRAY *  tmp_parameters = 0;
	tmp_parameters = (SAFEARRAY * )rt_ec.ccom_ec_safearray_bstr (eif_access (parameters));
	BSTR tmp_return_type = 0;
	tmp_return_type = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_type));
	
	hr = p_ICore->GenerateExternalIdentification(tmp_name,tmp_com_name,tmp_external_kind,tmp_feature_id,tmp_routine_id,tmp_in_current_class,tmp_written_type_id,tmp_parameters,tmp_return_type);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_name);
rt_ce.free_memory_bstr (tmp_com_name);
rt_ce.free_memory_safearray (tmp_parameters);
rt_ce.free_memory_bstr (tmp_return_type);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_feature_return_type(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->GenerateFeatureReturnType(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_feature_argument(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->GenerateFeatureArgument(tmp_name,tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_create_feature_description()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->CreateFeatureDescription ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_define_entry_point(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	
	hr = p_ICore->DefineEntryPoint(tmp_type_id,tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelCompiler::Core::ccom_last_error(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_ICore->LastError( &ret_value);
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

void ecom_EiffelCompiler::Core::ccom_add_ca(  /* [in] */ EIF_INTEGER target_type_id,  /* [in] */ EIF_INTEGER attribute_type_id,  /* [in] */ EIF_INTEGER arg_count )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_target_type_id = 0;
	tmp_target_type_id = (LONG)target_type_id;
	LONG tmp_attribute_type_id = 0;
	tmp_attribute_type_id = (LONG)attribute_type_id;
	LONG tmp_arg_count = 0;
	tmp_arg_count = (LONG)arg_count;
	
	hr = p_ICore->AddCA(tmp_target_type_id,tmp_attribute_type_id,tmp_arg_count);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_class_ca()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateClassCA ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_feature_ca(  /* [in] */ EIF_INTEGER feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	
	hr = p_ICore->GenerateFeatureCA(tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_catyped_arg(  /* [in] */ EIF_INTEGER a_value,  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_a_value = 0;
	tmp_a_value = (LONG)a_value;
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->AddCATypedArg(tmp_a_value,tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_cainteger_arg(  /* [in] */ EIF_INTEGER a_value )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_a_value = 0;
	tmp_a_value = (LONG)a_value;
	
	hr = p_ICore->AddCAIntegerArg(tmp_a_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_castring_arg(  /* [in] */ EIF_OBJECT a_value )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_a_value = 0;
	tmp_a_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_value));
	
	hr = p_ICore->AddCAStringArg(tmp_a_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_careal_arg(  /* [in] */ EIF_REAL a_value )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	FLOAT tmp_a_value = 0;
	tmp_a_value = (FLOAT)a_value;
	
	hr = p_ICore->AddCARealArg(tmp_a_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_cadouble_arg(  /* [in] */ EIF_DOUBLE a_value )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	double tmp_a_value = 0;
	tmp_a_value = (double)a_value;
	
	hr = p_ICore->AddCADoubleArg(tmp_a_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_cacharacter_arg(  /* [in] */ EIF_INTEGER a_value )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	USHORT tmp_a_value = 0;
	tmp_a_value = (USHORT)a_value;
	
	hr = p_ICore->AddCACharacterArg(tmp_a_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_caboolean_arg(  /* [in] */ EIF_BOOLEAN a_value )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_a_value = 0;
	tmp_a_value = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (a_value);
	
	hr = p_ICore->AddCABooleanArg(tmp_a_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_caarray_integer_arg(  /* [in] */ EIF_OBJECT a_value )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	SAFEARRAY *  tmp_a_value = 0;
	tmp_a_value = (SAFEARRAY * )rt_ec.ccom_ec_safearray_long (eif_access (a_value));
	
	hr = p_ICore->AddCAArrayIntegerArg(tmp_a_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_safearray (tmp_a_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_caarray_string_arg(  /* [in] */ EIF_OBJECT a_value )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	SAFEARRAY *  tmp_a_value = 0;
	tmp_a_value = (SAFEARRAY * )rt_ec.ccom_ec_safearray_bstr (eif_access (a_value));
	
	hr = p_ICore->AddCAArrayStringArg(tmp_a_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_safearray (tmp_a_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_caarray_real_arg(  /* [in] */ EIF_OBJECT a_value )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	SAFEARRAY *  tmp_a_value = 0;
	tmp_a_value = (SAFEARRAY * )rt_ec.ccom_ec_safearray_float (eif_access (a_value));
	
	hr = p_ICore->AddCAArrayRealArg(tmp_a_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_safearray (tmp_a_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_caarray_double_arg(  /* [in] */ EIF_OBJECT a_value )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	SAFEARRAY *  tmp_a_value = 0;
	tmp_a_value = (SAFEARRAY * )rt_ec.ccom_ec_safearray_double (eif_access (a_value));
	
	hr = p_ICore->AddCAArrayDoubleArg(tmp_a_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_safearray (tmp_a_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_caarray_character_arg(  /* [in] */ EIF_OBJECT a_value )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	SAFEARRAY *  tmp_a_value = 0;
	tmp_a_value = (SAFEARRAY * )rt_ec.ccom_ec_safearray_short (eif_access (a_value));
	
	hr = p_ICore->AddCAArrayCharacterArg(tmp_a_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_safearray (tmp_a_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_add_caarray_boolean_arg(  /* [in] */ EIF_OBJECT a_value )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	SAFEARRAY *  tmp_a_value = 0;
	tmp_a_value = (SAFEARRAY * )rt_ec.ccom_ec_safearray_boolean (eif_access (a_value));
	
	hr = p_ICore->AddCAArrayBooleanArg(tmp_a_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_safearray (tmp_a_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_start_il_generation(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->StartIlGeneration(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_feature_il(  /* [in] */ EIF_INTEGER feature_id,  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER code_feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	LONG tmp_code_feature_id = 0;
	tmp_code_feature_id = (LONG)code_feature_id;
	
	hr = p_ICore->GenerateFeatureIL(tmp_feature_id,tmp_type_id,tmp_code_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_feature_internal_clone(  /* [in] */ EIF_INTEGER feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	
	hr = p_ICore->GenerateFeatureInternalClone(tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_implementation_feature_il(  /* [in] */ EIF_INTEGER feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	
	hr = p_ICore->GenerateImplementationFeatureIL(tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_method_impl(  /* [in] */ EIF_INTEGER feature_id,  /* [in] */ EIF_INTEGER parent_type_id,  /* [in] */ EIF_INTEGER parent_feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	LONG tmp_parent_type_id = 0;
	tmp_parent_type_id = (LONG)parent_type_id;
	LONG tmp_parent_feature_id = 0;
	tmp_parent_feature_id = (LONG)parent_feature_id;
	
	hr = p_ICore->GenerateMethodImpl(tmp_feature_id,tmp_parent_type_id,tmp_parent_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_creation_feature_il(  /* [in] */ EIF_INTEGER feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	
	hr = p_ICore->GenerateCreationFeatureIL(tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_external_call(  /* [in] */ EIF_OBJECT external_type_name,  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_INTEGER external_kind,  /* [in] */ EIF_OBJECT parameter_types,  /* [in] */ EIF_OBJECT return_type,  /* [in] */ EIF_BOOLEAN is_virtual,  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_external_type_name = 0;
	tmp_external_type_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (external_type_name));
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	LONG tmp_external_kind = 0;
	tmp_external_kind = (LONG)external_kind;
	SAFEARRAY *  tmp_parameter_types = 0;
	tmp_parameter_types = (SAFEARRAY * )rt_ec.ccom_ec_safearray_bstr (eif_access (parameter_types));
	BSTR tmp_return_type = 0;
	tmp_return_type = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_type));
	VARIANT_BOOL tmp_is_virtual = 0;
	tmp_is_virtual = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_virtual);
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	
	hr = p_ICore->GenerateExternalCall(tmp_external_type_name,tmp_name,tmp_external_kind,tmp_parameter_types,tmp_return_type,tmp_is_virtual,tmp_type_id,tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_external_type_name);
rt_ce.free_memory_bstr (tmp_name);
rt_ce.free_memory_safearray (tmp_parameter_types);
rt_ce.free_memory_bstr (tmp_return_type);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_put_result_info(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->PutResultInfo(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_put_local_info(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_OBJECT name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	
	hr = p_ICore->PutLocalInfo(tmp_type_id,tmp_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_create_like_current_object()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->CreateLikeCurrentObject ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_create_object(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->CreateObject(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_create_attribute_object(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	
	hr = p_ICore->CreateAttributeObject(tmp_type_id,tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_set_eiffel_type(  /* [in] */ EIF_INTEGER exported_type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_exported_type_id = 0;
	tmp_exported_type_id = (LONG)exported_type_id;
	
	hr = p_ICore->SetEiffelType(tmp_exported_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_duplicate_top()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->DuplicateTop ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_pop()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->Pop ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_metamorphose(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->GenerateMetamorphose(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_unmetamorphose(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->GenerateUnmetamorphose(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_check_cast(  /* [in] */ EIF_INTEGER source_type_id,  /* [in] */ EIF_INTEGER target_type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_source_type_id = 0;
	tmp_source_type_id = (LONG)source_type_id;
	LONG tmp_target_type_id = 0;
	tmp_target_type_id = (LONG)target_type_id;
	
	hr = p_ICore->GenerateCheckCast(tmp_source_type_id,tmp_target_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_convert_to_native_int()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->ConvertToNativeInt ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_convert_to_boolean()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->ConvertToBoolean ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_convert_to_character()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->ConvertToCharacter ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_convert_to_integer8()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->ConvertToInteger8 ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_convert_to_integer16()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->ConvertToInteger16 ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_convert_to_integer32()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->ConvertToInteger32 ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_convert_to_integer64()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->ConvertToInteger64 ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_convert_to_double()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->ConvertToDouble ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_convert_to_real()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->ConvertToReal ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_current()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateCurrent ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_result()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateResult ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_attribute(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	
	hr = p_ICore->GenerateAttribute(tmp_type_id,tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_feature_access(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id,  /* [in] */ EIF_BOOLEAN is_virtual )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	VARIANT_BOOL tmp_is_virtual = 0;
	tmp_is_virtual = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (is_virtual);
	
	hr = p_ICore->GenerateFeatureAccess(tmp_type_id,tmp_feature_id,tmp_is_virtual);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_precursor_feature_access(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	
	hr = p_ICore->GeneratePrecursorFeatureAccess(tmp_type_id,tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_put_method_token(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	
	hr = p_ICore->PutMethodToken(tmp_type_id,tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_argument(  /* [in] */ EIF_INTEGER n )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_n = 0;
	tmp_n = (LONG)n;
	
	hr = p_ICore->GenerateArgument(tmp_n);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_local(  /* [in] */ EIF_INTEGER n )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_n = 0;
	tmp_n = (LONG)n;
	
	hr = p_ICore->GenerateLocal(tmp_n);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_in_assertion_test(  /* [in] */ EIF_INTEGER end_of_assert_label )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_end_of_assert_label = 0;
	tmp_end_of_assert_label = (LONG)end_of_assert_label;
	
	hr = p_ICore->GenerateInAssertionTest(tmp_end_of_assert_label);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_set_assertion_status()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateSetAssertionStatus ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_restore_assertion_status()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateRestoreAssertionStatus ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_assertion_check(  /* [in] */ EIF_INTEGER assert_type,  /* [in] */ EIF_OBJECT tag )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_assert_type = 0;
	tmp_assert_type = (LONG)assert_type;
	BSTR tmp_tag = 0;
	tmp_tag = (BSTR)rt_ec.ccom_ec_bstr (eif_access (tag));
	
	hr = p_ICore->GenerateAssertionCheck(tmp_assert_type,tmp_tag);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_tag);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_precondition_check(  /* [in] */ EIF_OBJECT tag,  /* [in] */ EIF_INTEGER label_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_tag = 0;
	tmp_tag = (BSTR)rt_ec.ccom_ec_bstr (eif_access (tag));
	LONG tmp_label_id = 0;
	tmp_label_id = (LONG)label_id;
	
	hr = p_ICore->GeneratePreconditionCheck(tmp_tag,tmp_label_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_tag);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_precondition_violation()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GeneratePreconditionViolation ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_invariant_checking(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->GenerateInvariantChecking(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_start_exception_block()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateStartExceptionBlock ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_start_rescue()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateStartRescue ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_end_exception_block()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateEndExceptionBlock ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_is_instance_of(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->GenerateIsInstanceOf(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_attribute_assignment(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	
	hr = p_ICore->GenerateAttributeAssignment(tmp_type_id,tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_local_assignment(  /* [in] */ EIF_INTEGER n )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_n = 0;
	tmp_n = (LONG)n;
	
	hr = p_ICore->GenerateLocalAssignment(tmp_n);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_result_assignment()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateResultAssignment ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_local_address(  /* [in] */ EIF_INTEGER n )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_n = 0;
	tmp_n = (LONG)n;
	
	hr = p_ICore->GenerateLocalAddress(tmp_n);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_routine_address(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	
	hr = p_ICore->GenerateRoutineAddress(tmp_type_id,tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_result_address()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateResultAddress ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_current_address()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateCurrentAddress ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_attribute_address(  /* [in] */ EIF_INTEGER type_id,  /* [in] */ EIF_INTEGER feature_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	LONG tmp_feature_id = 0;
	tmp_feature_id = (LONG)feature_id;
	
	hr = p_ICore->GenerateAttributeAddress(tmp_type_id,tmp_feature_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_argument_address(  /* [in] */ EIF_INTEGER n )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_n = 0;
	tmp_n = (LONG)n;
	
	hr = p_ICore->GenerateArgumentAddress(tmp_n);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_load_from_address(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->GenerateLoadFromAddress(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_array_access(  /* [in] */ EIF_INTEGER kind )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_kind = 0;
	tmp_kind = (LONG)kind;
	
	hr = p_ICore->GenerateArrayAccess(tmp_kind);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_array_write(  /* [in] */ EIF_INTEGER kind )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_kind = 0;
	tmp_kind = (LONG)kind;
	
	hr = p_ICore->GenerateArrayWrite(tmp_kind);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_array_creation(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->GenerateArrayCreation(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_return()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateReturn ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_return_value()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateReturnValue ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_once_done_info(  /* [in] */ EIF_OBJECT name )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	
	hr = p_ICore->GenerateOnceDoneInfo(tmp_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_once_result_info(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->GenerateOnceResultInfo(tmp_name,tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_once_test()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateOnceTest ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_once_result()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateOnceResult ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_once_store_result()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateOnceStoreResult ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_array_lower()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateArrayLower ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_array_upper()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateArrayUpper ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_array_count()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateArrayCount ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_put_void()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->PutVoid ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_put_manifest_string(  /* [in] */ EIF_OBJECT s )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_s = 0;
	tmp_s = (BSTR)rt_ec.ccom_ec_bstr (eif_access (s));
	
	hr = p_ICore->PutManifestString(tmp_s);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_s);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_put_integer8_constant(  /* [in] */ EIF_INTEGER i )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_i = 0;
	tmp_i = (LONG)i;
	
	hr = p_ICore->PutInteger8Constant(tmp_i);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_put_integer16_constant(  /* [in] */ EIF_INTEGER i )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_i = 0;
	tmp_i = (LONG)i;
	
	hr = p_ICore->PutInteger16Constant(tmp_i);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_put_integer32_constant(  /* [in] */ EIF_INTEGER i )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_i = 0;
	tmp_i = (LONG)i;
	
	hr = p_ICore->PutInteger32Constant(tmp_i);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_put_integer64_constant(  /* [in] */ EIF_INTEGER_64 i )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONGLONG tmp_i = 0;
	tmp_i = (LONGLONG)i;
	
	hr = p_ICore->PutInteger64Constant(tmp_i);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_put_double_constant(  /* [in] */ EIF_DOUBLE d )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	double tmp_d = 0;
	tmp_d = (double)d;
	
	hr = p_ICore->PutDoubleConstant(tmp_d);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_put_real_constant(  /* [in] */ EIF_REAL d )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	FLOAT tmp_d = 0;
	tmp_d = (FLOAT)d;
	
	hr = p_ICore->PutRealConstant(tmp_d);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_put_character_constant(  /* [in] */ EIF_INTEGER c )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	USHORT tmp_c = 0;
	tmp_c = (USHORT)c;
	
	hr = p_ICore->PutCharacterConstant(tmp_c);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_put_boolean_constant(  /* [in] */ EIF_BOOLEAN b )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_b = 0;
	tmp_b = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (b);
	
	hr = p_ICore->PutBooleanConstant(tmp_b);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_branch_on_true(  /* [in] */ EIF_INTEGER label )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_label = 0;
	tmp_label = (LONG)label;
	
	hr = p_ICore->BranchOnTrue(tmp_label);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_branch_on_false(  /* [in] */ EIF_INTEGER label )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_label = 0;
	tmp_label = (LONG)label;
	
	hr = p_ICore->BranchOnFalse(tmp_label);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_branch_to(  /* [in] */ EIF_INTEGER label )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_label = 0;
	tmp_label = (LONG)label;
	
	hr = p_ICore->BranchTo(tmp_label);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_mark_label(  /* [in] */ EIF_INTEGER label )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_label = 0;
	tmp_label = (LONG)label;
	
	hr = p_ICore->MarkLabel(tmp_label);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_lt()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateLt ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_le()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateLe ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_gt()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateGt ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_ge()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateGe ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_star()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateStar ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_power()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GeneratePower ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_max(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->GenerateMax(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_min(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->GenerateMin(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_abs(  /* [in] */ EIF_INTEGER type_id )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_type_id = 0;
	tmp_type_id = (LONG)type_id;
	
	hr = p_ICore->GenerateAbs(tmp_type_id);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_to_string()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateToString ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_plus()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GeneratePlus ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_mod()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateMod ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_minus()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateMinus ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_div()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateDiv ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_xor()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateXor ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_or()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateOr ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_and()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateAnd ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_implies()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateImplies ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_eq()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateEq ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_shl()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateShl ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_shr()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateShr ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_ne()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateNe ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_uminus()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateUMinus ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_not()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateNot ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_generate_bitwise_not()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->GenerateBitwiseNot ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_put_line_info(  /* [in] */ EIF_INTEGER n )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG tmp_n = 0;
	tmp_n = (LONG)n;
	
	hr = p_ICore->PutLineInfo(tmp_n);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelCompiler::Core::ccom_create_label(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG ret_value = 0;
	
	hr = p_ICore->CreateLabel( &ret_value);
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

void ecom_EiffelCompiler::Core::ccom_set_for_interfaces()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->SetForInterfaces ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelCompiler::Core::ccom_set_for_implementations()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_ICore == NULL)
	{
		hr = p_unknown->QueryInterface (IID_ICore_, (void **)&p_ICore);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_ICore->SetForImplementations ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_EiffelCompiler::Core::ccom_item()

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