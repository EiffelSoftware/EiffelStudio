/*-----------------------------------------------------------
Implemented `IEnumFeature' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEnumFeature_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IEnumFeature_ = {0xdc003e49,0x6c17,0x4be2,{0xbd,0x81,0x3d,0x35,0x40,0xb7,0x38,0xb1}};

static const IID LIBID_EiffelComCompiler_ = {0x06b5d7c0,0x2c7d,0x4d1c,{0xa9,0x8b,0x45,0x99,0xbd,0xcd,0xfa,0x58}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEnumFeature_impl_stub::IEnumFeature_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
	pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEnumFeature_impl_stub::~IEnumFeature_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	if (pTypeInfo)
		pTypeInfo->Release ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumFeature_impl_stub::Next(  /* [out] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * pp_ieiffel_feature_descriptor, /* [out] */ ULONG * pul_fetched )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_ieiffel_feature_descriptor = NULL;
	if (pp_ieiffel_feature_descriptor != NULL)
	{
		tmp_pp_ieiffel_feature_descriptor = eif_protect (grt_ce_ISE.ccom_ce_pointed_cell_56 (pp_ieiffel_feature_descriptor, NULL));
		if (*pp_ieiffel_feature_descriptor != NULL)
			(*pp_ieiffel_feature_descriptor)->AddRef ();
	}
	EIF_OBJECT tmp_pul_fetched = NULL;
	if (pul_fetched != NULL)
	{
		tmp_pul_fetched = eif_protect (rt_ce.ccom_ce_pointed_unsigned_long (pul_fetched, NULL));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("next", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_ieiffel_feature_descriptor != NULL) ? eif_access (tmp_pp_ieiffel_feature_descriptor) : NULL), ((tmp_pul_fetched != NULL) ? eif_access (tmp_pul_fetched) : NULL));
	
	if (*pp_ieiffel_feature_descriptor != NULL)
		(*pp_ieiffel_feature_descriptor)->Release ();
	grt_ec_ISE.ccom_ec_pointed_cell_56 (((tmp_pp_ieiffel_feature_descriptor != NULL) ? eif_wean (tmp_pp_ieiffel_feature_descriptor) : NULL), pp_ieiffel_feature_descriptor);
	rt_ec.ccom_ec_pointed_unsigned_long (((tmp_pul_fetched != NULL) ? eif_wean (tmp_pul_fetched) : NULL), pul_fetched);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumFeature_impl_stub::Skip(  /* [in] */ ULONG ul_count )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_ul_count = (EIF_INTEGER)ul_count;
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("skip", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_ul_count);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumFeature_impl_stub::Reset( void )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("reset", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumFeature_impl_stub::Clone(  /* [out] */ ecom_EiffelComCompiler::IEnumFeature * * pp_ienum_feature )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_pp_ienum_feature = NULL;
	if (pp_ienum_feature != NULL)
	{
		tmp_pp_ienum_feature = eif_protect (grt_ce_ISE.ccom_ce_pointed_cell_59 (pp_ienum_feature, NULL));
		if (*pp_ienum_feature != NULL)
			(*pp_ienum_feature)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("clone1", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_pp_ienum_feature != NULL) ? eif_access (tmp_pp_ienum_feature) : NULL));
	
	if (*pp_ienum_feature != NULL)
		(*pp_ienum_feature)->Release ();
	grt_ec_ISE.ccom_ec_pointed_cell_59 (((tmp_pp_ienum_feature != NULL) ? eif_wean (tmp_pp_ienum_feature) : NULL), pp_ienum_feature);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumFeature_impl_stub::IthItem(  /* [in] */ ULONG ul_index, /* [out] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * pp_ieiffel_feature_descriptor )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_INTEGER tmp_ul_index = (EIF_INTEGER)ul_index;
	EIF_OBJECT tmp_pp_ieiffel_feature_descriptor = NULL;
	if (pp_ieiffel_feature_descriptor != NULL)
	{
		tmp_pp_ieiffel_feature_descriptor = eif_protect (grt_ce_ISE.ccom_ce_pointed_cell_56 (pp_ieiffel_feature_descriptor, NULL));
		if (*pp_ieiffel_feature_descriptor != NULL)
			(*pp_ieiffel_feature_descriptor)->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("ith_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), (EIF_INTEGER)tmp_ul_index, ((tmp_pp_ieiffel_feature_descriptor != NULL) ? eif_access (tmp_pp_ieiffel_feature_descriptor) : NULL));
	
	if (*pp_ieiffel_feature_descriptor != NULL)
		(*pp_ieiffel_feature_descriptor)->Release ();
	grt_ec_ISE.ccom_ec_pointed_cell_56 (((tmp_pp_ieiffel_feature_descriptor != NULL) ? eif_wean (tmp_pp_ieiffel_feature_descriptor) : NULL), pp_ieiffel_feature_descriptor);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumFeature_impl_stub::Count(  /* [out, retval] */ ULONG * ul_count )

/*-----------------------------------------------------------
	No description available.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_INTEGER_FUNCTION eiffel_function = 0;
	eiffel_function = eif_integer_function ("count", type_id);
	EIF_INTEGER tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "count", EIF_INTEGER);
	*ul_count = (ULONG)tmp_value;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumFeature_impl_stub::GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo )

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
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEnumFeature_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	(*pptinfo = pTypeInfo)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumFeature_impl_stub::GetTypeInfoCount( unsigned int * pctinfo )

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

STDMETHODIMP ecom_EiffelComCompiler::IEnumFeature_impl_stub::GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid )

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
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEnumFeature_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	return pTypeInfo->GetIDsOfNames (rgszNames, cNames, rgdispid);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumFeature_impl_stub::Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr )

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

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::IEnumFeature_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::IEnumFeature_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEnumFeature_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_EiffelComCompiler::IEnumFeature*>(this);
	else if (riid == IID_IDispatch)
		*ppv = static_cast<ecom_EiffelComCompiler::IEnumFeature*>(this);
	else if (riid == IID_IEnumFeature_)
		*ppv = static_cast<ecom_EiffelComCompiler::IEnumFeature*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif