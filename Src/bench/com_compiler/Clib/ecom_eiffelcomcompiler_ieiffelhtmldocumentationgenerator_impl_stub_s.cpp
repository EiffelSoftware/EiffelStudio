/*-----------------------------------------------------------
Implemented `IEiffelHtmlDocumentationGenerator' Interface.
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_IEiffelHtmlDocumentationGenerator_impl_stub_s.h"
static int return_hr_value;

static const IID IID_IEiffelHtmlDocumentationGenerator_ = {0x86270519,0x790f,0x48cb,{0x88,0x69,0xdb,0x06,0x18,0x4f,0x97,0xb4}};

static const IID LIBID_EiffelComCompiler_ = {0x06b5d7c0,0x2c7d,0x4d1c,{0xa9,0x8b,0x45,0x99,0xbd,0xcd,0xfa,0x58}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_stub::IEiffelHtmlDocumentationGenerator_impl_stub( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
	pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_stub::~IEiffelHtmlDocumentationGenerator_impl_stub()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	if (pTypeInfo)
		pTypeInfo->Release ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_stub::AddExcludedCluster(  /* [in] */ BSTR bstr_full_cluster_name )

/*-----------------------------------------------------------
	Exclude a cluster from being generated.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_full_cluster_name = NULL;
	if (bstr_full_cluster_name != NULL)
	{
		tmp_bstr_full_cluster_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_full_cluster_name));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("add_excluded_cluster", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_bstr_full_cluster_name != NULL) ? eif_access (tmp_bstr_full_cluster_name) : NULL));
	if (tmp_bstr_full_cluster_name != NULL)
		eif_wean (tmp_bstr_full_cluster_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_stub::RemoveExcludedCluster(  /* [in] */ BSTR bstr_full_cluster_name )

/*-----------------------------------------------------------
	Include a cluster to be generated.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_full_cluster_name = NULL;
	if (bstr_full_cluster_name != NULL)
	{
		tmp_bstr_full_cluster_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_full_cluster_name));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remove_excluded_cluster", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_bstr_full_cluster_name != NULL) ? eif_access (tmp_bstr_full_cluster_name) : NULL));
	if (tmp_bstr_full_cluster_name != NULL)
		eif_wean (tmp_bstr_full_cluster_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_stub::StartGeneration(  /* [in] */ BSTR bstr_generation_path )

/*-----------------------------------------------------------
	Generate the HTML documents into path.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_generation_path = NULL;
	if (bstr_generation_path != NULL)
	{
		tmp_bstr_generation_path = eif_protect (rt_ce.ccom_ce_bstr (bstr_generation_path));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("start_generation", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_bstr_generation_path != NULL) ? eif_access (tmp_bstr_generation_path) : NULL));
	if (tmp_bstr_generation_path != NULL)
		eif_wean (tmp_bstr_generation_path);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_stub::AdviseStatusCallback(  /* [in] */ ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents * p_ieiffel_html_documentation_events )

/*-----------------------------------------------------------
	Add a callback interface.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_ieiffel_html_documentation_events = NULL;
	if (p_ieiffel_html_documentation_events != NULL)
	{
		tmp_p_ieiffel_html_documentation_events = eif_protect (grt_ce_ISE.ccom_ce_pointed_interface_235 (p_ieiffel_html_documentation_events));
		p_ieiffel_html_documentation_events->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("advise_status_callback", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_ieiffel_html_documentation_events != NULL) ? eif_access (tmp_p_ieiffel_html_documentation_events) : NULL));
	if (tmp_p_ieiffel_html_documentation_events != NULL)
		eif_wean (tmp_p_ieiffel_html_documentation_events);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_stub::UnadviseStatusCallback(  /* [in] */ ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents * p_ieiffel_html_documentation_events )

