/*-----------------------------------------------------------
Implemented `IEiffelHTMLDocGenerator' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelHTMLDocGenerator_impl_proxy_s.h"
static const IID IID_IEiffelHTMLDocGenerator_ = {0xaf48d380,0x8f9a,0x436c,{0x97,0x63,0xae,0x1c,0x73,0x2a,0xb3,0xf1}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_proxy::IEiffelHTMLDocGenerator_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEiffelHTMLDocGenerator_, (void **)&p_IEiffelHTMLDocGenerator);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_proxy::~IEiffelHTMLDocGenerator_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEiffelHTMLDocGenerator!=NULL)
		p_IEiffelHTMLDocGenerator->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_proxy::ccom_add_excluded_cluster(  /* [in] */ EIF_OBJECT cluster_full_name )

/*-----------------------------------------------------------
	Exclude a cluster from being generated.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHTMLDocGenerator == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHTMLDocGenerator_, (void **)&p_IEiffelHTMLDocGenerator);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_cluster_full_name = 0;
	tmp_cluster_full_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (cluster_full_name));
	
	hr = p_IEiffelHTMLDocGenerator->add_excluded_cluster(tmp_cluster_full_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_cluster_full_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_proxy::ccom_remove_excluded_cluster(  /* [in] */ EIF_OBJECT cluster_full_name )

/*-----------------------------------------------------------
	Exclude a cluster from being generated.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHTMLDocGenerator == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHTMLDocGenerator_, (void **)&p_IEiffelHTMLDocGenerator);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_cluster_full_name = 0;
	tmp_cluster_full_name = (BSTR)rt_ec.ccom_ec_bstr (eif_access (cluster_full_name));
	
	hr = p_IEiffelHTMLDocGenerator->remove_excluded_cluster(tmp_cluster_full_name);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_cluster_full_name);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_proxy::ccom_generate(  /* [in] */ EIF_OBJECT path )

/*-----------------------------------------------------------
	Exclude a cluster from being generated.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelHTMLDocGenerator == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelHTMLDocGenerator_, (void **)&p_IEiffelHTMLDocGenerator);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_path = 0;
	tmp_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (path));
	
	hr = p_IEiffelHTMLDocGenerator->generate(tmp_path);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_path);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_proxy::ccom_item()

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