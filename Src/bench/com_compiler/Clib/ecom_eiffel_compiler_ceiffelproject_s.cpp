/*-----------------------------------------------------------
Eiffel language compiler library. Help file: 
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_CEiffelProject_s.h"
static int return_hr_value;

static const CLSID CLSID_CEiffelProject_ = {0x5b4a07bb,0xba73,0x4d00,{0xb0,0xfe,0x35,0x2f,0xc4,0x12,0x7b,0x9e}};

static const IID IID_IEiffelProject_ = {0x3afea5ea,0x1aed,0x489b,{0x9e,0x8a,0xe3,0x53,0x42,0x58,0x2b,0x2b}};

static const IID LIBID_eiffel_compiler_ = {0x06b5d7c0,0x2c7d,0x4d1c,{0xa9,0x8b,0x45,0x99,0xbd,0xcd,0xfa,0x58}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::CEiffelProject::CEiffelProject( EIF_TYPE_ID tid )
{
	type_id = tid;
	ref_count = 0;
	eiffel_object = eif_create (type_id);
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("make_from_pointer", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)this);
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::CEiffelProject::CEiffelProject( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::CEiffelProject::~CEiffelProject()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::retrieve_eiffel_project(  /* [in] */ BSTR a_project_file_name )

/*-----------------------------------------------------------
	Retrieve Eiffel Project
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_project_file_name = NULL;
	if (a_project_file_name != NULL)
	{
		tmp_a_project_file_name = eif_protect (rt_ce.ccom_ce_bstr (a_project_file_name));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("retrieve_eiffel_project", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_a_project_file_name != NULL) ? eif_access (tmp_a_project_file_name) : NULL));
	if (tmp_a_project_file_name != NULL)
		eif_wean (tmp_a_project_file_name);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::create_eiffel_project(  /* [in] */ BSTR a_ace_file_name, /* [in] */ BSTR a_project_directory_path )

/*-----------------------------------------------------------
	Create new Eiffel project.
-----------------------------------------------------------*/
{
	ECATCH;

	EIF_OBJECT tmp_a_ace_file_name = NULL;
	if (a_ace_file_name != NULL)
	{
		tmp_a_ace_file_name = eif_protect (rt_ce.ccom_ce_bstr (a_ace_file_name));
	}
	EIF_OBJECT tmp_a_project_directory_path = NULL;
	if (a_project_directory_path != NULL)
	{
		tmp_a_project_directory_path = eif_protect (rt_ce.ccom_ce_bstr (a_project_directory_path));
	}
	
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("create_eiffel_project", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_REFERENCE, EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object), ((tmp_a_ace_file_name != NULL) ? eif_access (tmp_a_ace_file_name) : NULL), ((tmp_a_project_directory_path != NULL) ? eif_access (tmp_a_project_directory_path) : NULL));
	if (tmp_a_ace_file_name != NULL)
		eif_wean (tmp_a_ace_file_name);
	if (tmp_a_project_directory_path != NULL)
		eif_wean (tmp_a_project_directory_path);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::project_file_name(  /* [out, retval] */ BSTR * return_value )

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
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::ace_file_name(  /* [out, retval] */ BSTR * return_value )

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
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::project_directory(  /* [out, retval] */ BSTR * return_value )

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
		*return_value = rt_ec.ccom_ec_bstr (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::valid_project(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Is project valid?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("valid_project", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "valid_project", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::last_exception(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelException * * a_result )

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
		*a_result = grt_ec_ISE.ccom_ec_pointed_interface_6 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*a_result = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::compiler(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelCompiler * * return_value )

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
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_9 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::is_compiled(  /* [out, retval] */ VARIANT_BOOL * return_value )

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
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::project_has_updated(  /* [out, retval] */ VARIANT_BOOL * return_value )

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
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::system_browser(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelSystemBrowser * * return_value )

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
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_14 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::project_properties(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelProjectProperties * * return_value )

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
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_17 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::completion_information(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelCompletionInfo * * return_value )

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
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_20 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::html_doc_generator(  /* [out, retval] */ ecom_eiffel_compiler::IEiffelHTMLDocGenerator * * return_value )

/*-----------------------------------------------------------
	Help documentation generator
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("html_doc_generator", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "html_doc_generator", EIF_REFERENCE);
	if (tmp_value != NULL)
	{
		EIF_OBJECT tmp_object = eif_protect (tmp_value);
		*return_value = grt_ec_ISE.ccom_ec_pointed_interface_23 (eif_access (tmp_object));
		eif_wean (tmp_object);
	}
	else
		*return_value = NULL;
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::CEiffelProject::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	UnlockModule ();
	LONG res = InterlockedDecrement (&ref_count);
	if (res  ==  0)
	{
		delete this;
	}
	return res;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::CEiffelProject::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface.
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelProject*>(this);
	else if (riid == IID_IProvideClassInfo)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IProvideClassInfo2)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IEiffelProject_)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelProject*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::GetClassInfo( ITypeInfo ** ppti )

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
		hr = ptl->GetTypeInfoOfGuid (CLSID_CEiffelProject_, ppti);
		ptl->Release ();
	}
	return hr;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelProject::GetGUID( DWORD dwKind, GUID * pguid )

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