/*-----------------------------------------------------------
CEiffelHTMLDocGenerator factory
-----------------------------------------------------------*/

#include "CEiffelHTMLDocGenerator_factory.h"
#ifdef __cplusplus
extern "C" {
#endif

CEiffelHTMLDocGenerator_factory::CEiffelHTMLDocGenerator_factory()
{
	IsInitialized = 0;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) CEiffelHTMLDocGenerator_factory::AddRef()

/*-----------------------------------------------------------
	Increment reference count
-----------------------------------------------------------*/
{
	return 2;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP_(ULONG) CEiffelHTMLDocGenerator_factory::Release()

/*-----------------------------------------------------------
	Decrement reference count
-----------------------------------------------------------*/
{
	return 1;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP CEiffelHTMLDocGenerator_factory::QueryInterface( REFIID riid, void ** ppv )

/*-----------------------------------------------------------
	Query Interface
-----------------------------------------------------------*/
{
	if (riid == IID_IClassFactory)
		*ppv = static_cast<IClassFactory*>(this);
	else if (riid == IID_IUnknown)
		*ppv = static_cast<IClassFactory*>(this);
	else
		return (*ppv = 0), E_NOINTERFACE;
	reinterpret_cast<IUnknown *>(this)->AddRef ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP CEiffelHTMLDocGenerator_factory::CreateInstance( IUnknown *pIunknown, REFIID riid, void **ppv )

/*-----------------------------------------------------------
	Create Instance
-----------------------------------------------------------*/
{
	if (ppv == 0)
		return E_POINTER;
	*ppv = 0;
	if (pIunknown)
		return CLASS_E_NOAGGREGATION;
	ecom_eiffel_compiler::CEiffelHTMLDocGenerator *pUnknown = new ecom_eiffel_compiler::CEiffelHTMLDocGenerator (type_id);
	if (!pUnknown)
		return E_OUTOFMEMORY;
	pUnknown->AddRef ();
	HRESULT tmp_hr = pUnknown->QueryInterface (riid, ppv);
	pUnknown->Release ();
	return tmp_hr;
};
/*----------------------------------------------------------------------------------------------------------------------*/

STDMETHODIMP CEiffelHTMLDocGenerator_factory::LockServer( BOOL tmp_value )

/*-----------------------------------------------------------
	Lock Server
-----------------------------------------------------------*/
{
	if (tmp_value)
		LockModule ();
	else
		UnlockModule ();
	return S_OK;
};
/*----------------------------------------------------------------------------------------------------------------------*/

void CEiffelHTMLDocGenerator_factory::Initialize()

/*-----------------------------------------------------------
	Initialize
-----------------------------------------------------------*/
{
	type_id = eif_type_id ("CEIFFEL_HTMLDOC_GENERATOR_COCLASS_IMP");
	IsInitialized = (type_id >= 0);
};
/*----------------------------------------------------------------------------------------------------------------------*/


#ifdef __cplusplus
}
#endif