/*-----------------------------------------------------------
	Remove a callback interface.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_p_ieiffel_html_documentation_events = NULL;
	if (p_ieiffel_html_documentation_events != NULL)
	{
		tmp_p_ieiffel_html_documentation_events = eif_protect (grt_ce_ISE.ccom_ce_pointed_interface_235 (p_ieiffel_html_documentation_events));
		p_ieiffel_html_documentation_events->AddRef ();
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("unadvise_status_callback", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_p_ieiffel_html_documentation_events != NULL) ? eif_access (tmp_p_ieiffel_html_documentation_events) : NULL));
	if (tmp_p_ieiffel_html_documentation_events != NULL)
		eif_wean (tmp_p_ieiffel_html_documentation_events);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_stub::GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo )

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
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelHtmlDocumentationGenerator_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	(*pptinfo = pTypeInfo)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_stub::GetTypeInfoCount( unsigned int * pctinfo )

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

STDMETHODIMP ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_stub::GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid )

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
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelHtmlDocumentationGenerator_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	return pTypeInfo->GetIDsOfNames (rgszNames, cNames, rgdispid);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_stub::Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr )

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
		
		case 10066:
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
				
				hr = AddExcludedCluster ( arg_0);
				
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

		case 10067:
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
				
				hr = RemoveExcludedCluster ( arg_0);
				
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

		case 10068:
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
				
				hr = StartGeneration ( arg_0);
				
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

		case 10069:
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {9};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 9)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 9);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents * arg_0 = 0;
				IID tmp_iid_0 = {0xb120763e,0xed26,0x4ded,{0xaa,0xfb,0x21,0xfa,0x8b,0x28,0xe8,0x79}};
				if (tmp_value [0]->vt = VT_UNKNOWN)
				{
					IUnknown * tmp_arg_0 = tmp_value [0]->punkVal;
					if (tmp_arg_0 != NULL)
						hr = tmp_arg_0->QueryInterface (tmp_iid_0, (void**)(&arg_0));
				}
				else if (tmp_value [0]->vt = VT_DISPATCH)
				{
					IDispatch * tmp_arg_0 = tmp_value [0]->pdispVal;
					if (tmp_arg_0 != NULL)
						hr = tmp_arg_0->QueryInterface (tmp_iid_0, (void**)(&arg_0));
				}
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					
					return DISP_E_TYPEMISMATCH;
				}
				
				hr = AdviseStatusCallback ( arg_0);
				
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
				if (arg_0 != NULL)
					arg_0->Release ();
				CoTaskMemFree (tmp_value);
			}
			break;

		case 10070:
			{
				if (pDispParams->cArgs != 1)
					return DISP_E_BADPARAMCOUNT;

				tmp_value = (VARIANTARG **)CoTaskMemAlloc (1*sizeof (VARIANTARG*));

				VARTYPE vt_type [] = {9};

				if (cNamedArgs >0)
					for (i = 0; i < cNamedArgs; i++)
					{
						tmp_value [rgdispidNamedArgs [i]] = &(rgvarg [i]);
					}

				for (i = cArgs; i > cNamedArgs; i--)
				{
					tmp_value [cArgs - i] = &(rgvarg [i - 1]);
				}

				
				if (tmp_value [0]->vt != 9)
				{
					hr = VariantChangeType (tmp_value [0], tmp_value [0], VARIANT_NOUSEROVERRIDE, 9);
					if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					*puArgErr = 0;
					return DISP_E_TYPEMISMATCH;
				}
			
				}
				ecom_EiffelComCompiler::IEiffelHtmlDocumentationEvents * arg_0 = 0;
				IID tmp_iid_0 = {0xb120763e,0xed26,0x4ded,{0xaa,0xfb,0x21,0xfa,0x8b,0x28,0xe8,0x79}};
				if (tmp_value [0]->vt = VT_UNKNOWN)
				{
					IUnknown * tmp_arg_0 = tmp_value [0]->punkVal;
					if (tmp_arg_0 != NULL)
						hr = tmp_arg_0->QueryInterface (tmp_iid_0, (void**)(&arg_0));
				}
				else if (tmp_value [0]->vt = VT_DISPATCH)
				{
					IDispatch * tmp_arg_0 = tmp_value [0]->pdispVal;
					if (tmp_arg_0 != NULL)
						hr = tmp_arg_0->QueryInterface (tmp_iid_0, (void**)(&arg_0));
				}
				
				if (FAILED (hr))
				{
					CoTaskMemFree (tmp_value);
					
					return DISP_E_TYPEMISMATCH;
				}
				
				hr = UnadviseStatusCallback ( arg_0);
				
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
				if (arg_0 != NULL)
					arg_0->Release ();
				CoTaskMemFree (tmp_value);
			}
			break;

		default:
			return DISP_E_MEMBERNOTFOUND;
	}
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_stub::Release()

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

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_stub::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator_impl_stub::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator*>(this);
	else if (riid == IID_IDispatch)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator*>(this);
	else if (riid == IID_IEiffelHtmlDocumentationGenerator_)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif