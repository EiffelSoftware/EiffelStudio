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

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::~IEnumEiffelClass_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEnumEiffelClass!=NULL)
		p_IEnumEiffelClass->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_next(  /* [out] */ EIF_OBJECT rgelt,  /* [out] */ EIF_OBJECT pcelt_fetched )

/*-----------------------------------------------------------
	No description available.
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
	ecom_EiffelComCompiler::IEiffelClassDescriptor * * tmp_rgelt = 0;
	tmp_rgelt = (ecom_EiffelComCompiler::IEiffelClassDescriptor * *)grt_ec_ISE.ccom_ec_pointed_cell_54 (eif_access (rgelt), NULL);
	ULONG * tmp_pcelt_fetched = 0;
	tmp_pcelt_fetched = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pcelt_fetched), NULL);
	
	hr = p_IEnumEiffelClass->Next(tmp_rgelt,tmp_pcelt_fetched);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_54 ((ecom_EiffelComCompiler::IEiffelClassDescriptor * *)tmp_rgelt, rgelt);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pcelt_fetched, pcelt_fetched);
	
	grt_ce_ISE.ccom_free_memory_pointed_54 (tmp_rgelt);
grt_ce_ISE.ccom_free_memory_pointed_63 (tmp_pcelt_fetched);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_skip(  /* [in] */ EIF_INTEGER celt )

/*-----------------------------------------------------------
	No description available.
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
	ULONG tmp_celt = 0;
	tmp_celt = (ULONG)celt;
	
	hr = p_IEnumEiffelClass->Skip(tmp_celt);
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
	No description available.
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

void ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT ppenum )

/*-----------------------------------------------------------
	No description available.
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
	ecom_EiffelComCompiler::IEnumEiffelClass * * tmp_ppenum = 0;
	tmp_ppenum = (ecom_EiffelComCompiler::IEnumEiffelClass * *)grt_ec_ISE.ccom_ec_pointed_cell_40 (eif_access (ppenum), NULL);
	
	hr = p_IEnumEiffelClass->Clone(tmp_ppenum);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_40 ((ecom_EiffelComCompiler::IEnumEiffelClass * *)tmp_ppenum, ppenum);
	
	grt_ce_ISE.ccom_free_memory_pointed_40 (tmp_ppenum);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_ith_item(  /* [in] */ EIF_INTEGER an_index,  /* [out] */ EIF_OBJECT rgelt )

/*-----------------------------------------------------------
	No description available.
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
	ULONG tmp_an_index = 0;
	tmp_an_index = (ULONG)an_index;
	ecom_EiffelComCompiler::IEiffelClassDescriptor * * tmp_rgelt = 0;
	tmp_rgelt = (ecom_EiffelComCompiler::IEiffelClassDescriptor * *)grt_ec_ISE.ccom_ec_pointed_cell_54 (eif_access (rgelt), NULL);
	
	hr = p_IEnumEiffelClass->ith_item(tmp_an_index,tmp_rgelt);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_54 ((ecom_EiffelComCompiler::IEiffelClassDescriptor * *)tmp_rgelt, rgelt);
	
	grt_ce_ISE.ccom_free_memory_pointed_54 (tmp_rgelt);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelComCompiler::IEnumEiffelClass_impl_proxy::ccom_count(  )

/*-----------------------------------------------------------
	No description available.
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
	
	hr = p_IEnumEiffelClass->count( &ret_value);
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