/*-----------------------------------------------------------
Implemented `IEiffelHtmlDocumentationEvents' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEiffelHtmlDocumentationEvents_impl_proxy.h"
static const IID IID_IEiffelHtmlDocumentationEvents_ = {0xb120763e,0xed26,0x4ded,{0xaa,0xfb,0x21,0xfa,0x8b,0x28,0xe8,0x79}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy::IEiffelHtmlDocumentationEvents_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEiffelHtmlDocumentationEvents_, (void **)&p_IEiffelHtmlDocumentationEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy::~IEiffelHtmlDocumentationEvents_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEiffelHtmlDocumentationEvents!=NULL)
		p_IEiffelHtmlDocumentationEvents->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy::ccom_notify_initalizing_documentation()

/*-----------------------------------------------------------
	Notify that documentation generating is initializing
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHtmlDocumentationEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHtmlDocumentationEvents_, (void **)&p_IEiffelHtmlDocumentationEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IEiffelHtmlDocumentationEvents->NotifyInitalizingDocumentation ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy::ccom_notify_percentage_complete(  /* [in] */ EIF_INTEGER ul_percent )

/*-----------------------------------------------------------
	Notify that the percentage completed has changed
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHtmlDocumentationEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHtmlDocumentationEvents_, (void **)&p_IEiffelHtmlDocumentationEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ul_percent = 0;
	tmp_ul_percent = (ULONG)ul_percent;
	
	hr = p_IEiffelHtmlDocumentationEvents->NotifyPercentageComplete(tmp_ul_percent);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy::ccom_output_header(  /* [in] */ EIF_OBJECT bstr_msg )

/*-----------------------------------------------------------
	Put a header message to the output
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHtmlDocumentationEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHtmlDocumentationEvents_, (void **)&p_IEiffelHtmlDocumentationEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_msg = 0;
	tmp_bstr_msg = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_msg));
	
	hr = p_IEiffelHtmlDocumentationEvents->OutputHeader(tmp_bstr_msg);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_msg);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy::ccom_output_string(  /* [in] */ EIF_OBJECT bstr_msg )

/*-----------------------------------------------------------
	Put a string to the output
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHtmlDocumentationEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHtmlDocumentationEvents_, (void **)&p_IEiffelHtmlDocumentationEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_msg = 0;
	tmp_bstr_msg = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_msg));
	
	hr = p_IEiffelHtmlDocumentationEvents->OutputString(tmp_bstr_msg);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_msg);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy::ccom_output_class_document_message(  /* [in] */ EIF_OBJECT bstr_msg )

/*-----------------------------------------------------------
	Put a class name to the output
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHtmlDocumentationEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHtmlDocumentationEvents_, (void **)&p_IEiffelHtmlDocumentationEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_bstr_msg = 0;
	tmp_bstr_msg = (BSTR)rt_ec.ccom_ec_bstr (eif_access (bstr_msg));
	
	hr = p_IEiffelHtmlDocumentationEvents->OutputClassDocumentMessage(tmp_bstr_msg);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_bstr_msg);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy::ccom_should_continue(  /* [in, out] */ EIF_OBJECT pvb_continue )

/*-----------------------------------------------------------
	Should compilation continue.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHtmlDocumentationEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHtmlDocumentationEvents_, (void **)&p_IEiffelHtmlDocumentationEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	VARIANT_BOOL * tmp_pvb_continue = 0;
	tmp_pvb_continue = (VARIANT_BOOL *)rt_ec.ccom_ec_pointed_boolean (eif_access (pvb_continue), NULL);
	
	hr = p_IEiffelHtmlDocumentationEvents->ShouldContinue(tmp_pvb_continue);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	rt_ce.ccom_ce_pointed_boolean ((VARIANT_BOOL *)tmp_pvb_continue, pvb_continue);
	
	grt_ce_ISE_c.ccom_free_memory_pointed_236 (tmp_pvb_continue);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents_impl_proxy::ccom_item()

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