/*-----------------------------------------------------------
Implemented `IEnumEiffelClass' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEnumEiffelClass_impl_proxy_s.h"
static const IID IID_IEnumEiffelClass_ = {0x61e3d67a,0x4c96,0x49d3,{0x82,0x36,0x85,0x76,0x5e,0x67,0xc3,0x15}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::IEnumEiffelClass_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEnumEiffelClass_, (void **)&p_IEnumEiffelClass);
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

ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::~IEnumEiffelClass_impl_proxy()
{
	p_unknown->Release ();
	
	CoTaskMemFree ((void *)excepinfo);
	if (p_IEnumEiffelClass!=NULL)
		p_IEnumEiffelClass->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_last_error_code()

/*-----------------------------------------------------------
	Last error code
-----------------------------------------------------------*/
{
	return (EIF_INTEGER) excepinfo->wCode;
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_last_source_of_exception()

/*-----------------------------------------------------------
	Last source of exception
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrSource);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_last_error_description()

/*-----------------------------------------------------------
	Last error description
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrDescription);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_last_error_help_file()

/*-----------------------------------------------------------
	Last error help file
-----------------------------------------------------------*/
{
	return (EIF_REFERENCE) rt_ce.ccom_ce_bstr (excepinfo->bstrHelpFile);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_next(  /* [out] */ EIF_OBJECT pp_ieiffel_class_descriptor,  /* [out] */ EIF_OBJECT pul_fetched )

/*-----------------------------------------------------------
	Go to next item in enumerator
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumEiffelClass == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumEiffelClass_, (void **)&p_IEnumEiffelClass);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEiffelClassDescriptor * * tmp_pp_ieiffel_class_descriptor = 0;
	tmp_pp_ieiffel_class_descriptor = (ecom_EiffelComCompiler::IEiffelClassDescriptor * *)grt_ec_ISE.ccom_ec_pointed_cell_53 (eif_access (pp_ieiffel_class_descriptor), NULL);
	ULONG * tmp_pul_fetched = 0;
	tmp_pul_fetched = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pul_fetched), NULL);
	
	hr = p_IEnumEiffelClass->Next(tmp_pp_ieiffel_class_descriptor,tmp_pul_fetched);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_53 ((ecom_EiffelComCompiler::IEiffelClassDescriptor * *)tmp_pp_ieiffel_class_descriptor, pp_ieiffel_class_descriptor);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pul_fetched, pul_fetched);
	
	grt_ce_ISE.ccom_free_memory_pointed_53 (tmp_pp_ieiffel_class_descriptor);
grt_ce_ISE.ccom_free_memory_pointed_62 (tmp_pul_fetched);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_skip(  /* [in] */ EIF_INTEGER ul_count )

/*-----------------------------------------------------------
	Skip `ulCount' items.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumEiffelClass == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumEiffelClass_, (void **)&p_IEnumEiffelClass);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ul_count = 0;
	tmp_ul_count = (ULONG)ul_count;
	
	hr = p_IEnumEiffelClass->Skip(tmp_ul_count);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_reset()

/*-----------------------------------------------------------
	Reset enumerator.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumEiffelClass == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumEiffelClass_, (void **)&p_IEnumEiffelClass);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IEnumEiffelClass->Reset ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT pp_ienum_eiffel_class )

/*-----------------------------------------------------------
	Clone enumerator.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumEiffelClass == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumEiffelClass_, (void **)&p_IEnumEiffelClass);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEnumEiffelClass * * tmp_pp_ienum_eiffel_class = 0;
	tmp_pp_ienum_eiffel_class = (ecom_EiffelComCompiler::IEnumEiffelClass * *)grt_ec_ISE.ccom_ec_pointed_cell_39 (eif_access (pp_ienum_eiffel_class), NULL);
	
	hr = p_IEnumEiffelClass->Clone(tmp_pp_ienum_eiffel_class);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_39 ((ecom_EiffelComCompiler::IEnumEiffelClass * *)tmp_pp_ienum_eiffel_class, pp_ienum_eiffel_class);
	
	grt_ce_ISE.ccom_free_memory_pointed_39 (tmp_pp_ienum_eiffel_class);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_ith_item(  /* [in] */ EIF_INTEGER ul_index,  /* [out] */ EIF_OBJECT pp_ieiffel_class_descriptor )

/*-----------------------------------------------------------
	Retrieve enumerators ith item at `ulIndex'.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumEiffelClass == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumEiffelClass_, (void **)&p_IEnumEiffelClass);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ul_index = 0;
	tmp_ul_index = (ULONG)ul_index;
	ecom_EiffelComCompiler::IEiffelClassDescriptor * * tmp_pp_ieiffel_class_descriptor = 0;
	tmp_pp_ieiffel_class_descriptor = (ecom_EiffelComCompiler::IEiffelClassDescriptor * *)grt_ec_ISE.ccom_ec_pointed_cell_53 (eif_access (pp_ieiffel_class_descriptor), NULL);
	
	hr = p_IEnumEiffelClass->IthItem(tmp_ul_index,tmp_pp_ieiffel_class_descriptor);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_53 ((ecom_EiffelComCompiler::IEiffelClassDescriptor * *)tmp_pp_ieiffel_class_descriptor, pp_ieiffel_class_descriptor);
	
	grt_ce_ISE.ccom_free_memory_pointed_53 (tmp_pp_ieiffel_class_descriptor);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_count(  )

/*-----------------------------------------------------------
	Retrieve enumerator item count.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumEiffelClass == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumEiffelClass_, (void **)&p_IEnumEiffelClass);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG ret_value = 0;
	
	hr = p_IEnumEiffelClass->Count( &ret_value);
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

EIF_POINTER ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_item()

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