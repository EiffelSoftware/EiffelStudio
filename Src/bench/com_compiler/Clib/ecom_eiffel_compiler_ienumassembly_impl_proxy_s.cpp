/*-----------------------------------------------------------
Implemented `IEnumAssembly' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEnumAssembly_impl_proxy_s.h"
static const IID IID_IEnumAssembly_ = {0x67297abc,0xa19a,0x4985,{0x8f,0x7e,0x90,0xac,0x1f,0x66,0xee,0x6e}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEnumAssembly_impl_proxy::IEnumAssembly_impl_proxy( IUnknown * a_pointer )
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

ecom_eiffel_compiler::IEnumAssembly_impl_proxy::~IEnumAssembly_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEnumAssembly!=NULL)
		p_IEnumAssembly->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEnumAssembly_impl_proxy::ccom_next(  /* [out] */ EIF_OBJECT rgelt,  /* [out] */ EIF_OBJECT pcelt_fetched )

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
	ecom_eiffel_compiler::IEiffelAssemblyProperties * * tmp_rgelt = 0;
	tmp_rgelt = (ecom_eiffel_compiler::IEiffelAssemblyProperties * *)grt_ec_ISE.ccom_ec_pointed_cell_195 (eif_access (rgelt), NULL);
	ULONG * tmp_pcelt_fetched = 0;
	tmp_pcelt_fetched = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pcelt_fetched), NULL);
	
	hr = p_IEnumAssembly->Next(tmp_rgelt,tmp_pcelt_fetched);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_195 ((ecom_eiffel_compiler::IEiffelAssemblyProperties * *)tmp_rgelt, rgelt);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pcelt_fetched, pcelt_fetched);
	
	grt_ce_ISE.ccom_free_memory_pointed_195 (tmp_rgelt);
grt_ce_ISE.ccom_free_memory_pointed_216 (tmp_pcelt_fetched);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEnumAssembly_impl_proxy::ccom_skip(  /* [in] */ EIF_INTEGER celt )

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
	ULONG tmp_celt = 0;
	tmp_celt = (ULONG)celt;
	
	hr = p_IEnumAssembly->Skip(tmp_celt);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEnumAssembly_impl_proxy::ccom_reset()

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

void ecom_eiffel_compiler::IEnumAssembly_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT ppenum )

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
	ecom_eiffel_compiler::IEnumAssembly * * tmp_ppenum = 0;
	tmp_ppenum = (ecom_eiffel_compiler::IEnumAssembly * *)grt_ec_ISE.ccom_ec_pointed_cell_206 (eif_access (ppenum), NULL);
	
	hr = p_IEnumAssembly->Clone(tmp_ppenum);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_206 ((ecom_eiffel_compiler::IEnumAssembly * *)tmp_ppenum, ppenum);
	
	grt_ce_ISE.ccom_free_memory_pointed_206 (tmp_ppenum);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEnumAssembly_impl_proxy::ccom_ith_item(  /* [in] */ EIF_INTEGER an_index,  /* [out] */ EIF_OBJECT rgelt )

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
	ULONG tmp_an_index = 0;
	tmp_an_index = (ULONG)an_index;
	ecom_eiffel_compiler::IEiffelAssemblyProperties * * tmp_rgelt = 0;
	tmp_rgelt = (ecom_eiffel_compiler::IEiffelAssemblyProperties * *)grt_ec_ISE.ccom_ec_pointed_cell_195 (eif_access (rgelt), NULL);
	
	hr = p_IEnumAssembly->ith_item(tmp_an_index,tmp_rgelt);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_195 ((ecom_eiffel_compiler::IEiffelAssemblyProperties * *)tmp_rgelt, rgelt);
	
	grt_ce_ISE.ccom_free_memory_pointed_195 (tmp_rgelt);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_eiffel_compiler::IEnumAssembly_impl_proxy::ccom_count(  )

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
	
	hr = p_IEnumAssembly->count( &ret_value);
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

EIF_POINTER ecom_eiffel_compiler::IEnumAssembly_impl_proxy::ccom_item()

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