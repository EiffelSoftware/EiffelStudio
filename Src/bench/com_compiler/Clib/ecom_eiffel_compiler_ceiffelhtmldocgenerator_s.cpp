/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_CEiffelHTMLDocGenerator_s.h"
static int return_hr_value;

static const CLSID CLSID_CEiffelHTMLDocGenerator_ = {0x6b905ed7,0x196a,0x464c,{0x86,0xc9,0x16,0x06,0x3a,0x31,0x49,0x45}};

static const IID IID_IEiffelHTMLDocGenerator_ = {0x30626121,0x3df8,0x41f2,{0x81,0xb9,0x6f,0x55,0x4a,0x0f,0x7d,0x5c}};

static const IID LIBID_eiffel_compiler_ = {0xa81ca1a9,0x3eef,0x4e47,{0xbe,0xae,0xc1,0x63,0x25,0xee,0xfa,0x3f}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::CEiffelHTMLDocGenerator::CEiffelHTMLDocGenerator( EIF_TYPE_ID tid )
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

ecom_eiffel_compiler::CEiffelHTMLDocGenerator::CEiffelHTMLDocGenerator( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
	pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::CEiffelHTMLDocGenerator::~CEiffelHTMLDocGenerator()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	if (pTypeInfo)
		pTypeInfo->Release ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelHTMLDocGenerator::add_excluded_cluster(  /* [in] */ BSTR cluster_to_exclude )

/*-----------------------------------------------------------
	Add excluded cluster
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_cluster_to_exclude = NULL;
	if (cluster_to_exclude != NULL)
	{
		tmp_cluster_to_exclude = eif_protect (rt_ce.ccom_ce_bstr (cluster_to_exclude));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_excluded_cluster", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_cluster_to_exclude != NULL) ? eif_access (tmp_cluster_to_exclude) : NULL));
	if (tmp_cluster_to_exclude != NULL)
		eif_wean (tmp_cluster_to_exclude);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelHTMLDocGenerator::remove_excluded_cluster(  /* [in] */ BSTR excluded_cluster )

/*-----------------------------------------------------------
	Remove excluded cluster
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_excluded_cluster = NULL;
	if (excluded_cluster != NULL)
	{
		tmp_excluded_cluster = eif_protect (rt_ce.ccom_ce_bstr (excluded_cluster));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remove_excluded_cluster", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_excluded_cluster != NULL) ? eif_access (tmp_excluded_cluster) : NULL));
	if (tmp_excluded_cluster != NULL)
		eif_wean (tmp_excluded_cluster);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelHTMLDocGenerator::is_incompatible(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	is the project incompatible?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("is_incompatible", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "is_incompatible", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelHTMLDocGenerator::is_corrupted(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	is the project corrupted?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("is_corrupted", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "is_corrupted", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelHTMLDocGenerator::last_error(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	the last error
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("last_error", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "last_error", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelHTMLDocGenerator::load_project(  /* [in] */ BSTR project_dir, /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Load a compiled project
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_project_dir = NULL;
	if (project_dir != NULL)
	{
		tmp_project_dir = eif_protect (rt_ce.ccom_ce_bstr (project_dir));
	}
	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("load_project", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object), ((tmp_project_dir != NULL) ? eif_access (tmp_project_dir) : NULL));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "load_project", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	if (tmp_project_dir != NULL)
		eif_wean (tmp_project_dir);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelHTMLDocGenerator::generate(  /* [in] */ BSTR generation_dir )

/*-----------------------------------------------------------
	Generate the documentation.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_generation_dir = NULL;
	if (generation_dir != NULL)
	{
		tmp_generation_dir = eif_protect (rt_ce.ccom_ce_bstr (generation_dir));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("generate", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_generation_dir != NULL) ? eif_access (tmp_generation_dir) : NULL));
	if (tmp_generation_dir != NULL)
		eif_wean (tmp_generation_dir);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelHTMLDocGenerator::GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo )

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
		tmp_hr = LoadRegTypeLib (LIBID_eiffel_compiler_, 0, 0, 0, &pTypeLib);
		if (FAILED(tmp_hr))
			return tmp_hr;
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelHTMLDocGenerator_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	(*pptinfo = pTypeInfo)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelHTMLDocGenerator::GetTypeInfoCount( unsigned int * pctinfo )

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

STDMETHODIMP ecom_eiffel_compiler::CEiffelHTMLDocGenerator::GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid )

/*-----------------------------------------------------------
	IDs of function names 'rgszNames'
-----------------------------------------------------------*/
{
	if (pTypeInfo == 0)
	{
		HRESULT tmp_hr = 0;
		ITypeLib *pTypeLib = 0;
		tmp_hr = LoadRegTypeLib (LIBID_eiffel_compiler_, 0, 0, 0, &pTypeLib);
		if (FAILED(tmp_hr))
			return tmp_hr;
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelHTMLDocGenerator_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	return pTypeInfo->GetIDsOfNames (rgszNames, cNames, rgdispid);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelHTMLDocGenerator::Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr )

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
		
		case 36:
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
				
				hr = add_excluded_cluster ( arg_0);
				
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

		case 37:
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
				
				hr = remove_excluded_cluster ( arg_0);
				
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

		case 1610743810:
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				VARIANT_BOOL result = 0;
				
				hr = is_incompatible (&result);
				
				if (FAILED (hr))
				{
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
					pVarResult->vt = 11;
					pVarResult->boolVal = result;
				}
					
			}
			break;

		case 1610743811:
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				VARIANT_BOOL result = 0;
				
				hr = is_corrupted (&result);
				
				if (FAILED (hr))
				{
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
					pVarResult->vt = 11;
					pVarResult->boolVal = result;
				}
					
			}
			break;

		case 38:
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
				VARIANT_BOOL result = 0;
				
				hr = load_project ( arg_0,&result);
				
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
					pVarResult->vt = 11;
					pVarResult->boolVal = result;
				}
					
				CoTaskMemFree (tmp_value);
			}
			break;

		case 40:
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
				
				hr = generate ( arg_0);
				
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

		case 1610743812:
			if (wFlags & (DISPATCH_PROPERTYGET | DISPATCH_METHOD))
			{
				if (pDispParams->cArgs != 0)
					return DISP_E_BADPARAMCOUNT;

				BSTR result = 0;
				
				hr = last_error (&result);
				
				if (FAILED (hr))
				{
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
					pVarResult->vt = 8;
					pVarResult->bstrVal = result;
				}
					
			}
			break;

		default:
			return DISP_E_MEMBERNOTFOUND;
	}
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::CEiffelHTMLDocGenerator::Release()

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

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::CEiffelHTMLDocGenerator::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelHTMLDocGenerator::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface.
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelHTMLDocGenerator*>(this);
	else if (riid == IID_IProvideClassInfo)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IProvideClassInfo2)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IDispatch)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelHTMLDocGenerator*>(this);
	else if (riid == IID_IEiffelHTMLDocGenerator_)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelHTMLDocGenerator*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelHTMLDocGenerator::GetClassInfo( ITypeInfo ** ppti )

/*-----------------------------------------------------------
	GetClassInfo
-----------------------------------------------------------*/
{
	if (ppti == NULL)
		return E_POINTER;
	ITypeLib * ptl = NULL;
	HRESULT hr = LoadRegTypeLib (LIBID_eiffel_compiler_, 1, 0, 0, &ptl);
	if (SUCCEEDED (hr))
	{
		hr = ptl->GetTypeInfoOfGuid (CLSID_CEiffelHTMLDocGenerator_, ppti);
		ptl->Release ();
	}
	return hr;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelHTMLDocGenerator::GetGUID( DWORD dwKind, GUID * pguid )

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