/*-----------------------------------------------------------
Implemented `IEnumParameter' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEnumParameter_impl_proxy.h"
static const IID IID_IEnumParameter_ = {0xe3ab1afb,0x730c,0x498f,{0xa1,0x68,0x41,0x8e,0xe4,0x82,0xa2,0xd7}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEnumParameter_impl_proxy::IEnumParameter_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEnumParameter_, (void **)&p_IEnumParameter);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumParameter_impl_proxy::~IEnumParameter_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEnumParameter!=NULL)
		p_IEnumParameter->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumParameter_impl_proxy::ccom_next(  /* [out] */ EIF_OBJECT pp_ieiffel_parameter_descriptor,  /* [out] */ EIF_OBJECT pul_fetched )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumParameter == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumParameter_, (void **)&p_IEnumParameter);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEiffelParameterDescriptor * * tmp_pp_ieiffel_parameter_descriptor = 0;
	tmp_pp_ieiffel_parameter_descriptor = (ecom_EiffelComCompiler::IEiffelParameterDescriptor * *)grt_ec_ISE_c.ccom_ec_pointed_cell_121 (eif_access (pp_ieiffel_parameter_descriptor), NULL);
	ULONG * tmp_pul_fetched = 0;
	tmp_pul_fetched = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pul_fetched), NULL);
	
	hr = p_IEnumParameter->Next(tmp_pp_ieiffel_parameter_descriptor,tmp_pul_fetched);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE_c.ccom_ce_pointed_cell_121 ((ecom_EiffelComCompiler::IEiffelParameterDescriptor * *)tmp_pp_ieiffel_parameter_descriptor, pp_ieiffel_parameter_descriptor);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pul_fetched, pul_fetched);
	
	grt_ce_ISE_c.ccom_free_memory_pointed_121 (tmp_pp_ieiffel_parameter_descriptor);
grt_ce_ISE_c.ccom_free_memory_pointed_122 (tmp_pul_fetched);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumParameter_impl_proxy::ccom_skip(  /* [in] */ EIF_INTEGER ul_count )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumParameter == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumParameter_, (void **)&p_IEnumParameter);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ul_count = 0;
	tmp_ul_count = (ULONG)ul_count;
	
	hr = p_IEnumParameter->Skip(tmp_ul_count);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumParameter_impl_proxy::ccom_reset()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumParameter == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumParameter_, (void **)&p_IEnumParameter);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IEnumParameter->Reset ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumParameter_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT pp_ienum_parameter )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumParameter == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumParameter_, (void **)&p_IEnumParameter);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEnumParameter * * tmp_pp_ienum_parameter = 0;
	tmp_pp_ienum_parameter = (ecom_EiffelComCompiler::IEnumParameter * *)grt_ec_ISE_c.ccom_ec_pointed_cell_94 (eif_access (pp_ienum_parameter), NULL);
	
	hr = p_IEnumParameter->Clone(tmp_pp_ienum_parameter);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE_c.ccom_ce_pointed_cell_94 ((ecom_EiffelComCompiler::IEnumParameter * *)tmp_pp_ienum_parameter, pp_ienum_parameter);
	
	grt_ce_ISE_c.ccom_free_memory_pointed_94 (tmp_pp_ienum_parameter);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumParameter_impl_proxy::ccom_ith_item(  /* [in] */ EIF_INTEGER ul_index,  /* [out] */ EIF_OBJECT pp_ieiffel_parameter_descriptor )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumParameter == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumParameter_, (void **)&p_IEnumParameter);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ul_index = 0;
	tmp_ul_index = (ULONG)ul_index;
	ecom_EiffelComCompiler::IEiffelParameterDescriptor * * tmp_pp_ieiffel_parameter_descriptor = 0;
	tmp_pp_ieiffel_parameter_descriptor = (ecom_EiffelComCompiler::IEiffelParameterDescriptor * *)grt_ec_ISE_c.ccom_ec_pointed_cell_121 (eif_access (pp_ieiffel_parameter_descriptor), NULL);
	
	hr = p_IEnumParameter->IthItem(tmp_ul_index,tmp_pp_ieiffel_parameter_descriptor);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE_c.ccom_ce_pointed_cell_121 ((ecom_EiffelComCompiler::IEiffelParameterDescriptor * *)tmp_pp_ieiffel_parameter_descriptor, pp_ieiffel_parameter_descriptor);
	
	grt_ce_ISE_c.ccom_free_memory_pointed_121 (tmp_pp_ieiffel_parameter_descriptor);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelComCompiler::IEnumParameter_impl_proxy::ccom_count(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumParameter == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumParameter_, (void **)&p_IEnumParameter);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG ret_value = 0;
	
	hr = p_IEnumParameter->Count( &ret_value);
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

EIF_POINTER ecom_EiffelComCompiler::IEnumParameter_impl_proxy::ccom_item()

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