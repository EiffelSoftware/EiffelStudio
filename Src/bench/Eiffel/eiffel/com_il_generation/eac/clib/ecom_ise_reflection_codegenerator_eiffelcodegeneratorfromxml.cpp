/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#include "ecom_ISE_Reflection_CodeGenerator_EiffelCodeGeneratorFromXml.h"
static const CLSID CLSID_EiffelCodeGeneratorFromXml_ = {0x24bb4a3d,0x1d19,0x3cb2,{0xa5,0xb0,0x5b,0x8d,0x9c,0xf3,0x08,0x32}};

static const IID IID__EiffelCodeGeneratorFromXml_ = {0x6584b9e9,0x7b9f,0x359a,{0xa7,0xd4,0x98,0xc6,0x54,0x6d,0xee,0x50}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::EiffelCodeGeneratorFromXml()
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

	hr = CoCreateInstanceEx (CLSID_EiffelCodeGeneratorFromXml_, NULL, CLSCTX_INPROC_SERVER, NULL, 1, &a_qi);
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

	p__EiffelCodeGeneratorFromXml = 0;

	excepinfo = (EXCEPINFO*)CoTaskMemAlloc (sizeof (EXCEPINFO));
	if (excepinfo != NULL)
		memset (excepinfo, '\0', sizeof (EXCEPINFO));
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::EiffelCodeGeneratorFromXml( IUnknown * a_pointer )
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

	p__EiffelCodeGeneratorFromXml = 0;
	hr = a_pointer->QueryInterface(IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
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

ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::~EiffelCodeGeneratorFromXml()
{
	p_unknown->Release ();
	
	CoTaskMemFree ((void *)excepinfo);
	if (p__EiffelCodeGeneratorFromXml!=NULL)
		p__EiffelCodeGeneratorFromXml->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_to_string(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p__EiffelCodeGeneratorFromXml->ToString( &ret_value);
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

EIF_BOOLEAN ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_equals(  /* [in] */ VARIANT * obj )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p__EiffelCodeGeneratorFromXml->Equals(*(VARIANT*)obj, &ret_value);
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

EIF_INTEGER ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_get_hash_code(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG ret_value = 0;
	
	hr = p__EiffelCodeGeneratorFromXml->GetHashCode( &ret_value);
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

EIF_INTEGER ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_get_type(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	LONG ret_value = 0;
	
	hr = p__EiffelCodeGeneratorFromXml->GetType( &ret_value);
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

void ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_generate_eiffel_code_from_xml_and_path(  /* [in] */ EIF_OBJECT type_description_filename,  /* [in] */ EIF_OBJECT a_path )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_type_description_filename = 0;
	tmp_type_description_filename = (BSTR)rt_ec.ccom_ec_bstr (eif_access (type_description_filename));
	BSTR tmp_a_path = 0;
	tmp_a_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_path));
	
	hr = p__EiffelCodeGeneratorFromXml->GenerateEiffelCodeFromXmlAndPath(tmp_type_description_filename,tmp_a_path);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_type_description_filename);
rt_ce.free_memory_bstr (tmp_a_path);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_eiffel_assembly(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	IDispatch * ret_value = 0;
	
	hr = p__EiffelCodeGeneratorFromXml->EiffelAssembly( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_pointed_dispatch (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_generate_eiffel_code_from_xml(  /* [in] */ EIF_OBJECT type_description_filename )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_type_description_filename = 0;
	tmp_type_description_filename = (BSTR)rt_ec.ccom_ec_bstr (eif_access (type_description_filename));
	
	hr = p__EiffelCodeGeneratorFromXml->GenerateEiffelCodeFromXml(tmp_type_description_filename);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_type_description_filename);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_eiffel_class_from_xml(  /* [in] */ EIF_OBJECT type_description_filename )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_type_description_filename = 0;
	tmp_type_description_filename = (BSTR)rt_ec.ccom_ec_bstr (eif_access (type_description_filename));
	ecom_ISE_Reflection_EiffelComponents::_EiffelClass * ret_value = 0;
	
	hr = p__EiffelCodeGeneratorFromXml->EiffelClassFromXml(tmp_type_description_filename, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_type_description_filename);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_13 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_eiffel_code_generator(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator * ret_value = 0;
	
	hr = p__EiffelCodeGeneratorFromXml->a_EiffelCodeGenerator( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_16 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_make_from_info(  /* [in] */ EIF_OBJECT an_assembly_description_filename )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_an_assembly_description_filename = 0;
	tmp_an_assembly_description_filename = (BSTR)rt_ec.ccom_ec_bstr (eif_access (an_assembly_description_filename));
	
	hr = p__EiffelCodeGeneratorFromXml->MakeFromInfo(tmp_an_assembly_description_filename);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_an_assembly_description_filename);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_assembly_description_filename(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p__EiffelCodeGeneratorFromXml->AssemblyDescriptionFilename( &ret_value);
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

void ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_update_assembly_description(  /* [in] */ EIF_OBJECT new_path )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_new_path = 0;
	tmp_new_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (new_path));
	
	hr = p__EiffelCodeGeneratorFromXml->UpdateAssemblyDescription(tmp_new_path);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_new_path);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_make_from_info_and_path(  /* [in] */ EIF_OBJECT an_assembly_description_filename,  /* [in] */ EIF_OBJECT new_path )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_an_assembly_description_filename = 0;
	tmp_an_assembly_description_filename = (BSTR)rt_ec.ccom_ec_bstr (eif_access (an_assembly_description_filename));
	BSTR tmp_new_path = 0;
	tmp_new_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (new_path));
	
	hr = p__EiffelCodeGeneratorFromXml->MakeFromInfoAndPath(tmp_an_assembly_description_filename,tmp_new_path);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_an_assembly_description_filename);
rt_ce.free_memory_bstr (tmp_new_path);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_dotnet_library_relative_path(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p__EiffelCodeGeneratorFromXml->DotnetLibraryRelativePath( &ret_value);
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

void ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_make1()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p__EiffelCodeGeneratorFromXml->Make ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_x_internal_eiffel_assembly(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	IDispatch * ret_value = 0;
	
	hr = p__EiffelCodeGeneratorFromXml->_internal_EiffelAssembly( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_pointed_dispatch (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_set_ref__internal_eiffel_assembly(  /* [in] */ IDispatch * p_ret_val )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p__EiffelCodeGeneratorFromXml->set_ref__internal_EiffelAssembly(p_ret_val);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_x_internal_eiffel_code_generator(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator * ret_value = 0;
	
	hr = p__EiffelCodeGeneratorFromXml->_internal_EiffelCodeGenerator( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE_c.ccom_ce_pointed_interface_16 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_set_ref__internal_eiffel_code_generator(  /* [in] */ ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator * p_ret_val )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	
	hr = p__EiffelCodeGeneratorFromXml->set_ref__internal_EiffelCodeGenerator(p_ret_val);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_x_internal_assembly_description_filename(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p__EiffelCodeGeneratorFromXml->_internal_AssemblyDescriptionFilename( &ret_value);
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

void ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_set__internal_assembly_description_filename(  /* [in] */ EIF_OBJECT p_ret_val )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p__EiffelCodeGeneratorFromXml == NULL)
	{
		hr = p_unknown->QueryInterface (IID__EiffelCodeGeneratorFromXml_, (void **)&p__EiffelCodeGeneratorFromXml);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_p_ret_val = 0;
	tmp_p_ret_val = (BSTR)rt_ec.ccom_ec_bstr (eif_access (p_ret_val));
	
	hr = p__EiffelCodeGeneratorFromXml->set__internal_AssemblyDescriptionFilename(tmp_p_ret_val);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_p_ret_val);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_last_error_code()

/*-----------------------------------------------------------
	Last error code
-----------------------------------------------------------*/
{
	return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_last_source_of_exception()

/*-----------------------------------------------------------
	Last source of exception
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_last_error_description()

/*-----------------------------------------------------------
	Last error description
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_last_error_help_file()

/*-----------------------------------------------------------
	Last error help file
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_ISE_Reflection_CodeGenerator::EiffelCodeGeneratorFromXml::ccom_item()

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