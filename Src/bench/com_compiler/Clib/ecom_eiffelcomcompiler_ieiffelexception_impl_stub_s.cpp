/*-----------------------------------------------------------
Implemented `IEiffelException' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEiffelException_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IEiffelException_ = {0xfc94930c,0x06f1,0x448e,{0xa2,0x21,0x9c,0x70,0x2b,0x9d,0xf6,0x85}};

static const IID LIBID_EiffelComCompiler_ = {0x06b5d7c0,0x2c7d,0x4d1c,{0xa9,0x8b,0x45,0x99,0xbd,0xcd,0xfa,0x58}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEiffelException_impl_stub::IEiffelException_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
	pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelException_impl_stub::~IEiffelException_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	if (pTypeInfo)
		pTypeInfo->Release ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelException_impl_stub::InnerException(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelException * * pp_ieiffel_exception )

/*-----------------------------------------------------------
	Get inner exception
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("inner_exception", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "inner_exception", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ieiffel_exception = grt_ec_ISE.ccom_ec_pointed_interface_6 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ieiffel_exception = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelException_impl_stub::Message(  /* [out, retval] */ BSTR * pbstr_message )

/*-----------------------------------------------------------
	Get exception message
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("message", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "message", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pbstr_message = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pbstr_message = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelException_impl_stub::ExceptionCode(  /* [out, retval] */ long * p_eif_exceptions )

/*-----------------------------------------------------------
	Retrieve exception type
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_INTEGER_FUNCTION eiffel_function = 0;
	eiffel_function = eif_integer_function ("exception_code", type_id);
	EIF_INTEGER tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "exception_code", EIF_INTEGER);
	*p_eif_exceptions = (long)tmp_value;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelException_impl_stub::GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo )

/*-----------------------------------------------------------
	Get type info
-----------------------------------------------------------*/
{
	if ((itinfo != 0) || (pptinfo == NULL))
		return E_INVALIDARG;
	*pptinfo = NULL;
	if (pTypeInfo == 0)
	{
		HRESULT tmp_hr = 0;
		ITypeLib *pTypeLib = 0;
		tmp_hr = LoadRegTypeLib (LIBID_EiffelComCompiler_, 2, 0, 0, &pTypeLib);
		if (FAILED(tmp_hr))
			return tmp_hr;
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelException_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	(*pptinfo = pTypeInfo)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelException_impl_stub::GetTypeInfoCount( unsigned int * pctinfo )

/*-----------------------------------------------------------
	Get type info count
-----------------------------------------------------------*/
{
	if (pctinfo == NULL)
		return E_NOTIMPL;
	*pctinfo = 1;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelException_impl_stub::GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid )

/*-----------------------------------------------------------
	IDs of function names 'rgszNames'
-----------------------------------------------------------*/
{
	if (pTypeInfo == 0)
	{
		HRESULT tmp_hr = 0;
		ITypeLib *pTypeLib = 0;
		tmp_hr = LoadRegTypeLib (LIBID_EiffelComCompiler_, 2, 0, 0, &pTypeLib);
		if (FAILED(tmp_hr))
			return tmp_hr;
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelException_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	return pTypeInfo->GetIDsOfNames (rgszNames, cNames, rgdispid);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelException_impl_stub::Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr )

/*-----------------------------------------------------------
	Invoke function.
-----------------------------------------------------------*/
{
	HRESULT hr = 0;
	int i = 0;

	unsigned int uArgErr;
	if (wFlags & ~(DISPATCH_METHOD | DISPATCH_PROPERTYGET | DISPATCH_PROPERTYPUT | DISPATCH_PROPERTYPUTREF))
		return ResultFromScode (E_INVALIDARG);

	if (puArgErr == NULL)
		puArgErr = &uArgErr;

	VARIANTARG * rgvarg = pDispParams->rgvarg;
	DISPID * rgdispidNamedArgs = pDispParams->rgdispidNamedArgs;
	unsigned int cArgs = pDispParams->cArgs;
	unsigned int cNamedArgs = pDispParams->cNamedArgs;
	VARIANTARG ** tmp_value = NULL;

	if (pExcepInfo != NULL)
	{
		pExcepInfo->wCode = 0;
		pExcepInfo->wReserved = 0;
		pExcepInfo->bstrSource = NULL;
		pExcepInfo->bstrDescription = NULL;
		pExcepInfo->bstrHelpFile = NULL;
		pExcepInfo->dwHelpContext = 0;
		pExcepInfo->pvReserved = NULL;
		pExcepInfo->pfnDeferredFillIn = NULL;
		pExcepInfo->scode = 0;
	}
	
	switch (dispID)
	{
		
		default:
			return DISP_E_MEMBERNOTFOUND;
	}
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::IEiffelException_impl_stub::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	UnlockModule ();
	LONG res = InterlockedDecrement (&ref_count);
	if (res  ==  0)
	{
		if (pTypeInfo !=NULL)
		{
			pTypeInfo->Release ();
			pTypeInfo = NULL;
		}
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::IEiffelException_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelException_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelException*>(this);
	else if (riid == IID_IDispatch)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelException*>(this);
	else if (riid == IID_IEiffelException_)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelException*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif