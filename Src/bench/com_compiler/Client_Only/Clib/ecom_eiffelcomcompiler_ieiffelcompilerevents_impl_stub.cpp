/*-----------------------------------------------------------
Implemented `IEiffelCompilerEvents' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEiffelCompilerEvents_impl_stub.h"
static int return_hr_value;

static const IID IID_IEiffelCompilerEvents_ = {0x75b32e73,0xa00e,0x4bcf,{0x9a,0x7a,0x13,0xd4,0x1e,0x63,0x59,0xb4}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_stub::IEiffelCompilerEvents_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_stub::~IEiffelCompilerEvents_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_stub::BeginCompile( void )

/*-----------------------------------------------------------
	Beginning compilation.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("begin_compile", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_stub::BeginDegree(  /* [in] */ LONG ul_degree )

/*-----------------------------------------------------------
	Start of new degree phase in compilation.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_ul_degree = (EIF_INTEGER)ul_degree;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("begin_degree", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_ul_degree);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_stub::EndCompile(  /* [in] */ VARIANT_BOOL vb_sucessful )

/*-----------------------------------------------------------
	Finished compilation.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_BOOLEAN tmp_vb_sucessful = rt_ce.ccom_ce_boolean (vb_sucessful);
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("end_compile", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_BOOLEAN))eiffel_procedure) (eif_access (eiffel_object), (EIF_BOOLEAN)tmp_vb_sucessful);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_stub::ShouldContinue(  /* [in, out] */ VARIANT_BOOL * pvb_continue )

/*-----------------------------------------------------------
	Should compilation continue.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pvb_continue = NULL;
	if (pvb_continue != NULL)
	{
		tmp_pvb_continue = eif_protect (rt_ce.ccom_ce_pointed_boolean (pvb_continue, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("should_continue", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pvb_continue != NULL) ? eif_access (tmp_pvb_continue) : NULL));
	rt_ec.ccom_ec_pointed_boolean (((tmp_pvb_continue != NULL) ? eif_wean (tmp_pvb_continue) : NULL), pvb_continue);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_stub::OutputString(  /* [in] */ BSTR bstr_output )

/*-----------------------------------------------------------
	Output string.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_output = NULL;
	if (bstr_output != NULL)
	{
		tmp_bstr_output = eif_protect (rt_ce.ccom_ce_bstr (bstr_output));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("output_string", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_bstr_output != NULL) ? eif_access (tmp_bstr_output) : NULL));
	if (tmp_bstr_output != NULL)
		eif_wean (tmp_bstr_output);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_stub::OutputError(  /* [in] */ BSTR bstr_full_error, /* [in] */ BSTR bstr_short_error, /* [in] */ BSTR bstr_code, /* [in] */ BSTR bstr_file_name, /* [in] */ ULONG ul_line, /* [in] */ ULONG ul_col )

/*-----------------------------------------------------------
	Last error.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_full_error = NULL;
	if (bstr_full_error != NULL)
	{
		tmp_bstr_full_error = eif_protect (rt_ce.ccom_ce_bstr (bstr_full_error));
	}
	EIF_OBJECT tmp_bstr_short_error = NULL;
	if (bstr_short_error != NULL)
	{
		tmp_bstr_short_error = eif_protect (rt_ce.ccom_ce_bstr (bstr_short_error));
	}
	EIF_OBJECT tmp_bstr_code = NULL;
	if (bstr_code != NULL)
	{
		tmp_bstr_code = eif_protect (rt_ce.ccom_ce_bstr (bstr_code));
	}
	EIF_OBJECT tmp_bstr_file_name = NULL;
	if (bstr_file_name != NULL)
	{
		tmp_bstr_file_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_file_name));
	}
	EIF_INTEGER tmp_ul_line = (EIF_INTEGER)ul_line;
	EIF_INTEGER tmp_ul_col = (EIF_INTEGER)ul_col;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("output_error", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_bstr_full_error != NULL) ? eif_access (tmp_bstr_full_error) : NULL), ((tmp_bstr_short_error != NULL) ? eif_access (tmp_bstr_short_error) : NULL), ((tmp_bstr_code != NULL) ? eif_access (tmp_bstr_code) : NULL), ((tmp_bstr_file_name != NULL) ? eif_access (tmp_bstr_file_name) : NULL), (EIF_INTEGER)tmp_ul_line, (EIF_INTEGER)tmp_ul_col);
	if (tmp_bstr_full_error != NULL)
		eif_wean (tmp_bstr_full_error);
	if (tmp_bstr_short_error != NULL)
		eif_wean (tmp_bstr_short_error);
	if (tmp_bstr_code != NULL)
		eif_wean (tmp_bstr_code);
	if (tmp_bstr_file_name != NULL)
		eif_wean (tmp_bstr_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_stub::OutputWarning(  /* [in] */ BSTR bstr_full_warning, /* [in] */ BSTR bstr_short_warning, /* [in] */ BSTR bstr_code, /* [in] */ BSTR bstr_file_name, /* [in] */ ULONG ul_line, /* [in] */ ULONG ul_col )

/*-----------------------------------------------------------
	Last warning.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_full_warning = NULL;
	if (bstr_full_warning != NULL)
	{
		tmp_bstr_full_warning = eif_protect (rt_ce.ccom_ce_bstr (bstr_full_warning));
	}
	EIF_OBJECT tmp_bstr_short_warning = NULL;
	if (bstr_short_warning != NULL)
	{
		tmp_bstr_short_warning = eif_protect (rt_ce.ccom_ce_bstr (bstr_short_warning));
	}
	EIF_OBJECT tmp_bstr_code = NULL;
	if (bstr_code != NULL)
	{
		tmp_bstr_code = eif_protect (rt_ce.ccom_ce_bstr (bstr_code));
	}
	EIF_OBJECT tmp_bstr_file_name = NULL;
	if (bstr_file_name != NULL)
	{
		tmp_bstr_file_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_file_name));
	}
	EIF_INTEGER tmp_ul_line = (EIF_INTEGER)ul_line;
	EIF_INTEGER tmp_ul_col = (EIF_INTEGER)ul_col;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("output_warning", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_bstr_full_warning != NULL) ? eif_access (tmp_bstr_full_warning) : NULL), ((tmp_bstr_short_warning != NULL) ? eif_access (tmp_bstr_short_warning) : NULL), ((tmp_bstr_code != NULL) ? eif_access (tmp_bstr_code) : NULL), ((tmp_bstr_file_name != NULL) ? eif_access (tmp_bstr_file_name) : NULL), (EIF_INTEGER)tmp_ul_line, (EIF_INTEGER)tmp_ul_col);
	if (tmp_bstr_full_warning != NULL)
		eif_wean (tmp_bstr_full_warning);
	if (tmp_bstr_short_warning != NULL)
		eif_wean (tmp_bstr_short_warning);
	if (tmp_bstr_code != NULL)
		eif_wean (tmp_bstr_code);
	if (tmp_bstr_file_name != NULL)
		eif_wean (tmp_bstr_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_stub::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	LONG res = InterlockedDecrement (&ref_count);
	if (res  ==  0)
	{
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompilerEvents_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelCompilerEvents*>(this);
	else if (riid == IID_IEiffelCompilerEvents_)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelCompilerEvents*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif