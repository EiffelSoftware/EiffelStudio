/*-----------------------------------------------------------
Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_CEiffelCompletionInfo_s.h"
static int return_hr_value;

static const CLSID CLSID_CEiffelCompletionInfo_ = {0xbca3e550,0x3e39,0x4a44,{0xa0,0x34,0x38,0xf8,0xb4,0x22,0xd8,0xdf}};

static const IID IID_IEiffelCompletionInfo_ = {0x8630e639,0xedae,0x46b7,{0x88,0x0b,0x27,0xd6,0x8e,0x71,0x84,0xfa}};

static const IID LIBID_EiffelComCompiler_ = {0x06b5d7c0,0x2c7d,0x4d1c,{0xa9,0x8b,0x45,0x99,0xbd,0xcd,0xfa,0x58}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::CEiffelCompletionInfo::CEiffelCompletionInfo( EIF_TYPE_ID tid )
{
	type_id = tid;
	ref_count = 0;
	eiffel_object = eif_create (type_id);
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("make_from_pointer", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)this);
	pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::CEiffelCompletionInfo::CEiffelCompletionInfo( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
	pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::CEiffelCompletionInfo::~CEiffelCompletionInfo()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	if (pTypeInfo)
		pTypeInfo->Release ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::add_local(  /* [in] */ BSTR name, /* [in] */ BSTR type )

/*-----------------------------------------------------------
	Add a local variable used for solving member completion list
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_name = NULL;
	if (name != NULL)
	{
		tmp_name = eif_protect (rt_ce.ccom_ce_bstr (name));
	}
	EIF_OBJECT tmp_type = NULL;
	if (type != NULL)
	{
		tmp_type = eif_protect (rt_ce.ccom_ce_bstr (type));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_local", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_name != NULL) ? eif_access (tmp_name) : NULL), ((tmp_type != NULL) ? eif_access (tmp_type) : NULL));
	if (tmp_name != NULL)
		eif_wean (tmp_name);
	if (tmp_type != NULL)
		eif_wean (tmp_type);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::add_argument(  /* [in] */ BSTR name, /* [in] */ BSTR type )

/*-----------------------------------------------------------
	Add an argument used for solving member completion list
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_name = NULL;
	if (name != NULL)
	{
		tmp_name = eif_protect (rt_ce.ccom_ce_bstr (name));
	}
	EIF_OBJECT tmp_type = NULL;
	if (type != NULL)
	{
		tmp_type = eif_protect (rt_ce.ccom_ce_bstr (type));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_argument", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_name != NULL) ? eif_access (tmp_name) : NULL), ((tmp_type != NULL) ? eif_access (tmp_type) : NULL));
	if (tmp_name != NULL)
		eif_wean (tmp_name);
	if (tmp_type != NULL)
		eif_wean (tmp_type);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::target_features(  /* [in] */ BSTR target, /* [in] */ BSTR feature_name, /* [in] */ BSTR file_name, /* [out] */ VARIANT * return_names, /* [out] */ VARIANT * return_signatures, /* [out] */ VARIANT * return_image_indexes )

/*-----------------------------------------------------------
	Features accessible from target.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_target = NULL;
	if (target != NULL)
	{
		tmp_target = eif_protect (rt_ce.ccom_ce_bstr (target));
	}
	EIF_OBJECT tmp_feature_name = NULL;
	if (feature_name != NULL)
	{
		tmp_feature_name = eif_protect (rt_ce.ccom_ce_bstr (feature_name));
	}
	EIF_OBJECT tmp_file_name = NULL;
	if (file_name != NULL)
	{
		tmp_file_name = eif_protect (rt_ce.ccom_ce_bstr (file_name));
	}
	EIF_OBJECT tmp_return_names = NULL;
	if (return_names != NULL)
	{
		tmp_return_names = eif_protect (grt_ce_ISE.ccom_ce_pointed_record_232 (return_names));
	}
	EIF_OBJECT tmp_return_signatures = NULL;
	if (return_signatures != NULL)
	{
		tmp_return_signatures = eif_protect (grt_ce_ISE.ccom_ce_pointed_record_233 (return_signatures));
	}
	EIF_OBJECT tmp_return_image_indexes = NULL;
	if (return_image_indexes != NULL)
	{
		tmp_return_image_indexes = eif_protect (grt_ce_ISE.ccom_ce_pointed_record_234 (return_image_indexes));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("target_features", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_target != NULL) ? eif_access (tmp_target) : NULL), ((tmp_feature_name != NULL) ? eif_access (tmp_feature_name) : NULL), ((tmp_file_name != NULL) ? eif_access (tmp_file_name) : NULL), ((tmp_return_names != NULL) ? eif_access (tmp_return_names) : NULL), ((tmp_return_signatures != NULL) ? eif_access (tmp_return_signatures) : NULL), ((tmp_return_image_indexes != NULL) ? eif_access (tmp_return_image_indexes) : NULL));
	
	
	
	if (tmp_target != NULL)
		eif_wean (tmp_target);
	if (tmp_feature_name != NULL)
		eif_wean (tmp_feature_name);
	if (tmp_file_name != NULL)
		eif_wean (tmp_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::target_feature(  /* [in] */ BSTR target, /* [in] */ BSTR feature_name, /* [in] */ BSTR file_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * return_value )

/*-----------------------------------------------------------
	Feature information
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_target = NULL;
	if (target != NULL)
	{
		tmp_target = eif_protect (rt_ce.ccom_ce_bstr (target));
	}
	EIF_OBJECT tmp_feature_name = NULL;
	if (feature_name != NULL)
	{
		tmp_feature_name = eif_protect (rt_ce.ccom_ce_bstr (feature_name));
	}
	EIF_OBJECT tmp_file_name = NULL;
	if (file_name != NULL)
	{
		tmp_file_name = eif_protect (rt_ce.ccom_ce_bstr (file_name));
	}
	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("target_feature", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_target != NULL) ? eif_access (tmp_target) : NULL), ((tmp_feature_name != NULL) ? eif_access (tmp_feature_name) : NULL), ((tmp_file_name != NULL) ? eif_access (tmp_file_name) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "target_feature", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_56 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	if (tmp_target != NULL)
		eif_wean (tmp_target);
	if (tmp_feature_name != NULL)
		eif_wean (tmp_feature_name);
	if (tmp_file_name != NULL)
		eif_wean (tmp_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::flush_completion_features(  /* [in] */ BSTR a_file_name )

/*-----------------------------------------------------------
	Flush temporary completion features for a specifi file
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_file_name = NULL;
	if (a_file_name != NULL)
	{
		tmp_a_file_name = eif_protect (rt_ce.ccom_ce_bstr (a_file_name));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("flush_completion_features", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_a_file_name != NULL) ? eif_access (tmp_a_file_name) : NULL));
	if (tmp_a_file_name != NULL)
		eif_wean (tmp_a_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::initialize_feature(  /* [in] */ BSTR a_name, /* [in] */ VARIANT a_arguments, /* [in] */ VARIANT a_argument_types, /* [in] */ BSTR a_return_type, /* [in] */ ULONG a_feature_type, /* [in] */ BSTR a_file_name )

/*-----------------------------------------------------------
	Initialize a feature for completion without compiltation
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_name = NULL;
	if (a_name != NULL)
	{
		tmp_a_name = eif_protect (rt_ce.ccom_ce_bstr (a_name));
	}
	EIF_OBJECT tmp_a_arguments = NULL;
	tmp_a_arguments = eif_protect (rt_ce.ccom_ce_variant (a_arguments));
	EIF_OBJECT tmp_a_argument_types = NULL;
	tmp_a_argument_types = eif_protect (rt_ce.ccom_ce_variant (a_argument_types));
	EIF_OBJECT tmp_a_return_type = NULL;
	if (a_return_type != NULL)
	{
		tmp_a_return_type = eif_protect (rt_ce.ccom_ce_bstr (a_return_type));
	}
	EIF_INTEGER tmp_a_feature_type = (EIF_INTEGER)a_feature_type;
	EIF_OBJECT tmp_a_file_name = NULL;
	if (a_file_name != NULL)
	{
		tmp_a_file_name = eif_protect (rt_ce.ccom_ce_bstr (a_file_name));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("initialize_feature", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_a_name != NULL) ? eif_access (tmp_a_name) : NULL), ((tmp_a_arguments != NULL) ? eif_access (tmp_a_arguments) : NULL), ((tmp_a_argument_types != NULL) ? eif_access (tmp_a_argument_types) : NULL), ((tmp_a_return_type != NULL) ? eif_access (tmp_a_return_type) : NULL), (EIF_INTEGER)tmp_a_feature_type, ((tmp_a_file_name != NULL) ? eif_access (tmp_a_file_name) : NULL));
	if (tmp_a_name != NULL)
		eif_wean (tmp_a_name);
	if (tmp_a_arguments != NULL)
		eif_wean (tmp_a_arguments);
	if (tmp_a_argument_types != NULL)
		eif_wean (tmp_a_argument_types);
	if (tmp_a_return_type != NULL)
		eif_wean (tmp_a_return_type);
	if (tmp_a_file_name != NULL)
		eif_wean (tmp_a_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo )

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

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::GetTypeInfoCount( unsigned int * pctinfo )

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

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid )

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

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr )

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

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::CEiffelCompletionInfo::Release()

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

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::CEiffelCompletionInfo::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface.
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelCompletionInfo*>(this);
	else if (riid == IID_IProvideClassInfo)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IProvideClassInfo2)
		*ppv = static_cast<IProvideClassInfo2*>(this);
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

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::GetClassInfo( ITypeInfo ** ppti )

/*-----------------------------------------------------------
	GetClassInfo
-----------------------------------------------------------*/
{
	if (ppti == NULL)
		return E_POINTER;
	ITypeLib * ptl = NULL;
	HRESULT hr = LoadRegTypeLib (LIBID_EiffelComCompiler_, 1, 0, 0, &ptl);
	if (SUCCEEDED (hr))
	{
		hr = ptl->GetTypeInfoOfGuid (CLSID_CEiffelCompletionInfo_, ppti);
		ptl->Release ();
	}
	return hr;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::GetGUID( DWORD dwKind, GUID * pguid )

/*-----------------------------------------------------------
	GetGUID
-----------------------------------------------------------*/
{
	if ((dwKind != GUIDKIND_DEFAULT_SOURCE_DISP_IID) ||(!pguid))
		return E_INVALIDARG;
	*pguid = IID_NULL;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif