/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#include "ecom_eiffel_compiler_CEiffelCompiler_s.h"
static int return_hr_value;

static const CLSID CLSID_CEiffelCompiler_ = {0x86d23c62,0xe03d,0x4a16,{0x83,0xf6,0x8f,0x79,0xd6,0x28,0x11,0x0e}};

static const IID IID_IEiffelCompiler_ = {0x590282fd,0x2bee,0x44a1,{0x91,0xb3,0x61,0xc9,0x26,0xba,0xd5,0x12}};

static const IID IID_IEiffelCompilerEvents_ = {0xb16070bd,0xdece,0x4e7a,{0x80,0x3c,0xf7,0xa4,0x59,0x24,0xcb,0x88}};

static const IID LIBID_eiffel_compiler_ = {0xa81ca1a9,0x3eef,0x4e47,{0xbe,0xae,0xc1,0x63,0x25,0xee,0xfa,0x3f}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_eiffel_compiler::CEiffelCompiler::CEiffelCompiler( EIF_TYPE_ID tid )
{
	type_id = tid;
	ref_count = 0;
	eiffel_object = eif_create (type_id);
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("make_from_pointer", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), (EIF_POINTER)this);
	p_ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler = new ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler (this, eiffel_object, type_id);
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::CEiffelCompiler::CEiffelCompiler( EIF_OBJECT eif_obj )
{
	ref_count = 0;
	eiffel_object = eif_adopt (eif_obj);
	type_id = eif_type (eiffel_object);
	
	p_ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler = new ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler (this, eiffel_object, type_id);
};
/*----------------------------------------------------------------------------------------------------------------------*/

ecom_eiffel_compiler::CEiffelCompiler::~CEiffelCompiler()
{
	EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("set_item", type_id);

	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_POINTER))eiffel_procedure) (eif_access (eiffel_object), NULL);
	eif_wean (eiffel_object);
	delete p_ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompiler::compile( void )

/*-----------------------------------------------------------
	Compile.
-----------------------------------------------------------*/
{
	ECATCH;
EIF_PROCEDURE eiffel_procedure;
	eiffel_procedure = eif_procedure ("compile", type_id);

	(FUNCTION_CAST ( void, (EIF_REFERENCE))eiffel_procedure) (eif_access (eiffel_object));
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompiler::is_successful(  /* [out, retval] */ VARIANT_BOOL * return_value )

/*-----------------------------------------------------------
	Was last compilation successful?
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("is_successful", type_id);
	EIF_BOOLEAN tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "is_successful", EIF_BOOLEAN);
	*return_value = rt_ec.ccom_ec_boolean (tmp_value);
	
	END_ECATCH;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompiler::compiler_version(  /* [out, retval] */ BSTR * return_value )

/*-----------------------------------------------------------
	Compiler version.
-----------------------------------------------------------*/
{
	ECATCH;

	
	EIF_REFERENCE_FUNCTION eiffel_function = 0;
	eiffel_function = eif_reference_function ("compiler_version", type_id);
	EIF_REFERENCE tmp_value = 0;
	if (eiffel_function != NULL)
		tmp_value = (FUNCTION_CAST (EIF_REFERENCE, (EIF_REFERENCE))eiffel_function) (eif_access (eiffel_object));
	else
		tmp_value = eif_field (eif_access (eiffel_object), "compiler_version", EIF_REFERENCE);
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

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompiler::EnumConnectionPoints( /* [out] */ IEnumConnectionPoints ** ppEnum )

/*-----------------------------------------------------------
	EnumConnectionPoints of IConnectionPointContainer.
-----------------------------------------------------------*/
{
	return E_NOTIMPL;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompiler::FindConnectionPoint( /* [in] */ REFIID riid, /* [out] */ IConnectionPoint ** ppCP )

/*-----------------------------------------------------------
	FindConnectionPoint of IConnectionPointContainer.
-----------------------------------------------------------*/
{
	if (riid == IID_IEiffelCompilerEvents_)
		* ppCP = p_ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler;
	else 
	{
		*ppCP = NULL;
		return CONNECT_E_NOCONNECTION;
	}
	(*ppCP)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::CEiffelCompiler::Release()

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

STDMETHODIMP_(ULONG) ecom_eiffel_compiler::CEiffelCompiler::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	LockModule ();
	return InterlockedIncrement (&ref_count);
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompiler::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface.
-----------------------------------------------------------*/
{
	if (riid == IID_IUnknown)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelCompiler*>(this);
	else if (riid == IID_IProvideClassInfo)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IProvideClassInfo2)
		*ppv = static_cast<IProvideClassInfo2*>(this);
	else if (riid == IID_IEiffelCompiler_)
		*ppv = static_cast<ecom_eiffel_compiler::IEiffelCompiler*>(this);
	else if (riid == IID_IConnectionPointContainer)
		*ppv = static_cast<IConnectionPointContainer*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;

	reinterpret_cast<IUnknown *>(*ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompiler::GetClassInfo( ITypeInfo ** ppti )

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
		hr = ptl->GetTypeInfoOfGuid (CLSID_CEiffelCompiler_, ppti);
		ptl->Release ();
	}
	return hr;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_eiffel_compiler::CEiffelCompiler::GetGUID( DWORD dwKind, GUID * pguid )

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