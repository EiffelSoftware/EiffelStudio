/*-----------------------------------------------------------
Implemented `IEnumObjectFiles' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEnumObjectFiles_impl_proxy_s.h"
static const IID IID_IEnumObjectFiles_ = {0x5ce55179,0x0954,0x44f9,{0x9e,0x1f,0xa7,0x44,0x56,0x64,0x20,0x47}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEnumObjectFiles_impl_proxy::IEnumObjectFiles_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEnumObjectFiles_, (void **)&p_IEnumObjectFiles);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEnumObjectFiles_impl_proxy::~IEnumObjectFiles_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEnumObjectFiles!=NULL)
		p_IEnumObjectFiles->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEnumObjectFiles_impl_proxy::ccom_next(  /* [out] */ EIF_OBJECT rgelt,  /* [out] */ EIF_OBJECT pcelt_fetched )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumObjectFiles == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumObjectFiles_, (void **)&p_IEnumObjectFiles);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR * tmp_rgelt = 0;
	tmp_rgelt = (BSTR *)grt_ec_ISE.ccom_ec_pointed_cell_186 (eif_access (rgelt), NULL);
	ULONG * tmp_pcelt_fetched = 0;
	tmp_pcelt_fetched = (ULONG *)rt_ec.ccom_ec_pointed_unsigned_long (eif_access (pcelt_fetched), NULL);
	
	hr = p_IEnumObjectFiles->Next(tmp_rgelt,tmp_pcelt_fetched);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_186 ((BSTR *)tmp_rgelt, rgelt);
	rt_ce.ccom_ce_pointed_unsigned_long ((ULONG *)tmp_pcelt_fetched, pcelt_fetched);
	
	grt_ce_ISE.ccom_free_memory_pointed_186 (tmp_rgelt);
grt_ce_ISE.ccom_free_memory_pointed_187 (tmp_pcelt_fetched);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEnumObjectFiles_impl_proxy::ccom_skip(  /* [in] */ EIF_INTEGER celt )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumObjectFiles == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumObjectFiles_, (void **)&p_IEnumObjectFiles);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_celt = 0;
	tmp_celt = (ULONG)celt;
	
	hr = p_IEnumObjectFiles->Skip(tmp_celt);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEnumObjectFiles_impl_proxy::ccom_reset()

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumObjectFiles == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumObjectFiles_, (void **)&p_IEnumObjectFiles);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IEnumObjectFiles->Reset ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEnumObjectFiles_impl_proxy::ccom_clone1(  /* [out] */ EIF_OBJECT ppenum )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumObjectFiles == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumObjectFiles_, (void **)&p_IEnumObjectFiles);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_eiffel_compiler::IEnumObjectFiles * * tmp_ppenum = 0;
	tmp_ppenum = (ecom_eiffel_compiler::IEnumObjectFiles * *)grt_ec_ISE.ccom_ec_pointed_cell_181 (eif_access (ppenum), NULL);
	
	hr = p_IEnumObjectFiles->Clone(tmp_ppenum);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_181 ((ecom_eiffel_compiler::IEnumObjectFiles * *)tmp_ppenum, ppenum);
	
	grt_ce_ISE.ccom_free_memory_pointed_181 (tmp_ppenum);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEnumObjectFiles_impl_proxy::ccom_ith_item(  /* [in] */ EIF_INTEGER an_index,  /* [out] */ EIF_OBJECT rgelt )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumObjectFiles == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumObjectFiles_, (void **)&p_IEnumObjectFiles);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG tmp_an_index = 0;
	tmp_an_index = (ULONG)an_index;
	BSTR * tmp_rgelt = 0;
	tmp_rgelt = (BSTR *)grt_ec_ISE.ccom_ec_pointed_cell_188 (eif_access (rgelt), NULL);
	
	hr = p_IEnumObjectFiles->ith_item(tmp_an_index,tmp_rgelt);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	grt_ce_ISE.ccom_ce_pointed_cell_188 ((BSTR *)tmp_rgelt, rgelt);
	
	grt_ce_ISE.ccom_free_memory_pointed_188 (tmp_rgelt);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_INTEGER ecom_eiffel_compiler::IEnumObjectFiles_impl_proxy::ccom_count(  )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEnumObjectFiles == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEnumObjectFiles_, (void **)&p_IEnumObjectFiles);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ULONG ret_value = 0;
	
	hr = p_IEnumObjectFiles->count( &ret_value);
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

EIF_POINTER ecom_eiffel_compiler::IEnumObjectFiles_impl_proxy::ccom_item()

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