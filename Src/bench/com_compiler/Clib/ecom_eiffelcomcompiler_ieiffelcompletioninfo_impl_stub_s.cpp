/*-----------------------------------------------------------
Implemented `IEiffelCompletionInfo' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEiffelCompletionInfo_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IEiffelCompletionInfo_ = {0x8630e639,0xedae,0x46b7,{0x88,0x0b,0x27,0xd6,0x8e,0x71,0x84,0xfa}};

static const IID LIBID_EiffelComCompiler_ = {0x06b5d7c0,0x2c7d,0x4d1c,{0xa9,0x8b,0x45,0x99,0xbd,0xcd,0xfa,0x58}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::IEiffelCompletionInfo_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
	pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::~IEiffelCompletionInfo_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	if (pTypeInfo)
		pTypeInfo->Release ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::AddLocal(  /* [in] */ BSTR bstr_name, /* [in] */ BSTR bstr_type )

/*-----------------------------------------------------------
	Add a local variable used for solving member completion list
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_name = NULL;
	if (bstr_name != NULL)
	{
		tmp_bstr_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_name));
	}
	EIF_OBJECT tmp_bstr_type = NULL;
	if (bstr_type != NULL)
	{
		tmp_bstr_type = eif_protect (rt_ce.ccom_ce_bstr (bstr_type));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_local", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_bstr_name != NULL) ? eif_access (tmp_bstr_name) : NULL), ((tmp_bstr_type != NULL) ? eif_access (tmp_bstr_type) : NULL));
	if (tmp_bstr_name != NULL)
		eif_wean (tmp_bstr_name);
	if (tmp_bstr_type != NULL)
		eif_wean (tmp_bstr_type);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::AddArgument(  /* [in] */ BSTR bstr_name, /* [in] */ BSTR bstr_type )

/*-----------------------------------------------------------
	Add an argument used for solving member completion list
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_name = NULL;
	if (bstr_name != NULL)
	{
		tmp_bstr_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_name));
	}
	EIF_OBJECT tmp_bstr_type = NULL;
	if (bstr_type != NULL)
	{
		tmp_bstr_type = eif_protect (rt_ce.ccom_ce_bstr (bstr_type));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_argument", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_bstr_name != NULL) ? eif_access (tmp_bstr_name) : NULL), ((tmp_bstr_type != NULL) ? eif_access (tmp_bstr_type) : NULL));
	if (tmp_bstr_name != NULL)
		eif_wean (tmp_bstr_name);
	if (tmp_bstr_type != NULL)
		eif_wean (tmp_bstr_type);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::TargetFeatures(  /* [in] */ BSTR bstr_target, /* [in] */ BSTR bstr_feature_name, /* [in] */ BSTR bstr_file_name, /* [out] */ VARIANT * pvar_names, /* [out] */ VARIANT * pvar_signatures, /* [out] */ VARIANT * pvar_image_indexes )

/*-----------------------------------------------------------
	Features accessible from target.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_target = NULL;
	if (bstr_target != NULL)
	{
		tmp_bstr_target = eif_protect (rt_ce.ccom_ce_bstr (bstr_target));
	}
	EIF_OBJECT tmp_bstr_feature_name = NULL;
	if (bstr_feature_name != NULL)
	{
		tmp_bstr_feature_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_feature_name));
	}
	EIF_OBJECT tmp_bstr_file_name = NULL;
	if (bstr_file_name != NULL)
	{
		tmp_bstr_file_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_file_name));
	}
	EIF_OBJECT tmp_pvar_names = NULL;
	if (pvar_names != NULL)
	{
		tmp_pvar_names = eif_protect (grt_ce_ISE.ccom_ce_pointed_record_231 (pvar_names));
	}
	EIF_OBJECT tmp_pvar_signatures = NULL;
	if (pvar_signatures != NULL)
	{
		tmp_pvar_signatures = eif_protect (grt_ce_ISE.ccom_ce_pointed_record_232 (pvar_signatures));
	}
	EIF_OBJECT tmp_pvar_image_indexes = NULL;
	if (pvar_image_indexes != NULL)
	{
		tmp_pvar_image_indexes = eif_protect (grt_ce_ISE.ccom_ce_pointed_record_233 (pvar_image_indexes));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("target_features", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_bstr_target != NULL) ? eif_access (tmp_bstr_target) : NULL), ((tmp_bstr_feature_name != NULL) ? eif_access (tmp_bstr_feature_name) : NULL), ((tmp_bstr_file_name != NULL) ? eif_access (tmp_bstr_file_name) : NULL), ((tmp_pvar_names != NULL) ? eif_access (tmp_pvar_names) : NULL), ((tmp_pvar_signatures != NULL) ? eif_access (tmp_pvar_signatures) : NULL), ((tmp_pvar_image_indexes != NULL) ? eif_access (tmp_pvar_image_indexes) : NULL));
	
	
	
	if (tmp_bstr_target != NULL)
		eif_wean (tmp_bstr_target);
	if (tmp_bstr_feature_name != NULL)
		eif_wean (tmp_bstr_feature_name);
	if (tmp_bstr_file_name != NULL)
		eif_wean (tmp_bstr_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::TargetFeature(  /* [in] */ BSTR bstr_target, /* [in] */ BSTR bstr_feature_name, /* [in] */ BSTR bstr_file_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * pp_ieiffel_feature_descriptor )

/*-----------------------------------------------------------
	Feature information
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_target = NULL;
	if (bstr_target != NULL)
	{
		tmp_bstr_target = eif_protect (rt_ce.ccom_ce_bstr (bstr_target));
	}
	EIF_OBJECT tmp_bstr_feature_name = NULL;
	if (bstr_feature_name != NULL)
	{
		tmp_bstr_feature_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_feature_name));
	}
	EIF_OBJECT tmp_bstr_file_name = NULL;
	if (bstr_file_name != NULL)
	{
		tmp_bstr_file_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_file_name));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("target_feature", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_bstr_target != NULL) ? eif_access (tmp_bstr_target) : NULL), ((tmp_bstr_feature_name != NULL) ? eif_access (tmp_bstr_feature_name) : NULL), ((tmp_bstr_file_name != NULL) ? eif_access (tmp_bstr_file_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "target_feature", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ieiffel_feature_descriptor = grt_ec_ISE.ccom_ec_pointed_interface_55 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ieiffel_feature_descriptor = NULL;
	if (tmp_bstr_target != NULL)
		eif_wean (tmp_bstr_target);
	if (tmp_bstr_feature_name != NULL)
		eif_wean (tmp_bstr_feature_name);
	if (tmp_bstr_file_name != NULL)
		eif_wean (tmp_bstr_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::FlushCompletionFeatures(  /* [in] */ BSTR bstr_file_name )

/*-----------------------------------------------------------
	Flush temporary completion features for a specific file
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_file_name = NULL;
	if (bstr_file_name != NULL)
	{
		tmp_bstr_file_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_file_name));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("flush_completion_features", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_bstr_file_name != NULL) ? eif_access (tmp_bstr_file_name) : NULL));
	if (tmp_bstr_file_name != NULL)
		eif_wean (tmp_bstr_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::InitializeFeature(  /* [in] */ BSTR bstr_name, /* [in] */ VARIANT var_arguments, /* [in] */ VARIANT var_argument_types, /* [in] */ BSTR bstr_return_type, /* [in] */ ULONG ul_feature_type, /* [in] */ BSTR bstr_file_name )

/*-----------------------------------------------------------
	Initialize a feature for completion without compiltation
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_name = NULL;
	if (bstr_name != NULL)
	{
		tmp_bstr_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_name));
	}
	EIF_OBJECT tmp_var_arguments = NULL;
	tmp_var_arguments = eif_protect (rt_ce.ccom_ce_variant (var_arguments));
	EIF_OBJECT tmp_var_argument_types = NULL;
	tmp_var_argument_types = eif_protect (rt_ce.ccom_ce_variant (var_argument_types));
	EIF_OBJECT tmp_bstr_return_type = NULL;
	if (bstr_return_type != NULL)
	{
		tmp_bstr_return_type = eif_protect (rt_ce.ccom_ce_bstr (bstr_return_type));
	}
	EIF_INTEGER tmp_ul_feature_type = (EIF_INTEGER)ul_feature_type;
	EIF_OBJECT tmp_bstr_file_name = NULL;
	if (bstr_file_name != NULL)
	{
		tmp_bstr_file_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_file_name));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("initialize_feature", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_bstr_name != NULL) ? eif_access (tmp_bstr_name) : NULL), ((tmp_var_arguments != NULL) ? eif_access (tmp_var_arguments) : NULL), ((tmp_var_argument_types != NULL) ? eif_access (tmp_var_argument_types) : NULL), ((tmp_bstr_return_type != NULL) ? eif_access (tmp_bstr_return_type) : NULL), (EIF_INTEGER)tmp_ul_feature_type, ((tmp_bstr_file_name != NULL) ? eif_access (tmp_bstr_file_name) : NULL));
	if (tmp_bstr_name != NULL)
		eif_wean (tmp_bstr_name);
	if (tmp_var_arguments != NULL)
		eif_wean (tmp_var_arguments);
	if (tmp_var_argument_types != NULL)
		eif_wean (tmp_var_argument_types);
	if (tmp_bstr_return_type != NULL)
		eif_wean (tmp_bstr_return_type);
	if (tmp_bstr_file_name != NULL)
		eif_wean (tmp_bstr_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo )

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
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelCompletionInfo_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	(*pptinfo = pTypeInfo)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::GetTypeInfoCount( unsigned int * pctinfo )

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

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid )

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
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelCompletionInfo_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	return pTypeInfo->GetIDsOfNames (rgszNames, cNames, rgdispid);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr )

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

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelCompletionInfo_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelCompletionInfo*>(this);
	else if (riid == IID_IDispatch)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelCompletionInfo*>(this);
	else if (riid == IID_IEiffelCompletionInfo_)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelCompletionInfo*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif