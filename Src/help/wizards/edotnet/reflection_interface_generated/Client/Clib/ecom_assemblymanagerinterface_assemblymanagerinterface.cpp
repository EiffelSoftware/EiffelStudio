/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#include "ecom_AssemblyManagerInterface_AssemblyManagerInterface.h"
static const CLSID CLSID_AssemblyManagerInterface_ = {0x4116a1b8,0x4260,0x3d6f,{0xbe,0x70,0x19,0x98,0x2b,0x1b,0xb9,0xd7}};

static const IID IID_IAssemblyManagerInterface_ = {0x2cae334b,0x54e8,0x34bf,{0x86,0xaa,0x78,0xc3,0xe3,0x9b,0x80,0x4f}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_AssemblyManagerInterface::AssemblyManagerInterface::AssemblyManagerInterface()
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

	hr = CoCreateInstanceEx (CLSID_AssemblyManagerInterface_, NULL, CLSCTX_INPROC_SERVER, NULL, 1, &a_qi);
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

	p_IAssemblyManagerInterface = 0;

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_AssemblyManagerInterface::AssemblyManagerInterface::AssemblyManagerInterface( IUnknown * a_pointer )
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

	p_IAssemblyManagerInterface = 0;
	hr = a_pointer->QueryInterface(IID_IAssemblyManagerInterface_, (void **)&p_IAssemblyManagerInterface);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_AssemblyManagerInterface::AssemblyManagerInterface::~AssemblyManagerInterface()
{
	p_unknown->Release ();
	if (p_IAssemblyManagerInterface!=NULL)
		p_IAssemblyManagerInterface->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_AssemblyManagerInterface::AssemblyManagerInterface::ccom_imported_assemblies(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAssemblyManagerInterface == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAssemblyManagerInterface_, (void **)&p_IAssemblyManagerInterface);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	SAFEARRAY *  ret_value = 0;
	
	hr = p_IAssemblyManagerInterface->ImportedAssemblies( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_safearray_bstr (ret_value));
	rt_ce.free_memory_safearray (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_AssemblyManagerInterface::AssemblyManagerInterface::ccom_last_importation_successful(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAssemblyManagerInterface == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAssemblyManagerInterface_, (void **)&p_IAssemblyManagerInterface);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IAssemblyManagerInterface->LastImportationSuccessful( &ret_value);
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

EIF_REFERENCE ecom_AssemblyManagerInterface::AssemblyManagerInterface::ccom_assembly_location(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_OBJECT version,  /* [in] */ EIF_OBJECT culture,  /* [in] */ EIF_OBJECT public_key )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAssemblyManagerInterface == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAssemblyManagerInterface_, (void **)&p_IAssemblyManagerInterface);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	BSTR tmp_version = 0;
	tmp_version = (BSTR)rt_ec.ccom_ec_bstr (eif_access (version));
	BSTR tmp_culture = 0;
	tmp_culture = (BSTR)rt_ec.ccom_ec_bstr (eif_access (culture));
	BSTR tmp_public_key = 0;
	tmp_public_key = (BSTR)rt_ec.ccom_ec_bstr (eif_access (public_key));
	BSTR ret_value = 0;
	
	hr = p_IAssemblyManagerInterface->AssemblyLocation(tmp_name,tmp_version,tmp_culture,tmp_public_key, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_name);
rt_ce.free_memory_bstr (tmp_version);
rt_ce.free_memory_bstr (tmp_culture);
rt_ce.free_memory_bstr (tmp_public_key);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_bstr (ret_value));
	rt_ce.free_memory_bstr (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_AssemblyManagerInterface::AssemblyManagerInterface::ccom_local_assembly_dependencies(  /* [in] */ EIF_OBJECT filename )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAssemblyManagerInterface == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAssemblyManagerInterface_, (void **)&p_IAssemblyManagerInterface);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_filename = 0;
	tmp_filename = (BSTR)rt_ec.ccom_ec_bstr (eif_access (filename));
	SAFEARRAY *  ret_value = 0;
	
	hr = p_IAssemblyManagerInterface->LocalAssemblyDependencies(tmp_filename, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_filename);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_safearray_bstr (ret_value));
	rt_ce.free_memory_safearray (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_AssemblyManagerInterface::AssemblyManagerInterface::ccom_assembly_dependencies(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_OBJECT version,  /* [in] */ EIF_OBJECT culture,  /* [in] */ EIF_OBJECT public_key )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAssemblyManagerInterface == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAssemblyManagerInterface_, (void **)&p_IAssemblyManagerInterface);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_name = 0;
	tmp_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (name));
	BSTR tmp_version = 0;
	tmp_version = (BSTR)rt_ec.ccom_ec_bstr (eif_access (version));
	BSTR tmp_culture = 0;
	tmp_culture = (BSTR)rt_ec.ccom_ec_bstr (eif_access (culture));
	BSTR tmp_public_key = 0;
	tmp_public_key = (BSTR)rt_ec.ccom_ec_bstr (eif_access (public_key));
	SAFEARRAY *  ret_value = 0;
	
	hr = p_IAssemblyManagerInterface->AssemblyDependencies(tmp_name,tmp_version,tmp_culture,tmp_public_key, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_name);
rt_ce.free_memory_bstr (tmp_version);
rt_ce.free_memory_bstr (tmp_culture);
rt_ce.free_memory_bstr (tmp_public_key);

	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)rt_ce.ccom_ce_safearray_bstr (ret_value));
	rt_ce.free_memory_safearray (ret_value);
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_AssemblyManagerInterface::AssemblyManagerInterface::ccom_is_signed(  /* [in] */ EIF_OBJECT filename )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAssemblyManagerInterface == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAssemblyManagerInterface_, (void **)&p_IAssemblyManagerInterface);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_filename = 0;
	tmp_filename = (BSTR)rt_ec.ccom_ec_bstr (eif_access (filename));
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IAssemblyManagerInterface->IsSigned(tmp_filename, &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_filename);

	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_AssemblyManagerInterface::AssemblyManagerInterface::ccom_clean_assemblies()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IAssemblyManagerInterface == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IAssemblyManagerInterface_, (void **)&p_IAssemblyManagerInterface);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IAssemblyManagerInterface->CleanAssemblies ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_AssemblyManagerInterface::AssemblyManagerInterface::ccom_item()

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