/*-----------------------------------------------------------
Implemented `IEiffelProjectProperties' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelProjectProperties_impl_proxy_s.h"
static const IID IID_IEiffelProjectProperties_ = {0xc212faab,0xfaa8,0x48b9,{0x9d,0x4e,0x2d,0x0c,0xa4,0xeb,0x33,0x54}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::IEiffelProjectProperties_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
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

ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::~IEiffelProjectProperties_impl_proxy()
{
	p_unknown->Release ();
	
	CoTaskMemFree ((void *)excepinfo);
	if (p_IEiffelProjectProperties!=NULL)
		p_IEiffelProjectProperties->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_last_error_code()

/*-----------------------------------------------------------
	Last error code
-----------------------------------------------------------*/
{
	return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_last_source_of_exception()

/*-----------------------------------------------------------
	Last source of exception
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_last_error_description()

/*-----------------------------------------------------------
	Last error description
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_last_error_help_file()

/*-----------------------------------------------------------
	Last error help file
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_system_name(  )

/*-----------------------------------------------------------
	System name.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProjectProperties->system_name( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_system_name(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	System name.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelProjectProperties->set_system_name(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_root_class_name(  )

/*-----------------------------------------------------------
	Root class name.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProjectProperties->root_class_name( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_root_class_name(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	Root class name.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelProjectProperties->set_root_class_name(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_creation_routine(  )

/*-----------------------------------------------------------
	Creation routine name.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProjectProperties->creation_routine( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_creation_routine(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	Creation routine name.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelProjectProperties->set_creation_routine(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_compilation_type(  )

/*-----------------------------------------------------------
	Compilation type.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	long ret_value = 0;
	
	hr = p_IEiffelProjectProperties->compilation_type( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_compilation_type(  /* [in] */ EIF_INTEGER return_value )

/*-----------------------------------------------------------
	Compilation type.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	long tmp_return_value = 0;
	tmp_return_value = (long)return_value;
	
	hr = p_IEiffelProjectProperties->set_compilation_type(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_console_application(  )

/*-----------------------------------------------------------
	Is console application?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelProjectProperties->console_application( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_console_application(  /* [in] */ EIF_BOOLEAN return_value )

/*-----------------------------------------------------------
	Is console application?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_return_value = 0;
	tmp_return_value = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (return_value);
	
	hr = p_IEiffelProjectProperties->set_console_application(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_evaluate_require(  )

/*-----------------------------------------------------------
	Should preconditions be evaluated?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelProjectProperties->evaluate_require( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_evaluate_require(  /* [in] */ EIF_BOOLEAN return_value )

/*-----------------------------------------------------------
	Should preconditions be evaluated?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_return_value = 0;
	tmp_return_value = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (return_value);
	
	hr = p_IEiffelProjectProperties->set_evaluate_require(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_evaluate_ensure(  )

/*-----------------------------------------------------------
	Should postconditions be evaluated?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelProjectProperties->evaluate_ensure( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_evaluate_ensure(  /* [in] */ EIF_BOOLEAN return_value )

/*-----------------------------------------------------------
	Should postconditions be evaluated?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_return_value = 0;
	tmp_return_value = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (return_value);
	
	hr = p_IEiffelProjectProperties->set_evaluate_ensure(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_evaluate_check(  )

/*-----------------------------------------------------------
	Should check assertions be evaluated?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelProjectProperties->evaluate_check( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_evaluate_check(  /* [in] */ EIF_BOOLEAN return_value )

/*-----------------------------------------------------------
	Should check assertions be evaluated?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_return_value = 0;
	tmp_return_value = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (return_value);
	
	hr = p_IEiffelProjectProperties->set_evaluate_check(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_evaluate_loop(  )

/*-----------------------------------------------------------
	Should loop assertions be evaluated?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelProjectProperties->evaluate_loop( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_evaluate_loop(  /* [in] */ EIF_BOOLEAN return_value )

