/*-----------------------------------------------------------
Implemented `IEnumAssembly' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEnumAssembly_impl_proxy.h"
static const IID IID_IEnumAssembly_ = {0xb8a7d9f4,0xb23b,0x45a9,{0xb3,0xb1,0x2e,0x0e,0x00,0x4f,0xfb,0x8d}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEnumAssembly_impl_proxy::IEnumAssembly_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEnumAssembly_, (void **)&p_IEnumAssembly);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumAssembly_impl_proxy::~IEnumAssembly_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEnumAssembly!=NULL)
		p_IEnumAssembly->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumAssembly_impl_proxy::ccom_next(  /* [out] */ EIF_OBJECT pp_ieiffel_assembly_properties,  /* [out] */ EIF_OBJECT pul_fetched )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumAssembly == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumAssembly_, (void **)&p_IEnumAssembly);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEiffelAssemblyProperties * * tmp_pp_ieiffel_assembly_properties = 0;
	tmp_pp_ieiffel_assembly_properties = (ecom_EiffelComCompiler::IEiffelAssemblyProperties * *)grt_ec_ISE_c.ccom_ec_pointed_cell_139 (eif_access (pp_ieiffel_assembly_properties), NULL);
	ULONG * tmp_pul_fetched = 0;
	tmp_pul_fetched = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pul_fetched), NULL);
	
	hr = p_IEnumAssembly->Next(tmp_pp_ieiffel_assembly_properties,tmp_pul_fetched);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE_c.ccom_ce_pointed_cell_139 ((ecom_EiffelComCompiler::IEiffelAssemblyProperties * *)tmp_pp_ieiffel_assembly_properties, pp_ieiffel_assembly_properties);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pul_fetched, pul_fetched);
	
	grt_ce_ISE_c.ccom_free_memory_pointed_139 (tmp_pp_ieiffel_assembly_properties);
grt_ce_ISE_c.ccom_free_memory_pointed_140 (tmp_pul_fetched);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumAssembly_impl_proxy::ccom_skip(  /* [in] */ EIF_INTEGER ul_count )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumAssembly == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumAssembly_, (void **)&p_IEnumAssembly);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ul_count = 0;
	tmp_ul_count = (ULONG)ul_count;
	
	hr = p_IEnumAssembly->Skip(tmp_ul_count);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumAssembly_impl_proxy::ccom_reset()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumAssembly == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumAssembly_, (void **)&p_IEnumAssembly);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IEnumAssembly->Reset ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumAssembly_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT pp_ienum_assembly )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumAssembly == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumAssembly_, (void **)&p_IEnumAssembly);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_EiffelComCompiler::IEnumAssembly * * tmp_pp_ienum_assembly = 0;
	tmp_pp_ienum_assembly = (ecom_EiffelComCompiler::IEnumAssembly * *)grt_ec_ISE_c.ccom_ec_pointed_cell_46 (eif_access (pp_ienum_assembly), NULL);
	
	hr = p_IEnumAssembly->Clone(tmp_pp_ienum_assembly);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE_c.ccom_ce_pointed_cell_46 ((ecom_EiffelComCompiler::IEnumAssembly * *)tmp_pp_ienum_assembly, pp_ienum_assembly);
	
	grt_ce_ISE_c.ccom_free_memory_pointed_46 (tmp_pp_ienum_assembly);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_EiffelComCompiler::IEnumAssembly_impl_proxy::ccom_ith_item(  /* [in] */ EIF_INTEGER ul_count,  /* [out] */ EIF_OBJECT pp_ieiffel_assembly_properties )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumAssembly == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumAssembly_, (void **)&p_IEnumAssembly);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_ul_count = 0;
	tmp_ul_count = (ULONG)ul_count;
	ecom_EiffelComCompiler::IEiffelAssemblyProperties * * tmp_pp_ieiffel_assembly_properties = 0;
	tmp_pp_ieiffel_assembly_properties = (ecom_EiffelComCompiler::IEiffelAssemblyProperties * *)grt_ec_ISE_c.ccom_ec_pointed_cell_139 (eif_access (pp_ieiffel_assembly_properties), NULL);
	
	hr = p_IEnumAssembly->IthItem(tmp_ul_count,tmp_pp_ieiffel_assembly_properties);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE_c.ccom_ce_pointed_cell_139 ((ecom_EiffelComCompiler::IEiffelAssemblyProperties * *)tmp_pp_ieiffel_assembly_properties, pp_ieiffel_assembly_properties);
	
	grt_ce_ISE_c.ccom_free_memory_pointed_139 (tmp_pp_ieiffel_assembly_properties);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_EiffelComCompiler::IEnumAssembly_impl_proxy::ccom_count(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumAssembly == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumAssembly_, (void **)&p_IEnumAssembly);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG ret_value = 0;
	
	hr = p_IEnumAssembly->Count( &ret_value);
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

EIF_POINTER ecom_EiffelComCompiler::IEnumAssembly_impl_proxy::ccom_item()

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