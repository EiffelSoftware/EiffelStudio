/*-----------------------------------------------------------
Implemented `IEiffelCompilerEvents' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelCompilerEvents_impl_proxy_s.h"
static const IID IID_IEiffelCompilerEvents_ = {0xb16070bd,0xdece,0x4e7a,{0x80,0x3c,0xf7,0xa4,0x59,0x24,0xcb,0x88}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelCompilerEvents_impl_proxy::IEiffelCompilerEvents_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEiffelCompilerEvents_, (void **)&p_IEiffelCompilerEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelCompilerEvents_impl_proxy::~IEiffelCompilerEvents_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEiffelCompilerEvents!=NULL)
		p_IEiffelCompilerEvents->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelCompilerEvents_impl_proxy::ccom_should_continue(  /* [in, out] */ EIF_OBJECT a_boolean )

/*-----------------------------------------------------------
	Should compilation continue.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelCompilerEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelCompilerEvents_, (void **)&p_IEiffelCompilerEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL * tmp_a_boolean = 0;
	tmp_a_boolean = (VARIANT_BOOL *)rt_ec.ccom_ec_pointed_boolean (eif_access (a_boolean), NULL);
	
	hr = p_IEiffelCompilerEvents->should_continue(tmp_a_boolean);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_boolean ((VARIANT_BOOL *)tmp_a_boolean, a_boolean);
	
	grt_ce_Eif_compiler.ccom_free_memory_pointed_129 (tmp_a_boolean);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelCompilerEvents_impl_proxy::ccom_output_string(  /* [in] */ EIF_OBJECT a_string )

/*-----------------------------------------------------------
	Output string.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelCompilerEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelCompilerEvents_, (void **)&p_IEiffelCompilerEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_a_string = 0;
	tmp_a_string = (BSTR)rt_ec.ccom_ec_bstr (eif_access (a_string));
	
	hr = p_IEiffelCompilerEvents->output_string(tmp_a_string);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_a_string);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelCompilerEvents_impl_proxy::ccom_last_error(  /* [in] */ EIF_OBJECT error_message,  /* [in] */ EIF_OBJECT file_name,  /* [in] */ EIF_INTEGER line_number )

/*-----------------------------------------------------------
	Last error.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelCompilerEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelCompilerEvents_, (void **)&p_IEiffelCompilerEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_error_message = 0;
	tmp_error_message = (BSTR)rt_ec.ccom_ec_bstr (eif_access (error_message));
	BSTR tmp_file_name = 0;
	tmp_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (file_name));
	ULONG tmp_line_number = 0;
	tmp_line_number = (ULONG)line_number;
	
	hr = p_IEiffelCompilerEvents->last_error(tmp_error_message,tmp_file_name,tmp_line_number);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_error_message);
rt_ce.free_memory_bstr (tmp_file_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_eiffel_compiler::IEiffelCompilerEvents_impl_proxy::ccom_item()

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