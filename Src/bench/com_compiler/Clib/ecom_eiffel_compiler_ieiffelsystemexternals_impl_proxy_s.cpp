/*-----------------------------------------------------------
Implemented `IEiffelSystemExternals' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelSystemExternals_impl_proxy_s.h"
static const IID IID_IEiffelSystemExternals_ = {0xea511e88,0x0ff6,0x407b,{0x89,0x56,0xfb,0x41,0x66,0x26,0xb6,0x2a}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelSystemExternals_impl_proxy::IEiffelSystemExternals_impl_proxy( IUnknown * a_pointer )
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

	hr = a_pointer->QueryInterface(IID_IEiffelSystemExternals_, (void **)&p_IEiffelSystemExternals);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};

};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelSystemExternals_impl_proxy::~IEiffelSystemExternals_impl_proxy()
{
	p_unknown->Release ();
	if (p_IEiffelSystemExternals!=NULL)
		p_IEiffelSystemExternals->Release ();
	CoUninitialize ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelSystemExternals_impl_proxy::ccom_store()

/*-----------------------------------------------------------
	Save changes.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemExternals == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemExternals_, (void **)&p_IEiffelSystemExternals);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	hr = p_IEiffelSystemExternals->store ();
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};	
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelSystemExternals_impl_proxy::ccom_add_include_path(  /* [in] */ EIF_OBJECT include_path )

/*-----------------------------------------------------------
	Add a include path to the project.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemExternals == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemExternals_, (void **)&p_IEiffelSystemExternals);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_include_path = 0;
	tmp_include_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (include_path));
	
	hr = p_IEiffelSystemExternals->add_include_path(tmp_include_path);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_include_path);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelSystemExternals_impl_proxy::ccom_remove_include_path(  /* [in] */ EIF_OBJECT include_path )

/*-----------------------------------------------------------
	Remove a include path from the project.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemExternals == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemExternals_, (void **)&p_IEiffelSystemExternals);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_include_path = 0;
	tmp_include_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (include_path));
	
	hr = p_IEiffelSystemExternals->remove_include_path(tmp_include_path);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_include_path);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelSystemExternals_impl_proxy::ccom_replace_include_path(  /* [in] */ EIF_OBJECT new_include_path,  /* [in] */ EIF_OBJECT old_include_path )

/*-----------------------------------------------------------
	Replace an include path in the project.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemExternals == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemExternals_, (void **)&p_IEiffelSystemExternals);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_new_include_path = 0;
	tmp_new_include_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (new_include_path));
	BSTR tmp_old_include_path = 0;
	tmp_old_include_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (old_include_path));
	
	hr = p_IEiffelSystemExternals->replace_include_path(tmp_new_include_path,tmp_old_include_path);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_new_include_path);
rt_ce.free_memory_bstr (tmp_old_include_path);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemExternals_impl_proxy::ccom_include_paths(  )

/*-----------------------------------------------------------
	Include paths.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemExternals == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemExternals_, (void **)&p_IEiffelSystemExternals);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_eiffel_compiler::IEnumIncludePaths * ret_value = 0;
	
	hr = p_IEiffelSystemExternals->include_paths( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_218 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelSystemExternals_impl_proxy::ccom_add_object_file(  /* [in] */ EIF_OBJECT object_file )

/*-----------------------------------------------------------
	Add a object file to the project.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemExternals == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemExternals_, (void **)&p_IEiffelSystemExternals);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_object_file = 0;
	tmp_object_file = (BSTR)rt_ec.ccom_ec_bstr (eif_access (object_file));
	
	hr = p_IEiffelSystemExternals->add_object_file(tmp_object_file);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_object_file);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelSystemExternals_impl_proxy::ccom_remove_object_file(  /* [in] */ EIF_OBJECT object_file )

/*-----------------------------------------------------------
	Remove a object file from the project.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemExternals == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemExternals_, (void **)&p_IEiffelSystemExternals);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_object_file = 0;
	tmp_object_file = (BSTR)rt_ec.ccom_ec_bstr (eif_access (object_file));
	
	hr = p_IEiffelSystemExternals->remove_object_file(tmp_object_file);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_object_file);

};
/*----------------------------------------------------------------------------------------------------------------------*/

void ecom_eiffel_compiler::IEiffelSystemExternals_impl_proxy::ccom_replace_object_file(  /* [in] */ EIF_OBJECT new_include_path,  /* [in] */ EIF_OBJECT old_object_file )

/*-----------------------------------------------------------
	Replace an object file in the project.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemExternals == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemExternals_, (void **)&p_IEiffelSystemExternals);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	BSTR tmp_new_include_path = 0;
	tmp_new_include_path = (BSTR)rt_ec.ccom_ec_bstr (eif_access (new_include_path));
	BSTR tmp_old_object_file = 0;
	tmp_old_object_file = (BSTR)rt_ec.ccom_ec_bstr (eif_access (old_object_file));
	
	hr = p_IEiffelSystemExternals->replace_object_file(tmp_new_include_path,tmp_old_object_file);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	rt_ce.free_memory_bstr (tmp_new_include_path);
rt_ce.free_memory_bstr (tmp_old_object_file);

};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_REFERENCE ecom_eiffel_compiler::IEiffelSystemExternals_impl_proxy::ccom_object_files(  )

/*-----------------------------------------------------------
	Object files.
-----------------------------------------------------------*/
{
	HRESULT hr;
	if (p_IEiffelSystemExternals == NULL)
	{
		hr = p_unknown->QueryInterface (IID_IEiffelSystemExternals_, (void **)&p_IEiffelSystemExternals);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	};
	ecom_eiffel_compiler::IEnumObjectFiles * ret_value = 0;
	
	hr = p_IEiffelSystemExternals->object_files( &ret_value);
	if (FAILED (hr))
	{
		if ((HRESULT_FACILITY (hr)  ==  FACILITY_ITF) && (HRESULT_CODE (hr) > 1024) && (HRESULT_CODE (hr) < 1053))
			com_eraise (rt_ec.ccom_ec_lpstr (eename(HRESULT_CODE (hr) - 1024), NULL),HRESULT_CODE (hr) - 1024);
		com_eraise (f.c_format_message (hr), EN_PROG);
	};
	
	
	EIF_REFERENCE eiffel_result = eif_protect ((EIF_REFERENCE)grt_ce_ISE.ccom_ce_pointed_interface_221 (ret_value));
	return eif_wean (eiffel_result);
};
/*----------------------------------------------------------------------------------------------------------------------*/

EIF_POINTER ecom_eiffel_compiler::IEiffelSystemExternals_impl_proxy::ccom_item()

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