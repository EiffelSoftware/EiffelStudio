/*-----------------------------------------------------------
Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#include "ecom_EiffelComCompiler_CEiffelProject_s.h"
static int return_hr_value;

static const CLSID CLSID_CEiffelProject_ = {0x5b4a07bb,0xba73,0x4d00,{0xb0,0xfe,0x35,0x2f,0xc4,0x12,0x7b,0x9e}};

static const IID IID_IEiffelProject_ = {0x3afea5ea,0x1aed,0x489b,{0x9e,0x8a,0xe3,0x53,0x42,0x58,0x2b,0x2b}};

static const IID LIBID_EiffelComCompiler_ = {0x06b5d7c0,0x2c7d,0x4d1c,{0xa9,0x8b,0x45,0x99,0xbd,0xcd,0xfa,0x58}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_EiffelComCompiler::CEiffelProject::CEiffelProject( EIF_TYPE_ID tid )
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

ecom_EiffelComCompiler::CEiffelProject::CEiffelProject( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
	pTypeInfo = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_EiffelComCompiler::CEiffelProject::~CEiffelProject()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	if (pTypeInfo)
		pTypeInfo->Release ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::RetrieveEiffelProject(  /* [in] */ BSTR bstr_project_file_name )

/*-----------------------------------------------------------
	Retrieve Eiffel Project
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_project_file_name = NULL;
	if (bstr_project_file_name != NULL)
	{
		tmp_bstr_project_file_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_project_file_name));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("retrieve_eiffel_project", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_bstr_project_file_name != NULL) ? eif_access (tmp_bstr_project_file_name) : NULL));
	if (tmp_bstr_project_file_name != NULL)
		eif_wean (tmp_bstr_project_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::CreateEiffelProject(  /* [in] */ BSTR bstr_ace_file_name, /* [in] */ BSTR bstr_project_directory )

/*-----------------------------------------------------------
	Create new Eiffel project from an existing ace file.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_ace_file_name = NULL;
	if (bstr_ace_file_name != NULL)
	{
		tmp_bstr_ace_file_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_ace_file_name));
	}
	EIF_OBJECT tmp_bstr_project_directory = NULL;
	if (bstr_project_directory != NULL)
	{
		tmp_bstr_project_directory = eif_protect (rt_ce.ccom_ce_bstr (bstr_project_directory));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("create_eiffel_project", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_bstr_ace_file_name != NULL) ? eif_access (tmp_bstr_ace_file_name) : NULL), ((tmp_bstr_project_directory != NULL) ? eif_access (tmp_bstr_project_directory) : NULL));
	if (tmp_bstr_ace_file_name != NULL)
		eif_wean (tmp_bstr_ace_file_name);
	if (tmp_bstr_project_directory != NULL)
		eif_wean (tmp_bstr_project_directory);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::GenerateNewEiffelProject(  /* [in] */ BSTR bstr_project_name, /* [in] */ BSTR bstr_ace_file_name, /* [in] */ BSTR bstr_root_class_name, /* [in] */ BSTR bstr_creation_routine, /* [in] */ BSTR bstr_project_directory )

/*-----------------------------------------------------------
	Create new Eiffel project from scratch.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_bstr_project_name = NULL;
	if (bstr_project_name != NULL)
	{
		tmp_bstr_project_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_project_name));
	}
	EIF_OBJECT tmp_bstr_ace_file_name = NULL;
	if (bstr_ace_file_name != NULL)
	{
		tmp_bstr_ace_file_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_ace_file_name));
	}
	EIF_OBJECT tmp_bstr_root_class_name = NULL;
	if (bstr_root_class_name != NULL)
	{
		tmp_bstr_root_class_name = eif_protect (rt_ce.ccom_ce_bstr (bstr_root_class_name));
	}
	EIF_OBJECT tmp_bstr_creation_routine = NULL;
	if (bstr_creation_routine != NULL)
	{
		tmp_bstr_creation_routine = eif_protect (rt_ce.ccom_ce_bstr (bstr_creation_routine));
	}
	EIF_OBJECT tmp_bstr_project_directory = NULL;
	if (bstr_project_directory != NULL)
	{
		tmp_bstr_project_directory = eif_protect (rt_ce.ccom_ce_bstr (bstr_project_directory));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("generate_new_eiffel_project", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_bstr_project_name != NULL) ? eif_access (tmp_bstr_project_name) : NULL), ((tmp_bstr_ace_file_name != NULL) ? eif_access (tmp_bstr_ace_file_name) : NULL), ((tmp_bstr_root_class_name != NULL) ? eif_access (tmp_bstr_root_class_name) : NULL), ((tmp_bstr_creation_routine != NULL) ? eif_access (tmp_bstr_creation_routine) : NULL), ((tmp_bstr_project_directory != NULL) ? eif_access (tmp_bstr_project_directory) : NULL));
	if (tmp_bstr_project_name != NULL)
		eif_wean (tmp_bstr_project_name);
	if (tmp_bstr_ace_file_name != NULL)
		eif_wean (tmp_bstr_ace_file_name);
	if (tmp_bstr_root_class_name != NULL)
		eif_wean (tmp_bstr_root_class_name);
	if (tmp_bstr_creation_routine != NULL)
		eif_wean (tmp_bstr_creation_routine);
	if (tmp_bstr_project_directory != NULL)
		eif_wean (tmp_bstr_project_directory);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::ProjectFileName(  /* [out, retval] */ BSTR * pbstr_project_file_name )

/*-----------------------------------------------------------
	Full path to .epr file.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("project_file_name", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "project_file_name", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pbstr_project_file_name = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pbstr_project_file_name = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::AceFileName(  /* [out, retval] */ BSTR * pbstr_ace_file_name )

/*-----------------------------------------------------------
	Full path to Ace file.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("ace_file_name", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "ace_file_name", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pbstr_ace_file_name = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pbstr_ace_file_name = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::ProjectDirectory(  /* [out, retval] */ BSTR * pbstr_project_directory )

/*-----------------------------------------------------------
	Project directory.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("project_directory", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "project_directory", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pbstr_project_directory = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pbstr_project_directory = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::IsValidProject(  /* [out, retval] */ VARIANT_BOOL * pvb_valid )

/*-----------------------------------------------------------
	Is project valid?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("is_valid_project", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "is_valid_project", EIF_BOOLEAN);
	*pvb_valid = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::LastException(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelException * * pp_ieiffel_exception )

/*-----------------------------------------------------------
	Last exception raised
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("last_exception", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "last_exception", EIF_REFERENCE);
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

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::Compiler(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelCompiler * * pp_ieiffel_compiler )

/*-----------------------------------------------------------
	Compiler.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("compiler", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "compiler", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ieiffel_compiler = grt_ec_ISE.ccom_ec_pointed_interface_9 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ieiffel_compiler = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::IsCompiled(  /* [out, retval] */ VARIANT_BOOL * pvb_compiled )

/*-----------------------------------------------------------
	Has system been compiled?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("is_compiled", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "is_compiled", EIF_BOOLEAN);
	*pvb_compiled = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::ProjectHasUpdated(  /* [out, retval] */ VARIANT_BOOL * pvb_updated )

/*-----------------------------------------------------------
	Has the project updated since last compilation?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("project_has_updated", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "project_has_updated", EIF_BOOLEAN);
	*pvb_updated = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::SystemBrowser(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelSystemBrowser * * pp_eiffel_system_browser )

/*-----------------------------------------------------------
	System Browser.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("system_browser", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "system_browser", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_eiffel_system_browser = grt_ec_ISE.ccom_ec_pointed_interface_14 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_eiffel_system_browser = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::ProjectProperties(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelProjectProperties * * pp_ieiffel_project_properties )

/*-----------------------------------------------------------
	Project Properties.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("project_properties", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "project_properties", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ieiffel_project_properties = grt_ec_ISE.ccom_ec_pointed_interface_17 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ieiffel_project_properties = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::CompletionInformation(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelCompletionInfo * * pp_ieiffel_completion_info )

/*-----------------------------------------------------------
	Completion information
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("completion_information", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "completion_information", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ieiffel_completion_info = grt_ec_ISE.ccom_ec_pointed_interface_20 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ieiffel_completion_info = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::HtmlDocumentationGenerator(  /* [out, retval] */ ecom_EiffelComCompiler::IEiffelHtmlDocumentationGenerator * * pp_ieiffel_html_documentation_generator )

/*-----------------------------------------------------------
	Help documentation generator
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("html_documentation_generator", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "html_documentation_generator", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*pp_ieiffel_html_documentation_generator = grt_ec_ISE.ccom_ec_pointed_interface_23 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*pp_ieiffel_html_documentation_generator = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo )

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
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelProject_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	(*pptinfo = pTypeInfo)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::GetTypeInfoCount( unsigned int * pctinfo )

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

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid )

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
		tmp_hr = pTypeLib->GetTypeInfoOfGuid (IID_IEiffelProject_, &pTypeInfo);
		pTypeLib->Release ();
		if (FAILED(tmp_hr))
			return tmp_hr;
	}
	return pTypeInfo->GetIDsOfNames (rgszNames, cNames, rgdispid);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr )

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

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::CEiffelProject::Release()

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

STDMETHODIMP_(ULONG) ecom_EiffelComCompiler::CEiffelProject::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface.
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelProject*>(this);
	else if (riid == IID_IProvideClassInfo)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IProvideClassInfo2)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IDispatch)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelProject*>(this);
	else if (riid == IID_IEiffelProject_)
		*ppv = static_cast<ecom_EiffelComCompiler::IEiffelProject*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::GetClassInfo( ITypeInfo ** ppti )

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
		hr = ptl->GetTypeInfoOfGuid (CLSID_CEiffelProject_, ppti);
		ptl->Release ();
	}
	return hr;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_EiffelComCompiler::CEiffelProject::GetGUID( DWORD dwKind, GUID * pguid )

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