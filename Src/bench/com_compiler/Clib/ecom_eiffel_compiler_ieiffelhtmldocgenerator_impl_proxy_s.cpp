/*-----------------------------------------------------------
Implemented `IEiffelHTMLDocGenerator' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelHTMLDocGenerator_impl_proxy_s.h"
static const IID IID_IEiffelHTMLDocGenerator_ = {0x86270519,0x790f,0x48cb,{0x88,0x69,0xdb,0x06,0x18,0x4f,0x97,0xb4}};

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

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_proxy::ccom_is_loaded(  )

/*-----------------------------------------------------------
	Is the project loaded?
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
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelHTMLDocGenerator->is_loaded( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_proxy::ccom_is_corrupted(  )

/*-----------------------------------------------------------
	Is the project oorrupted?
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
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelHTMLDocGenerator->is_corrupted( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_BOOLEAN ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_proxy::ccom_is_incompatible(  )

/*-----------------------------------------------------------
	Is the project incompatible with the current version of the compiled?
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
	VARIANT_BOOL ret_value = 0;
	
	hr = p_IEiffelHTMLDocGenerator->is_incompatible( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_BOOLEAN eiffel_result =  (EIF_BOOLEAN)rt_ce.ccom_ce_boolean (ret_value);
	return (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_proxy::ccom_add_status_callback(  /* [in] */ ecom_eiffel_compiler::IEiffelHTMLDocEvents * new_callback )

/*-----------------------------------------------------------
	Add a callback interface.
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
	
	hr = p_IEiffelHTMLDocGenerator->add_status_callback(new_callback);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelHTMLDocGenerator_impl_proxy::ccom_remove_status_callback(  /* [in] */ ecom_eiffel_compiler::IEiffelHTMLDocEvents * old_callback )

/*-----------------------------------------------------------
	Remove a callback interface.
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
	
	hr = p_IEiffelHTMLDocGenerator->remove_status_callback(old_callback);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
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
	Include a cluster to be generated.
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
	Generate the HTML documents into path.
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