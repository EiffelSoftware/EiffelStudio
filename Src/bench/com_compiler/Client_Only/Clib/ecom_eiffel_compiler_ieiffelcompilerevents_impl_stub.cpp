/*-----------------------------------------------------------
Implemented `IEiffelCompilerEvents' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelCompilerEvents_impl_stub.h"
static int return_hr_value;

static const IID IID_IEiffelCompilerEvents_ = {0xb16070bd,0xdece,0x4e7a,{0x80,0x3c,0xf7,0xa4,0x59,0x24,0xcb,0x88}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelCompilerEvents_impl_stub::IEiffelCompilerEvents_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelCompilerEvents_impl_stub::~IEiffelCompilerEvents_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelCompilerEvents_impl_stub::should_continue(  /* [in, out] */ VARIANT_BOOL * a_boolean )

/*-----------------------------------------------------------
	Should compilation continue.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_boolean = NULL;
	if (a_boolean != NULL)
	{
		tmp_a_boolean = eif_protect (rt_ce.ccom_ce_pointed_boolean (a_boolean, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("should_continue", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_a_boolean != NULL) ? eif_access (tmp_a_boolean) : NULL));
	rt_ec.ccom_ec_pointed_boolean (((tmp_a_boolean != NULL) ? eif_wean (tmp_a_boolean) : NULL), a_boolean);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelCompilerEvents_impl_stub::output_string(  /* [in] */ BSTR a_string )

/*-----------------------------------------------------------
	Output string.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_string = NULL;
	if (a_string != NULL)
	{
		tmp_a_string = eif_protect (rt_ce.ccom_ce_bstr (a_string));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("output_string", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_a_string != NULL) ? eif_access (tmp_a_string) : NULL));
	if (tmp_a_string != NULL)
		eif_wean (tmp_a_string);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelCompilerEvents_impl_stub::last_error(  /* [in] */ BSTR error_message, /* [in] */ BSTR file_name, /* [in] */ ULONG line_number )

/*-----------------------------------------------------------
	Last error.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_error_message = NULL;
	if (error_message != NULL)
	{
		tmp_error_message = eif_protect (rt_ce.ccom_ce_bstr (error_message));
	}
	EIF_OBJECT tmp_file_name = NULL;
	if (file_name != NULL)
	{
		tmp_file_name = eif_protect (rt_ce.ccom_ce_bstr (file_name));
	}
	EIF_INTEGER tmp_line_number = (EIF_INTEGER)line_number;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("last_error", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), ((tmp_error_message != NULL) ? eif_access (tmp_error_message) : NULL), ((tmp_file_name != NULL) ? eif_access (tmp_file_name) : NULL), (EIF_INTEGER)tmp_line_number);
	if (tmp_error_message != NULL)
		eif_wean (tmp_error_message);
	if (tmp_file_name != NULL)
		eif_wean (tmp_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelCompilerEvents_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelCompilerEvents_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelCompilerEvents_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelCompilerEvents*>(this);
	else if (riid == IID_IEiffelCompilerEvents_)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelCompilerEvents*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif