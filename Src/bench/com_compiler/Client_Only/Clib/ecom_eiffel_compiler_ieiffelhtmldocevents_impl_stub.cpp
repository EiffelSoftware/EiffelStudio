/*-----------------------------------------------------------
Implemented `IEiffelHTMLDocEvents' Interface.
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_IEiffelHTMLDocEvents_impl_stub.h"
static int return_hr_value;

static const IID IID_IEiffelHTMLDocEvents_ = {0x62890dd1,0x7909,0x4a7d,{0x89,0x0d,0x51,0xdb,0xef,0xe2,0xbb,0x12}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_stub::IEiffelHTMLDocEvents_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_stub::~IEiffelHTMLDocEvents_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_stub::put_header(  /* [in] */ BSTR new_value )

/*-----------------------------------------------------------
	Put a header message to the output
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_new_value = NULL;
	if (new_value != NULL)
	{
		tmp_new_value = eif_protect (rt_ce.ccom_ce_bstr (new_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("put_header", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_new_value != NULL) ? eif_access (tmp_new_value) : NULL));
	if (tmp_new_value != NULL)
		eif_wean (tmp_new_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_stub::put_string(  /* [in] */ BSTR new_value )

/*-----------------------------------------------------------
	Put a string to the output
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_new_value = NULL;
	if (new_value != NULL)
	{
		tmp_new_value = eif_protect (rt_ce.ccom_ce_bstr (new_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("put_string", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_new_value != NULL) ? eif_access (tmp_new_value) : NULL));
	if (tmp_new_value != NULL)
		eif_wean (tmp_new_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_stub::put_class_document_message(  /* [in] */ BSTR new_value )

/*-----------------------------------------------------------
	Put a class name to the output
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_new_value = NULL;
	if (new_value != NULL)
	{
		tmp_new_value = eif_protect (rt_ce.ccom_ce_bstr (new_value));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("put_class_document_message", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_new_value != NULL) ? eif_access (tmp_new_value) : NULL));
	if (tmp_new_value != NULL)
		eif_wean (tmp_new_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_stub::put_initializing_documentation( void )

/*-----------------------------------------------------------
	Notify that documentation generating is initializing
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("put_initializing_documentation", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_stub::put_percentage_completed(  /* [in] */ ULONG new_value )

/*-----------------------------------------------------------
	Notify that the percentage completed has changed
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_new_value = (EIF_INTEGER)new_value;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("put_percentage_completed", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_new_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::IEiffelHTMLDocEvents_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelHTMLDocEvents*>(this);
	else if (riid == IID_IEiffelHTMLDocEvents_)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelHTMLDocEvents*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif