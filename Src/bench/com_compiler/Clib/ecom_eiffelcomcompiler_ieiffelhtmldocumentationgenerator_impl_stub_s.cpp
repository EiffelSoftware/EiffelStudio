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