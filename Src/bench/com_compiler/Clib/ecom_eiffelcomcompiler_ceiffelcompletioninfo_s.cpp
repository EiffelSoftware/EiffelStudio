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

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::AddLocal(  /* [in] */ BSTR bstr_name, /* [in] */ BSTR bstr_type )

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

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::AddArgument(  /* [in] */ BSTR bstr_name, /* [in] */ BSTR bstr_type )

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

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::TargetFeatures(  /* [in] */ BSTR bstr_target, /* [in] */ BSTR bstr_feature_name, /* [in] */ BSTR bstr_file_name, /* [out] */ VARIANT * pvar_names, /* [out] */ VARIANT * pvar_signatures, /* [out] */ VARIANT * pvar_image_indexes )

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

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::TargetFeature(  /* [in] */ BSTR bstr_target, /* [in] */ BSTR bstr_feature_name, /* [in] */ BSTR bstr_file_name, /* [out, retval] */ ecom_EiffelComCompiler::IEiffelFeatureDescriptor * * pp_ieiffel_feature_descriptor )

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

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::FlushCompletionFeatures(  /* [in] */ BSTR bstr_file_name )

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

STDMETHODIMP ecom_EiffelComCompiler::CEiffelCompletionInfo::InitializeFeature(  /* [in] */ BSTR bstr_name, /* [in] */ VARIANT var_arguments, /* [in] */ VARIANT var_argument_types, /* [in] */ BSTR bstr_return_type, /* [in] */ ULONG ul_feature_type, /* [in] */ BSTR bstr_file_name )

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
		
		case 10060:
			{
				if (pDispParams->cArgs != 2)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (2*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8, 8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				if (tmp_value [1]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [1], tmp_value [1], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 1;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_1 = (BSTR)tmp_value [1]->bstrVal;
				
				hr = AddLocal ( arg_0, arg_1);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 10061:
			{
				if (pDispParams->cArgs != 2)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (2*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8, 8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				if (tmp_value [1]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [1], tmp_value [1], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 1;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_1 = (BSTR)tmp_value [1]->bstrVal;
				
				hr = AddArgument ( arg_0, arg_1);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 10062:
			{
				if (pDispParams->cArgs != 6)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (6*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8, 8, 8, 16396, 16396, 16396};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				if (tmp_value [1]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [1], tmp_value [1], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 1;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_1 = (BSTR)tmp_value [1]->bstrVal;
				
				if (tmp_value [2]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [2], tmp_value [2], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 2;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_2 = (BSTR)tmp_value [2]->bstrVal;
				
				if (tmp_value [3]->vt != 16396)
				{
					hr = VariantChangeType (tmp_value [3], tmp_value [3], VARIANT_NOUSEROVERRIDE, 16396);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 3;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				VARIANT * arg_3 = (VARIANT *)tmp_value [3]->pvarVal;
				
				if (tmp_value [4]->vt != 16396)
				{
					hr = VariantChangeType (tmp_value [4], tmp_value [4], VARIANT_NOUSEROVERRIDE, 16396);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 4;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				VARIANT * arg_4 = (VARIANT *)tmp_value [4]->pvarVal;
				
				if (tmp_value [5]->vt != 16396)
				{
					hr = VariantChangeType (tmp_value [5], tmp_value [5], VARIANT_NOUSEROVERRIDE, 16396);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 5;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				VARIANT * arg_5 = (VARIANT *)tmp_value [5]->pvarVal;
				
				hr = TargetFeatures ( arg_0, arg_1, arg_2, arg_3, arg_4, arg_5);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 10063:
			{
				if (pDispParams->cArgs != 3)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (3*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8, 8, 8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				if (tmp_value [1]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [1], tmp_value [1], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 1;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_1 = (BSTR)tmp_value [1]->bstrVal;
				
				if (tmp_value [2]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [2], tmp_value [2], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 2;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_2 = (BSTR)tmp_value [2]->bstrVal;
				ecom_EiffelComCompiler::IEiffelFeatureDescriptor * result = 0;
				
				hr = TargetFeature ( arg_0, arg_1, arg_2,&result);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				if (pVarResult != NULL)
				{
					VariantClear (pVarResult);
					pVarResult->vt = 9;
					pVarResult->pdispVal = result;
				}
					
				CoTaskMemFree (tmp_value);
			}
			break;

		case 10064:
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				hr = FlushCompletionFeatures ( arg_0);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

		case 10065:
			{
				if (pDispParams->cArgs != 6)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (6*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {8, 16396, 16396, 8, 19, 8};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_0 = (BSTR)tmp_value [0]->bstrVal;
				
				if (tmp_value [1]->vt != 16396)
				{
					hr = VariantChangeType (tmp_value [1], tmp_value [1], VARIANT_NOUSEROVERRIDE, 16396);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 1;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				VARIANT arg_1;
				memcpy (&arg_1, &(tmp_value [1]->pvarVal), sizeof (VARIANT));
				
				if (tmp_value [2]->vt != 16396)
				{
					hr = VariantChangeType (tmp_value [2], tmp_value [2], VARIANT_NOUSEROVERRIDE, 16396);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 2;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				VARIANT arg_2;
				memcpy (&arg_2, &(tmp_value [2]->pvarVal), sizeof (VARIANT));
				
				if (tmp_value [3]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [3], tmp_value [3], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 3;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_3 = (BSTR)tmp_value [3]->bstrVal;
				
				if (tmp_value [4]->vt != 19)
				{
					hr = VariantChangeType (tmp_value [4], tmp_value [4], VARIANT_NOUSEROVERRIDE, 19);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 4;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				ULONG arg_4 = (ULONG)tmp_value [4]->ulVal;
				
				if (tmp_value [5]->vt != 8)
				{
					hr = VariantChangeType (tmp_value [5], tmp_value [5], VARIANT_NOUSEROVERRIDE, 8);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 5;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				BSTR arg_5 = (BSTR)tmp_value [5]->bstrVal;
				
				hr = InitializeFeature ( arg_0, arg_1, arg_2, arg_3, arg_4, arg_5);
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					if (pExcepInfo != NULL)
					{
						WCHAR * wide_string = 0;
						wide_string = ccom_create_from_string (eename(HRESULT_CODE (hr) - 1024));
						BSTR b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrDescription = b_string;
						wide_string = ccom_create_from_string ("ISE");
						b_string = SysAllocString (wide_string);
						free (wide_string);
						pExcepInfo->bstrSource = b_string;
						pExcepInfo->wCode = HRESULT_CODE (hr);
					}
					return DISP_E_EXCEPTION;
				}
				CoTaskMemFree (tmp_value);
			}
			break;

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