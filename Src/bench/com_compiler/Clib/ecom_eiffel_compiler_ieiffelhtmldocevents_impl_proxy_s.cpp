/*-----------------------------------------------------------
Implemented `IEiffelHTMLDocEvents' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelHTMLDocEvents_impl_proxy_s.h"
static const IID IID_IEiffelHTMLDocEvents_ = {0xb120763e,0xed26,0x4ded,{0xaa,0xfb,0x21,0xfa,0x8b,0x28,0xe8,0x79}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_proxy::IEiffelHTMLDocEvents_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEiffelHTMLDocEvents_, (void **)&p_IEiffelHTMLDocEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_proxy::~IEiffelHTMLDocEvents_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEiffelHTMLDocEvents!=NULL)
		p_IEiffelHTMLDocEvents->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_proxy::ccom_put_header(  /* [in] */ EIF_OBJECT new_value )

/*-----------------------------------------------------------
	Put a header message to the output
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHTMLDocEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHTMLDocEvents_, (void **)&p_IEiffelHTMLDocEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_new_value = 0;
	tmp_new_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (new_value));
	
	hr = p_IEiffelHTMLDocEvents->put_header(tmp_new_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_new_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_proxy::ccom_put_string(  /* [in] */ EIF_OBJECT new_value )

/*-----------------------------------------------------------
	Put a string to the output
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHTMLDocEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHTMLDocEvents_, (void **)&p_IEiffelHTMLDocEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_new_value = 0;
	tmp_new_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (new_value));
	
	hr = p_IEiffelHTMLDocEvents->put_string(tmp_new_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_new_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_proxy::ccom_put_class_document_message(  /* [in] */ EIF_OBJECT new_value )

/*-----------------------------------------------------------
	Put a class name to the output
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHTMLDocEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHTMLDocEvents_, (void **)&p_IEiffelHTMLDocEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_new_value = 0;
	tmp_new_value = (BSTR)rt_ec.ccom_ec_bstr (eif_access (new_value));
	
	hr = p_IEiffelHTMLDocEvents->put_class_document_message(tmp_new_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_new_value);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_proxy::ccom_put_initializing_documentation()

/*-----------------------------------------------------------
	Notify that documentation generating is initializing
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHTMLDocEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHTMLDocEvents_, (void **)&p_IEiffelHTMLDocEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IEiffelHTMLDocEvents->put_initializing_documentation ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_proxy::ccom_put_percentage_completed(  /* [in] */ EIF_INTEGER new_value )

/*-----------------------------------------------------------
	Notify that the percentage completed has changed
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHTMLDocEvents == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHTMLDocEvents_, (void **)&p_IEiffelHTMLDocEvents);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_new_value = 0;
	tmp_new_value = (ULONG)new_value;
	
	hr = p_IEiffelHTMLDocEvents->put_percentage_completed(tmp_new_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_proxy::ccom_item()

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