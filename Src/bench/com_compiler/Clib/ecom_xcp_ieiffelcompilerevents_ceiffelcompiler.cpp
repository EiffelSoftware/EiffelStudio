/*-----------------------------------------------------------
To deal with identity relationship of IConnectionPoin,
IEiffelCompilerEvents-specific inner class.
-----------------------------------------------------------*/

#include "ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler.h"
static const IID IID_IEiffelCompilerEvents_ = {0xb16070bd,0xdece,0x4e7a,{0x80,0x3c,0xf7,0xa4,0x59,0x24,0xcb,0x88}};

#ifdef __cplusplus
extern "C" {
#endif

ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler::ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler( ecom_eiffel_compiler::CEiffelCompiler * an_outer, EIF_OBJECT an_object, EIF_TYPE_ID a_type_id )
{
	outer = an_outer;
	eiffel_object = an_object;
	type_id = a_type_id;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	QueryInterface
-----------------------------------------------------------*/
{
	if ((riid == IID_IUnknown) || (riid == IID_IConnectionPoint))
		*ppv = static_cast<IConnectionPoint *> (this);
	else
	{
		*ppv = NULL;
		return E_NOINTERFACE;
	}
	((IUnknown *)* ppv)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler::AddRef( void )

/*-----------------------------------------------------------
	AddRef
-----------------------------------------------------------*/
{
	return outer->AddRef ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler::Release( void )

/*-----------------------------------------------------------
	Release
-----------------------------------------------------------*/
{
	return outer->Release ();
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler::GetConnectionInterface( IID * piid )

/*-----------------------------------------------------------
	GetConnectionInterface
-----------------------------------------------------------*/
{
	if (piid == NULL)
		return E_POINTER;
	*piid = IID_IEiffelCompilerEvents_;
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler::GetConnectionPointContainer( IConnectionPointContainer ** ppcpc )

/*-----------------------------------------------------------
	GetConnectionPointContainer
-----------------------------------------------------------*/
{
	if (ppcpc == NULL)
		return E_POINTER;
	(*ppcpc = outer)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler::Advise( IUnknown * pUnk, DWORD * pdwCookie )

/*-----------------------------------------------------------
	Advise
-----------------------------------------------------------*/
{
	if ((pUnk == NULL) || (pdwCookie == NULL))
		return E_POINTER;
	*pdwCookie = 0;
	ecom_eiffel_compiler::IEiffelCompilerEvents * pIEiffelCompilerEvents;
	HRESULT hr = pUnk->QueryInterface (IID_IEiffelCompilerEvents_, (void**)&pIEiffelCompilerEvents);
	if (hr == E_NOINTERFACE)
		hr = CONNECT_E_NOCONNECTION;
	if (SUCCEEDED(hr))
	{
		EIF_INTEGER_FUNCTION eiffel_function = 0;
		eiffel_function = eif_integer_function ("add_ieiffel_compiler_events_call_back", type_id);
		EIF_OBJECT tmp_object = eif_protect (rt_ce.ccom_ce_pointed_interface (pIEiffelCompilerEvents, "IEIFFEL_COMPILER_EVENTS_IMPL_PROXY"));
		*pdwCookie = (FUNCTION_CAST (EIF_INTEGER, (EIF_REFERENCE, EIF_REFERENCE))eiffel_function)(eif_access (eiffel_object), eif_wean (tmp_object));
	}
	return hr;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler::Unadvise( DWORD dwCookie )

/*-----------------------------------------------------------
	Unadvise
-----------------------------------------------------------*/
{
	EIF_BOOLEAN_FUNCTION eiffel_function = 0;
	eiffel_function = eif_boolean_function ("has_ieiffel_compiler_events_call_back", type_id);
	EIF_BOOLEAN a_bool = (FUNCTION_CAST (EIF_BOOLEAN, (EIF_REFERENCE, EIF_INTEGER))eiffel_function)(eif_access (eiffel_object), (EIF_INTEGER)dwCookie);
	if (a_bool != EIF_TRUE)
		return CONNECT_E_NOCONNECTION;
	EIF_PROCEDURE eiffel_procedure = 0;
	eiffel_procedure = eif_procedure ("remove_ieiffel_compiler_events_call_back", type_id);
	(FUNCTION_CAST (void, (EIF_REFERENCE, EIF_INTEGER))eiffel_function)(eif_access (eiffel_object), (EIF_INTEGER)dwCookie);
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler::EnumConnections( IEnumConnections ** ppEnum )

/*-----------------------------------------------------------
	EnumConnections
-----------------------------------------------------------*/
{
	return E_NOTIMPL;
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif