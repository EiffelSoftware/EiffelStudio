/*-----------------------------------------------------------
Implemented `IEiffelCompilerEvents' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEiffelCompilerEvents_impl_proxy_s.h"
static const IID IID_IEiffelCompilerEvents_ = {0x75b32e73,0xa00e,0x4bcf,{0x9a,0x7a,0x13,0xd4,0x1e,0x63,0x59,0xb4}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_proxy::IEiffelCompilerEvents_impl_proxy( IUnknown * a_pointer )
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

ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_proxy::~IEiffelCompilerEvents_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEiffelCompilerEvents!=NULL)
		p_IEiffelCompilerEvents->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_proxy::ccom_begin_compile()

/*-----------------------------------------------------------
	Beginning compilation.
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
	hr = p_IEiffelCompilerEvents->BeginCompile ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_proxy::ccom_begin_degree(  /* [in] */ EIF_INTEGER ul_degree )

/*-----------------------------------------------------------
	Start of new degree phase in compilation.
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
	LONG tmp_ul_degree = 0;
	tmp_ul_degree = (LONG)ul_degree;
	
	hr = p_IEiffelCompilerEvents->BeginDegree(tmp_ul_degree);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_proxy::ccom_end_compile(  /* [in] */ EIF_BOOLEAN vb_sucessful )

/*-----------------------------------------------------------
	Finished compilation.
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
	VARIANT_BOOL tmp_vb_sucessful = 0;
	tmp_vb_sucessful = (VARIANT_BOOL)rt_ec.ccom_ec_boolean (vb_sucessful);
	
	hr = p_IEiffelCompilerEvents->EndCompile(tmp_vb_sucessful);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_proxy::ccom_should_continue(  /* [in, out] */ EIF_OBJECT pvb_continue )

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
	VARIANT_BOOL * tmp_pvb_continue = 0;
	tmp_pvb_continue = (VARIANT_BOOL *)rt_ec.ccom_ec_pointed_boolean (eif_access (pvb_continue), NULL);
	
	hr = p_IEiffelCompilerEvents->ShouldContinue(tmp_pvb_continue);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_boolean ((VARIANT_BOOL *)tmp_pvb_continue, pvb_continue);
	
	grt_ce_ISE.ccom_free_memory_pointed_237 (tmp_pvb_continue);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_proxy::ccom_output_string(  /* [in] */ EIF_OBJECT bstr_output )

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
	BSTR tmp_bstr_output = 0;
	tmp_bstr_output = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_output));
	
	hr = p_IEiffelCompilerEvents->OutputString(tmp_bstr_output);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_output);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_proxy::ccom_output_error(  /* [in] */ EIF_OBJECT bstr_full_error,  /* [in] */ EIF_OBJECT bstr_short_error,  /* [in] */ EIF_OBJECT bstr_code,  /* [in] */ EIF_OBJECT bstr_file_name,  /* [in] */ EIF_INTEGER ul_line,  /* [in] */ EIF_INTEGER ul_col )

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
	BSTR tmp_bstr_full_error = 0;
	tmp_bstr_full_error = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_full_error));
	BSTR tmp_bstr_short_error = 0;
	tmp_bstr_short_error = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_short_error));
	BSTR tmp_bstr_code = 0;
	tmp_bstr_code = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_code));
	BSTR tmp_bstr_file_name = 0;
	tmp_bstr_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_file_name));
	ULONG tmp_ul_line = 0;
	tmp_ul_line = (ULONG)ul_line;
	ULONG tmp_ul_col = 0;
	tmp_ul_col = (ULONG)ul_col;
	
	hr = p_IEiffelCompilerEvents->OutputError(tmp_bstr_full_error,tmp_bstr_short_error,tmp_bstr_code,tmp_bstr_file_name,tmp_ul_line,tmp_ul_col);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_full_error);
rt_ce.free_memory_bstr (tmp_bstr_short_error);
rt_ce.free_memory_bstr (tmp_bstr_code);
rt_ce.free_memory_bstr (tmp_bstr_file_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_proxy::ccom_output_warning(  /* [in] */ EIF_OBJECT bstr_full_warning,  /* [in] */ EIF_OBJECT bstr_short_warning,  /* [in] */ EIF_OBJECT bstr_code,  /* [in] */ EIF_OBJECT bstr_file_name,  /* [in] */ EIF_INTEGER ul_line,  /* [in] */ EIF_INTEGER ul_col )

/*-----------------------------------------------------------
	Last warning.
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
	BSTR tmp_bstr_full_warning = 0;
	tmp_bstr_full_warning = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_full_warning));
	BSTR tmp_bstr_short_warning = 0;
	tmp_bstr_short_warning = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_short_warning));
	BSTR tmp_bstr_code = 0;
	tmp_bstr_code = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_code));
	BSTR tmp_bstr_file_name = 0;
	tmp_bstr_file_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_file_name));
	ULONG tmp_ul_line = 0;
	tmp_ul_line = (ULONG)ul_line;
	ULONG tmp_ul_col = 0;
	tmp_ul_col = (ULONG)ul_col;
	
	hr = p_IEiffelCompilerEvents->OutputWarning(tmp_bstr_full_warning,tmp_bstr_short_warning,tmp_bstr_code,tmp_bstr_file_name,tmp_ul_line,tmp_ul_col);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_full_warning);
rt_ce.free_memory_bstr (tmp_bstr_short_warning);
rt_ce.free_memory_bstr (tmp_bstr_code);
rt_ce.free_memory_bstr (tmp_bstr_file_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_proxy::ccom_item()

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