/*-----------------------------------------------------------
	Should loop assertions be evaluated?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_return_value = 0;
	tmp_return_value = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (return_value);
	
	hr = p_IEiffelProjectProperties->set_evaluate_loop(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_evaluate_invariant(  )

/*-----------------------------------------------------------
	Should class invariants be evaluated?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelProjectProperties->evaluate_invariant( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_evaluate_invariant(  /* [in] */ EIF_BOOLEAN return_value )

/*-----------------------------------------------------------
	Should class invariants be evaluated?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_return_value = 0;
	tmp_return_value = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (return_value);
	
	hr = p_IEiffelProjectProperties->set_evaluate_invariant(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_debug_info(  )

/*-----------------------------------------------------------
	Generate debug info?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelProjectProperties->debug_info( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_debug_info(  /* [in] */ EIF_BOOLEAN return_value )

/*-----------------------------------------------------------
	Generate debug info?
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL tmp_return_value = 0;
	tmp_return_value = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (return_value);
	
	hr = p_IEiffelProjectProperties->set_debug_info(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_clusters(  )

/*-----------------------------------------------------------
	Project Clusters.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_eiffel_compiler::IEiffelSystemClusters * ret_value = 0;
	
	hr = p_IEiffelProjectProperties->clusters( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_156 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_externals(  )

/*-----------------------------------------------------------
	Externals.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_eiffel_compiler::IEiffelSystemExternals * ret_value = 0;
	
	hr = p_IEiffelProjectProperties->externals( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_159 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_default_namespace(  )

/*-----------------------------------------------------------
	Default namespace.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProjectProperties->default_namespace( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_default_namespace(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	Default namespace.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelProjectProperties->set_default_namespace(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_assemblies(  )

/*-----------------------------------------------------------
	Assemblies.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_eiffel_compiler::IEiffelSystemAssemblies * ret_value = 0;
	
	hr = p_IEiffelProjectProperties->assemblies( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_163 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_precompiled(  )

/*-----------------------------------------------------------
	Precompiled file.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProjectProperties->precompiled( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_precompiled(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	Precompiled file.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelProjectProperties->set_precompiled(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_title(  )

/*-----------------------------------------------------------
	Project title.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProjectProperties->title( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_title(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	Project title.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelProjectProperties->set_title(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_description(  )

/*-----------------------------------------------------------
	Project description.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProjectProperties->description( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_description(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	Project description.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelProjectProperties->set_description(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_company(  )

/*-----------------------------------------------------------
	Project company.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProjectProperties->company( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_company(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	Project company.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelProjectProperties->set_company(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_product(  )

/*-----------------------------------------------------------
	Product.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProjectProperties->product( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_product(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	Product.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelProjectProperties->set_product(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_version(  )

/*-----------------------------------------------------------
	Project version.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProjectProperties->version( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_version(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	Project version.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelProjectProperties->set_version(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_trademark(  )

/*-----------------------------------------------------------
	Project trademark.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProjectProperties->trademark( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_trademark(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	Project trademark.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelProjectProperties->set_trademark(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_copyright(  )

/*-----------------------------------------------------------
	Project copyright.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProjectProperties->copyright( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_copyright(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	Project copyright.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelProjectProperties->set_copyright(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_key_file_name(  )

/*-----------------------------------------------------------
	Asembly signing key file name.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProjectProperties->key_file_name( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_key_file_name(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	Asembly signing key file name.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelProjectProperties->set_key_file_name(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_culture(  )

/*-----------------------------------------------------------
	Asembly culture.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR ret_value = 0;
	
	hr = p_IEiffelProjectProperties->culture( &ret_value);
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

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_set_culture(  /* [in] */ EIF_OBJECT return_value )

/*-----------------------------------------------------------
	Asembly culture.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_return_value = 0;
	tmp_return_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (return_value));
	
	hr = p_IEiffelProjectProperties->set_culture(tmp_return_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_return_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_apply()

/*-----------------------------------------------------------
	Apply changes
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelProjectProperties == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelProjectProperties_, (void **)&p_IEiffelProjectProperties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IEiffelProjectProperties->Apply ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_eiffel_compiler::IEiffelProjectProperties_impl_proxy::ccom_item()

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